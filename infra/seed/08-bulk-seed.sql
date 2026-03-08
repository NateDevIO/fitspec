-- ============================================================================
-- FitSpec Bulk Seed: Additional Vehicles + Broad Fitment Mappings
-- Adds ~60 vehicles and ~1500 fitment mappings for full coverage
-- ============================================================================

-- ==========================================================================
-- PART 1: Additional Vehicles (IDs 108-170)
-- More year/trim combos for existing models
-- ==========================================================================
SET IDENTITY_INSERT Vehicles ON;

INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
-- Ford F-150 extras
(108, 1, 1, 2025, 'XLT',          'Crew Cab', '4WD', 11600),
(109, 1, 1, 2025, 'Tremor',       'Crew Cab', '4WD', 10200),
(110, 1, 1, 2017, 'XLT',          'Crew Cab', '4WD', 11000),
(111, 1, 1, 2016, 'Lariat',       'Crew Cab', '4WD', 12200),
-- Ford Ranger extras
(112, 1, 2, 2025, 'Raptor',       'Crew Cab', '4WD', 7500),
(113, 1, 2, 2022, 'XLT',          'Crew Cab', '4WD', 7500),
-- Ford Bronco extras
(114, 1, 4, 2025, 'Raptor',       'SUV', '4WD', 3500),
(115, 1, 4, 2024, 'Wildtrak',     'SUV', '4WD', 3500),
-- Chevy Silverado extras
(116, 2, 6, 2025, 'LT',           'Crew Cab', '4WD', 11400),
(117, 2, 6, 2025, 'ZR2',          'Crew Cab', '4WD', 9500),
(118, 2, 6, 2020, 'RST',          'Crew Cab', '4WD', 11100),
(119, 2, 6, 2018, 'LT',           'Crew Cab', '4WD', 11200),
-- Chevy Colorado extras
(120, 2, 7, 2025, 'ZR2',          'Crew Cab', '4WD', 7700),
(121, 2, 7, 2022, 'LT',           'Crew Cab', 'RWD', 7000),
-- Toyota Tacoma extras
(122, 3, 10, 2025, 'TRD Off-Road','Crew Cab', '4WD', 6500),
(123, 3, 10, 2025, 'Limited',     'Crew Cab', '4WD', 6500),
(124, 3, 10, 2023, 'SR5',         'Crew Cab', '4WD', 6500),
(125, 3, 10, 2021, 'TRD Off-Road','Crew Cab', '4WD', 6500),
(126, 3, 10, 2019, 'SR5',         'Crew Cab', 'RWD', 6800),
(127, 3, 10, 2017, 'TRD Sport',   'Crew Cab', '4WD', 6800),
-- Toyota Tundra extras
(128, 3, 11, 2025, 'Limited',     'Crew Cab', '4WD', 11450),
(129, 3, 11, 2025, 'TRD Pro',     'Crew Cab', '4WD', 10890),
(130, 3, 11, 2021, 'SR5',         'Crew Cab', '4WD', 10200),
-- Toyota 4Runner extras
(131, 3, 12, 2025, 'TRD Pro',     'SUV', '4WD', 5000),
(132, 3, 12, 2023, 'Limited',     'SUV', '4WD', 5000),
(133, 3, 12, 2021, 'SR5',         'SUV', 'RWD', 5000),
-- Toyota RAV4 extras
(134, 3, 13, 2025, 'TRD Off-Road','SUV', 'AWD', 3500),
(135, 3, 13, 2023, 'Limited',     'SUV', 'AWD', 3500),
(136, 3, 13, 2021, 'XLE Premium', 'SUV', 'AWD', 1750),
-- RAM 1500 extras
(137, 4, 14, 2025, 'Laramie',     'Crew Cab', '4WD', 11560),
(138, 4, 14, 2025, 'TRX',         'Crew Cab', '4WD', 8100),
(139, 4, 14, 2020, 'Big Horn',    'Crew Cab', '4WD', 11240),
(140, 4, 14, 2018, 'Limited',     'Crew Cab', '4WD', 12750),
-- Honda Ridgeline extras
(141, 5, 17, 2025, 'TrailSport',  'Crew Cab', 'AWD', 5000),
(142, 5, 17, 2023, 'Black Edition','Crew Cab','AWD', 5000),
(143, 5, 17, 2020, 'RTL',         'Crew Cab', 'AWD', 5000),
-- Honda Pilot extras
(144, 5, 18, 2025, 'Elite',       'SUV', 'AWD', 5000),
(145, 5, 18, 2023, 'Sport',       'SUV', 'AWD', 5000),
-- Honda CR-V extras
(146, 5, 19, 2025, 'Hybrid Sport','SUV', 'AWD', 1500),
(147, 5, 19, 2023, 'EX',          'SUV', 'FWD', 1500),
-- Jeep Wrangler extras
(148, 6, 20, 2025, 'Rubicon 392', 'SUV', '4WD', 3500),
(149, 6, 20, 2022, 'Willys',      'SUV', '4WD', 2000),
(150, 6, 20, 2019, 'Rubicon',     'SUV', '4WD', 3500),
-- Jeep Gladiator extras
(151, 6, 21, 2025, 'Rubicon',     'Crew Cab', '4WD', 7650),
(152, 6, 21, 2022, 'Sport',       'Crew Cab', '4WD', 4500),
-- Jeep Grand Cherokee extras
(153, 6, 22, 2025, 'Summit',      'SUV', '4WD', 7200),
(154, 6, 22, 2023, 'Overland',    'SUV', 'AWD', 6200),
-- GMC Sierra extras
(155, 7, 23, 2025, 'AT4X',        'Crew Cab', '4WD', 11500),
(156, 7, 23, 2022, 'SLT',         'Crew Cab', '4WD', 11200),
(157, 7, 23, 2020, 'Denali',      'Crew Cab', '4WD', 12100),
-- Nissan Frontier extras
(158, 8, 26, 2025, 'PRO-4X',      'Crew Cab', '4WD', 6720),
(159, 8, 26, 2023, 'SV',          'Crew Cab', 'RWD', 6720),
-- Nissan Titan extras
(160, 8, 27, 2024, 'PRO-4X',      'Crew Cab', '4WD', 9370),
-- Subaru Outback extras
(161, 10, 31, 2025, 'Wilderness',  'SUV', 'AWD', 3500),
(162, 10, 31, 2023, 'Onyx Edition','SUV', 'AWD', 3500),
-- Tesla Cybertruck extras
(163, 14, 39, 2025, 'Foundation', 'Crew Cab', 'AWD', 11000),
-- Rivian R1T extras
(164, 15, 41, 2025, 'Adventure',  'Crew Cab', 'AWD', 11000);

SET IDENTITY_INSERT Vehicles OFF;
