import {useEffect, useState} from 'react'

import './App.css'
import {GraphCanvas} from "reagraph";

import {ApolloClient, gql, InMemoryCache} from '@apollo/client';

const layoutTypes = ['forceDirected2d' , 'forceDirected3d' , 'circular2d' , 'treeTd2d' , 'treeTd3d' , 'treeLr2d' , 'treeLr3d' , 'radialOut2d' , 'radialOut3d' , 'nooverlap' , 'forceatlas2'];


const client = new ApolloClient({
  uri: '/graphql',
  cache: new InMemoryCache(),
});

function getNodeStyle(node) {
  switch (node.label) {
    case 'person':
      return '#0066ff';
    case 'application':
      return '#ff00c8';
    case 'server':
      return '#0066ff';
    case 'sm account':
      return '#00ffe1';
    case 'network':
      return '#00ffe1';
    case 'extremism':
      return '#e37f71';
    case 'vulnerability':
      return '#e81d02';
    case 'activity':
      return '#eeb34a'
    case 'workstation':
      return '#eeb34a'
    case 'site':
      return '#4faa80';
    case 'department':
      return '#a0e7c6';
    default:
      return '#A2A2A2';
  }
}

function formNameFromProperties(node) {
  const nameProp = node.properties?.find((p) => p.key === 'name')
  if (nameProp) {
    return node.label + ':' + nameProp.value;
  } else {
    return node.label;
  }
}

function withNodeStyle(node) {
  return Object.assign({}, {
    ...node,
    id: node.id + '',
    data: {label: node.label},
    fill: getNodeStyle(node),
    label: formNameFromProperties(node)
  })
}

function withEdgeId(edge) {
  return Object.assign({},
    {...edge,
      source: edge.source + '',
      target: edge.target + '',
      id: edge.source + '-' + edge.target,
    edgeLabelPosition: 'below'});
}

const graphQuery = gql`{
      query:graphs(isQueryGraph: true) {
          id,
          name,
          queryGraph
      },
      knowledge:graphs(isQueryGraph: false) {
        id,
        name,
        queryGraph
    }
  }`;

function similarityMeasureQuery(kg, qg, similarityTreshold, queryFocusLabel) {
  return gql`{
      pings:similarityMeasure(
          knowledgeGraph: ${kg},
          similarityTreshold: ${similarityTreshold},
          queryGraph: ${qg},
          queryFocusLabel: ${JSON.stringify(queryFocusLabel)}) {
          name,
          similarity,
          nodes {
              id,
              label,
              properties {
                  key,
                  value
                  weight
              }
          }
          edges {
              source,
              target,
              label
          }

      }
  }`;
}

function neighborHoodSimilarityQuery(kg, qg, similarityTreshold, queryFocusLabel) {
  return gql`{
      pings:neighborhoodSimilarity(
          knowledgeGraph: ${kg},
          similarityTreshold: ${similarityTreshold},
          queryGraph: ${qg},
          queryFocusLabel: ${JSON.stringify(queryFocusLabel)}) {
          name,
          similarity,
          nodes {
              id,
              label,
              properties {
                  key,
                  value
                  weight
              }
          }
          edges {
              source,
              target,
              label
          }

      }
  }`;
}

