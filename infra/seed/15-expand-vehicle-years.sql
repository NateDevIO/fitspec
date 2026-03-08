-- ============================================================================
-- Expand vehicle year coverage
-- Extends popular models back to 2015 and fills year gaps for all models
-- Starting IDs from 389 (max existing is 388)
-- ============================================================================

SET IDENTITY_INSERT Vehicles ON;

-- ==========================================================================
-- FORD F-150 (MakeId=1, ModelId=1) — fill 2015, missing trims
-- ==========================================================================
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(389,  2015, 1, 1, 'XLT',           'Crew Cab',     '4WD', 11100),
(390,  2015, 1, 1, 'Lariat',        'Crew Cab',     '4WD', 11500),
(391,  2017, 1, 1, 'Lariat',        'Crew Cab',     '4WD', 11500),
(392,  2021, 1, 1, 'Lariat',        'Crew Cab',     '4WD', 11500),
(393,  2022, 1, 1, 'XLT',           'Crew Cab',     '4WD', 11300),
(394,  2023, 1, 1, 'XLT',           'Crew Cab',     '4WD', 11300),
(395,  2023, 1, 1, 'Raptor',        'Crew Cab',     '4WD', 8200);

-- ==========================================================================
-- FORD RANGER (MakeId=1, ModelId=2) — extend back to 2019
-- ==========================================================================
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(396,  2019, 1, 2, 'XLT',           'Crew Cab',     '4WD', 7500),
(397,  2020, 1, 2, 'Lariat',        'Crew Cab',     '4WD', 7500),
(398,  2021, 1, 2, 'XLT',           'Crew Cab',     '4WD', 7500),
(399,  2022, 1, 2, 'Lariat',        'Crew Cab',     '4WD', 7500);

-- ==========================================================================
-- FORD EXPLORER (MakeId=1, ModelId=3) — extend back to 2017
-- ==========================================================================
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(400,  2017, 1, 3, 'XLT',           'SUV',          'AWD', 5000),
(401,  2018, 1, 3, 'Limited',       'SUV',          'AWD', 5000),
(402,  2019, 1, 3, 'XLT',           'SUV',          'AWD', 5000);

-- ==========================================================================
-- FORD ESCAPE (MakeId=1, ModelId=50) — extend back to 2017
-- ==========================================================================
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(403,  2017, 1, 50, 'SE',           'SUV',          'AWD', 3500),
(404,  2018, 1, 50, 'Titanium',     'SUV',          'AWD', 3500),
(405,  2019, 1, 50, 'SE',           'SUV',          'AWD', 3500);

-- ==========================================================================
-- FORD MUSTANG (MakeId=1, ModelId=52) — extend back to 2015
-- ==========================================================================
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(406,  2015, 1, 52, 'GT',           'Coupe',        'RWD', 0),
(407,  2016, 1, 52, 'EcoBoost',     'Coupe',        'RWD', 0),
(408,  2017, 1, 52, 'GT',           'Coupe',        'RWD', 0),
(409,  2018, 1, 52, 'GT',           'Coupe',        'RWD', 0);

-- ==========================================================================
-- FORD EXPEDITION (MakeId=1, ModelId=53) — extend back to 2017
-- ==========================================================================
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(410,  2017, 1, 53, 'XLT',          'SUV',          '4WD', 9300),
(411,  2018, 1, 53, 'Limited',      'SUV',          '4WD', 9300),
(412,  2019, 1, 53, 'XLT',          'SUV',          '4WD', 9300);

-- ==========================================================================
-- CHEVY SILVERADO 1500 (MakeId=2, ModelId=6) — fill 2015-2016
-- ==========================================================================
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(413,  2015, 2, 6, 'LT',            'Crew Cab',     '4WD', 11200),
(414,  2016, 2, 6, 'LTZ',           'Crew Cab',     '4WD', 11200);

-- ==========================================================================
-- CHEVY COLORADO (MakeId=2, ModelId=7) — extend back to 2017
-- ==========================================================================
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(415,  2017, 2, 7, 'Z71',           'Crew Cab',     '4WD', 7000),
(416,  2018, 2, 7, 'LT',            'Crew Cab',     '4WD', 7000),
(417,  2019, 2, 7, 'ZR2',           'Crew Cab',     '4WD', 5000);

