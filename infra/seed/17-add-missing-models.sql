-- ============================================================================
-- FitSpec Seed #17: Add missing makes, models, and vehicles
-- New Makes: Chrysler, Lincoln, Acura, Infiniti, Volvo, Buick, Cadillac,
--            Genesis, Lexus, Audi, Land Rover, Porsche
-- New Models for existing + new makes, plus vehicles for all
-- ============================================================================

-- ==========================================================================
-- NEW MAKES (Id 19-30)
-- ==========================================================================
SET IDENTITY_INSERT Makes ON;

INSERT INTO Makes (Id, Name, Slug) VALUES
(19, 'Chrysler', 'chrysler'),
(20, 'Lincoln', 'lincoln'),
(21, 'Acura', 'acura'),
(22, 'Infiniti', 'infiniti'),
(23, 'Volvo', 'volvo'),
(24, 'Buick', 'buick'),
(25, 'Cadillac', 'cadillac'),
(26, 'Genesis', 'genesis'),
(27, 'Lexus', 'lexus'),
(28, 'Audi', 'audi'),
(29, 'Land Rover', 'land-rover'),
(30, 'Porsche', 'porsche');

SET IDENTITY_INSERT Makes OFF;

-- ==========================================================================
-- NEW MODELS (Id 81-180)
-- ==========================================================================
SET IDENTITY_INSERT Models ON;

INSERT INTO Models (Id, MakeId, Name, Slug) VALUES
(81, 18, 'Grand Caravan', 'grand-caravan'),
(82, 18, 'Challenger', 'challenger'),
(83, 18, 'Hornet', 'hornet'),
(84, 1, 'F-250', 'f-250'),
(85, 1, 'F-350', 'f-350'),
(86, 1, 'Bronco Sport', 'bronco-sport'),
(87, 1, 'Transit', 'transit'),
(88, 2, 'Suburban', 'suburban'),
(89, 2, 'Silverado 2500HD', 'silverado-2500hd'),
(90, 2, 'Silverado 3500HD', 'silverado-3500hd'),
(91, 2, 'Camaro', 'camaro'),
(92, 2, 'Bolt EV', 'bolt-ev'),
(93, 7, 'Sierra 2500HD', 'sierra-2500hd'),
(94, 7, 'Sierra 3500HD', 'sierra-3500hd'),
(95, 7, 'Yukon XL', 'yukon-xl'),
(96, 5, 'Odyssey', 'odyssey'),
(97, 5, 'Passport', 'passport'),
(98, 9, 'Kona', 'kona'),
(99, 9, 'Ioniq 5', 'ioniq-5'),
(100, 9, 'Sonata', 'sonata'),
(101, 9, 'Venue', 'venue'),
(102, 6, 'Wagoneer', 'wagoneer'),
(103, 6, 'Grand Wagoneer', 'grand-wagoneer'),
(104, 16, 'EV6', 'ev6'),
(105, 16, 'K5', 'k5'),
(106, 16, 'Carnival', 'carnival'),
(107, 16, 'Soul', 'soul'),
(108, 17, 'CX-30', 'cx-30'),
(109, 17, 'MX-5 Miata', 'mx-5-miata'),
(110, 12, 'C-Class', 'c-class'),
(111, 12, 'E-Class', 'e-class'),
(112, 12, 'GLA', 'gla'),
(113, 12, 'GLB', 'glb'),
(114, 12, 'GLS', 'gls'),
(115, 8, 'Murano', 'murano'),
(116, 8, 'Kicks', 'kicks'),
(117, 8, 'Armada', 'armada'),
(118, 10, 'Impreza', 'impreza'),
(119, 10, 'WRX', 'wrx'),
(120, 10, 'Legacy', 'legacy'),
(121, 10, 'Solterra', 'solterra'),
(122, 14, 'Model 3', 'model-3'),
(123, 14, 'Model X', 'model-x'),
(124, 14, 'Model S', 'model-s'),
(125, 3, 'Sequoia', 'sequoia'),
(126, 3, 'Prius', 'prius'),
(127, 3, 'Venza', 'venza'),
(128, 3, 'GR86', 'gr86'),
(129, 3, 'Land Cruiser', 'land-cruiser'),
(130, 13, 'Jetta', 'jetta'),
(131, 13, 'Golf', 'golf'),
(132, 13, 'ID.4', 'id-4'),
(133, 13, 'Taos', 'taos'),
(134, 11, '3 Series', '3-series'),
(135, 11, '5 Series', '5-series'),
(136, 11, 'X1', 'x1'),
(137, 11, 'X7', 'x7'),
(138, 19, 'Pacifica', 'pacifica'),
(139, 19, '300', '300'),
(140, 20, 'Aviator', 'aviator'),
(141, 20, 'Navigator', 'navigator'),
(142, 20, 'Corsair', 'corsair'),
(143, 21, 'MDX', 'mdx'),
(144, 21, 'RDX', 'rdx'),
(145, 21, 'TLX', 'tlx'),
(146, 21, 'Integra', 'integra'),
(147, 22, 'QX60', 'qx60'),
(148, 22, 'QX80', 'qx80'),
(149, 22, 'Q50', 'q50'),
(150, 23, 'XC90', 'xc90'),
(151, 23, 'XC60', 'xc60'),
(152, 23, 'XC40', 'xc40'),
(153, 23, 'S60', 's60'),
(154, 24, 'Enclave', 'enclave'),
(155, 24, 'Encore GX', 'encore-gx'),
(156, 24, 'Envista', 'envista'),
(157, 25, 'Escalade', 'escalade'),
(158, 25, 'XT5', 'xt5'),
(159, 25, 'XT4', 'xt4'),
(160, 25, 'CT5', 'ct5'),
(161, 26, 'GV70', 'gv70'),
(162, 26, 'GV80', 'gv80'),
(163, 26, 'G70', 'g70'),
(164, 27, 'RX', 'rx'),
(165, 27, 'NX', 'nx'),
(166, 27, 'GX', 'gx'),
(167, 27, 'IS', 'is'),
(168, 27, 'TX', 'tx'),
(169, 28, 'Q5', 'q5'),
(170, 28, 'Q7', 'q7'),
(171, 28, 'A4', 'a4'),
(172, 28, 'Q3', 'q3'),
(173, 28, 'e-tron', 'e-tron'),
(174, 29, 'Range Rover', 'range-rover'),
(175, 29, 'Range Rover Sport', 'range-rover-sport'),
(176, 29, 'Defender', 'defender'),
(177, 29, 'Discovery', 'discovery'),
(178, 30, 'Cayenne', 'cayenne'),
(179, 30, 'Macan', 'macan'),
(180, 30, '911', '911');

SET IDENTITY_INSERT Models OFF;

-- ==========================================================================
-- VEHICLES (starting at Id=798)
-- ==========================================================================
SET IDENTITY_INSERT Vehicles ON;

-- Grand Caravan (ModelId=81, MakeId=18): 2015-2020
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(798, 18, 81, 2015, 'SE', 'Minivan', 'FWD', 0),
(799, 18, 81, 2016, 'SXT', 'Minivan', 'FWD', 0),
(800, 18, 81, 2017, 'GT', 'Minivan', 'FWD', 0),
(801, 18, 81, 2018, 'SE Plus', 'Minivan', 'FWD', 0),
(802, 18, 81, 2019, 'SXT Plus', 'Minivan', 'FWD', 0),
(803, 18, 81, 2020, 'Crew', 'Minivan', 'FWD', 0);

-- Challenger (ModelId=82, MakeId=18): 2015-2023
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(804, 18, 82, 2015, 'SXT', 'Coupe', 'RWD', 0),
(805, 18, 82, 2016, 'R/T', 'Coupe', 'AWD', 0),
(806, 18, 82, 2017, 'GT', 'Coupe', 'RWD', 0),
(807, 18, 82, 2018, 'Scat Pack', 'Coupe', 'AWD', 0),
(808, 18, 82, 2019, 'SRT Hellcat', 'Coupe', 'RWD', 0),
(809, 18, 82, 2020, 'R/T Scat Pack', 'Coupe', 'AWD', 0),
(810, 18, 82, 2021, 'SXT AWD', 'Coupe', 'RWD', 0),
(811, 18, 82, 2022, 'GT AWD', 'Coupe', 'AWD', 0),
(812, 18, 82, 2023, 'SRT Jailbreak', 'Coupe', 'RWD', 0);

-- Hornet (ModelId=83, MakeId=18): 2023-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(813, 18, 83, 2023, 'GT', 'SUV', 'AWD', 2000),
(814, 18, 83, 2024, 'GT Plus', 'SUV', 'AWD', 2000),
(815, 18, 83, 2025, 'R/T', 'SUV', 'AWD', 2000),
(816, 18, 83, 2026, 'R/T Plus', 'SUV', 'AWD', 2000);

-- F-250 (ModelId=84, MakeId=1): 2015-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(817, 1, 84, 2015, 'XL', 'Crew Cab', '4WD', 12000),
(818, 1, 84, 2016, 'XLT', 'Crew Cab', 'RWD', 12300),
(819, 1, 84, 2017, 'Lariat', 'Crew Cab', '4WD', 12500),
(820, 1, 84, 2018, 'King Ranch', 'Crew Cab', 'RWD', 12800),
(821, 1, 84, 2019, 'Platinum', 'Crew Cab', '4WD', 13100),
(822, 1, 84, 2020, 'Limited', 'Crew Cab', 'RWD', 13400),
(823, 1, 84, 2021, 'Tremor', 'Crew Cab', '4WD', 13600),
(824, 1, 84, 2022, 'XLT Sport', 'Crew Cab', 'RWD', 13900),
(825, 1, 84, 2023, 'Lariat Sport', 'Crew Cab', '4WD', 14200),
(826, 1, 84, 2024, 'XL Value', 'Crew Cab', 'RWD', 14500),
(827, 1, 84, 2025, 'XLT Premium', 'Crew Cab', '4WD', 14700),
(828, 1, 84, 2026, 'King Ranch Ultimate', 'Crew Cab', 'RWD', 15000);

-- F-350 (ModelId=85, MakeId=1): 2015-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(829, 1, 85, 2015, 'XL', 'Crew Cab', '4WD', 15000),
(830, 1, 85, 2016, 'XLT', 'Crew Cab', 'RWD', 15500),
(831, 1, 85, 2017, 'Lariat', 'Crew Cab', '4WD', 16100),
(832, 1, 85, 2018, 'King Ranch', 'Crew Cab', 'RWD', 16600),
(833, 1, 85, 2019, 'Platinum', 'Crew Cab', '4WD', 17200),
(834, 1, 85, 2020, 'Limited', 'Crew Cab', 'RWD', 17700),
(835, 1, 85, 2021, 'Tremor', 'Crew Cab', '4WD', 18300),
(836, 1, 85, 2022, 'XL DRW', 'Crew Cab', 'RWD', 18800),
(837, 1, 85, 2023, 'XLT DRW', 'Crew Cab', '4WD', 19400),
(838, 1, 85, 2024, 'Lariat DRW', 'Crew Cab', 'RWD', 19900),
(839, 1, 85, 2025, 'King Ranch DRW', 'Crew Cab', '4WD', 20500),
(840, 1, 85, 2026, 'Platinum DRW', 'Crew Cab', 'RWD', 21000);

-- Bronco Sport (ModelId=86, MakeId=1): 2021-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(841, 1, 86, 2021, 'Base', 'SUV', 'AWD', 2000),
(842, 1, 86, 2022, 'Big Bend', 'SUV', '4WD', 2000),
(843, 1, 86, 2023, 'Outer Banks', 'SUV', 'AWD', 2100),
(844, 1, 86, 2024, 'Badlands', 'SUV', '4WD', 2100),
(845, 1, 86, 2025, 'Heritage', 'SUV', 'AWD', 2200),
(846, 1, 86, 2026, 'Heritage Limited', 'SUV', '4WD', 2200);

-- Transit (ModelId=87, MakeId=1): 2015-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(847, 1, 87, 2015, 'Base', 'Van', 'RWD', 0),
(848, 1, 87, 2016, 'XL', 'Van', 'AWD', 0),
(849, 1, 87, 2017, 'XLT', 'Van', 'RWD', 0),
(850, 1, 87, 2018, '150 Low Roof', 'Van', 'AWD', 0),
(851, 1, 87, 2019, '250 Med Roof', 'Van', 'RWD', 0),
(852, 1, 87, 2020, '350 High Roof', 'Van', 'AWD', 0),
(853, 1, 87, 2021, '250 Low Roof', 'Van', 'RWD', 0),
(854, 1, 87, 2022, '350 EXT High Roof', 'Van', 'AWD', 0),
(855, 1, 87, 2023, '150 Cargo', 'Van', 'RWD', 0),
(856, 1, 87, 2024, '250 Cargo', 'Van', 'AWD', 0),
(857, 1, 87, 2025, '350 Cargo', 'Van', 'RWD', 0),
(858, 1, 87, 2026, 'XL Cargo', 'Van', 'AWD', 0);

