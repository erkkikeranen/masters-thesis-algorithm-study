-- This data is created with help of some of the CSVs available from http://www.cnrl.colostate.edu/Projects/RAD/pings.html
-- With respect to (c) CNRL 2020. See project README for more information

delete from public.edge cascade
where source in (select id from public.node where graph_id in (3,4,5,6))
or target in (select id from public.node where graph_id in (3,4,5,6));

delete from public.property cascade
where node_id in (select id from public.node where graph_id in (3,4,5,6));

delete from public.node cascade where graph_id in (3,4,5,6);

delete from public.graph cascade where id = 3;
delete from public.graph cascade where id = 4;
delete from public.graph cascade where id = 5;
delete from public.graph cascade where id = 6;

-- query graph
INSERT INTO public.graph (id, name, query_graph) VALUES (4, 'person knows person U87 who knows person who has facebook', true);

INSERT INTO public.node (id, label, graph_id) VALUES (50, 'person', 4);
INSERT INTO public.node (id, label, graph_id) VALUES (51, 'person', 4);
INSERT INTO public.node (id, label, graph_id) VALUES (52, 'person', 4);
INSERT INTO public.node (id, label, graph_id) VALUES(54, 'sm account', 4);

INSERT INTO public.edge (source, target, label) VALUES (50, 51, 'knows');
INSERT INTO public.edge (source, target, label) VALUES (51, 52, 'knows');
INSERT INTO public.edge (source, target, label) VALUES (52, 54, 'has');

INSERT into public.property(node_id, key, value) VALUES (51, 'name', 'U87');
INSERT into public.property(node_id, key, value) VALUES (54, 'name', 'Facebook');


-- query graph example from investigative graph search using graph databases

INSERT INTO public.graph (id, name, query_graph) VALUES (5, 'article example 2019 muramadulige et al p. 63', true);
INSERT INTO public.node (id, label, graph_id) VALUES (70, 'person', 5);
-- TODO: wait for scoring
-- INSERT into public.property(node_id, key, value) VALUES (70, 'name', 'U57');
INSERT INTO public.node (id, label, graph_id) VALUES(71, 'sm account', 5);
-- TODO: wait for scoring
-- INSERT into public.property(node_id, key, value) VALUES (71, 'name', 'Facebook');
INSERT INTO public.node (id, label, graph_id) VALUES(72, 'extremism', 5);

INSERT INTO public.node (id, label, graph_id) VALUES(73, 'activity', 5);
INSERT into public.property(node_id, key, value, weight) VALUES (73, 'name', 'Received Training', 1.5);
INSERT INTO public.node (id, label, graph_id) VALUES(74, 'activity', 5);
INSERT into public.property(node_id, key, value, weight) VALUES (74, 'name', 'Purchase Weapons', 1.5);
INSERT INTO public.node (id, label, graph_id) VALUES(75, 'activity', 5);
INSERT into public.property(node_id, key, value, weight) VALUES (75, 'name', 'Suspicious Travel', 1.2);
INSERT INTO public.node (id, label, graph_id) VALUES(76, 'activity', 5);
INSERT into public.property(node_id, key, value, weight) VALUES (76, 'name', 'Referred Radicalized Materials', 1.1);
INSERT INTO public.node (id, label, graph_id) VALUES(77, 'activity', 5);
INSERT into public.property(node_id, key, value, weight) VALUES (77, 'name', 'Detonated a bomb', 2.0);
INSERT INTO public.node (id, label, graph_id) VALUES(78, 'activity', 5);
INSERT into public.property(node_id, key, value, weight) VALUES (78, 'name', 'Carried an attack', 2.0);

INSERT INTO public.edge (source, target, label) VALUES (70, 71, 'has');
INSERT INTO public.edge (source, target, label) VALUES (71, 72, 'posts');
INSERT INTO public.edge (source, target, label) VALUES (70, 73, 'exhibits');
INSERT INTO public.edge (source, target, label) VALUES (70, 74, 'exhibits');
INSERT INTO public.edge (source, target, label) VALUES (70, 75, 'exhibits');
INSERT INTO public.edge (source, target, label) VALUES (70, 76, 'exhibits');
INSERT INTO public.edge (source, target, label) VALUES (70, 77, 'exhibits');
INSERT INTO public.edge (source, target, label) VALUES (70, 78, 'exhibits');


-- suspicious person like above NO social media
-- todo: does not work, querygraph value goes negative
INSERT INTO public.graph (id, name, query_graph) VALUES (6, 'suspicious person without social media connection', true);
INSERT INTO public.node (id, label, graph_id) VALUES (80, 'person', 6);
-- TODO: wait for scoring
-- INSERT into public.property(node_id, key, value) VALUES (70, 'name', 'U57');
INSERT INTO public.node (id, label, graph_id) VALUES(81, 'sm account', 6);
INSERT INTO public.node (id, label, graph_id) VALUES(89, 'sm account', 6);
-- prove negative scoring
INSERT into public.property(node_id, key, value, weight) VALUES (81, 'name', 'Facebook', -2.0);
INSERT into public.property(node_id, key, value, weight) VALUES (89, 'name', 'Twitter', -2.0);

INSERT INTO public.node (id, label, graph_id) VALUES(82, 'extremism', 6);

INSERT INTO public.node (id, label, graph_id) VALUES(83, 'activity', 6);
INSERT into public.property(node_id, key, value, weight) VALUES (83, 'name', 'Received Training', 1.5);
INSERT INTO public.node (id, label, graph_id) VALUES(84, 'activity', 6);
INSERT into public.property(node_id, key, value, weight) VALUES (84, 'name', 'Purchase Weapons', 1.5);
INSERT INTO public.node (id, label, graph_id) VALUES(85, 'activity', 6);
INSERT into public.property(node_id, key, value, weight) VALUES (85, 'name', 'Suspicious Travel', 1.2);
INSERT INTO public.node (id, label, graph_id) VALUES(86, 'activity', 6);
INSERT into public.property(node_id, key, value, weight) VALUES (86, 'name', 'Referred Radicalized Materials', 1.1);
INSERT INTO public.node (id, label, graph_id) VALUES(87, 'activity', 6);
INSERT into public.property(node_id, key, value, weight) VALUES (87, 'name', 'Detonated a bomb', 2.0);
INSERT INTO public.node (id, label, graph_id) VALUES(88, 'activity', 6);
INSERT into public.property(node_id, key, value, weight) VALUES (88, 'name', 'Carried an attack', 2.0);

INSERT INTO public.edge (source, target, label) VALUES (80, 81, 'has');
INSERT INTO public.edge (source, target, label) VALUES (80, 89, 'has');
INSERT INTO public.edge (source, target, label) VALUES (81, 82, 'posts');
INSERT INTO public.edge (source, target, label) VALUES (80, 83, 'exhibits');
INSERT INTO public.edge (source, target, label) VALUES (80, 84, 'exhibits');
INSERT INTO public.edge (source, target, label) VALUES (80, 85, 'exhibits');
INSERT INTO public.edge (source, target, label) VALUES (80, 86, 'exhibits');
INSERT INTO public.edge (source, target, label) VALUES (80, 87, 'exhibits');
INSERT INTO public.edge (source, target, label) VALUES (80, 88, 'exhibits');

-- pings 100 person radicalization set

INSERT INTO graph(id, name) VALUES (3, 'pings_100_radicalization');

INSERT INTO node(id, label, graph_id) VALUES
(100,'person',3),
(101,'person',3),
(102,'person',3),
(103,'person',3),
(104,'person',3),
(105,'person',3),
(106,'person',3),
(107,'person',3),
(108,'person',3),
(109,'person',3),
(110,'person',3),
(111,'person',3),
(112,'person',3),
(113,'person',3),
(114,'person',3),
(115,'person',3),
(116,'person',3),
(117,'person',3),
(118,'person',3),
(119,'person',3),
(120,'person',3),
(121,'person',3),
(122,'person',3),
(123,'person',3),
(124,'person',3),
(125,'person',3),
(126,'person',3),
(127,'person',3),
(128,'person',3),
(129,'person',3),
(130,'person',3),
(131,'person',3),
(132,'person',3),
(133,'person',3),
(134,'person',3),
(135,'person',3),
(136,'person',3),
(137,'person',3),
(138,'person',3),
(139,'person',3),
(140,'person',3),
(141,'person',3),
(142,'person',3),
(143,'person',3),
(144,'person',3),
(145,'person',3),
(146,'person',3),
(147,'person',3),
(148,'person',3),
(149,'person',3),
(150,'person',3),
(151,'person',3),
(152,'person',3),
(153,'person',3),
(154,'person',3),
(155,'person',3),
(156,'person',3),
(157,'person',3),
(158,'person',3),
(159,'person',3),
(160,'person',3),
(161,'person',3),
(162,'person',3),
(163,'person',3),
(164,'person',3),
(165,'person',3),
(166,'person',3),
(167,'person',3),
(168,'person',3),
(169,'person',3),
(170,'person',3),
(171,'person',3),
(172,'person',3),
(173,'person',3),
(174,'person',3),
(175,'person',3),
(176,'person',3),
(177,'person',3),
(178,'person',3),
(179,'person',3),
(180,'person',3),
(181,'person',3),
(182,'person',3),
(183,'person',3),
(184,'person',3),
(185,'person',3),
(186,'person',3),
(187,'person',3),
(188,'person',3),
(189,'person',3),
(190,'person',3),
(191,'person',3),
(192,'person',3),
(193,'person',3),
(194,'person',3),
(195,'person',3),
(196,'person',3),
(197,'person',3),
(198,'person',3),
(199,'person',3);

INSERT INTO property(node_id, key, value) VALUES
(100,'name','U0'),
(101,'name','U1'),
(102,'name','U2'),
(103,'name','U3'),
(104,'name','U4'),
(105,'name','U5'),
(106,'name','U6'),
(107,'name','U7'),
(108,'name','U8'),
(109,'name','U9'),
(110,'name','U10'),
(111,'name','U11'),
(112,'name','U12'),
(113,'name','U13'),
(114,'name','U14'),
(115,'name','U15'),
(116,'name','U16'),
(117,'name','U17'),
(118,'name','U18'),
(119,'name','U19'),
(120,'name','U20'),
(121,'name','U21'),
(122,'name','U22'),
(123,'name','U23'),
(124,'name','U24'),
(125,'name','U25'),
(126,'name','U26'),
(127,'name','U27'),
(128,'name','U28'),
(129,'name','U29'),
(130,'name','U30'),
(131,'name','U31'),
(132,'name','U32'),
(133,'name','U33'),
(134,'name','U34'),
(135,'name','U35'),
(136,'name','U36'),
(137,'name','U37'),
(138,'name','U38'),
(139,'name','U39'),
(140,'name','U40'),
(141,'name','U41'),
(142,'name','U42'),
(143,'name','U43'),
(144,'name','U44'),
(145,'name','U45'),
(146,'name','U46'),
(147,'name','U47'),
(148,'name','U48'),
(149,'name','U49'),
(150,'name','U50'),
(151,'name','U51'),
(152,'name','U52'),
(153,'name','U53'),
(154,'name','U54'),
(155,'name','U55'),
(156,'name','U56'),
(157,'name','U57'),
(158,'name','U58'),
(159,'name','U59'),
(160,'name','U60'),
(161,'name','U61'),
(162,'name','U62'),
(163,'name','U63'),
(164,'name','U64'),
(165,'name','U65'),
(166,'name','U66'),
(167,'name','U67'),
(168,'name','U68'),
(169,'name','U69'),
(170,'name','U70'),
(171,'name','U71'),
(172,'name','U72'),
(173,'name','U73'),
(174,'name','U74'),
(175,'name','U75'),
(176,'name','U76'),
(177,'name','U77'),
(178,'name','U78'),
(179,'name','U79'),
(180,'name','U80'),
(181,'name','U81'),
(182,'name','U82'),
(183,'name','U83'),
(184,'name','U84'),
(185,'name','U85'),
(186,'name','U86'),
(187,'name','U87'),
(188,'name','U88'),
(189,'name','U89'),
(190,'name','U90'),
(191,'name','U91'),
(192,'name','U92'),
(193,'name','U93'),
(194,'name','U94'),
(195,'name','U95'),
(196,'name','U96'),
(197,'name','U97'),
(198,'name','U98'),
(199,'name','U99');

-- UserID1,UserID2,Timestamp
INSERT INTO edge(source, target, label) VALUES