-- ==========================================================================
-- CHEVY TAHOE (MakeId=2, ModelId=8) — extend back to 2015
-- ==========================================================================
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(418,  2015, 2, 8, 'LT',            'SUV',          '4WD', 8600),
(419,  2016, 2, 8, 'LTZ',           'SUV',          '4WD', 8600),
(420,  2017, 2, 8, 'LT',            'SUV',          '4WD', 8600),
(421,  2018, 2, 8, 'Premier',       'SUV',          '4WD', 8600);

-- ==========================================================================
-- CHEVY EQUINOX (MakeId=2, ModelId=9) — extend back to 2018
-- ==========================================================================
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(422,  2018, 2, 9, 'LT',            'SUV',          'AWD', 1500),
(423,  2019, 2, 9, 'Premier',       'SUV',          'AWD', 1500),
(424,  2020, 2, 9, 'LT',            'SUV',          'AWD', 1500),
(425,  2021, 2, 9, 'RS',            'SUV',          'AWD', 1500);

-- ==========================================================================
-- CHEVY MALIBU (MakeId=2, ModelId=54) — extend back to 2016
-- ==========================================================================
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(426,  2016, 2, 54, 'LT',           'Sedan',        'FWD', 0),
(427,  2017, 2, 54, 'Premier',      'Sedan',        'FWD', 0),
(428,  2018, 2, 54, 'LT',           'Sedan',        'FWD', 0),
(429,  2019, 2, 54, 'RS',           'Sedan',        'FWD', 0);

-- ==========================================================================
-- CHEVY TRAVERSE (MakeId=2, ModelId=55) — extend back to 2018
-- ==========================================================================
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(430,  2018, 2, 55, 'LT',           'SUV',          'AWD', 5000),
(431,  2019, 2, 55, 'Premier',      'SUV',          'AWD', 5000);

-- ==========================================================================
-- TOYOTA TACOMA (MakeId=3, ModelId=10) — fill 2015-2016
-- ==========================================================================
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(432,  2015, 3, 10, 'TRD Sport',    'Crew Cab',     '4WD', 6500),
(433,  2016, 3, 10, 'SR5',          'Crew Cab',     '4WD', 6800);

-- ==========================================================================
-- TOYOTA TUNDRA (MakeId=3, ModelId=11) — extend back to 2015
-- ==========================================================================
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(434,  2015, 3, 11, 'SR5',          'Crew Cab',     '4WD', 10200),
(435,  2016, 3, 11, 'Limited',      'Crew Cab',     '4WD', 10200),
(436,  2017, 3, 11, 'SR5',          'Crew Cab',     '4WD', 10200),
(437,  2018, 3, 11, 'Platinum',     'Crew Cab',     '4WD', 10200);

-- ==========================================================================
-- TOYOTA 4RUNNER (MakeId=3, ModelId=12) — fill 2015-2017
-- ==========================================================================
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(438,  2015, 3, 12, 'Trail',        'SUV',          '4WD', 5000),
(439,  2016, 3, 12, 'SR5',          'SUV',          '4WD', 5000),
(440,  2017, 3, 12, 'TRD Off-Road', 'SUV',          '4WD', 5000);

-- ==========================================================================
-- TOYOTA CAMRY (MakeId=3, ModelId=43) — extend back to 2015
-- ==========================================================================
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(441,  2015, 3, 43, 'SE',           'Sedan',        'FWD', 0),
(442,  2016, 3, 43, 'XLE',          'Sedan',        'FWD', 0),
(443,  2017, 3, 43, 'SE',           'Sedan',        'FWD', 0);

-- ==========================================================================
-- TOYOTA COROLLA (MakeId=3, ModelId=44) — extend back to 2015
-- ==========================================================================
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(444,  2015, 3, 44, 'S',            'Sedan',        'FWD', 0),
(445,  2016, 3, 44, 'LE',           'Sedan',        'FWD', 0),
(446,  2017, 3, 44, 'SE',           'Sedan',        'FWD', 0),
(447,  2018, 3, 44, 'XSE',          'Sedan',        'FWD', 0);