-- Suburban (ModelId=88, MakeId=2): 2015-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(859, 2, 88, 2015, 'LS', 'SUV', '4WD', 7700),
(860, 2, 88, 2016, 'LT', 'SUV', 'RWD', 7800),
(861, 2, 88, 2017, 'RST', 'SUV', '4WD', 7800),
(862, 2, 88, 2018, 'Z71', 'SUV', 'RWD', 7900),
(863, 2, 88, 2019, 'Premier', 'SUV', '4WD', 7900),
(864, 2, 88, 2020, 'High Country', 'SUV', 'RWD', 8000),
(865, 2, 88, 2021, 'LT Luxury', 'SUV', '4WD', 8000),
(866, 2, 88, 2022, 'RST Performance', 'SUV', 'RWD', 8100),
(867, 2, 88, 2023, 'Z71 Midnight', 'SUV', '4WD', 8100),
(868, 2, 88, 2024, 'LS Fleet', 'SUV', 'RWD', 8200),
(869, 2, 88, 2025, 'LT Premium', 'SUV', '4WD', 8200),
(870, 2, 88, 2026, 'Premier Midnight', 'SUV', 'RWD', 8300);

-- Silverado 2500HD (ModelId=89, MakeId=2): 2015-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(871, 2, 89, 2015, 'Work Truck', 'Crew Cab', '4WD', 14500),
(872, 2, 89, 2016, 'Custom', 'Crew Cab', 'RWD', 14900),
(873, 2, 89, 2017, 'LT', 'Crew Cab', '4WD', 15200),
(874, 2, 89, 2018, 'LTZ', 'Crew Cab', 'RWD', 15600),
(875, 2, 89, 2019, 'High Country', 'Crew Cab', '4WD', 16000),
(876, 2, 89, 2020, 'ZR2', 'Crew Cab', 'RWD', 16300),
(877, 2, 89, 2021, 'Custom Trail Boss', 'Crew Cab', '4WD', 16700),
(878, 2, 89, 2022, 'LT Trail Boss', 'Crew Cab', 'RWD', 17000),
(879, 2, 89, 2023, 'Work Truck Pro', 'Crew Cab', '4WD', 17400),
(880, 2, 89, 2024, 'LTZ Plus', 'Crew Cab', 'RWD', 17800),
(881, 2, 89, 2025, 'High Country Deluxe', 'Crew Cab', '4WD', 18100),
(882, 2, 89, 2026, 'ZR2 Bison', 'Crew Cab', 'RWD', 18500);

-- Silverado 3500HD (ModelId=90, MakeId=2): 2015-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(883, 2, 90, 2015, 'Work Truck', 'Crew Cab', '4WD', 18000),
(884, 2, 90, 2016, 'Custom', 'Crew Cab', 'RWD', 18500),
(885, 2, 90, 2017, 'LT', 'Crew Cab', '4WD', 19000),
(886, 2, 90, 2018, 'LTZ', 'Crew Cab', 'RWD', 19500),
(887, 2, 90, 2019, 'High Country', 'Crew Cab', '4WD', 20000),
(888, 2, 90, 2020, 'Work Truck DRW', 'Crew Cab', 'RWD', 20500),
(889, 2, 90, 2021, 'LT DRW', 'Crew Cab', '4WD', 21000),
(890, 2, 90, 2022, 'LTZ DRW', 'Crew Cab', 'RWD', 21500),
(891, 2, 90, 2023, 'High Country DRW', 'Crew Cab', '4WD', 22000),
(892, 2, 90, 2024, 'Custom DRW', 'Crew Cab', 'RWD', 22500),
(893, 2, 90, 2025, 'LT Chassis', 'Crew Cab', '4WD', 23000),
(894, 2, 90, 2026, 'LTZ Chassis', 'Crew Cab', 'RWD', 23500);

-- Camaro (ModelId=91, MakeId=2): 2015-2024
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(895, 2, 91, 2015, 'LT', 'Coupe', 'RWD', 0),
(896, 2, 91, 2016, '1LT', 'Coupe', 'RWD', 0),
(897, 2, 91, 2017, '2LT', 'Coupe', 'RWD', 0),
(898, 2, 91, 2018, 'LT1', 'Coupe', 'RWD', 0),
(899, 2, 91, 2019, 'SS', 'Coupe', 'RWD', 0),
(900, 2, 91, 2020, 'ZL1', 'Coupe', 'RWD', 0),
(901, 2, 91, 2021, '1SS', 'Coupe', 'RWD', 0),
(902, 2, 91, 2022, '2SS', 'Coupe', 'RWD', 0),
(903, 2, 91, 2023, 'RS', 'Coupe', 'RWD', 0),
(904, 2, 91, 2024, 'LT RS', 'Coupe', 'RWD', 0);

-- Bolt EV (ModelId=92, MakeId=2): 2017-2023
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(905, 2, 92, 2017, 'LT', 'Hatchback', 'FWD', 0),
(906, 2, 92, 2018, 'Premier', 'Hatchback', 'FWD', 0),
(907, 2, 92, 2019, '1LT', 'Hatchback', 'FWD', 0),
(908, 2, 92, 2020, '2LT', 'Hatchback', 'FWD', 0),
(909, 2, 92, 2021, 'LT Preferred', 'Hatchback', 'FWD', 0),
(910, 2, 92, 2022, 'Premier Preferred', 'Hatchback', 'FWD', 0),
(911, 2, 92, 2023, 'LT Comfort', 'Hatchback', 'FWD', 0);

-- Sierra 2500HD (ModelId=93, MakeId=7): 2015-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(912, 7, 93, 2015, 'Pro', 'Crew Cab', '4WD', 14500),
(913, 7, 93, 2016, 'SLE', 'Crew Cab', 'RWD', 14900),
(914, 7, 93, 2017, 'SLT', 'Crew Cab', '4WD', 15200),
(915, 7, 93, 2018, 'AT4', 'Crew Cab', 'RWD', 15600),
(916, 7, 93, 2019, 'Denali', 'Crew Cab', '4WD', 16000),
(917, 7, 93, 2020, 'Denali Ultimate', 'Crew Cab', 'RWD', 16300),
(918, 7, 93, 2021, 'AT4X', 'Crew Cab', '4WD', 16700),
(919, 7, 93, 2022, 'SLE Preferred', 'Crew Cab', 'RWD', 17000),
(920, 7, 93, 2023, 'SLT Preferred', 'Crew Cab', '4WD', 17400),
(921, 7, 93, 2024, 'AT4 Preferred', 'Crew Cab', 'RWD', 17800),
(922, 7, 93, 2025, 'Denali Reserve', 'Crew Cab', '4WD', 18100),
(923, 7, 93, 2026, 'Pro Value', 'Crew Cab', 'RWD', 18500);

-- Sierra 3500HD (ModelId=94, MakeId=7): 2015-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(924, 7, 94, 2015, 'Pro', 'Crew Cab', '4WD', 18000),
(925, 7, 94, 2016, 'SLE', 'Crew Cab', 'RWD', 18500),
(926, 7, 94, 2017, 'SLT', 'Crew Cab', '4WD', 19000),
(927, 7, 94, 2018, 'AT4', 'Crew Cab', 'RWD', 19500),
(928, 7, 94, 2019, 'Denali', 'Crew Cab', '4WD', 20000),
(929, 7, 94, 2020, 'Denali Ultimate', 'Crew Cab', 'RWD', 20500),
(930, 7, 94, 2021, 'Pro DRW', 'Crew Cab', '4WD', 21000),
(931, 7, 94, 2022, 'SLE DRW', 'Crew Cab', 'RWD', 21500),
(932, 7, 94, 2023, 'SLT DRW', 'Crew Cab', '4WD', 22000),
(933, 7, 94, 2024, 'Denali DRW', 'Crew Cab', 'RWD', 22500),
(934, 7, 94, 2025, 'AT4 DRW', 'Crew Cab', '4WD', 23000),
(935, 7, 94, 2026, 'Denali Ultimate DRW', 'Crew Cab', 'RWD', 23500);

-- Yukon XL (ModelId=95, MakeId=7): 2015-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(936, 7, 95, 2015, 'SLE', 'SUV', '4WD', 7900),
(937, 7, 95, 2016, 'SLT', 'SUV', 'RWD', 7900),
(938, 7, 95, 2017, 'AT4', 'SUV', '4WD', 8000),
(939, 7, 95, 2018, 'Denali', 'SUV', 'RWD', 8000),
(940, 7, 95, 2019, 'Denali Ultimate', 'SUV', '4WD', 8100),
(941, 7, 95, 2020, 'SLE Preferred', 'SUV', 'RWD', 8100),
(942, 7, 95, 2021, 'SLT Premium', 'SUV', '4WD', 8200),
(943, 7, 95, 2022, 'AT4 Premium', 'SUV', 'RWD', 8200),
(944, 7, 95, 2023, 'Denali Reserve', 'SUV', '4WD', 8300),
(945, 7, 95, 2024, 'SLT Midnight', 'SUV', 'RWD', 8300),
(946, 7, 95, 2025, 'Denali Midnight', 'SUV', '4WD', 8400),
(947, 7, 95, 2026, 'SLE Fleet', 'SUV', 'RWD', 8400);

-- Odyssey (ModelId=96, MakeId=5): 2015-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(948, 5, 96, 2015, 'LX', 'Minivan', 'FWD', 3500),
(949, 5, 96, 2016, 'EX', 'Minivan', 'FWD', 3500),
(950, 5, 96, 2017, 'EX-L', 'Minivan', 'FWD', 3500),
(951, 5, 96, 2018, 'Sport', 'Minivan', 'FWD', 3500),
(952, 5, 96, 2019, 'Touring', 'Minivan', 'FWD', 3500),
(953, 5, 96, 2020, 'Elite', 'Minivan', 'FWD', 3500),
(954, 5, 96, 2021, 'SE', 'Minivan', 'FWD', 3500),
(955, 5, 96, 2022, 'EX-L Navi', 'Minivan', 'FWD', 3500),
(956, 5, 96, 2023, 'Touring Elite', 'Minivan', 'FWD', 3500),
(957, 5, 96, 2024, 'Sport Touring', 'Minivan', 'FWD', 3500),
(958, 5, 96, 2025, 'LX SE', 'Minivan', 'FWD', 3500),
(959, 5, 96, 2026, 'EX Sport', 'Minivan', 'FWD', 3500);

-- Passport (ModelId=97, MakeId=5): 2019-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(960, 5, 97, 2019, 'Sport', 'SUV', 'AWD', 3500),
(961, 5, 97, 2020, 'EX-L', 'SUV', 'FWD', 3700),
(962, 5, 97, 2021, 'Touring', 'SUV', 'AWD', 3900),
(963, 5, 97, 2022, 'Elite', 'SUV', 'FWD', 4100),
(964, 5, 97, 2023, 'TrailSport', 'SUV', 'AWD', 4400),
(965, 5, 97, 2024, 'Sport Touring', 'SUV', 'FWD', 4600),
(966, 5, 97, 2025, 'EX-L Navi', 'SUV', 'AWD', 4800),
(967, 5, 97, 2026, 'Touring AWD', 'SUV', 'FWD', 5000);

-- Kona (ModelId=98, MakeId=9): 2018-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(968, 9, 98, 2018, 'SE', 'SUV', 'FWD', 0),
(969, 9, 98, 2019, 'SEL', 'SUV', 'AWD', 0),
(970, 9, 98, 2020, 'N Line', 'SUV', 'FWD', 0),
(971, 9, 98, 2021, 'Limited', 'SUV', 'AWD', 0),
(972, 9, 98, 2022, 'Ultimate', 'SUV', 'FWD', 0),
(973, 9, 98, 2023, 'SEL Plus', 'SUV', 'AWD', 0),
(974, 9, 98, 2024, 'N Line Ultimate', 'SUV', 'FWD', 0),
(975, 9, 98, 2025, 'SE Special', 'SUV', 'AWD', 0),
(976, 9, 98, 2026, 'Night Edition', 'SUV', 'FWD', 0);

-- Ioniq 5 (ModelId=99, MakeId=9): 2022-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(977, 9, 99, 2022, 'SE Standard Range', 'SUV', 'RWD', 0),
(978, 9, 99, 2023, 'SE Long Range', 'SUV', 'AWD', 0),
(979, 9, 99, 2024, 'SEL', 'SUV', 'RWD', 0),
(980, 9, 99, 2025, 'Limited', 'SUV', 'AWD', 0),
(981, 9, 99, 2026, 'N', 'SUV', 'RWD', 0);

-- Sonata (ModelId=100, MakeId=9): 2015-2024
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(982, 9, 100, 2015, 'SE', 'Sedan', 'FWD', 0),
(983, 9, 100, 2016, 'SEL', 'Sedan', 'FWD', 0),
(984, 9, 100, 2017, 'SEL Plus', 'Sedan', 'FWD', 0),
(985, 9, 100, 2018, 'Sport', 'Sedan', 'FWD', 0),
(986, 9, 100, 2019, 'Limited', 'Sedan', 'FWD', 0),
(987, 9, 100, 2020, 'N Line', 'Sedan', 'FWD', 0),
(988, 9, 100, 2021, 'SE Special', 'Sedan', 'FWD', 0),
(989, 9, 100, 2022, 'SEL Premium', 'Sedan', 'FWD', 0),
(990, 9, 100, 2023, 'Sport 2.0T', 'Sedan', 'FWD', 0),
(991, 9, 100, 2024, 'Limited Ultimate', 'Sedan', 'FWD', 0);