(131,199,'knows'),             -- ,1519093849 Timestamp
(162,198,'knows'),             -- ,1496540303 Timestamp
(172,195,'knows'),             -- ,1362954772 Timestamp
(151,185,'knows'),             -- ,1277176762 Timestamp
(118,113,'knows'),             -- ,1425058960 Timestamp
(123,171,'knows'),             -- ,1314229525 Timestamp
(119,121,'knows'),             -- ,1330426762 Timestamp
(129,177,'knows'),             -- ,1291706079 Timestamp
(163,138,'knows'),             -- ,1541039162 Timestamp
(184,150,'knows'),             -- ,1312741095 Timestamp
(128,101,'knows'),             -- ,1275354568 Timestamp
(111,100,'knows'),             -- ,1291086158 Timestamp
(163,137,'knows'),             -- ,1437790068 Timestamp
(132,178,'knows'),             -- ,1390579029 Timestamp
(117,187,'knows'),             -- ,1349133235 Timestamp
(189,164,'knows'),             -- ,1317037324 Timestamp
(183,100,'knows'),             -- ,1304378636 Timestamp
(138,161,'knows'),             -- ,1445403621 Timestamp
(115,106,'knows'),             -- ,1326183542 Timestamp
(184,139,'knows'),             -- ,1510199586 Timestamp
(116,172,'knows'),             -- ,1341170713 Timestamp
(192,121,'knows'),             -- ,1392374508 Timestamp
(115,126,'knows'),             -- ,1472144513 Timestamp
(183,174,'knows'),             -- ,1456392139 Timestamp
(137,180,'knows'),             -- ,1553194573 Timestamp
(145,111,'knows'),             -- ,1546901913 Timestamp
(115,111,'knows'),             -- ,1482369784 Timestamp
(195,199,'knows'),             -- ,1511739144 Timestamp
(192,114,'knows'),             -- ,1507308944 Timestamp
(169,135,'knows'),             -- ,1324906277 Timestamp
(112,180,'knows'),             -- ,1329915492 Timestamp
(172,199,'knows'),             -- ,1338094914 Timestamp
(184,115,'knows'),             -- ,1458464573 Timestamp
(189,132,'knows'),             -- ,1415278602 Timestamp
(118,169,'knows'),             -- ,1276740786 Timestamp
(162,141,'knows'),             -- ,1433043574 Timestamp
(174,151,'knows'),             -- ,1505079384 Timestamp
(197,158,'knows'),             -- ,1541106949 Timestamp
(156,163,'knows'),             -- ,1518385524 Timestamp
(140,177,'knows'),             -- ,1453647682 Timestamp
(116,178,'knows'),             -- ,1285098835 Timestamp
(164,122,'knows'),             -- ,1496010348 Timestamp
(144,187,'knows'),             -- ,1554399934 Timestamp
(158,140,'knows'),             -- ,1493567282 Timestamp
(197,124,'knows'),             -- ,1555971247 Timestamp
(119,199,'knows'),             -- ,1275632537 Timestamp
(118,103,'knows'),             -- ,1336991965 Timestamp
(140,182,'knows'),             -- ,1444867822 Timestamp
(126,182,'knows'),             -- ,1461455350 Timestamp
(175,164,'knows'),             -- ,1311324532 Timestamp
(192,119,'knows'),             -- ,1328373204 Timestamp
(170,131,'knows'),             -- ,1392522274 Timestamp
(118,142,'knows'),             -- ,1535660320 Timestamp
(114,163,'knows'),             -- ,1273439433 Timestamp
(185,160,'knows'),             -- ,1345665297 Timestamp
(151,197,'knows'),             -- ,1276986838 Timestamp
(130,102,'knows'),             -- ,1411874187 Timestamp
(127,199,'knows'),             -- ,1452729684 Timestamp
(161,128,'knows'),             -- ,1500463949 Timestamp
(116,113,'knows'),             -- ,1533278300 Timestamp
(161,112,'knows'),             -- ,1318330670 Timestamp
(114,158,'knows'),             -- ,1530523373 Timestamp
(165,172,'knows'),             -- ,1329617081 Timestamp
(160,181,'knows'),             -- ,1517765939 Timestamp
(144,143,'knows'),             -- ,1485451226 Timestamp
(141,183,'knows'),             -- ,1292546220 Timestamp
(186,132,'knows'),             -- ,1284216095 Timestamp
(167,182,'knows'),             -- ,1444002259 Timestamp
(160,168,'knows'),             -- ,1318465394 Timestamp
(155,197,'knows'),             -- ,1331841226 Timestamp
(115,194,'knows'),             -- ,1436202074 Timestamp
(115,155,'knows'),             -- ,1474091703 Timestamp
(152,117,'knows'),             -- ,1434036682 Timestamp
(160,194,'knows'),             -- ,1541505496 Timestamp
(117,191,'knows'),             -- ,1307433164 Timestamp
(112,115,'knows'),             -- ,1411597989 Timestamp
(126,118,'knows'),             -- ,1359724876 Timestamp
(167,184,'knows'),             -- ,1324487287 Timestamp
(119,199,'knows'),             -- ,1325643799 Timestamp
(129,171,'knows'),             -- ,1415701273 Timestamp
(188,166,'knows'),             -- ,1275547549 Timestamp
(116,195,'knows'),             -- ,1477217515 Timestamp
(163,177,'knows'),             -- ,1347780545 Timestamp
(184,134,'knows'),             -- ,1476205133 Timestamp
(129,156,'knows'),             -- ,1450805813 Timestamp
(193,132,'knows'),             -- ,1480014013 Timestamp
(138,150,'knows'),             -- ,1518557820 Timestamp
(116,166,'knows'),             -- ,1385554005 Timestamp
(165,167,'knows'),             -- ,1437971705 Timestamp
(114,102,'knows'),             -- ,1294929841 Timestamp
(144,141,'knows'),             -- ,1387690905 Timestamp
(116,193,'knows'),             -- ,1377988926 Timestamp
(196,157,'knows'),             -- ,1500695705 Timestamp
(178,128,'knows'),             -- ,1510045338 Timestamp
(143,140,'knows'),             -- ,1340986268 Timestamp
(133,137,'knows'),             -- ,1301881474 Timestamp
(181,166,'knows'),             -- ,1536869332 Timestamp
(190,160,'knows'),             -- ,1541835000 Timestamp
(132,102,'knows'),             -- ,1316679588 Timestamp
(158,136,'knows'),             -- ,1312802984 Timestamp
(167,108,'knows'),             -- ,1286470960 Timestamp
(172,198,'knows'),             -- ,1530434606 Timestamp
(121,171,'knows'),             -- ,1371250625 Timestamp
(182,124,'knows'),             -- ,1301427583 Timestamp
(132,146,'knows'),             -- ,1404249073 Timestamp
(123,131,'knows'),             -- ,1536226398 Timestamp
(189,124,'knows'),             -- ,1546638470 Timestamp
(117,183,'knows'),             -- ,1415939846 Timestamp
(171,145,'knows'),             -- ,1282283830 Timestamp
(113,132,'knows'),             -- ,1512789443 Timestamp
(189,149,'knows'),             -- ,1351285087 Timestamp
(150,103,'knows'),             -- ,1334192969 Timestamp
(120,146,'knows'),             -- ,1409925445 Timestamp
(163,139,'knows'),             -- ,1524174707 Timestamp
(122,178,'knows'),             -- ,1415411608 Timestamp
(146,190,'knows'),             -- ,1273580850 Timestamp
(121,109,'knows'),             -- ,1347592154 Timestamp
(162,174,'knows'),             -- ,1455092301 Timestamp
(156,135,'knows'),             -- ,1275644330 Timestamp
(177,193,'knows'),             -- ,1351510732 Timestamp
(122,127,'knows'),             -- ,1276158553 Timestamp
(127,146,'knows'),             -- ,1470056675 Timestamp
(137,100,'knows'),             -- ,1370885168 Timestamp
(117,118,'knows'),             -- ,1452628723 Timestamp
(192,162,'knows'),             -- ,1332106177 Timestamp
(176,163,'knows'),             -- ,1297959011 Timestamp
(182,101,'knows'),             -- ,1335017602 Timestamp
(155,150,'knows'),             -- ,1460180637 Timestamp
(110,171,'knows'),             -- ,1394327118 Timestamp
(128,123,'knows'),             -- ,1289912798 Timestamp
(195,163,'knows'),             -- ,1494852853 Timestamp
(112,139,'knows'),             -- ,1287346164 Timestamp
(188,153,'knows'),             -- ,1509292964 Timestamp
(168,101,'knows'),             -- ,1295806825 Timestamp
(161,117,'knows'),             -- ,1502027681 Timestamp
(142,164,'knows'),             -- ,1326471375 Timestamp
(123,175,'knows'),             -- ,1326298605 Timestamp
(192,138,'knows'),             -- ,1536314601 Timestamp
(130,171,'knows'),             -- ,1402072763 Timestamp
(187,126,'knows'),             -- ,1301098686 Timestamp
(132,190,'knows'),             -- ,1515636859 Timestamp
(192,181,'knows'),             -- ,1532861042 Timestamp
(171,163,'knows'),             -- ,1517022414 Timestamp
(140,129,'knows'),             -- ,1504790167 Timestamp
(139,125,'knows'),             -- ,1509793724 Timestamp
(165,102,'knows'),             -- ,1473472509 Timestamp
(162,142,'knows'),             -- ,1545225635 Timestamp
(155,190,'knows'),             -- ,1308102292 Timestamp
(117,105,'knows'),             -- ,1530293699 Timestamp
(192,103,'knows');             -- ,1377774598 Timestamp

-- sm account

-- ID,Type

INSERT into public.node (id, label, graph_id) VALUES
(2000,'sm account', 3),   ---Facebook
(2001,'sm account', 3),   ---Facebook
(2002,'sm account', 3),   ---Twitter
(2003,'sm account', 3),   ---Facebook
(2004,'sm account', 3),   ---Facebook
(2005,'sm account', 3),   ---Twitter
(2006,'sm account', 3),   ---Twitter
(2007,'sm account', 3),   ---Facebook
(2008,'sm account', 3),   ---Twitter
(2009,'sm account', 3),   ---Facebook
(2010,'sm account', 3),   ---Twitter
(2011,'sm account', 3),   ---Facebook
(2012,'sm account', 3),   ---Twitter
(2013,'sm account', 3),   ---Facebook
(2014,'sm account', 3),   ---Twitter
(2015,'sm account', 3),   ---Twitter
(2016,'sm account', 3),   ---Facebook
(2017,'sm account', 3),   ---Twitter
(2018,'sm account', 3),   ---Facebook
(2019,'sm account', 3),   ---Twitter
(2020,'sm account', 3),   ---Twitter
(2021,'sm account', 3),   ---Twitter
(2022,'sm account', 3),   ---Facebook
(2023,'sm account', 3),   ---Twitter
(2024,'sm account', 3),   ---Facebook
(2025,'sm account', 3),   ---Twitter
(2026,'sm account', 3),   ---Twitter
(2027,'sm account', 3),   ---Facebook
(2028,'sm account', 3),   ---Facebook
(2029,'sm account', 3),   ---Twitter
(2030,'sm account', 3),   ---Facebook
(2031,'sm account', 3),   ---Twitter
(2032,'sm account', 3),   ---Twitter
(2033,'sm account', 3),   ---Facebook
(2034,'sm account', 3),   ---Facebook
(2035,'sm account', 3),   ---Facebook
(2036,'sm account', 3),   ---Facebook
(2037,'sm account', 3),   ---Twitter
(2038,'sm account', 3),   ---Facebook
(2039,'sm account', 3),   ---Twitter
(2040,'sm account', 3),   ---Facebook
(2041,'sm account', 3),   ---Twitter
(2042,'sm account', 3),   ---Facebook
(2043,'sm account', 3),   ---Twitter
(2044,'sm account', 3),   ---Facebook
(2045,'sm account', 3),   ---Twitter
(2046,'sm account', 3),   ---Facebook
(2047,'sm account', 3),   ---Twitter
(2048,'sm account', 3),   ---Facebook
(2049,'sm account', 3),   ---Twitter
(2050,'sm account', 3),   ---Facebook
(2051,'sm account', 3),   ---Twitter
(2052,'sm account', 3),   ---Facebook
(2053,'sm account', 3),   ---Facebook
(2054,'sm account', 3),   ---Facebook
(2055,'sm account', 3),   ---Facebook
(2056,'sm account', 3),   ---Facebook
(2057,'sm account', 3),   ---Twitter
(2058,'sm account', 3),   ---Facebook
(2059,'sm account', 3),   ---Twitter
(2060,'sm account', 3),   ---Facebook
(2061,'sm account', 3),   ---Facebook
(2062,'sm account', 3),   ---Facebook
(2063,'sm account', 3),   ---Twitter
(2064,'sm account', 3),   ---Twitter
(2065,'sm account', 3),   ---Facebook
(2066,'sm account', 3),   ---Facebook
(2067,'sm account', 3),   ---Twitter
(2068,'sm account', 3),   ---Facebook
(2069,'sm account', 3),   ---Twitter
(2070,'sm account', 3),   ---Facebook
(2071,'sm account', 3),   ---Twitter
(2072,'sm account', 3),   ---Twitter
(2073,'sm account', 3),   ---Facebook
(2074,'sm account', 3),   ---Twitter
(2075,'sm account', 3),   ---Twitter
(2076,'sm account', 3),   ---Facebook
(2077,'sm account', 3),   ---Facebook
(2078,'sm account', 3),   ---Twitter
(2079,'sm account', 3),   ---Facebook
(2080,'sm account', 3),   ---Twitter
(2081,'sm account', 3),   ---Facebook
(2082,'sm account', 3),   ---Twitter
(2083,'sm account', 3),   ---Facebook
(2084,'sm account', 3),   ---Twitter
(2085,'sm account', 3),   ---Twitter
(2086,'sm account', 3),   ---Facebook
(2087,'sm account', 3),   ---Twitter
(2088,'sm account', 3),   ---Facebook
(2089,'sm account', 3),   ---Facebook
(2090,'sm account', 3),   ---Facebook
(2091,'sm account', 3),   ---Twitter
(2092,'sm account', 3),   ---Facebook
(2093,'sm account', 3),   ---Twitter
(2094,'sm account', 3),   ---Facebook
(2095,'sm account', 3),   ---Twitter
(2096,'sm account', 3),   ---Twitter
(2097,'sm account', 3),   ---Twitter
(2098,'sm account', 3),   ---Twitter
(2099,'sm account', 3),   ---Twitter
(2100,'sm account', 3),   ---Facebook
(2101,'sm account', 3),   ---Facebook
(2102,'sm account', 3),   ---Facebook
(2103,'sm account', 3),   ---Twitter
(2104,'sm account', 3),   ---Facebook
(2105,'sm account', 3),   ---Twitter
(2106,'sm account', 3),   ---Twitter
(2107,'sm account', 3),   ---Facebook
(2108,'sm account', 3),   ---Twitter
(2109,'sm account', 3),   ---Facebook
(2110,'sm account', 3),   ---Twitter
(2111,'sm account', 3),   ---Facebook
(2112,'sm account', 3),   ---Facebook
(2113,'sm account', 3),   ---Twitter
(2114,'sm account', 3),   ---Facebook
(2115,'sm account', 3),   ---Twitter
(2116,'sm account', 3),   ---Facebook
(2117,'sm account', 3),   ---Twitter
(2118,'sm account', 3),   ---Twitter
(2119,'sm account', 3),   ---Twitter
(2120,'sm account', 3),   ---Twitter
(2121,'sm account', 3),   ---Facebook
(2122,'sm account', 3),   ---Twitter
(2123,'sm account', 3),   ---Facebook
(2124,'sm account', 3),   ---Facebook
(2125,'sm account', 3),   ---Twitter
(2126,'sm account', 3),   ---Twitter
(2127,'sm account', 3),   ---Facebook
(2128,'sm account', 3),   ---Twitter
(2129,'sm account', 3),   ---Twitter
(2130,'sm account', 3),   ---Facebook
(2131,'sm account', 3),   ---Twitter
(2132,'sm account', 3),   ---Facebook
(2133,'sm account', 3),   ---Twitter
(2134,'sm account', 3),   ---Facebook
(2135,'sm account', 3),   ---Twitter
(2136,'sm account', 3),   ---Facebook
(2137,'sm account', 3),   ---Facebook
(2138,'sm account', 3),   ---Twitter
(2139,'sm account', 3),   ---Facebook
(2140,'sm account', 3);   ---Twitter