-- ==========================================================================
-- TOYOTA RAV4 (MakeId=3, ModelId=13) — extend back to 2017
-- ==========================================================================
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(448,  2017, 3, 13, 'XLE',          'SUV',          'AWD', 1500),
(449,  2018, 3, 13, 'Adventure',    'SUV',          'AWD', 1500),
(450,  2019, 3, 13, 'XLE',          'SUV',          'AWD', 1500),
(451,  2020, 3, 13, 'TRD Off-Road', 'SUV',          'AWD', 1500);

-- ==========================================================================
-- TOYOTA HIGHLANDER (MakeId=3, ModelId=46) — extend back to 2015
-- ==========================================================================
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(452,  2015, 3, 46, 'XLE',          'SUV',          'AWD', 5000),
(453,  2016, 3, 46, 'Limited',      'SUV',          'AWD', 5000),
(454,  2017, 3, 46, 'SE',           'SUV',          'AWD', 5000),
(455,  2018, 3, 46, 'XLE',          'SUV',          'AWD', 5000);

-- ==========================================================================
-- TOYOTA SIENNA (MakeId=3, ModelId=45) — extend back to 2015
-- ==========================================================================
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(456,  2015, 3, 45, 'XLE',          'Minivan',      'AWD', 3500),
(457,  2016, 3, 45, 'SE',           'Minivan',      'FWD', 3500),
(458,  2017, 3, 45, 'Limited',      'Minivan',      'AWD', 3500),
(459,  2018, 3, 45, 'XLE',          'Minivan',      'AWD', 3500);

-- ==========================================================================
-- RAM 1500 (MakeId=4, ModelId=14) — extend back to 2015
-- ==========================================================================
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(460,  2015, 4, 14, 'Laramie',      'Crew Cab',     '4WD', 10620),
(461,  2016, 4, 14, 'Big Horn',     'Crew Cab',     '4WD', 10620),
(462,  2017, 4, 14, 'Rebel',        'Crew Cab',     '4WD', 10620);

-- ==========================================================================
-- RAM 2500 (MakeId=4, ModelId=15) — extend back to 2017
-- ==========================================================================
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(463,  2017, 4, 15, 'Laramie',      'Crew Cab',     '4WD', 17980),
(464,  2018, 4, 15, 'Tradesman',    'Crew Cab',     '4WD', 17980),
(465,  2019, 4, 15, 'Power Wagon',  'Crew Cab',     '4WD', 17980);

-- ==========================================================================
-- RAM 3500 (MakeId=4, ModelId=16) — extend back to 2019
-- ==========================================================================
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(466,  2019, 4, 16, 'Laramie',      'Crew Cab',     '4WD', 31210),
(467,  2020, 4, 16, 'Limited',      'Crew Cab',     '4WD', 31210),
(468,  2021, 4, 16, 'Tradesman',    'Crew Cab',     '4WD', 31210);

-- ==========================================================================
-- HONDA CIVIC (MakeId=5, ModelId=47) — extend back to 2015
-- ==========================================================================
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(469,  2015, 5, 47, 'EX',           'Sedan',        'FWD', 0),
(470,  2016, 5, 47, 'Touring',      'Sedan',        'FWD', 0),
(471,  2017, 5, 47, 'Si',           'Sedan',        'FWD', 0);

-- ==========================================================================
-- HONDA ACCORD (MakeId=5, ModelId=48) — extend back to 2015
-- ==========================================================================
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(472,  2015, 5, 48, 'EX-L',         'Sedan',        'FWD', 0),
(473,  2016, 5, 48, 'Sport',        'Sedan',        'FWD', 0),
(474,  2017, 5, 48, 'Touring',      'Sedan',        'FWD', 0);