-- Venue (ModelId=101, MakeId=9): 2020-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(992, 9, 101, 2020, 'SE', 'SUV', 'FWD', 0),
(993, 9, 101, 2021, 'SEL', 'SUV', 'FWD', 0),
(994, 9, 101, 2022, 'Limited', 'SUV', 'FWD', 0),
(995, 9, 101, 2023, 'Denim', 'SUV', 'FWD', 0),
(996, 9, 101, 2024, 'SEL Premium', 'SUV', 'FWD', 0),
(997, 9, 101, 2025, 'Night Edition', 'SUV', 'FWD', 0),
(998, 9, 101, 2026, 'SE Value', 'SUV', 'FWD', 0);

-- Wagoneer (ModelId=102, MakeId=6): 2022-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(999, 6, 102, 2022, 'Series I', 'SUV', '4WD', 9900),
(1000, 6, 102, 2023, 'Series II', 'SUV', 'RWD', 9900),
(1001, 6, 102, 2024, 'Series III', 'SUV', '4WD', 9900),
(1002, 6, 102, 2025, 'Carbide', 'SUV', 'RWD', 10000),
(1003, 6, 102, 2026, 'Hurricane', 'SUV', '4WD', 10000);

-- Grand Wagoneer (ModelId=103, MakeId=6): 2022-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1004, 6, 103, 2022, 'Series I', 'SUV', '4WD', 9900),
(1005, 6, 103, 2023, 'Series II', 'SUV', '4WD', 9900),
(1006, 6, 103, 2024, 'Series III', 'SUV', '4WD', 9900),
(1007, 6, 103, 2025, 'Obsidian', 'SUV', '4WD', 10000),
(1008, 6, 103, 2026, 'Hurricane', 'SUV', '4WD', 10000);

-- EV6 (ModelId=104, MakeId=16): 2022-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1009, 16, 104, 2022, 'Light', 'SUV', 'RWD', 0),
(1010, 16, 104, 2023, 'Wind', 'SUV', 'AWD', 0),
(1011, 16, 104, 2024, 'GT-Line', 'SUV', 'RWD', 0),
(1012, 16, 104, 2025, 'GT', 'SUV', 'AWD', 0),
(1013, 16, 104, 2026, 'Wind AWD', 'SUV', 'RWD', 0);

-- K5 (ModelId=105, MakeId=16): 2021-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1014, 16, 105, 2021, 'LX', 'Sedan', 'FWD', 0),
(1015, 16, 105, 2022, 'LXS', 'Sedan', 'AWD', 0),
(1016, 16, 105, 2023, 'GT-Line', 'Sedan', 'FWD', 0),
(1017, 16, 105, 2024, 'EX', 'Sedan', 'AWD', 0),
(1018, 16, 105, 2025, 'GT', 'Sedan', 'FWD', 0),
(1019, 16, 105, 2026, 'GT-Line AWD', 'Sedan', 'AWD', 0);

-- Carnival (ModelId=106, MakeId=16): 2022-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1020, 16, 106, 2022, 'LX', 'Minivan', 'FWD', 3500),
(1021, 16, 106, 2023, 'LX Seat Pkg', 'Minivan', 'FWD', 3500),
(1022, 16, 106, 2024, 'EX', 'Minivan', 'FWD', 3500),
(1023, 16, 106, 2025, 'EX Seat Pkg', 'Minivan', 'FWD', 3500),
(1024, 16, 106, 2026, 'SX', 'Minivan', 'FWD', 3500);

-- Soul (ModelId=107, MakeId=16): 2015-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1025, 16, 107, 2015, 'LX', 'Hatchback', 'FWD', 0),
(1026, 16, 107, 2016, 'S', 'Hatchback', 'FWD', 0),
(1027, 16, 107, 2017, 'EX', 'Hatchback', 'FWD', 0),
(1028, 16, 107, 2018, 'GT-Line', 'Hatchback', 'FWD', 0),
(1029, 16, 107, 2019, 'Turbo', 'Hatchback', 'FWD', 0),
(1030, 16, 107, 2020, 'X-Line', 'Hatchback', 'FWD', 0),
(1031, 16, 107, 2021, 'Base', 'Hatchback', 'FWD', 0),
(1032, 16, 107, 2022, 'Plus', 'Hatchback', 'FWD', 0),
(1033, 16, 107, 2023, 'EX Designer', 'Hatchback', 'FWD', 0),
(1034, 16, 107, 2024, 'GT-Line Tech', 'Hatchback', 'FWD', 0),
(1035, 16, 107, 2025, 'LX Tech', 'Hatchback', 'FWD', 0),
(1036, 16, 107, 2026, 'S Tech', 'Hatchback', 'FWD', 0);

-- CX-30 (ModelId=108, MakeId=17): 2020-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1037, 17, 108, 2020, 'Base', 'SUV', 'FWD', 0),
(1038, 17, 108, 2021, 'Select', 'SUV', 'AWD', 0),
(1039, 17, 108, 2022, 'Preferred', 'SUV', 'FWD', 0),
(1040, 17, 108, 2023, 'Premium', 'SUV', 'AWD', 0),
(1041, 17, 108, 2024, 'Turbo', 'SUV', 'FWD', 0),
(1042, 17, 108, 2025, 'Turbo Premium', 'SUV', 'AWD', 0),
(1043, 17, 108, 2026, 'Carbon Edition', 'SUV', 'FWD', 0);

-- MX-5 Miata (ModelId=109, MakeId=17): 2015-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1044, 17, 109, 2015, 'Sport', 'Convertible', 'RWD', 0),
(1045, 17, 109, 2016, 'Club', 'Convertible', 'RWD', 0),
(1046, 17, 109, 2017, 'Grand Touring', 'Convertible', 'RWD', 0),
(1047, 17, 109, 2018, 'RF', 'Convertible', 'RWD', 0),
(1048, 17, 109, 2019, 'RF Club', 'Convertible', 'RWD', 0),
(1049, 17, 109, 2020, 'RF Grand Touring', 'Convertible', 'RWD', 0),
(1050, 17, 109, 2021, 'Sport MT', 'Convertible', 'RWD', 0),
(1051, 17, 109, 2022, 'Club MT', 'Convertible', 'RWD', 0),
(1052, 17, 109, 2023, 'Grand Touring AT', 'Convertible', 'RWD', 0),
(1053, 17, 109, 2024, 'RF Club MT', 'Convertible', 'RWD', 0),
(1054, 17, 109, 2025, 'RF Grand Touring AT', 'Convertible', 'RWD', 0),
(1055, 17, 109, 2026, 'Special Edition', 'Convertible', 'RWD', 0);

-- C-Class (ModelId=110, MakeId=12): 2015-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1056, 12, 110, 2015, 'C 300', 'Sedan', 'RWD', 0),
(1057, 12, 110, 2016, 'C 300 4MATIC', 'Sedan', 'AWD', 0),
(1058, 12, 110, 2017, 'AMG C 43', 'Sedan', 'RWD', 0),
(1059, 12, 110, 2018, 'AMG C 63', 'Sedan', 'AWD', 0),
(1060, 12, 110, 2019, 'C 300e', 'Sedan', 'RWD', 0),
(1061, 12, 110, 2020, 'C 300 Sport', 'Sedan', 'AWD', 0),
(1062, 12, 110, 2021, 'AMG C 43 4MATIC', 'Sedan', 'RWD', 0),
(1063, 12, 110, 2022, 'C 300 Exclusive', 'Sedan', 'AWD', 0),
(1064, 12, 110, 2023, 'C 300 Avantgarde', 'Sedan', 'RWD', 0),
(1065, 12, 110, 2024, 'AMG C 63 S', 'Sedan', 'AWD', 0),
(1066, 12, 110, 2025, 'C 300d', 'Sedan', 'RWD', 0),
(1067, 12, 110, 2026, 'C 350e', 'Sedan', 'AWD', 0);

-- E-Class (ModelId=111, MakeId=12): 2017-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1068, 12, 111, 2017, 'E 350', 'Sedan', 'RWD', 0),
(1069, 12, 111, 2018, 'E 350 4MATIC', 'Sedan', 'AWD', 0),
(1070, 12, 111, 2019, 'E 450', 'Sedan', 'RWD', 0),
(1071, 12, 111, 2020, 'AMG E 53', 'Sedan', 'AWD', 0),
(1072, 12, 111, 2021, 'AMG E 63 S', 'Sedan', 'RWD', 0),
(1073, 12, 111, 2022, 'E 300', 'Sedan', 'AWD', 0),
(1074, 12, 111, 2023, 'E 450 4MATIC', 'Sedan', 'RWD', 0),
(1075, 12, 111, 2024, 'AMG E 53 4MATIC+', 'Sedan', 'AWD', 0),
(1076, 12, 111, 2025, 'E 350 Exclusive', 'Sedan', 'RWD', 0),
(1077, 12, 111, 2026, 'AMG E 63 S 4MATIC+', 'Sedan', 'AWD', 0);

-- GLA (ModelId=112, MakeId=12): 2015-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1078, 12, 112, 2015, 'GLA 250', 'SUV', 'FWD', 0),
(1079, 12, 112, 2016, 'GLA 250 4MATIC', 'SUV', 'AWD', 0),
(1080, 12, 112, 2017, 'AMG GLA 35', 'SUV', 'FWD', 0),
(1081, 12, 112, 2018, 'AMG GLA 45', 'SUV', 'AWD', 0),
(1082, 12, 112, 2019, 'GLA 250e', 'SUV', 'FWD', 0),
(1083, 12, 112, 2020, 'GLA 250 Sport', 'SUV', 'AWD', 0),
(1084, 12, 112, 2021, 'GLA 250 Progressive', 'SUV', 'FWD', 0),
(1085, 12, 112, 2022, 'AMG GLA 35 4MATIC', 'SUV', 'AWD', 0),
(1086, 12, 112, 2023, 'AMG GLA 45 S', 'SUV', 'FWD', 0),
(1087, 12, 112, 2024, 'GLA 250 Night Edition', 'SUV', 'AWD', 0),
(1088, 12, 112, 2025, 'GLA 250 Premium', 'SUV', 'FWD', 0),
(1089, 12, 112, 2026, 'GLA 250 Exclusive', 'SUV', 'AWD', 0);

-- GLB (ModelId=113, MakeId=12): 2020-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1090, 12, 113, 2020, 'GLB 250', 'SUV', 'FWD', 0),
(1091, 12, 113, 2021, 'GLB 250 4MATIC', 'SUV', 'AWD', 0),
(1092, 12, 113, 2022, 'AMG GLB 35', 'SUV', 'FWD', 0),
(1093, 12, 113, 2023, 'GLB 250 Sport', 'SUV', 'AWD', 0),
(1094, 12, 113, 2024, 'AMG GLB 35 4MATIC', 'SUV', 'FWD', 0),
(1095, 12, 113, 2025, 'GLB 250 Progressive', 'SUV', 'AWD', 0),
(1096, 12, 113, 2026, 'GLB 250 Night Edition', 'SUV', 'FWD', 0);

-- GLS (ModelId=114, MakeId=12): 2017-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1097, 12, 114, 2017, 'GLS 450', 'SUV', 'AWD', 7500),
(1098, 12, 114, 2018, 'GLS 450 4MATIC', 'SUV', '4WD', 7500),
(1099, 12, 114, 2019, 'GLS 580', 'SUV', 'AWD', 7500),
(1100, 12, 114, 2020, 'AMG GLS 63', 'SUV', '4WD', 7600),
(1101, 12, 114, 2021, 'Maybach GLS 600', 'SUV', 'AWD', 7600),
(1102, 12, 114, 2022, 'GLS 450 Sport', 'SUV', '4WD', 7600),
(1103, 12, 114, 2023, 'GLS 580 4MATIC', 'SUV', 'AWD', 7600),
(1104, 12, 114, 2024, 'AMG GLS 63 4MATIC+', 'SUV', '4WD', 7700),
(1105, 12, 114, 2025, 'GLS 450 Night Edition', 'SUV', 'AWD', 7700),
(1106, 12, 114, 2026, 'Maybach GLS 600 4MATIC', 'SUV', '4WD', 7700);