INSERT INTO property (node_id, key, value) VALUES
(2000,'name', 'Facebook'),
(2001,'name', 'Facebook'),
(2002,'name', 'Twitter'),
(2003,'name', 'Facebook'),
(2004,'name', 'Facebook'),
(2005,'name', 'Twitter'),
(2006,'name', 'Twitter'),
(2007,'name', 'Facebook'),
(2008,'name', 'Twitter'),
(2009,'name', 'Facebook'),
(2010,'name', 'Twitter'),
(2011,'name', 'Facebook'),
(2012,'name', 'Twitter'),
(2013,'name', 'Facebook'),
(2014,'name', 'Twitter'),
(2015,'name', 'Twitter'),
(2016,'name', 'Facebook'),
(2017,'name', 'Twitter'),
(2018,'name', 'Facebook'),
(2019,'name', 'Twitter'),
(2020,'name', 'Twitter'),
(2021,'name', 'Twitter'),
(2022,'name', 'Facebook'),
(2023,'name', 'Twitter'),
(2024,'name', 'Facebook'),
(2025,'name', 'Twitter'),
(2026,'name', 'Twitter'),
(2027,'name', 'Facebook'),
(2028,'name', 'Facebook'),
(2029,'name', 'Twitter'),
(2030,'name', 'Facebook'),
(2031,'name', 'Twitter'),
(2032,'name', 'Twitter'),
(2033,'name', 'Facebook'),
(2034,'name', 'Facebook'),
(2035,'name', 'Facebook'),
(2036,'name', 'Facebook'),
(2037,'name', 'Twitter'),
(2038,'name', 'Facebook'),
(2039,'name', 'Twitter'),
(2040,'name', 'Facebook'),
(2041,'name', 'Twitter'),
(2042,'name', 'Facebook'),
(2043,'name', 'Twitter'),
(2044,'name', 'Facebook'),
(2045,'name', 'Twitter'),
(2046,'name', 'Facebook'),
(2047,'name', 'Twitter'),
(2048,'name', 'Facebook'),
(2049,'name', 'Twitter'),
(2050,'name', 'Facebook'),
(2051,'name', 'Twitter'),
(2052,'name', 'Facebook'),
(2053,'name', 'Facebook'),
(2054,'name', 'Facebook'),
(2055,'name', 'Facebook'),
(2056,'name', 'Facebook'),
(2057,'name', 'Twitter'),
(2058,'name', 'Facebook'),
(2059,'name', 'Twitter'),
(2060,'name', 'Facebook'),
(2061,'name', 'Facebook'),
(2062,'name', 'Facebook'),
(2063,'name', 'Twitter'),
(2064,'name', 'Twitter'),
(2065,'name', 'Facebook'),
(2066,'name', 'Facebook'),
(2067,'name', 'Twitter'),
(2068,'name', 'Facebook'),
(2069,'name', 'Twitter'),
(2070,'name', 'Facebook'),
(2071,'name', 'Twitter'),
(2072,'name', 'Twitter'),
(2073,'name', 'Facebook'),
(2074,'name', 'Twitter'),
(2075,'name', 'Twitter'),
(2076,'name', 'Facebook'),
(2077,'name', 'Facebook'),
(2078,'name', 'Twitter'),
(2079,'name', 'Facebook'),
(2080,'name', 'Twitter'),
(2081,'name', 'Facebook'),
(2082,'name', 'Twitter'),
(2083,'name', 'Facebook'),
(2084,'name', 'Twitter'),
(2085,'name', 'Twitter'),
(2086,'name', 'Facebook'),
(2087,'name', 'Twitter'),
(2088,'name', 'Facebook'),
(2089,'name', 'Facebook'),
(2090,'name', 'Facebook'),
(2091,'name', 'Twitter'),
(2092,'name', 'Facebook'),
(2093,'name', 'Twitter'),
(2094,'name', 'Facebook'),
(2095,'name', 'Twitter'),
(2096,'name', 'Twitter'),
(2097,'name', 'Twitter'),
(2098,'name', 'Twitter'),
(2099,'name', 'Twitter'),
(2100,'name', 'Facebook'),
(2101,'name', 'Facebook'),
(2102,'name', 'Facebook'),
(2103,'name', 'Twitter'),
(2104,'name', 'Facebook'),
(2105,'name', 'Twitter'),
(2106,'name', 'Twitter'),
(2107,'name', 'Facebook'),
(2108,'name', 'Twitter'),
(2109,'name', 'Facebook'),
(2110,'name', 'Twitter'),
(2111,'name', 'Facebook'),
(2112,'name', 'Facebook'),
(2113,'name', 'Twitter'),
(2114,'name', 'Facebook'),
(2115,'name', 'Twitter'),
(2116,'name', 'Facebook'),
(2117,'name', 'Twitter'),
(2118,'name', 'Twitter'),
(2119,'name', 'Twitter'),
(2120,'name', 'Twitter'),
(2121,'name', 'Facebook'),
(2122,'name', 'Twitter'),
(2123,'name', 'Facebook'),
(2124,'name', 'Facebook'),
(2125,'name', 'Twitter'),
(2126,'name', 'Twitter'),
(2127,'name', 'Facebook'),
(2128,'name', 'Twitter'),
(2129,'name', 'Twitter'),
(2130,'name', 'Facebook'),
(2131,'name', 'Twitter'),
(2132,'name', 'Facebook'),
(2133,'name', 'Twitter'),
(2134,'name', 'Facebook'),
(2135,'name', 'Twitter'),
(2136,'name', 'Facebook'),
(2137,'name', 'Facebook'),
(2138,'name', 'Twitter'),
(2139,'name', 'Facebook'),
(2140,'name', 'Twitter');

-- UserID,SMID
INSERT INTO public.edge (source, target, label) VALUES
(100,2000,'has'),
(101,2001,'has'),
(102,2002,'has'),
(103,2003,'has'),
(104,2004,'has'),
(104,2005,'has'),
(105,2006,'has'),
(106,2007,'has'),
(106,2008,'has'),
(107,2009,'has'),
(107,2010,'has'),
(108,2011,'has'),
(108,2012,'has'),
(109,2013,'has'),
(110,2014,'has'),
(111,2015,'has'),
(112,2016,'has'),
(112,2017,'has'),
(113,2018,'has'),
(113,2019,'has'),
(114,2020,'has'),
(115,2021,'has'),
(116,2022,'has'),
(116,2023,'has'),
(117,2024,'has'),
(117,2025,'has'),
(118,2026,'has'),
(119,2027,'has'),
(120,2028,'has'),
(120,2029,'has'),
(121,2030,'has'),
(121,2031,'has'),
(122,2032,'has'),
(123,2033,'has'),
(124,2034,'has'),
(125,2035,'has'),
(126,2036,'has'),
(127,2037,'has'),
(128,2038,'has'),
(129,2039,'has'),
(130,2040,'has'),
(130,2041,'has'),
(131,2042,'has'),
(131,2043,'has'),
(132,2044,'has'),
(132,2045,'has'),
(133,2046,'has'),
(133,2047,'has'),
(134,2048,'has'),
(134,2049,'has'),
(135,2050,'has'),
(135,2051,'has'),
(136,2052,'has'),
(137,2053,'has'),
(138,2054,'has'),
(139,2055,'has'),
(140,2056,'has'),
(140,2057,'has'),
(141,2058,'has'),
(141,2059,'has'),
(142,2060,'has'),
(143,2061,'has'),
(144,2062,'has'),
(144,2063,'has'),
(145,2064,'has'),
(146,2065,'has'),
(147,2066,'has'),
(147,2067,'has'),
(148,2068,'has'),
(149,2069,'has'),
(150,2070,'has'),
(150,2071,'has'),
(151,2072,'has'),
(152,2073,'has'),
(152,2074,'has'),
(153,2075,'has'),
(154,2076,'has'),
(155,2077,'has'),
(155,2078,'has'),
(156,2079,'has'),
(156,2080,'has'),
(157,2081,'has'),
(158,2082,'has'),
(159,2083,'has'),
(159,2084,'has'),
(160,2085,'has'),
(161,2086,'has'),
(162,2087,'has'),
(163,2088,'has'),
(164,2089,'has'),
(165,2090,'has'),
(166,2091,'has'),
(167,2092,'has'),
(167,2093,'has'),
(168,2094,'has'),
(168,2095,'has'),
(169,2096,'has'),
(170,2097,'has'),
(171,2098,'has'),
(172,2099,'has'),
(173,2100,'has'),
(174,2101,'has'),
(175,2102,'has'),
(175,2103,'has'),
(176,2104,'has'),
(176,2105,'has'),
(177,2106,'has'),
(178,2107,'has'),
(178,2108,'has'),
(179,2109,'has'),
(180,2110,'has'),
(181,2111,'has'),
(182,2112,'has'),
(182,2113,'has'),
(183,2114,'has'),
(183,2115,'has'),
(184,2116,'has'),
(184,2117,'has'),
(185,2118,'has'),
(186,2119,'has'),
(187,2120,'has'),
(188,2121,'has'),
(188,2122,'has'),
(189,2123,'has'),
(190,2124,'has'),
(190,2125,'has'),
(191,2126,'has'),
(192,2127,'has'),
(192,2128,'has'),
(193,2129,'has'),
(194,2130,'has'),
(194,2131,'has'),
(195,2132,'has'),
(195,2133,'has'),
(196,2134,'has'),
(196,2135,'has'),
(197,2136,'has'),
(198,2137,'has'),
(198,2138,'has'),
(199,2139,'has'),
(199,2140,'has');

-- post nodes

-- ID,Type
INSERT INTO node(id, label, graph_id) VALUES
(4000,'extremism',3),
(4001,'extremism',3),
(4002,'extremism',3),
(4003,'extremism',3),
(4004,'extremism',3),
(4005,'extremism',3),
(4006,'extremism',3),
(4007,'extremism',3),
(4008,'extremism',3),
(4009,'extremism',3),
(4010,'extremism',3),
(4011,'extremism',3),
(4012,'extremism',3),
(4013,'extremism',3),
(4014,'extremism',3),
(4015,'extremism',3),
(4016,'extremism',3),
(4017,'extremism',3),
(4018,'extremism',3),
(4019,'extremism',3),
(4020,'extremism',3),
(4021,'extremism',3),
(4022,'extremism',3),
(4023,'extremism',3),
(4024,'extremism',3),
(4025,'extremism',3),
(4026,'extremism',3),
(4027,'extremism',3),
(4028,'extremism',3),
(4029,'extremism',3),
(4030,'extremism',3),
(4031,'extremism',3),
(4032,'extremism',3),
(4033,'extremism',3),
(4034,'extremism',3),
(4035,'extremism',3),
(4036,'extremism',3),
(4037,'extremism',3),
(4038,'extremism',3),
(4039,'extremism',3),
(4040,'extremism',3),
(4041,'extremism',3),
(4042,'extremism',3),
(4043,'extremism',3),
(4044,'extremism',3),
(4045,'extremism',3),
(4046,'extremism',3),
(4047,'extremism',3),
(4048,'extremism',3),
(4049,'extremism',3),
(4050,'extremism',3),
(4051,'extremism',3),
(4052,'extremism',3),
(4053,'extremism',3),
(4054,'extremism',3),
(4055,'extremism',3),
(4056,'extremism',3),
(4057,'extremism',3),
(4058,'extremism',3),
(4059,'extremism',3),
(4060,'extremism',3),
(4061,'extremism',3),
(4062,'extremism',3),
(4063,'extremism',3),
(4064,'extremism',3),
(4065,'extremism',3),
(4066,'extremism',3),
(4067,'extremism',3),
(4068,'extremism',3),
(4069,'extremism',3),
(4070,'extremism',3),
(4071,'extremism',3),
(4072,'extremism',3),
(4073,'extremism',3),
(4074,'extremism',3),
(4075,'extremism',3),
(4076,'extremism',3),
(4077,'extremism',3),
(4078,'extremism',3),
(4079,'extremism',3),
(4080,'extremism',3),
(4081,'extremism',3),
(4082,'extremism',3),
(4083,'extremism',3),
(4084,'extremism',3),
(4085,'extremism',3),
(4086,'extremism',3),
(4087,'extremism',3),
(4088,'extremism',3),
(4089,'extremism',3),
(4090,'extremism',3),
(4091,'extremism',3),
(4092,'extremism',3),
(4093,'extremism',3),
(4094,'extremism',3),
(4095,'extremism',3),
(4096,'extremism',3),
(4097,'extremism',3),
(4098,'extremism',3),
(4099,'extremism',3),
(4100,'extremism',3),
(4101,'extremism',3),
(4102,'extremism',3),
(4103,'extremism',3),
(4104,'extremism',3),
(4105,'extremism',3),
(4106,'extremism',3),
(4107,'extremism',3),
(4108,'extremism',3),
(4109,'extremism',3),
(4110,'extremism',3),
(4111,'extremism',3),
(4112,'extremism',3),
(4113,'extremism',3),
(4114,'extremism',3),
(4115,'extremism',3),
(4116,'extremism',3),
(4117,'extremism',3),
(4118,'extremism',3),
(4119,'extremism',3),
(4120,'extremism',3),
(4121,'extremism',3),
(4122,'extremism',3),
(4123,'extremism',3),
(4124,'extremism',3),
(4125,'extremism',3),
(4126,'extremism',3),
(4127,'extremism',3),
(4128,'extremism',3),
(4129,'extremism',3),
(4130,'extremism',3),
(4131,'extremism',3),
(4132,'extremism',3),
(4133,'extremism',3),
(4134,'extremism',3),
(4135,'extremism',3),
(4136,'extremism',3),
(4137,'extremism',3),
(4138,'extremism',3),
(4139,'extremism',3),
(4140,'extremism',3),
(4141,'extremism',3),
(4142,'extremism',3),
(4143,'extremism',3),
(4144,'extremism',3),
(4145,'extremism',3),
(4146,'extremism',3),
(4147,'extremism',3),
(4148,'extremism',3),
(4149,'extremism',3),
(4150,'extremism',3),
(4151,'extremism',3),
(4152,'extremism',3),
(4153,'extremism',3),
(4154,'extremism',3),
(4155,'extremism',3),
(4156,'extremism',3),
(4157,'extremism',3),
(4158,'extremism',3),
(4159,'extremism',3),
(4160,'extremism',3),
(4161,'extremism',3),
(4162,'extremism',3),
(4163,'extremism',3),
(4164,'extremism',3),
(4165,'extremism',3),
(4166,'extremism',3),
(4167,'extremism',3),
(4168,'extremism',3),
(4169,'extremism',3),
(4170,'extremism',3),
(4171,'extremism',3),
(4172,'extremism',3),
(4173,'extremism',3),
(4174,'extremism',3),
(4175,'extremism',3),
(4176,'extremism',3),
(4177,'extremism',3),
(4178,'extremism',3),
(4179,'extremism',3),
(4180,'extremism',3),
(4181,'extremism',3),
(4182,'extremism',3),
(4183,'extremism',3),
(4184,'extremism',3),
(4185,'extremism',3),
(4186,'extremism',3),
(4187,'extremism',3),
(4188,'extremism',3),
(4189,'extremism',3),
(4190,'extremism',3),
(4191,'extremism',3),
(4192,'extremism',3),
(4193,'extremism',3),
(4194,'extremism',3),
(4195,'extremism',3),
(4196,'extremism',3),
(4197,'extremism',3),
(4198,'extremism',3),
(4199,'extremism',3),
(4200,'extremism',3),
(4201,'extremism',3),
(4202,'extremism',3),
(4203,'extremism',3),
(4204,'extremism',3),
(4205,'extremism',3),
(4206,'extremism',3),
(4207,'extremism',3),
(4208,'extremism',3),
(4209,'extremism',3),
(4210,'extremism',3),
(4211,'extremism',3),
(4212,'extremism',3),
(4213,'extremism',3),
(4214,'extremism',3),
(4215,'extremism',3),
(4216,'extremism',3),
(4217,'extremism',3),
(4218,'extremism',3),
(4219,'extremism',3),
(4220,'extremism',3),
(4221,'extremism',3),
(4222,'extremism',3),
(4223,'extremism',3),
(4224,'extremism',3),
(4225,'extremism',3),
(4226,'extremism',3),
(4227,'extremism',3),
(4228,'extremism',3),
(4229,'extremism',3),
(4230,'extremism',3),
(4231,'extremism',3),
(4232,'extremism',3),
(4233,'extremism',3),
(4234,'extremism',3),
(4235,'extremism',3),
(4236,'extremism',3),
(4237,'extremism',3),
(4238,'extremism',3),
(4239,'extremism',3),
(4240,'extremism',3),
(4241,'extremism',3),
(4242,'extremism',3),
(4243,'extremism',3),
(4244,'extremism',3),
(4245,'extremism',3),
(4246,'extremism',3),
(4247,'extremism',3),
(4248,'extremism',3),
(4249,'extremism',3),
(4250,'extremism',3),
(4251,'extremism',3),
(4252,'extremism',3),
(4253,'extremism',3),
(4254,'extremism',3),
(4255,'extremism',3),
(4256,'extremism',3),
(4257,'extremism',3),
(4258,'extremism',3),
(4259,'extremism',3),
(4260,'extremism',3),
(4261,'extremism',3),
(4262,'extremism',3),
(4263,'extremism',3),
(4264,'extremism',3),
(4265,'extremism',3),
(4266,'extremism',3),
(4267,'extremism',3),
(4268,'extremism',3),
(4269,'extremism',3),
(4270,'extremism',3),
(4271,'extremism',3),
(4272,'extremism',3),
(4273,'extremism',3),
(4274,'extremism',3),
(4275,'extremism',3),
(4276,'extremism',3),
(4277,'extremism',3),
(4278,'extremism',3),
(4279,'extremism',3),
(4280,'extremism',3),
(4281,'extremism',3),
(4282,'extremism',3),
(4283,'extremism',3),
(4284,'extremism',3),
(4285,'extremism',3),
(4286,'extremism',3),
(4287,'extremism',3),
(4288,'extremism',3),
(4289,'extremism',3),
(4290,'extremism',3),
(4291,'extremism',3),
(4292,'extremism',3),
(4293,'extremism',3),
(4294,'extremism',3),
(4295,'extremism',3),
(4296,'extremism',3),
(4297,'extremism',3),
(4298,'extremism',3),
(4299,'extremism',3),
(4300,'extremism',3),
(4301,'extremism',3),
(4302,'extremism',3),
(4303,'extremism',3),
(4304,'extremism',3),
(4305,'extremism',3),
(4306,'extremism',3),
(4307,'extremism',3),
(4308,'extremism',3),
(4309,'extremism',3),
(4310,'extremism',3),
(4311,'extremism',3),
(4312,'extremism',3),
(4313,'extremism',3),
(4314,'extremism',3),
(4315,'extremism',3),
(4316,'extremism',3),
(4317,'extremism',3),
(4318,'extremism',3),
(4319,'extremism',3),
(4320,'extremism',3),
(4321,'extremism',3),
(4322,'extremism',3),
(4323,'extremism',3),
(4324,'extremism',3),
(4325,'extremism',3),
(4326,'extremism',3),
(4327,'extremism',3),
(4328,'extremism',3),
(4329,'extremism',3),
(4330,'extremism',3),
(4331,'extremism',3),
(4332,'extremism',3),
(4333,'extremism',3),
(4334,'extremism',3),
(4335,'extremism',3),
(4336,'extremism',3),
(4337,'extremism',3);

