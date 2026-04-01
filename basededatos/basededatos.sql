-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 31-03-2026 a las 21:55:35
-- Versión del servidor: 8.0.45-cll-lve
-- Versión de PHP: 8.4.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `servidat_devtaller`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `id` int UNSIGNED NOT NULL,
  `nombre` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo_documento` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `num_documento` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `direccion` varchar(70) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telefono` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `condicion` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`id`, `nombre`, `tipo_documento`, `num_documento`, `direccion`, `telefono`, `email`, `condicion`, `created_at`, `updated_at`) VALUES
(1, 'cristian', 'DNI', '123456', 'limaq', '22222', 'demo@gmail.com', 1, NULL, NULL),
(2, 'Ariana dominguez', 'DNI', '35478989', 'lima', '1344', 'demo@gmail.com', 1, NULL, NULL),
(3, 'wilfredo', 'DNI', '45800077', 'lima los olivos', '93566789', 'demo@gmail.com', 1, NULL, NULL),
(4, 'Roxana molinas', 'DNI', '4555144', 'lima los olivos', '123456', 'demo@hotmail.com', 1, NULL, NULL),
(5, 'thiago romero', 'DNI', '23443543', 'lima los olivos', '3233', 'demo@gmail.com', 1, NULL, NULL),
(6, 'JEANETTE RODRIGUEZ', 'DNI', '12.690.380-4', 'SEVIL,LA0560', '966028364', 'servidata.cl@gmail.com', 1, NULL, NULL),
(7, 'Cristian Alcaman', 'DNI', '15.626.422-9', 'Campanario 2439 Villa La Encino', '956796003', 'crialcaman@gmail.com', 1, NULL, NULL),
(8, 'Bernardo Salazar Sanhueza', 'DNI', '7.371.474-5', 'Camelias Baja Parcela 8 Los Angeles', '951752316', 'info.besal@gmail.com', 1, NULL, NULL),
(9, 'annette laier', 'DNI', '14.658.853-0', 'los carreras 237', '90427905', 'servidataventas@gmail.com', 1, NULL, NULL),
(10, 'Manuel Gonzales', 'DNI', '9.162.411-7', 'Los carrera 624', '954616457', 'servidataventas@gmail.com', 1, NULL, NULL),
(11, 'belen escobar', 'DNI', '190524140', 'madrid 1266', '931247884', 'servidataventas@gmail.com', 1, NULL, NULL),
(12, 'PRISCILLA ZUÑIGA', 'DNI', '15.205.277-4', 'CAMINO CERRO COLORADO SIN NUMERO', '998934126', 'servidataventas@gmail.com', 1, NULL, NULL),
(13, 'Daniela Gajardo', 'DNI', '17.982.049-8', 'Av De la Trinidad 1306', '9 40071601', 'danigalagos@gmail.com', 1, NULL, NULL),
(15, 'yleey fuentes', 'DNI', '21.552.360-8', 'pasaje 11 oriente 2424', '995274769', 'servidataventas@gmail.com', 1, NULL, NULL),
(16, 'ariel  maldonado', 'DNI', '15.191.397-0', 'avenida julio 1073', '975905715', 'servidataventas@gmail.com', 1, NULL, NULL),
(17, 'Rodrigo Ortega', 'DNI', '13.109.525-2', 'Ernesto Stark 510', '956323933', 'rodortega21@gmail.com', 1, NULL, NULL),
(18, 'ERIKA MEZA', 'DNI', '12326982-9', 'LA DEHESA DE MONCALLO 221', '992978320', 'academia.erica.meza@gmail.com', 1, NULL, NULL),
(19, 'Delfina Fuentes', 'DNI', '9.276.332-3', 'Sevilla 0689', '978873123', 'delfinafuentes0@gmail.com', 1, NULL, NULL),
(20, 'ivan augsburger', 'DNI', '8.321.180-6', 'villa linares el mirador 143', '999196142', 'servidataventas@gmail.com', 1, NULL, NULL),
(21, 'sebastian zapata', 'DNI', '19.717.653-9', 'condominio plaza san marco parcela b4', '977140095', 'servidataventas@gmail.com', 1, NULL, NULL),
(22, 'Patricia Sepulveda', 'DNI', '9.815.512-0', 'Casa Reposo Jardin de San Juan', '985319891', 'cr.jardindesanjuan@gmail.com', 1, NULL, NULL),
(23, 'jonatan ramo', 'DNI', '20.023.043-4', 'pasaje profesor rodolfo rebolledo', '950074318', 'servidataventas@gmail.com', 1, NULL, NULL),
(24, 'MANUEL ACEVEDO', 'DNI', '20.255.847-3', 'VICENTE BLASCO 801 VILLA ESPAÑA', '967059489', 'acvmanuel25@gmail.com', 1, NULL, NULL),
(25, 'domingo  aliante', 'DNI', '12.743.345-3', 'el bosque 658', '985014056', 'servidataventas@gmail.com', 1, NULL, NULL),
(26, 'DARWIN PARDO', 'DNI', '20.115.393-K', 'JORGE INOSTROZA  195 ESCRITORES DE CHILE', '949364979', 'darwinpardo98@gmail.com', 1, NULL, NULL),
(27, 'KATHERINE ARIAS', 'DNI', '13.386.738-4', 'AVENIDA LAS INDUSTRIAS PARCELA EL MAITEN', '997524149', 'katita_arias@yahoo.es', 1, NULL, NULL),
(28, 'patricio  armijo', 'DNI', '13.772.178-3', 'pamplona 0570', '930548451', 'servidataventas@gmail.com', 1, NULL, NULL),
(29, 'luis valderrama contreras', 'DNI', '9.307.811-k', 'marconi 686', '986071702', 'servidataventas@gmail.com', 1, NULL, NULL),
(30, 'angelica monsalve', 'DNI', '12.983.810-8', 'parcela 1 lote 15 camino santa clara', '940036062', 'servidataventas@gmail.com', 1, NULL, NULL),
(31, 'Roberto Castillo', 'DNI', '7.144.111-3', 'Velmencura 22 Hacienda Las Cruces Los Angeles', '994995233', 'rkastiyo@gmail.com', 1, NULL, NULL),
(32, 'Ignacio Roble', 'DNI', '8.942.486-0', 'Las vetanadas 104 Mirador De Los Andes', '998740710', 'ignarobles@gmail.com', 1, NULL, NULL),
(33, 'Romanet Zuñiga', 'DNI', '12.030.271-k', 'av. Oriente 1272 villa españa', '966528159', 'rzl_mane@hotmail.com', 1, NULL, NULL),
(34, 'SEBASTIAN CONTRERAS', 'DNI', '18.804.422-0', 'TOLOUSE 1360', '983115882', 'scontrerasceballo@gmail.com', 1, NULL, NULL),
(35, 'NAYARETH SUFAN', 'DNI', '18.292.280-3', 'AVENIDA DE LA TRINIDAD 930', '939426910', 'nayaretsufan@gmail.com', 1, NULL, NULL),
(36, 'davids mitmans', 'DNI', '10.668.232-1', 'pasaje monet 119 villa sor vicenta 2', '978407217', NULL, 1, NULL, NULL),
(37, 'Pedro Nuñez', 'DNI', '15.953.583-5', 'Manuel Rioseco 400', '993329113', 'pedroandresabogado@gmail.com', 1, NULL, NULL),
(38, 'Sofia Villarroel Pulgar', 'DNI', '17.400.227-4', 'Av. Almirante La Torre 0840', '94758279', 'tm.sofiavillarroel@gmail.com', 1, NULL, NULL),
(39, 'Gilda Herrera Valdebenito', 'DNI', '13.843.101-0', 'Napoles 1319 Villa Italia', '936938824', 'guildajhv@gmail.com', 1, NULL, NULL),
(40, 'Jackeline Rodriguez', 'DNI', '11.111.111-1', 'Napoles con roma 1307', '920196243', 'servidataventas@gmail.com', 1, NULL, NULL),
(41, 'Ariel Ortega', 'DNI', '15.159.134-5', 'Corralco 812 Parque Sor Vicenta 2', '987255341', 'arielortega.geomensura@gmail.com', 1, NULL, NULL),
(42, 'CONSTANZA SANTANA', 'DNI', NULL, 'BULNES  220 EDIFICIO PUERTO MAYOR 2 PISO 8 OF. 813', '982944413', 'constanzasantanam@gmail.com', 1, NULL, NULL),
(43, 'Exequiel Hernandez', 'DNI', '19.050.085-3', 'Segovia 1257', '979420570', 'exequielhernandez183@gmail.com', 1, NULL, NULL),
(44, 'VICENTE PESOA', 'DNI', '21.369.851-6', 'HIJUELA SANTA GERTRUDIS SIN NUMERO', '944627590', NULL, 1, NULL, NULL),
(45, 'Gonzalo Galvez', 'DNI', '16.214.871-0', 'Roma 0627', '973962554', 'gonzalopatricio85@gmail.com', 1, NULL, NULL),
(46, 'Jorge Cabezas', 'DNI', '14.069.589-0', 'Villagran 1210', '950245289', 'Fl3cabezas.jfcy@gmail.com', 1, NULL, NULL),
(47, 'Julio Nuñez', 'DNI', '14.553.363-5', 'Pasaje la coruña 0595', '998876690', 'julionunez.an@gmail.com', 1, NULL, NULL),
(48, 'Magdely Valenzuela', 'DNI', '19.716.465-4', 'Camino Santa Clara km 2.5 Sector El Natre', '938784785', 'servidataventas@gmail.com', 1, NULL, NULL),
(49, 'Debora Ortega', 'DNI', '16.982.679-k', 'Km 5.5 camino santa barbara', '939533233', 'debora.copahue.reserva@gmail.com', 1, NULL, NULL),
(50, 'FELIPE LILLO GALVEZ', 'DNI', '19.039.030-6', 'PARCELA STA. BEATRIZ  SALTOS DEL LAJA', '949121633', 'h.lillog96@gmail.com', 1, NULL, NULL),
(51, 'MARCO ROYO ORTIZ', 'DNI', '10.852.631-9', 'Julet 175 los angeles', '996669330', 'marcoroyo168@gmail.com', 1, NULL, NULL),
(52, 'Erick Fritz', 'DNI', '10.102.639-6', 'Aguasanta 2513', '940115989', 'efritzvalencia@gmail.com', 1, NULL, NULL),
(53, 'martin cuevas soto', 'DNI', '22.409.904-5', 'lauca 0605', '968122342', NULL, 1, NULL, NULL),
(54, 'Camila Garrido', 'DNI', '19.600.233-2', 'Manuel Montt 158', '9 94132927', 'camila3garridoalveal@gmail.com', 1, NULL, NULL),
(55, 'Marcelo Henrriquez Ciappa', 'DNI', '12.721.342-9', 'Parcela Isla del Guindo Sin Numero Santa Cruz', '+56 999387133', 'marcelociappa04@gmail.com', 1, NULL, NULL),
(56, 'benjamin morales', 'DNI', '20.114.512-0', 'pasaje allipen sur 354', '953922917', NULL, 1, NULL, NULL),
(57, 'Rozana pedrasa', 'DNI', '13.800.738-3', 'avenida las industria kilometro 502', '90947107', 'roxanapedrasae@gmail.com', 1, NULL, NULL),
(58, 'Sabina Baldevenito', 'DNI', '9.565.535-1', 'Turin 1360 Villa Italia', '966051678', 'sanhuezacarla1985@gmail.com', 1, NULL, NULL),
(59, 'daniel hargaus garcia', 'DNI', '21.610491-9', 'sevilla  0677', '944332652', NULL, 1, NULL, NULL),
(60, 'PATRICIO MOREIRA', 'DNI', '10.160.900-6', 'LAGUNA VERDE 540 CONDOMINIO NORTE CASA 43', '942265118', 'CHICO.MOREIRA66@GMAIL.COM', 1, NULL, NULL),
(61, 'KATHERINE GOMEZ', 'DNI', '18.344.560-K', 'VILLAGRAN 1398', '959952342', 'katherinegomeztroncoso@8gmail.com', 1, NULL, NULL),
(62, 'danny sandoval', 'DNI', '18.099.236-7', 'los caquis 164 villa las quintas', '952197898', NULL, 1, NULL, NULL),
(112, 'ALFREDO ARIEL GODOY MUÑOZ', 'DNI', '9.041.401-1', 'SEVILLA 0677', '92277018', NULL, 1, NULL, NULL),
(113, 'Loreto Salas', 'DNI', '16.063.429-4', 'Los aimaraes 1071', '978894616', 'marambio.loreto@gmail.com', 1, NULL, NULL),
(114, 'Mario Diaz', 'DNI', '9.495.673-0', 'Madrid 1270', '996792538', 'fabiagustindiazmorales@gmail.com', 1, NULL, NULL),
(115, 'edgardo  frias', 'DNI', '9.044.814-5', 'lauca 0565', '984181058', NULL, 1, NULL, NULL),
(116, 'juan carlos letelier', 'DNI', '9.705.731-1', 'pasaje miravalle 4617 puente alto', '994331928', NULL, 1, NULL, NULL),
(117, 'Jose Morillo', 'DNI', '25.691.471-9', 'Alcazar 369', '979915310', 'josemb720@gmail.com', 1, NULL, NULL),
(118, 'Catherine Cifuentes', 'DNI', '16.329.011-1', 'Corralco 812', '978603069', 'catherine.cifuentes@gmail.com', 1, NULL, NULL),
(119, 'Andrea Condeza', 'DNI', '16.673.137-2', 'Valladolid 1353', '985956870', 'andrecondeza@gmail.com', 1, NULL, NULL),
(120, 'ANGELA FERREIRA', 'DNI', '16.396.346-9', 'De la compañia 118', '962469640', 'angelaferreira@unpade.com', 1, NULL, NULL),
(121, 'eduardo  navarrete', 'DNI', '11.962.087-2', 'parcelas 232 los claveles el huerton', '998376903', 'ednavarro@gmail.com', 1, NULL, NULL),
(122, 'gaston cortes', 'DNI', '13.844.381-7', 'cascada rio paine 259', '998177890', NULL, 1, NULL, NULL),
(123, 'Cindy Valdebenito', 'DNI', '19.944.031-4', 'Pasaje Brasilia 897', '994185914', 'cvaldebenit2017@gmail.com', 1, NULL, NULL),
(124, 'Patricia Colima', 'DNI', '8.748.694-k', 'Villa Italia Bolonia con roma 1341', '981999829', 'servidataventas@gmail.com', 1, NULL, NULL),
(125, 'delegacion presidencial del bio bio', 'DNI', '60.511.084-4', 'caupolican 410', '988478166', 'blanca.amo.g@gmail.com', 1, NULL, NULL),
(126, 'paulina muñoz', 'DNI', '19.390.602-8', 'manuel rodriguez 245', '9 58497603', 'paulina.97yasmin@gmail.com', 1, NULL, NULL),
(127, 'Luis rivas', 'DNI', '12.191.779-3', 'quinta el manzano parcela 26', '984793229', NULL, 1, NULL, NULL),
(128, 'Catalina Pinilla', 'DNI', '23.081.380-9', 'nahuelbuta 885', '9 66500995', 'chpinillaf@gyahoo.es', 1, NULL, NULL),
(129, 'Cristian Garcia', 'DNI', '20.323.840-1', 'Camino cerro colorado km 1.1', '952153683', NULL, 1, NULL, NULL),
(130, 'Evelin Bustos', 'DNI', '15.194.741-7', 'Valladolid 1148', '977855010', 'evelin.bustos55@gmail.com', 1, NULL, NULL),
(131, 'carolina Quezada', 'DNI', '17.216.608-3', 'quinta los barones kl1 camino cerro colorado', '959509558', 'Karito_andy22@hotmail.com', 1, NULL, NULL),
(132, 'Juan Viveros', 'DNI', '15.628.369-k', 'Pasaje 1 sur 790 Parque Lauquen', '973385017', 'juan.viveros.transviveros@transviveros.cl', 1, NULL, NULL),
(133, 'Ricardo Suarez', 'DNI', '9.899.658-3', 'Sector Lo Nieve Santa Barbara', '992499683', 'ozosrs@gmail.com', 1, NULL, NULL),
(134, 'hector navarrete', 'DNI', '14.298.799-6', 'pasaje lerida 0657 villa españa', '989805191', NULL, 1, NULL, NULL),
(135, 'ESTEBAN RIQUELME', 'DNI', '15.205.135-2', 'LLANO BLANCO 351 VILLA 3 VIENTOS', '91990969', NULL, 1, NULL, NULL),
(136, 'osvaldo olivares', 'DNI', '12.327.387-7', 'calle atenea 1510 villa gracias', '987226138', NULL, 1, NULL, NULL),
(137, 'Oscar  pieringer', 'DNI', '14.471.246-3', 'avenida nahuelbuta 1200', '950004577', NULL, 1, NULL, NULL),
(138, 'Andrea Torres', 'DNI', '17.592.141-9', 'Las cruces 752', '975732081', 'andretoriv@gmail.com', 1, NULL, NULL),
(139, 'Carla vignolo', 'DNI', '14.069.733-8', 'colo colo 0615', '956765879', NULL, 1, NULL, NULL),
(140, 'Paulina Suazo', 'DNI', '16.286.728-8', 'Sevilla 0566', '996740121', 'pau.suazoo@gmail.com', 1, NULL, NULL),
(141, 'Carlos Sanzana', 'DNI', '15.195.115-5', 'Quitrahue 2A los angeles', '978765038', 'cspobletesanzana@gmail.com', 1, NULL, NULL),
(142, 'Maria José Rivera Pavez', 'DNI', '18.523.140-2', 'Los Alerces 1422 Villa Santa Fe', '967352547', 'mariajose-rivera@live.com', 1, NULL, NULL),
(143, 'MATIAS NAVAS', 'DNI', '21.975.562-7', 'AVENIDA GABRIELA MUISTRAL  680', '975504881', 'matiasnavas10@gmail.com', 1, NULL, NULL),
(144, 'Rubi Rujano', 'DNI', '27.933.612-7', 'sevilla 0529', '959685037', NULL, 1, NULL, NULL),
(145, 'gisela Barro', 'DNI', '13.790.704-4', 'Condominio laderas de curamonte casa 391', '979883955', NULL, 1, NULL, NULL),
(146, 'Maria veronica figueroa', 'DNI', '7.720.116-5', 'calladolid 1260', '954210912', NULL, 1, NULL, NULL),
(147, 'jose antonio', 'DNI', '8.486.768-k', 'malaga 798', '958368205', 'joseangarridom@gmail.com', 1, NULL, NULL),
(148, 'Claudia Rivera', 'DNI', '16.984.286-8', 'Pasaje Otagua 1 oriente 105', '998360167', 'claudiariveragodoy@gmail.com', 1, NULL, NULL),
(149, 'Luis Hidalgo', 'DNI', '26.556.144-6', 'Alerce andino 1121', '946120285', 'lhidalgorjbm@gmail.com', 1, NULL, NULL),
(150, 'Froilan quezada', 'DNI', '15.215.551-5', 'sevilla 0560', '957869916', 'servidata.cl@gmail.com', 1, NULL, NULL),
(151, 'Sergio Hermosilla', 'DNI', '13.579.290-k', 'Avila 1243', '987276403', 'serrgio.hermozilla@gmail.com', 1, NULL, NULL),
(152, 'Diego maturana', 'DNI', '19.045.922-5', 'doctor pablo murua 240 los angeles', '976090462', NULL, 1, NULL, NULL),
(153, 'luz quezada', 'DNI', '11.962.381-2', 'cataluña 0450 villa españa', '98474729', NULL, 1, NULL, NULL),
(154, 'Daniela Aguilera Acuña', 'DNI', '18.344.823-4', NULL, '973427863', NULL, 1, NULL, NULL),
(155, 'joaquín Reyes', 'DNI', '20.903.953-2', 'costanera quilque norte 994', '952287630', NULL, 1, NULL, NULL),
(156, 'Tihare Neira', 'DNI', '19.369.926-k', 'Murcia 0557 Villa España', '936863921', 'tiahreneira13@gmail.com', 1, NULL, NULL),
(157, 'Fabian Quezada', 'DNI', '21.471.800-6', 'Quinta San Fabian Sector Las Obras Santa Barbara', '964320154', 'garito2912@gmail.com', 1, NULL, NULL),
(158, 'Nicol Ramirez', 'DNI', '18.100.767-2', 'Canta Rana Parcela 10', '973446909', 'nico.andrearj@gmail.com', 1, NULL, NULL),
(159, 'Omar Rivera  Venegas', 'DNI', '9.244.009-5', 'Los araucanos 1050', '921635622', 'or5045912@gmail.com', 1, NULL, NULL),
(160, 'Carmen Gloria De la Cuesta', 'DNI', '12.628.877-8', 'Av. Oriente 785 Casa 467', '993209999', 'cgdelacuesta@yahoo.es', 1, NULL, NULL),
(161, 'Debora Berríos', 'DNI', '18.027.841-9', 'Las Cruces 752', '973983990', 'debora.berrioss@gmail.com', 1, NULL, NULL),
(162, 'Rocio Moreno', 'DNI', '18.524.527-6', 'Malaga 1224', '990770496', 'Rocio.morenob@gmail.com', 1, NULL, NULL),
(163, 'Freddy araya', 'DNI', '12.101.464-5', 'avenida oriente 785', '993594562', 'Frearayach@gmail.com', 1, NULL, NULL),
(164, 'Miguel Saez', 'DNI', '20.384.825-0', 'Frei Jorge 744', '956327555', 'saez09666@gmail.com', 1, NULL, NULL),
(165, 'Devora Ortega', 'DNI', '16.982.679-k', 'k5 camino santa barbara', '939533233', NULL, 1, NULL, NULL),
(166, 'Yenifer Morales', 'DNI', '18.525.258-2', 'Hijuelas las culebras s/n Chacayal Sur', '9337621712', 'yiieni98@gmail.com', 1, NULL, NULL),
(167, 'Alejandra leonelli', 'DNI', '9.504.311-9', 'segovia 1376', '991785827', NULL, 1, NULL, NULL),
(168, 'Pilar Lagos', 'DNI', '13.743.888-7', 'Pasaje Eduardo Bel 104 Villa El Avellano', '977105599', 'pili_lagos@hotmail.com', 1, NULL, NULL),
(169, 'Felipe diaz', 'DNI', '21.169.565-k', 'villa francia pasaje  burdeos', '94888283', 'fd031202@gmail.com', 1, NULL, NULL),
(170, 'Rodolfo Torres', 'DNI', '13.844.048-6', 'Almagro 204 Antuco', '926895592', 'cesartorres.directvantuco@gmail.com', 1, NULL, NULL),
(171, 'Karen Muñoz', 'DNI', '16.204.604-7', 'Carlos Ibañez Del Campo 0540', '978660499', 'ingekaren.munoz@gmail.com', 1, NULL, NULL),
(172, 'geraldine miranda', 'DNI', '172554687', 'villa santa clara', '97475872', NULL, 1, NULL, NULL),
(173, 'astrid kaiser', 'DNI', '15.626.936-6', 'burgos 1246', '989755492', 'astridkaiserv@gmail.com', 1, NULL, NULL),
(174, 'alexis peña', 'DNI', '8.012.169-5', 'doctor pablo neruda 150 el avellano los angeles', '999493550', NULL, 1, NULL, NULL),
(175, 'Matias Diaz', 'DNI', '17.546.562-6', 'Napoles 1330', '993581310', 'matiasdiazlafont@gmail.com', 1, NULL, NULL),
(176, 'Christian Tisi', 'DNI', '15.626.837-2', 'Av. Oriente 1279', '983686612', 'ctisi.la@gmail.com', 1, NULL, NULL),
(177, 'ANDRES SALAZAR', 'DNI', '26.050.879-2', 'MADRID 1290', '933387068', NULL, 1, NULL, NULL),
(178, 'Marcia Obreque', 'DNI', '8.902.112-k', 'Porvenir 2370 Villa Pinares', '999796600', 'marcia.obreque@gmail.com', 1, NULL, NULL),
(179, 'patricio cuevas', 'DNI', '10.862.534-1', 'avenida las industrias 7215', '934180236', NULL, 1, NULL, NULL),
(180, 'Claudia Azagra', 'DNI', '17.216.234-7', 'Aranjuez 0666 villa españa', '988200686', 'clauazagrasobarzo@gmail.com', 1, NULL, NULL),
(181, 'marcela munera', 'DNI', '23.447.675-0', 'madrid 1221', '942078036', NULL, 1, NULL, NULL),
(182, 'Rocio Novoa', 'DNI', '18.524.679-5', 'La frontera 5 185', '990073662', 'rosi.matu93@gmail.com', 1, NULL, NULL),
(183, 'Dany Neira', 'DNI', '14.373.480-3', 'Villa Amatista Pasaje Turquesa Casa 1', '997413299', 'prdanyneira@gmail.com', 1, NULL, NULL),
(184, 'antonela salazar', 'DNI', '11.075.305-5', 'carlo ibañez 050', '934856814', NULL, 1, NULL, NULL),
(185, 'yolanda bascur', 'DNI', '16.988.676-8', 'toledo 0662', '964394118', NULL, 1, NULL, NULL),
(186, 'Cristian Olivares', 'DNI', '13.843.413-3', 'Nestor del Rio 490', '935137972', 'comercialentremix@gmail.com', 1, NULL, NULL),
(187, 'ana sanchez', 'DNI', '7.445.772-k', 'costanera quilque sur 1083', '976095465', NULL, 1, NULL, NULL),
(188, 'Paola Godoy', 'DNI', '14.351.545-1', 'condominio los boldos casa 36', '9843926974', NULL, 1, NULL, NULL),
(189, 'carol herrera', 'DNI', '11.883.965-k', 'jose zavala rios 1200 nacimiento', '948488060', NULL, 1, NULL, NULL),
(190, 'belen acosta', 'DNI', '18.442.520-3', 'valladolid 1345', '986254131', NULL, 1, NULL, NULL),
(191, 'Pedro Sandoval', 'DNI', '8.984.033-3', 'Camino nacimiento km 13', '987680833', 'sin correo', 1, NULL, NULL),
(192, 'CRISTIAN CARRASCO', 'DNI', '13.145.285-3', 'ALMIRANTE LATORRE 0949', '954091556', NULL, 1, NULL, NULL),
(193, 'Guillermo Castro', 'DNI', '11.701.704-4', 'Sevilla 0471', '950036552', 'gmocastro1970@gmail.com', 1, NULL, NULL),
(194, 'maria jose', 'DNI', '15.392.701-4', 'plaza san marco a22', '932111062', NULL, 1, NULL, NULL),
(195, 'Gabriela Dies', 'DNI', '22.071.156-0', 'avenida oriente 785', '931955718', NULL, 1, NULL, NULL),
(196, 'Felipe Ervias', 'DNI', '15.399.416-1', 'av. sor vicenta 2331', '957852575', NULL, 1, NULL, NULL),
(197, 'Juan Carrillo', 'DNI', '11.604.206-1', 'Freire 501', '979772066', 'vetpehuen@hotmail.com', 1, NULL, NULL),
(198, 'Carlos Contreras', 'DNI', '8.927.379-k', 'Calle 102 condominio 1354 casa 40 las princesas concepcion', '9 66872297', 'carlos3131.kvc@gmail.com', 1, NULL, NULL),
(199, 'Oscar atuesta', 'DNI', '24.062.320-k', 'nida oriente 785', '944766680', NULL, 1, NULL, NULL),
(200, 'Diana doves', 'DNI', '24.431.615-8', 'Malaga 1279', '99773999', NULL, 1, NULL, NULL),
(201, 'Lesly Garrido', 'DNI', '16.062.364-0', 'lindulfo padilla 1791', '976919989', NULL, 1, NULL, NULL),
(202, 'LEONARDO PEREZ', 'DNI', '7.625.044-8', 'PASAJE MONTALBAN 793', '977734944', NULL, 1, NULL, NULL),
(203, 'lorena arriagada', 'DNI', '13.144.549-0', 'avenida oriente 635 departamento 1a', '996922967', NULL, 1, NULL, NULL),
(204, 'Mauricio Perez', 'DNI', '9.236.527-1', 'Jardines de Luxemburgo 2450', '978745248', 'm_perezgallardo@hotmail.com', 1, NULL, NULL),
(205, 'Rosario Gonzalez', 'DNI', '8.711.317-5', 'Madrid 1266', '966387265', 'servidataventas@gmail.com', 1, NULL, NULL),
(206, 'jessica becerra', 'DNI', '13.385.781-8', 'parcela 11 lote 1 san gerardo', '936297891', NULL, 1, NULL, NULL),
(207, 'Marco Candia', 'DNI', '14.299.990-0', 'Marsella 2471', '994444395', 'marcocandia1010@gmail.com', 1, NULL, NULL),
(208, 'Elizabeth Yañez', 'DNI', '13.144.862-7', 'Asienda Las Cruces Condomio Los arrayanes 601', '987577644', 'elizabethyanesnovoa18@gmail.com', 1, NULL, NULL),
(209, 'Silvia Arteaga Obreque', 'DNI', '16.009.686-1', 'Camino Sta Barbara KM2,5', '978742292', NULL, 1, NULL, NULL),
(210, 'Barbara Oettinger', 'DNI', '16.768.308-8', 'Av. Alemana 1550', '950119127', NULL, 1, NULL, NULL),
(211, 'Claudia Zapata Sanhueza', 'DNI', '15.212.657-3', 'Las Cruces 701 Casa 7', '977545111', NULL, 1, NULL, NULL),
(212, 'evelyn quezada', 'DNI', '14.070.073-8', 'pasaje las arenarias 819', '978740411', NULL, 1, NULL, NULL),
(213, 'Arcel Lavin Duran', 'DNI', '15.627.365-1', 'Camino Las Trancas Callejon san antonio pasaje 38A', '952141775', 'arcelavin@hotmail.com', 1, NULL, NULL),
(214, 'Camilo Orellana', 'DNI', '19.854.782-4', 'Libertad 780', '9 4009 7648', NULL, 1, NULL, NULL),
(215, 'Gustavo Navarrete', 'DNI', '13.145.265-9', 'Valdivia 300 oficina 906', '952176008', NULL, 1, NULL, NULL),
(216, 'claudia sandoval', 'DNI', '18.101.954-9', 'lincoyan 360', '961025215', NULL, 1, NULL, NULL),
(217, 'ricardo herrera', 'DNI', '6.001.114-1', 'kilometro 2,5 camino santa clara', '954225913', NULL, 1, NULL, NULL),
(218, 'Dinelly Decap', 'DNI', '14.069.635-8', 'Camino cerro colorado 56 el porvenir 2', '994857110', NULL, 1, NULL, NULL),
(219, 'barbara uribe', 'DNI', '21.169.564-1', 'la providencia 333 villa galilea', '934460331', NULL, 1, NULL, NULL),
(220, 'Claudio Romero', 'DNI', '12.632.607-6', 'avenida sor vicenta 2276 casa 150', '995994278', NULL, 1, NULL, NULL),
(221, 'teresa orellana', 'DNI', '14.374.893-6', 'los terrones 308 parque sor vicenta', '977648211', NULL, 1, NULL, NULL),
(222, 'Patricia Troncoso', 'DNI', '12.327.488-1', 'Lauca 0659', '939677543', NULL, 1, NULL, NULL),
(223, 'SOFIA LEPE', 'DNI', '18.102.374-0', 'CERVATILLO 731', '968721572', 'sofialepef@gmail.com', 1, NULL, NULL),
(224, 'paula vivanco', 'DNI', '10.8672102', 'seminario 444 villa galicia', '952329128', NULL, 1, NULL, NULL),
(225, 'Juan Carlos Salcedo', 'DNI', '11.793.805-0', 'Leutierio ramirez 1235', '979937041', NULL, 1, NULL, NULL),
(226, 'alexander yañez', 'DNI', '17.875.157-3', 'avenida las industrias 13850', '942371991', '1', 1, NULL, NULL),
(272, 'Franklin salas', 'DNI', '15.208.879-5', 'orompello 1892', '978564223', NULL, 1, NULL, NULL),
(273, 'mariela cid', 'DNI', '13.844.610-7', 'pasaje pablo picasso casa 102', '981293874', NULL, 1, NULL, NULL),
(274, 'carlos mella', 'DNI', '17.744.345-k', 'maisegure 1171 los angeles', '952152855', NULL, 1, NULL, NULL),
(275, 'Jocelyne Parra', 'DNI', '16.498.787-6', 'Burgos 1224 Villa España', '984745506', NULL, 1, NULL, NULL),
(276, 'martin segovia', 'DNI', '23.190.842-0', 'doña raquel 755 los angeles', '991518683', NULL, 1, NULL, NULL),
(277, 'franco huenchul', 'DNI', '22.556.360-8', 'valladolid 1160', '971791925', NULL, 1, NULL, NULL),
(278, 'leslie jaramillo', 'DNI', '16.482.187-0', 'porvenir 2 casa 66', '953599991', NULL, 1, NULL, NULL),
(279, 'PAMELA SOTO', 'DNI', '15.213.552-1', 'FREIRE 422 NACIMIENTO', '968989730', 'p.soto@serfonac.cl', 1, NULL, NULL),
(280, 'Isabelle Saez', 'DNI', '5.316.072-7', NULL, '979857537', NULL, 1, NULL, NULL),
(281, 'alex macia', 'DNI', '11.498775-1', 'lauca 516', '978537149', NULL, 1, NULL, NULL),
(282, 'Marcela Maulen Garces', 'DNI', '11.962.098-8', NULL, '998138109', NULL, 1, NULL, NULL),
(283, 'Julio Saavedra', 'DNI', '14.374.752-2', 'La Deesa del Moncayo 236', '995099827', NULL, 1, NULL, NULL),
(284, 'jaime martinez', 'DNI', '6.920.582-8', 'alicante 0410', '988762773', NULL, 1, NULL, NULL),
(285, 'cristian  seguel', 'DNI', '12.768.920-2', 'la coruña 0539', '966996555', NULL, 1, NULL, NULL),
(286, 'Ines Fica', 'DNI', '19.051.157-k', NULL, '973690865', NULL, 1, NULL, NULL),
(287, 'Gilda Herrera', 'DNI', '13.843.101-0', NULL, '936938824', NULL, 1, NULL, NULL),
(288, 'dominic martel', 'DNI', '16.156.266-1', 'avenida oriente 1418', '993577354', NULL, 1, NULL, NULL),
(289, 'Daniel Castro', 'DNI', '13.843.014-6', 'Sevilla 0584', '983607317', NULL, 1, NULL, NULL),
(290, 'Freddy Castañeda', 'DNI', '13.467.824-0', NULL, '968504039', 'freddy_gfp@hotmail.com', 1, NULL, NULL),
(291, 'daniel veloso', 'DNI', '21.860.988-0', 'quilleco 1297', '920347269', NULL, 1, NULL, NULL),
(292, 'carlos perez', 'DNI', '12.588.838-0', 'avenida 3 viento 201', '994167866', NULL, 1, NULL, NULL),
(293, 'margarita fuentes', 'DNI', '11.680.684-3', 'fray jorge 775 villa parque nacionales', '995919083', NULL, 1, NULL, NULL),
(294, 'Rodolfo venthur', 'DNI', '7.449.313-0', NULL, '995375990', NULL, 1, NULL, NULL),
(295, 'Patricio Espinoza', 'DNI', '14.351.692-k', NULL, '986382387', NULL, 1, NULL, NULL),
(296, 'angelina tovar', 'DNI', '20.554.108-4', 'leonardo da vinci 1312', '984914695', NULL, 1, NULL, NULL),
(297, 'ricardo', 'DNI', NULL, NULL, NULL, NULL, 0, NULL, NULL),
(298, 'Eduardo wood', 'DNI', '14.067.512-1', 'Laura Vicuña 423', '977984370', NULL, 1, NULL, NULL),
(299, 'carolina gonzales', 'DNI', '14.349.691-0', 'montague 2477', '987816236', NULL, 1, NULL, NULL),
(300, 'angelo  quezada', 'DNI', '16.026.487-k', 'huerto N2 san gerardo', '950514445', NULL, 1, NULL, NULL),
(301, 'Roberto Venegas', 'DNI', '13.845.011-2', NULL, '966850442', 'roberto_venegas_rojas@hotmail.com', 1, NULL, NULL),
(302, 'pamela muñoz', 'DNI', '11.792.9094', 'ciudades de chile calle ñuble 1658', '971016510', NULL, 1, NULL, NULL),
(303, 'Rosario Valdez', 'DNI', '7.399.542-6', NULL, '992379741', NULL, 1, NULL, NULL),
(304, 'enrique santander', 'DNI', '76.603.463-2', 'pasaje roberto garcía 460 villa el avellano los angeles', '975236015', NULL, 1, NULL, NULL),
(305, 'carolina', 'DNI', '12.697.372-1', 'camino antuco  km 3,6', '992309200', NULL, 1, NULL, NULL),
(306, 'jonatan calderon', 'DNI', '16.397.034-1', 'km 20 camino santa barbara', '966368422', NULL, 1, NULL, NULL),
(307, 'leticia amestica', 'DNI', '12.559.357-7', 'avenida san luis citio 64 sector el peral', '961057499', NULL, 1, NULL, NULL),
(308, 'andrea  spano', 'DNI', '20.018.486-6', 'costanera quilque norte 820', '988178735', NULL, 1, NULL, NULL),
(309, 'Erna Montenegro', 'DNI', '18.503.051-2', NULL, '945084583', NULL, 1, NULL, NULL),
(310, 'alejandro  castillo', 'DNI', '16.204.255-6', 'camino cerro colorado km05', '978858876', NULL, 1, NULL, NULL),
(311, 'RUT SEPULVEDA', 'DNI', '17.216.191-K', 'PARCELA 6 SECTOR LOS TILOS', '957215664', 'bricellaoficial@gmail.com', 1, NULL, NULL),
(312, 'LAUTARO FLORES VELASQUEZ', 'DNI', '7354578-1', 'VALLADOLID 1205', '966129281', 'laut13@yahoo.es', 1, NULL, NULL),
(313, 'Evelin Quezada', 'DNI', '14070073-8', 'las arenarias 819', '978740411', 'evequecompu@gmail.com', 1, NULL, NULL),
(314, 'Alejandra Villalobos', 'DNI', '14.547.562-7', 'Colon 141 of 5', '966760972', 'Alejandravillalobos.rivera@gmail.com', 1, NULL, NULL),
(315, 'FREDY CASTAÑEDA', 'DNI', '13.467.824-0', 'PASAJE PEDRO DE VALDIVIA 17', '968504039', 'freddy_gfp@hotmail.com', 1, NULL, NULL),
(316, 'BORIS FIGUEROA', 'DNI', '22.418.461-1', 'Valle nevado 809', '971325007', 'borisgabrielfugueroarodriguez@gmail.com', 1, NULL, NULL),
(317, 'Alexis Gutierrez', 'DNI', '15.231.286-5', 'Francisco de agoya 280', '950088206 - 77002575', 'eagp.07@gmail.com', 1, NULL, NULL),
(318, 'Nataly Tamaño', 'DNI', '19.714870-5', 'pasaje la frontera 4 373 altos del petrohue', '920155789', 'tamanonataly@gmail.com', 1, NULL, NULL),
(319, 'Claudia Lopez', 'DNI', '13.955.620-8', 'Ohiggins  743 casa g', '94895177', 'c.lopezcondeza@gmail.com', 1, NULL, NULL),
(320, 'ELIAS OLIVIERI', 'DNI', '5545454-5', 'Las alamedas de san francisco cerro colorado', '+15873357933', 'theotherelias@gmail.com', 1, NULL, NULL),
(321, 'JOSE MENDOZA JARA', 'DNI', '22.332.726-5', 'Ayin Rehue 2465', '992581042', 'josemendojara@gmail.com', 1, NULL, NULL),
(335, 'Claudia Rivera Otarola', 'DNI', '12.558.688-0', 'quinta el amnzano lote 15 b', '975650920', 'b.tremer@gmail.com', 1, NULL, NULL),
(336, 'Emilio Carrasco', 'DNI', '10.293.750-3', 'Pasaje Eiffel 114', '975772026', 'emilio.carrasco.s@gmail.com', 1, NULL, NULL),
(337, 'TOMAS   SALAMANCA', 'DNI', '21.598.853-8', 'Eloisa Diaz 144 Villa El avellano', '968597392', 'tomassalamanca01@gmail.com', 1, NULL, NULL),
(338, 'LORENA CARRILLO', 'DNI', '11.116.927-6', 'La Torre 0410', '9332345660', 'freire@clinicapahuen.cl', 1, NULL, NULL),
(339, 'FERNANDA CARRASCO', 'DNI', '16.987.705K', 'AVENIDA ORIENTE 1279', '934619164', 'mfcarrascos@gmail.com', 1, NULL, NULL),
(340, 'Liliana Riveros', 'DNI', '12.922.219-0', 'Los Manantiales 104', '998204511', 'rivero.liliana@gmail.com', 1, NULL, NULL),
(341, 'Maria Esperanza', 'DNI', '22.978.204-5', 'Sevilla 0519', '920514053', NULL, 1, NULL, NULL),
(342, 'maritza cares melo', 'DNI', '9.696.983-k', 'Avenida oriente 624', '942167781', NULL, 1, NULL, NULL),
(343, 'Elza Valdevenito', 'DNI', '7.743.187-k', 'Camino Santa Matilde Km 2 San Diego Norte Parcela 6 Los Angeles', '931421465', 'elza-valdevenito@hotmail.com', 1, NULL, NULL),
(344, 'Roberto Guzman', 'DNI', '15.627.044-k', 'Niza 1307 Villa Francia', '956811626', 'guzmanpublicidad2016@gmail.com', 1, NULL, NULL),
(345, 'dileta farias', 'DNI', '19.053.215-1', 'anperes 320', '959171099', NULL, 1, NULL, NULL),
(346, 'jose cea', 'DNI', '15.511.846-6', 'salvador de ali 108 avenida sorvicenta', '9 9549 8550', NULL, 1, NULL, NULL),
(347, 'Loretto Santibañez', 'DNI', '9.783.585.3', 'madrid 1251', '942676792', NULL, 1, NULL, NULL),
(360, 'Milton Sommer', 'DNI', '19.053.212-7', 'Villa Guallali Pasaje costanera 0260', '99852473', NULL, 1, NULL, NULL),
(361, 'Robert Salazar', 'DNI', '15.204.546-8', 'Almagro 1398', '967511480', NULL, 1, NULL, NULL),
(362, 'Daisy pino', 'DNI', '16.599.979-7', 'alto del refugio 480', '923802137', NULL, 1, NULL, NULL),
(363, 'Josefa Bustos', 'DNI', '20.903.612-6', 'Bilbao 1251 Villa España', '997138408', NULL, 1, NULL, NULL),
(364, 'vicente maldonado', 'DNI', '21.625.818-5', 'Matices 116', '981228876', NULL, 1, NULL, NULL),
(365, 'Jaime Cereceda', 'DNI', '10.169.351-1', 'Zaragoza 570 Villa España', '992094916', 'jacerecedab66@yahoo.es', 1, NULL, NULL),
(366, 'Cesar Jorquera', 'DNI', '11.438.085-7', 'Helios 443 Casa 1', '951917682', NULL, 1, NULL, NULL),
(367, 'Isaias Moraga', 'DNI', '17.686.647-0', 'Napoles 1365', '966307137', NULL, 1, NULL, NULL),
(368, 'pedro parra valenzuela', 'DNI', '8.196.263-4', 'maria de los angeles 18 las trancas', '961893290', NULL, 1, NULL, NULL),
(369, 'Rozzana Mellado', 'DNI', '9.071.917-3', 'Sevilla 0680', '976951630', NULL, 1, NULL, NULL),
(370, 'Nicolas Fernandez', 'DNI', '26.434.063-2', 'Marsella 2216', '978039584', NULL, 1, NULL, NULL),
(371, 'Belen Alonso', 'DNI', '20.619.228-3', 'Camino Maria Dolores 1.5', '956592818', NULL, 1, NULL, NULL),
(372, 'Rodrigo Fritz', 'DNI', '13.313.063-2', 'Av. Oriente 785 casa 273', '957428515', NULL, 1, NULL, NULL),
(373, 'Borich Figueroa', 'DNI', '22.418.461-1', 'Valle Nevado 809', '995952423', NULL, 1, NULL, NULL),
(374, 'JOSE RIVERA', 'DNI', '19.855.079-5', 'CAMPANARIO 2454', '989606952', 'jlriveraing@gmail.com', 1, NULL, NULL),
(439, 'erwin castro', 'DNI', '13.804.846-2', 'luis uribes interio quito camino las terma de chillan', '973950039', NULL, 1, NULL, NULL),
(440, 'Francisco uribe', 'DNI', '17.130.994-8', 'Luis Soto 759', '957168221', 'fco.uribef@gmail.com', 1, NULL, NULL),
(441, 'Paola escobar', 'DNI', '19.653.842-9', 'parcela 1 la capilla coihue', '981360672', 'm.paolaescobarh@gmail.com', 1, NULL, NULL),
(442, 'Yasna rojas', 'DNI', '18.356.551-6', 'avenida malvada con colo colo departamento 108', '962029713', NULL, 1, NULL, NULL),
(443, 'joaquin valdes', 'DNI', '21.593.258-3', 'malaga 1112', '963737897', NULL, 1, NULL, NULL),
(444, 'Pamela Pezoa', 'DNI', '15.629.191-9', 'Camino Casa Blanca Km 14', '988137175', NULL, 1, NULL, NULL),
(445, 'Gaspar garcia', 'DNI', '21.253.685-7', 'Condominio el Avellano, Los Ángeles', '938822765', NULL, 1, NULL, NULL),
(446, 'Daniela escobar', 'DNI', '18.279.652-2', 'parcela 1 la capilla el coigue', '979636734', NULL, 1, NULL, NULL),
(447, 'Nicol Campos', 'DNI', '17.594.549-0', 'Sevilla 0446', '986854508', NULL, 1, NULL, NULL),
(448, 'Agricola y Comercial los volcanes  SPA', 'DNI', '76.295.797-3', 'PC 4 STA LAURAL T B1 NULL  LOS ANGELES', '+56 9 9731 7159', NULL, 1, NULL, NULL),
(449, 'ignacio diaz', 'DNI', '18.800.184-k', 'valladolid', '957746519', NULL, 1, NULL, NULL),
(450, 'Vivian Muñoz', 'DNI', '15.811.001-6', 'Av. Oriente 1279', '986325399', NULL, 1, NULL, NULL),
(451, 'Verena Diehelfer', 'DNI', '13.118.305-4', 'avenida oriente 1315', '986566729', NULL, 1, NULL, NULL),
(452, 'Ricardo Salamanca', 'DNI', '9.262.512-5', 'Elosia Diaz 144', '979133121', NULL, 1, NULL, NULL),
(453, 'Humberto aviles', 'DNI', '8.803.245-4', 'Belfo 0957 Villa Grecia', '978450782', NULL, 1, NULL, NULL),
(454, 'Eduardo Godoi', 'DNI', '14.586.887-4', 'Avenida oriente 1289 villa francia', '981245039', NULL, 1, NULL, NULL),
(456, 'carmen venegas', 'DNI', '13.802.061-4', 'pasaje matisse 1010 parque sor vicenta', '976103350', NULL, 1, NULL, NULL),
(457, 'carolina  silva', 'DNI', '76.252.122-9', 'Avenida sor vicenta 2371', '988187219', NULL, 1, NULL, NULL),
(458, 'valeria manrique', 'DNI', '17.400.847-7', 'avenida manuel rio seco 400 condominio parque el avellano casa 15', '976894255', NULL, 1, NULL, NULL),
(459, 'vivi  miranda', 'DNI', '13.143.266-6', 'genova 1746', '940634847', NULL, 1, NULL, NULL),
(460, 'Valentina Hidalgo', 'DNI', '21.254.074-9', 'Lago Villarrica 860', '972051663', NULL, 1, NULL, NULL),
(461, 'TANIA ORELLANA', 'DNI', '14.069.451-7', 'ALERCE ANDINO 1110 VILLA ESPAÑA', '972930842', 'v.antonella@yahoo.es', 1, NULL, NULL),
(462, 'josefina veloso', 'DNI', '21.350.087-2', 'condominio el avellano casa 98', '957980472', NULL, 1, NULL, NULL),
(463, 'Alejandra Castro', 'DNI', '12.883.437-0', 'Pedri Lira 105 Parque Nativa', '984096367', NULL, 1, NULL, NULL),
(464, 'patricia gomez', 'DNI', '10.666.888-4', 'villa italia pasaje siena 1974', '979963610', NULL, 1, NULL, NULL),
(466, 'Marco Oporto', 'DNI', '8.913.394-7', 'Segobia 1215', '983697381', NULL, 1, NULL, NULL),
(467, 'Karol Lepe Campos', 'DNI', '17.216.938-4', 'Hamberton 109', '945582439', NULL, 1, NULL, NULL),
(468, 'maria  nieves', 'DNI', '13.387.717-7', 'almirante latorre villa españa 0641', '999184299', NULL, 1, NULL, NULL),
(469, 'Jose donoso', 'DNI', '7.070.331-9', 'Pasaje Queulat 1140', '999397486', NULL, 1, NULL, NULL),
(470, 'LUIS CARRASCO', 'DNI', '22.279.675-K', 'AVDA. Gabriela Mistral villa cataluña pasaje amanecer 106', '974518275', 'luisignaciocarrascorosas@gmail.com', 1, NULL, NULL),
(471, 'Ariel Fuentes', 'DNI', '12.028.741-9', 'Parcela 6 lote v1 sector capilla los angeles', '956930222', NULL, 1, NULL, NULL),
(477, 'Carolina Astudillo', 'DNI', '10.975.987-2', 'Glaciares 843', '982051295', NULL, 1, NULL, NULL),
(478, 'Henry jara', 'DNI', '18.100.829-6', 'las palma 1143', '998970740', NULL, 1, NULL, NULL),
(479, 'ezequiel Aravena', 'DNI', '4.502.489-k', 'Sector el durazno', '992385068', NULL, 1, NULL, NULL),
(489, 'Yarly', 'DNI', '17.592.380-2', 'Los quimbayas 504', '961742478', NULL, 1, NULL, NULL),
(490, 'Jose rochal', 'DNI', '16.664.101-2', 'ramon larena 197 santa barbara', '987343304', NULL, 1, NULL, NULL),
(491, 'David Contreras', 'DNI', '18.804.716-5', 'calle el bosque 691 los angeles', '932846102', NULL, 1, NULL, NULL),
(492, 'valentina Gomez', 'DNI', '21.432.344-3', 'camino pedregal', '933016973', NULL, 1, NULL, NULL),
(493, 'paola molina', 'DNI', '9.659.879-3', 'roma 0603', '951400228', NULL, 1, NULL, NULL),
(494, 'Fernando constanzo', 'DNI', '7.796.828-8', 'Leonardo danbinchi 1284', '98832339', NULL, 1, NULL, NULL),
(495, 'claudio torres', 'DNI', '15.205.142-5', 'leonardo da vinci 1377', '986640432', NULL, 1, NULL, NULL),
(496, 'viviana diaz', 'DNI', '12.669.791-0', 'Av. Almirante La Torre 0500', '984346351', NULL, 1, NULL, NULL),
(497, 'Sandra Echeverria', 'DNI', '17.217.107-9', 'Camino santa clara parcela 13 sector Rarinco Centro', '979409369', 'berly2117@hotmail.com', 1, NULL, NULL),
(498, 'Natalia urriola', 'DNI', '17.744.048-5', 'Salamanca 560', '947191367', NULL, 1, NULL, NULL),
(499, 'Paulina Campos', 'DNI', '15.208.386-6', 'Toulouse 1346 Villa Francia', '929466295', NULL, 1, NULL, NULL),
(500, 'Metal partner SPA', 'DNI', '78.224.611-9', 'LOS ALPES 960 DEPARTAMENTO 807B LAS CONDES', '981360791', NULL, 1, NULL, NULL),
(501, 'carlo figueroa', 'DNI', '15.811.086-5', 'Sin direcion', '986246228', NULL, 1, NULL, NULL),
(510, 'Yenifer morales yañez', 'DNI', '16.305.244-k', 'quinta el manzano cerro colorado', '956796030', NULL, 1, NULL, NULL),
(511, 'sebastian arriagada', 'DNI', '19.370.148-5', 'pasaje burgo 1250', '972724933', NULL, 1, NULL, NULL),
(512, 'tania salvo', 'DNI', '19.370.730-0', 'la campana 930', '940050102', NULL, 1, NULL, NULL),
(513, 'carol cid', 'DNI', '15.626.536-5', 'avenida almirante latorre 0840 casa 27', '984091072', NULL, 1, NULL, NULL),
(514, 'solange mora', 'DNI', '18.102.485-2', 'chacabuco cartocha 96', '957337142', NULL, 1, NULL, NULL),
(515, 'FRANCISCO ARANEDA', 'DNI', '16.749.014-K', 'ALTO DEL REFUGIO 320', '929817903', 'FJARANEDAA@GMAIL.COM', 1, NULL, NULL),
(516, 'Luis Zambrano', 'DNI', '26.445.303-8', 'Almirante La Torre Condominio santa ana 0840', '973885602', NULL, 1, NULL, NULL),
(517, 'mario acuña leon', 'DNI', '6.391.561-0', 'colo colo 0683  poblacion pedro lagos', '987421360', NULL, 1, NULL, NULL),
(530, 'Yenifer morales.', 'DNI', '18.525.258-2', 'chacayal sur', '933762172', NULL, 1, NULL, NULL),
(531, 'Silvia Pereira', 'DNI', '18.101.412-1', 'Valladolid 1247', '968649305', NULL, 1, NULL, NULL),
(532, 'Rodrigo Mora', 'DNI', '14.555.073-4', 'Lindulfo Padilla 1956', '962099905', NULL, 1, NULL, NULL),
(533, 'hilda hernandez', 'DNI', '12.326.152-6', 'poblacion basilio muñoz calle san gabriel 1785', '947377676', NULL, 1, NULL, NULL),
(534, 'BORIS SILVA', 'DNI', '15.626.159-9', 'CAMPANARIO 2469', '978561216', 'borisilva.org@gmail.com', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_100000_create_password_resets_table', 1),
(2, '2019_08_19_000000_create_failed_jobs_table', 1),
(3, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(4, '2022_05_31_012649_create_clientes_table', 1),
(5, '2022_06_05_140859_create_tecnicos_table', 1),
(6, '2022_07_04_195734_create_usuario_table', 1),
(7, '2024_09_01_224822_create_roles_table', 1),
(8, '2024_10_01_200156_create_users_table', 1),
(9, '2024_11_01_151914_create_orden_table', 1),
(10, '2024_12_01_212045_add_imagen_to_orden_table', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `orden`
--

CREATE TABLE `orden` (
  `id` int UNSIGNED NOT NULL,
  `idcliente` int UNSIGNED NOT NULL,
  `idtecnico` int UNSIGNED NOT NULL,
  `idusuario` int UNSIGNED NOT NULL,
  `nombreEquipo` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `marca` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `modelo` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `serial` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `clave` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `accesorios` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `observaciones` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `fallaEquipo` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `reparacion` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `fechaEntrada` datetime NOT NULL,
  `fechaEntrega` datetime NOT NULL,
  `adelanto` decimal(11,2) NOT NULL,
  `totalPagar` decimal(11,2) NOT NULL,
  `estado` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `imagen` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `orden`
--

INSERT INTO `orden` (`id`, `idcliente`, `idtecnico`, `idusuario`, `nombreEquipo`, `marca`, `modelo`, `serial`, `clave`, `accesorios`, `observaciones`, `fallaEquipo`, `reparacion`, `fechaEntrada`, `fechaEntrega`, `adelanto`, `totalPagar`, `estado`, `imagen`, `created_at`, `updated_at`) VALUES
(31, 6, 7, 1, 'NOTEBOOK', 'ACER', 'A515-54', '12108023076', 'SIN CLAVE', 'SIN ACCESORIOS', 'SIN CARGADOR', 'PANTALLA ROTA Y CARCASA DAÑADA', 'CAMBIO DE CARCASA Y PANTALLA', '2025-03-24 00:00:00', '2025-05-30 00:00:00', 100000.00, 220000.00, 'Reparando', NULL, '2025-05-07 18:32:48', '2025-05-07 18:51:44'),
(32, 7, 8, 1, 'NOTEBOOK', 'LENOVO', 'IDEAPAD 3 15ADA05', 'PF38XP21', 'SIN CLAVE', 'SIN ACCESORIOS', 'SIN  CARGADOR', 'EQUIPO MUY LENTO', 'CAMBIO DESSD 240GIGAS', '2025-05-07 00:00:00', '2025-05-12 00:00:00', 0.00, 65000.00, 'Ingresado', NULL, '2025-05-07 21:46:30', '2025-05-07 23:47:30'),
(33, 8, 8, 1, 'Notebook', 'Acer', 'A515-43-R5KB', 'NXHG8AL00Q1491FC023400', 'S/N CLAVE', 'S/N CARGADOR', 'TIENE UN PARCHE PEGADO POR DAÑO EN LA CARCASA.', 'PROBLEMAS CON EL PIN DE CARGA. AL MOVER LA ENTRADA DEL CARGADOR SE CORTA LA ENERGÍA.', 'EVALUACION COMPLETA', '2025-05-08 00:00:00', '2025-05-15 00:00:00', 0.00, 35000.00, 'Entregado', NULL, '2025-05-08 20:03:19', '2025-05-20 18:32:41'),
(34, 9, 7, 7, 'impresora', 'canon', 'ip2702', '1234', 'sin clave', 'sin cables', 'llamar a cliente', 'color negro con fallas', 'evaluacion completa', '2025-05-08 00:00:00', '2025-05-13 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-05-08 23:01:32', '2025-05-08 23:01:32'),
(35, 10, 8, 1, 'Notebook', 'HP', '14-AQ2025LA', '5CD136BXV6', 'S/N CLAVE', 'S/N CARGADOR', 'Cliente formateo el disco duro.', 'Pidio clave bitlocker y formatearon el disco.', 'Formateo sin respaldo', '2025-05-09 00:00:00', '2025-05-13 00:00:00', 0.00, 15000.00, 'Entregado', NULL, '2025-05-09 23:52:26', '2025-05-13 21:08:01'),
(36, 11, 7, 1, 'notebook', 'Lenovo', 'ideapad 305-15ibd', 'MP17G4JC', 'CONSULTAR A  CLIENTE', 'SIN CARGADOR', 'EL JACK POWER SE FUE HACIA ADENTRO', 'EL JACK POWER SE FUE HACIA ADENTRO', 'REPARAR  JACK POWER', '2025-05-09 00:00:00', '2025-05-13 00:00:00', 0.00, 0.00, 'Entregado', NULL, '2025-05-10 03:04:48', '2025-05-10 03:09:30'),
(37, 12, 9, 1, 'HP  STREAM', 'HP', 'STREAM', 'SC0722837M', 'SIN CLAVE', 'SIN ACCESORIOS', 'NO ARRANCA SISTEMA', 'SOLO PRENDE LUZ PILOTO', 'RECUPERAR ARRANQUE O EVALUAR SITUASION', '2025-05-10 00:00:00', '2025-05-13 00:00:00', 0.00, 10000.00, 'Entregado', NULL, '2025-05-10 21:10:52', '2025-05-24 00:34:32'),
(38, 13, 8, 1, 'Impresora', 'Epson', 'L3250', 'epsonl3250', 'NO APLICA', 'SIN ACCESORIOS', 'TIENE TIENTA SUBLIMABLE', 'NO IMPRIME', 'EVALUACION COMPLETA', '2025-05-12 00:00:00', '2025-05-19 00:00:00', 0.00, 0.00, 'Entregado', NULL, '2025-05-12 21:11:36', '2025-05-17 01:46:27'),
(39, 15, 7, 1, 'impresora', 'epson', 'L3250', '123456', 'sin clave', 'sin cables', 'la impresora esta imprimiendo mal', 'no salen los colores y negro', 'evaluacion completa', '2025-05-12 00:00:00', '2025-05-16 00:00:00', 0.00, 18000.00, 'Entregado', NULL, '2025-05-13 02:44:37', '2025-05-15 02:00:43'),
(40, 16, 7, 1, 'impresora', 'canon', 'G2100', '123456', 'sin clave', 'sin cables', 'no toma bien la hoja', 'no toma bien la hoja', 'evaluación completa', '2025-05-13 00:00:00', '2025-05-19 00:00:00', 0.00, 10000.00, 'Entregado', NULL, '2025-05-13 18:27:49', '2025-05-15 01:58:06'),
(41, 16, 7, 1, 'impresora', 'epson', 'l3210', '1234567', 'sin clave', 'sin clave', 'la impresora dejo de imprimir', 'la impresora dejo de imprimir', 'evaluacion completa', '2025-05-13 00:00:00', '2025-05-19 00:00:00', 0.00, 18000.00, 'Entregado', NULL, '2025-05-13 18:30:19', '2025-05-15 01:58:17'),
(42, 17, 8, 1, 'Impresora', 'Epson', 'L220', 'epsonl220x2', 'no aplica', 'sin accesorios', '2 impresoras mismo modelo', 'evaluacion completa', 'evaluacion completa', '2025-05-13 00:00:00', '2025-05-19 00:00:00', 0.00, 60000.00, 'Entregado', NULL, '2025-05-13 20:03:13', '2025-05-20 18:29:38'),
(43, 18, 7, 1, 'NOTEBOOK', 'LENOVO', 'THINKPAD', 'G0HMG0871', 'NO APLICA', 'SIN ACCESORIOS', 'EQUIPO NO PRESENTA SEÑALES  DE ENERGIA', 'NO PRENDE', 'EVALUACION COMPLETA', '2025-05-13 00:00:00', '2025-05-19 00:00:00', 0.00, 8000.00, 'Entregado', NULL, '2025-05-13 20:15:40', '2025-05-17 00:46:52'),
(44, 19, 8, 1, 'Celular', 'Samsung', 'S21FE', 'samsungs21fe', 'Patron \"Z\"', 'Sin accesorios', 'Arroja publicidad de virus constantemente', 'Infectado', 'Resetear de fábrica', '2025-05-14 00:00:00', '2025-05-15 00:00:00', 0.00, 15000.00, 'Entregado', NULL, '2025-05-14 18:23:03', '2025-05-15 01:57:01'),
(45, 20, 7, 1, 'notebook', 'DELL', 'VOSTRO 3400', '12345678', 'PEDIR CLAVE', 'SIN CARGADOR', 'EL EQUIPO NO ESTA RECIBIENDO BIEN ENERGIA', 'EL EQUIPO NO ESTA RECIBIENDO', 'EVALUACION COMPLETA', '2025-05-14 00:00:00', '2025-05-19 00:00:00', 0.00, 40000.00, 'Entregado', NULL, '2025-05-14 21:05:27', '2025-05-27 02:16:04'),
(46, 21, 7, 1, 'notebook', 'lenovo', 'Y700-15ISK', 'PF0Q36AM', 'SIN CLAVE', 'CON CARGADOR', 'EL EQUIPO TIRA ERROR DE SISTEMA', 'EVALUACION COMPLETA', 'EVALUACION COMPLETA', '2025-05-14 00:00:00', '2025-05-16 00:00:00', 0.00, 18000.00, 'Entregado', NULL, '2025-05-15 02:10:18', '2025-05-20 19:21:14'),
(47, 22, 8, 1, 'Pc de Escritorio', 'Generico', 'De Escritorio', 'PC-ESCRITORIO', 'S/N CLAVE', 'Sin Cables', 'Instalar office', 'Sin office', 'Office Crackeado', '2025-05-14 00:00:00', '2025-05-15 00:00:00', 0.00, 15000.00, 'Entregado', NULL, '2025-05-15 02:23:43', '2025-05-20 18:30:32'),
(48, 23, 7, 1, 'notebook GAMER', 'acer', 'PREDATOR  N20C3', 'NHQC5AL001134136933400', 'no recuerda la clave', 'con cargador  y caja', 'Formateo sin respaldo', 'Formateo sin respaldo', 'Formateo sin respaldo', '2025-05-15 00:00:00', '2025-05-20 00:00:00', 0.00, 15000.00, 'Entregado', NULL, '2025-05-15 20:20:11', '2025-05-20 19:16:31'),
(49, 24, 7, 1, 'Notebook Gamer', 'HP', '15-FB0104LA', '5CD3194GTB', '2310', 'CON CARGADOR', 'Problemas de estabilidad, se apaga al poco tiempo de uso, realizar limpieza y cambio de pasta disipadora', 'exceso de temperatura', 'limpeza de sistema de ventilacion y camb de pasta disipadora', '2025-05-16 00:00:00', '2025-05-19 00:00:00', 0.00, 25000.00, 'Entregado', NULL, '2025-05-16 18:34:40', '2025-05-17 01:26:56'),
(50, 25, 7, 1, 'impresora', 'epson', '3210', '123456789789', 'sin clave', 'sin cables', 'las impresora no esta imprimiendo el color negro', 'las impresora no esta imprimiendo el color negro', 'evaluacion completa', '2025-05-19 00:00:00', '2025-05-21 00:00:00', 0.00, 10000.00, 'Entregado', NULL, '2025-05-19 20:18:30', '2025-05-20 19:20:17'),
(51, 26, 7, 7, 'Notebook', 'acer', 'A514-53-54am', 'nxhunal000m042075ab2n00', 'sin clave', 'sin cargador', 'equipo con visagras dañadas y no enciente', 'sin actividad de encendido', 'evaluar posible reparacion', '2025-05-19 00:00:00', '2025-05-25 00:00:00', 0.00, 8.00, 'Ingresado', NULL, '2025-05-19 22:37:02', '2025-05-19 22:37:02'),
(52, 27, 7, 1, 'notebook', 'Lenovo', 'V14IIL', 'PF35VSLZ', 'monse', 'sin accesorios', 'equipo presenta broblemas de marcacion en teclado', 'Letras con funcionamiento intermitente linea 9ol', 'evaluar teclado', '2025-05-19 00:00:00', '2025-05-25 00:00:00', 0.00, 8000.00, 'Entregado', NULL, '2025-05-19 22:48:48', '2025-05-22 18:38:26'),
(53, 28, 7, 1, 'notebook', 'hp', '15-dv1021cy', 'cnd9434lpf', 'sin calve', 'sin cargador', 'el equipo tienen windows 11 y necesita bajar a windows 10', 'el equipo tienen windows 11 y necesita bajar a windows 10', 'formateo  con respaldo', '2025-05-20 00:00:00', '2025-05-23 00:00:00', 0.00, 0.00, 'Entregado', NULL, '2025-05-21 02:04:29', '2025-05-29 22:59:24'),
(54, 29, 7, 7, 'equipo de torre', 'armado', 'equipo armado', '123654987', 'sin clave', 'sin cables', 'evaluacion completa', 'el equipo enciende pero no da imagen y no recibe energia lo perifericos', 'el equipo enciende pero no da imagen y no recibe energia lo perifericos', '2025-05-22 00:00:00', '2025-05-26 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-05-22 18:34:22', '2025-05-22 18:34:22'),
(55, 30, 7, 1, 'impresora', 'epson', 'l3250', '1236547895', 'sin clave', 'sin cables', 'la impresora esta tirando error', 'la impresora esta tirando error', 'evaluacion completa mandar valores', '2025-05-22 00:00:00', '2025-05-26 00:00:00', 0.00, 0.00, 'Entregado', NULL, '2025-05-22 23:25:25', '2025-06-05 23:09:30'),
(56, 31, 8, 1, 'PC DE ESCRITORIO', 'Armado', 'Generico', 'PCESCRITORIO', 'Sin Clave', 'Sin Accesorios', 'Formateo con respaldo', 'Lentitud en las operaciones', 'Formateo con Respaldo', '2025-05-22 00:00:00', '2025-05-26 00:00:00', 0.00, 18000.00, 'Entregado', NULL, '2025-05-23 00:56:22', '2025-05-26 21:50:56'),
(57, 31, 8, 1, 'Lenovo', 'Lenovo', 'IDEAPAD 330-14AST', 'ideapad330ast', 'Sin clave', 'Sin Accesorios', 'Cambio de disco ssd 240gb', 'Desea mejorar el funcionamiento', 'Cambio de disco ssd 240gb', '2025-05-22 00:00:00', '2025-05-27 00:00:00', 0.00, 65000.00, 'Entregado', NULL, '2025-05-23 00:58:39', '2025-05-26 21:50:50'),
(58, 32, 8, 1, 'Impresora', 'Epson', 'L3150', 'l3150epson', 'No aplica', 'Sin Accesorios', 'No imprime', 'No imprime', 'Evaluacion completa', '2025-05-23 00:00:00', '2025-05-27 00:00:00', 0.00, 0.00, 'Entregado', NULL, '2025-05-23 20:35:06', '2025-05-29 22:55:58'),
(59, 33, 8, 1, 'Traspaso vhs/digital', 'VHSC', 'Cintas vhsc', 'Cinvhsc', 'No aplica', 'Sin accesorios', '4 cintas vhsc', 'Desea realizar traspaso a digital', 'Traspaso cintas vhs', '2025-05-23 00:00:00', '2025-05-28 00:00:00', 0.00, 0.00, 'Entregado', NULL, '2025-05-24 00:15:20', '2025-06-13 00:46:57'),
(60, 34, 9, 1, 'NOTEBOOK GAMER', 'ACER', 'AN515-52', '82105176434', 'NO APLICA', 'CON CARGADOR', 'EQUIPO NO ARRANCA SISTEMA OPERATIVO', 'PROBLEMAS EN ARRANQUE', 'EVALUACION Y PRESUPUESTO', '2025-05-27 00:00:00', '2025-05-30 00:00:00', 0.00, 90000.00, 'Entregado', NULL, '2025-05-24 20:22:44', '2025-05-29 18:10:39'),
(61, 35, 9, 1, 'Notebook', 'Asus', 'X543UA', '568K', 'NO APLICA', 'CON CARGADOR', 'FORMATEO CON RESPALDOS', 'EQUIPO LENTO Y SE CUELGA AL INICIAR', 'FORMATEO CON RESPALDOS', '2025-05-26 00:00:00', '2025-05-30 00:00:00', 0.00, 18000.00, 'Entregado', NULL, '2025-05-26 22:32:15', '2025-06-13 00:47:14'),
(62, 36, 7, 7, 'pc  escritorio', 'armado', 'AMD', '1234567', 'sin clave', 'incluye memoria ram t tarjeta grafica', 'COTIZACION Y EVALUACION', 'LE FALTAN  COMPONENTES', 'COTIZACION Y EVALUACION', '2025-05-29 00:00:00', '2025-06-06 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-05-30 02:40:05', '2025-05-30 02:40:05'),
(63, 37, 8, 1, 'Notebook', 'Lenovo', 'Inspiron 14', '80433f2', 'NO APLICA', 'SIN CARGADOR', 'CAMBIAR DISCO SSD 240 GB Y EVALUAR BATERIA', 'BATERIA DAÑADA Y FUNCIONANDO LENTO', 'CAMBIAR DISCO SSD 240 GB Y EVALUAR BATERIA', '2025-05-29 00:00:00', '2025-06-04 00:00:00', 0.00, 65000.00, 'Entregado', NULL, '2025-05-30 02:48:28', '2025-06-03 01:48:11'),
(64, 38, 8, 1, 'Impresora', 'Epson', 'L3250', 'EPSONL3250', 'NO APLICA', 'SIN CABLES', 'PASA LA HOJA PERO NO IMPRIME', 'NO IMPRIME', 'EVALUACION COMPLETA', '2025-05-30 00:00:00', '2025-06-05 00:00:00', 0.00, 10000.00, 'Entregado', NULL, '2025-05-31 01:18:57', '2025-06-05 23:07:19'),
(65, 39, 8, 1, 'VHS', 'VHS', 'VHS', '6CINTASVHS', 'NO APLICA', '1 DISCO DURO TOSHIBA', '6 CINTAS VHS PARA DIGITALIZACION', 'DESEA DIGITALIZAR EL MATERIAL', 'DIGITALIZAR Y RESPALDAR', '2025-06-02 00:00:00', '2025-06-05 00:00:00', 0.00, 0.00, 'Entregado', NULL, '2025-06-02 18:06:01', '2025-06-13 00:46:41'),
(66, 40, 7, 1, 'Celular', 'Motorola', 'E32', 'MOTOE32', 'SIN CLAVE', 'SIN ACCESORIOS', 'PANTALLA DAÑADA', 'PANTALLA ROTA', 'CAMBIO DE PANTALLA', '2025-06-02 00:00:00', '2025-06-03 00:00:00', 0.00, 40000.00, 'Entregado', NULL, '2025-06-02 23:26:39', '2025-06-05 23:04:24'),
(67, 41, 8, 1, 'Envy', 'HP', '17-J150LA', '17-J150LA', 'SIN CLAVE', 'SIN CARGADOR', 'NO ARRANCA, SE QUEDA CARGANDO', 'FALLA AL ARRANCAR', 'EVALUACION COMPLETA', '2025-06-03 00:00:00', '2025-06-06 00:00:00', 0.00, 18000.00, 'Entregado', NULL, '2025-06-03 18:45:21', '2025-06-05 23:05:33'),
(68, 42, 9, 1, 'IMPRESORA', 'CANON', 'G4110', '11111', '0', 'SIN CABLES', 'EVALUACION', 'EVALUACION Y COTIZACION', 'ANALIZAR FALLAS ACTUALES', '2025-06-03 00:00:00', '2025-06-05 00:00:00', 0.00, 0.00, 'Entregado', NULL, '2025-06-03 23:33:09', '2025-06-13 00:46:15'),
(69, 43, 8, 1, 'Notebook', 'HP', '240G8', '240G8HP', 'SIN CLAVE', 'SIN CARGADOR', 'DESEA CAMBIAR DISCO Y EXPANDIR RAM', 'EQUIPO DEMASIADO LENTO', 'CAMBIO DE DISCO Y COTIZACION DE RAM', '2025-06-03 00:00:00', '2025-06-09 00:00:00', 0.00, 100000.00, 'Entregado', NULL, '2025-06-04 00:28:02', '2025-06-13 00:44:28'),
(70, 44, 9, 9, 'Parlante jbl', 'JBL', 'jbl', '1234567894', 'sin clave', 'sin clave', 'evaluacion completa', 'evaluacion completa', 'evaluacion completa', '2025-06-03 00:00:00', '2025-06-13 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-06-04 00:40:05', '2025-06-04 00:40:05'),
(71, 45, 8, 1, 'IMPRESORA', 'EPSON', 'L3250', 'EPSONL3250', 'NO APLICA', 'SIN ACCESORIOS', 'NO IMPRIME BIEN', 'NO FLUYE CORRECTAMENTE LA TINTA', 'EVALUACION COMPLETA', '2025-06-03 00:00:00', '2025-06-09 00:00:00', 0.00, 10000.00, 'Entregado', NULL, '2025-06-04 01:55:36', '2025-06-13 00:44:09'),
(72, 46, 8, 1, 'IMPRESORA', 'EPSON', 'L210', 'EPSONL210', 'NO APLICA', 'SIN CABLES', 'ESTÁ IMPRIMIENDO MAL', 'NECESITA MANTENCION', 'EVALUACION COMPLETA', '2025-06-04 00:00:00', '2025-06-09 00:00:00', 0.00, 30000.00, 'Entregado', NULL, '2025-06-04 18:51:55', '2025-06-13 00:42:51'),
(73, 46, 8, 1, 'NOTEBOOK', 'HP', '14-BP001LA', '5CD7323288', 'SIN CONTRASEÑA', 'SIN CARGADOR', 'NO FUNCIONAN LAS TECLAS', 'TECLADO CON FALLAS', 'EVALUACION DE TECLADO', '2025-06-04 00:00:00', '2025-06-13 00:00:00', 0.00, 18000.00, 'Entregado', NULL, '2025-06-04 18:54:41', '2025-06-13 00:42:24'),
(74, 46, 8, 1, 'NOTEBOOK', 'ACER', 'ASPIRE LITE 16 N24G1', 'NXKXDAL0074470339C4500', 'SIN CONTRASEÑA', 'SIN CARGADOR', 'FORMATEO SIN RESPALDO', 'FORMATEO SIN RESPALDO', 'FORMATEO SIN RESPALDO', '2025-06-04 00:00:00', '2025-06-09 00:00:00', 0.00, 0.00, 'Entregado', NULL, '2025-06-04 18:58:24', '2025-06-05 00:49:44'),
(75, 47, 8, 8, 'Impresora', 'Epson', 'L395', 'epsonl395', 'no aplica', 'sin cables', 'Imprime mal', 'Tiene tinta pero imprime con lineas', 'Evaluacion completa', '2025-06-05 00:00:00', '2025-06-10 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-06-06 00:55:32', '2025-06-06 00:55:32'),
(76, 48, 8, 1, 'Notebook', 'Lenovo', 'Yoga', 'Lenovoyoga', 'No recuerda la contraseña', 'Sin Cargador', 'Le cayó agua en el teclado', 'No funciona el teclado, no recuerda la contraseña', 'Evaluación completa', '2025-06-06 00:00:00', '2025-06-11 00:00:00', 0.00, 0.00, 'Reparando', NULL, '2025-06-06 21:32:13', '2025-06-13 00:40:11'),
(77, 49, 8, 1, 'Notebook', 'HP', '11-k172la', '8CG532111X', 'Sin contraseña', 'Sin cargador', 'Funciona demasiado lento', 'Tiene disco mecánico', 'Cambio de disco ssd 240 gb', '2025-06-06 00:00:00', '2025-06-11 00:00:00', 0.00, 65000.00, 'Entregado', NULL, '2025-06-06 23:20:32', '2025-06-13 00:39:58'),
(78, 50, 7, 7, 'Notebook', 'HP', '13-BA1123LA', '13-BA1123LA', 'No aplica', 'con Cargador', 'equipo no arranca sistema operativo', 'Problemas de arranque (evaluacion completa', 'evaluacion de disco y visagras', '2025-06-09 00:00:00', '2025-06-16 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-06-09 22:07:31', '2025-06-09 22:07:31'),
(79, 51, 8, 1, 'NMotebook', 'Packardbell', 'Easynote ENTG71BM', 'ENTG71BM', 'SIN CALAVE', 'sin cargador', 'Equipo lento', 'Equipo de bajo rendimiento se recomienda  cambio de disco duro', 'Cambio de disco ssd de 240 gigas', '2025-06-09 00:00:00', '2025-06-13 00:00:00', 0.00, 65000.00, 'Entregado', NULL, '2025-06-09 22:21:07', '2025-06-13 00:37:56'),
(80, 52, 8, 1, 'OMEN', 'HP', '16-B0509LA', '5CD145P9TP', '2068', 'CON CARGADOR', 'MODELO NUEVO PERO NO ESTÁ EN GARANTÍA', 'LA BATERIA NO FUNCIONA', 'EVALUACION COMPLETA', '2025-06-09 00:00:00', '2025-06-12 00:00:00', 0.00, 18000.00, 'Entregado', NULL, '2025-06-09 23:16:35', '2025-06-13 00:38:11'),
(81, 53, 7, 1, 'consola xbox', 'xbox one s', 'xbox one s', '123456789987624', 'sin clave', 'sin cables', 'limpieza de ventilación mas cambio de pasta termica', 'limpieza de ventilación mas cambio de pasta termica', 'limpieza de ventilación mas cambio de pasta termica', '2025-06-09 00:00:00', '2025-06-13 00:00:00', 0.00, 25000.00, 'Entregado', NULL, '2025-06-10 02:16:59', '2025-06-25 02:20:52'),
(82, 54, 8, 8, 'Pavilion x360', 'HP', '14-ba002la', '8CG75004KB', 'NO RECUERDA EL CLIENTE', 'SIN CARGADOR', 'EVALUACION COMPLETA', 'NO ARRANCA EL SISTEMA OPERATIVO', 'EVALUACION COMPLETA', '2025-06-09 00:00:00', '2025-06-13 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-06-10 02:44:13', '2025-06-10 02:44:13'),
(83, 55, 9, 1, 'Notebook', 'Toshiba', 'Satelite C45 -A4120FL', '2E0561980', 'NO APLICA', 'Sin Accesorios', 'Equipo no Arranca sistema operativo', 'problemas de arranque de sist. operativo', 'Cambio de disco y extraccion de datos', '2025-06-06 00:00:00', '2025-06-16 00:00:00', 30000.00, 90000.00, 'Reparando', NULL, '2025-06-10 18:46:10', '2025-06-10 22:46:48'),
(84, 56, 7, 7, 'pc de escritorio', 'armado', 'armado', '32165489852', 'sin clave', 'sin cables', 'el equipo recibió orina de gato', 'el equipo resivio orina de gato', 'evaluacion completa', '2025-06-11 00:00:00', '2025-06-18 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-06-11 19:18:28', '2025-06-11 19:18:28'),
(85, 57, 7, 7, 'impresora', 'canon', 'G2110', '1765', 'sin clave', 'sin cables', 'evaluacion completa', 'la impresora no esta imprimiendo  bien', 'la impresora no esta imprimiendo  bien', '2025-06-13 00:00:00', '2025-06-17 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-06-13 18:11:37', '2025-06-13 18:11:37'),
(86, 58, 8, 1, 'A12', 'Samsung', 'SM-A127M/DS', 'SAMSUNGA12', 'NO APLICA', 'SIN ACCESORIOS', 'LA PANTALLA NO DA IMAGEN', 'PANTALLA DEFECTUOSA', 'CAMBIO DE PANTALLA', '2025-06-13 00:00:00', '2025-06-18 00:00:00', 0.00, 0.00, 'Entregado', NULL, '2025-06-14 00:19:28', '2025-06-25 02:22:17'),
(87, 59, 7, 1, 'notenbook', 'ASUS', 'x505z', 'L3N0CX055150118', '703012', 'SIN CARGADOR', 'EVALUACION COMPLETA', 'EL EQUIPO  NO LE ESTA RECONOCIENDO LA TARJETA WIFI', 'EL EQUIPO  NO LE ESTA RECONOCIENDO LA TARJETA WIFI', '2025-06-13 00:00:00', '2025-06-17 00:00:00', 0.00, 10000.00, 'Entregado', NULL, '2025-06-14 01:05:30', '2025-06-25 02:22:46'),
(88, 60, 7, 7, 'IMPRESORA', 'EPSON', 'L3150', '33311122', 'SIN CLAVE', 'SIN CABLES', 'EVALUACION COMPLETA', 'NO ESTA IMPRIMIENDO EL COLOR NEGRO', 'NO ESTA IMPRIMIENDO EL COLOR NEGRO', '2025-06-13 00:00:00', '2025-06-19 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-06-14 01:37:23', '2025-06-14 01:37:23'),
(89, 61, 9, 1, 'Notebook', 'HP', '348 G7', '5CG1202X5Q', 'No aplica', 'caja y cargador', 'problemas de lentitud', 'Equipo lento  no arranca sistema operativo', 'Cambio de disco SSD 250 GIGAS', '2025-06-14 00:00:00', '2025-06-17 00:00:00', 0.00, 90000.00, 'Entregado', NULL, '2025-06-15 00:07:42', '2025-06-25 02:20:18'),
(90, 25, 7, 1, 'notenbook', 'HP', '240G8', '123456789987', 'sin clave', 'sin cargador', 'evaluacion completa', 'el equipo tiene rastro de cafe y no enciende mas parpadea el bloqueo mayuscula', 'el equipo tiene rastro de cafe y no enciende mas parpadea el bloqueo mayuscula', '2025-06-16 00:00:00', '2025-06-20 00:00:00', 0.00, 0.00, 'Entregado', NULL, '2025-06-16 19:08:09', '2025-06-25 02:21:39'),
(91, 62, 7, 1, 'notenbook', 'Dell', 'p60g', '222555666', 'sin clave', 'Con cargador', 'evaluacion completa', 'el equipo paso mucho tiempo apagado mas da unos pitidos extraños y tienen un pixel dañado en la pantalla', 'el equipo paso mucho tiempo apagado mas da unos pitidos extraños y tienen un pixel dañado en la pantalla', '2025-06-19 00:00:00', '2025-06-25 00:00:00', 0.00, 0.00, 'Reparando', NULL, '2025-06-19 19:21:11', '2025-06-25 02:21:21'),
(92, 24, 8, 8, 'Victus', 'hp', '15-fb0104la', '5cd3194gtb', '2310', 'Con Cargador', 'Equipo se va a negro después de unos minutos', 'Equipo se va a negro después de unos minutos', 'Evaluacion Completa', '2025-06-19 00:00:00', '2025-06-26 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-06-19 20:49:08', '2025-06-19 20:49:08'),
(93, 112, 7, 1, 'Notebook', 'Lenovo', 'Ideapad3 14ii05la', '666666', 'no aplica', 'sin accesorios', 'daño visual en caracasa de pantalla', 'problemas de arranque en sistema', 'evaluacion completa', '2025-06-20 00:00:00', '2025-06-24 00:00:00', 0.00, 10000.00, 'Reparando', NULL, '2025-06-20 21:20:40', '2025-06-25 02:21:03'),
(94, 113, 8, 8, 'Notebook', 'Lenovo', 'Ideapad flex 514ARE05', 'R945J2DR', '1307', 'Sin cargador', 'No funcionan ciertas teclas', 'Teclado con falla', 'Descartar teclado dañado', '2025-06-23 00:00:00', '2025-06-26 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-06-23 20:32:41', '2025-06-23 20:32:41'),
(95, 114, 8, 8, 'Notebook', 'Acer', 'AN515-43-R42V', '02511629934', 'NO APLICA', 'con cargador', 'equipo no presenta imagen', 'no arranca y no se visualiza imagen', 'evaluacion de componentes', '2025-06-23 00:00:00', '2025-06-27 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-06-23 21:30:32', '2025-06-23 21:30:32'),
(96, 115, 7, 1, 'all in one', 'HP', 'HP  pavilion 20', '1236354228741', 'sin clave', 'sin cargador', 'formatear sin respaldo', 'el equipo  anda lento', 'formatear sin respaldo', '2025-06-23 00:00:00', '2025-06-27 00:00:00', 0.00, 18000.00, 'Entregado', NULL, '2025-06-24 00:54:51', '2025-07-18 23:50:19'),
(97, 116, 7, 1, 'vhs', 'vhs', 'vhs', '123456789963', 'sin clave', 'sin accesorios', 'traspaso de vhs', 'hablarle por whatsapp cuando este listo', 'traspaso de vhs', '2025-06-24 00:00:00', '2025-06-30 00:00:00', 0.00, 0.00, 'Entregado', NULL, '2025-06-24 22:50:21', '2025-07-18 23:50:00'),
(98, 117, 8, 1, 'Notebook', 'Asus', 'X1605Z', 'ASUSX1605Z', 'SIN CLAVE', 'EN CAJA + DISCO SSD', 'RESPALDAR INFORMACIÓN DEL DISCO SSD AL NOTE ASUS', 'NUEVO EN CAJA', 'RESPALDO DE INFORMACION', '2025-06-25 00:00:00', '2025-06-27 00:00:00', 0.00, 0.00, 'Entregado', NULL, '2025-06-25 18:32:51', '2025-07-18 23:49:50'),
(99, 118, 8, 1, 'Notebook', 'Hp', '14-cf3028la', '30280000', 'no aplica', 'sin accesorios', 'sin cargador', 'Equipo lento al arranque y problemas de estrabilidad', 'Formateo sin Respaldos', '2025-06-26 00:00:00', '2025-06-23 00:00:00', 0.00, 18000.00, 'Entregado', NULL, '2025-06-27 03:19:45', '2025-07-05 02:48:22'),
(100, 119, 8, 1, 'Notebook', 'Lenovo', 'IDEAPAD GAMING 3', 'gaming3', 'Sin Clave', 'Con cargador', 'Tiene disco mecánico', 'Funciona demasiado lento. Cambiar disco a sólido.', 'Cambio de disco ssd 240 gb', '2025-06-27 00:00:00', '2025-07-03 00:00:00', 0.00, 68000.00, 'Entregado', NULL, '2025-06-27 22:21:09', '2025-07-18 23:49:24'),
(101, 120, 8, 8, 'Notebook', 'Asus y hp', 'x407m y 14-av006la', 'x407ma-bv07', 'sin clave', 'sin accesorios', '2 equipos de diferentes marcas', 'asus  problema de energia / hp problemas de lentitus', 'evaluacion de ambos equipos', '2025-06-27 00:00:00', '2025-07-01 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-06-27 22:55:25', '2025-06-27 22:55:25'),
(102, 121, 7, 1, 'notenbook', 'Dell', 'P35g', '789456123118', 'sin clave', 'sin cargador', 'Pedir Flex de video el cliente abono $20.000 el cliente se llevo el equipo', 'no da imagen en la pantallas', 'evaluacion completa mas cotizacion de baterias', '2025-07-01 00:00:00', '2025-07-07 00:00:00', 20000.00, 40000.00, 'Entregado', NULL, '2025-07-01 21:05:19', '2025-07-18 23:50:47'),
(103, 122, 7, 1, 'Notebook', 'Lenovo', 'V14-ADA', 'pf34v79d', 'sin clave', 'sin cargador', 'solo montaje de teclado mandar valores', 'solo montaje de teclado mandar valores', 'solo montaje de teclado mandar valores', '2025-07-01 00:00:00', '2025-07-03 00:00:00', 0.00, 25000.00, 'Entregado', NULL, '2025-07-01 22:21:26', '2025-07-18 23:51:06'),
(104, 123, 8, 8, 'Notebook', 'Asus', 'S403J', 'ASUSS403J', 'SIN CLAVE', 'SIN CARGADOR', 'Trae el bisel suelto y probablemente  soportes dañados', 'Se cayó y ahora la pantalla se va a negro al mover el equipo.', 'Evaluación completa', '2025-07-02 00:00:00', '2025-07-08 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-07-02 20:20:24', '2025-07-02 20:20:24'),
(105, 124, 8, 1, 'Impresora', 'Epson', 'L475', 'epsonl475', 'No aplica', 'Sin accesorios', 'Se equivocaron al recargar la tinta cyan. Está verde.,', 'Desea mantención completa.', 'Evaluar y entregar diagnostico completo antes.', '2025-07-02 00:00:00', '2025-07-09 00:00:00', 0.00, 45000.00, 'Entregado', NULL, '2025-07-02 21:06:28', '2025-07-18 23:51:43'),
(106, 125, 7, 1, 'notebook', 'HP', '240-G7', '213546978546', 'Sin clave', 'sin cargador', 'NO DEJARÁ LOS EQUIPOS!', 'Cotizacion de mejoras para 3 equipos mas mantencion  mas 1 cargador  HP  pin azul  mas 3 Adaptador Enchufe americano', 'Cotizacion', '2025-07-03 00:00:00', '2025-07-16 00:00:00', 0.00, 0.00, 'Entregado', NULL, '2025-07-03 21:43:16', '2025-07-18 23:51:57'),
(107, 125, 7, 1, 'notebook', 'HP', '245-G10', '2136549851251', 'SIN CLAVE', 'SIN CARGADOR', 'NO DEJARÁ LOS EQUIPOS!', 'Cotizacion para 3  equipo con de office permanente', 'Cotizacion para 3  equipo con de office permanente', '2025-07-03 00:00:00', '2025-07-09 00:00:00', 0.00, 0.00, 'Entregado', NULL, '2025-07-03 21:47:56', '2025-07-18 23:52:03'),
(108, 126, 7, 1, 'Notenbook', 'lenovo', 'ideapad s340-14iil', 'MPNXB9C2302X', 'Sin clave', 'Sin cargador', 'Cambio de pantalla', 'Cambio de pantalla', 'Cambio de pantalla', '2025-07-03 00:00:00', '2025-07-08 00:00:00', 0.00, 100000.00, 'Entregado', NULL, '2025-07-04 00:48:51', '2025-07-18 23:52:27'),
(109, 127, 7, 1, 'All in one', 'HP', '20-c213La', '8cc83206df', 'Sin clave', 'Sin cargador', 'evaluacion completa', 'el equipo anda muy lento y se pega', 'el equipo anda muy lento y se pega', '2025-07-07 00:00:00', '2025-07-10 00:00:00', 0.00, 88000.00, 'Entregado', NULL, '2025-07-07 20:36:16', '2025-07-18 23:53:12'),
(110, 128, 8, 1, 'NOTEBOOK', 'HP', '15-EH0005LA', '5CD210HCJY', '1009 o 1007', 'sin accesorios', 'No arroja ped en la tecla mayúscula.', 'Equipo no enciende.', 'Evaluacion completa', '2025-07-07 00:00:00', '2025-07-11 00:00:00', 0.00, 10000.00, 'Entregado', NULL, '2025-07-08 02:59:49', '2025-07-18 23:53:25'),
(111, 129, 7, 7, 'Impresora', 'Epson', 'L3110', '12356648518', 'sin clave', 'sin cables', 'evaluacion completa', 'evaluacion completa', 'evaluacion completa', '2025-07-08 00:00:00', '2025-07-08 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-07-09 03:05:39', '2025-07-09 03:05:39'),
(112, 130, 7, 1, 'Notebook', 'Lenovo', 'thinkpad', '0012121', 'sin clave', 'con cargador', 'sistema op w7', 'Actualizacion de sist operativo', 'formateo sin respaldos', '2025-07-08 00:00:00', '2025-07-09 00:00:00', 0.00, 18000.00, 'Entregado', NULL, '2025-07-09 04:07:58', '2025-07-18 23:54:24'),
(113, 131, 7, 1, 'IMPRESORA', 'CANON', 'G4110', '123548715', 'SIN CLAVE', 'SIN CABLES', 'LA IMPRESORA NO TOMA BIEN LA HOJA', 'LA IMPRESORA NO TOMA BIEN LA HOJA', 'EVLAUCION COMPLETA', '2025-07-09 00:00:00', '2025-07-16 00:00:00', 0.00, 15000.00, 'Entregado', NULL, '2025-07-10 02:49:14', '2025-07-18 23:54:42'),
(114, 132, 8, 1, 'Notebook', 'Samsung', 'NP270E5G', 'JHUK91HD900138P', 'No recuerda si tiene clave', 'Sin accesorios', 'El equipo viene sin una tecla direccional.', 'Desea realizarle', 'Evaluacion completa', '2025-07-10 00:00:00', '2025-07-16 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-07-10 18:28:08', '2025-07-18 23:48:07'),
(115, 133, 8, 1, 'Notebook', 'Acer', 'Aspire A515-54', 'NXHMDAL01611103D687600', 'Rs142857', 'sin cargador', 'Parlante con fallas. Office pide activación.', 'Parlante con fallas. Office pide activación.', 'Evaluacion completa', '2025-07-10 00:00:00', '2025-07-15 00:00:00', 0.00, 8000.00, 'Entregado', NULL, '2025-07-10 19:01:26', '2025-07-18 23:55:22'),
(116, 133, 8, 1, 'Notebook', 'HP', '15-ef256la', '5CD413G9DS', '1912', 'Sin cargador', 'No tiene office.', 'Desea office permanente.', 'Instalación de licencia de office', '2025-07-10 00:00:00', '2025-07-23 00:00:00', 0.00, 45000.00, 'Entregado', NULL, '2025-07-10 19:03:32', '2025-07-18 23:55:40'),
(117, 134, 7, 1, 'Notebook', 'HP Omen', '15-ce004la', '123489175', 'Sin Clave', 'Con cargador', 'Formateo sin respaldo', 'Formateo sin respaldo', 'Formateo sin respaldo', '2025-07-11 00:00:00', '2025-07-16 00:00:00', 0.00, 18000.00, 'Entregado', NULL, '2025-07-12 00:02:48', '2025-07-18 23:55:56'),
(118, 135, 8, 1, 'impresora', 'epson', 'l120', 'l120000', 'no aplica', 'sin accesorios', 'sin uso prolongado', 'mantencion', 'mantencion completa', '2025-07-12 00:00:00', '2025-07-15 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-07-12 19:53:46', '2025-10-13 23:13:44'),
(119, 136, 7, 1, 'Notenbook', 'HP', '14-ck0036la', '126187156165', 'Sin clave', 'Sin cargador', 'Formateo con respaldo mas instalacion de driver a impresora HP', 'Mas dejar la impresora para instalar driver de la impresora', 'Formateo con respaldo mas instalacion de driver a impresora HP', '2025-07-14 00:00:00', '2025-07-18 00:00:00', 0.00, 23000.00, 'Entregado', NULL, '2025-07-14 19:53:39', '2025-07-18 23:56:35'),
(120, 125, 7, 1, 'Notebook', 'HP', 'HP', '5CG509127B', 'SIN CALVE', 'SIN CARGADOR', 'INSTALACIÓN DE OFFICE PERMANENTE', 'INSTALACIÓN DE OFFICE PERMANENTE', 'INSTALACIÓN DE OFFICE PERMANENTE', '2025-07-17 00:00:00', '2025-07-23 00:00:00', 0.00, 45000.00, 'Entregado', NULL, '2025-07-17 22:08:47', '2025-07-29 02:39:37'),
(121, 125, 7, 1, 'NOTEBOOK', 'HP', 'HP 245-G10', '121877474774', 'SIN CLAVE', 'SIN CARGADOR', 'INSTALACIÓN DE OFFICE PERMANENTE', 'INSTALACIÓN DE OFFICE PERMANENTE', 'INSTALACIÓN DE OFFICE PERMANENTE', '2025-07-17 00:00:00', '2025-07-23 00:00:00', 0.00, 45000.00, 'Entregado', NULL, '2025-07-17 22:10:45', '2025-07-29 02:39:21'),
(122, 125, 7, 1, 'NOTEBOOK', 'HP', 'HP 245-G10', '78948594984', 'SIN CLAVE', 'SIN CARGADOR', 'ISTALACION DE OFFICE PERMANENTE', 'ISTALACION DE OFFICE PERMANENTE', 'ISTALACION DE OFFICE PERMANENTE', '2025-07-17 00:00:00', '2025-07-23 00:00:00', 0.00, 48000.00, 'Entregado', NULL, '2025-07-17 22:12:17', '2025-07-29 02:39:00'),
(123, 125, 7, 1, 'HP', 'HP', 'HP 240 G7', '16554184618', 'SIN CLAVE', 'SIN CARCAGDOR', 'Mantencion al sistema de ventilacion + cambio de pasta disipadora', 'Mantencion al sistema de ventilacion + cambio de pasta disipadora', 'Mantencion al sistema de ventilacion + cambio de pasta disipadora', '2025-07-17 00:00:00', '2025-07-24 00:00:00', 0.00, 48000.00, 'Entregado', NULL, '2025-07-17 22:16:48', '2025-07-29 02:38:39'),
(124, 125, 7, 1, 'NOTEBOOK', 'HP', 'HP 240 G7', '4811818181', 'SIN CLAVE', 'SIN CARGADOR', 'Mantencion al sistema de ventilacion + cambio de pasta disipadora', 'Mantencion al sistema de ventilacion + cambio de pasta disipadora', 'Mantencion al sistema de ventilacion + cambio de pasta disipadora', '2025-07-17 00:00:00', '2025-07-24 00:00:00', 0.00, 48000.00, 'Entregado', NULL, '2025-07-17 22:18:23', '2025-07-29 02:38:22'),
(125, 137, 7, 1, 'Notebook', 'HP', 'HP 240 G7', '213415432441', 'Sin clave', 'Sin Cargador', 'Cambio de Pantalla Usada la pantalla quedo Cancelada $60.000', 'Cambio de Pantalla Usada', 'Cambio de Pantalla Usada la pantalla quedo Cancelada $60.000', '2025-07-17 00:00:00', '2025-07-22 00:00:00', 0.00, 68000.00, 'Entregado', NULL, '2025-07-18 02:09:20', '2025-07-29 02:36:06'),
(126, 138, 8, 1, 'Notebook', 'Dell', 'Inspiron 3505', 'H3DQRK3', 'Milenio', 'Sin cargador', 'Conecta a red pero no llega internet', 'problemas de red y bluetooth', 'Formateo con respaldo', '2025-07-21 00:00:00', '2025-07-25 00:00:00', 0.00, 23000.00, 'Entregado', NULL, '2025-07-21 18:27:23', '2025-07-29 02:35:26'),
(127, 139, 7, 1, 'notebook', 'Asus', 'X420F', '1851813181', 'Sin clave', 'sin cargador', 'EVALUACION COMPLETA', 'EL EQUIPO NO ESTA RECIBIENDO ENERGIA', 'EL EQUIPO NO ESTA RECIBIENDO ENERGIA', '2025-07-21 00:00:00', '2025-07-25 00:00:00', 0.00, 0.00, 'Reparando', NULL, '2025-07-21 20:20:11', '2025-07-29 02:35:04'),
(128, 140, 8, 1, 'Impresora', 'Epson', 'L3250', 'epsonl3250', 'no aplica', 'sin cables', 'jalaron la hoja para tirar el papel atascado y fue demasiado brusco', 'atasco y daño al retirar papel', 'evaluacion completa', '2025-07-21 00:00:00', '2025-07-25 00:00:00', 0.00, 0.00, 'Reparando', NULL, '2025-07-21 23:11:57', '2025-07-29 02:34:12'),
(129, 141, 8, 1, 'Iphone', 'Iphone', '6s plus', 'iphone6s', 'no aplica', 'sin accesorios', 'Tiene la pantalla dañada', 'Tiene la pantalla dañada', 'Cambio de pantalla', '2025-07-21 00:00:00', '2025-07-25 00:00:00', 0.00, 0.00, 'Entregado', NULL, '2025-07-22 02:42:49', '2025-07-29 02:33:28'),
(130, 36, 7, 1, 'impresora', 'hp', 'L3110', '285181681651', 'Sin clave', 'sin cargador', 'evaluacion completa', 'Esta dañada la fuente de poder mas no está imprimiendo bien los coloros y negro', 'Esta dañada la fuente de poder mas no está imprimiendo bien los coloros y negro', '2025-07-21 00:00:00', '2025-07-28 00:00:00', 0.00, 63000.00, 'Entregado', NULL, '2025-07-22 03:03:35', '2025-07-29 02:33:00'),
(131, 142, 8, 1, 'Notebook', 'HP', 'Probook 450 G9', '5CD3251MR3', 'CON CLAVE', 'Sin Cargador', 'Tiene clave pero desea dejarlo en 0', 'No recuerda contraseña', 'Formateo con respaldo', '2025-07-22 00:00:00', '2025-07-28 00:00:00', 0.00, 18000.00, 'Entregado', NULL, '2025-07-22 22:25:06', '2025-07-29 02:30:03'),
(132, 142, 8, 1, 'Impresora', 'Epson', 'L4150', 'epsonl4150', 'no aplica', 'Sin cables', 'No imprimen hace 2 meses con la maquina', 'No fluian bien los colores', 'Evaluación completa', '2025-07-22 00:00:00', '2025-07-29 00:00:00', 0.00, 18000.00, 'Entregado', NULL, '2025-07-22 22:26:22', '2025-07-29 02:29:30'),
(133, 143, 8, 1, 'Equipo de Escritorio', 'Multimarca', 'armado', '0012455', 'sin clave', '2 unidades de disco mecanicos', 'equipo con fallas de disco', 'problemas den disco duro', 'instalacion ssd 480', '2025-07-22 00:00:00', '2025-07-25 00:00:00', 0.00, 80000.00, 'Entregado', NULL, '2025-07-22 23:01:02', '2025-07-29 02:28:18'),
(134, 144, 7, 1, 'All in one', 'Lenovo', 'F0D7', 'TJ016P8D', '1904', 'SIN CARGADO', 'Evaluacion completa  llamar al cliente', 'El equipo  anda muy lento', 'El equipo  anda muy lento', '2025-07-23 00:00:00', '2025-07-31 00:00:00', 0.00, 0.00, 'Reparando', NULL, '2025-07-23 21:25:42', '2025-07-29 02:27:56'),
(135, 145, 7, 1, 'Notebook', 'Acer', 'Aspire 3 A314', 'NXHVVAL0070410935E7600', 'SIN CLAVE', 'SIN CARGADO', 'INSTALACIÓN DE OFFICE CRACKEADO', 'MAS DEJARA UNA IMPRESORA PARA INSTALACIÓN DE DRIVER', 'INSTALACIÓN DE OFFICE MAS DEJARA UNA IMPRESORA PARA INSTALACIÓN DE DRIVER', '2025-07-24 00:00:00', '2025-07-31 00:00:00', 0.00, 18000.00, 'Entregado', NULL, '2025-07-25 00:40:18', '2025-07-29 02:27:44'),
(136, 146, 7, 1, 'movil', 'Samsung', 'A12', 'a125m', 'Sin clave', 'Sin cargador', 'Evaluacion completa', 'El equipo se apaga de repente y no volvio a encender', 'El equipo se apaga de repente y no volvio a encender', '2025-07-28 00:00:00', '2025-07-31 00:00:00', 0.00, 0.00, 'Reparando', NULL, '2025-07-28 20:57:37', '2025-07-29 02:30:51'),
(137, 147, 7, 1, 'Notebook', 'HP', '14-am015la', '5cg6382ft5', 'bairon01234', 'Sin cargador', 'Formateo con respaldo', 'Formateo con respaldo', 'Formateo con respaldo', '2025-07-30 00:00:00', '2025-08-01 00:00:00', 0.00, 23000.00, 'Ingresado', NULL, '2025-07-30 19:06:42', '2025-07-30 19:19:06'),
(138, 148, 8, 8, 'Huawei', 'Huawei', 'Dongguan 523808', 'GAPPM21929002506', '101935', 'CON CARGADOR', 'El equipo fue llevado a un servicio tecnico previamente.', 'No enciende.', 'Evaluacion completa', '2025-08-01 00:00:00', '2025-08-07 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-08-01 21:59:02', '2025-08-01 21:59:02'),
(139, 149, 8, 8, 'Notebook', 'Lenovo', '82C4', 'PF39YV2L', 'NO APLICA', 'Sin cargador', 'intel i3', 'Está infectado, demasiada publicidad', 'Formateo sin respaldo', '2025-08-01 00:00:00', '2025-08-06 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-08-02 00:40:16', '2025-08-02 00:40:16'),
(140, 149, 8, 8, 'Ideapad 3 15ADA05', 'Lenovo', '81w1', 'PF39X0QC', 'NO APLICA', 'SIN CARGADOR', 'Demasiada lentitud al operar', 'Demasiada lentitud al operar', 'Cotizar cambio de disco y aumento de ram', '2025-08-01 00:00:00', '2025-08-14 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-08-02 00:42:50', '2025-08-02 00:42:50'),
(141, 150, 7, 7, 'tarjeta', 'tarjeta', 'tarjeta', '1651551515151515', 'tarjeta', 'sin cargador', 'impresion de 100 tarjetas y cortadas', 'impresion de 100 tarjetas y cortada', 'impresion de 100 tarjetas y cortada', '2025-08-01 00:00:00', '2025-08-05 00:00:00', 10000.00, 15000.00, 'Ingresado', NULL, '2025-08-02 01:44:16', '2025-08-02 01:44:16'),
(142, 151, 8, 8, 'Impresora', 'Epson', 'L3110', 'epsonl3110', 'no aplica', 'Sin cables', 'Cliente quito atasco de papel algo brusco', 'imprime entre cortado', 'Evaluacion completa', '2025-08-04 00:00:00', '2025-08-08 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-08-04 19:34:33', '2025-08-04 19:34:33'),
(143, 152, 7, 7, 'Notebook', 'Acer', 'Nitrp 5 AN515', '252525251741747', 'SIN CLAVE', 'Con cargador', 'Limpieza de sistema de ventilacion mas formateo sin respaldo', 'Limpieza de sistema de ventilacion mas formateo sin respaldo', 'Limpieza de sistema de ventilacion mas formateo sin respaldo', '2025-08-04 00:00:00', '2025-08-05 00:00:00', 0.00, 43000.00, 'Ingresado', NULL, '2025-08-04 23:30:11', '2025-08-04 23:30:11'),
(144, 153, 7, 7, 'notebook', 'HP', '13-an1010la', '1265168686818618', 'walter0450', 'Sin cargador', 'evaluacion completa', 'la pantalla parpadea  y queda en negro', 'la pantalla parpadea  y queda en negro', '2025-08-05 00:00:00', '2025-08-07 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-08-06 01:38:27', '2025-08-06 01:38:27'),
(145, 154, 7, 7, 'pc', 'armado', 'armado', '1231817114486', 'Sin clave', 'Sin cables', 'Formateo sin respaldo', 'Formateo sin respaldo', 'Formateo sin respaldo', '2025-08-06 00:00:00', '2025-08-08 00:00:00', 0.00, 18000.00, 'Ingresado', NULL, '2025-08-06 23:09:18', '2025-08-06 23:09:18'),
(146, 155, 7, 7, 'IMPRESORA', 'EPSON', 'F170', '59818918911', 'SIN CLAVE', 'SIN CARGADOR', 'NO ESTAS BAJANDO BIEN LOS COLORES MAS TIRA EL ERROR DE CAJA DE MANTENIMIOENTO', 'NO ESTAS BAJANDO BIEN LOS COLORES MAS TIRA EL ERROR DE CAJA DE MANTENIMIOENTO', 'EVALUACION COMPLETA', '2025-08-06 00:00:00', '2025-08-14 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-08-07 02:19:41', '2025-08-07 02:19:41'),
(147, 156, 8, 8, 'Impresora', 'Epson', 'L3110', 'Epsonl3110', 'No aplica', 'Sin Cables', 'Magente y yellow bajos. Dejar llenos.', 'No está imprimiendo.', 'Evaluacion completa. Enviar Valores.', '2025-08-06 00:00:00', '2025-08-12 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-08-07 02:46:36', '2025-08-07 02:46:36'),
(148, 157, 8, 8, 'Impresora', 'Epson', 'L4160', 'epsonl4160', 'no aplica', 'sin cables', 'Posible pieza suelta.', 'No imprime.', 'Evaluación completa.', '2025-08-07 00:00:00', '2025-08-12 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-08-08 03:02:11', '2025-08-08 03:02:11'),
(149, 158, 8, 8, 'Notebook', 'HP', '14-dq2026la', '5cd129b8y2', 'hola', 'sin cargador', 'Inaccesible boot device', 'No arranca el sistema.', 'Evaluar disco duro.', '2025-08-08 00:00:00', '2025-08-13 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-08-08 19:25:47', '2025-08-08 19:25:47'),
(150, 159, 8, 8, 'PRESARIO', 'COMPAQ', 'CQ40', 'CND0062JLL', 'SIN CLAVE', 'SIN CARGADOR', 'PANTALLA DAÑADA', 'PANTALLA DAÑADA', 'CAMBIO DE PANTALLA USADA MAS CARGADOR USADO.', '2025-08-08 00:00:00', '2025-08-13 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-08-09 01:26:10', '2025-08-09 01:26:10'),
(151, 159, 8, 8, 'ES1-411 SERIES', 'ACER', 'ES1-411-28SF', 'NXMRUAL0084350B3407600', 'NO LA RECUERDA', 'SIN CARGADOR', 'DESEA FORMATEAR Y UN CARGADOR.', 'NO RECUERDA LA CONTRASEÑA.', 'EVALUAR DISCO ANTES DE FORMATEAR. CON RESPALDO.', '2025-08-08 00:00:00', '2025-08-13 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-08-09 01:29:31', '2025-08-09 01:29:31'),
(152, 160, 8, 1, 'V110-14IAP', 'Lenovo', '80TF', 'R90PPMGE', 'Sin clave', 'Sin cargador', 'Office desactivado', 'Licencia crackeada', 'Instalar Licencia office permanente', '2025-08-11 00:00:00', '2025-08-13 00:00:00', 0.00, 45000.00, 'Ingresado', NULL, '2025-08-11 21:22:18', '2025-08-12 01:50:49'),
(153, 153, 7, 7, 'netonbook', 'HP', '240G7', '27144719871981', 'Sin Clave', 'Sin Cargador', 'Cotizacion de carcasa de teclado por soportes dañados', 'el equipo tiene los soporte de bisagra dañados', 'Cotizacion de carcasa de teclado por soportes dañados', '2025-08-12 00:00:00', '2025-08-14 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-08-12 23:18:55', '2025-08-12 23:18:55'),
(154, 159, 8, 8, 'Notebook', 'Acer', 'ES1-411-28SF', 'NXMRUAL0084350B3407600', 'SIN CLAVE', 'SIN CARGADOR', 'NO FUNCIONA TOUCHPAD.', 'LENTITUD.  AUMENTAR A 4GB EN RAM (CORTESIA DEL LOCAL)', 'CAMBIO DE DISCO SSD 240 GB', '2025-08-13 00:00:00', '2025-08-18 00:00:00', 0.00, 68000.00, 'Ingresado', NULL, '2025-08-14 02:42:56', '2025-08-14 02:42:56'),
(155, 161, 8, 8, 'Notebook', 'Hp', '14-dq1001la', '5cd020bn4w', '361467', 'Sin cargador', 'Tiene i3-10th', 'Está demasiado lento.', 'Cambio de disco y aumento de ram a 8 gb ddr4.', '2025-08-18 00:00:00', '2025-08-25 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-08-18 19:03:16', '2025-08-18 19:03:16'),
(156, 162, 8, 8, 'Ideapad s340-14iwl', 'Lenovo', '81N7', 'MP1NT8F8', 'No aplica', 'Sin cargador', 'Cliente le cambio el disco ssd.', 'Está sin sistema operativo.', 'Instalacion sistema operativo + office permanente.', '2025-08-18 00:00:00', '2025-08-22 00:00:00', 0.00, 63000.00, 'Ingresado', NULL, '2025-08-18 19:41:38', '2025-08-18 19:41:38'),
(157, 163, 7, 7, 'Notebook gamer', 'Asus', 'FX506L', '11561851531D5A15SD', '2408', 'CON CARGADOR', 'INSTALACIÓN DE OFFICE PERMANENTE', 'INSTALACIÓN DE OFFICE PERMANENTE', 'INSTALACIÓN DE OFFICE PERMANENTE', '2025-08-18 00:00:00', '2025-08-19 00:00:00', 0.00, 45000.00, 'Ingresado', NULL, '2025-08-19 02:30:12', '2025-08-19 02:30:12'),
(158, 28, 7, 1, 'notebook', 'HP', '240G6', '5cd7453tk7', 'Sin clave', 'Sin cargador', 'Formateo sin respaldo Mas limpieza de ventilacion y cotización de bateria', 'Formateo sin respaldo Mas limpieza de ventilacion y cotización de bateria', 'Formateo sin respaldo Mas limpieza de ventilacion y cotización de bateria', '2025-08-18 00:00:00', '2025-08-21 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-08-19 02:35:05', '2025-08-19 02:43:36'),
(159, 164, 8, 8, 'Inspiron 14', 'Lenovo', 'Inspiron 14', '6WCNXB2', 'SIN CLAVE', 'SIN CARGADOR', 'PROCESADOR INTEL', 'DEMASIADO LENTO', 'CAMBIO DE DISCO SSD 240 GB', '2025-08-19 00:00:00', '2025-08-22 00:00:00', 0.00, 68000.00, 'Ingresado', NULL, '2025-08-19 20:18:36', '2025-08-19 20:18:36'),
(160, 165, 7, 7, 'Notebook', 'HP', '11-k1la', '2516818181818', 'Sin clave', 'Sin Cargador', 'Evaluacion completa', 'el equipo no esta arrancando el sistema operativo', 'el equipo no esta arrancando el sistema operativo', '2025-08-21 00:00:00', '2025-08-25 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-08-22 02:04:24', '2025-08-22 02:04:24'),
(161, 148, 7, 7, 'Notebook', 'Huawei', 'Huawei 123456', '12316818884', 'Sin clave', 'Con cargador', 'evaluacion completa', 'el equipo se descargó y no volvio encender y no resive energia', 'el equipo se descargó y no volvio encender y no resive energia', '2025-08-25 00:00:00', '2025-08-26 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-08-25 18:19:06', '2025-08-25 18:19:06'),
(162, 166, 8, 1, 'IDEAPAD I3-1', 'LENOVO', '81WD', 'PF2VWJ9K', 'SIN CLAVE', 'EN CAJA', 'NUEVO', 'DESEA INSTALAR PAQUETE DE PROGRAMAS', 'PAQUETE DE PROGRAMAS, MAS LICENCIA DE OFFICE PERMANENTE', '2025-08-25 00:00:00', '2025-08-29 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-08-25 19:33:53', '2025-08-25 19:37:05'),
(163, 167, 7, 1, 'Notebook', 'Samsung', 'NP270e', '321751781186186', 'Sin clave', 'Sin cargador', 'Evaluacion completa', 'revisar el equipo le cayo Cafe en el teclado evaluar mas el teclado esta con conflixto', 'revisar el equipo le cayo Cafe en el teclado evaluar mas el teclado esta con conflixto', '2025-08-25 00:00:00', '2025-08-29 00:00:00', 0.00, 50000.00, 'Reparacion finalizado', NULL, '2025-08-25 22:50:02', '2025-09-08 16:34:01'),
(164, 168, 8, 8, 'IDEAPAD S145-14IGM', 'LENOVO', '81MW', 'PF2J8G85', '150419', 'SIN CARGADOR', 'FUNCIONAN CIERTAS TECLAS DEL TECLADO', 'PROBLEMAS CON CIERTAS TECLAS  Y LENTITUD', 'EVALUAR TECLADO Y SI ES MAS CONVENIENTE RECOMENDAR CAMBIO DE DISCO SSD', '2025-08-26 00:00:00', '2025-08-29 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-08-26 20:13:02', '2025-08-26 20:13:02'),
(165, 169, 7, 1, 'Notebook gamer', 'Lenovo', 'Gamer', '1234564816168', 'Sin clave', 'Sin cargador', 'pedir ram de 8gb ddr4', 'pedir ram de 8gb ddr4', 'el cliente no dejara el equipo', '2025-08-26 00:00:00', '2025-08-29 00:00:00', 20000.00, 45000.00, 'Ingresado', NULL, '2025-08-27 01:48:52', '2025-08-27 01:50:07'),
(166, 170, 8, 1, 'Aspire 3 A314 SERIES', 'Acer', 'N20Q1', 'NXHVWAL00304719DC97600', '3392', 'SIN CARGADOR', 'QUEDA SUELTO EL CARGADOR', 'TECLA S DAÑADA', 'COTIZACION CAMBJO DE TECLADO Y FORMATEO SIN RESPALDO', '2025-08-27 00:00:00', '2025-09-03 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-08-28 00:24:32', '2025-09-04 02:12:41'),
(167, 171, 8, 8, 'HP Probook', 'HP', '650g2', '5CG6440SNS', 'SIN CLAVE', 'SIN CARGADOR', 'ESTA DEMASIADO LENTO', 'LENTITUD', 'CAMBIO DE DISCO SSD 240 GB', '2025-08-27 00:00:00', '2025-09-01 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-08-28 03:00:43', '2025-08-28 03:00:43'),
(168, 172, 7, 7, 'Impresora', 'canon', 'G2100', '123178874', 'Sin clave', 'Sin cargador', 'Evaluacion completa', 'Evaluacion completa', 'la impresora esta imprimiendo mal y desalineada', '2025-08-29 00:00:00', '2025-09-02 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-08-29 21:02:00', '2025-08-29 21:02:00'),
(169, 173, 7, 7, 'Notebook', 'HP', '15-r001la', 'CND51196WP', 'SIN CLAVE', 'SIN CARGADOR', 'FORMATEAR SIN RESPALDO', 'MAS LLEVARA CARGADOR PIN AZUL', 'FORMATEAR SIN RESPALDO', '2025-08-29 00:00:00', '2025-09-02 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-08-29 23:41:28', '2025-08-29 23:41:28'),
(170, 174, 7, 1, 'impresora', 'epson', 'L380', '117171717177171', 'Sin Clave', 'Sin cables', 'Cambio de cabezal', 'la impresora estumo mucho tiempo sin usar', 'Cambio de cabezal', '2025-08-29 00:00:00', '2025-09-04 00:00:00', 30000.00, 75000.00, 'Reparacion finalizado', NULL, '2025-08-30 00:07:30', '2025-09-16 00:35:10'),
(171, 175, 8, 8, 'NOTEBOOK ESTILO TABLETA', 'ASUS', 'B121', 'ASUSB121', 'SIN CLAVE', 'CON CARGADOR', 'NO TRAE TECLADO', 'NECESITA FORMATEAR', 'FORMATEO SIN RESPALDO', '2025-09-02 00:00:00', '2025-09-05 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-09-02 18:48:20', '2025-09-02 18:48:20'),
(172, 176, 8, 1, 'X515JA-BQ4117W', 'ASUS', 'X515J', 'N8N0CX11V597356', '0121', 'SIN CARGADOR', 'CASI NUEVO', 'ARROJA GLITCHES DE PANTALLA', 'EVALUACION COMPLETA', '2025-09-03 00:00:00', '2025-09-08 00:00:00', 0.00, 0.00, 'Reparacion finalizado', NULL, '2025-09-03 19:38:19', '2025-09-05 01:38:44'),
(173, 177, 7, 1, 'IMPRESORA', 'CANON', 'G2110', '521891811', 'SIN CLAVE', 'SIN CABLES', 'EVALUACION COMPLETA', 'LA IMPRESORA ESTO,O MUCHO TIEMPO SIN UTILIZAR', 'LA IMPRESORA ESTO,O MUCHO TIEMPO SIN UTILIZAR', '2025-09-03 00:00:00', '2025-09-09 00:00:00', 0.00, 0.00, 'Reparacion finalizado', NULL, '2025-09-03 19:52:49', '2025-09-05 01:37:34'),
(174, 178, 8, 8, 'HP PAVILION LAPTOP', 'HP', '14-DV0002LA', '5CD0532MHWQ', '2370', 'SIN CARGADOR', 'EL EQUIPO TIENE SELLO DE GARANTÍA PERO YA VENCIÓ', 'NO ENCIENDE', 'EVALUACION COMPLETA', '2025-09-03 00:00:00', '2025-09-08 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-09-03 23:39:24', '2025-09-03 23:39:24'),
(175, 179, 7, 1, 'Parlante', 'bose', 'bose soundlink color 2', '186181818181', 'Sin clave', 'Sin cargador', 'Evaluacion completa', 'Evaluacion completa', 'no esta recibiendo energia posible fallo pin de carga', '2025-09-05 00:00:00', '2025-09-10 00:00:00', 0.00, 8000.00, 'Entregado', NULL, '2025-09-05 23:19:52', '2025-09-22 19:48:55'),
(176, 180, 8, 1, 'LENOVO YOGA', 'LENOVO', '81A5', 'YD0517QR', 'SIN CLAVE', 'SIN CARGADOR', 'TECLA ENCENDIDO HACIA ADENTRO', 'TECLA ENCENDIDO DAÑADA', 'EVALUAR TECLA ENCENDIDO', '2025-09-05 00:00:00', '2025-09-10 00:00:00', 0.00, 8000.00, 'Entregado', NULL, '2025-09-06 01:43:22', '2025-09-22 19:49:23'),
(177, 175, 8, 8, 'NITRO 5 AN515-42', 'ACER', 'N17C1', 'NHQ3RAL003911060FA3400', '0409', 'CON CARGADOR (ESTÁ PEDIO PELADO)', 'BASTANTE LENTO', 'LENTITUD', 'CAMBIO DE DISCO SSD O NVME 250 GB Y MANTENCION SISTEMA DE VENTILACION', '2025-09-08 00:00:00', '2025-09-12 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-09-08 16:16:29', '2025-09-08 16:16:29'),
(178, 181, 7, 1, 'Notebook', 'hp pavilion', '15-dk0015la', 'CND0290Y60', '0507', 'CON CARGADOR', 'Limpieza de ventilacion mas cambio de pasta disipadora', 'Limpieza de ventilacion mas cambio de pasta disipadora', 'Limpieza de ventilacion mas cambio de pasta disipadora', '2025-09-08 00:00:00', '2025-09-10 00:00:00', 0.00, 32000.00, 'Entregado', NULL, '2025-09-09 00:20:25', '2025-09-22 19:48:23'),
(179, 182, 8, 8, 'Impresora', 'Epson', 'L3150', 'epsonl3150', 'no aplica', 'sin cables', 'buen nivel de tintas', 'no imprime en negro', 'Evaluacion completa', '2025-09-09 00:00:00', '2025-09-12 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-09-09 18:20:21', '2025-09-09 18:20:21'),
(180, 183, 8, 1, 'ALL IN ONE', 'HP', '20-C414LA', '20-C414LA', 'zymdental', 'sin cables', 'Funciona demasiado lento', 'Lentitud', 'Evaluar mejora de ssd y ram', '2025-09-09 00:00:00', '2025-09-15 00:00:00', 0.00, 93000.00, 'Entregado', NULL, '2025-09-09 19:44:23', '2025-09-22 19:47:27'),
(181, 184, 7, 7, 'Notebook', 'Lenovo', 'T14', '11511818181', 'Sin contraseña', 'Sin cargador', 'Formateo  con respaldo', 'Formateo  con respaldo', 'Formateo  con respaldo', '2025-09-09 00:00:00', '2025-09-11 00:00:00', 0.00, 23000.00, 'Ingresado', NULL, '2025-09-09 21:33:17', '2025-09-09 21:33:17'),
(182, 185, 7, 7, 'notebook', 'HP', 'HSN-113c', '512651651515', 'Sin clave', 'Sin cargador', 'Evaluacion completa', 'el equipo no arranca sistema operativo que en pantalla de recovery', 'el equipo no arranca sistema operativo que en pantalla de recovery', '2025-09-10 00:00:00', '2025-09-12 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-09-11 00:17:23', '2025-09-11 00:17:23');
INSERT INTO `orden` (`id`, `idcliente`, `idtecnico`, `idusuario`, `nombreEquipo`, `marca`, `modelo`, `serial`, `clave`, `accesorios`, `observaciones`, `fallaEquipo`, `reparacion`, `fechaEntrada`, `fechaEntrega`, `adelanto`, `totalPagar`, `estado`, `imagen`, `created_at`, `updated_at`) VALUES
(183, 186, 8, 8, 'ALl IN ONE', 'LENOVO', '10040', 'VS.30253029', 'SIN CLAVE', 'CON CARGADOR', 'SE CORTO LA LUZ EN CASA', 'NO ARRANCA', 'EVALUACION COMPLETA', '2025-09-11 00:00:00', '2025-09-15 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-09-11 19:10:10', '2025-09-11 19:10:10'),
(184, 187, 7, 1, 'tablet', 'Samsung', 'Samsung Galaxy Tab A LTE SM-T515', '215111181511', 'Sin clave', 'Sin cables', 'cotizacion de pantalla llamas al cliente', 'cotizacion de pantalla llamas al cliente', 'cotizacion de pantalla llamas al cliente', '2025-09-11 00:00:00', '2025-09-12 00:00:00', 0.00, 0.00, 'Entregado', NULL, '2025-09-11 22:26:27', '2025-09-22 17:50:04'),
(185, 188, 7, 1, 'Impresora', 'Epson', 'l3250', '2581418181', 'Sin Clave', 'Sin cables', 'Evaluacion completa', 'la impresora se queda pegada y no conecta al equipo', 'la impresora se queda pegada y no conecta al equipo', '2025-09-11 00:00:00', '2025-09-17 00:00:00', 0.00, 25000.00, 'Entregado', NULL, '2025-09-12 00:46:20', '2025-09-22 17:50:56'),
(186, 189, 7, 7, 'notenbok', 'Asus', 'x1605z', 's2n0cv046090076', 'Sin clave', 'con cargador', 'evaluacion completa', 'el equipo no esta recibiendo energia', 'el equipo no esta recibiendo energia', '2025-09-16 00:00:00', '2025-09-23 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-09-16 22:41:19', '2025-09-16 22:41:19'),
(187, 190, 7, 7, 'telefoto', 'motorola', 'moto g34', '16515135135', 'Sin clave', 'Sin cargador', 'Cambio de pantalla', 'mas el equipo le callo un poco de huevo y lometieron en arroz', 'mas el equipo le callo un poco de huevo y lometieron en arroz', '2025-09-16 00:00:00', '2025-09-17 00:00:00', 0.00, 28000.00, 'Ingresado', NULL, '2025-09-16 23:30:40', '2025-09-16 23:30:40'),
(188, 191, 8, 8, 'NOTEBOOK', 'ACER', 'N19C1', 'NXHF9AL00F0450818D3400', 'NO SABE', 'SIN CARGADOR', 'BISAGRA DE PANTALLA DAÑADA', 'DAÑO EN SOPORTES DE BISAGRA', 'COTIZACION CARCASA PANTALLA', '2025-09-22 00:00:00', '2025-10-10 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-09-22 16:18:28', '2025-09-22 16:18:28'),
(189, 192, 7, 7, 'NOTEBOOK', 'HP', '240g8', '05185185080', 'SIN CLAVE', 'SIN CARGADOR', 'EVALUACION COMPLETA', 'EL EQUIPO RECIBIÓ DERRAME DE LÍQUIDO EN EL EQUIPO MAS EL EQUIPO LO INTENTARON SECAR Y NO ENCENDIO', 'EL EQUIPO RECIBIÓ DERRAME DE LÍQUIDO EN EL EQUIPO', '2025-09-22 00:00:00', '2025-09-25 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-09-22 17:26:53', '2025-09-22 17:26:53'),
(190, 193, 8, 8, 'Notebook', 'Compaq', 'Presario CQ40', 'CND0011TY9', 'NO LA RECUERDA', 'SIN CARGADOR', 'VIENE CON WINDOWS 7, COMPONENTES BASICOS', 'QUIERE FORMATEAR EL EQUIPO', 'CAMBIAR DISCO Y AUMENTAR RAM', '2025-09-22 00:00:00', '2025-09-26 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-09-22 17:40:27', '2025-09-22 17:40:27'),
(191, 194, 7, 7, 'impresora', 'canon', 'G3110', '17441455459698', 'Sin clave', 'Sin cargador', 'Evaluacion completa', 'la impresora no esta imprimiendo bien', 'la impresora no esta imprimiendo bien', '2025-09-22 00:00:00', '2025-09-24 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-09-22 22:35:21', '2025-09-22 22:35:21'),
(192, 195, 7, 7, 'Notebook', 'HP', '14-cm0007la', '5871116886', 'Sin calve', 'Sin cargador', 'Evaluacion completa', 'El equipo Se queda pegado al instalador de windows mas tiene soporte de visagra dañados', 'El equipo Se queda pegado al instalador de windows mas tiene soporte de visagra dañados', '2025-09-23 00:00:00', '2025-09-26 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-09-23 21:31:04', '2025-09-23 21:31:04'),
(193, 196, 8, 8, 'Impresora', 'Epson', 'L210', 'epsonl210', 'no aplica', 'sin cables', 'está muy empolvada, está en deshuso hace mucho tiempo', 'Está sin uso hace mucho tiempo', 'Evaluación completa', '2025-09-24 00:00:00', '2025-09-29 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-09-24 17:46:50', '2025-09-24 17:46:50'),
(194, 197, 8, 8, 'Impresora', 'Epson', 'L220', 'epsonl220', 'no aplica', 'sin cables', 'Arroja codigo de error', 'Fin vida útil almohadillas', 'evaluación y cambio de almohadillas', '2025-09-24 00:00:00', '2025-09-29 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-09-24 19:36:41', '2025-09-24 19:36:41'),
(195, 149, 8, 8, 'notebook', 'hp', 'Probook 440G7', '5cd04047dw', 'sin clave', 'sin cargador', 'sin cargador', 'no enciende', 'evaluación completa', '2025-09-24 00:00:00', '2025-09-26 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-09-24 21:24:12', '2025-09-24 21:24:12'),
(196, 194, 7, 1, 'notebook', 'Lonevo', 'G40-80', 'pf0mxx1u', 'Sin clave', 'Sin cargador', 'Evaluacion completa', 'el equipo recibió derrame de liquido', 'Cotizar cambio de teclado', '2025-09-24 00:00:00', '2025-09-26 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-09-24 22:19:04', '2025-09-24 22:19:55'),
(197, 198, 8, 8, 'Notebook', 'Asus', 'x409f', 'K6N0CX02A36223B', 'kvc253131', 'SIN CARGADOR', 'No arranca', 'se queda tildado al inicio', 'Evaluacion completa', '2025-09-25 00:00:00', '2025-10-06 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-09-25 16:16:14', '2025-09-25 16:16:14'),
(198, 199, 7, 7, 'notebook', 'HP', '14-eh1003la', '15418186686', '2913', 'Sin cargador', 'instalación de office permanente', 'instalación de office permanente', 'instalación de office permanente', '2025-10-02 00:00:00', '2025-10-03 00:00:00', 0.00, 45000.00, 'Ingresado', NULL, '2025-10-02 19:36:16', '2025-10-02 19:36:16'),
(199, 200, 7, 7, 'notebook', 'Lenovo', '110-15isk', '146518168116', 'Sin clave', 'Sin cargador', 'Formateo sin respaldo', 'Formateo sin respaldo', 'Formateo sin respaldo', '2025-10-02 00:00:00', '2025-10-03 00:00:00', 0.00, 18000.00, 'Ingresado', NULL, '2025-10-02 21:06:09', '2025-10-02 21:06:09'),
(200, 201, 8, 8, 'Celular', 'Apple', 'Iphone 11', 'iphone11apple', 'no aplica', 'sin accesorios', 'Tiene la bateria dañada', 'Bateria dañada', 'Cambio de bateria', '2025-10-02 00:00:00', '2025-10-04 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-10-02 22:35:10', '2025-10-02 22:35:10'),
(201, 202, 7, 7, 'IMPRESORA', 'CANON', 'G2110', '5465168168168', 'SIN CLAVE', 'SIN CABLES', 'LLAMAR AL CLIENTE Y DAR EL PRESUPUESTO DE LA IMPRESORA', 'LA IMPRESORA LA DEJARON QUE SE VACIARA', 'LA IMPRESORA LA DEJARON QUE SE VACIARA', '2025-10-03 00:00:00', '2025-10-14 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-10-03 16:47:44', '2025-10-03 16:47:44'),
(202, 175, 7, 7, 'Notenbok', 'Asus', 'asustek b121', '2151818686', 'Sin clave', 'Sin cargador', 'Evaluacion Completa', 'el equipo recibió una caida y termino dañando el cargador', 'el equipo recibió una caida mas el jack power le quedo un troso del cargador atorado', '2025-10-03 00:00:00', '2025-10-21 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-10-03 18:10:58', '2025-10-03 18:10:58'),
(203, 175, 7, 7, 'Notenbok', 'Asus', 'asustek b121', '2151818686', 'Sin clave', 'Sin cargador', 'Evaluacion Completa', 'el equipo recibió una caida y termino dañando el cargador', 'el equipo recibió una caida mas el jack power le quedo un troso del cargador atorado', '2025-10-03 00:00:00', '2025-10-21 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-10-03 18:10:58', '2025-10-03 18:10:58'),
(204, 203, 7, 7, 'impresora', 'Canon', 'G4110', '165858118188', 'Sin clave', 'Sin cables', 'evaluacion completa', 'la impresora no esta imprimiendo  bien', 'la impresora no esta imprimiendo  bien', '2025-10-03 00:00:00', '2025-10-07 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-10-03 23:32:35', '2025-10-03 23:32:35'),
(205, 204, 8, 8, 'Notebook', 'HP', '240g7', 'hps240g7', 'sin clave', 'sin cargador', 'Tiene la carcasa del teclado rota, desea reemplazarla.', 'La falla del daño en carcasa se debe a que la batería esta inflada.', 'Cotizar cambio de bateria y carcasa superior del teclado.', '2025-10-06 00:00:00', '2025-10-10 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-10-06 16:53:22', '2025-10-06 16:53:22'),
(206, 205, 8, 8, 'IDEAPAD 305-15IBD', 'Lenovo', '80NJ', 'MP17G', 'SIN CLAVE', 'SIN CARGADOR', 'PIN DE CARGA DAÑADO O HACIA ADENTRO', 'PIN DE CARGA DAÑADO Y COTIZAR CARGADOR', 'EVALUACION COMPLETA', '2025-10-06 00:00:00', '2025-10-10 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-10-06 17:17:16', '2025-10-06 17:17:16'),
(207, 206, 7, 1, 'Notebook Gamer', 'HP', 'Pavilion 15-dk001la', '1861681818168168168', 'Sin clave', 'Sin cargador', 'Limpieza de ventilacion mas cambio de pasta disipadora', 'Limpieza de ventilacion mas cambio de pasta disipadora', 'Mas cotizacion de bateria del equipo', '2025-10-08 00:00:00', '2025-10-10 00:00:00', 0.00, 32000.00, 'Entregado', NULL, '2025-10-08 22:19:22', '2025-10-11 00:01:05'),
(208, 207, 8, 8, 'NOTEBOOK', 'LENOVO', 'THINKPAD X280', 'THINKPADX280', 'monse2009', 'con cargador', 'usb lateral derecho está hundido', 'se le cayó y se quedó hacia dentro el usb', 'evaluacion completa', '2025-10-08 00:00:00', '2025-10-13 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-10-09 00:45:36', '2025-10-09 00:45:36'),
(209, 208, 8, 1, 'Impresora', 'Epson', 'L4160', 'epsonl4160', 'No aplica', 'Sin cables', 'Imprime débil los colores', 'Está imprimiendo mal', 'Evaluacion completa', '2025-10-09 00:00:00', '2025-10-14 00:00:00', 0.00, 15000.00, 'Entregado', NULL, '2025-10-09 19:34:23', '2025-10-10 23:59:14'),
(210, 209, 7, 1, 'Impresora', 'Epson', 'L3150', '144165811', 'Sin clave', 'Sin Cables', 'Evaluacion Completas Mandar valores al cliente', 'La Impresora esta imprimiendo y de la nada empezó a parpadear las luces', 'La Impresora esta imprimiendo y de la nada empezó a parpadear las luces', '2025-10-09 00:00:00', '2025-10-15 00:00:00', 0.00, 20000.00, 'Entregado', NULL, '2025-10-10 16:40:32', '2025-10-10 23:58:47'),
(211, 209, 7, 1, 'Impresora', 'Epson', 'L3250', '4864864848', 'Sin clave', 'Sin cables', 'Evaluacion Completas Mas mandar valores al cliente', 'La impresora la estarán conectando a wifi y de la nada empeso a parpadear las luces', 'La impresora la estarán conectando a wifi y de la nada empeso a parpadear las luces', '2025-10-09 00:00:00', '2025-10-15 00:00:00', 0.00, 20000.00, 'Entregado', NULL, '2025-10-10 16:45:01', '2025-10-10 23:58:23'),
(212, 210, 8, 1, 'All in one', 'Acer', 'Aspire Z1-601', 'DQSYFAL0024510062E6B01', 'franypia', 'Con cargador', 'Necesita Formatearlo', 'Requiere formatear', 'Formateo con Respaldo', '2025-10-10 00:00:00', '2025-10-14 00:00:00', 0.00, 23000.00, 'Ingresado', NULL, '2025-10-10 17:43:33', '2025-10-10 17:43:48'),
(213, 211, 8, 8, 'Impresora', 'Epson', 'L3150', 'epsonl3150', 'no aplica', 'sin cables', 'Tinta negra llena y colores mas o menos hasta la mitad.', 'No imprime', 'Evaluacion completa', '2025-10-14 00:00:00', '2025-10-17 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-10-14 16:04:29', '2025-10-14 16:04:29'),
(214, 212, 7, 7, 'notebook', 'Samsung', 'NP300E4E', '1871848668', 'Sin clave', 'Sin cargador', 'el equipo  enciende pero  no da imagen', 'el equipo  enciende pero  no da imagen', 'Evaluacion completa Mandar valores', '2025-10-14 00:00:00', '2025-10-17 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-10-14 17:05:46', '2025-10-14 17:05:46'),
(215, 212, 7, 7, 'notebook', 'lenovo', 'ideapad 330-15kb', '126841811818', 'Sin clave', 'Sin cargador', 'cotizar cambio  de teclado', 'el equipo  lo llevaron a otro sevicio tecnico por derrame de liquido', 'evaluacion completa', '2025-10-14 00:00:00', '2025-10-21 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-10-14 17:08:50', '2025-10-14 17:08:50'),
(216, 213, 8, 8, 'Aspire 1 A114 series', 'Acer', 'N20Q1', 'NXA7VAL0042041DBB07600', 'Mamitatekiero', 'sin cargador', 'No enciende', 'No enciende', 'Evaluacion completa', '2025-10-15 00:00:00', '2025-10-22 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-10-15 18:10:32', '2025-10-15 18:10:32'),
(217, 213, 8, 8, 'Notebook', 'HP', '1111', '111', 'sin clave', 'sin cargador', 'No enciende', 'No enciende. Viene sin batería.', 'Evaluación completa. Cotizar bateria.', '2025-10-15 00:00:00', '2025-10-30 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-10-15 18:14:25', '2025-10-15 18:14:25'),
(218, 214, 7, 1, 'notebook', 'Samsung', 'NP750XFG', '15416544561', 'SIN CLAVE', 'CON CARGADOR', 'el cliente de abonado $50.000', 'Pedir carcasa samsung', 'Pedir carcasa de pantalla samsung', '2025-10-15 00:00:00', '2025-10-17 00:00:00', 50000.00, 110000.00, 'Ingresado', NULL, '2025-10-15 21:21:40', '2025-10-16 00:16:44'),
(219, 215, 8, 8, 'PC-ARMADO', 'ARMADO', 'ARMADO', '.', 'SIN CLAVE', 'CON CABLE DE PODER', 'NO DA IMAGEN', 'RECIEN ESTA ARMADO', 'EVALUACION COMPLETA', '2025-10-15 00:00:00', '2025-10-20 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-10-15 23:54:59', '2025-10-15 23:54:59'),
(220, 216, 7, 7, 'Notebook', 'Lenovo', 'ideapad 3', '171761988', 'Sin clave', 'Sin cargador', 'el equipo anda lento mas se pega y el disco duro no baja del 100%', 'el equipo anda lento mas se pega y el disco duro no baja del 100%', 'Ecaluacion completa', '2025-10-17 00:00:00', '2025-10-22 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-10-17 19:18:52', '2025-10-17 19:18:52'),
(221, 217, 7, 7, 'notebook', 'compac', '610', '11848616816', 'Cholo2021', 'Con cargador', 'Recuperacion de contraseña', 'Recuperacion de contraseña', 'Evaluacion completa', '2025-10-21 00:00:00', '2025-10-24 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-10-21 17:12:51', '2025-10-21 17:12:51'),
(222, 218, 7, 7, 'Impresora', 'Epson', 'L5190', '1151515151515', 'Sin Clave', 'Sin Cables', 'La  impresora  no esta imprimiendo bien', 'La  impresora  no esta imprimiendo bien', 'Evaluacion completa', '2025-10-21 00:00:00', '2025-10-24 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-10-21 23:17:31', '2025-10-21 23:17:31'),
(223, 219, 7, 7, 'Notebook', 'HP', '13-ba1123la', '251515151515', 'Sin Clave', 'Sin cargador', 'el equipo no arranca sistema operativo', 'el equipo no arranca sistema operativo', 'Evaluacion completa', '2025-10-21 00:00:00', '2025-10-23 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-10-21 23:39:42', '2025-10-21 23:39:42'),
(224, 217, 7, 7, 'notebook', 'Samsung', 'RC420', '15115151551', 'Sin clave', 'Sin cargador', 'Cotizacion de cambio de teclado mandar valores', 'Cotizacion de cambio de teclado mandar valores', 'Evaluacion completa', '2025-10-24 00:00:00', '2025-10-22 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-10-22 22:22:47', '2025-10-22 22:22:47'),
(225, 220, 7, 7, 'notebook', 'Lenovo Thinkpad', 'TP00091b', '1515171516868', 'Sin clave', 'Con cargador y adaptador de energia', 'Formateo  Sin respaldo', 'Formateo  Sin respaldo', 'Formateo  Sin respaldo', '2025-10-22 00:00:00', '2025-10-24 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-10-22 22:43:13', '2025-10-22 22:43:13'),
(226, 221, 7, 7, 'Notenbok', 'HP', '14-dq1004la', '5CD048CKPP', 'gabiifco', 'Sin cargador', 'Cotizacion de teclado mandar valores', 'Cotizacion de teclado mandar valores', 'Evaluacion', '2025-10-27 00:00:00', '2025-10-29 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-10-27 23:29:42', '2025-10-27 23:29:42'),
(227, 222, 8, 8, 'Swift 3', 'Acer', 'N20C12', 'NXABLAL004145022FC3400', 'sin clave', 'Sin cargador', 'El cargador queda suelto.', 'No recibe carga. No enciende.', 'Evaluación completa', '2025-10-28 00:00:00', '2025-11-03 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-10-28 16:42:07', '2025-10-28 16:42:07'),
(228, 223, 9, 1, 'IMPRESORA', 'EPSON', 'L3150', '000L3150', 'NO APLICA', 'SIN ACCESORIOS', 'LUCES INTERMITENTES ANUNCIANDO FALLAS', 'EVALUAR FALLA', 'EVALUACION COMPLETA', '2025-11-02 00:00:00', '2025-11-04 00:00:00', 0.00, 18.00, 'Ingresado', NULL, '2025-11-02 23:06:59', '2025-11-03 18:18:07'),
(229, 224, 7, 7, 'notebook', 'lenovo', 'ideapad 3 15itl6', '584584848484/', 'Sin clave', 'Con cargador mas bolso', 'el integrado de  carga esta roto', 'el integrado de  carga esta roto', 'evaluacion completa y cotizaciones', '2025-11-06 00:00:00', '2025-11-09 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-11-06 16:36:11', '2025-11-06 16:36:11'),
(230, 225, 8, 8, 'Armado', 'Armado', 'hp', 'hp-armado', 'sin contraseña', 'sin cables', 'Equipo no da imagen y no da sonido.', 'Se le soltó al cliente. Cayó de una altura pequeña pero ahora no le da imagen.', 'Evaluacion completa', '2025-11-10 00:00:00', '2025-11-17 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-11-10 19:18:40', '2025-11-10 19:18:40'),
(231, 226, 7, 7, 'notebook', 'MSI', '151515158777', '125618161', 'Sin clave', 'Con  cargador', 'el equipo se apago de repente y quedo funcionando el ventilador mas no resive energia', 'el equipo se apago de repente y quedo funcionando el ventilador mas no resive energia', 'Evaluacion completa', '2025-11-10 00:00:00', '2025-11-13 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-11-10 21:18:27', '2025-11-10 21:18:27'),
(232, 272, 7, 7, 'impresora', 'canon', 'G3170', '1851818418', 'Sin clave', 'Sin cables', 'Evaluacion completa', 'la impresora esta imprimiendo mal', 'la impresora esta imprimiendo mal', '2025-11-10 00:00:00', '2025-11-17 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-11-10 23:04:03', '2025-11-10 23:04:03'),
(233, 273, 7, 7, 'impresora', 'epson', 'l3150', '1765181468', 'sin clave', 'sin cables', 'el color rojo no esta bajando', 'el color rojo no esta bajando', 'evaluacion completa', '2025-11-10 00:00:00', '2025-11-13 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-11-11 00:04:35', '2025-11-11 00:04:35'),
(234, 274, 7, 7, 'notebook', 'lenovo', 'thinkpad T14', '416511515151', 'Sin clave', 'Sin cargador', 'el equipo pero da imagen tenue', 'el equipo pero da imagen tenue', 'evaluacion completa', '2025-11-11 00:00:00', '2025-11-14 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-11-11 18:07:15', '2025-11-11 18:07:15'),
(235, 275, 8, 8, 'HP ELITE BOOK 840 G5', 'HP', 'HSN-I13C-4', '5CG82262XZ', 'SIN CLAVE', 'SIN CARGADOR', 'TIENE UNA ABOLLADURA', 'NO ENCIENDE', 'EVALUACION COMPLETA', '2025-11-17 00:00:00', '2025-11-21 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-11-17 23:02:46', '2025-11-17 23:02:46'),
(236, 276, 7, 7, 'equipo de torre', 'armado', '1851515151', '12313354188', 'Sin clave', 'Sin cables', 'el  equipo no esta dando  imagen evaluacion completa', 'el  equipo no esta dando  imagen evaluacion completa', 'evaluacion completa', '2025-11-17 00:00:00', '2025-11-20 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-11-18 00:13:16', '2025-11-18 00:13:16'),
(237, 277, 7, 7, 'honor X8A 5g', 'honor X8A 5g', 'honor X8A 5g', '15151515', 'Sin clave', 'Sin cables', 'el cliente dejo pagado el cambio de pantalla', 'Cambio de pantalla', 'Cambio de pantalla', '2025-11-19 00:00:00', '2025-11-21 00:00:00', 35000.00, 35000.00, 'Ingresado', NULL, '2025-11-20 00:36:19', '2025-11-20 00:36:19'),
(238, 278, 7, 7, 'equipo  de torre', 'armado', '125125151', '187484848', 'Sin clave', 'sin cables', 'recuperacion de la informacion del equipo', 'recuperacion de la informacion del equipo', 'recuperacion de la informacion del equipo  mas mandar  valores', '2025-11-22 00:00:00', '2025-11-26 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-11-22 01:02:02', '2025-11-22 01:02:02'),
(239, 279, 9, 1, 'IMPRESORA', 'CANON', 'G4100', 'G4100012', 'NIO APLICA', 'SIN ACCESORIOS', 'SIN CABLES', 'EVALUACION', 'MANTENCION  COMPLETA', '2025-11-25 00:00:00', '2025-11-30 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-11-25 20:34:39', '2025-11-25 20:35:59'),
(240, 280, 8, 1, 'Impresora', 'Canon', 'G3170', 'canon3170', 'no aplica', 'sin cables', 'Desea saber si está imprimiendo bien', 'Desea saber si está imprimiendo bien', 'evaluacion completa', '2025-11-25 00:00:00', '2025-11-28 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-11-25 21:39:24', '2025-11-25 21:40:00'),
(241, 281, 7, 7, 'impresora', 'epson', 'l396', '2165165156165', 'Sin clave', 'Sin cables', 'la impresora  se dejo de ocupar  por un tiempo', 'la impresora  se dejo de ocupar  por un tiempo', 'Evaluacion  Completa', '2025-11-26 00:00:00', '2025-12-11 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-11-26 17:21:12', '2025-11-26 17:21:12'),
(242, 282, 8, 8, 'Impresora', 'Canon', 'G2160', 'G2160', 'no aplica', 'sin cables', 'no está imprimiendo', 'no imprime', 'evaluacion completaq', '2025-11-27 00:00:00', '2025-12-02 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-11-27 17:02:51', '2025-11-27 17:02:51'),
(243, 283, 8, 8, 'Impresora', 'Epson', 'L395', 'epsonl395', 'no aplica', 'sin cables', 'No pasa la hoja', 'arroja que no hay papel', 'evaluación completa', '2025-11-28 00:00:00', '2025-12-03 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-11-28 19:09:05', '2025-11-28 19:09:05'),
(244, 284, 7, 7, 'notebook', 'Acer', 'Es1 331', '25181818', 'Sin clave', 'Sin cargador', 'Cambio de disco SSD 240 GB', 'Cambio de disco SSD 240 GB', 'Cambio de disco SSD 240 GB', '2025-11-28 00:00:00', '2025-12-03 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-11-28 23:55:20', '2025-11-28 23:55:20'),
(245, 285, 7, 7, 'notebook', 'DELL', 'P129G', '0515815151', 'SIN CLAVE', 'CON CARGADOR', 'el equipo no esta encendiendo y no da imagen entra como en un bucle se enciende y se apaga mas enciende el bloque mayuscula', 'Mas se nota que tienen un soporte d e bisagra dañado', 'Evaluación completa', '2025-12-02 00:00:00', '2025-12-05 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-12-02 16:09:59', '2025-12-02 16:09:59'),
(246, 286, 8, 8, 'Notebook', 'HP', '250 G9', 'hp250g9', 'sin clave', 'con bolso y cargador', 'formateo sin respaldo', 'desea formatear e instalar programas', 'formateo sin respaldo', '2025-12-02 00:00:00', '2025-12-05 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-12-02 18:04:23', '2025-12-02 18:04:23'),
(247, 287, 8, 8, 'CINTA', 'SONY', 'MP120', 'NTSC8', 'NO APLICA', 'SIN ACCESORIOS', 'DIGITALIZAR', 'DIGITALIZAR CINTA', 'DIGITALIZAR CINTA', '2025-12-02 00:00:00', '2025-12-05 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-12-02 20:17:09', '2025-12-02 20:17:09'),
(248, 288, 7, 7, 'notebook', 'lenovo', 'ideapad 3', '1541414141', 'Sin clave', 'Sin cargador', 'el equipo tiene atorado parte del cargador en el puerto de carga', 'el equipo tiene atorado parte del cargador en el puerto de carga', 'evaluacion completas', '2025-12-05 00:00:00', '2025-12-05 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-12-05 18:28:11', '2025-12-05 18:28:11'),
(249, 289, 8, 8, 'Impresora', 'Epson', 'L3150', 'epsonl3150', 'no aplica', 'sin cables', 'Arroja mensaje de almohadillas', 'Almohadillas lenas', 'Cambio de almohadillas + reset', '2025-12-05 00:00:00', '2025-12-10 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-12-06 00:26:45', '2025-12-06 00:26:45'),
(250, 290, 8, 1, 'Notebook', 'Asus', 'X543U', 'ASUSX543U', 'sin clave', 'sin cargador', 'Presenta la carcasa trasera de la pantalla dañada', 'Posible daño en bisagra', 'Formateo sin respaldo y evaluación bisagra de pantalla', '2025-12-09 00:00:00', '2025-12-12 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-12-09 17:09:04', '2025-12-09 17:09:51'),
(251, 291, 7, 7, 'pc de escritorio', 'armado', 'armado', '123185188', 'sin clave', 'sin cables', 'el equipo esta dando imagen y se reinicia', 'el equipo esta dando imagen y se reinicia', 'evaluacion completa', '2025-12-09 00:00:00', '2025-12-11 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-12-09 21:13:31', '2025-12-09 21:13:31'),
(252, 292, 7, 7, 'carlos perez', 'armado', 'armado', '21561651561', 'Sin clave', 'Sin Cables', 'el equipo se empieza a ocupar y se apaga', 'el cliente limpio el equipo  pero no cambio la pasta termica', 'evaluacion completa', '2025-12-09 00:00:00', '2025-12-12 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-12-09 21:57:21', '2025-12-09 21:57:21'),
(253, 293, 7, 7, 'notenbook', 'hp', '14-em007la', '1521515313515', '2026', 'Sin cargador y bolso', 'instalación de office permanente', 'instalación de office permanente', 'instalación de office permanente', '2025-12-11 00:00:00', '2025-12-19 00:00:00', 0.00, 45000.00, 'Ingresado', NULL, '2025-12-11 17:15:47', '2025-12-11 17:15:47'),
(254, 294, 8, 8, 'Notebook', 'Asus', 'x412f', 'asusx412f', '11021965', 'Sin cargador', 'Tiene un sticker pegado', 'Desea formateo con respaldo', 'Formateo con respaldo', '2025-12-12 00:00:00', '2025-12-15 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-12-12 17:01:44', '2025-12-12 17:01:44'),
(255, 295, 8, 8, 'Pixma', 'Canon', 'PIXMA MG3510', 'pixma3510', 'no aplica', 'sin cables', 'Está hace 6 meses aprox. sin imprimir', 'No se sabe en que estado está', 'Evaluacion completa', '2025-12-12 00:00:00', '2025-12-17 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-12-12 20:06:50', '2025-12-12 20:06:50'),
(256, 296, 7, 7, 'notebook gamer', 'HP  pavilion', '14-ec1029la', '415185151', '9439', 'Con cargador', 'el equipo  se calienta y suena muchos los ventiladores', 'el cliente llevo el equipo donde un amigo para limpiarlo por dentro', 'Evaluacion completa', '2025-12-15 00:00:00', '2025-12-17 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-12-15 23:54:14', '2025-12-15 23:54:14'),
(257, 217, 7, 7, 'notenbock', 'Samsung', 'NP-rc420', '16511151', 'Sin clave', 'Sin cargador', 'el equipo anda muy lento', 'Evaluación Completas mandar valores para mejora', 'Evaluación Completas mandar valores para mejora', '2025-12-15 00:00:00', '2025-12-17 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-12-16 00:18:00', '2025-12-16 00:18:00'),
(258, 159, 7, 7, 'notenbok', 'Acer', 'es1-411', '65165416516816', 'Sin clave', 'Sin cargador', 'Evaluacion completa', 'el equipo  no esta encendiendo', 'el equipo no esta encendiendo', '2025-12-17 00:00:00', '2025-12-19 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-12-17 23:33:10', '2025-12-17 23:33:10'),
(259, 298, 8, 8, 'Ideapad 5', 'Lenovo', '14ALC05', 'MP248VWW', '16082000', 'Sin cargador', 'El equipó tiene un ruido extraño que no se sabe de donde proviene.', 'No consigue arrancar el sistema operativo', 'Evaluacion completa', '2025-12-18 00:00:00', '2025-12-23 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-12-18 22:58:14', '2025-12-18 22:58:14'),
(260, 299, 7, 1, 'notebook', 'lenovo', 'ideapad 3 15itl6', '1651168168', 'Sin clave', 'Con cargador', 'Cambio de jack power', 'Cambio de jack power', 'el cliente dejo todo  pagado y se le entrego la factura', '2025-12-19 00:00:00', '2025-12-22 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-12-19 16:32:47', '2025-12-19 16:35:24'),
(261, 300, 7, 7, 'telefono', 'Samsung', 'samsung a01', '18618616816', 'Sin clave', 'Sin cargador', 'si cepilla algun otro fallo  llamar al cliente y dar valores', 'si cepilla algun otro equipo viene con la pantalla rota mas la parte trasera esta rota', 'Cambio de pantalla', '2025-12-19 00:00:00', '2025-12-23 00:00:00', 0.00, 28000.00, 'Ingresado', NULL, '2025-12-19 21:11:42', '2025-12-19 21:11:42'),
(262, 301, 8, 8, 'Aspire', 'Acer', '??', 'aceraspire', 'no aplica', 'sin cargador', 'tiene la pantalla rota y el touchpad dañado', 'Pantalla rota', 'Cotizar cambio de pantalla y enviar valores', '2025-12-22 00:00:00', '2025-12-31 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-12-22 17:01:48', '2025-12-22 17:01:48'),
(263, 302, 7, 7, 'impresora', 'epson', 'l3210', '154618516156', 'Sin Clave', 'Sin Cables', 'La impresora paso un tiempo sin usar mas tiene tinta de sublimacion', 'La impresora paso un tiempo sin usar mas tiene tinta de sublimacion', 'Evaluacion completa', '2025-12-22 00:00:00', '2025-12-26 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-12-22 17:17:07', '2025-12-22 17:17:07'),
(264, 303, 8, 8, 'Impresora', 'Canon', 'G3110', 'canong3110', 'no aplica', 'sin cables', 'Se infecto la tinta roja con amarillo. No baja el negro.', 'Error 5B00.', 'Evaluacion completa', '2025-12-22 00:00:00', '2025-12-29 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-12-22 18:02:37', '2025-12-22 18:02:37'),
(265, 304, 7, 7, 'notebook', 'Asus', 'x507u', '154151515', 'Sin Clave', 'Sin cargador', 'Formateo Con respaldo mas instalación de driver de la impresora', 'Formateo Con respaldo mas instalación de driver de la impresora', 'Formateo Con respaldo mas instalación de driver de la impresora', '2025-12-22 00:00:00', '2025-12-26 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-12-22 18:20:14', '2025-12-22 18:20:14'),
(266, 305, 7, 7, 'notenbok', 'lenovo', 'lenovo ideapad 1 14ijl7', '15174151515', 'Sin clave', 'Sin cargador', 'formateo sin respaldo', 'formateo sin respaldo', 'formateo sin respaldo', '2025-12-22 00:00:00', '2025-12-26 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-12-22 20:18:45', '2025-12-22 20:18:45'),
(267, 306, 7, 7, 'notanbook', 'predator', 'Ph315-54-97rm', '5848618118', '1987', 'Con cargador', 'el equipo llega a altas temperaturas', 'el equipo llega a altas temperaturas', 'Limpieza de ventilacion mas cambio de pasta disipadora', '2025-12-23 00:00:00', '2025-12-26 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-12-23 17:00:28', '2025-12-23 17:00:28'),
(268, 307, 7, 7, 'notenbok', 'Asus', 'E410M', '1651161651615', 'Sin clave', 'Con cargador', 'el equipo no arranca sistema operativo', 'el equipo no arranca sistema operativo', 'Evaluacion completa', '2025-12-26 00:00:00', '2025-12-30 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-12-26 19:10:06', '2025-12-26 19:10:06'),
(269, 308, 7, 7, 'notebook', 'Acer', 'aspire 5 a515-54', '156151651', 'Sin clave', 'sin cargador', 'cambio de carcasa el cliente  no dejara el equipo', 'cambio de carcasa el cliente  no dejara el equipo', 'cambio de carcasa', '2025-12-26 00:00:00', '2026-01-20 00:00:00', 50000.00, 100000.00, 'Ingresado', NULL, '2025-12-27 00:02:23', '2025-12-27 00:02:23'),
(270, 309, 8, 8, 'Pixma', 'Canon', 'G4110', 'canong4110', 'no aplica', 'Sin cables', 'Infeccion en la tinta yellow con magenta. Manguera cyan vacía.', 'Tinta yellow infectada. Evaluar cabezal.', 'Mantención profunda.', '2025-12-29 00:00:00', '2026-01-01 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-12-29 17:15:32', '2025-12-29 17:15:32'),
(271, 183, 7, 7, 'all in one', 'HP', '20-c414la', '165451651656', 'Sin clave', 'Sin cargador', 'Cambio de isco duro SSD 240 mas evaluar aumento de memoria RAM', 'Cambio de isco duro SSD 240 mas evaluar aumento de memoria RAM', 'Cambio de isco duro SSD 240 mas evaluar aumento de memoria RAM', '2025-12-30 00:00:00', '2026-01-06 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-12-30 19:05:15', '2025-12-30 19:05:15'),
(272, 310, 7, 7, 'notebooks', 'Dell y samsungo', 'dell', '1651515151', 'Sin clave', 'Sin cargador', 'los equipo no enciende y no reciben energia', 'los equipo no enciende y no reciben energia', 'Evaluacion completa', '2025-12-30 00:00:00', '2026-01-02 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2025-12-30 23:53:44', '2025-12-30 23:53:44'),
(273, 311, 9, 9, 'Notebook', 'Acer', 'A515', '011166', 'NO APLICA', 'SIN ACCESORIOS', 'EQUIPO SIN SIGNOS DE CARGA O ACTIVIDAD', 'NOI ENCENDE', 'EVALUACION DE ENERGIA', '2026-01-03 00:00:00', '2026-01-06 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-01-03 19:15:49', '2026-01-03 19:15:49'),
(274, 272, 9, 9, 'IMPRESORA', 'CANON', 'G3170', '001', 'NO APLICA', 'SIN ACCESORIOS', 'ALMOHADILLA LLENA', 'BLOQUE DE ALMAHADILLA RESIDUAL', 'CAMBIO DE ALMOHADILLAS', '2026-01-05 00:00:00', '2026-01-12 00:00:00', 0.00, 42000.00, 'Ingresado', NULL, '2026-01-05 21:21:53', '2026-01-05 21:21:53'),
(275, 312, 9, 1, 'notebook', 'acer', 'a515', '0011221', 'sin clave', 'sin accesorios', 'con cargador', 'jack power', 'reemplazo de jack power + for. con resp', '2026-01-06 00:00:00', '2026-01-13 00:00:00', 0.00, 68000.00, 'Ingresado', NULL, '2026-01-06 17:54:00', '2026-01-06 17:54:45'),
(276, 313, 9, 9, 'Impresora', 'Canon', 'G3110', '0112212', 'no aplica', 'sin accesorios', 'Problemas de calidad de impresion', 'posible cabezal', 'evaluacion', '2026-01-06 00:00:00', '2026-01-15 00:00:00', 0.00, 8.00, 'Ingresado', NULL, '2026-01-06 19:57:49', '2026-01-06 19:57:49'),
(277, 314, 9, 1, 'Notebook', 'Asus', 'Vivobook', '002132', 'sin clave', 'caja sellada', 'instalacion de office original', 'intalacion de of + antivirus', 'instalacion office original', '2026-01-07 00:00:00', '2026-01-07 00:00:00', 0.00, 45.00, 'Entregado', NULL, '2026-01-07 00:18:13', '2026-01-09 18:51:33'),
(278, 315, 9, 9, 'Notebook', 'Sony Vaio', 'SVE14113ELW', '012121', 'SIN CLAVE', 'SIN ACCESORIOS', 'Caercasa dañada grieta en pantalla y soportes dañados', 'daño de carcasa', 'evaluacion de reparacion', '2026-01-07 00:00:00', '2026-01-15 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-01-07 18:47:09', '2026-01-07 18:47:09'),
(279, 316, 9, 9, 'notebook', 'hp', '14-dq1004la', '021255', 'sin clave', 'sin accesorios', 'error de ventilador', 'mensaje de proteccion de temperatura', 'evaluacion de ventilacion', '2026-01-07 00:00:00', '2026-01-15 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-01-07 19:49:45', '2026-01-07 19:49:45'),
(280, 317, 9, 9, 'Notebook', 'Lenovo', 'IDEAPAD S145', '24545454', 'SIN CLAVE', 'CON CARGADOR', 'EQUIPO CON PROBLEMAS DE ARRANQUE', 'FALLA EN SIS. OPERATIVO', 'FORMATEO CON RESPALDOS', '2026-01-08 00:00:00', '2026-01-11 00:00:00', 0.00, 18000.00, 'Ingresado', NULL, '2026-01-08 17:10:35', '2026-01-08 17:10:35'),
(281, 318, 9, 1, '2 Casette vh2s', 'multimarca', 'vhs', '654656', '2315646', 'nada', '2 cintas una con daño en proteccion', 'Digitalizacion', 'digitalizacion de cintas', '2026-01-08 00:00:00', '2026-01-12 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-01-08 19:53:46', '2026-03-02 19:47:21'),
(282, 319, 9, 9, 'IMPRESORA', 'CANON', 'G3160', '5454663', 'NO APLICA', 'SIN ACCESORIOS', 'RESIDUOS DE POLVO Y BAJO NIVEL DE TINTAS', 'MANTENCION', 'MANTENCION COMPLETA', '2026-01-12 00:00:00', '2026-01-19 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-01-12 18:34:35', '2026-01-12 18:34:35'),
(283, 320, 9, 9, 'notebook', 'lenovo', 'Thinqpad  E530', '454556', 'sin clave', 'con cargador', 'problemas de inicio', 'Pantallazo azul de advertencia', 'evaluacion', '2026-01-13 00:00:00', '2026-01-16 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-01-13 17:42:11', '2026-01-13 17:42:11'),
(284, 321, 9, 1, 'notebook', 'Acerr', 'Nitro 5', '323245565', 'SIN CLAVE', 'CON CARGADOR', 'Ruido en ventiladores', 'lentitud y exceso de temperatura', 'evaluacion completa', '2026-01-13 00:00:00', '2026-01-20 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-01-13 19:24:30', '2026-01-13 19:31:18'),
(285, 335, 9, 9, 'notebook', 'acer', 'A315-42', '122444', 'SIN CLAVE', 'Con Cargador', 'carcasa dañada', 'pantalla y carcasa', 'cambio de carcasa y pantalla', '2026-01-13 00:00:00', '2026-01-16 00:00:00', 100000.00, 180000.00, 'Ingresado', NULL, '2026-01-13 21:01:04', '2026-01-13 21:01:04'),
(286, 336, 9, 9, 'Notebook', 'Acer', 'es1-572', '5454545', 'sin clave', 'sin accesorios', 'tecla esc sin actividad', 'evaluacion completa', 'Evaluacion completa', '2026-01-16 00:00:00', '2026-01-22 00:00:00', 0.00, 0.00, 'Entregado', NULL, '2026-01-16 23:21:27', '2026-01-16 23:21:27'),
(287, 337, 9, 9, 'notebook', 'Lenovo', 'Ideapad Gaming', '4545454', 'sin clave', 'con cargador', 'disco ssd 89%', 'lentitud y sistema de ventilacion sucio', 'mantencion completa incluido formateo con respaldos', '2026-01-17 00:00:00', '2026-01-22 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-01-17 20:17:56', '2026-01-17 20:17:56'),
(288, 338, 9, 9, 'Impresora', 'Epson', 'L210', '6545454', 'no aplica', 'sin cables', 'inspeccion visual normal', 'atasco de papel', 'evaluacion de sistema de toma de hojas', '2026-01-19 00:00:00', '2026-01-22 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-01-19 23:27:00', '2026-01-19 23:27:00'),
(289, 339, 9, 9, 'Impresora', 'Epson', 'L3150', '22221', 'NO APLICA', 'SIN ACCESORIOS', 'CARCASA QUEMADA', 'impresion descontinua', 'mantencion', '2026-01-21 00:00:00', '2026-01-28 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-01-21 22:29:40', '2026-01-21 22:29:40'),
(290, 340, 9, 9, 'Impresora', 'Epson', 'L3150', '212545', 'no aplica', 'sin accesorios', 'problemas de impresion', 'falla de impresion', 'Mantencion y carga de tintas', '2026-01-22 00:00:00', '2026-01-22 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-01-22 20:16:09', '2026-01-22 20:16:09'),
(291, 341, 8, 8, 'Iphone', 'apple', '11', 'appleiphone11', 'No la recuerda', 'sin accesorios', 'Está bloqueado y no recuerda el pin', 'Está bloqueado y no recuerda el pin', 'Desbloquear equipo', '2026-01-23 00:00:00', '2026-01-27 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-01-24 00:51:16', '2026-01-24 00:51:16'),
(292, 342, 7, 7, 'notebook', 'lenovo', 'ideappad 5 14itl052', '251615165165', 'Lili0598', 'Sin cargador', 'Formateo con respaldo', 'Formateo con respaldo', 'Formateo con respaldo', '2026-01-26 00:00:00', '2026-01-30 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-01-26 19:20:11', '2026-01-26 19:20:11'),
(293, 343, 8, 8, 'HP LAPTOP', 'HP', '15-dy2501la', 'SCD2378QDW', '1957', 'Con Cargador', 'El equipo recibe carga intermitente', 'Está en 0% la bateria', 'Evaluacion completa', '2026-01-27 00:00:00', '2026-02-01 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-01-27 17:36:42', '2026-01-27 17:36:42'),
(294, 344, 8, 8, 'Impresora', 'Epson', 'L3210', 'epsonl3210', 'no aplica', 'sin accesorios', 'No se usa hace 6 meses', 'No baja el color negro.', 'Mantención completa', '2026-01-27 00:00:00', '2026-02-02 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-01-27 20:28:15', '2026-01-27 20:28:15'),
(295, 345, 7, 7, 'impresora', 'epson', 'l3250', '165165165561', 'Sin clave', 'Sin cargador', 'la impresora tira un error parpadean ambas luces', 'Evaluacion completa', 'Evaluacion completa', '2026-01-27 00:00:00', '2026-02-02 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-01-28 00:45:52', '2026-01-28 00:45:52'),
(296, 346, 7, 7, 'Notebook Gamer', 'HP OMEN', '15-en0002la', '5468161681', 'Sin clave', 'Sin cargador', 'Cotizacion de cambio de teclado', 'Cotizacion de cambio de teclado', 'Cotizacion de cambio de teclado', '2026-01-27 00:00:00', '2026-02-01 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-01-28 00:53:04', '2026-01-28 00:53:04'),
(297, 347, 7, 7, 'Notebook', 'Acer', 'A315-42-R4FJ', '256516515615615', 'Sin clave', 'Sin Cargador', 'Cotizacion de cambio de carcasa de pantalla   mas cotizar bateria', 'el equipo tiene los soporte de pantalla dañados mas la bateria no duro mucho tiempo', 'el equipo tiene los soporte de pantalla dañados mas la bateria no duro mucho tiempo', '2026-01-30 00:00:00', '2026-02-04 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-01-30 23:41:36', '2026-01-30 23:41:36'),
(298, 289, 7, 7, 'impresora', 'epson', 'l3150', '461561561561', 'Sin clave', 'Sin cargador', 'la impresora esta tirando error de almohadillas llenas', 'la impresora esta tirando error de almohadillas llenas', 'Evaluacion completa mas Cambio de almohadillas y reset', '2026-01-30 00:00:00', '2026-02-05 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-01-31 00:31:24', '2026-01-31 00:31:24'),
(299, 360, 8, 8, 'Ideapad S145-14IIL', 'Lenovo', '81W6', 'PF1W24FG', 'sin clave', 'sin cargador', 'Da imagen de carga, recibe energia', 'Tecla encendido no acciona el equipo', 'Evaluacion completa', '2026-02-03 00:00:00', '2026-02-09 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-02-03 18:01:53', '2026-02-03 18:01:53'),
(300, 361, 8, 8, 'Notebook', 'Asus', 'S400C', 'asuss400c', '--', 'con cargador', 'Teclas dañadas,', 'Teclado dañado', 'Actualizar antivirus, cambio de teclado y respaldo de informacion', '2026-02-03 00:00:00', '2026-02-09 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-02-03 18:23:15', '2026-02-03 18:23:15'),
(301, 362, 7, 7, 'notebook', 'HP', '14-dq2025la', '151651616515', 'Sin clave', 'Sin cargador', 'evaluacion completa memoria ram llega hasta 95%', 'evaluacion completa memoria ram llega hasta 95%', 'Formatear sin respaldo', '2026-02-03 00:00:00', '2026-02-06 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-02-03 22:03:40', '2026-02-03 22:03:40'),
(302, 363, 8, 8, 'Notebook', 'Hp', '14-am010la', '5CG6383FQ4', 'josejose', 'sin cargador', 'Desea formatear', 'Formateo', 'Formateo con respaldo', '2026-02-03 00:00:00', '2026-02-09 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-02-03 23:17:24', '2026-02-03 23:17:24'),
(303, 364, 7, 7, 'notebook gamer', 'Asus', 'FX507Z', '021151155', '2907', 'Con cargador', 'el equipo le faltan 2 tornillos en la parte trasera mas ddentro del equipo se siente algo que se mueve y se levata la carcasa', 'evaluacion completa mas enviar valores', 'evaluacion completa  limpieza de ventilacion mas cambio de pasta disipadora', '2026-02-04 00:00:00', '2026-02-10 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-02-04 20:00:48', '2026-02-04 20:00:48'),
(304, 365, 8, 8, 'Notebook', 'Hp', '14-r001la', 'CND62060YN', 'No tiene clave', 'Sin cargador', 'Tiene disco ssd', 'Lentitud', 'Formateo con respaldo pero antes evaluar disco', '2026-02-05 00:00:00', '2026-02-11 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-02-05 17:23:01', '2026-02-05 17:23:01'),
(305, 366, 8, 8, 'Impresora', 'Epson', 'L4160', 'epsonl4160', 'sin clave', 'Sin cables', 'No baja tinta blue', 'No baja tinta blue', 'Evaluación completa', '2026-02-05 00:00:00', '2026-02-11 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-02-05 18:17:47', '2026-02-05 18:17:47'),
(306, 367, 8, 1, 'A455LF-WX089T', 'Asus', 'A455L', 'asusa455l', 'Isaias07', 'sin cargador', 'Cambio de disco duro SSD 240GB', 'Cambio de disco duro SSD 240GB', 'Cambio de disco duro SSD 240GB', '2026-02-06 00:00:00', '2026-03-06 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-02-06 17:04:39', '2026-02-27 19:49:48'),
(307, 368, 7, 7, 'Pc', 'Armado', 'Armado', '31651165165', '123', 'Sin Cables', 'el equipo que con la pantalla en negra y no carga sistema operativo mas anda lento', 'el equipo que con la pantalla en negra y no carga sistema operativo mas anda lento', 'Evaluacion Completa', '2026-02-06 00:00:00', '2026-02-17 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-02-06 17:39:47', '2026-02-06 17:39:47'),
(308, 369, 8, 8, 'Lenovo 80KY', 'Lenovo', 'Lenovo G40-80', 'MTM 80KY000JCL', 'no tiene', 'Con cargador', 'Pin de carga a la vista', 'Tiene dos cables del pin de cargador cortados', 'Cotizar reparación', '2026-02-09 00:00:00', '2026-02-13 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-02-09 16:32:26', '2026-02-09 16:32:26'),
(309, 370, 8, 8, 'Aspire 3', 'Acer', 'N19C1', 'NXHHNAL009011048F73400', '17493', 'SIN CARGADOR', 'Se quedó en negro en el primer encendido. Despues ya arreanco con normalidad.', 'Lentitud y polvo acumulado.', 'Mantencion al sistema de ventilacion mas formateo sin respaldo', '2026-02-09 00:00:00', '2026-02-13 00:00:00', 0.00, 43000.00, 'Ingresado', NULL, '2026-02-09 18:44:29', '2026-02-09 18:44:29'),
(310, 371, 8, 1, 'Celulares', 'Varios', 'Varios', 'xxxxxxxxxx', 'xxxxxxxx', 'xxxxxxxxx', 'Son 5 celulares', 'Cotizar reparacion', 'Enviar cotizacion para reparar', '2026-02-09 00:00:00', '2026-02-20 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-02-09 19:56:53', '2026-02-09 20:37:30'),
(311, 372, 8, 8, 'Impresora', 'Epson', 'L3150', 'epsonl3150', 'no aplica', 'sin cables', 'No bajan los colores', 'No bajan los colores', 'Evaluacion completa', '2026-02-09 00:00:00', '2026-02-13 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-02-09 23:43:36', '2026-02-09 23:43:36'),
(312, 373, 8, 8, 'HP PAVILION X360 CONVERTIBLE', 'HP', '14-dh0025la', '8CGO342CFN', 'No sabe', 'Sin cargador', 'Tiene daño aparentemente en el tactil', 'Daño visual en tactil o pantalla', 'Evaluación y cotización reparación', '2026-02-10 00:00:00', '2026-02-20 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-02-10 19:51:52', '2026-02-10 19:51:52'),
(313, 374, 8, 8, 'NOTEBOOK', 'ASUS', 'TUF  FX505D', '52545545', '1998', 'CON CARGADOR', 'EXCESO DE TEMPERATURA', 'VENTILACION ASIMETRICA', 'EVALUACION DE DISIPACION', '2026-02-10 00:00:00', '2026-02-15 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-02-10 20:56:26', '2026-02-10 20:56:26'),
(314, 222, 8, 8, 'Swift 3', 'Acer', 'N20C12', 'NXABLAL004145022FC3400', 'no tiene', 'sin cargador', 'Puerto usb derecho dañado. No le llega energía al equipo.', 'No enciende. Posibles problemas de energía.', 'Evaluación completa', '2026-02-10 00:00:00', '2026-02-20 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-02-10 21:26:19', '2026-02-10 21:26:19'),
(315, 439, 7, 7, 'Impresora', 'Canon', 'G3110', '165165165165', 'Sin clave', 'Sin Cables', 'Evaluacion completas', 'la impresora tiene las mangueras vacias y esta imprimiendo mal', 'la impresora tiene las mangueras vacias y esta imprimiendo mal', '2026-02-11 00:00:00', '2026-02-13 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-02-11 20:15:07', '2026-02-11 20:15:07'),
(316, 440, 9, 9, 'Notebook', 'Samsung', 'samfx plateado', '54554', 'no aplica', 'con cargador', 'ruido al activar ventilador', 'Problemas de vientilador', 'reemplazo de ventilador', '2026-02-11 00:00:00', '2026-02-15 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-02-11 21:12:37', '2026-02-11 21:12:37'),
(317, 441, 7, 7, 'Notenbok', 'HP', '15-dw2037la', '15514104', 'Sin clave', 'Sin cargador', 'El equipo  no esta arrancando', 'Buscar Orden antigual del equipo', 'Evaluacion Completa', '2026-02-11 00:00:00', '2026-02-16 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-02-11 21:31:26', '2026-02-11 21:31:26'),
(318, 442, 7, 7, 'notenbok', 'Acer', 'A515-43', '186181611', 'Sin claves', 'Sin cargador', 'el equipo le cayo liquido y lo encendieron mas trae otro equipo armar  el quetenga menos daño', 'el equipo le cayo liquido y lo encendieron', 'Evaluacion completa mandar valores', '2026-02-11 00:00:00', '2026-02-16 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-02-11 22:23:59', '2026-02-11 22:23:59'),
(319, 443, 7, 7, 'pc armado', 'pc armado', 'armado', '123654987', 'Sin clave', 'Sin cables', 'traspaso de componentes a la torre nueva', 'traspaso de componentes a la torre nueva', 'traspaso de componentes a la torre nueva', '2026-02-11 00:00:00', '2026-02-17 00:00:00', 0.00, 45000.00, 'Ingresado', NULL, '2026-02-11 23:09:02', '2026-02-11 23:09:02'),
(320, 444, 8, 8, 'Ideapad 300-14IBR', 'Lenovo', '80M2', 'PF0C6LN3', '1234', 'CON CARGADOR', 'Teclas dañadas, microfo segun cliente no funciona. Desea formatear.', 'Teclado dañado. Microfono defectuoso.', 'Evaluacion completa', '2026-02-12 00:00:00', '2026-02-19 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-02-12 23:50:38', '2026-02-12 23:50:38'),
(321, 445, 7, 7, 'PC  Escritorio', 'PC  Escritorio', 'Armado', '115415151515', 'Sin Clave', 'Sin Cambles', 'Evaluar cual m.2 es mas rapido y dejar con sistema operativo', 'Evaluar cual m.2 es mas rapido y dejar con sistema operativo', 'Mantencion completa mas montar m.2', '2026-02-13 00:00:00', '2026-02-19 00:00:00', 0.00, 50000.00, 'Ingresado', NULL, '2026-02-13 17:25:03', '2026-02-13 17:25:03'),
(322, 446, 7, 7, 'iphone 13', 'iphone', 'iphone 13', '12316546578', 'Sin clave', 'Sin cables', 'El equipo recibio un golpe y tiene la pantalla levantada y se ve algo inflamada la bateria', 'El equipo recibio un golpe y tiene la pantalla levantada y se ve algo inflamada la bateria', 'Evaluación completa', '2026-02-13 00:00:00', '2026-02-20 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-02-13 22:50:34', '2026-02-13 22:50:34'),
(323, 447, 8, 8, 'l13 YOGA', 'LENOVO', '20R6-S32J05', 'R9-11757H', 'SIN CLAVE', 'CON CARGADOR', 'NO ARRANCA', 'PROBLEMAS DE ENCENDIDO', 'EVALUACION COMPLETA', '2026-02-17 00:00:00', '2026-02-25 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-02-17 19:41:08', '2026-02-17 19:41:08'),
(324, 448, 7, 7, 'NOTEBOOK', 'lenovo', '330', '4181161', 'Sin Clave', 'Sin cargador', 'Cambio de pantalla', 'Cambio de pantalla', 'Cambio de pantalla', '2026-02-17 00:00:00', '2026-02-18 00:00:00', 0.00, 75000.00, 'Ingresado', NULL, '2026-02-18 00:15:10', '2026-02-18 00:15:10'),
(325, 449, 7, 7, 'notenbok', 'HP Pavilio', '15 dx1028la', '15115185', 'Sin clave', 'Con cargador', 'Evaluacion', 'el equipo vienen con varios daños y sin tornillos', 'Cotizar Cambio de flex de encendido', '2026-02-18 00:00:00', '2026-02-25 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-02-18 16:43:57', '2026-02-18 16:43:57'),
(326, 450, 8, 8, 'G40-80', 'LENOVO', '80E4', 'PF0EVU86', 'Sin clave', 'Con cargador', 'Le falta una tecla', 'No tiene office ni antivirus.', 'Instalar office, antivirus y arrojar actualizaciones.', '2026-02-18 00:00:00', '2026-02-20 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-02-18 17:26:22', '2026-02-18 17:26:22'),
(327, 451, 7, 7, 'Impresora', 'Canon', 'G3100', '11818181816', 'Sin clave', 'Sin Cables', 'La impresora esta tirando un error', 'La impresora esta tirando un error', 'Evaluacion completa', '2026-02-20 00:00:00', '2026-02-25 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-02-20 17:47:06', '2026-02-20 17:47:06'),
(328, 452, 8, 8, 'REDMI', 'XIAOMI', '10A', 'REDMI10A', 'NO APLICA', 'SIN CARGADOR', 'PANTALLA DAÑADA', 'PANTALLA ROTA', 'CAMBIO DE PANTALLA', '2026-02-23 00:00:00', '2026-02-25 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-02-23 18:06:03', '2026-02-23 18:06:03'),
(329, 453, 8, 8, 'Asus', 'Asus', 'X407U', 'K3NOGR07T798127', '?', 'SIN CARGADOR', 'Evaluar disco antes', 'No arranca', 'Formateo con respaldo (previa evaluacion)', '2026-02-23 00:00:00', '2026-02-27 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-02-23 18:39:47', '2026-02-23 18:39:47'),
(330, 454, 7, 7, 'Notebook', 'HP', '15-ay017la', '126515615', 'Sin clave', 'Sin cargador', 'Cotizacion de aumento de memoria Ram', 'Cotizacion de aumento de memoria Ram', 'Cotizacion de aumento de memoria Ram', '2026-02-23 00:00:00', '2026-02-24 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-02-23 22:03:27', '2026-02-23 22:03:27'),
(331, 456, 7, 7, 'impresora', 'Epson', 'L495', '186168161', 'Sin clave', 'sin cables', 'marca un error de atasco de papel', 'marca un error de atasco de papel', 'Mantencion completa', '2026-02-23 00:00:00', '2026-02-27 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-02-23 22:18:17', '2026-02-23 22:18:17'),
(332, 368, 7, 7, 'notebook', 'lenovo', 'ideapat 330', '165115165', 'Sin clave', 'Sin cargador', 'Problema en teclado  no le funcionan  la letra A y S', 'Problema en teclado  no le funcionan  la letra A y S', 'Cotizacion de teclado', '2026-02-23 00:00:00', '2026-02-24 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-02-23 23:36:02', '2026-02-23 23:36:02'),
(333, 457, 7, 7, 'Notenbok', 'HP', '240 G7', '456165165165', 'Sin clave', 'Sin cargador', 'tienen un ruido  en el ventilador del equipo', 'tienen un ruido  en el ventilador del equipo', 'Evaluacion completa enviar valores', '2026-02-24 00:00:00', '2026-02-27 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-02-24 18:17:39', '2026-02-24 18:17:39');
INSERT INTO `orden` (`id`, `idcliente`, `idtecnico`, `idusuario`, `nombreEquipo`, `marca`, `modelo`, `serial`, `clave`, `accesorios`, `observaciones`, `fallaEquipo`, `reparacion`, `fechaEntrada`, `fechaEntrega`, `adelanto`, `totalPagar`, `estado`, `imagen`, `created_at`, `updated_at`) VALUES
(334, 458, 7, 7, 'Notenbok', 'Lenovo', 'V14 G3 Iap', '5165165151', 'josefa2018', 'Sin cargador', 'Instalación de paquete de programas mas office permanente', 'Instalación de paquete de programas ms office permanente', 'Instalación de paquete de programas ms office permanente', '2026-02-24 00:00:00', '2026-02-25 00:00:00', 0.00, 50000.00, 'Ingresado', NULL, '2026-02-24 21:46:47', '2026-02-24 21:46:47'),
(335, 452, 8, 8, 'Parlante', 'JBL', 'JBL', 'JBL', 'NO APLICA', 'SIN ACCESORIOS', 'NO ENCIENDE', 'NO ENCIENDE|', 'EVALUACION PIN DE CARGA', '2026-02-24 00:00:00', '2026-02-27 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-02-24 22:39:05', '2026-02-24 22:39:05'),
(336, 175, 8, 8, 'Legion', 'Legion', 'Legion', 'Legion', 'no tiene', 'con cargador', 'Está lento al arrancar', 'Sin mantencion', 'Formateo sin respaldo + mantencion al sistema de ventilacion', '2026-02-25 00:00:00', '2026-03-02 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-02-25 18:03:54', '2026-02-25 18:03:54'),
(337, 175, 8, 8, 'Samsung', 'Samsung', 'Samsung', 'Samsung', 'No aplica', 'Con cargador', 'Capacidades limitadas', 'lentitud', 'Formateo sin respaldo', '2026-02-25 00:00:00', '2026-03-04 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-02-25 18:05:31', '2026-02-25 18:05:31'),
(338, 459, 7, 7, 'impresora', 'epson', 'l380', '451651651651', 'Sin clave', 'Sin cables', 'la impresora esta tirando un error de almohadillas de tinta llenas', 'la impresora esta tirando un error de almohadillas de tinta llenas', 'Cambio de almuadillas mas reset  mas evaluacion', '2026-03-02 00:00:00', '2026-02-25 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-02-25 23:52:18', '2026-02-25 23:52:18'),
(339, 460, 8, 8, 'Tablet', 'MLAB', 'Studio Max 10', 'mlabstudiomax', 'no aplica', 'sin cargador', 'tiene covertor negro', 'Pantalla dañada', 'evaluacion', '2026-02-25 00:00:00', '2026-03-03 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-02-26 00:30:21', '2026-02-26 00:30:21'),
(340, 461, 9, 9, 'Notebook', 'Lenovo', 'ideapad', '515645454', 'sin clave', 'sin accesorios', 'equipo con problemas de velocidad en arranque', 'lentitud general', 'evaluacion de sistema y componentes', '2026-02-25 00:00:00', '2027-02-01 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-02-26 01:34:33', '2026-02-26 01:34:33'),
(341, 462, 7, 7, 'impresora', 'Epson', 'L3110', '146165651', 'Sin clave', 'Sin cables', 'la impresora no esta imprimiendo bien y no bajan los colores', 'la impresora no esta imprimiendo bien y no bajan los colores', 'Evaluacion completa', '2026-02-26 00:00:00', '2026-03-03 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-02-26 16:57:35', '2026-02-26 16:57:35'),
(342, 462, 7, 7, 'notebook', 'HP ENVY', '13-BA0102LA', '416464654654', 'Sin clave', 'Sin cargador', 'el equipo  al cerrar se levanta de una esquina  evaluar  y mandar valores', 'el equipo  al cerrar se levanta de una esquina  evaluar  y mandar valores', 'evaluacion completa evaluar soporte de bisagra', '2026-02-26 00:00:00', '2026-03-04 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-02-26 17:53:20', '2026-02-26 17:53:20'),
(343, 463, 8, 8, 'IdeaPad S145-14IGM', 'LENOVO', '81MW', 'MTM81MW0024CL', 'sin clave', 'sin accesorios', 'Lentitud', 'Funciona Lento', 'Formateo con respaldo. evaluar aumento de ram y cotizar bateria', '2026-02-26 00:00:00', '2026-03-02 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-02-26 18:09:03', '2026-02-26 18:09:03'),
(344, 464, 7, 7, 'impresora', 'epson', 'l220', '2165165165', 'Sin clave', 'Sin cables', 'la impresora no le esta bajando la tinta', 'la impresora no le esta bajando la tinta', 'Evaluacion completa', '2026-02-26 00:00:00', '2026-03-06 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-02-26 23:35:13', '2026-02-26 23:35:13'),
(345, 466, 8, 8, 'Impresora', 'Epson', 'L395', 'epsonl395', 'no aplica', 'sin cables', 'Atasco de papel', 'No pasa papel', 'Evaluacion', '2026-02-27 00:00:00', '2026-03-05 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-02-27 16:22:23', '2026-02-27 16:22:23'),
(346, 467, 8, 8, 'Impresora', 'Canon', 'G3160', 'canong3160', 'no aplica', 'sin cables', 'Error en pantalla', 'Codigo 6800', 'Cotizar cambio de placa', '2026-02-27 00:00:00', '2026-03-06 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-02-27 22:41:53', '2026-02-27 22:41:53'),
(347, 7, 7, 7, 'notebook', 'lenovo', 'ideapad 3 155ada05', '1351351315', 'Sin clave', 'Sin cargador', 'el cliente vendra a fin de mes a retirar el equipo', 'el cliente vendra a fin de mes a retirar el equipo', 'Cambio de disco SSD 240', '2026-03-03 00:00:00', '2026-04-01 00:00:00', 45000.00, 90000.00, 'Ingresado', NULL, '2026-03-03 18:20:22', '2026-03-03 18:20:22'),
(348, 468, 7, 7, 'all in one', 'lenovo', 'z7s', '154168165165', 'Sin clave', 'Sin cables', 'el equipo no esta recibiendo energia y no enciende', 'mas el equipo tiene una patita de la pantalla dañada', 'Evaluacion completas', '2026-03-03 00:00:00', '2026-03-16 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-03-03 18:54:38', '2026-03-03 18:54:38'),
(349, 469, 8, 8, 'hp laptop', 'hp', '14-dq1003la', '5cd1112b99', '1140', 'sin cargador', 'Lentitud, evaluar componentes', 'Lentitud, evaluar componentes', 'Evaluacion mejora componentes mas formateo', '2026-03-03 00:00:00', '2026-03-11 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-03-03 22:05:22', '2026-03-03 22:05:22'),
(350, 470, 8, 8, 'All in one', 'Lenovo', 'AIO', '121545', 'NO APLICA', 'Sin accesorios', 'equipo ingresa para evaluacion prende pero no arranca sistema', 'solo evaluacion', 'a convenir con el cliente', '2026-03-05 00:00:00', '2026-03-10 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-03-05 21:10:26', '2026-03-05 21:10:26'),
(351, 471, 8, 8, 'hp laptop', 'hp', '14-dq2025la', '5cd212mc3c', 'no tiene', 'sin cargador', 'Se queda reparando al inicio', 'Disco o sistema operativo con problemas', 'Evaluar/reemplazar unidad de disco ssd', '2026-03-05 00:00:00', '2026-03-11 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-03-06 00:32:27', '2026-03-06 00:32:27'),
(352, 293, 7, 7, 'impresora', 'epson', 'l3150', '56516516416868', 'Sin clave', 'Sin Cables', 'la impresora no esta imprimiendo bien mas las almohadillas estan llenas', 'Evaluación Completa mandar valores', 'Evaluación Completa mandar valores', '2026-03-05 00:00:00', '2026-03-13 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-03-06 00:53:42', '2026-03-06 00:53:42'),
(353, 477, 8, 8, 'Ideapad Slim 3', 'Lenovo', '15IAH8', 'PF4V3VV1', '3011', 'sin cargador', 'Le cayó jugo en parte del teclado.', 'Tactil no funciona. Derrame de liquido-', 'Baño quimico', '2026-03-09 00:00:00', '2026-03-16 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-03-09 17:08:44', '2026-03-09 17:08:44'),
(354, 478, 7, 7, 'Notenbok', 'Lenovo', 'ideapad 3 14alc6', '5165189165', 'Sin clave', 'Sin cargador', 'Formateo Sin respaldo e instalar windows 11', 'Formateo Sin respaldo e instalar windows 11', 'Formateo Sin respaldo e instalar windows 11', '2026-03-09 00:00:00', '2026-03-13 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-03-09 18:00:33', '2026-03-09 18:00:33'),
(355, 479, 7, 7, 'VHS', 'VHS', 'VHS', '165165165165', 'Sin Clave', 'Sin cargador', 'traspaso de vhs a pendrive de  las 2 cintas', 'traspaso de vhs a pendrive', 'traspaso de vhs a pendrive', '2026-03-09 00:00:00', '2026-03-13 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-03-09 18:45:20', '2026-03-09 18:45:20'),
(356, 446, 8, 1, 'Aspire Lite 14', 'Acer', 'N23G1', 'NXD45AL00151069184500', 'la enviara al wsp', 'dejó la ram que compro', 'Cliente dice que su hijo le compro una ram incompatible y forzó para colocarla.', 'No funciona por mala manipulacion del hijo del cliente.', 'Evaluacion completa', '2026-03-09 00:00:00', '2026-03-17 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-03-09 19:01:17', '2026-03-09 19:01:41'),
(357, 489, 8, 8, 'Impresora', 'Epson', 'L3150', 'epsonl3150', 'no aplica', 'Sin cables', 'Hace rato no se usa.', 'En su momento tuvo atasco, jalaron la hoja fuerte y luego ya no imprime, solo pasa la hoja.', 'evaluacion completa', '2026-03-09 00:00:00', '2026-03-16 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-03-09 23:29:19', '2026-03-09 23:29:19'),
(358, 490, 7, 7, 'impresora', 'epson', 'l3150', '61556165165', 'Sin clave', 'Sin Cables', 'La impresora esta tirando  un error  y no deja imprimir', 'La impresora esta tirando  un error  y no deja imprimir', 'Evaluacion completa', '2026-03-10 00:00:00', '2026-03-16 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-03-10 18:29:32', '2026-03-10 18:29:32'),
(359, 491, 7, 7, 'notenbok', 'Lenovo', 'ideapad slim 15abr8', '1651681615', 'Sin clave', 'Con cargador y caja', 'Instalación de paquete de programa', 'Instalación de paquete de programa', 'Instalación de paquete de programa', '2026-03-11 00:00:00', '2026-03-12 00:00:00', 0.00, 18000.00, 'Ingresado', NULL, '2026-03-10 23:19:14', '2026-03-10 23:19:14'),
(360, 461, 9, 9, 'Notebook', 'DELL', 'Inspiron 15 3000', '3246546464', 'tania1981', 'con cargador', 'equipo con lentitud de inicio', 'inestabilidad de carga y lentitud', 'evaluacion de conflictos', '2026-03-10 00:00:00', '2026-03-20 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-03-11 01:58:56', '2026-03-11 01:58:56'),
(361, 492, 7, 7, 'notebook', 'HP', '245 G10', '151561531355', 'Chispita16.', 'Sin Cargador', 'Evlaucion Completa', 'el equipo no carga la barra de tarea', 'el equipo no carga la barra de tarea', '2026-03-11 00:00:00', '2026-03-12 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-03-11 18:13:03', '2026-03-11 18:13:03'),
(362, 493, 7, 7, 'telefono', 'Motorola', '?', '15156165165', 'Sin clave', 'Sin cargador', 'el equipo se apago y sono un pitido y no esta cargando', 'el equipo se apago y sono un pitido y no esta cargando', 'Evaluacion completa', '2026-03-13 00:00:00', '2026-03-17 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-03-13 19:13:25', '2026-03-13 19:13:25'),
(363, 494, 7, 7, 'notebook', 'HP', '15-db0010la', '1651651651651', 'Sin clave', 'Sin cargador', 'Cotizar bateria mas evaluar para mejora', 'el equipo  tiene la bateria mala', 'Evaluacion  Completa  mandar valores', '2026-03-16 00:00:00', '2026-03-19 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-03-16 16:16:04', '2026-03-16 16:16:04'),
(364, 495, 7, 7, 'impresora', 'canon', 'G2110', '16515615611', 'Sin clave', 'Sin cables', 'la impresora no estan bajando bien los colores', 'la impresora no estan bajando bien los colores', 'Evaluacion completa', '2026-03-16 00:00:00', '2026-03-23 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-03-16 23:15:56', '2026-03-16 23:15:56'),
(365, 496, 8, 8, 'Aspire one', 'Acer', 'Q1VZC', '30503900734', 'no tiene contraseña', 'sin accesorios', 'Equipo de limitadas caracteristicas. Muy probablemente venga con windows 8.', 'No consigue arrancar el sistema operativo.', 'Evaluacion.', '2026-03-16 00:00:00', '2026-03-25 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-03-17 00:32:05', '2026-03-17 00:32:05'),
(366, 497, 8, 8, 'tablet', 'Samsung', 'SM-P613', '255154', 'NO APLICA', 'Caja Pin y Cargador', 'equipo nuevo', 'perdida de cuenta google', 'eliminar FRP', '2026-03-17 00:00:00', '2026-03-20 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-03-18 01:50:52', '2026-03-18 01:50:52'),
(367, 498, 7, 1, 'impresora', 'Epson', 'l3110', '56165f1561', 'Sin clave', 'Sin cables', 'la impresora esta tirando un error con el cliente la intento revisar y desconecto los flex', 'la impresora esta tirando un error con el cliente la intento revisar y desconecto los flex', 'Evaluación completa', '2026-03-18 00:00:00', '2026-03-24 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-03-18 16:36:18', '2026-03-18 16:36:28'),
(368, 499, 8, 1, 'Hp laptop', 'hp', '14-dq1001la', 'hp14dq', '3121', 'sin cargador', 'usuario maximiliano', 'Falla en pantalla. En su momento le cayó orina de gato en el teclado.', 'Baño quimico. Diagnostico pantalla', '2026-03-19 00:00:00', '2026-03-26 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-03-19 18:02:48', '2026-03-25 00:48:42'),
(369, 500, 7, 1, 'NOTEBOOK', 'SAMSUNG', 'NP750XED', '641981981819', 'Sin clave', 'Con cargador', 'cotizacion de pantalla mandar valores', 'el equipo tienen la pantalla rota', 'Evaluación completa', '2026-03-19 00:00:00', '2026-03-27 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-03-19 21:16:57', '2026-03-19 21:17:22'),
(370, 501, 7, 7, 'notenbok', 'Asus', 'E402N', '165416516515', 'Sin clave', 'Con cargador', 'el equipo anda lento y se pega', 'el equipo anda lento y se pega', 'Evaluación completa', '2026-03-23 00:00:00', '2026-03-31 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-03-23 17:47:15', '2026-03-23 17:47:15'),
(371, 510, 7, 7, 'all  in one', 'HP', 'all  in one 12', '616515165156165', 'Sin clave', 'Sin cargador', 'el equipo anda lento', 'el equipo anda lento', 'Cambio de disco duro SSD 240', '2026-03-23 00:00:00', '2026-03-27 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-03-23 20:52:04', '2026-03-23 20:52:04'),
(372, 511, 8, 8, 'telefono', 'Samsung', 'Samsung Galaxy A25 5G', '051656151', 'Sin clave', 'Sin cables', 'el equipo le callo liquido mas se le pega la pantalla y tiene n algunos pixeles dañado', 'el equipo le callo liquido mas se le pega la pantalla y tiene n algunos pixeles dañado', 'Cambio de  pantalla', '2026-03-23 00:00:00', '2026-03-24 00:00:00', 0.00, 72000.00, 'Ingresado', NULL, '2026-03-23 23:27:23', '2026-03-23 23:27:23'),
(373, 512, 7, 7, 'impresora', 'Epson', 'l121', '5165165165165', 'Sin clave', 'Sin cables', 'la impresora esta imprimiendo con rayas', 'la impresora esta imprimiendo con rayas', 'evaluacion completa', '2026-03-24 00:00:00', '2026-03-31 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-03-24 18:51:44', '2026-03-24 18:51:44'),
(374, 513, 7, 7, 'impresora', 'Epson', 'L4160', '15461611', 'Sin clave', 'Sin cables', 'la impresora no esta bajando  el azul y el color negro  sale con rayas', 'la impresora no esta bajando  el azul y el color negro  sale con rayas', 'Evaluacion completa', '2026-03-24 00:00:00', '2026-03-30 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-03-24 19:24:09', '2026-03-24 19:24:09'),
(375, 514, 7, 7, 'notebook', 'Acer', 'SF314-511', '46544565', 'Compu2022@', 'Sin cargador', 'evaluar jack power el cargador queda suelto y no recibe energia', 'evaluar jack power el cargador queda suelto y no recibe energia', 'evaluacion completa', '2026-03-24 00:00:00', '2026-03-31 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-03-24 22:27:22', '2026-03-24 22:27:22'),
(376, 515, 9, 9, 'NOTEBOOK', 'LENOVO', 'IDEAPAD 330 S', '2121212121', 'SIN CLAVE', 'SIN ACCESORIOS', 'VISAGRA CON EXCESO DE TENSION, LIMP SIST VENTILACION FORM SIN RESP.', 'LENTITUD  SOBRELALENTAMIENTO Y LIMPIEZA GRAL', 'FORMATEO SIN RESPALDOS QUITAR TENSION A VISAGRAS  MANT SIST VENTILACION', '2026-03-24 00:00:00', '2026-03-27 00:00:00', 0.00, 48.00, 'Ingresado', NULL, '2026-03-25 03:29:47', '2026-03-25 03:29:47'),
(377, 516, 8, 8, 'Impresora', 'Epson', 'L3210', 'epsonl3210', 'no aplica', 'sin accesorios', 'Tinta negra casi vacía.', 'Imprime por partes.', 'Evaluacion completa. Agregar tinta black 455.', '2026-03-26 00:00:00', '2026-04-03 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-03-26 23:03:58', '2026-03-26 23:03:58'),
(378, 517, 7, 7, 'all in one', 'Acer', 'z1-601', 'all in one Acer', 'Sin clave', 'Sin cargador', 'el equipo anda lento', 'el equipo anda lento', 'evaluacion completa mandar valores', '2026-03-27 00:00:00', '2026-04-06 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-03-27 16:42:53', '2026-03-27 16:42:53'),
(379, 530, 7, 7, 'impresora', 'canon', 'G3100', '2165156165', 'Sin clave', 'Sin cables', 'la impresora esta tirando un error mas paso un buen tiernpo sin ocuparla', 'la impresora esta tirando un error mas paso un buen tiernpo sin ocuparla', 'Evaluación completa Mas mandar calores', '2026-03-27 00:00:00', '2026-04-07 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-03-27 17:05:48', '2026-03-27 17:05:48'),
(380, 531, 8, 8, 'Impresora', 'Epson', 'L3210', 'epsonl3210', 'no aplica', 'sin cables', 'No imprime en negro. Quedo mucho tiempo sin imprimir y cerca de una ventana.', 'No imprime bien, arroja error.', 'Evaluacion completa', '2026-03-27 00:00:00', '2026-04-02 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-03-28 00:10:10', '2026-03-28 00:10:10'),
(381, 532, 8, 8, 'Impresora', 'Canon', 'G3110', 'canong3110', 'no aplica', 'sin cables', 'Mangueras distribucion de tinta vacios.', 'No imprime bien.', 'Evaluacion completa y enviar diagnostico.', '2026-03-30 00:00:00', '2026-04-01 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-03-30 18:17:38', '2026-03-30 18:17:38'),
(382, 533, 7, 7, 'Notebook', 'lenovo', 'slim 3  15amn8', '216451651651', 'aloso', 'Sin cargador', 'instalación de office permanente', 'instalación de office permanente', 'instalación de office permanente', '2026-03-30 00:00:00', '2026-03-31 00:00:00', 0.00, 45000.00, 'Ingresado', NULL, '2026-03-30 23:39:22', '2026-03-30 23:39:22'),
(383, 534, 8, 8, 'IMPRESORA', 'CANON', 'G2110', '54465454', 'NO APLICA', 'SIN CABLES', 'IMPRESION DESALINEADA', 'ENCODER SUCIO', 'LIMPIEZA Y EVALUACION', '2026-03-31 00:00:00', '2026-04-07 00:00:00', 0.00, 0.00, 'Ingresado', NULL, '2026-04-01 01:01:06', '2026-04-01 01:01:06');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id` int UNSIGNED NOT NULL,
  `nombre` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `condicion` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id`, `nombre`, `descripcion`, `condicion`) VALUES
(1, 'Administrador', 'Administradores de área', 1),
(2, 'Tecnico', 'Tecnico', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tecnicos`
--

CREATE TABLE `tecnicos` (
  `id` int UNSIGNED NOT NULL,
  `nombre` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo_documento` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `num_documento` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `direccion` varchar(70) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telefono` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `condicion` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `tecnicos`
--

INSERT INTO `tecnicos` (`id`, `nombre`, `tipo_documento`, `num_documento`, `direccion`, `telefono`, `email`, `condicion`, `created_at`, `updated_at`) VALUES
(2, 'Cristian patric', 'DNI', '12341', NULL, NULL, NULL, 1, NULL, NULL),
(7, 'HECTOR ALMENDRAS', 'DNI', '18.345.239-8', 'Sucre 1275', '957869916', 'servidataventas@gmail.com', 1, '2024-11-17 21:05:35', '2024-11-17 21:05:38'),
(8, 'MARCELO SALAS', 'DNI', '19.369.975-8', 'Guaraníes 1569', '957869916', 'servidataventas@gmail.com', 1, NULL, NULL),
(9, 'HANS HERRERA', 'DNI', '13.388.246-4', 'SEVILLA 0560', '997343197', 'hans_h_martinez@yahoo.es', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` int UNSIGNED NOT NULL,
  `usuario` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `condicion` tinyint(1) NOT NULL DEFAULT '1',
  `idrol` int UNSIGNED NOT NULL,
  `idtecnico` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `usuario`, `password`, `condicion`, `idrol`, `idtecnico`) VALUES
(1, 'admin', '$2y$10$CD10K3aY2qqzh0vzqmREs.8lrWQgoxN97lQJxWBm6vYtbmK0N47rK', 1, 1, 2),
(7, 'Hector', '$2y$10$F.XoaL/cuAmuOe6fYmqqLOew2MwAHvBICY5nNChDHcd6jgj8NBs6u', 1, 2, 7),
(8, 'Marcelo', '$2y$10$QMqBDme6WXMI7cakjoGiq.QVmYia/oFyasq4vIOD/zr.nmrDZdFQu', 1, 2, 8),
(9, 'HANS', '$2y$10$15HTzj1DXStjSXjUhOLNK.5sVIzPsqDz2MJOaoUOQInqHSDWGnlsa', 1, 2, 9);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `clientes_nombre_unique` (`nombre`);

--
-- Indices de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indices de la tabla `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `orden`
--
ALTER TABLE `orden`
  ADD PRIMARY KEY (`id`),
  ADD KEY `orden_idcliente_foreign` (`idcliente`),
  ADD KEY `orden_idtecnico_foreign` (`idtecnico`),
  ADD KEY `orden_idusuario_foreign` (`idusuario`);

--
-- Indices de la tabla `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indices de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_nombre_unique` (`nombre`);

--
-- Indices de la tabla `tecnicos`
--
ALTER TABLE `tecnicos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `tecnicos_nombre_unique` (`nombre`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_usuario_unique` (`usuario`),
  ADD KEY `users_idrol_foreign` (`idrol`),
  ADD KEY `users_idtecnico_foreign` (`idtecnico`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=535;

--
-- AUTO_INCREMENT de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `orden`
--
ALTER TABLE `orden`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=384;

--
-- AUTO_INCREMENT de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `tecnicos`
--
ALTER TABLE `tecnicos`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `orden`
--
ALTER TABLE `orden`
  ADD CONSTRAINT `orden_idcliente_foreign` FOREIGN KEY (`idcliente`) REFERENCES `clientes` (`id`),
  ADD CONSTRAINT `orden_idtecnico_foreign` FOREIGN KEY (`idtecnico`) REFERENCES `tecnicos` (`id`),
  ADD CONSTRAINT `orden_idusuario_foreign` FOREIGN KEY (`idusuario`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_idrol_foreign` FOREIGN KEY (`idrol`) REFERENCES `roles` (`id`),
  ADD CONSTRAINT `users_idtecnico_foreign` FOREIGN KEY (`idtecnico`) REFERENCES `tecnicos` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