-- ==========================================================================
-- HONDA CR-V (MakeId=5, ModelId=19) — extend back to 2017
-- ==========================================================================
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(475,  2017, 5, 19, 'EX',           'SUV',          'AWD', 1500),
(476,  2018, 5, 19, 'Touring',      'SUV',          'AWD', 1500),
(477,  2019, 5, 19, 'EX-L',         'SUV',          'AWD', 1500),
(478,  2020, 5, 19, 'EX',           'SUV',          'AWD', 1500),
(479,  2021, 5, 19, 'Touring',      'SUV',          'AWD', 1500);

-- ==========================================================================
-- HONDA PILOT (MakeId=5, ModelId=18) — extend back to 2016
-- ==========================================================================
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(480,  2016, 5, 18, 'EX-L',         'SUV',          'AWD', 5000),
(481,  2017, 5, 18, 'Touring',      'SUV',          'AWD', 5000),
(482,  2018, 5, 18, 'Elite',        'SUV',          'AWD', 5000),
(483,  2019, 5, 18, 'EX-L',         'SUV',          'AWD', 5000),
(484,  2020, 5, 18, 'Touring',      'SUV',          'AWD', 5000),
(485,  2021, 5, 18, 'TrailSport',   'SUV',          'AWD', 5000);

-- ==========================================================================
-- HONDA RIDGELINE (MakeId=5, ModelId=17) — extend back to 2017
-- ==========================================================================
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(486,  2017, 5, 17, 'RTL-T',        'Crew Cab',     'AWD', 5000),
(487,  2018, 5, 17, 'Sport',        'Crew Cab',     'AWD', 5000),
(488,  2019, 5, 17, 'RTL-E',        'Crew Cab',     'AWD', 5000);

-- ==========================================================================
-- HONDA HR-V (MakeId=5, ModelId=49) — extend back to 2019
-- ==========================================================================
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(489,  2019, 5, 49, 'Sport',        'SUV',          'AWD', 0),
(490,  2020, 5, 49, 'EX',           'SUV',          'AWD', 0),
(491,  2021, 5, 49, 'EX-L',         'SUV',          'AWD', 0);

-- ==========================================================================
-- JEEP WRANGLER (MakeId=6, ModelId=20) — extend back to 2015
-- ==========================================================================
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(492,  2015, 6, 20, 'Sport',        'SUV',          '4WD', 3500),
(493,  2016, 6, 20, 'Rubicon',      'SUV',          '4WD', 3500),
(494,  2017, 6, 20, 'Sahara',       'SUV',          '4WD', 3500),
(495,  2018, 6, 20, 'Rubicon',      'SUV',          '4WD', 3500);

-- ==========================================================================
-- JEEP GRAND CHEROKEE (MakeId=6, ModelId=22) — extend back to 2015
-- ==========================================================================
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(496,  2015, 6, 22, 'Limited',      'SUV',          '4WD', 7200),
(497,  2016, 6, 22, 'Overland',     'SUV',          '4WD', 7200),
(498,  2017, 6, 22, 'Trailhawk',    'SUV',          '4WD', 7200),
(499,  2018, 6, 22, 'Limited',      'SUV',          '4WD', 7200),
(500,  2019, 6, 22, 'Summit',       'SUV',          '4WD', 7200),
(501,  2020, 6, 22, 'Laredo',       'SUV',          '4WD', 7200),
(502,  2021, 6, 22, 'Limited',      'SUV',          '4WD', 7200);

-- ==========================================================================
-- JEEP CHEROKEE (MakeId=6, ModelId=65) — extend back to 2015
-- ==========================================================================
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(503,  2015, 6, 65, 'Trailhawk',    'SUV',          '4WD', 4500),
(504,  2016, 6, 65, 'Limited',      'SUV',          '4WD', 4500),
(505,  2017, 6, 65, 'Latitude',     'SUV',          '4WD', 4500),
(506,  2018, 6, 65, 'Overland',     'SUV',          '4WD', 4500),
(507,  2019, 6, 65, 'Trailhawk',    'SUV',          '4WD', 4500);