-- SMID,PostID,TimeStamp

INSERT INTO edge(source, target, label) VALUES
(2000,4000,'posts'),      -- 1452032337
(2001,4001,'posts'),      -- 1538997907
(2001,4002,'posts'),      -- 1296556176
(2001,4003,'posts'),      -- 1543388943
(2001,4004,'posts'),      -- 1393395971
(2002,4005,'posts'),      -- 1493198172
(2002,4006,'posts'),      -- 1487988877
(2002,4007,'posts'),      -- 1437793911
(2002,4008,'posts'),      -- 1312559692
(2003,4009,'posts'),      -- 1556514642
(2003,4010,'posts'),    -- 1301904146
(2003,4011,'posts'),    -- 1387543722
(2004,4012,'posts'),    -- 1354072097
(2004,4013,'posts'),    -- 1468513594
(2004,4014,'posts'),    -- 1425846775
(2005,4015,'posts'),    -- 1430424546
(2005,4016,'posts'),    -- 1506496884
(2006,4017,'posts'),    -- 1291431498
(2007,4018,'posts'),    -- 1477508164
(2007,4019,'posts'),    -- 1488258100
(2007,4020,'posts'),    -- 1385146175
(2007,4021,'posts'),    -- 1426775723
(2008,4022,'posts'),    -- 1282644758
(2008,4023,'posts'),    -- 1406114960
(2009,4024,'posts'),    -- 1448269177
(2009,4025,'posts'),    -- 1317983301
(2009,4026,'posts'),    -- 1507530500
(2009,4027,'posts'),    -- 1522963870
(2010,4028,'posts'),    -- 1381203170
(2011,4029,'posts'),    -- 1271369022
(2011,4030,'posts'),    -- 1472742515
(2011,4031,'posts'),    -- 1522339305
(2012,4032,'posts'),    -- 1475780011
(2012,4033,'posts'),    -- 1443299576
(2013,4034,'posts'),    -- 1354005196
(2014,4035,'posts'),    -- 1536752689
(2014,4036,'posts'),    -- 1329912316
(2014,4037,'posts'),    -- 1472481904
(2014,4038,'posts'),    -- 1306102956
(2015,4039,'posts'),    -- 1522084511
(2015,4040,'posts'),    -- 1397243254
(2015,4041,'posts'),    -- 1509048400
(2015,4042,'posts'),    -- 1382348952
(2016,4043,'posts'),    -- 1272218958
(2017,4044,'posts'),    -- 1540625997
(2018,4045,'posts'),    -- 1411852829
(2019,4046,'posts'),    -- 1443474468
(2019,4047,'posts'),    -- 1441471968
(2020,4048,'posts'),    -- 1478828255
(2020,4049,'posts'),    -- 1397960900
(2020,4050,'posts'),    -- 1427956367
(2021,4051,'posts'),    -- 1414228515
(2021,4052,'posts'),    -- 1316674794
(2021,4053,'posts'),    -- 1316228492
(2021,4054,'posts'),    -- 1542901188
(2022,4055,'posts'),    -- 1556231575
(2022,4056,'posts'),    -- 1527066417
(2023,4057,'posts'),    -- 1411661504
(2023,4058,'posts'),    -- 1467942197
(2023,4059,'posts'),    -- 1460947842
(2023,4060,'posts'),    -- 1356496719
(2024,4061,'posts'),    -- 1527140179
(2024,4062,'posts'),    -- 1544982725
(2024,4063,'posts'),    -- 1305162556
(2025,4064,'posts'),    -- 1428653941
(2026,4065,'posts'),    -- 1361571261
(2026,4066,'posts'),    -- 1419334173
(2026,4067,'posts'),    -- 1389881998
(2027,4068,'posts'),    -- 1482134480
(2027,4069,'posts'),    -- 1515388672
(2027,4070,'posts'),    -- 1339290932
(2028,4071,'posts'),    -- 1388589527
(2028,4072,'posts'),    -- 1394419766
(2029,4073,'posts'),    -- 1293866109
(2029,4074,'posts'),    -- 1352008013
(2029,4075,'posts'),    -- 1551224118
(2030,4076,'posts'),    -- 1552905482
(2030,4077,'posts'),    -- 1366479079
(2031,4078,'posts'),    -- 1557813962
(2031,4079,'posts'),    -- 1559378306
(2031,4080,'posts'),    -- 1550473443
(2031,4081,'posts'),    -- 1535424989
(2032,4082,'posts'),    -- 1311644484
(2033,4083,'posts'),    -- 1473862357
(2033,4084,'posts'),    -- 1357979535
(2033,4085,'posts'),    -- 1493192321
(2034,4086,'posts'),    -- 1380679047
(2035,4087,'posts'),    -- 1535161998
(2035,4088,'posts'),    -- 1421722333
(2035,4089,'posts'),    -- 1354640239
(2035,4090,'posts'),    -- 1351552352
(2036,4091,'posts'),    -- 1447871958
(2037,4092,'posts'),    -- 1533766622
(2037,4093,'posts'),    -- 1465798202
(2037,4094,'posts'),    -- 1307067589
(2038,4095,'posts'),    -- 1432429840
(2039,4096,'posts'),    -- 1416434270
(2039,4097,'posts'),    -- 1427048403
(2039,4098,'posts'),    -- 1463893996
(2039,4099,'posts'),    -- 1406022897
(2040,4100,'posts'),    -- 1283346430
(2041,4101,'posts'),    -- 1387637051
(2041,4102,'posts'),    -- 1262835024
(2042,4103,'posts'),    -- 1534444337
(2042,4104,'posts'),    -- 1503311453
(2043,4105,'posts'),    -- 1450212194
(2044,4106,'posts'),    -- 1331582467
(2044,4107,'posts'),    -- 1275832322
(2045,4108,'posts'),    -- 1525387580
(2045,4109,'posts'),    -- 1383867703
(2045,4110,'posts'),    -- 1404447957
(2046,4111,'posts'),    -- 1335346824
(2046,4112,'posts'),    -- 1354113090
(2047,4113,'posts'),    -- 1393050002
(2047,4114,'posts'),    -- 1287880244
(2047,4115,'posts'),    -- 1365124930
(2047,4116,'posts'),    -- 1357786604
(2048,4117,'posts'),    -- 1528172904
(2049,4118,'posts'),    -- 1282852809
(2050,4119,'posts'),    -- 1470461160
(2051,4120,'posts'),    -- 1364702395
(2051,4121,'posts'),    -- 1490172392
(2051,4122,'posts'),    -- 1325341892
(2051,4123,'posts'),    -- 1549836897
(2052,4124,'posts'),    -- 1324518169
(2052,4125,'posts'),    -- 1443517206
(2052,4126,'posts'),    -- 1339087803
(2052,4127,'posts'),    -- 1450894545
(2053,4128,'posts'),    -- 1548983051
(2054,4129,'posts'),    -- 1440338492
(2054,4130,'posts'),    -- 1398937777
(2055,4131,'posts'),    -- 1278881160
(2055,4132,'posts'),    -- 1493053924
(2056,4133,'posts'),    -- 1475405143
(2056,4134,'posts'),    -- 1351364032
(2056,4135,'posts'),    -- 1419848590
(2056,4136,'posts'),    -- 1282241568
(2057,4137,'posts'),    -- 1541327642
(2058,4138,'posts'),    -- 1298892270
(2058,4139,'posts'),    -- 1464395852
(2058,4140,'posts'),    -- 1305137944
(2059,4141,'posts'),    -- 1467820590
(2060,4142,'posts'),    -- 1379891427
(2060,4143,'posts'),    -- 1318799953
(2060,4144,'posts'),    -- 1519634582
(2061,4145,'posts'),    -- 1388782606
(2061,4146,'posts'),    -- 1526083448
(2061,4147,'posts'),    -- 1393632719
(2062,4148,'posts'),    -- 1369489527
(2062,4149,'posts'),    -- 1532960142
(2062,4150,'posts'),    -- 1531463016
(2062,4151,'posts'),    -- 1425107857
(2063,4152,'posts'),    -- 1410882019
(2063,4153,'posts'),    -- 1360803498
(2063,4154,'posts'),    -- 1548834349
(2064,4155,'posts'),    -- 1445028465
(2065,4156,'posts'),    -- 1388484796
(2065,4157,'posts'),    -- 1520903871
(2066,4158,'posts'),    -- 1518603289
(2066,4159,'posts'),    -- 1394778669
(2066,4160,'posts'),    -- 1374085089
(2067,4161,'posts'),    -- 1293300653
(2068,4162,'posts'),    -- 1384964838
(2068,4163,'posts'),    -- 1370196261
(2069,4164,'posts'),    -- 1516995569
(2069,4165,'posts'),    -- 1541077824
(2069,4166,'posts'),    -- 1395958962
(2070,4167,'posts'),    -- 1497456365
(2071,4168,'posts'),    -- 1515728967
(2071,4169,'posts'),    -- 1538295259
(2071,4170,'posts'),    -- 1311638887
(2071,4171,'posts'),    -- 1328220452
(2072,4172,'posts'),    -- 1391303412
(2072,4173,'posts'),    -- 1556092844
(2072,4174,'posts'),    -- 1400263524
(2073,4175,'posts'),    -- 1349657584
(2073,4176,'posts'),    -- 1549680396
(2073,4177,'posts'),    -- 1478561960
(2074,4178,'posts'),    -- 1440670149
(2074,4179,'posts'),    -- 1355263601
(2074,4180,'posts'),    -- 1354209874
(2075,4181,'posts'),    -- 1387200565
(2076,4182,'posts'),    -- 1295969247
(2076,4183,'posts'),    -- 1417644725
(2076,4184,'posts'),    -- 1479312662
(2077,4185,'posts'),    -- 1318758665
(2077,4186,'posts'),    -- 1511384371
(2077,4187,'posts'),    -- 1424449540
(2078,4188,'posts'),    -- 1276542333
(2078,4189,'posts'),    -- 1490559153
(2079,4190,'posts'),    -- 1501498499
(2079,4191,'posts'),    -- 1316256234
(2079,4192,'posts'),    -- 1323548334
(2079,4193,'posts'),    -- 1313451563
(2080,4194,'posts'),    -- 1417147462
(2080,4195,'posts'),    -- 1344472854
(2081,4196,'posts'),    -- 1486256103
(2081,4197,'posts'),    -- 1499863748
(2081,4198,'posts'),    -- 1376551754
(2082,4199,'posts'),    -- 1456004971
(2083,4200,'posts'),    -- 1540445873
(2083,4201,'posts'),    -- 1427805903
(2084,4202,'posts'),    -- 1450793827
(2084,4203,'posts'),    -- 1498662899
(2085,4204,'posts'),    -- 1295906688
(2086,4205,'posts'),    -- 1413066895
(2086,4206,'posts'),    -- 1367057732
(2086,4207,'posts'),    -- 1492491351
(2087,4208,'posts'),    -- 1528993248
(2087,4209,'posts'),    -- 1363266810
(2088,4210,'posts'),    -- 1344557133
(2088,4211,'posts'),    -- 1354310242
(2088,4212,'posts'),    -- 1381299336
(2088,4213,'posts'),    -- 1365473038
(2089,4214,'posts'),    -- 1413535955
(2089,4215,'posts'),    -- 1368136558
(2090,4216,'posts'),    -- 1353330927
(2091,4217,'posts'),    -- 1397529306
(2091,4218,'posts'),    -- 1549060944
(2092,4219,'posts'),    -- 1488281469
(2092,4220,'posts'),    -- 1549679660
(2093,4221,'posts'),    -- 1305555190
(2094,4222,'posts'),    -- 1513624425
(2094,4223,'posts'),    -- 1361935348
(2095,4224,'posts'),    -- 1487520792
(2096,4225,'posts'),    -- 1412162140
(2096,4226,'posts'),    -- 1454318322
(2096,4227,'posts'),    -- 1325385782
(2097,4228,'posts'),    -- 1415666897
(2097,4229,'posts'),    -- 1301687341
(2098,4230,'posts'),    -- 1446176612
(2098,4231,'posts'),    -- 1447914912
(2098,4232,'posts'),    -- 1270381611
(2099,4233,'posts'),    -- 1273226297
(2099,4234,'posts'),    -- 1387780691
(2099,4235,'posts'),    -- 1469648953
(2100,4236,'posts'),    -- 1327676510
(2100,4237,'posts'),    -- 1273388099
(2100,4238,'posts'),    -- 1416274941
(2101,4239,'posts'),    -- 1438920748
(2101,4240,'posts'),    -- 1441434464
(2102,4241,'posts'),    -- 1395253125
(2102,4242,'posts'),    -- 1452855578
(2102,4243,'posts'),    -- 1332454787
(2102,4244,'posts'),    -- 1373529569
(2103,4245,'posts'),    -- 1493529545
(2103,4246,'posts'),    -- 1378824597
(2103,4247,'posts'),    -- 1281492606
(2104,4248,'posts'),    -- 1335617702
(2104,4249,'posts'),    -- 1285057745
(2105,4250,'posts'),    -- 1497050763
(2105,4251,'posts'),    -- 1274702758
(2105,4252,'posts'),    -- 1414727702
(2105,4253,'posts'),    -- 1367790676
(2106,4254,'posts'),    -- 1274741212
(2107,4255,'posts'),    -- 1428648602
(2108,4256,'posts'),    -- 1325464257
(2109,4257,'posts'),    -- 1429985766
(2109,4258,'posts'),    -- 1437698781
(2109,4259,'posts'),    -- 1326900801
(2110,4260,'posts'),    -- 1352631258
(2110,4261,'posts'),    -- 1403055557
(2111,4262,'posts'),    -- 1500856539
(2112,4263,'posts'),    -- 1332091086
(2112,4264,'posts'),    -- 1346052496
(2112,4265,'posts'),    -- 1317237173
(2112,4266,'posts'),    -- 1303395860
(2113,4267,'posts'),    -- 1559417404
(2113,4268,'posts'),    -- 1379157872
(2114,4269,'posts'),    -- 1284001887
(2114,4270,'posts'),    -- 1409396516
(2114,4271,'posts'),    -- 1541703404
(2115,4272,'posts'),    -- 1538169925
(2115,4273,'posts'),    -- 1429907801
(2116,4274,'posts'),    -- 1317772711
(2116,4275,'posts'),    -- 1474693588
(2116,4276,'posts'),    -- 1356055445
(2116,4277,'posts'),    -- 1504721062
(2117,4278,'posts'),    -- 1441852791
(2117,4279,'posts'),    -- 1340798354
(2118,4280,'posts'),    -- 1281853281
(2118,4281,'posts'),    -- 1478438798
(2118,4282,'posts'),    -- 1347553510
(2119,4283,'posts'),    -- 1403654278
(2119,4284,'posts'),    -- 1361023606
(2120,4285,'posts'),    -- 1278692520
(2121,4286,'posts'),    -- 1490986513
(2121,4287,'posts'),    -- 1448025171
(2121,4288,'posts'),    -- 1358053778
(2122,4289,'posts'),    -- 1528142301
(2122,4290,'posts'),    -- 1281196363
(2122,4291,'posts'),    -- 1504239550
(2122,4292,'posts'),    -- 1388104076
(2123,4293,'posts'),    -- 1374976610
(2123,4294,'posts'),    -- 1366417385
(2123,4295,'posts'),    -- 1382555578
(2123,4296,'posts'),    -- 1450159649
(2124,4297,'posts'),    -- 1314329742
(2124,4298,'posts'),    -- 1313350170
(2125,4299,'posts'),    -- 1472338226
(2125,4300,'posts'),    -- 1382925444
(2125,4301,'posts'),    -- 1429970000
(2125,4302,'posts'),    -- 1371510384
(2126,4303,'posts'),    -- 1406418697
(2126,4304,'posts'),    -- 1412536012
(2126,4305,'posts'),    -- 1550558928
(2127,4306,'posts'),    -- 1288453122
(2128,4307,'posts'),    -- 1537831935
(2128,4308,'posts'),    -- 1440937244
(2128,4309,'posts'),    -- 1327669852
(2128,4310,'posts'),    -- 1311965181
(2129,4311,'posts'),    -- 1388602769
(2129,4312,'posts'),    -- 1283422267
(2129,4313,'posts'),    -- 1478663109
(2130,4314,'posts'),    -- 1376121818
(2130,4315,'posts'),    -- 1339115422
(2131,4316,'posts'),    -- 1316978399
(2132,4317,'posts'),    -- 1528994580
(2132,4318,'posts'),    -- 1273477947
(2132,4319,'posts'),    -- 1424834049
(2133,4320,'posts'),    -- 1535354766
(2134,4321,'posts'),    -- 1359683912
(2134,4322,'posts'),    -- 1497111620
(2135,4323,'posts'),    -- 1528842978
(2135,4324,'posts'),    -- 1555290157
(2136,4325,'posts'),    -- 1547934931
(2136,4326,'posts'),    -- 1478737542
(2136,4327,'posts'),    -- 1385462283
(2136,4328,'posts'),    -- 1469005721
(2137,4329,'posts'),    -- 1380482249
(2138,4330,'posts'),    -- 1430262053
(2138,4331,'posts'),    -- 1555292748
(2139,4332,'posts'),    -- 1408229494
(2139,4333,'posts'),    -- 1520312101
(2140,4334,'posts'),    -- 1280706440
(2140,4335,'posts'),    -- 1554064900
(2140,4336,'posts'),    -- 1481448457
(2140,4337,'posts');    -- 1504114832

