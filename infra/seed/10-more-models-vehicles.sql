-- ============================================================================
-- FitSpec: Add missing popular models, more makes, and wider year ranges
-- ============================================================================

-- ==========================================================================
-- NEW MAKES: Kia (16), Mazda (17), Dodge (18)
-- ==========================================================================
SET IDENTITY_INSERT Makes ON;
INSERT INTO Makes (Id, Name, Slug) VALUES
(16, 'Kia',   'kia'),
(17, 'Mazda', 'mazda'),
(18, 'Dodge', 'dodge');
SET IDENTITY_INSERT Makes OFF;

-- ==========================================================================
-- NEW MODELS (IDs 43-80)
-- ==========================================================================
SET IDENTITY_INSERT Models ON;
INSERT INTO Models (Id, MakeId, Name, Slug) VALUES
-- Toyota missing
(43, 3, 'Camry',       'camry'),
(44, 3, 'Corolla',     'corolla'),
(45, 3, 'Sienna',      'sienna'),
(46, 3, 'Highlander',  'highlander'),
-- Honda missing
(47, 5, 'Civic',       'civic'),
(48, 5, 'Accord',      'accord'),
(49, 5, 'HR-V',        'hr-v'),
-- Ford missing
(50, 1, 'Escape',      'escape'),
(51, 1, 'Edge',        'edge'),
(52, 1, 'Mustang',     'mustang'),
(53, 1, 'Expedition',  'expedition'),
-- Chevy missing
(54, 2, 'Malibu',      'malibu'),
(55, 2, 'Traverse',    'traverse'),
(56, 2, 'Blazer',      'blazer'),
(57, 2, 'Trailblazer', 'trailblazer'),
-- Nissan missing
(58, 8, 'Rogue',       'rogue'),
(59, 8, 'Altima',      'altima'),
(60, 8, 'Sentra',      'sentra'),
-- Hyundai missing
(61, 9, 'Santa Fe',    'santa-fe'),
(62, 9, 'Elantra',     'elantra'),
(63, 9, 'Palisade',    'palisade'),
-- RAM missing
(64, 4, 'ProMaster',   'promaster'),
-- Jeep missing
(65, 6, 'Cherokee',    'cherokee'),
(66, 6, 'Compass',     'compass'),
-- GMC missing
(67, 7, 'Terrain',     'terrain'),
(68, 7, 'Acadia',      'acadia'),
-- Subaru missing
(69, 10, 'Forester',   'forester'),
(70, 10, 'Ascent',     'ascent'),
-- Kia (new make)
(71, 16, 'Telluride',  'telluride'),
(72, 16, 'Sorento',    'sorento'),
(73, 16, 'Sportage',   'sportage'),
(74, 16, 'Forte',      'forte'),
-- Mazda (new make)
(75, 17, 'CX-5',       'cx-5'),
(76, 17, 'CX-50',      'cx-50'),
(77, 17, 'CX-90',      'cx-90'),
(78, 17, 'Mazda3',     'mazda3'),
-- Dodge (new make)
(79, 18, 'Durango',    'durango'),
(80, 18, 'Charger',    'charger');
SET IDENTITY_INSERT Models OFF;