-- Murano (ModelId=115, MakeId=8): 2015-2025
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1107, 8, 115, 2015, 'S', 'SUV', 'FWD', 0),
(1108, 8, 115, 2016, 'SV', 'SUV', 'AWD', 0),
(1109, 8, 115, 2017, 'SL', 'SUV', 'FWD', 0),
(1110, 8, 115, 2018, 'Platinum', 'SUV', 'AWD', 0),
(1111, 8, 115, 2019, 'Midnight Edition', 'SUV', 'FWD', 0),
(1112, 8, 115, 2020, 'SV Premium', 'SUV', 'AWD', 0),
(1113, 8, 115, 2021, 'SL Premium', 'SUV', 'FWD', 0),
(1114, 8, 115, 2022, 'Platinum Reserve', 'SUV', 'AWD', 0),
(1115, 8, 115, 2023, 'S Special', 'SUV', 'FWD', 0),
(1116, 8, 115, 2024, 'SV Midnight', 'SUV', 'AWD', 0),
(1117, 8, 115, 2025, 'SL Midnight', 'SUV', 'FWD', 0);

-- Kicks (ModelId=116, MakeId=8): 2018-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1118, 8, 116, 2018, 'S', 'SUV', 'FWD', 0),
(1119, 8, 116, 2019, 'SV', 'SUV', 'FWD', 0),
(1120, 8, 116, 2020, 'SR', 'SUV', 'FWD', 0),
(1121, 8, 116, 2021, 'SV Special Edition', 'SUV', 'FWD', 0),
(1122, 8, 116, 2022, 'S Midnight', 'SUV', 'FWD', 0),
(1123, 8, 116, 2023, 'SR Premium', 'SUV', 'FWD', 0),
(1124, 8, 116, 2024, 'SV Play', 'SUV', 'FWD', 0),
(1125, 8, 116, 2025, 'SR Midnight', 'SUV', 'FWD', 0),
(1126, 8, 116, 2026, 'S Play', 'SUV', 'FWD', 0);

-- Armada (ModelId=117, MakeId=8): 2017-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1127, 8, 117, 2017, 'SV', 'SUV', '4WD', 8500),
(1128, 8, 117, 2018, 'SL', 'SUV', 'RWD', 8500),
(1129, 8, 117, 2019, 'Platinum', 'SUV', '4WD', 8500),
(1130, 8, 117, 2020, 'Midnight Edition', 'SUV', 'RWD', 8500),
(1131, 8, 117, 2021, 'PRO-4X', 'SUV', '4WD', 8500),
(1132, 8, 117, 2022, 'SL Premium', 'SUV', 'RWD', 8500),
(1133, 8, 117, 2023, 'Platinum Reserve', 'SUV', '4WD', 8500),
(1134, 8, 117, 2024, 'SV Convenience', 'SUV', 'RWD', 8500),
(1135, 8, 117, 2025, 'SL Convenience', 'SUV', '4WD', 8500),
(1136, 8, 117, 2026, 'PRO-4X Premium', 'SUV', 'RWD', 8500);

-- Impreza (ModelId=118, MakeId=10): 2015-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1137, 10, 118, 2015, 'Base', 'Hatchback', 'AWD', 0),
(1138, 10, 118, 2016, 'Premium', 'Hatchback', 'AWD', 0),
(1139, 10, 118, 2017, 'Sport', 'Hatchback', 'AWD', 0),
(1140, 10, 118, 2018, 'Limited', 'Hatchback', 'AWD', 0),
(1141, 10, 118, 2019, 'RS', 'Hatchback', 'AWD', 0),
(1142, 10, 118, 2020, 'Base AWD', 'Hatchback', 'AWD', 0),
(1143, 10, 118, 2021, 'Premium Plus', 'Hatchback', 'AWD', 0),
(1144, 10, 118, 2022, 'Sport Tech', 'Hatchback', 'AWD', 0),
(1145, 10, 118, 2023, 'Limited Tech', 'Hatchback', 'AWD', 0),
(1146, 10, 118, 2024, 'RS Sport', 'Hatchback', 'AWD', 0),
(1147, 10, 118, 2025, 'Base Tech', 'Hatchback', 'AWD', 0),
(1148, 10, 118, 2026, 'Premium Tech', 'Hatchback', 'AWD', 0);

-- WRX (ModelId=119, MakeId=10): 2015-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1149, 10, 119, 2015, 'Base', 'Sedan', 'AWD', 0),
(1150, 10, 119, 2016, 'Premium', 'Sedan', 'AWD', 0),
(1151, 10, 119, 2017, 'Limited', 'Sedan', 'AWD', 0),
(1152, 10, 119, 2018, 'GT', 'Sedan', 'AWD', 0),
(1153, 10, 119, 2019, 'tS', 'Sedan', 'AWD', 0),
(1154, 10, 119, 2020, 'STI', 'Sedan', 'AWD', 0),
(1155, 10, 119, 2021, 'Base MT', 'Sedan', 'AWD', 0),
(1156, 10, 119, 2022, 'Premium MT', 'Sedan', 'AWD', 0),
(1157, 10, 119, 2023, 'Limited CVT', 'Sedan', 'AWD', 0),
(1158, 10, 119, 2024, 'GT CVT', 'Sedan', 'AWD', 0),
(1159, 10, 119, 2025, 'STI Sport', 'Sedan', 'AWD', 0),
(1160, 10, 119, 2026, 'STI Limited', 'Sedan', 'AWD', 0);

-- Legacy (ModelId=120, MakeId=10): 2015-2024
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1161, 10, 120, 2015, 'Base', 'Sedan', 'AWD', 0),
(1162, 10, 120, 2016, 'Premium', 'Sedan', 'AWD', 0),
(1163, 10, 120, 2017, 'Sport', 'Sedan', 'AWD', 0),
(1164, 10, 120, 2018, 'Limited', 'Sedan', 'AWD', 0),
(1165, 10, 120, 2019, 'Touring XT', 'Sedan', 'AWD', 0),
(1166, 10, 120, 2020, 'Base AWD', 'Sedan', 'AWD', 0),
(1167, 10, 120, 2021, 'Premium Plus', 'Sedan', 'AWD', 0),
(1168, 10, 120, 2022, 'Sport XT', 'Sedan', 'AWD', 0),
(1169, 10, 120, 2023, 'Limited XT', 'Sedan', 'AWD', 0),
(1170, 10, 120, 2024, 'Touring', 'Sedan', 'AWD', 0);

-- Solterra (ModelId=121, MakeId=10): 2023-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1171, 10, 121, 2023, 'Premium', 'SUV', 'AWD', 0),
(1172, 10, 121, 2024, 'Limited', 'SUV', 'AWD', 0),
(1173, 10, 121, 2025, 'Touring', 'SUV', 'AWD', 0),
(1174, 10, 121, 2026, 'Premium AWD', 'SUV', 'AWD', 0);

-- Model 3 (ModelId=122, MakeId=14): 2018-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1175, 14, 122, 2018, 'Standard Range', 'Sedan', 'RWD', 0),
(1176, 14, 122, 2019, 'Standard Range Plus', 'Sedan', 'AWD', 0),
(1177, 14, 122, 2020, 'Long Range', 'Sedan', 'RWD', 0),
(1178, 14, 122, 2021, 'Performance', 'Sedan', 'AWD', 0),
(1179, 14, 122, 2022, 'Long Range AWD', 'Sedan', 'RWD', 0),
(1180, 14, 122, 2023, 'Standard Range RWD', 'Sedan', 'AWD', 0),
(1181, 14, 122, 2024, 'Long Range Dual Motor', 'Sedan', 'RWD', 0),
(1182, 14, 122, 2025, 'Performance AWD', 'Sedan', 'AWD', 0),
(1183, 14, 122, 2026, 'Highland', 'Sedan', 'RWD', 0);

-- Model X (ModelId=123, MakeId=14): 2016-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1184, 14, 123, 2016, '75D', 'SUV', 'AWD', 5000),
(1185, 14, 123, 2017, '90D', 'SUV', 'AWD', 5000),
(1186, 14, 123, 2018, '100D', 'SUV', 'AWD', 5000),
(1187, 14, 123, 2019, 'Long Range', 'SUV', 'AWD', 5000),
(1188, 14, 123, 2020, 'Plaid', 'SUV', 'AWD', 5000),
(1189, 14, 123, 2021, 'Long Range Plus', 'SUV', 'AWD', 5000),
(1190, 14, 123, 2022, 'Standard Range', 'SUV', 'AWD', 5000),
(1191, 14, 123, 2023, '75D AWD', 'SUV', 'AWD', 5000),
(1192, 14, 123, 2024, '90D AWD', 'SUV', 'AWD', 5000),
(1193, 14, 123, 2025, '100D AWD', 'SUV', 'AWD', 5000),
(1194, 14, 123, 2026, 'Plaid AWD', 'SUV', 'AWD', 5000);

-- Model S (ModelId=124, MakeId=14): 2015-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1195, 14, 124, 2015, '70D', 'Sedan', 'AWD', 0),
(1196, 14, 124, 2016, '85D', 'Sedan', 'RWD', 0),
(1197, 14, 124, 2017, '90D', 'Sedan', 'AWD', 0),
(1198, 14, 124, 2018, '100D', 'Sedan', 'RWD', 0),
(1199, 14, 124, 2019, 'Long Range', 'Sedan', 'AWD', 0),
(1200, 14, 124, 2020, 'Plaid', 'Sedan', 'RWD', 0),
(1201, 14, 124, 2021, 'Long Range Plus', 'Sedan', 'AWD', 0),
(1202, 14, 124, 2022, '70', 'Sedan', 'RWD', 0),
(1203, 14, 124, 2023, '85', 'Sedan', 'AWD', 0),
(1204, 14, 124, 2024, 'P85D', 'Sedan', 'RWD', 0),
(1205, 14, 124, 2025, 'P100D', 'Sedan', 'AWD', 0),
(1206, 14, 124, 2026, 'Plaid+', 'Sedan', 'RWD', 0);

-- Sequoia (ModelId=125, MakeId=3): 2015-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1207, 3, 125, 2015, 'SR5', 'SUV', '4WD', 7000),
(1208, 3, 125, 2016, 'Limited', 'SUV', 'RWD', 7200),
(1209, 3, 125, 2017, 'Platinum', 'SUV', '4WD', 7500),
(1210, 3, 125, 2018, 'TRD Pro', 'SUV', 'RWD', 7700),
(1211, 3, 125, 2019, 'Capstone', 'SUV', '4WD', 7900),
(1212, 3, 125, 2020, 'TRD Sport', 'SUV', 'RWD', 8100),
(1213, 3, 125, 2021, 'SR5 Premium', 'SUV', '4WD', 8400),
(1214, 3, 125, 2022, 'Limited Premium', 'SUV', 'RWD', 8600),
(1215, 3, 125, 2023, 'Platinum Nightshade', 'SUV', '4WD', 8800),
(1216, 3, 125, 2024, 'TRD Pro Premium', 'SUV', 'RWD', 9100),
(1217, 3, 125, 2025, 'SR5 4WD', 'SUV', '4WD', 9300),
(1218, 3, 125, 2026, 'Capstone 4WD', 'SUV', 'RWD', 9500);

-- Prius (ModelId=126, MakeId=3): 2015-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1219, 3, 126, 2015, 'L Eco', 'Hatchback', 'FWD', 0),
(1220, 3, 126, 2016, 'LE', 'Hatchback', 'AWD', 0),
(1221, 3, 126, 2017, 'XLE', 'Hatchback', 'FWD', 0),
(1222, 3, 126, 2018, 'Limited', 'Hatchback', 'AWD', 0),
(1223, 3, 126, 2019, 'XLE Premium', 'Hatchback', 'FWD', 0),
(1224, 3, 126, 2020, 'SE', 'Hatchback', 'AWD', 0),
(1225, 3, 126, 2021, 'LE AWD-e', 'Hatchback', 'FWD', 0),
(1226, 3, 126, 2022, 'XLE AWD-e', 'Hatchback', 'AWD', 0),
(1227, 3, 126, 2023, 'Limited AWD-e', 'Hatchback', 'FWD', 0),
(1228, 3, 126, 2024, 'Prime SE', 'Hatchback', 'AWD', 0),
(1229, 3, 126, 2025, 'Prime XSE', 'Hatchback', 'FWD', 0),
(1230, 3, 126, 2026, 'Prime Limited', 'Hatchback', 'AWD', 0);

-- Venza (ModelId=127, MakeId=3): 2021-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1231, 3, 127, 2021, 'LE', 'SUV', 'AWD', 0),
(1232, 3, 127, 2022, 'XLE', 'SUV', 'AWD', 0),
(1233, 3, 127, 2023, 'Limited', 'SUV', 'AWD', 0),
(1234, 3, 127, 2024, 'Nightshade', 'SUV', 'AWD', 0),
(1235, 3, 127, 2025, 'SE', 'SUV', 'AWD', 0),
(1236, 3, 127, 2026, 'XLE Premium', 'SUV', 'AWD', 0);

-- GR86 (ModelId=128, MakeId=3): 2022-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1237, 3, 128, 2022, 'Base', 'Coupe', 'RWD', 0),
(1238, 3, 128, 2023, 'Premium', 'Coupe', 'RWD', 0),
(1239, 3, 128, 2024, 'Special Edition', 'Coupe', 'RWD', 0),
(1240, 3, 128, 2025, 'Trueno Edition', 'Coupe', 'RWD', 0),
(1241, 3, 128, 2026, 'Base MT', 'Coupe', 'RWD', 0);