-- ==========================================================================
-- GMC SIERRA 1500 (MakeId=7, ModelId=23) — extend back to 2015
-- ==========================================================================
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(508,  2015, 7, 23, 'SLE',          'Crew Cab',     '4WD', 11200),
(509,  2016, 7, 23, 'SLT',          'Crew Cab',     '4WD', 11200),
(510,  2017, 7, 23, 'Denali',       'Crew Cab',     '4WD', 11200),
(511,  2018, 7, 23, 'SLT',          'Crew Cab',     '4WD', 11200),
(512,  2019, 7, 23, 'Elevation',    'Crew Cab',     '4WD', 11200);

-- ==========================================================================
-- GMC YUKON (MakeId=7, ModelId=25) — extend back to 2015
-- ==========================================================================
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(513,  2015, 7, 25, 'SLT',          'SUV',          '4WD', 8500),
(514,  2016, 7, 25, 'Denali',       'SUV',          '4WD', 8500),
(515,  2017, 7, 25, 'SLE',          'SUV',          '4WD', 8500),
(516,  2018, 7, 25, 'SLT',          'SUV',          '4WD', 8500),
(517,  2019, 7, 25, 'Denali',       'SUV',          '4WD', 8500),
(518,  2020, 7, 25, 'SLT',          'SUV',          '4WD', 8500),
(519,  2021, 7, 25, 'AT4',          'SUV',          '4WD', 8500);

-- ==========================================================================
-- NISSAN ROGUE (MakeId=8, ModelId=58) — extend back to 2017
-- ==========================================================================
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(520,  2017, 8, 58, 'SV',           'SUV',          'AWD', 1350),
(521,  2018, 8, 58, 'SL',           'SUV',          'AWD', 1350),
(522,  2019, 8, 58, 'SV',           'SUV',          'AWD', 1350);

-- ==========================================================================
-- NISSAN ALTIMA (MakeId=8, ModelId=59) — extend back to 2016
-- ==========================================================================
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(523,  2016, 8, 59, 'SV',           'Sedan',        'FWD', 0),
(524,  2017, 8, 59, 'SL',           'Sedan',        'FWD', 0),
(525,  2018, 8, 59, 'SR',           'Sedan',        'FWD', 0),
(526,  2019, 8, 59, 'Platinum',     'Sedan',        'AWD', 0);

-- ==========================================================================
-- NISSAN FRONTIER (MakeId=8, ModelId=26) — extend back to 2017
-- ==========================================================================
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(527,  2017, 8, 26, 'SV',           'Crew Cab',     '4WD', 6720),
(528,  2018, 8, 26, 'PRO-4X',       'Crew Cab',     '4WD', 6720),
(529,  2019, 8, 26, 'SV',           'Crew Cab',     '4WD', 6720),
(530,  2020, 8, 26, 'SV',           'Crew Cab',     '4WD', 6720),
(531,  2021, 8, 26, 'PRO-4X',       'Crew Cab',     '4WD', 6720);

-- ==========================================================================
-- NISSAN TITAN (MakeId=8, ModelId=27) — extend back to 2017
-- ==========================================================================
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(532,  2017, 8, 27, 'SV',           'Crew Cab',     '4WD', 9390),
(533,  2018, 8, 27, 'PRO-4X',       'Crew Cab',     '4WD', 9390),
(534,  2019, 8, 27, 'Platinum',     'Crew Cab',     '4WD', 9390);

-- ==========================================================================
-- NISSAN PATHFINDER (MakeId=8, ModelId=28) — extend back to 2017
-- ==========================================================================
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(535,  2017, 8, 28, 'SV',           'SUV',          '4WD', 6000),
(536,  2018, 8, 28, 'SL',           'SUV',          '4WD', 6000),
(537,  2019, 8, 28, 'Platinum',     'SUV',          '4WD', 6000),
(538,  2020, 8, 28, 'SV',           'SUV',          '4WD', 6000),
(539,  2021, 8, 28, 'SL',           'SUV',          '4WD', 6000),
(540,  2022, 8, 28, 'SV',           'SUV',          '4WD', 6000),
(541,  2023, 8, 28, 'Platinum',     'SUV',          '4WD', 6000);