-- activity
-- ID,Name,Type
INSERT INTO node(id, label, graph_id) VALUES
(5000,'activity',3),
(5001,'activity',3),
(5002,'activity',3),
(5003,'activity',3),
(5004,'activity',3),
(5005,'activity',3),
(5006,'activity',3),
(5007,'activity',3),
(5008,'activity',3),
(5009,'activity',3),
(5010,'activity',3),
(5011,'activity',3),
(5012,'activity',3),
(5013,'activity',3),
(5014,'activity',3),
(5015,'activity',3),
(5016,'activity',3),
(5017,'activity',3),
(5018,'activity',3),
(5019,'activity',3),
(5020,'activity',3),
(5021,'activity',3),
(5022,'activity',3),
(5023,'activity',3),
(5024,'activity',3),
(5025,'activity',3),
(5026,'activity',3),
(5027,'activity',3),
(5028,'activity',3),
(5029,'activity',3),
(5030,'activity',3),
(5031,'activity',3),
(5032,'activity',3),
(5033,'activity',3),
(5034,'activity',3),
(5035,'activity',3),
(5036,'activity',3),
(5037,'activity',3),
(5038,'activity',3),
(5039,'activity',3),
(5040,'activity',3),
(5041,'activity',3),
(5042,'activity',3),
(5043,'activity',3),
(5044,'activity',3),
(5045,'activity',3),
(5046,'activity',3),
(5047,'activity',3),
(5048,'activity',3),
(5049,'activity',3),
(5050,'activity',3),
(5051,'activity',3),
(5052,'activity',3),
(5053,'activity',3),
(5054,'activity',3),
(5055,'activity',3),
(5056,'activity',3),
(5057,'activity',3),
(5058,'activity',3),
(5059,'activity',3),
(5060,'activity',3),
(5061,'activity',3),
(5062,'activity',3),
(5063,'activity',3),
(5064,'activity',3),
(5065,'activity',3),
(5066,'activity',3),
(5067,'activity',3),
(5068,'activity',3),
(5069,'activity',3),
(5070,'activity',3),
(5071,'activity',3),
(5072,'activity',3),
(5073,'activity',3),
(5074,'activity',3),
(5075,'activity',3),
(5076,'activity',3),
(5077,'activity',3),
(5078,'activity',3),
(5079,'activity',3),
(5080,'activity',3),
(5081,'activity',3),
(5082,'activity',3),
(5083,'activity',3),
(5084,'activity',3),
(5085,'activity',3),
(5086,'activity',3),
(5087,'activity',3),
(5088,'activity',3),
(5089,'activity',3),
(5090,'activity',3),
(5091,'activity',3),
(5092,'activity',3),
(5093,'activity',3),
(5094,'activity',3),
(5095,'activity',3),
(5096,'activity',3),
(5097,'activity',3),
(5098,'activity',3),
(5099,'activity',3),
(5100,'activity',3),
(5101,'activity',3),
(5102,'activity',3),
(5103,'activity',3),
(5104,'activity',3),
(5105,'activity',3),
(5106,'activity',3),
(5107,'activity',3),
(5108,'activity',3),
(5109,'activity',3),
(5110,'activity',3),
(5111,'activity',3),
(5112,'activity',3),
(5113,'activity',3),
(5114,'activity',3),
(5115,'activity',3),
(5116,'activity',3),
(5117,'activity',3),
(5118,'activity',3),
(5119,'activity',3),
(5120,'activity',3),
(5121,'activity',3),
(5122,'activity',3),
(5123,'activity',3),
(5124,'activity',3),
(5125,'activity',3),
(5126,'activity',3),
(5127,'activity',3),
(5128,'activity',3),
(5129,'activity',3),
(5130,'activity',3),
(5131,'activity',3),
(5132,'activity',3),
(5133,'activity',3),
(5134,'activity',3),
(5135,'activity',3),
(5136,'activity',3),
(5137,'activity',3),
(5138,'activity',3),
(5139,'activity',3),
(5140,'activity',3),
(5141,'activity',3),
(5142,'activity',3),
(5143,'activity',3),
(5144,'activity',3),
(5145,'activity',3),
(5146,'activity',3),
(5147,'activity',3),
(5148,'activity',3),
(5149,'activity',3),
(5150,'activity',3),
(5151,'activity',3),
(5152,'activity',3),
(5153,'activity',3),
(5154,'activity',3),
(5155,'activity',3),
(5156,'activity',3),
(5157,'activity',3),
(5158,'activity',3),
(5159,'activity',3),
(5160,'activity',3),
(5161,'activity',3),
(5162,'activity',3),
(5163,'activity',3),
(5164,'activity',3),
(5165,'activity',3),
(5166,'activity',3),
(5167,'activity',3),
(5168,'activity',3),
(5169,'activity',3),
(5170,'activity',3),
(5171,'activity',3),
(5172,'activity',3),
(5173,'activity',3),
(5174,'activity',3),
(5175,'activity',3),
(5176,'activity',3),
(5177,'activity',3),
(5178,'activity',3),
(5179,'activity',3),
(5180,'activity',3),
(5181,'activity',3),
(5182,'activity',3),
(5183,'activity',3),
(5184,'activity',3),
(5185,'activity',3),
(5186,'activity',3),
(5187,'activity',3),
(5188,'activity',3),
(5189,'activity',3),
(5190,'activity',3),
(5191,'activity',3),
(5192,'activity',3),
(5193,'activity',3),
(5194,'activity',3),
(5195,'activity',3),
(5196,'activity',3),
(5197,'activity',3),
(5198,'activity',3),
(5199,'activity',3),
(5200,'activity',3),
(5201,'activity',3),
(5202,'activity',3),
(5203,'activity',3),
(5204,'activity',3),
(5205,'activity',3),
(5206,'activity',3),
(5207,'activity',3),
(5208,'activity',3),
(5209,'activity',3),
(5210,'activity',3),
(5211,'activity',3),
(5212,'activity',3),
(5213,'activity',3),
(5214,'activity',3),
(5215,'activity',3),
(5216,'activity',3),
(5217,'activity',3),
(5218,'activity',3),
(5219,'activity',3),
(5220,'activity',3),
(5221,'activity',3),
(5222,'activity',3),
(5223,'activity',3),
(5224,'activity',3),
(5225,'activity',3),
(5226,'activity',3),
(5227,'activity',3),
(5228,'activity',3),
(5229,'activity',3),
(5230,'activity',3),
(5231,'activity',3),
(5232,'activity',3),
(5233,'activity',3),
(5234,'activity',3),
(5235,'activity',3),
(5236,'activity',3),
(5237,'activity',3),
(5238,'activity',3),
(5239,'activity',3),
(5240,'activity',3),
(5241,'activity',3),
(5242,'activity',3),
(5243,'activity',3),
(5244,'activity',3),
(5245,'activity',3),
(5246,'activity',3),
(5247,'activity',3),
(5248,'activity',3),
(5249,'activity',3),
(5250,'activity',3),
(5251,'activity',3),
(5252,'activity',3),
(5253,'activity',3),
(5254,'activity',3),
(5255,'activity',3),
(5256,'activity',3),
(5257,'activity',3),
(5258,'activity',3),
(5259,'activity',3),
(5260,'activity',3),
(5261,'activity',3),
(5262,'activity',3),
(5263,'activity',3),
(5264,'activity',3),
(5265,'activity',3),
(5266,'activity',3),
(5267,'activity',3),
(5268,'activity',3),
(5269,'activity',3),
(5270,'activity',3),
(5271,'activity',3),
(5272,'activity',3),
(5273,'activity',3),
(5274,'activity',3),
(5275,'activity',3),
(5276,'activity',3),
(5277,'activity',3),
(5278,'activity',3),
(5279,'activity',3),
(5280,'activity',3),
(5281,'activity',3),
(5282,'activity',3),
(5283,'activity',3),
(5284,'activity',3),
(5285,'activity',3),
(5286,'activity',3),
(5287,'activity',3),
(5288,'activity',3),
(5289,'activity',3),
(5290,'activity',3),
(5291,'activity',3),
(5292,'activity',3),
(5293,'activity',3),
(5294,'activity',3),
(5295,'activity',3),
(5296,'activity',3),
(5297,'activity',3),
(5298,'activity',3),
(5299,'activity',3),
(5300,'activity',3),
(5301,'activity',3),
(5302,'activity',3),
(5303,'activity',3),
(5304,'activity',3),
(5305,'activity',3),
(5306,'activity',3),
(5307,'activity',3),
(5308,'activity',3),
(5309,'activity',3),
(5310,'activity',3),
(5311,'activity',3),
(5312,'activity',3),
(5313,'activity',3),
(5314,'activity',3),
(5315,'activity',3),
(5316,'activity',3),
(5317,'activity',3),
(5318,'activity',3),
(5319,'activity',3),
(5320,'activity',3),
(5321,'activity',3),
(5322,'activity',3),
(5323,'activity',3),
(5324,'activity',3),
(5325,'activity',3),
(5326,'activity',3),
(5327,'activity',3),
(5328,'activity',3),
(5329,'activity',3),
(5330,'activity',3),
(5331,'activity',3),
(5332,'activity',3),
(5333,'activity',3),
(5334,'activity',3),
(5335,'activity',3),
(5336,'activity',3),
(5337,'activity',3),
(5338,'activity',3),
(5339,'activity',3),
(5340,'activity',3),
(5341,'activity',3),
(5342,'activity',3),
(5343,'activity',3),
(5344,'activity',3),
(5345,'activity',3),
(5346,'activity',3),
(5347,'activity',3),
(5348,'activity',3),
(5349,'activity',3),
(5350,'activity',3),
(5351,'activity',3),
(5352,'activity',3),
(5353,'activity',3),
(5354,'activity',3),
(5355,'activity',3),
(5356,'activity',3),
(5357,'activity',3),
(5358,'activity',3),
(5359,'activity',3),
(5360,'activity',3),
(5361,'activity',3),
(5362,'activity',3),
(5363,'activity',3),
(5364,'activity',3),
(5365,'activity',3),
(5366,'activity',3),
(5367,'activity',3),
(5368,'activity',3),
(5369,'activity',3),
(5370,'activity',3),
(5371,'activity',3),
(5372,'activity',3),
(5373,'activity',3),
(5374,'activity',3),
(5375,'activity',3),
(5376,'activity',3),
(5377,'activity',3),
(5378,'activity',3),
(5379,'activity',3),
(5380,'activity',3),
(5381,'activity',3),
(5382,'activity',3),
(5383,'activity',3),
(5384,'activity',3),
(5385,'activity',3),
(5386,'activity',3),
(5387,'activity',3),
(5388,'activity',3),
(5389,'activity',3),
(5390,'activity',3),
(5391,'activity',3),
(5392,'activity',3),
(5393,'activity',3),
(5394,'activity',3),
(5395,'activity',3),
(5396,'activity',3),
(5397,'activity',3),
(5398,'activity',3),
(5399,'activity',3);