-- Land Cruiser (ModelId=129, MakeId=3): 2015-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1242, 3, 129, 2015, 'Base', 'SUV', '4WD', 6000),
(1243, 3, 129, 2016, 'Heritage Edition', 'SUV', '4WD', 6200),
(1244, 3, 129, 2017, '1958', 'SUV', '4WD', 6400),
(1245, 3, 129, 2018, 'First Edition', 'SUV', '4WD', 6600),
(1246, 3, 129, 2019, 'Base 4WD', 'SUV', '4WD', 6800),
(1247, 3, 129, 2020, 'Heritage 4WD', 'SUV', '4WD', 7000),
(1248, 3, 129, 2021, 'Land Cruiser 250', 'SUV', '4WD', 7100),
(1249, 3, 129, 2022, 'Land Cruiser 300', 'SUV', '4WD', 7300),
(1250, 3, 129, 2023, 'Premium', 'SUV', '4WD', 7500),
(1251, 3, 129, 2024, 'Overtrail', 'SUV', '4WD', 7700),
(1252, 3, 129, 2025, 'Standard', 'SUV', '4WD', 7900),
(1253, 3, 129, 2026, 'Premium Plus', 'SUV', '4WD', 8100);

-- Jetta (ModelId=130, MakeId=13): 2015-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1254, 13, 130, 2015, 'S', 'Sedan', 'FWD', 0),
(1255, 13, 130, 2016, 'SE', 'Sedan', 'FWD', 0),
(1256, 13, 130, 2017, 'SEL', 'Sedan', 'FWD', 0),
(1257, 13, 130, 2018, 'SEL Premium', 'Sedan', 'FWD', 0),
(1258, 13, 130, 2019, 'GLI', 'Sedan', 'FWD', 0),
(1259, 13, 130, 2020, 'Sport', 'Sedan', 'FWD', 0),
(1260, 13, 130, 2021, 'R-Line', 'Sedan', 'FWD', 0),
(1261, 13, 130, 2022, 'S Manual', 'Sedan', 'FWD', 0),
(1262, 13, 130, 2023, 'SE Auto', 'Sedan', 'FWD', 0),
(1263, 13, 130, 2024, 'GLI Autobahn', 'Sedan', 'FWD', 0),
(1264, 13, 130, 2025, 'GLI S', 'Sedan', 'FWD', 0),
(1265, 13, 130, 2026, 'Sport Manual', 'Sedan', 'FWD', 0);

-- Golf (ModelId=131, MakeId=13): 2015-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1266, 13, 131, 2015, 'S', 'Hatchback', 'FWD', 0),
(1267, 13, 131, 2016, 'SE', 'Hatchback', 'AWD', 0),
(1268, 13, 131, 2017, 'TSI', 'Hatchback', 'FWD', 0),
(1269, 13, 131, 2018, 'GTI', 'Hatchback', 'AWD', 0),
(1270, 13, 131, 2019, 'R', 'Hatchback', 'FWD', 0),
(1271, 13, 131, 2020, 'GTI SE', 'Hatchback', 'AWD', 0),
(1272, 13, 131, 2021, 'GTI Autobahn', 'Hatchback', 'FWD', 0),
(1273, 13, 131, 2022, 'R-Line', 'Hatchback', 'AWD', 0),
(1274, 13, 131, 2023, 'GTI S', 'Hatchback', 'FWD', 0),
(1275, 13, 131, 2024, 'R Performance', 'Hatchback', 'AWD', 0),
(1276, 13, 131, 2025, 'TSI SE', 'Hatchback', 'FWD', 0),
(1277, 13, 131, 2026, 'GTI Performance', 'Hatchback', 'AWD', 0);

-- ID.4 (ModelId=132, MakeId=13): 2021-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1278, 13, 132, 2021, 'Standard', 'SUV', 'RWD', 0),
(1279, 13, 132, 2022, 'Pro', 'SUV', 'AWD', 0),
(1280, 13, 132, 2023, 'Pro S', 'SUV', 'RWD', 0),
(1281, 13, 132, 2024, 'Pro S Plus', 'SUV', 'AWD', 0),
(1282, 13, 132, 2025, 'S', 'SUV', 'RWD', 0),
(1283, 13, 132, 2026, 'S Plus', 'SUV', 'AWD', 0);

-- Taos (ModelId=133, MakeId=13): 2022-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1284, 13, 133, 2022, 'S', 'SUV', 'FWD', 0),
(1285, 13, 133, 2023, 'SE', 'SUV', 'AWD', 0),
(1286, 13, 133, 2024, 'SEL', 'SUV', 'FWD', 0),
(1287, 13, 133, 2025, 'SE R-Line', 'SUV', 'AWD', 0),
(1288, 13, 133, 2026, 'S 4MOTION', 'SUV', 'FWD', 0);

-- 3 Series (ModelId=134, MakeId=11): 2015-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1289, 11, 134, 2015, '330i', 'Sedan', 'RWD', 0),
(1290, 11, 134, 2016, '330i xDrive', 'Sedan', 'AWD', 0),
(1291, 11, 134, 2017, '330e', 'Sedan', 'RWD', 0),
(1292, 11, 134, 2018, 'M340i', 'Sedan', 'AWD', 0),
(1293, 11, 134, 2019, 'M340i xDrive', 'Sedan', 'RWD', 0),
(1294, 11, 134, 2020, 'M3', 'Sedan', 'AWD', 0),
(1295, 11, 134, 2021, '320i', 'Sedan', 'RWD', 0),
(1296, 11, 134, 2022, '328i', 'Sedan', 'AWD', 0),
(1297, 11, 134, 2023, '330i M Sport', 'Sedan', 'RWD', 0),
(1298, 11, 134, 2024, 'M340i M Sport', 'Sedan', 'AWD', 0),
(1299, 11, 134, 2025, 'M3 Competition', 'Sedan', 'RWD', 0),
(1300, 11, 134, 2026, '328d', 'Sedan', 'AWD', 0);

-- 5 Series (ModelId=135, MakeId=11): 2017-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1301, 11, 135, 2017, '530i', 'Sedan', 'RWD', 0),
(1302, 11, 135, 2018, '530i xDrive', 'Sedan', 'AWD', 0),
(1303, 11, 135, 2019, '540i', 'Sedan', 'RWD', 0),
(1304, 11, 135, 2020, '540i xDrive', 'Sedan', 'AWD', 0),
(1305, 11, 135, 2021, 'M550i', 'Sedan', 'RWD', 0),
(1306, 11, 135, 2022, 'i5 eDrive40', 'Sedan', 'AWD', 0),
(1307, 11, 135, 2023, 'M5', 'Sedan', 'RWD', 0),
(1308, 11, 135, 2024, '530e', 'Sedan', 'AWD', 0),
(1309, 11, 135, 2025, '530e xDrive', 'Sedan', 'RWD', 0),
(1310, 11, 135, 2026, 'M550i xDrive', 'Sedan', 'AWD', 0);

-- X1 (ModelId=136, MakeId=11): 2016-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1311, 11, 136, 2016, 'sDrive28i', 'SUV', 'FWD', 0),
(1312, 11, 136, 2017, 'xDrive28i', 'SUV', 'AWD', 0),
(1313, 11, 136, 2018, 'xDrive23i', 'SUV', 'FWD', 0),
(1314, 11, 136, 2019, 'xDrive28i M Sport', 'SUV', 'AWD', 0),
(1315, 11, 136, 2020, 'M35i', 'SUV', 'FWD', 0),
(1316, 11, 136, 2021, 'sDrive18i', 'SUV', 'AWD', 0),
(1317, 11, 136, 2022, 'xDrive20i', 'SUV', 'FWD', 0),
(1318, 11, 136, 2023, 'xDrive25i', 'SUV', 'AWD', 0),
(1319, 11, 136, 2024, 'xDrive28i xLine', 'SUV', 'FWD', 0),
(1320, 11, 136, 2025, 'M35i xDrive', 'SUV', 'AWD', 0),
(1321, 11, 136, 2026, 'xDrive23i M Sport', 'SUV', 'FWD', 0);

-- X7 (ModelId=137, MakeId=11): 2019-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1322, 11, 137, 2019, 'xDrive40i', 'SUV', 'AWD', 7500),
(1323, 11, 137, 2020, 'xDrive50i', 'SUV', 'AWD', 7500),
(1324, 11, 137, 2021, 'M60i', 'SUV', 'AWD', 7500),
(1325, 11, 137, 2022, 'Alpina XB7', 'SUV', 'AWD', 7500),
(1326, 11, 137, 2023, 'xDrive40i M Sport', 'SUV', 'AWD', 7500),
(1327, 11, 137, 2024, 'xDrive50i M Sport', 'SUV', 'AWD', 7500),
(1328, 11, 137, 2025, 'M60i xDrive', 'SUV', 'AWD', 7500),
(1329, 11, 137, 2026, 'xDrive40d', 'SUV', 'AWD', 7500);

-- ProMaster (ModelId=64, MakeId=4): 2015-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1330, 4, 64, 2015, '1500', 'Van', 'FWD', 0),
(1331, 4, 64, 2016, '2500', 'Van', 'FWD', 0),
(1332, 4, 64, 2017, '3500', 'Van', 'FWD', 0),
(1333, 4, 64, 2018, '1500 Low Roof', 'Van', 'FWD', 0),
(1334, 4, 64, 2019, '2500 High Roof', 'Van', 'FWD', 0),
(1335, 4, 64, 2020, '3500 High Roof EXT', 'Van', 'FWD', 0),
(1336, 4, 64, 2021, '1500 Cargo', 'Van', 'FWD', 0),
(1337, 4, 64, 2022, '2500 Cargo', 'Van', 'FWD', 0),
(1338, 4, 64, 2023, '3500 Cargo', 'Van', 'FWD', 0),
(1339, 4, 64, 2024, '1500 Window', 'Van', 'FWD', 0),
(1340, 4, 64, 2025, '2500 Window', 'Van', 'FWD', 0),
(1341, 4, 64, 2026, '3500 Window', 'Van', 'FWD', 0);

-- Pacifica (ModelId=138, MakeId=19): 2017-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1342, 19, 138, 2017, 'Touring', 'Minivan', 'FWD', 3600),
(1343, 19, 138, 2018, 'Touring L', 'Minivan', 'AWD', 3600),
(1344, 19, 138, 2019, 'Limited', 'Minivan', 'FWD', 3600),
(1345, 19, 138, 2020, 'Pinnacle', 'Minivan', 'AWD', 3600),
(1346, 19, 138, 2021, 'Hybrid Touring L', 'Minivan', 'FWD', 3600),
(1347, 19, 138, 2022, 'Hybrid Limited', 'Minivan', 'AWD', 3600),
(1348, 19, 138, 2023, 'Touring S', 'Minivan', 'FWD', 3600),
(1349, 19, 138, 2024, 'Limited S', 'Minivan', 'AWD', 3600),
(1350, 19, 138, 2025, 'Hybrid Pinnacle', 'Minivan', 'FWD', 3600),
(1351, 19, 138, 2026, 'Hybrid Touring', 'Minivan', 'AWD', 3600);

-- 300 (ModelId=139, MakeId=19): 2015-2023
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1352, 19, 139, 2015, 'Touring', 'Sedan', 'RWD', 0),
(1353, 19, 139, 2016, 'Touring L', 'Sedan', 'AWD', 0),
(1354, 19, 139, 2017, 'S', 'Sedan', 'RWD', 0),
(1355, 19, 139, 2018, 'C', 'Sedan', 'AWD', 0),
(1356, 19, 139, 2019, 'Limited', 'Sedan', 'RWD', 0),
(1357, 19, 139, 2020, 'SRT8', 'Sedan', 'AWD', 0),
(1358, 19, 139, 2021, 'S V6', 'Sedan', 'RWD', 0),
(1359, 19, 139, 2022, 'C Platinum', 'Sedan', 'AWD', 0),
(1360, 19, 139, 2023, 'Touring AWD', 'Sedan', 'RWD', 0);

-- Aviator (ModelId=140, MakeId=20): 2020-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1361, 20, 140, 2020, 'Standard', 'SUV', 'RWD', 5600),
(1362, 20, 140, 2021, 'Reserve', 'SUV', 'AWD', 5600),
(1363, 20, 140, 2022, 'Black Label', 'SUV', 'RWD', 5600),
(1364, 20, 140, 2023, 'Grand Touring', 'SUV', 'AWD', 5600),
(1365, 20, 140, 2024, 'Shinola', 'SUV', 'RWD', 5600),
(1366, 20, 140, 2025, 'Reserve AWD', 'SUV', 'AWD', 5600),
(1367, 20, 140, 2026, 'Black Label AWD', 'SUV', 'RWD', 5600);