-- ==========================================================================
-- HYUNDAI TUCSON (MakeId=9, ModelId=29) — extend back to 2016
-- ==========================================================================
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(542,  2016, 9, 29, 'SE',           'SUV',          'AWD', 1500),
(543,  2017, 9, 29, 'Limited',      'SUV',          'AWD', 1500),
(544,  2018, 9, 29, 'Sport',        'SUV',          'AWD', 1500),
(545,  2019, 9, 29, 'SEL',          'SUV',          'AWD', 1500),
(546,  2020, 9, 29, 'Limited',      'SUV',          'AWD', 2000),
(547,  2021, 9, 29, 'SEL',          'SUV',          'AWD', 2000),
(548,  2022, 9, 29, 'N Line',       'SUV',          'AWD', 2000),
(549,  2023, 9, 29, 'Limited',      'SUV',          'AWD', 2000),
(550,  2025, 9, 29, 'SEL',          'SUV',          'AWD', 2000);

-- ==========================================================================
-- HYUNDAI SANTA FE (MakeId=9, ModelId=61) — extend back to 2016
-- ==========================================================================
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(551,  2016, 9, 61, 'Sport',        'SUV',          'AWD', 5000),
(552,  2017, 9, 61, 'Limited',      'SUV',          'AWD', 5000),
(553,  2018, 9, 61, 'SE',           'SUV',          'AWD', 5000),
(554,  2019, 9, 61, 'Ultimate',     'SUV',          'AWD', 5000);

-- ==========================================================================
-- HYUNDAI ELANTRA (MakeId=9, ModelId=62) — extend back to 2017
-- ==========================================================================
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(555,  2017, 9, 62, 'SE',           'Sedan',        'FWD', 0),
(556,  2018, 9, 62, 'Sport',        'Sedan',        'FWD', 0),
(557,  2019, 9, 62, 'SEL',          'Sedan',        'FWD', 0),
(558,  2020, 9, 62, 'Limited',      'Sedan',        'FWD', 0);

-- ==========================================================================
-- HYUNDAI PALISADE (MakeId=9, ModelId=63) — already 2020-2025, good
-- HYUNDAI SANTA CRUZ (MakeId=9, ModelId=30) — already 2022-2024, new model
-- ==========================================================================

-- ==========================================================================
-- SUBARU OUTBACK (MakeId=10, ModelId=31) — extend back to 2015
-- ==========================================================================
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(559,  2015, 10, 31, 'Premium',     'Wagon',        'AWD', 2700),
(560,  2016, 10, 31, 'Limited',     'Wagon',        'AWD', 2700),
(561,  2017, 10, 31, 'Touring',     'Wagon',        'AWD', 2700),
(562,  2018, 10, 31, 'Premium',     'Wagon',        'AWD', 2700),
(563,  2019, 10, 31, 'Limited',     'Wagon',        'AWD', 2700),
(564,  2020, 10, 31, 'Onyx Edition','Wagon',        'AWD', 3500),
(565,  2021, 10, 31, 'Wilderness',  'Wagon',        'AWD', 3500);

-- ==========================================================================
-- SUBARU FORESTER (MakeId=10, ModelId=69) — extend back to 2015
-- ==========================================================================
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(566,  2015, 10, 69, 'Premium',     'SUV',          'AWD', 1500),
(567,  2016, 10, 69, 'Touring',     'SUV',          'AWD', 1500),
(568,  2017, 10, 69, 'XT Touring',  'SUV',          'AWD', 1500),
(569,  2018, 10, 69, 'Premium',     'SUV',          'AWD', 1500),
(570,  2019, 10, 69, 'Sport',       'SUV',          'AWD', 1500),
(571,  2020, 10, 69, 'Touring',     'SUV',          'AWD', 1500);

-- ==========================================================================
-- SUBARU CROSSTREK (MakeId=10, ModelId=32) — extend back to 2016
-- ==========================================================================
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(572,  2016, 10, 32, 'Premium',     'SUV',          'AWD', 1500),
(573,  2017, 10, 32, 'Limited',     'SUV',          'AWD', 1500),
(574,  2018, 10, 32, 'Premium',     'SUV',          'AWD', 1500),
(575,  2019, 10, 32, 'Limited',     'SUV',          'AWD', 1500),
(576,  2020, 10, 32, 'Sport',       'SUV',          'AWD', 1500),
(577,  2021, 10, 32, 'Limited',     'SUV',          'AWD', 1500),
(578,  2022, 10, 32, 'Sport',       'SUV',          'AWD', 1500),
(579,  2023, 10, 32, 'Wilderness',  'SUV',          'AWD', 3500),
(580,  2025, 10, 32, 'Sport',       'SUV',          'AWD', 3500);