-- ==========================================================================
-- NEW VEHICLES (IDs 165-350+)
-- Wide year ranges: 2017-2025 for popular models
-- ==========================================================================
SET IDENTITY_INSERT Vehicles ON;
INSERT INTO Vehicles (Id, MakeId, ModelId, Year, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
-- Toyota Camry (ModelId 43)
(165, 3, 43, 2025, 'XSE',         'Sedan', 'FWD', 0),
(166, 3, 43, 2025, 'XLE',         'Sedan', 'AWD', 0),
(167, 3, 43, 2024, 'SE',          'Sedan', 'FWD', 0),
(168, 3, 43, 2023, 'LE',          'Sedan', 'FWD', 0),
(169, 3, 43, 2022, 'TRD',         'Sedan', 'FWD', 0),
(170, 3, 43, 2021, 'XSE',         'Sedan', 'AWD', 0),
(171, 3, 43, 2020, 'SE',          'Sedan', 'FWD', 0),
(172, 3, 43, 2019, 'LE',          'Sedan', 'FWD', 0),
(173, 3, 43, 2018, 'XLE',         'Sedan', 'FWD', 0),
-- Toyota Corolla (ModelId 44)
(174, 3, 44, 2025, 'SE',          'Sedan', 'FWD', 0),
(175, 3, 44, 2024, 'LE',          'Sedan', 'FWD', 0),
(176, 3, 44, 2023, 'XSE',         'Sedan', 'FWD', 0),
(177, 3, 44, 2022, 'SE',          'Sedan', 'FWD', 0),
(178, 3, 44, 2021, 'LE',          'Sedan', 'FWD', 0),
(179, 3, 44, 2020, 'XLE',         'Sedan', 'FWD', 0),
(180, 3, 44, 2019, 'SE',          'Sedan', 'FWD', 0),
-- Toyota Sienna (ModelId 45)
(181, 3, 45, 2025, 'XLE',         'Minivan', 'AWD', 3500),
(182, 3, 45, 2025, 'Woodland',    'Minivan', 'AWD', 3500),
(183, 3, 45, 2024, 'Limited',     'Minivan', 'AWD', 3500),
(184, 3, 45, 2023, 'XSE',         'Minivan', 'FWD', 3500),
(185, 3, 45, 2022, 'LE',          'Minivan', 'FWD', 3500),
(186, 3, 45, 2021, 'XLE',         'Minivan', 'AWD', 3500),
(187, 3, 45, 2020, 'SE',          'Minivan', 'FWD', 3500),
(188, 3, 45, 2019, 'Limited',     'Minivan', 'AWD', 3500),
-- Toyota Highlander (ModelId 46)
(189, 3, 46, 2025, 'Limited',     'SUV', 'AWD', 5000),
(190, 3, 46, 2025, 'XLE',         'SUV', 'AWD', 5000),
(191, 3, 46, 2024, 'XSE',         'SUV', 'AWD', 5000),
(192, 3, 46, 2023, 'Bronze Edition','SUV','AWD', 5000),
(193, 3, 46, 2022, 'Limited',     'SUV', 'AWD', 5000),
(194, 3, 46, 2021, 'XLE',         'SUV', 'FWD', 5000),
(195, 3, 46, 2020, 'LE',          'SUV', 'FWD', 5000),
(196, 3, 46, 2019, 'Limited',     'SUV', 'AWD', 5000),
-- Honda Civic (ModelId 47)
(197, 5, 47, 2025, 'Sport',       'Sedan', 'FWD', 0),
(198, 5, 47, 2025, 'Si',          'Sedan', 'FWD', 0),
(199, 5, 47, 2024, 'EX',          'Sedan', 'FWD', 0),
(200, 5, 47, 2023, 'Touring',     'Sedan', 'FWD', 0),
(201, 5, 47, 2022, 'Sport',       'Sedan', 'FWD', 0),
(202, 5, 47, 2021, 'EX',          'Sedan', 'FWD', 0),
(203, 5, 47, 2020, 'LX',          'Sedan', 'FWD', 0),
(204, 5, 47, 2019, 'Si',          'Sedan', 'FWD', 0),
(205, 5, 47, 2018, 'Type R',      'Sedan', 'FWD', 0),
-- Honda Accord (ModelId 48)
(206, 5, 48, 2025, 'Sport',       'Sedan', 'FWD', 0),
(207, 5, 48, 2024, 'EX-L',        'Sedan', 'FWD', 0),
(208, 5, 48, 2023, 'Touring',     'Sedan', 'FWD', 0),
(209, 5, 48, 2022, 'Sport',       'Sedan', 'FWD', 0),
(210, 5, 48, 2021, 'EX',          'Sedan', 'FWD', 0),
(211, 5, 48, 2020, 'LX',          'Sedan', 'FWD', 0),
(212, 5, 48, 2019, 'Sport',       'Sedan', 'FWD', 0),
(213, 5, 48, 2018, 'Touring',     'Sedan', 'FWD', 0),
-- Honda HR-V (ModelId 49)
(214, 5, 49, 2025, 'Sport',       'SUV', 'AWD', 0),
(215, 5, 49, 2024, 'EX-L',        'SUV', 'AWD', 0),
(216, 5, 49, 2023, 'LX',          'SUV', 'FWD', 0),
(217, 5, 49, 2022, 'Sport',       'SUV', 'FWD', 0),
-- Ford Escape (ModelId 50)
(218, 1, 50, 2025, 'ST-Line',     'SUV', 'AWD', 3500),
(219, 1, 50, 2024, 'Platinum',    'SUV', 'AWD', 3500),
(220, 1, 50, 2023, 'SE',          'SUV', 'FWD', 2000),
(221, 1, 50, 2022, 'SEL',         'SUV', 'AWD', 3500),
(222, 1, 50, 2021, 'Titanium',    'SUV', 'AWD', 3500),
(223, 1, 50, 2020, 'SE',          'SUV', 'FWD', 2000),
-- Ford Edge (ModelId 51)
(224, 1, 51, 2024, 'ST',          'SUV', 'AWD', 3500),
(225, 1, 51, 2023, 'SEL',         'SUV', 'AWD', 3500),
(226, 1, 51, 2022, 'Titanium',    'SUV', 'AWD', 3500),
(227, 1, 51, 2021, 'SE',          'SUV', 'FWD', 3500),
(228, 1, 51, 2020, 'ST',          'SUV', 'AWD', 3500),
-- Ford Mustang (ModelId 52)
(229, 1, 52, 2025, 'GT',          'Coupe', 'RWD', 0),
(230, 1, 52, 2025, 'Dark Horse',  'Coupe', 'RWD', 0),
(231, 1, 52, 2024, 'EcoBoost',    'Coupe', 'RWD', 0),
(232, 1, 52, 2023, 'GT',          'Coupe', 'RWD', 0),
(233, 1, 52, 2022, 'Mach 1',      'Coupe', 'RWD', 0),
(234, 1, 52, 2021, 'GT Premium',  'Coupe', 'RWD', 0),
(235, 1, 52, 2020, 'EcoBoost',    'Coupe', 'RWD', 0),
(236, 1, 52, 2019, 'Bullitt',     'Coupe', 'RWD', 0),
-- Ford Expedition (ModelId 53)
(237, 1, 53, 2025, 'Limited',     'SUV', '4WD', 9300),
(238, 1, 53, 2024, 'King Ranch',  'SUV', '4WD', 9300),
(239, 1, 53, 2023, 'XLT',         'SUV', '4WD', 9300),
(240, 1, 53, 2022, 'Timberline',  'SUV', '4WD', 9300),
(241, 1, 53, 2021, 'Platinum',    'SUV', '4WD', 9300),
(242, 1, 53, 2020, 'Limited',     'SUV', '4WD', 9300),
-- Chevy Malibu (ModelId 54)
(243, 2, 54, 2024, 'RS',          'Sedan', 'FWD', 0),
(244, 2, 54, 2023, 'LT',          'Sedan', 'FWD', 0),
(245, 2, 54, 2022, 'Premier',     'Sedan', 'FWD', 0),
(246, 2, 54, 2021, 'RS',          'Sedan', 'FWD', 0),
(247, 2, 54, 2020, 'LT',          'Sedan', 'FWD', 0),
-- Chevy Traverse (ModelId 55)
(248, 2, 55, 2025, 'RS',          'SUV', 'AWD', 5000),
(249, 2, 55, 2024, 'LT',          'SUV', 'AWD', 5000),
(250, 2, 55, 2023, 'High Country','SUV', 'AWD', 5000),
(251, 2, 55, 2022, 'Premier',     'SUV', 'AWD', 5000),
(252, 2, 55, 2021, 'LT',          'SUV', 'FWD', 5000),
(253, 2, 55, 2020, 'RS',          'SUV', 'AWD', 5000),
-- Chevy Blazer (ModelId 56)
(254, 2, 56, 2025, 'RS',          'SUV', 'AWD', 4500),
(255, 2, 56, 2024, 'LT',          'SUV', 'FWD', 4500),
(256, 2, 56, 2023, 'Premier',     'SUV', 'AWD', 4500),
(257, 2, 56, 2022, 'RS',          'SUV', 'AWD', 4500),
(258, 2, 56, 2021, 'LT',          'SUV', 'FWD', 4500),
-- Chevy Trailblazer (ModelId 57)
(259, 2, 57, 2025, 'RS',          'SUV', 'AWD', 1000),
(260, 2, 57, 2024, 'LT',          'SUV', 'FWD', 1000),
(261, 2, 57, 2023, 'ACTIV',       'SUV', 'AWD', 1000),
(262, 2, 57, 2022, 'RS',          'SUV', 'FWD', 1000),
-- Nissan Rogue (ModelId 58)
(263, 8, 58, 2025, 'SL',          'SUV', 'AWD', 1500),
(264, 8, 58, 2024, 'SV',          'SUV', 'FWD', 1500),
(265, 8, 58, 2023, 'Platinum',    'SUV', 'AWD', 1500),
(266, 8, 58, 2022, 'SL',          'SUV', 'AWD', 1500),
(267, 8, 58, 2021, 'SV',          'SUV', 'FWD', 1500),
(268, 8, 58, 2020, 'SL',          'SUV', 'AWD', 1350),
-- Nissan Altima (ModelId 59)
(269, 8, 59, 2025, 'SR',          'Sedan', 'FWD', 0),
(270, 8, 59, 2024, 'SV',          'Sedan', 'AWD', 0),
(271, 8, 59, 2023, 'SL',          'Sedan', 'FWD', 0),
(272, 8, 59, 2022, 'SR',          'Sedan', 'FWD', 0),
(273, 8, 59, 2021, 'Platinum',    'Sedan', 'AWD', 0),
(274, 8, 59, 2020, 'SV',          'Sedan', 'FWD', 0),
-- Nissan Sentra (ModelId 60)
(275, 8, 60, 2025, 'SR',          'Sedan', 'FWD', 0),
(276, 8, 60, 2024, 'SV',          'Sedan', 'FWD', 0),
(277, 8, 60, 2023, 'SR',          'Sedan', 'FWD', 0),
(278, 8, 60, 2022, 'SV',          'Sedan', 'FWD', 0),
-- Hyundai Santa Fe (ModelId 61)
(279, 9, 61, 2025, 'Calligraphy', 'SUV', 'AWD', 3500),
(280, 9, 61, 2024, 'Limited',     'SUV', 'AWD', 3500),
(281, 9, 61, 2023, 'SEL',         'SUV', 'AWD', 3500),
(282, 9, 61, 2022, 'Limited',     'SUV', 'AWD', 3500),
(283, 9, 61, 2021, 'SEL',         'SUV', 'FWD', 2000),
(284, 9, 61, 2020, 'SE',          'SUV', 'FWD', 2000),
-- Hyundai Elantra (ModelId 62)
(285, 9, 62, 2025, 'N',           'Sedan', 'FWD', 0),
(286, 9, 62, 2024, 'SEL',         'Sedan', 'FWD', 0),
(287, 9, 62, 2023, 'Limited',     'Sedan', 'FWD', 0),
(288, 9, 62, 2022, 'N Line',      'Sedan', 'FWD', 0),
(289, 9, 62, 2021, 'SEL',         'Sedan', 'FWD', 0),
-- Hyundai Palisade (ModelId 63)
(290, 9, 63, 2025, 'Calligraphy', 'SUV', 'AWD', 5000),
(291, 9, 63, 2024, 'Limited',     'SUV', 'AWD', 5000),
(292, 9, 63, 2023, 'SEL',         'SUV', 'AWD', 5000),
(293, 9, 63, 2022, 'Calligraphy', 'SUV', 'AWD', 5000),
(294, 9, 63, 2021, 'Limited',     'SUV', 'AWD', 5000),
(295, 9, 63, 2020, 'SEL',         'SUV', 'FWD', 5000),
-- Jeep Cherokee (ModelId 65)
(296, 6, 65, 2023, 'Trailhawk',   'SUV', '4WD', 4500),
(297, 6, 65, 2022, 'Limited',     'SUV', 'AWD', 4500),
(298, 6, 65, 2021, 'Latitude',    'SUV', 'FWD', 4500),
(299, 6, 65, 2020, 'Trailhawk',   'SUV', '4WD', 4500),
-- Jeep Compass (ModelId 66)
(300, 6, 66, 2025, 'Trailhawk',   'SUV', '4WD', 2000),
(301, 6, 66, 2024, 'Limited',     'SUV', 'AWD', 2000),
(302, 6, 66, 2023, 'Latitude',    'SUV', 'FWD', 2000),
(303, 6, 66, 2022, 'Trailhawk',   'SUV', '4WD', 2000),
-- GMC Terrain (ModelId 67)
(304, 7, 67, 2025, 'AT4',         'SUV', 'AWD', 3500),
(305, 7, 67, 2024, 'Denali',      'SUV', 'AWD', 3500),
(306, 7, 67, 2023, 'SLT',         'SUV', 'AWD', 3500),
(307, 7, 67, 2022, 'AT4',         'SUV', 'AWD', 3500),
-- GMC Acadia (ModelId 68)
(308, 7, 68, 2025, 'AT4',         'SUV', 'AWD', 4000),
(309, 7, 68, 2024, 'Denali',      'SUV', 'AWD', 4000),
(310, 7, 68, 2023, 'SLT',         'SUV', 'AWD', 4000),
(311, 7, 68, 2022, 'AT4',         'SUV', 'AWD', 4000),
-- Subaru Forester (ModelId 69)
(312, 10, 69, 2025, 'Touring',    'SUV', 'AWD', 1500),
(313, 10, 69, 2024, 'Sport',      'SUV', 'AWD', 1500),
(314, 10, 69, 2023, 'Wilderness', 'SUV', 'AWD', 1500),
(315, 10, 69, 2022, 'Premium',    'SUV', 'AWD', 1500),
(316, 10, 69, 2021, 'Sport',      'SUV', 'AWD', 1500),
-- Subaru Ascent (ModelId 70)
(317, 10, 70, 2025, 'Touring',    'SUV', 'AWD', 5000),
(318, 10, 70, 2024, 'Onyx',       'SUV', 'AWD', 5000),
(319, 10, 70, 2023, 'Limited',    'SUV', 'AWD', 5000),
(320, 10, 70, 2022, 'Premium',    'SUV', 'AWD', 5000),
-- Kia Telluride (ModelId 71)
(321, 16, 71, 2025, 'SX',         'SUV', 'AWD', 5000),
(322, 16, 71, 2024, 'EX',         'SUV', 'AWD', 5000),
(323, 16, 71, 2023, 'SX Prestige','SUV', 'AWD', 5000),
(324, 16, 71, 2022, 'EX',         'SUV', 'AWD', 5000),
(325, 16, 71, 2021, 'SX',         'SUV', 'AWD', 5000),
(326, 16, 71, 2020, 'LX',         'SUV', 'FWD', 5000),
-- Kia Sorento (ModelId 72)
(327, 16, 72, 2025, 'SX',         'SUV', 'AWD', 3500),
(328, 16, 72, 2024, 'EX',         'SUV', 'AWD', 3500),
(329, 16, 72, 2023, 'SX Prestige','SUV', 'AWD', 3500),
(330, 16, 72, 2022, 'EX',         'SUV', 'FWD', 3500),
(331, 16, 72, 2021, 'SX',         'SUV', 'AWD', 3500),
-- Kia Sportage (ModelId 73)
(332, 16, 73, 2025, 'X-Pro',      'SUV', 'AWD', 2500),
(333, 16, 73, 2024, 'EX',         'SUV', 'AWD', 2500),
(334, 16, 73, 2023, 'SX Prestige','SUV', 'AWD', 2500),
(335, 16, 73, 2022, 'EX',         'SUV', 'FWD', 2500),
-- Kia Forte (ModelId 74)
(336, 16, 74, 2025, 'GT',         'Sedan', 'FWD', 0),
(337, 16, 74, 2024, 'LXS',        'Sedan', 'FWD', 0),
(338, 16, 74, 2023, 'GT-Line',    'Sedan', 'FWD', 0),
(339, 16, 74, 2022, 'GT',         'Sedan', 'FWD', 0),
-- Mazda CX-5 (ModelId 75)
(340, 17, 75, 2025, 'Turbo',      'SUV', 'AWD', 2000),
(341, 17, 75, 2024, 'Premium Plus','SUV','AWD', 2000),
(342, 17, 75, 2023, 'Turbo',      'SUV', 'AWD', 2000),
(343, 17, 75, 2022, 'Preferred',  'SUV', 'FWD', 2000),
(344, 17, 75, 2021, 'Grand Touring','SUV','AWD', 2000),
-- Mazda CX-50 (ModelId 76)
(345, 17, 76, 2025, 'Turbo Premium Plus','SUV','AWD', 3500),
(346, 17, 76, 2024, 'Turbo',      'SUV', 'AWD', 3500),
(347, 17, 76, 2023, 'Premium Plus','SUV','AWD', 3500),
-- Mazda CX-90 (ModelId 77)
(348, 17, 77, 2025, 'Turbo S',    'SUV', 'AWD', 5000),
(349, 17, 77, 2024, 'PHEV Premium Plus','SUV','AWD', 5000),
(350, 17, 77, 2024, 'Turbo',      'SUV', 'AWD', 5000),
-- Mazda3 (ModelId 78)
(351, 17, 78, 2025, 'Turbo',      'Sedan', 'AWD', 0),
(352, 17, 78, 2024, 'Premium',    'Sedan', 'AWD', 0),
(353, 17, 78, 2023, 'Preferred',  'Sedan', 'FWD', 0),
-- Dodge Durango (ModelId 79)
(354, 18, 79, 2025, 'R/T',        'SUV', 'AWD', 8700),
(355, 18, 79, 2024, 'SRT 392',    'SUV', 'AWD', 8700),
(356, 18, 79, 2023, 'GT',         'SUV', 'AWD', 6200),
(357, 18, 79, 2022, 'R/T',        'SUV', 'AWD', 8700),
(358, 18, 79, 2021, 'Citadel',    'SUV', 'AWD', 7400),
-- Dodge Charger (ModelId 80)
(359, 18, 80, 2025, 'Daytona',    'Sedan', 'AWD', 0),
(360, 18, 80, 2024, 'Scat Pack',  'Sedan', 'RWD', 0),
(361, 18, 80, 2023, 'R/T',        'Sedan', 'RWD', 0),
(362, 18, 80, 2022, 'SRT Hellcat','Sedan', 'RWD', 0),
(363, 18, 80, 2021, 'GT',         'Sedan', 'AWD', 0),
-- Extra year coverage for existing popular models
-- More F-150 years
(364, 1, 1, 2025, 'Raptor',       'Crew Cab', '4WD', 8200),
(365, 1, 1, 2025, 'Lariat',       'Crew Cab', '4WD', 13300),
(366, 1, 1, 2020, 'XLT',          'Crew Cab', '4WD', 11300),
(367, 1, 1, 2019, 'Platinum',     'Crew Cab', '4WD', 13200),
(368, 1, 1, 2018, 'XLT',          'Crew Cab', '4WD', 11100),
-- More Silverado years
(369, 2, 6, 2025, 'High Country', 'Crew Cab', '4WD', 13300),
(370, 2, 6, 2022, 'LT Trail Boss','Crew Cab', '4WD', 9500),
(371, 2, 6, 2019, 'LTZ',          'Crew Cab', '4WD', 11800),
-- More Tacoma years
(372, 3, 10, 2025, 'SR',          'Crew Cab', '4WD', 6500),
(373, 3, 10, 2022, 'TRD Pro',     'Crew Cab', '4WD', 6500),
(374, 3, 10, 2020, 'SR5',         'Crew Cab', 'RWD', 6800),
(375, 3, 10, 2018, 'TRD Off-Road','Crew Cab', '4WD', 6800),
-- More RAM 1500 years
(376, 4, 14, 2024, 'Rebel',       'Crew Cab', '4WD', 11560),
(377, 4, 14, 2023, 'Limited',     'Crew Cab', '4WD', 12750),
(378, 4, 14, 2022, 'Big Horn',    'Crew Cab', '4WD', 11240),
(379, 4, 14, 2021, 'Laramie',     'Crew Cab', '4WD', 11560),
-- More Wrangler years
(380, 6, 20, 2024, 'Rubicon',     'SUV', '4WD', 3500),
(381, 6, 20, 2023, 'Sahara',      'SUV', '4WD', 3500),
(382, 6, 20, 2021, 'Rubicon 4xe', 'SUV', '4WD', 3500),
(383, 6, 20, 2020, 'Sport',       'SUV', '4WD', 2000),
-- More 4Runner years
(384, 3, 12, 2024, 'TRD Off-Road','SUV', '4WD', 5000),
(385, 3, 12, 2022, 'Trail',       'SUV', '4WD', 5000),
(386, 3, 12, 2020, 'TRD Pro',     'SUV', '4WD', 5000),
(387, 3, 12, 2019, 'Limited',     'SUV', '4WD', 5000),
(388, 3, 12, 2018, 'SR5',         'SUV', 'RWD', 5000);

SET IDENTITY_INSERT Vehicles OFF;