-- Navigator (ModelId=141, MakeId=20): 2015-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1368, 20, 141, 2015, 'Standard', 'SUV', '4WD', 8300),
(1369, 20, 141, 2016, 'Reserve', 'SUV', 'RWD', 8300),
(1370, 20, 141, 2017, 'Black Label', 'SUV', '4WD', 8400),
(1371, 20, 141, 2018, 'L Standard', 'SUV', 'RWD', 8400),
(1372, 20, 141, 2019, 'L Reserve', 'SUV', '4WD', 8400),
(1373, 20, 141, 2020, 'L Black Label', 'SUV', 'RWD', 8500),
(1374, 20, 141, 2021, 'Select', 'SUV', '4WD', 8500),
(1375, 20, 141, 2022, 'Select L', 'SUV', 'RWD', 8600),
(1376, 20, 141, 2023, 'Reserve L', 'SUV', '4WD', 8600),
(1377, 20, 141, 2024, 'Black Label L', 'SUV', 'RWD', 8600),
(1378, 20, 141, 2025, 'Premiere', 'SUV', '4WD', 8700),
(1379, 20, 141, 2026, 'Premiere L', 'SUV', 'RWD', 8700);

-- Corsair (ModelId=142, MakeId=20): 2020-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1380, 20, 142, 2020, 'Standard', 'SUV', 'FWD', 2000),
(1381, 20, 142, 2021, 'Reserve', 'SUV', 'AWD', 2200),
(1382, 20, 142, 2022, 'Grand Touring', 'SUV', 'FWD', 2300),
(1383, 20, 142, 2023, 'Black Label', 'SUV', 'AWD', 2500),
(1384, 20, 142, 2024, 'Standard AWD', 'SUV', 'FWD', 2700),
(1385, 20, 142, 2025, 'Reserve AWD', 'SUV', 'AWD', 2800),
(1386, 20, 142, 2026, 'Grand Touring AWD', 'SUV', 'FWD', 3000);

-- MDX (ModelId=143, MakeId=21): 2015-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1387, 21, 143, 2015, 'Base', 'SUV', 'FWD', 3500),
(1388, 21, 143, 2016, 'Technology', 'SUV', 'AWD', 3600),
(1389, 21, 143, 2017, 'A-Spec', 'SUV', 'FWD', 3800),
(1390, 21, 143, 2018, 'Advance', 'SUV', 'AWD', 3900),
(1391, 21, 143, 2019, 'Type S', 'SUV', 'FWD', 4000),
(1392, 21, 143, 2020, 'Type S Advance', 'SUV', 'AWD', 4200),
(1393, 21, 143, 2021, 'SH-AWD', 'SUV', 'FWD', 4300),
(1394, 21, 143, 2022, 'Technology SH-AWD', 'SUV', 'AWD', 4500),
(1395, 21, 143, 2023, 'A-Spec SH-AWD', 'SUV', 'FWD', 4600),
(1396, 21, 143, 2024, 'Advance SH-AWD', 'SUV', 'AWD', 4700),
(1397, 21, 143, 2025, 'Type S SH-AWD', 'SUV', 'FWD', 4900),
(1398, 21, 143, 2026, 'Entertainment', 'SUV', 'AWD', 5000);

-- RDX (ModelId=144, MakeId=21): 2015-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1399, 21, 144, 2015, 'Base', 'SUV', 'FWD', 1500),
(1400, 21, 144, 2016, 'Technology', 'SUV', 'AWD', 1500),
(1401, 21, 144, 2017, 'A-Spec', 'SUV', 'FWD', 1500),
(1402, 21, 144, 2018, 'Advance', 'SUV', 'AWD', 1500),
(1403, 21, 144, 2019, 'PMC Edition', 'SUV', 'FWD', 1500),
(1404, 21, 144, 2020, 'SH-AWD', 'SUV', 'AWD', 1500),
(1405, 21, 144, 2021, 'Technology SH-AWD', 'SUV', 'FWD', 1500),
(1406, 21, 144, 2022, 'A-Spec SH-AWD', 'SUV', 'AWD', 1500),
(1407, 21, 144, 2023, 'Advance SH-AWD', 'SUV', 'FWD', 1500),
(1408, 21, 144, 2024, 'PMC SH-AWD', 'SUV', 'AWD', 1500),
(1409, 21, 144, 2025, 'Base FWD', 'SUV', 'FWD', 1500),
(1410, 21, 144, 2026, 'A-Spec Advance', 'SUV', 'AWD', 1500);

-- TLX (ModelId=145, MakeId=21): 2015-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1411, 21, 145, 2015, 'Base', 'Sedan', 'FWD', 0),
(1412, 21, 145, 2016, 'Technology', 'Sedan', 'AWD', 0),
(1413, 21, 145, 2017, 'A-Spec', 'Sedan', 'FWD', 0),
(1414, 21, 145, 2018, 'Advance', 'Sedan', 'AWD', 0),
(1415, 21, 145, 2019, 'Type S', 'Sedan', 'FWD', 0),
(1416, 21, 145, 2020, 'Type S PMC', 'Sedan', 'AWD', 0),
(1417, 21, 145, 2021, 'SH-AWD', 'Sedan', 'FWD', 0),
(1418, 21, 145, 2022, 'Technology SH-AWD', 'Sedan', 'AWD', 0),
(1419, 21, 145, 2023, 'A-Spec SH-AWD', 'Sedan', 'FWD', 0),
(1420, 21, 145, 2024, 'Advance SH-AWD', 'Sedan', 'AWD', 0),
(1421, 21, 145, 2025, 'Type S SH-AWD', 'Sedan', 'FWD', 0),
(1422, 21, 145, 2026, 'V6 SH-AWD', 'Sedan', 'AWD', 0);

-- Integra (ModelId=146, MakeId=21): 2023-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1423, 21, 146, 2023, 'Base', 'Hatchback', 'FWD', 0),
(1424, 21, 146, 2024, 'A-Spec', 'Hatchback', 'FWD', 0),
(1425, 21, 146, 2025, 'A-Spec Tech', 'Hatchback', 'FWD', 0),
(1426, 21, 146, 2026, 'Type S', 'Hatchback', 'FWD', 0);

-- QX60 (ModelId=147, MakeId=22): 2015-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1427, 22, 147, 2015, 'Pure', 'SUV', 'FWD', 6000),
(1428, 22, 147, 2016, 'Luxe', 'SUV', 'AWD', 6000),
(1429, 22, 147, 2017, 'Sensory', 'SUV', 'FWD', 6000),
(1430, 22, 147, 2018, 'Autograph', 'SUV', 'AWD', 6000),
(1431, 22, 147, 2019, 'Base', 'SUV', 'FWD', 6000),
(1432, 22, 147, 2020, 'Premium', 'SUV', 'AWD', 6000),
(1433, 22, 147, 2021, 'Premium Plus', 'SUV', 'FWD', 6000),
(1434, 22, 147, 2022, 'Luxe AWD', 'SUV', 'AWD', 6000),
(1435, 22, 147, 2023, 'Sensory AWD', 'SUV', 'FWD', 6000),
(1436, 22, 147, 2024, 'Autograph AWD', 'SUV', 'AWD', 6000),
(1437, 22, 147, 2025, 'Pure FWD', 'SUV', 'FWD', 6000),
(1438, 22, 147, 2026, 'Luxe FWD', 'SUV', 'AWD', 6000);

-- QX80 (ModelId=148, MakeId=22): 2015-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1439, 22, 148, 2015, 'Base', 'SUV', '4WD', 8500),
(1440, 22, 148, 2016, 'Luxe', 'SUV', 'RWD', 8500),
(1441, 22, 148, 2017, 'Sensory', 'SUV', '4WD', 8500),
(1442, 22, 148, 2018, 'Autograph', 'SUV', 'RWD', 8500),
(1443, 22, 148, 2019, 'Premium Select', 'SUV', '4WD', 8500),
(1444, 22, 148, 2020, 'ProActive', 'SUV', 'RWD', 8500),
(1445, 22, 148, 2021, 'Luxe 4WD', 'SUV', '4WD', 8500),
(1446, 22, 148, 2022, 'Sensory 4WD', 'SUV', 'RWD', 8500),
(1447, 22, 148, 2023, 'Autograph 4WD', 'SUV', '4WD', 8500),
(1448, 22, 148, 2024, 'Premium Select 4WD', 'SUV', 'RWD', 8500),
(1449, 22, 148, 2025, 'Limited', 'SUV', '4WD', 8500),
(1450, 22, 148, 2026, 'Base 4WD', 'SUV', 'RWD', 8500);

-- Q50 (ModelId=149, MakeId=22): 2015-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1451, 22, 149, 2015, 'Pure', 'Sedan', 'RWD', 0),
(1452, 22, 149, 2016, 'Luxe', 'Sedan', 'AWD', 0),
(1453, 22, 149, 2017, 'Sensory', 'Sedan', 'RWD', 0),
(1454, 22, 149, 2018, 'Red Sport 400', 'Sedan', 'AWD', 0),
(1455, 22, 149, 2019, 'Sport', 'Sedan', 'RWD', 0),
(1456, 22, 149, 2020, 'Pure AWD', 'Sedan', 'AWD', 0),
(1457, 22, 149, 2021, 'Luxe AWD', 'Sedan', 'RWD', 0),
(1458, 22, 149, 2022, 'Red Sport 400 AWD', 'Sedan', 'AWD', 0),
(1459, 22, 149, 2023, '3.0t Luxe', 'Sedan', 'RWD', 0),
(1460, 22, 149, 2024, '3.0t Sport', 'Sedan', 'AWD', 0),
(1461, 22, 149, 2025, '3.0t Red Sport', 'Sedan', 'RWD', 0),
(1462, 22, 149, 2026, 'Base', 'Sedan', 'AWD', 0);

-- XC90 (ModelId=150, MakeId=23): 2016-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1463, 23, 150, 2016, 'Momentum', 'SUV', 'AWD', 5000),
(1464, 23, 150, 2017, 'R-Design', 'SUV', 'FWD', 5000),
(1465, 23, 150, 2018, 'Inscription', 'SUV', 'AWD', 5000),
(1466, 23, 150, 2019, 'Ultimate', 'SUV', 'FWD', 5000),
(1467, 23, 150, 2020, 'Recharge', 'SUV', 'AWD', 5000),
(1468, 23, 150, 2021, 'B5', 'SUV', 'FWD', 5000),
(1469, 23, 150, 2022, 'B5 Plus', 'SUV', 'AWD', 5000),
(1470, 23, 150, 2023, 'T5 Momentum', 'SUV', 'FWD', 5000),
(1471, 23, 150, 2024, 'T6 R-Design', 'SUV', 'AWD', 5000),
(1472, 23, 150, 2025, 'T6 Inscription', 'SUV', 'FWD', 5000),
(1473, 23, 150, 2026, 'B6 Ultimate', 'SUV', 'AWD', 5000);

-- XC60 (ModelId=151, MakeId=23): 2018-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1474, 23, 151, 2018, 'Momentum', 'SUV', 'AWD', 3500),
(1475, 23, 151, 2019, 'R-Design', 'SUV', 'FWD', 3500),
(1476, 23, 151, 2020, 'Inscription', 'SUV', 'AWD', 3500),
(1477, 23, 151, 2021, 'Ultimate', 'SUV', 'FWD', 3500),
(1478, 23, 151, 2022, 'Recharge', 'SUV', 'AWD', 3500),
(1479, 23, 151, 2023, 'B5', 'SUV', 'FWD', 3500),
(1480, 23, 151, 2024, 'B5 Plus', 'SUV', 'AWD', 3500),
(1481, 23, 151, 2025, 'T5 Momentum', 'SUV', 'FWD', 3500),
(1482, 23, 151, 2026, 'T6 R-Design', 'SUV', 'AWD', 3500);

-- XC40 (ModelId=152, MakeId=23): 2019-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1483, 23, 152, 2019, 'Momentum', 'SUV', 'AWD', 0),
(1484, 23, 152, 2020, 'R-Design', 'SUV', 'FWD', 0),
(1485, 23, 152, 2021, 'Inscription', 'SUV', 'AWD', 0),
(1486, 23, 152, 2022, 'Ultimate', 'SUV', 'FWD', 0),
(1487, 23, 152, 2023, 'Recharge', 'SUV', 'AWD', 0),
(1488, 23, 152, 2024, 'T4 Momentum', 'SUV', 'FWD', 0),
(1489, 23, 152, 2025, 'T5 R-Design', 'SUV', 'AWD', 0),
(1490, 23, 152, 2026, 'B4 Ultimate', 'SUV', 'FWD', 0);

-- S60 (ModelId=153, MakeId=23): 2019-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1491, 23, 153, 2019, 'Momentum', 'Sedan', 'AWD', 0),
(1492, 23, 153, 2020, 'R-Design', 'Sedan', 'FWD', 0),
(1493, 23, 153, 2021, 'Inscription', 'Sedan', 'AWD', 0),
(1494, 23, 153, 2022, 'Recharge', 'Sedan', 'FWD', 0),
(1495, 23, 153, 2023, 'Polestar Engineered', 'Sedan', 'AWD', 0),
(1496, 23, 153, 2024, 'B5', 'Sedan', 'FWD', 0),
(1497, 23, 153, 2025, 'T5 Momentum', 'Sedan', 'AWD', 0),
(1498, 23, 153, 2026, 'T6 R-Design', 'Sedan', 'FWD', 0);