-- ==========================================================================
-- SUBARU ASCENT (MakeId=10, ModelId=70) — extend back to 2019
-- ==========================================================================
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(581,  2019, 10, 70, 'Premium',     'SUV',          'AWD', 5000),
(582,  2020, 10, 70, 'Touring',     'SUV',          'AWD', 5000),
(583,  2021, 10, 70, 'Limited',     'SUV',          'AWD', 5000);

-- ==========================================================================
-- BMW X5 (MakeId=11, ModelId=33) — extend back to 2018
-- ==========================================================================
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(584,  2018, 11, 33, 'xDrive40i',   'SUV',          'AWD', 7200),
(585,  2019, 11, 33, 'xDrive50i',   'SUV',          'AWD', 7200),
(586,  2020, 11, 33, 'M50i',        'SUV',          'AWD', 7200),
(587,  2022, 11, 33, 'xDrive40i',   'SUV',          'AWD', 7200),
(588,  2023, 11, 33, 'xDrive45e',   'SUV',          'AWD', 7200),
(589,  2025, 11, 33, 'xDrive40i',   'SUV',          'AWD', 7200);

-- ==========================================================================
-- BMW X3 (MakeId=11, ModelId=34) — extend back to 2018
-- ==========================================================================
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(590,  2018, 11, 34, 'xDrive30i',   'SUV',          'AWD', 4400),
(591,  2019, 11, 34, 'M40i',        'SUV',          'AWD', 4400),
(592,  2020, 11, 34, 'xDrive30i',   'SUV',          'AWD', 4400),
(593,  2021, 11, 34, 'xDrive30i',   'SUV',          'AWD', 4400),
(594,  2022, 11, 34, 'M40i',        'SUV',          'AWD', 4400),
(595,  2023, 11, 34, 'xDrive30i',   'SUV',          'AWD', 4400),
(596,  2025, 11, 34, 'xDrive30i',   'SUV',          'AWD', 4400);

-- ==========================================================================
-- MERCEDES GLE (MakeId=12, ModelId=35) — extend back to 2020
-- ==========================================================================
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(597,  2020, 12, 35, 'GLE 350',     'SUV',          'AWD', 7700),
(598,  2021, 12, 35, 'GLE 450',     'SUV',          'AWD', 7700),
(599,  2023, 12, 35, 'GLE 350',     'SUV',          'AWD', 7700),
(600,  2025, 12, 35, 'AMG GLE 53',  'SUV',          'AWD', 7700);

-- ==========================================================================
-- MERCEDES GLC (MakeId=12, ModelId=36) — extend back to 2020
-- ==========================================================================
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(601,  2020, 12, 36, 'GLC 300',     'SUV',          'AWD', 4400),
(602,  2021, 12, 36, 'AMG GLC 43',  'SUV',          'AWD', 4400),
(603,  2022, 12, 36, 'GLC 300',     'SUV',          'AWD', 4400),
(604,  2023, 12, 36, 'GLC 300',     'SUV',          'AWD', 4400),
(605,  2025, 12, 36, 'GLC 300',     'SUV',          'AWD', 4400);

-- ==========================================================================
-- VW ATLAS (MakeId=13, ModelId=37) — extend back to 2018
-- ==========================================================================
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(606,  2018, 13, 37, 'SE',          'SUV',          'AWD', 5000),
(607,  2019, 13, 37, 'SEL',         'SUV',          'AWD', 5000),
(608,  2020, 13, 37, 'SE',          'SUV',          'AWD', 5000),
(609,  2021, 13, 37, 'SEL Premium', 'SUV',          'AWD', 5000),
(610,  2025, 13, 37, 'SE',          'SUV',          'AWD', 5000);

