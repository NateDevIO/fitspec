-- ============================================================================
-- FitSpec Seed Data: Models
-- ~40 models across 15 makes — trucks, SUVs, crossovers, sedans, EVs
-- ============================================================================

SET IDENTITY_INSERT Models ON;

INSERT INTO Models (Id, MakeId, Name, Slug) VALUES
-- Ford (MakeId=1): 5 models
(1,  1, 'F-150',       'f-150'),
(2,  1, 'Ranger',      'ranger'),
(3,  1, 'Explorer',    'explorer'),
(4,  1, 'Bronco',      'bronco'),
(5,  1, 'Maverick',    'maverick'),

-- Chevrolet (MakeId=2): 4 models
(6,  2, 'Silverado 1500', 'silverado-1500'),
(7,  2, 'Colorado',       'colorado'),
(8,  2, 'Tahoe',          'tahoe'),
(9,  2, 'Equinox',        'equinox'),

-- Toyota (MakeId=3): 4 models
(10, 3, 'Tacoma',   'tacoma'),
(11, 3, 'Tundra',   'tundra'),
(12, 3, '4Runner',  '4runner'),
(13, 3, 'RAV4',     'rav4'),

-- RAM (MakeId=4): 3 models
(14, 4, '1500', '1500'),
(15, 4, '2500', '2500'),
(16, 4, '3500', '3500'),

-- Honda (MakeId=5): 3 models
(17, 5, 'Ridgeline', 'ridgeline'),
(18, 5, 'Pilot',     'pilot'),
(19, 5, 'CR-V',      'cr-v'),

-- Jeep (MakeId=6): 3 models
(20, 6, 'Wrangler',        'wrangler'),
(21, 6, 'Gladiator',       'gladiator'),
(22, 6, 'Grand Cherokee',  'grand-cherokee'),

-- GMC (MakeId=7): 3 models
(23, 7, 'Sierra 1500', 'sierra-1500'),
(24, 7, 'Canyon',      'canyon'),
(25, 7, 'Yukon',       'yukon'),

-- Nissan (MakeId=8): 3 models
(26, 8, 'Frontier',   'frontier'),
(27, 8, 'Titan',      'titan'),
(28, 8, 'Pathfinder', 'pathfinder'),

-- Hyundai (MakeId=9): 2 models
(29, 9, 'Tucson',     'tucson'),
(30, 9, 'Santa Cruz', 'santa-cruz'),

-- Subaru (MakeId=10): 2 models
(31, 10, 'Outback',    'outback'),
(32, 10, 'Crosstrek',  'crosstrek'),

-- BMW (MakeId=11): 2 models
(33, 11, 'X5',  'x5'),
(34, 11, 'X3',  'x3'),

-- Mercedes-Benz (MakeId=12): 2 models
(35, 12, 'GLE', 'gle'),
(36, 12, 'GLC', 'glc'),

-- Volkswagen (MakeId=13): 2 models
(37, 13, 'Atlas',    'atlas'),
(38, 13, 'Tiguan',   'tiguan'),

-- Tesla (MakeId=14): 2 models
(39, 14, 'Cybertruck', 'cybertruck'),
(40, 14, 'Model Y',    'model-y'),

-- Rivian (MakeId=15): 2 models
(41, 15, 'R1T', 'r1t'),
(42, 15, 'R1S', 'r1s');

SET IDENTITY_INSERT Models OFF;