INSERT INTO public.property(node_id, key, value) VALUES

(5000,'name','Suspicious Travel'),
(5001,'name','Referred Radicalized Materials'),
(5002,'name','Suspicious Travel'),
(5003,'name','Referred Radicalized Materials'),
(5004,'name','Suspicious Travel'),
(5005,'name','Referred Radicalized Materials'),
(5006,'name','Suspicious Travel'),
(5007,'name','Suspicious Travel'),
(5008,'name','Referred Radicalized Materials'),
(5009,'name','Purchase Weapons'),
(5010,'name','Suspicious Travel'),
(5011,'name','Purchase Weapons'),
(5012,'name','Purchase Weapons'),
(5013,'name','Purchase Weapons'),
(5014,'name','Referred Radicalized Materials'),
(5015,'name','Purchase Weapons'),
(5016,'name','Suspicious Travel'),
(5017,'name','Received Training'),
(5018,'name','Purchase Weapons'),
(5019,'name','Referred Radicalized Materials'),
(5020,'name','Received Training'),
(5021,'name','Purchase Weapons'),
(5022,'name','Received Training'),
(5023,'name','Received Training'),
(5024,'name','Received Training'),
(5025,'name','Purchase Weapons'),
(5026,'name','Referred Radicalized Materials'),
(5027,'name','Referred Radicalized Materials'),
(5028,'name','Received Training'),
(5029,'name','Suspicious Travel'),
(5030,'name','Received Training'),
(5031,'name','Referred Radicalized Materials'),
(5032,'name','Referred Radicalized Materials'),
(5033,'name','Suspicious Travel'),
(5034,'name','Suspicious Travel'),
(5035,'name','Purchase Weapons'),
(5036,'name','Purchase Weapons'),
(5037,'name','Referred Radicalized Materials'),
(5038,'name','Referred Radicalized Materials'),
(5039,'name','Referred Radicalized Materials'),
(5040,'name','Referred Radicalized Materials'),
(5041,'name','Received Training'),
(5042,'name','Purchase Weapons'),
(5043,'name','Received Training'),
(5044,'name','Purchase Weapons'),
(5045,'name','Received Training'),
(5046,'name','Referred Radicalized Materials'),
(5047,'name','Referred Radicalized Materials'),
(5048,'name','Referred Radicalized Materials'),
(5049,'name','Referred Radicalized Materials'),
(5050,'name','Purchase Weapons'),
(5051,'name','Suspicious Travel'),
(5052,'name','Received Training'),
(5053,'name','Referred Radicalized Materials'),
(5054,'name','Referred Radicalized Materials'),
(5055,'name','Received Training'),
(5056,'name','Received Training'),
(5057,'name','Suspicious Travel'),
(5058,'name','Purchase Weapons'),
(5059,'name','Purchase Weapons'),
(5060,'name','Purchase Weapons'),
(5061,'name','Referred Radicalized Materials'),
(5062,'name','Referred Radicalized Materials'),
(5063,'name','Purchase Weapons'),
(5064,'name','Purchase Weapons'),
(5065,'name','Suspicious Travel'),
(5066,'name','Referred Radicalized Materials'),
(5067,'name','Referred Radicalized Materials'),
(5068,'name','Referred Radicalized Materials'),
(5069,'name','Purchase Weapons'),
(5070,'name','Referred Radicalized Materials'),
(5071,'name','Suspicious Travel'),
(5072,'name','Referred Radicalized Materials'),
(5073,'name','Referred Radicalized Materials'),
(5074,'name','Referred Radicalized Materials'),
(5075,'name','Suspicious Travel'),
(5076,'name','Referred Radicalized Materials'),
(5077,'name','Referred Radicalized Materials'),
(5078,'name','Purchase Weapons'),
(5079,'name','Purchase Weapons'),
(5080,'name','Referred Radicalized Materials'),
(5081,'name','Purchase Weapons'),
(5082,'name','Received Training'),
(5083,'name','Referred Radicalized Materials'),
(5084,'name','Purchase Weapons'),
(5085,'name','Suspicious Travel'),
(5086,'name','Referred Radicalized Materials'),
(5087,'name','Suspicious Travel'),
(5088,'name','Purchase Weapons'),
(5089,'name','Suspicious Travel'),
(5090,'name','Received Training'),
(5091,'name','Referred Radicalized Materials'),
(5092,'name','Purchase Weapons'),
(5093,'name','Purchase Weapons'),
(5094,'name','Suspicious Travel'),
(5095,'name','Suspicious Travel'),
(5096,'name','Purchase Weapons'),
(5097,'name','Referred Radicalized Materials'),
(5098,'name','Received Training'),
(5099,'name','Referred Radicalized Materials'),
(5100,'name','Suspicious Travel'),
(5101,'name','Suspicious Travel'),
(5102,'name','Referred Radicalized Materials'),
(5103,'name','Referred Radicalized Materials'),
(5104,'name','Purchase Weapons'),
(5105,'name','Received Training'),
(5106,'name','Purchase Weapons'),
(5107,'name','Purchase Weapons'),
(5108,'name','Purchase Weapons'),
(5109,'name','Purchase Weapons'),
(5110,'name','Received Training'),
(5111,'name','Received Training'),
(5112,'name','Suspicious Travel'),
(5113,'name','Received Training'),
(5114,'name','Suspicious Travel'),
(5115,'name','Suspicious Travel'),
(5116,'name','Suspicious Travel'),
(5117,'name','Received Training'),
(5118,'name','Suspicious Travel'),
(5119,'name','Suspicious Travel'),
(5120,'name','Received Training'),
(5121,'name','Referred Radicalized Materials'),
(5122,'name','Suspicious Travel'),
(5123,'name','Suspicious Travel'),
(5124,'name','Suspicious Travel'),
(5125,'name','Suspicious Travel'),
(5126,'name','Suspicious Travel'),
(5127,'name','Received Training'),
(5128,'name','Purchase Weapons'),
(5129,'name','Referred Radicalized Materials'),
(5130,'name','Referred Radicalized Materials'),
(5131,'name','Suspicious Travel'),
(5132,'name','Received Training'),
(5133,'name','Received Training'),
(5134,'name','Referred Radicalized Materials'),
(5135,'name','Referred Radicalized Materials'),
(5136,'name','Purchase Weapons'),
(5137,'name','Suspicious Travel'),
(5138,'name','Suspicious Travel'),
(5139,'name','Purchase Weapons'),
(5140,'name','Referred Radicalized Materials'),
(5141,'name','Purchase Weapons'),
(5142,'name','Received Training'),
(5143,'name','Purchase Weapons'),
(5144,'name','Received Training'),
(5145,'name','Suspicious Travel'),
(5146,'name','Received Training'),
(5147,'name','Referred Radicalized Materials'),
(5148,'name','Suspicious Travel'),
(5149,'name','Purchase Weapons'),
(5150,'name','Referred Radicalized Materials'),
(5151,'name','Referred Radicalized Materials'),
(5152,'name','Received Training'),
(5153,'name','Purchase Weapons'),
(5154,'name','Referred Radicalized Materials'),
(5155,'name','Purchase Weapons'),
(5156,'name','Referred Radicalized Materials'),
(5157,'name','Purchase Weapons'),
(5158,'name','Received Training'),
(5159,'name','Referred Radicalized Materials'),
(5160,'name','Purchase Weapons'),
(5161,'name','Received Training'),
(5162,'name','Received Training'),
(5163,'name','Received Training'),
(5164,'name','Referred Radicalized Materials'),
(5165,'name','Received Training'),
(5166,'name','Referred Radicalized Materials'),
(5167,'name','Referred Radicalized Materials'),
(5168,'name','Received Training'),
(5169,'name','Suspicious Travel'),
(5170,'name','Suspicious Travel'),
(5171,'name','Purchase Weapons'),
(5172,'name','Purchase Weapons'),
(5173,'name','Received Training'),
(5174,'name','Received Training'),
(5175,'name','Purchase Weapons'),
(5176,'name','Suspicious Travel'),
(5177,'name','Referred Radicalized Materials'),
(5178,'name','Purchase Weapons'),
(5179,'name','Suspicious Travel'),
(5180,'name','Received Training'),
(5181,'name','Purchase Weapons'),
(5182,'name','Purchase Weapons'),
(5183,'name','Purchase Weapons'),
(5184,'name','Purchase Weapons'),
(5185,'name','Received Training'),
(5186,'name','Purchase Weapons'),
(5187,'name','Suspicious Travel'),
(5188,'name','Referred Radicalized Materials'),
(5189,'name','Suspicious Travel'),
(5190,'name','Purchase Weapons'),
(5191,'name','Purchase Weapons'),
(5192,'name','Referred Radicalized Materials'),
(5193,'name','Referred Radicalized Materials'),
(5194,'name','Referred Radicalized Materials'),
(5195,'name','Received Training'),
(5196,'name','Referred Radicalized Materials'),
(5197,'name','Referred Radicalized Materials'),
(5198,'name','Referred Radicalized Materials'),
(5199,'name','Received Training'),
(5200,'name','Received Training'),
(5201,'name','Suspicious Travel'),
(5202,'name','Suspicious Travel'),
(5203,'name','Received Training'),
(5204,'name','Suspicious Travel'),
(5205,'name','Received Training'),
(5206,'name','Purchase Weapons'),
(5207,'name','Purchase Weapons'),
(5208,'name','Purchase Weapons'),
(5209,'name','Received Training'),
(5210,'name','Suspicious Travel'),
(5211,'name','Purchase Weapons'),
(5212,'name','Referred Radicalized Materials'),
(5213,'name','Received Training'),
(5214,'name','Purchase Weapons'),
(5215,'name','Purchase Weapons'),
(5216,'name','Purchase Weapons'),
(5217,'name','Suspicious Travel'),
(5218,'name','Purchase Weapons'),
(5219,'name','Received Training'),
(5220,'name','Received Training'),
(5221,'name','Suspicious Travel'),
(5222,'name','Suspicious Travel'),
(5223,'name','Received Training'),
(5224,'name','Received Training'),
(5225,'name','Referred Radicalized Materials'),
(5226,'name','Suspicious Travel'),
(5227,'name','Suspicious Travel'),
(5228,'name','Received Training'),
(5229,'name','Suspicious Travel'),
(5230,'name','Received Training'),
(5231,'name','Referred Radicalized Materials'),
(5232,'name','Purchase Weapons'),
(5233,'name','Suspicious Travel'),
(5234,'name','Received Training'),
(5235,'name','Suspicious Travel'),
(5236,'name','Purchase Weapons'),
(5237,'name','Received Training'),
(5238,'name','Received Training'),
(5239,'name','Purchase Weapons'),
(5240,'name','Received Training'),
(5241,'name','Suspicious Travel'),
(5242,'name','Referred Radicalized Materials'),
(5243,'name','Received Training'),
(5244,'name','Purchase Weapons'),
(5245,'name','Suspicious Travel'),
(5246,'name','Received Training'),
(5247,'name','Purchase Weapons'),
(5248,'name','Received Training'),
(5249,'name','Received Training'),
(5250,'name','Suspicious Travel'),
(5251,'name','Suspicious Travel'),
(5252,'name','Purchase Weapons'),
(5253,'name','Purchase Weapons'),
(5254,'name','Received Training'),
(5255,'name','Suspicious Travel'),
(5256,'name','Referred Radicalized Materials'),
(5257,'name','Purchase Weapons'),
(5258,'name','Purchase Weapons'),
(5259,'name','Suspicious Travel'),
(5260,'name','Suspicious Travel'),
(5261,'name','Suspicious Travel'),
(5262,'name','Purchase Weapons'),
(5263,'name','Received Training'),
(5264,'name','Received Training'),
(5265,'name','Suspicious Travel'),
(5266,'name','Received Training'),
(5267,'name','Suspicious Travel'),
(5268,'name','Purchase Weapons'),
(5269,'name','Referred Radicalized Materials'),
(5270,'name','Purchase Weapons'),
(5271,'name','Referred Radicalized Materials'),
(5272,'name','Received Training'),
(5273,'name','Received Training'),
(5274,'name','Purchase Weapons'),
(5275,'name','Suspicious Travel'),
(5276,'name','Suspicious Travel'),
(5277,'name','Received Training'),
(5278,'name','Referred Radicalized Materials'),
(5279,'name','Received Training'),
(5280,'name','Purchase Weapons'),
(5281,'name','Received Training'),
(5282,'name','Purchase Weapons'),
(5283,'name','Suspicious Travel'),
(5284,'name','Purchase Weapons'),
(5285,'name','Received Training'),
(5286,'name','Received Training'),
(5287,'name','Purchase Weapons'),
(5288,'name','Received Training'),
(5289,'name','Received Training'),
(5290,'name','Referred Radicalized Materials'),
(5291,'name','Purchase Weapons'),
(5292,'name','Purchase Weapons'),
(5293,'name','Purchase Weapons'),
(5294,'name','Suspicious Travel'),
(5295,'name','Suspicious Travel'),
(5296,'name','Purchase Weapons'),
(5297,'name','Suspicious Travel'),
(5298,'name','Received Training'),
(5299,'name','Purchase Weapons'),
(5300,'name','Suspicious Travel'),
(5301,'name','Suspicious Travel'),
(5302,'name','Referred Radicalized Materials'),
(5303,'name','Received Training'),
(5304,'name','Purchase Weapons'),
(5305,'name','Purchase Weapons'),
(5306,'name','Purchase Weapons'),
(5307,'name','Purchase Weapons'),
(5308,'name','Suspicious Travel'),
(5309,'name','Suspicious Travel'),
(5310,'name','Suspicious Travel'),
(5311,'name','Received Training'),
(5312,'name','Purchase Weapons'),
(5313,'name','Suspicious Travel'),
(5314,'name','Received Training'),
(5315,'name','Purchase Weapons'),
(5316,'name','Referred Radicalized Materials'),
(5317,'name','Received Training'),
(5318,'name','Referred Radicalized Materials'),
(5319,'name','Referred Radicalized Materials'),
(5320,'name','Suspicious Travel'),
(5321,'name','Suspicious Travel'),
(5322,'name','Received Training'),
(5323,'name','Received Training'),
(5324,'name','Received Training'),
(5325,'name','Referred Radicalized Materials'),
(5326,'name','Purchase Weapons'),
(5327,'name','Suspicious Travel'),
(5328,'name','Referred Radicalized Materials'),
(5329,'name','Suspicious Travel'),
(5330,'name','Purchase Weapons'),
(5331,'name','Suspicious Travel'),
(5332,'name','Received Training'),
(5333,'name','Referred Radicalized Materials'),
(5334,'name','Suspicious Travel'),
(5335,'name','Suspicious Travel'),
(5336,'name','Referred Radicalized Materials'),
(5337,'name','Received Training'),
(5338,'name','Received Training'),
(5339,'name','Referred Radicalized Materials'),
(5340,'name','Received Training'),
(5341,'name','Suspicious Travel'),
(5342,'name','Suspicious Travel'),
(5343,'name','Purchase Weapons'),
(5344,'name','Purchase Weapons'),
(5345,'name','Received Training'),
(5346,'name','Purchase Weapons'),
(5347,'name','Suspicious Travel'),
(5348,'name','Purchase Weapons'),
(5349,'name','Referred Radicalized Materials'),
(5350,'name','Carried an attack'),
(5351,'name','Carried an attack'),
(5352,'name','Detonated a bomb'),
(5353,'name','Carried an attack'),
(5354,'name','Detonated a bomb'),
(5355,'name','Carried an attack'),
(5356,'name','Detonated a bomb'),
(5357,'name','Carried an attack'),
(5358,'name','Detonated a bomb'),
(5359,'name','Carried an attack'),
(5360,'name','Carried an attack'),
(5361,'name','Carried an attack'),
(5362,'name','Detonated a bomb'),
(5363,'name','Detonated a bomb'),
(5364,'name','Carried an attack'),
(5365,'name','Detonated a bomb'),
(5366,'name','Carried an attack'),
(5367,'name','Detonated a bomb'),
(5368,'name','Carried an attack'),
(5369,'name','Detonated a bomb'),
(5370,'name','Detonated a bomb'),
(5371,'name','Detonated a bomb'),
(5372,'name','Detonated a bomb'),
(5373,'name','Detonated a bomb'),
(5374,'name','Carried an attack'),
(5375,'name','Detonated a bomb'),
(5376,'name','Detonated a bomb'),
(5377,'name','Carried an attack'),
(5378,'name','Detonated a bomb'),
(5379,'name','Carried an attack'),
(5380,'name','Carried an attack'),
(5381,'name','Detonated a bomb'),
(5382,'name','Detonated a bomb'),
(5383,'name','Detonated a bomb'),
(5384,'name','Carried an attack'),
(5385,'name','Carried an attack'),
(5386,'name','Detonated a bomb'),
(5387,'name','Carried an attack'),
(5388,'name','Detonated a bomb'),
(5389,'name','Detonated a bomb'),
(5390,'name','Carried an attack'),
(5391,'name','Carried an attack'),
(5392,'name','Detonated a bomb'),
(5393,'name','Detonated a bomb'),
(5394,'name','Carried an attack'),
(5395,'name','Detonated a bomb'),
(5396,'name','Carried an attack'),
(5397,'name','Detonated a bomb'),
(5398,'name','Detonated a bomb'),
(5399,'name','Detonated a bomb');