-- Enclave (ModelId=154, MakeId=24): 2018-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1499, 24, 154, 2018, 'Preferred', 'SUV', 'FWD', 1500),
(1500, 24, 154, 2019, 'Essence', 'SUV', 'AWD', 1900),
(1501, 24, 154, 2020, 'Premium', 'SUV', 'FWD', 2400),
(1502, 24, 154, 2021, 'Avenir', 'SUV', 'AWD', 2800),
(1503, 24, 154, 2022, 'Sport Touring', 'SUV', 'FWD', 3300),
(1504, 24, 154, 2023, 'Preferred FWD', 'SUV', 'AWD', 3700),
(1505, 24, 154, 2024, 'Essence AWD', 'SUV', 'FWD', 4100),
(1506, 24, 154, 2025, 'Premium AWD', 'SUV', 'AWD', 4600),
(1507, 24, 154, 2026, 'Avenir AWD', 'SUV', 'FWD', 5000);

-- Encore GX (ModelId=155, MakeId=24): 2020-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1508, 24, 155, 2020, 'Preferred', 'SUV', 'FWD', 0),
(1509, 24, 155, 2021, 'Select', 'SUV', 'AWD', 0),
(1510, 24, 155, 2022, 'Essence', 'SUV', 'FWD', 0),
(1511, 24, 155, 2023, 'Avenir', 'SUV', 'AWD', 0),
(1512, 24, 155, 2024, 'Sport Touring', 'SUV', 'FWD', 0),
(1513, 24, 155, 2025, 'Preferred FWD', 'SUV', 'AWD', 0),
(1514, 24, 155, 2026, 'Select AWD', 'SUV', 'FWD', 0);

-- Envista (ModelId=156, MakeId=24): 2024-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1515, 24, 156, 2024, 'Preferred', 'SUV', 'FWD', 0),
(1516, 24, 156, 2025, 'Sport Touring', 'SUV', 'FWD', 0),
(1517, 24, 156, 2026, 'Avenir', 'SUV', 'FWD', 0);

-- Escalade (ModelId=157, MakeId=25): 2015-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1518, 25, 157, 2015, 'Luxury', 'SUV', '4WD', 7600),
(1519, 25, 157, 2016, 'Premium Luxury', 'SUV', 'RWD', 7700),
(1520, 25, 157, 2017, 'Sport', 'SUV', '4WD', 7700),
(1521, 25, 157, 2018, 'Premium', 'SUV', 'RWD', 7800),
(1522, 25, 157, 2019, 'V-Series', 'SUV', '4WD', 7800),
(1523, 25, 157, 2020, 'ESV Luxury', 'SUV', 'RWD', 7900),
(1524, 25, 157, 2021, 'ESV Premium Luxury', 'SUV', '4WD', 7900),
(1525, 25, 157, 2022, 'ESV Sport', 'SUV', 'RWD', 8000),
(1526, 25, 157, 2023, 'Luxury 4WD', 'SUV', '4WD', 8000),
(1527, 25, 157, 2024, 'Premium Luxury 4WD', 'SUV', 'RWD', 8100),
(1528, 25, 157, 2025, 'Sport 4WD', 'SUV', '4WD', 8100),
(1529, 25, 157, 2026, 'ESV V-Series', 'SUV', 'RWD', 8200);

-- XT5 (ModelId=158, MakeId=25): 2017-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1530, 25, 158, 2017, 'Luxury', 'SUV', 'FWD', 3500),
(1531, 25, 158, 2018, 'Premium Luxury', 'SUV', 'AWD', 3500),
(1532, 25, 158, 2019, 'Sport', 'SUV', 'FWD', 3500),
(1533, 25, 158, 2020, 'Premium', 'SUV', 'AWD', 3500),
(1534, 25, 158, 2021, 'Luxury FWD', 'SUV', 'FWD', 3500),
(1535, 25, 158, 2022, 'Premium Luxury AWD', 'SUV', 'AWD', 3500),
(1536, 25, 158, 2023, 'Sport AWD', 'SUV', 'FWD', 3500),
(1537, 25, 158, 2024, 'Luxury AWD', 'SUV', 'AWD', 3500),
(1538, 25, 158, 2025, 'Premium FWD', 'SUV', 'FWD', 3500),
(1539, 25, 158, 2026, 'Premium Luxury FWD', 'SUV', 'AWD', 3500);

-- XT4 (ModelId=159, MakeId=25): 2019-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1540, 25, 159, 2019, 'Luxury', 'SUV', 'FWD', 0),
(1541, 25, 159, 2020, 'Premium Luxury', 'SUV', 'AWD', 0),
(1542, 25, 159, 2021, 'Sport', 'SUV', 'FWD', 0),
(1543, 25, 159, 2022, 'Luxury FWD', 'SUV', 'AWD', 0),
(1544, 25, 159, 2023, 'Premium Luxury AWD', 'SUV', 'FWD', 0),
(1545, 25, 159, 2024, 'Sport AWD', 'SUV', 'AWD', 0),
(1546, 25, 159, 2025, 'Luxury AWD', 'SUV', 'FWD', 0),
(1547, 25, 159, 2026, 'Premium Luxury FWD', 'SUV', 'AWD', 0);

-- CT5 (ModelId=160, MakeId=25): 2020-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1548, 25, 160, 2020, 'Luxury', 'Sedan', 'RWD', 0),
(1549, 25, 160, 2021, 'Premium Luxury', 'Sedan', 'AWD', 0),
(1550, 25, 160, 2022, 'Sport', 'Sedan', 'RWD', 0),
(1551, 25, 160, 2023, 'V', 'Sedan', 'AWD', 0),
(1552, 25, 160, 2024, 'V Blackwing', 'Sedan', 'RWD', 0),
(1553, 25, 160, 2025, 'Luxury RWD', 'Sedan', 'AWD', 0),
(1554, 25, 160, 2026, 'Premium Luxury AWD', 'Sedan', 'RWD', 0);

-- GV70 (ModelId=161, MakeId=26): 2022-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1555, 26, 161, 2022, 'Standard', 'SUV', 'RWD', 3500),
(1556, 26, 161, 2023, 'Advanced', 'SUV', 'AWD', 3500),
(1557, 26, 161, 2024, 'Prestige', 'SUV', 'RWD', 3500),
(1558, 26, 161, 2025, 'Sport Advanced', 'SUV', 'AWD', 3500),
(1559, 26, 161, 2026, 'Sport Prestige', 'SUV', 'RWD', 3500);

-- GV80 (ModelId=162, MakeId=26): 2021-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1560, 26, 162, 2021, 'Standard', 'SUV', 'RWD', 6000),
(1561, 26, 162, 2022, 'Advanced', 'SUV', 'AWD', 6000),
(1562, 26, 162, 2023, 'Prestige', 'SUV', 'RWD', 6000),
(1563, 26, 162, 2024, 'Sport Advanced', 'SUV', 'AWD', 6000),
(1564, 26, 162, 2025, 'Sport Prestige', 'SUV', 'RWD', 6000),
(1565, 26, 162, 2026, 'Calligraphy', 'SUV', 'AWD', 6000);

-- G70 (ModelId=163, MakeId=26): 2019-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1566, 26, 163, 2019, 'Standard', 'Sedan', 'RWD', 0),
(1567, 26, 163, 2020, 'Advanced', 'Sedan', 'AWD', 0),
(1568, 26, 163, 2021, 'Prestige', 'Sedan', 'RWD', 0),
(1569, 26, 163, 2022, 'Sport Advanced', 'Sedan', 'AWD', 0),
(1570, 26, 163, 2023, 'Sport Prestige', 'Sedan', 'RWD', 0),
(1571, 26, 163, 2024, 'Launch Edition', 'Sedan', 'AWD', 0),
(1572, 26, 163, 2025, 'Standard RWD', 'Sedan', 'RWD', 0),
(1573, 26, 163, 2026, 'Prestige AWD', 'Sedan', 'AWD', 0);

-- RX (ModelId=164, MakeId=27): 2016-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1574, 27, 164, 2016, 'RX 350', 'SUV', 'FWD', 3500),
(1575, 27, 164, 2017, 'RX 350 F Sport', 'SUV', 'AWD', 3500),
(1576, 27, 164, 2018, 'RX 350h', 'SUV', 'FWD', 3500),
(1577, 27, 164, 2019, 'RX 500h', 'SUV', 'AWD', 3500),
(1578, 27, 164, 2020, 'RX 350 Premium', 'SUV', 'FWD', 3500),
(1579, 27, 164, 2021, 'RX 450h', 'SUV', 'AWD', 3500),
(1580, 27, 164, 2022, 'RX 350 Luxury', 'SUV', 'FWD', 3500),
(1581, 27, 164, 2023, 'RX 350h AWD', 'SUV', 'AWD', 3500),
(1582, 27, 164, 2024, 'RX 500h F Sport Performance', 'SUV', 'FWD', 3500),
(1583, 27, 164, 2025, 'RX 450h F Sport', 'SUV', 'AWD', 3500),
(1584, 27, 164, 2026, 'RX 350 Executive', 'SUV', 'FWD', 3500);

-- NX (ModelId=165, MakeId=27): 2015-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1585, 27, 165, 2015, 'NX 250', 'SUV', 'FWD', 0),
(1586, 27, 165, 2016, 'NX 350', 'SUV', 'AWD', 0),
(1587, 27, 165, 2017, 'NX 350h', 'SUV', 'FWD', 0),
(1588, 27, 165, 2018, 'NX 450h+', 'SUV', 'AWD', 0),
(1589, 27, 165, 2019, 'NX 300', 'SUV', 'FWD', 0),
(1590, 27, 165, 2020, 'F Sport', 'SUV', 'AWD', 0),
(1591, 27, 165, 2021, 'NX 300 F Sport', 'SUV', 'FWD', 0),
(1592, 27, 165, 2022, 'NX 350 F Sport', 'SUV', 'AWD', 0),
(1593, 27, 165, 2023, 'NX 250 Luxury', 'SUV', 'FWD', 0),
(1594, 27, 165, 2024, 'NX 350h AWD', 'SUV', 'AWD', 0),
(1595, 27, 165, 2025, 'NX 450h+ Luxury', 'SUV', 'FWD', 0),
(1596, 27, 165, 2026, 'NX 200t', 'SUV', 'AWD', 0);

-- GX (ModelId=166, MakeId=27): 2015-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1597, 27, 166, 2015, 'Base', 'SUV', '4WD', 6500),
(1598, 27, 166, 2016, 'Premium', 'SUV', '4WD', 6600),
(1599, 27, 166, 2017, 'Luxury', 'SUV', '4WD', 6800),
(1600, 27, 166, 2018, 'Overtrail', 'SUV', '4WD', 6900),
(1601, 27, 166, 2019, 'Overtrail+', 'SUV', '4WD', 7000),
(1602, 27, 166, 2020, '550 Premium', 'SUV', '4WD', 7200),
(1603, 27, 166, 2021, '460 Base', 'SUV', '4WD', 7300),
(1604, 27, 166, 2022, '460 Premium', 'SUV', '4WD', 7500),
(1605, 27, 166, 2023, '460 Luxury', 'SUV', '4WD', 7600),
(1606, 27, 166, 2024, '550 Overtrail', 'SUV', '4WD', 7700),
(1607, 27, 166, 2025, '550 Overtrail+', 'SUV', '4WD', 7900),
(1608, 27, 166, 2026, '550 Luxury', 'SUV', '4WD', 8000);

-- IS (ModelId=167, MakeId=27): 2015-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1609, 27, 167, 2015, 'IS 300', 'Sedan', 'RWD', 0),
(1610, 27, 167, 2016, 'IS 350', 'Sedan', 'AWD', 0),
(1611, 27, 167, 2017, 'IS 350 F Sport', 'Sedan', 'RWD', 0),
(1612, 27, 167, 2018, 'IS 500', 'Sedan', 'AWD', 0),
(1613, 27, 167, 2019, 'IS 500 F Sport Performance', 'Sedan', 'RWD', 0),
(1614, 27, 167, 2020, 'IS 300 AWD', 'Sedan', 'AWD', 0),
(1615, 27, 167, 2021, 'IS 350 AWD', 'Sedan', 'RWD', 0),
(1616, 27, 167, 2022, 'IS 200t', 'Sedan', 'AWD', 0),
(1617, 27, 167, 2023, 'IS 300 F Sport', 'Sedan', 'RWD', 0),
(1618, 27, 167, 2024, 'IS 350 F Sport Design', 'Sedan', 'AWD', 0),
(1619, 27, 167, 2025, 'IS 500 Launch Edition', 'Sedan', 'RWD', 0),
(1620, 27, 167, 2026, 'IS 300 Premium', 'Sedan', 'AWD', 0);