function App() {

  const [queryGraph, setQueryGraph] = useState({});
  const [qge, setQge] = useState([]);
  const [qgn, setQgn] = useState([]);
  const [knowledgeGraph, setKnowledgeGraph] = useState({});
  const [kge, setKge] = useState([]);
  const [kgn, setKgn] = useState([]);

  const [selected, setSelected] = useState('qg');
  const [filter, setFilter] = useState('');
  const [includeNodes, setIncludeNodes] = useState([]);
  const [matches, setMatches] = useState([]);
  const [selectedMatch, setSelectedMatch] = useState(undefined);
  const [mge, setMge] = useState([]);
  const [mgn, setMgn] = useState([]);
  const [similarityMeasureMode, setSimilarityMeasureMode] = useState(true)
  const [queryFocusLabel, setQueryFocusLabel] = useState('');

  const [similarityTreshold, setSimilarityTreshold] = useState(1.0);

  const [combineAllMatches, setCombineAllMatches] = useState(false);

  const [knowledgeGraphs, setKnowledgeGraphs] = useState([]);
  const [queryGraphs, setQueryGraphs] = useState([]);

  const [selectedQg, setSelectedQg] = useState(26);
  const [selectedKg, setSelectedKg] = useState(40);

  const [inspectedItem, setInspectedItem] = useState(undefined);

  const [layoutType, setLayoutType] = useState('forceDirected2d');

  const [useClustering, setUseClustering] = useState(false);

  // init

  useEffect(() => {
    client.query({
      query: graphQuery
    }).then((response) => {
      setQueryGraphs(response.data.query);
      setKnowledgeGraphs(response.data.knowledge);
      // setSelectedQg(response.data.query[0].id);
      // setSelectedKg(response.data.query[0].id);
    }).catch((error) => {
      console.error(error);
    });

  }, [])

  // or neighborhood similarity
  useEffect(() => {
    client.query({
      query: similarityMeasureMode ?
        similarityMeasureQuery(selectedKg, selectedQg, similarityTreshold, queryFocusLabel) :
        neighborHoodSimilarityQuery(selectedKg, selectedQg, similarityTreshold, queryFocusLabel)
    }).then((response) => {
      console.log('start load')
      const qg = response.data.pings[0];
      setQueryGraph(qg);
      setQgn(qg.nodes.map(withNodeStyle))
      setQge(qg.edges.map(withEdgeId))

      const kg = response.data.pings[1];
      setKnowledgeGraph(kg);
      setKgn(kg.nodes.map(withNodeStyle))
      setKge(kg.edges.map(withEdgeId))

      const mgs = response.data.pings?.slice(2).sort((a, b) => b.similarity- a.similarity);
      setMatches(mgs);

      console.log('loaded');
      // console.log(response.data)
    }).catch((error) => {
      console.error(error);
    })
  }, [similarityTreshold, similarityMeasureMode, queryFocusLabel, selectedQg, selectedKg])

  useEffect(() => {
    if (kge.length > 0 || kgn.length > 0) {
      console.log('kg', kgn, kge)
    }
  }, [kgn, kge])

  useEffect(() => {
    if (qge.length > 0 || qgn.length > 0) {
      console.log('qg', qgn, qge)
    }
  }, [qgn, qge])

  function selectOption(e) {
    setCombineAllMatches(false);
    const newSelected = e.target.value;
    setSelectedMatch(newSelected);
    setSelected(newSelected);

    console.log(newSelected, matches, matches.find((m) => m.name === newSelected))
    setMgn(matches.find((m) => m.name === newSelected).nodes.map(withNodeStyle))
    setMge(matches.find((m) => m.name === newSelected).edges.map(withEdgeId))
  }

  function updateTreshold(e) {
    console.log("baa")
    setSimilarityTreshold(Number(e.target.value));
  }

  function toggleCombineMatches(e) {
    const newValue = !combineAllMatches;
    setCombineAllMatches(newValue);
    console.log(newValue)
    if (newValue === true) {
      console.log("combining")
      const newMgn = matches.reduce((acc, val) => acc.concat(val.nodes.map(withNodeStyle)), []);
      const newMge = matches.reduce((acc, val) => acc.concat(val.edges.map(withEdgeId)), []);
      console.log(newMgn, newMge)
      setMgn(newMgn)
      setMge(newMge)
    }
  }

  function updateFilter(e) {
    e.preventDefault();
    setFilter(e.target.value);
    setIncludeNodes(e.target.value.split(" "));
    if (e.target.value.trim() === '') setIncludeNodes([]);
  }

  function updateQfLabel(e) {
    e.preventDefault();
    setQueryFocusLabel(e.target.value.trim());
  }

  function selectQg(e) {
    e.preventDefault();
    setSelectedQg(e.target.value);
  }

  function selectKg(e) {
    e.preventDefault();
    setSelectedKg(e.target.value);
  }

  return (
    <div className="App">
      <div>

        <div style={{position: 'absolute', top: '0px', left: '0px', zIndex: 10000, display: 'flex'}}>
          <div>
            <label htmlFor="qg">Choose Qg</label>
            <select name="qg"
                    id="qg"
                    onChange={(e) => selectQg(e) }
                    value={selectedQg}>
              <option value="none">select.. ({queryGraphs ? queryGraphs.length : 0})</option>
              {queryGraphs && queryGraphs.length > 0 &&
              queryGraphs.map((queryGraph) => <option key={queryGraph.id}
                                             value={queryGraph.id}>{queryGraph.id} : {queryGraph.name}</option>)}
            </select>
          <button onClick={(e) => setSelected('qg')}>queryGraph {queryGraph?.name}</button>
          <input type="text"
                 value={queryFocusLabel}
                 onChange={(e) => updateQfLabel(e)}
                 placeholder="focus label"/>
          </div>
          <div>
          <label htmlFor="kg">Choose Kg</label>
          <select name="kg"
                  id="kg"
                  onChange={(e) => selectKg(e) }
                  value={selectedKg}>
            <option value="none">select.. ({knowledgeGraphs ? knowledgeGraphs.length : 0})</option>
            {knowledgeGraphs && knowledgeGraphs.length > 0 &&
            knowledgeGraphs.map((knowledgeGraph) => <option key={knowledgeGraph.id}
                                                    value={knowledgeGraph.id}>{knowledgeGraph.id} : {knowledgeGraph.name}</option>)}
          </select>
          <button onClick={(e) => setSelected('kg')}>knowledgeGraph {knowledgeGraph?.name}</button>
          </div>
            <div style={{ position: 'relative', right: '0px', marginLeft: 'auto'}}>
            <span style={{'color': 'black'}}>min.score &nbsp;
          <input type="number"
                 value={similarityTreshold}
                 onChange={(e) => updateTreshold(e)}/>
              </span>
          <div >

          <label htmlFor="matches">Choose match</label>
          <select name="matches"
                  id="matches"
                  onChange={(e) => selectOption(e) }
                  value={selectedMatch}>
            <option value="none">select.. ({matches ? matches.length : 0})</option>
            {matches && matches.length > 0 &&
            matches.map((match) => <option key={match.name}
                                           value={match.name}>{match.name} nodes: {match.nodes.length} score: {match.similarity} </option>)}
          </select>
            <select name="layoutType"
                    id="layoutType"
                    onChange={(e) => setLayoutType(e.target.value)}
                    value={layoutType}>
              {layoutTypes.map((l) => <option key={l} value={l}>{l}</option>)}
            </select>
            <input type="text"
                   value={filter}
                   onChange={(e) => updateFilter(e)}
                   placeholder="filter nodes"/>
            <button onClick={toggleCombineMatches}>Combine matches {combineAllMatches}</button>
            <button onClick={(e) => setSimilarityMeasureMode(!similarityMeasureMode)}>
              {similarityMeasureMode ? "querymode: Similarity" : "querymode: Neighborhood"}
            </button>
            <button onClick={(e) => setUseClustering(!useClustering)}>
              Clustering: {useClustering.toString()}
            </button>

          </div>
              {inspectedItem &&
              <div style={{'color': 'black'}}>
                {inspectedItem.id}:{inspectedItem.label}
              </div>
              }
          </div>
        </div>



        {qgn && selected === 'qg' && qgn.length > 0 && qge?.length > 0 &&
        <div>
          <h4>{queryGraph?.name}</h4>
          <GraphCanvas className="querygraph" style={{position: 'relative'}}
                       nodes={qgn}
                       edges={qge}
                       labelType="all"
                       layoutType={layoutType}
                       draggable={true}
                       clusterAttribute={useClustering ? "label" : ""}
                       minNodeSize={3}
                       defaultNodeSize={4}
                       maxNodeSize={8}
          onNodePointerOver={(n) => setInspectedItem(n)}
          onNodePointerOut={(n) => setInspectedItem(undefined)}
                       onEdgePointerOver={(e) => setInspectedItem(e)}
                       onEdgePointerOut={(e) => setInspectedItem(undefined)}/>
        </div>}

        {kgn && selected === 'kg' && kgn.length > 0 && kge?.length > 0 &&
        <div>
          <h4>{knowledgeGraph?.name}</h4>
          <GraphCanvas styleName={[{position: 'relative'}, {height: '500px'}]}
                       labelType="all"
                       edgeInterpolation="linear"
                       layoutType={layoutType}
                       nodes={includeNodes.length > 0 && kgn.length > 0 ?
                         kgn.filter(node => includeNodes.find(n => node.label.split(":")[0].startsWith(n))?.length > 0)
                       :kgn}
                       edges={kge}
                       sizingType="centrality"
                       clusterAttribute={useClustering ? "label" : ""}
                       minNodeSize={3}
                       defaultNodeSize={4}
                       maxNodeSize={8}
                       draggable={true}
                       onNodePointerOver={(n) => setInspectedItem(n)}
                       onNodePointerOut={(n) => setInspectedItem(undefined)}
          onEdgePointerOver={(e) => setInspectedItem(e)}
          onEdgePointerOut={(e) => setInspectedItem(undefined)}/>
        </div>}

        {selectedMatch && selected !== 'kg' && selected !== 'qg' &&
        <div>
          <GraphCanvas styleName={[{position: 'relative'}, {height: '500px'}]}
                       labelType="all"
                       layoutType={layoutType}
                       nodes={includeNodes.length > 0 && mgn.length > 0 ?
                       mgn.filter(node => includeNodes.find(n => node.label.split(":")[0].startsWith(n))?.length > 0)
                       :mgn}
                       edges={mge}
                       sizingType="centrality"
                       minNodeSize={3}
                       defaultNodeSize={4}
                       maxNodeSize={8}
                       clusterAttribute={useClustering ? "label" : ""}
                       draggable={true}/>
        </div>}


      </div>
    </div>
  )
}

export default App