INSERT INTO public.property(node_id, key, value) VALUES

(5000,'type','IND'),
(5001,'type','IND'),
(5002,'type','IND'),
(5003,'type','IND'),
(5004,'type','IND'),
(5005,'type','IND'),
(5006,'type','IND'),
(5007,'type','IND'),
(5008,'type','IND'),
(5009,'type','IIRA'),
(5010,'type','IND'),
(5011,'type','IIRA'),
(5012,'type','IIRA'),
(5013,'type','IIRA'),
(5014,'type','IND'),
(5015,'type','IIRA'),
(5016,'type','IND'),
(5017,'type','IND'),
(5018,'type','IIRA'),
(5019,'type','IND'),
(5020,'type','IND'),
(5021,'type','IIRA'),
(5022,'type','IND'),
(5023,'type','IND'),
(5024,'type','IND'),
(5025,'type','IIRA'),
(5026,'type','IND'),
(5027,'type','IND'),
(5028,'type','IND'),
(5029,'type','IND'),
(5030,'type','IND'),
(5031,'type','IND'),
(5032,'type','IND'),
(5033,'type','IND'),
(5034,'type','IND'),
(5035,'type','IIRA'),
(5036,'type','IIRA'),
(5037,'type','IND'),
(5038,'type','IND'),
(5039,'type','IND'),
(5040,'type','IND'),
(5041,'type','IND'),
(5042,'type','IIRA'),
(5043,'type','IND'),
(5044,'type','IIRA'),
(5045,'type','IND'),
(5046,'type','IND'),
(5047,'type','IND'),
(5048,'type','IND'),
(5049,'type','IND'),
(5050,'type','IIRA'),
(5051,'type','IND'),
(5052,'type','IND'),
(5053,'type','IND'),
(5054,'type','IND'),
(5055,'type','IND'),
(5056,'type','IND'),
(5057,'type','IND'),
(5058,'type','IIRA'),
(5059,'type','IIRA'),
(5060,'type','IIRA'),
(5061,'type','IND'),
(5062,'type','IND'),
(5063,'type','IIRA'),
(5064,'type','IIRA'),
(5065,'type','IND'),
(5066,'type','IND'),
(5067,'type','IND'),
(5068,'type','IND'),
(5069,'type','IIRA'),
(5070,'type','IND'),
(5071,'type','IND'),
(5072,'type','IND'),
(5073,'type','IND'),
(5074,'type','IND'),
(5075,'type','IND'),
(5076,'type','IND'),
(5077,'type','IND'),
(5078,'type','IIRA'),
(5079,'type','IIRA'),
(5080,'type','IND'),
(5081,'type','IIRA'),
(5082,'type','IND'),
(5083,'type','IND'),
(5084,'type','IIRA'),
(5085,'type','IND'),
(5086,'type','IND'),
(5087,'type','IND'),
(5088,'type','IIRA'),
(5089,'type','IND'),
(5090,'type','IND'),
(5091,'type','IND'),
(5092,'type','IIRA'),
(5093,'type','IIRA'),
(5094,'type','IND'),
(5095,'type','IND'),
(5096,'type','IIRA'),
(5097,'type','IND'),
(5098,'type','IND'),
(5099,'type','IND'),
(5100,'type','IND'),
(5101,'type','IND'),
(5102,'type','IND'),
(5103,'type','IND'),
(5104,'type','IIRA'),
(5105,'type','IND'),
(5106,'type','IIRA'),
(5107,'type','IIRA'),
(5108,'type','IIRA'),
(5109,'type','IIRA'),
(5110,'type','IND'),
(5111,'type','IND'),
(5112,'type','IND'),
(5113,'type','IND'),
(5114,'type','IND'),
(5115,'type','IND'),
(5116,'type','IND'),
(5117,'type','IND'),
(5118,'type','IND'),
(5119,'type','IND'),
(5120,'type','IND'),
(5121,'type','IND'),
(5122,'type','IND'),
(5123,'type','IND'),
(5124,'type','IND'),
(5125,'type','IND'),
(5126,'type','IND'),
(5127,'type','IND'),
(5128,'type','IIRA'),
(5129,'type','IND'),
(5130,'type','IND'),
(5131,'type','IND'),
(5132,'type','IND'),
(5133,'type','IND'),
(5134,'type','IND'),
(5135,'type','IND'),
(5136,'type','IIRA'),
(5137,'type','IND'),
(5138,'type','IND'),
(5139,'type','IIRA'),
(5140,'type','IND'),
(5141,'type','IIRA'),
(5142,'type','IND'),
(5143,'type','IIRA'),
(5144,'type','IND'),
(5145,'type','IND'),
(5146,'type','IND'),
(5147,'type','IND'),
(5148,'type','IND'),
(5149,'type','IIRA'),
(5150,'type','IND'),
(5151,'type','IND'),
(5152,'type','IND'),
(5153,'type','IIRA'),
(5154,'type','IND'),
(5155,'type','IIRA'),
(5156,'type','IND'),
(5157,'type','IIRA'),
(5158,'type','IND'),
(5159,'type','IND'),
(5160,'type','IIRA'),
(5161,'type','IND'),
(5162,'type','IND'),
(5163,'type','IND'),
(5164,'type','IND'),
(5165,'type','IND'),
(5166,'type','IND'),
(5167,'type','IND'),
(5168,'type','IND'),
(5169,'type','IND'),
(5170,'type','IND'),
(5171,'type','IIRA'),
(5172,'type','IIRA'),
(5173,'type','IND'),
(5174,'type','IND'),
(5175,'type','IIRA'),
(5176,'type','IND'),
(5177,'type','IND'),
(5178,'type','IIRA'),
(5179,'type','IND'),
(5180,'type','IND'),
(5181,'type','IIRA'),
(5182,'type','IIRA'),
(5183,'type','IIRA'),
(5184,'type','IIRA'),
(5185,'type','IND'),
(5186,'type','IIRA'),
(5187,'type','IND'),
(5188,'type','IND'),
(5189,'type','IND'),
(5190,'type','IIRA'),
(5191,'type','IIRA'),
(5192,'type','IND'),
(5193,'type','IND'),
(5194,'type','IND'),
(5195,'type','IND'),
(5196,'type','IND'),
(5197,'type','IND'),
(5198,'type','IND'),
(5199,'type','IND'),
(5200,'type','IND'),
(5201,'type','IND'),
(5202,'type','IND'),
(5203,'type','IND'),
(5204,'type','IND'),
(5205,'type','IND'),
(5206,'type','IIRA'),
(5207,'type','IIRA'),
(5208,'type','IIRA'),
(5209,'type','IND'),
(5210,'type','IND'),
(5211,'type','IIRA'),
(5212,'type','IND'),
(5213,'type','IND'),
(5214,'type','IIRA'),
(5215,'type','IIRA'),
(5216,'type','IIRA'),
(5217,'type','IND'),
(5218,'type','IIRA'),
(5219,'type','IND'),
(5220,'type','IND'),
(5221,'type','IND'),
(5222,'type','IND'),
(5223,'type','IND'),
(5224,'type','IND'),
(5225,'type','IND'),
(5226,'type','IND'),
(5227,'type','IND'),
(5228,'type','IND'),
(5229,'type','IND'),
(5230,'type','IND'),
(5231,'type','IND'),
(5232,'type','IIRA'),
(5233,'type','IND'),
(5234,'type','IND'),
(5235,'type','IND'),
(5236,'type','IIRA'),
(5237,'type','IND'),
(5238,'type','IND'),
(5239,'type','IIRA'),
(5240,'type','IND'),
(5241,'type','IND'),
(5242,'type','IND'),
(5243,'type','IND'),
(5244,'type','IIRA'),
(5245,'type','IND'),
(5246,'type','IND'),
(5247,'type','IIRA'),
(5248,'type','IND'),
(5249,'type','IND'),
(5250,'type','IND'),
(5251,'type','IND'),
(5252,'type','IIRA'),
(5253,'type','IIRA'),
(5254,'type','IND'),
(5255,'type','IND'),
(5256,'type','IND'),
(5257,'type','IIRA'),
(5258,'type','IIRA'),
(5259,'type','IND'),
(5260,'type','IND'),
(5261,'type','IND'),
(5262,'type','IIRA'),
(5263,'type','IND'),
(5264,'type','IND'),
(5265,'type','IND'),
(5266,'type','IND'),
(5267,'type','IND'),
(5268,'type','IIRA'),
(5269,'type','IND'),
(5270,'type','IIRA'),
(5271,'type','IND'),
(5272,'type','IND'),
(5273,'type','IND'),
(5274,'type','IIRA'),
(5275,'type','IND'),
(5276,'type','IND'),
(5277,'type','IND'),
(5278,'type','IND'),
(5279,'type','IND'),
(5280,'type','IIRA'),
(5281,'type','IND'),
(5282,'type','IIRA'),
(5283,'type','IND'),
(5284,'type','IIRA'),
(5285,'type','IND'),
(5286,'type','IND'),
(5287,'type','IIRA'),
(5288,'type','IND'),
(5289,'type','IND'),
(5290,'type','IND'),
(5291,'type','IIRA'),
(5292,'type','IIRA'),
(5293,'type','IIRA'),
(5294,'type','IND'),
(5295,'type','IND'),
(5296,'type','IIRA'),
(5297,'type','IND'),
(5298,'type','IND'),
(5299,'type','IIRA'),
(5300,'type','IND'),
(5301,'type','IND'),
(5302,'type','IND'),
(5303,'type','IND'),
(5304,'type','IIRA'),
(5305,'type','IIRA'),
(5306,'type','IIRA'),
(5307,'type','IIRA'),
(5308,'type','IND'),
(5309,'type','IND'),
(5310,'type','IND'),
(5311,'type','IND'),
(5312,'type','IIRA'),
(5313,'type','IND'),
(5314,'type','IND'),
(5315,'type','IIRA'),
(5316,'type','IND'),
(5317,'type','IND'),
(5318,'type','IND'),
(5319,'type','IND'),
(5320,'type','IND'),
(5321,'type','IND'),
(5322,'type','IND'),
(5323,'type','IND'),
(5324,'type','IND'),
(5325,'type','IND'),
(5326,'type','IIRA'),
(5327,'type','IND'),
(5328,'type','IND'),
(5329,'type','IND'),
(5330,'type','IIRA'),
(5331,'type','IND'),
(5332,'type','IND'),
(5333,'type','IND'),
(5334,'type','IND'),
(5335,'type','IND'),
(5336,'type','IND'),
(5337,'type','IND'),
(5338,'type','IND'),
(5339,'type','IND'),
(5340,'type','IND'),
(5341,'type','IND'),
(5342,'type','IND'),
(5343,'type','IIRA'),
(5344,'type','IIRA'),
(5345,'type','IND'),
(5346,'type','IIRA'),
(5347,'type','IND'),
(5348,'type','IIRA'),
(5349,'type','IND'),
(5350,'type','RF'),
(5351,'type','RF'),
(5352,'type','RF'),
(5353,'type','RF'),
(5354,'type','RF'),
(5355,'type','RF'),
(5356,'type','RF'),
(5357,'type','RF'),
(5358,'type','RF'),
(5359,'type','RF'),
(5360,'type','RF'),
(5361,'type','RF'),
(5362,'type','RF'),
(5363,'type','RF'),
(5364,'type','RF'),
(5365,'type','RF'),
(5366,'type','RF'),
(5367,'type','RF'),
(5368,'type','RF'),
(5369,'type','RF'),
(5370,'type','RF'),
(5371,'type','RF'),
(5372,'type','RF'),
(5373,'type','RF'),
(5374,'type','RF'),
(5375,'type','RF'),
(5376,'type','RF'),
(5377,'type','RF'),
(5378,'type','RF'),
(5379,'type','RF'),
(5380,'type','RF'),
(5381,'type','RF'),
(5382,'type','RF'),
(5383,'type','RF'),
(5384,'type','RF'),
(5385,'type','RF'),
(5386,'type','RF'),
(5387,'type','RF'),
(5388,'type','RF'),
(5389,'type','RF'),
(5390,'type','RF'),
(5391,'type','RF'),
(5392,'type','RF'),
(5393,'type','RF'),
(5394,'type','RF'),
(5395,'type','RF'),
(5396,'type','RF'),
(5397,'type','RF'),
(5398,'type','RF'),
(5399,'type','RF');