-- TX (ModelId=168, MakeId=27): 2024-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1621, 27, 168, 2024, 'TX 350', 'SUV', 'FWD', 5000),
(1622, 27, 168, 2025, 'TX 500h', 'SUV', 'AWD', 5000),
(1623, 27, 168, 2026, 'TX 550h+', 'SUV', 'FWD', 5000);

-- Q5 (ModelId=169, MakeId=28): 2018-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1624, 28, 169, 2018, 'Premium', 'SUV', 'AWD', 4400),
(1625, 28, 169, 2019, 'Premium Plus', 'SUV', 'AWD', 4400),
(1626, 28, 169, 2020, 'Prestige', 'SUV', 'AWD', 4400),
(1627, 28, 169, 2021, 'S Line Premium', 'SUV', 'AWD', 4400),
(1628, 28, 169, 2022, 'Sportback Premium', 'SUV', 'AWD', 4400),
(1629, 28, 169, 2023, 'Premium 45', 'SUV', 'AWD', 4400),
(1630, 28, 169, 2024, 'Premium Plus 45', 'SUV', 'AWD', 4400),
(1631, 28, 169, 2025, 'Prestige 45', 'SUV', 'AWD', 4400),
(1632, 28, 169, 2026, 'S Line 45', 'SUV', 'AWD', 4400);

-- Q7 (ModelId=170, MakeId=28): 2017-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1633, 28, 170, 2017, 'Premium', 'SUV', 'AWD', 7700),
(1634, 28, 170, 2018, 'Premium Plus', 'SUV', 'AWD', 7700),
(1635, 28, 170, 2019, 'Prestige', 'SUV', 'AWD', 7700),
(1636, 28, 170, 2020, 'S Line Premium', 'SUV', 'AWD', 7700),
(1637, 28, 170, 2021, 'Komfort', 'SUV', 'AWD', 7700),
(1638, 28, 170, 2022, 'Premium 55', 'SUV', 'AWD', 7700),
(1639, 28, 170, 2023, 'Premium Plus 55', 'SUV', 'AWD', 7700),
(1640, 28, 170, 2024, 'Prestige 55', 'SUV', 'AWD', 7700),
(1641, 28, 170, 2025, 'SQ7 Premium Plus', 'SUV', 'AWD', 7700),
(1642, 28, 170, 2026, 'SQ7 Prestige', 'SUV', 'AWD', 7700);

-- A4 (ModelId=171, MakeId=28): 2015-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1643, 28, 171, 2015, 'Premium', 'Sedan', 'FWD', 0),
(1644, 28, 171, 2016, 'Premium Plus', 'Sedan', 'AWD', 0),
(1645, 28, 171, 2017, 'Prestige', 'Sedan', 'FWD', 0),
(1646, 28, 171, 2018, 'S Line Premium', 'Sedan', 'AWD', 0),
(1647, 28, 171, 2019, 'Ultra Premium', 'Sedan', 'FWD', 0),
(1648, 28, 171, 2020, 'Premium 40', 'Sedan', 'AWD', 0),
(1649, 28, 171, 2021, 'Premium Plus 40', 'Sedan', 'FWD', 0),
(1650, 28, 171, 2022, 'Premium 45', 'Sedan', 'AWD', 0),
(1651, 28, 171, 2023, 'Premium Plus 45', 'Sedan', 'FWD', 0),
(1652, 28, 171, 2024, 'Prestige 45', 'Sedan', 'AWD', 0),
(1653, 28, 171, 2025, 'S4 Premium Plus', 'Sedan', 'FWD', 0),
(1654, 28, 171, 2026, 'S4 Prestige', 'Sedan', 'AWD', 0);

-- Q3 (ModelId=172, MakeId=28): 2019-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1655, 28, 172, 2019, 'Premium', 'SUV', 'FWD', 0),
(1656, 28, 172, 2020, 'Premium Plus', 'SUV', 'AWD', 0),
(1657, 28, 172, 2021, 'Prestige', 'SUV', 'FWD', 0),
(1658, 28, 172, 2022, 'S Line Premium', 'SUV', 'AWD', 0),
(1659, 28, 172, 2023, 'Premium 40', 'SUV', 'FWD', 0),
(1660, 28, 172, 2024, 'Premium Plus 40', 'SUV', 'AWD', 0),
(1661, 28, 172, 2025, 'Prestige 45', 'SUV', 'FWD', 0),
(1662, 28, 172, 2026, 'S Line 45', 'SUV', 'AWD', 0);

-- e-tron (ModelId=173, MakeId=28): 2019-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1663, 28, 173, 2019, 'Premium', 'SUV', 'AWD', 0),
(1664, 28, 173, 2020, 'Premium Plus', 'SUV', 'AWD', 0),
(1665, 28, 173, 2021, 'Prestige', 'SUV', 'AWD', 0),
(1666, 28, 173, 2022, 'Sportback Premium', 'SUV', 'AWD', 0),
(1667, 28, 173, 2023, 'Sportback Prestige', 'SUV', 'AWD', 0),
(1668, 28, 173, 2024, 'S', 'SUV', 'AWD', 0),
(1669, 28, 173, 2025, 'Sportback Premium Plus', 'SUV', 'AWD', 0),
(1670, 28, 173, 2026, 'Chronos Edition', 'SUV', 'AWD', 0);

-- Range Rover (ModelId=174, MakeId=29): 2015-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1671, 29, 174, 2015, 'SE', 'SUV', 'AWD', 7716),
(1672, 29, 174, 2016, 'HSE', 'SUV', '4WD', 7716),
(1673, 29, 174, 2017, 'Autobiography', 'SUV', 'AWD', 7716),
(1674, 29, 174, 2018, 'SV', 'SUV', '4WD', 7716),
(1675, 29, 174, 2019, 'Westminster', 'SUV', 'AWD', 7716),
(1676, 29, 174, 2020, 'First Edition', 'SUV', '4WD', 7716),
(1677, 29, 174, 2021, 'SV LWB', 'SUV', 'AWD', 7716),
(1678, 29, 174, 2022, 'HSE LWB', 'SUV', '4WD', 7716),
(1679, 29, 174, 2023, 'Autobiography LWB', 'SUV', 'AWD', 7716),
(1680, 29, 174, 2024, 'SE P400', 'SUV', '4WD', 7716),
(1681, 29, 174, 2025, 'HSE P530', 'SUV', 'AWD', 7716),
(1682, 29, 174, 2026, 'SV P615', 'SUV', '4WD', 7716);

-- Range Rover Sport (ModelId=175, MakeId=29): 2015-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1683, 29, 175, 2015, 'SE', 'SUV', 'AWD', 7716),
(1684, 29, 175, 2016, 'Dynamic SE', 'SUV', '4WD', 7716),
(1685, 29, 175, 2017, 'Dynamic HSE', 'SUV', 'AWD', 7716),
(1686, 29, 175, 2018, 'Autobiography', 'SUV', '4WD', 7716),
(1687, 29, 175, 2019, 'First Edition', 'SUV', 'AWD', 7716),
(1688, 29, 175, 2020, 'SV Edition One', 'SUV', '4WD', 7716),
(1689, 29, 175, 2021, 'SE P360', 'SUV', 'AWD', 7716),
(1690, 29, 175, 2022, 'Dynamic SE P400', 'SUV', '4WD', 7716),
(1691, 29, 175, 2023, 'Dynamic HSE P530', 'SUV', 'AWD', 7716),
(1692, 29, 175, 2024, 'Autobiography P530', 'SUV', '4WD', 7716),
(1693, 29, 175, 2025, 'HSE', 'SUV', 'AWD', 7716),
(1694, 29, 175, 2026, 'SVR', 'SUV', '4WD', 7716);

-- Defender (ModelId=176, MakeId=29): 2020-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1695, 29, 176, 2020, 'S', 'SUV', 'AWD', 8201),
(1696, 29, 176, 2021, 'SE', 'SUV', '4WD', 8201),
(1697, 29, 176, 2022, 'X-Dynamic SE', 'SUV', 'AWD', 8201),
(1698, 29, 176, 2023, 'X-Dynamic HSE', 'SUV', '4WD', 8201),
(1699, 29, 176, 2024, 'X', 'SUV', 'AWD', 8201),
(1700, 29, 176, 2025, 'V8', 'SUV', '4WD', 8201),
(1701, 29, 176, 2026, '75th Anniversary', 'SUV', 'AWD', 8201);

-- Discovery (ModelId=177, MakeId=29): 2017-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1702, 29, 177, 2017, 'S', 'SUV', 'AWD', 8201),
(1703, 29, 177, 2018, 'SE', 'SUV', '4WD', 8201),
(1704, 29, 177, 2019, 'HSE', 'SUV', 'AWD', 8201),
(1705, 29, 177, 2020, 'R-Dynamic SE', 'SUV', '4WD', 8201),
(1706, 29, 177, 2021, 'R-Dynamic HSE', 'SUV', 'AWD', 8201),
(1707, 29, 177, 2022, 'Metropolitan Edition', 'SUV', '4WD', 8201),
(1708, 29, 177, 2023, 'S P300', 'SUV', 'AWD', 8201),
(1709, 29, 177, 2024, 'SE P360', 'SUV', '4WD', 8201),
(1710, 29, 177, 2025, 'HSE P360', 'SUV', 'AWD', 8201),
(1711, 29, 177, 2026, 'R-Dynamic SE P360', 'SUV', '4WD', 8201);

-- Cayenne (ModelId=178, MakeId=30): 2015-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1712, 30, 178, 2015, 'Base', 'SUV', 'AWD', 7716),
(1713, 30, 178, 2016, 'S', 'SUV', 'AWD', 7716),
(1714, 30, 178, 2017, 'GTS', 'SUV', 'AWD', 7716),
(1715, 30, 178, 2018, 'Turbo', 'SUV', 'AWD', 7716),
(1716, 30, 178, 2019, 'Turbo GT', 'SUV', 'AWD', 7716),
(1717, 30, 178, 2020, 'E-Hybrid', 'SUV', 'AWD', 7716),
(1718, 30, 178, 2021, 'Coupe S', 'SUV', 'AWD', 7716),
(1719, 30, 178, 2022, 'Coupe GTS', 'SUV', 'AWD', 7716),
(1720, 30, 178, 2023, 'Coupe Turbo', 'SUV', 'AWD', 7716),
(1721, 30, 178, 2024, 'Coupe Turbo GT', 'SUV', 'AWD', 7716),
(1722, 30, 178, 2025, 'S E-Hybrid', 'SUV', 'AWD', 7716),
(1723, 30, 178, 2026, 'Coupe E-Hybrid', 'SUV', 'AWD', 7716);

-- Macan (ModelId=179, MakeId=30): 2015-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1724, 30, 179, 2015, 'Base', 'SUV', 'AWD', 0),
(1725, 30, 179, 2016, 'S', 'SUV', 'AWD', 0),
(1726, 30, 179, 2017, 'GTS', 'SUV', 'AWD', 0),
(1727, 30, 179, 2018, 'T', 'SUV', 'AWD', 0),
(1728, 30, 179, 2019, 'Turbo', 'SUV', 'AWD', 0),
(1729, 30, 179, 2020, 'Electric', 'SUV', 'AWD', 0),
(1730, 30, 179, 2021, 'S Sport Chrono', 'SUV', 'AWD', 0),
(1731, 30, 179, 2022, 'GTS Sport Chrono', 'SUV', 'AWD', 0),
(1732, 30, 179, 2023, 'Turbo Sport Chrono', 'SUV', 'AWD', 0),
(1733, 30, 179, 2024, 'T Sport Chrono', 'SUV', 'AWD', 0),
(1734, 30, 179, 2025, 'Electric AWD', 'SUV', 'AWD', 0),
(1735, 30, 179, 2026, 'Base Sport Chrono', 'SUV', 'AWD', 0);

-- 911 (ModelId=180, MakeId=30): 2015-2026
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(1736, 30, 180, 2015, 'Carrera', 'Coupe', 'RWD', 0),
(1737, 30, 180, 2016, 'Carrera S', 'Coupe', 'AWD', 0),
(1738, 30, 180, 2017, 'Carrera 4S', 'Coupe', 'RWD', 0),
(1739, 30, 180, 2018, 'Turbo', 'Coupe', 'AWD', 0),
(1740, 30, 180, 2019, 'Turbo S', 'Coupe', 'RWD', 0),
(1741, 30, 180, 2020, 'GT3', 'Coupe', 'AWD', 0),
(1742, 30, 180, 2021, 'GT3 RS', 'Coupe', 'RWD', 0),
(1743, 30, 180, 2022, 'Targa 4', 'Coupe', 'AWD', 0),
(1744, 30, 180, 2023, 'Targa 4S', 'Coupe', 'RWD', 0),
(1745, 30, 180, 2024, 'GTS', 'Coupe', 'AWD', 0),
(1746, 30, 180, 2025, 'Carrera 4', 'Coupe', 'RWD', 0),
(1747, 30, 180, 2026, 'Carrera T', 'Coupe', 'AWD', 0);

SET IDENTITY_INSERT Vehicles OFF;

-- Total new vehicles added: 950
-- Final vehicle ID: 1747