-- ==========================================================================
-- VW TIGUAN (MakeId=13, ModelId=38) — extend back to 2018
-- ==========================================================================
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(611,  2018, 13, 38, 'SE',          'SUV',          'AWD', 1500),
(612,  2019, 13, 38, 'SEL',         'SUV',          'AWD', 1500),
(613,  2020, 13, 38, 'SE',          'SUV',          'AWD', 1500),
(614,  2021, 13, 38, 'SE R-Line',   'SUV',          'AWD', 1500),
(615,  2022, 13, 38, 'SE',          'SUV',          'AWD', 1500),
(616,  2023, 13, 38, 'SEL',         'SUV',          'AWD', 1500),
(617,  2025, 13, 38, 'SE',          'SUV',          'AWD', 1500);

-- ==========================================================================
-- KIA TELLURIDE (MakeId=16, ModelId=71) — extend back to 2019 (launch year)
-- ==========================================================================
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(618,  2019, 16, 71, 'EX',          'SUV',          'AWD', 5000);

-- ==========================================================================
-- KIA SORENTO (MakeId=16, ModelId=72) — extend back to 2016
-- ==========================================================================
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(619,  2016, 16, 72, 'EX',          'SUV',          'AWD', 5000),
(620,  2017, 16, 72, 'SX',          'SUV',          'AWD', 5000),
(621,  2018, 16, 72, 'EX',          'SUV',          'AWD', 5000),
(622,  2019, 16, 72, 'SX Limited',  'SUV',          'AWD', 5000),
(623,  2020, 16, 72, 'EX',          'SUV',          'AWD', 5000);

-- ==========================================================================
-- KIA SPORTAGE (MakeId=16, ModelId=73) — extend back to 2017
-- ==========================================================================
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(624,  2017, 16, 73, 'EX',          'SUV',          'AWD', 2000),
(625,  2018, 16, 73, 'SX Turbo',    'SUV',          'AWD', 2000),
(626,  2019, 16, 73, 'EX',          'SUV',          'AWD', 2000),
(627,  2020, 16, 73, 'S',           'SUV',          'AWD', 2000),
(628,  2021, 16, 73, 'EX',          'SUV',          'AWD', 2000);

-- ==========================================================================
-- MAZDA CX-5 (MakeId=17, ModelId=75) — extend back to 2017
-- ==========================================================================
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(629,  2017, 17, 75, 'Grand Touring','SUV',         'AWD', 2000),
(630,  2018, 17, 75, 'Touring',     'SUV',          'AWD', 2000),
(631,  2019, 17, 75, 'Signature',   'SUV',          'AWD', 2000),
(632,  2020, 17, 75, 'Grand Touring','SUV',         'AWD', 2000);

-- ==========================================================================
-- DODGE DURANGO (MakeId=18, ModelId=79) — extend back to 2015
-- ==========================================================================
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(633,  2015, 18, 79, 'Limited',     'SUV',          'AWD', 7400),
(634,  2016, 18, 79, 'R/T',         'SUV',          'AWD', 7400),
(635,  2017, 18, 79, 'GT',          'SUV',          'AWD', 7400),
(636,  2018, 18, 79, 'SRT',         'SUV',          'AWD', 8700),
(637,  2019, 18, 79, 'R/T',         'SUV',          'AWD', 7400),
(638,  2020, 18, 79, 'Citadel',     'SUV',          'AWD', 7400);

-- ==========================================================================
-- DODGE CHARGER (MakeId=18, ModelId=80) — extend back to 2015
-- ==========================================================================
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(639,  2015, 18, 80, 'R/T',         'Sedan',        'RWD', 0),
(640,  2016, 18, 80, 'SXT',         'Sedan',        'RWD', 0),
(641,  2017, 18, 80, 'Daytona',     'Sedan',        'RWD', 0),
(642,  2018, 18, 80, 'R/T',         'Sedan',        'RWD', 0),
(643,  2019, 18, 80, 'Scat Pack',   'Sedan',        'RWD', 0),
(644,  2020, 18, 80, 'GT',          'Sedan',        'AWD', 0);

SET IDENTITY_INSERT Vehicles OFF;