-- person exhibits activity

-- UserID,ActivityID,Timestamp
INSERT INTO public.edge (source, target, label) VALUES
(194,5000,'exhibits'),
(152,5001,'exhibits'),
(196,5002,'exhibits'),
(120,5003,'exhibits'),
(178,5004,'exhibits'),
(169,5005,'exhibits'),
(110,5006,'exhibits'),
(136,5007,'exhibits'),
(134,5008,'exhibits'),
(196,5009,'exhibits'),
(183,5010,'exhibits'),
(140,5011,'exhibits'),
(142,5012,'exhibits'),
(102,5013,'exhibits'),
(128,5014,'exhibits'),
(194,5015,'exhibits'),
(158,5016,'exhibits'),
(135,5017,'exhibits'),
(158,5018,'exhibits'),
(189,5019,'exhibits'),
(186,5020,'exhibits'),
(120,5021,'exhibits'),
(196,5022,'exhibits'),
(179,5023,'exhibits'),
(107,5024,'exhibits'),
(145,5025,'exhibits'),
(192,5026,'exhibits'),
(104,5027,'exhibits'),
(183,5028,'exhibits'),
(157,5029,'exhibits'),
(119,5030,'exhibits'),
(137,5031,'exhibits'),
(164,5032,'exhibits'),
(180,5033,'exhibits'),
(115,5034,'exhibits'),
(175,5035,'exhibits'),
(110,5037,'exhibits'),
(142,5038,'exhibits'),
(159,5039,'exhibits'),
(102,5040,'exhibits'),
(165,5041,'exhibits'),
(121,5042,'exhibits'),
(151,5043,'exhibits'),
(144,5044,'exhibits'),
(145,5045,'exhibits'),
(193,5046,'exhibits'),
(138,5047,'exhibits'),
(157,5048,'exhibits'),
(112,5049,'exhibits'),
(140,5051,'exhibits'),
(166,5052,'exhibits'),
(115,5053,'exhibits'),
(130,5054,'exhibits'),
(140,5056,'exhibits'),
(130,5057,'exhibits'),
(148,5058,'exhibits'),
(150,5059,'exhibits'),
(141,5060,'exhibits'),
(132,5061,'exhibits'),
(158,5062,'exhibits'),
(168,5063,'exhibits'),
(144,5065,'exhibits'),
(126,5066,'exhibits'),
(125,5067,'exhibits'),
(154,5068,'exhibits'),
(163,5070,'exhibits'),
(175,5071,'exhibits'),
(147,5073,'exhibits'),
(121,5074,'exhibits'),
(146,5075,'exhibits'),
(122,5076,'exhibits'),
(114,5078,'exhibits'),
(157,5079,'exhibits'),
(145,5080,'exhibits'),
(134,5081,'exhibits'),
(105,5082,'exhibits'),
(118,5083,'exhibits'),
(179,5084,'exhibits'),
(174,5085,'exhibits'),
(175,5086,'exhibits'),
(153,5087,'exhibits'),
(180,5088,'exhibits'),
(161,5089,'exhibits'),
(183,5091,'exhibits'),
(108,5093,'exhibits'),
(184,5094,'exhibits'),
(160,5095,'exhibits'),
(113,5096,'exhibits'),
(166,5097,'exhibits'),
(112,5098,'exhibits'),
(114,5099,'exhibits'),
(121,5100,'exhibits'),
(104,5101,'exhibits'),
(149,5102,'exhibits'),
(153,5103,'exhibits'),
(178,5104,'exhibits'),
(100,5105,'exhibits'),
(181,5106,'exhibits'),
(117,5107,'exhibits'),
(109,5108,'exhibits'),
(133,5109,'exhibits'),
(194,5110,'exhibits'),
(173,5112,'exhibits'),
(190,5113,'exhibits'),
(193,5115,'exhibits'),
(129,5116,'exhibits'),
(138,5118,'exhibits'),
(169,5120,'exhibits'),
(146,5121,'exhibits'),
(150,5122,'exhibits'),
(127,5123,'exhibits'),
(151,5124,'exhibits'),
(101,5125,'exhibits'),
(133,5126,'exhibits'),
(117,5127,'exhibits'),
(171,5128,'exhibits'),
(176,5129,'exhibits'),
(127,5130,'exhibits'),
(163,5131,'exhibits'),
(102,5133,'exhibits'),
(167,5134,'exhibits'),
(110,5136,'exhibits'),
(168,5140,'exhibits'),
(128,5141,'exhibits'),
(175,5142,'exhibits'),
(188,5143,'exhibits'),
(135,5145,'exhibits'),
(167,5146,'exhibits'),
(105,5147,'exhibits'),
(123,5149,'exhibits'),
(152,5152,'exhibits'),
(151,5154,'exhibits'),
(176,5155,'exhibits'),
(116,5156,'exhibits'),
(146,5157,'exhibits'),
(147,5158,'exhibits'),
(107,5159,'exhibits'),
(100,5160,'exhibits'),
(170,5162,'exhibits'),
(176,5163,'exhibits'),
(157,5168,'exhibits'),
(116,5169,'exhibits'),
(181,5170,'exhibits'),
(170,5171,'exhibits'),
(149,5173,'exhibits'),
(152,5176,'exhibits'),
(133,5177,'exhibits'),
(135,5178,'exhibits'),
(126,5179,'exhibits'),
(174,5180,'exhibits'),
(143,5185,'exhibits'),
(195,5186,'exhibits'),
(178,5188,'exhibits'),
(111,5190,'exhibits'),
(126,5191,'exhibits'),
(140,5192,'exhibits'),
(129,5193,'exhibits'),
(172,5194,'exhibits'),
(187,5195,'exhibits'),
(172,5199,'exhibits'),
(108,5200,'exhibits'),
(162,5201,'exhibits'),
(114,5203,'exhibits'),
(134,5204,'exhibits'),
(167,5207,'exhibits'),
(199,5208,'exhibits'),
(148,5209,'exhibits'),
(136,5212,'exhibits'),
(126,5213,'exhibits'),
(192,5216,'exhibits'),
(182,5217,'exhibits'),
(187,5218,'exhibits'),
(188,5220,'exhibits'),
(170,5221,'exhibits'),
(119,5227,'exhibits'),
(105,5229,'exhibits'),
(181,5230,'exhibits'),
(192,5233,'exhibits'),
(156,5234,'exhibits'),
(164,5235,'exhibits'),
(127,5237,'exhibits'),
(191,5238,'exhibits'),
(104,5239,'exhibits'),
(178,5243,'exhibits'),
(124,5248,'exhibits'),
(136,5249,'exhibits'),
(188,5251,'exhibits'),
(183,5252,'exhibits'),
(116,5254,'exhibits'),
(198,5258,'exhibits'),
(149,5259,'exhibits'),
(122,5260,'exhibits'),
(190,5261,'exhibits'),
(118,5262,'exhibits'),
(106,5265,'exhibits'),
(130,5266,'exhibits'),
(113,5267,'exhibits'),
(162,5270,'exhibits'),
(171,5272,'exhibits'),
(136,5274,'exhibits'),
(112,5275,'exhibits'),
(156,5276,'exhibits'),
(164,5277,'exhibits'),
(198,5278,'exhibits'),
(138,5280,'exhibits'),
(147,5283,'exhibits'),
(101,5284,'exhibits'),
(113,5285,'exhibits'),
(115,5286,'exhibits'),
(116,5287,'exhibits'),
(197,5292,'exhibits'),
(118,5294,'exhibits'),
(191,5299,'exhibits'),
(179,5300,'exhibits'),
(191,5301,'exhibits'),
(119,5302,'exhibits'),
(124,5304,'exhibits'),
(154,5308,'exhibits'),
(130,5312,'exhibits'),
(163,5314,'exhibits'),
(177,5321,'exhibits'),
(128,5322,'exhibits'),
(197,5323,'exhibits'),
(139,5324,'exhibits'),
(160,5325,'exhibits'),
(135,5328,'exhibits'),
(152,5330,'exhibits'),
(166,5331,'exhibits'),
(174,5333,'exhibits'),
(169,5334,'exhibits'),
(190,5336,'exhibits'),
(123,5338,'exhibits'),
(199,5339,'exhibits'),
(128,5341,'exhibits'),
(189,5343,'exhibits'),
(134,5345,'exhibits'),
(137,5347,'exhibits'),
(136,5350,'exhibits'),
(185,5351,'exhibits'),
(157,5352,'exhibits'),
(165,5353,'exhibits'),
(167,5354,'exhibits'),
(138,5355,'exhibits'),
(169,5356,'exhibits'),
(157,5357,'exhibits'),
(106,5358,'exhibits'),
(197,5359,'exhibits'),
(174,5361,'exhibits'),
(152,5362,'exhibits'),
(112,5363,'exhibits'),
(176,5364,'exhibits'),
(158,5365,'exhibits'),
(192,5367,'exhibits'),
(105,5368,'exhibits'),
(161,5369,'exhibits'),
(179,5370,'exhibits'),
(173,5371,'exhibits'),
(132,5373,'exhibits'),
(129,5374,'exhibits'),
(127,5375,'exhibits'),
(131,5376,'exhibits'),
(120,5377,'exhibits'),
(193,5378,'exhibits'),
(139,5379,'exhibits'),
(103,5380,'exhibits'),
(142,5382,'exhibits'),
(182,5383,'exhibits'),
(142,5384,'exhibits'),
(160,5385,'exhibits'),
(186,5387,'exhibits'),
(136,5389,'exhibits'),
(188,5390,'exhibits'),
(121,5391,'exhibits'),
(183,5392,'exhibits'),
(166,5394,'exhibits'),
(104,5395,'exhibits'),
(145,5396,'exhibits'),
(198,5397,'exhibits'),
(146,5398,'exhibits'),
(156,5399,'exhibits');