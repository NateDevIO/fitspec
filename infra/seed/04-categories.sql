-- ============================================================================
-- FitSpec Seed Data: Categories
-- 4 parent categories + 16 subcategories (20 total)
-- ============================================================================

SET IDENTITY_INSERT Categories ON;

-- Parent Categories
INSERT INTO Categories (Id, Name, Slug, Icon, ParentCategoryId, SortOrder) VALUES
(1, 'Towing',          'towing',         'local_shipping', NULL, 1),
(2, 'Exterior',        'exterior',       'directions_car',  NULL, 2),
(3, 'Lighting',        'lighting',       'lightbulb',       NULL, 3),
(4, 'Cargo & Utility', 'cargo-utility',  'inventory_2',     NULL, 4);

-- Towing Subcategories (ParentCategoryId = 1)
INSERT INTO Categories (Id, Name, Slug, Icon, ParentCategoryId, SortOrder) VALUES
(5,  'Trailer Hitches',    'trailer-hitches',    'tow',           1, 1),
(6,  'Wiring Harnesses',   'wiring-harnesses',   'cable',         1, 2),
(7,  'Ball Mounts',        'ball-mounts',         'sports_soccer', 1, 3),
(8,  'Brake Controllers',  'brake-controllers',   'speed',         1, 4);

-- Exterior Subcategories (ParentCategoryId = 2)
INSERT INTO Categories (Id, Name, Slug, Icon, ParentCategoryId, SortOrder) VALUES
(9,  'Running Boards',  'running-boards',  'stairs',      2, 1),
(10, 'Fender Flares',   'fender-flares',   'shield',      2, 2),
(11, 'Mud Flaps',       'mud-flaps',        'water_drop',  2, 3),
(12, 'Grille Guards',   'grille-guards',    'security',    2, 4);

-- Lighting Subcategories (ParentCategoryId = 3)
INSERT INTO Categories (Id, Name, Slug, Icon, ParentCategoryId, SortOrder) VALUES
(13, 'Headlights',  'headlights',  'highlight',    3, 1),
(14, 'Tail Lights', 'tail-lights', 'wb_twilight',  3, 2),
(15, 'Light Bars',  'light-bars',  'fluorescent',  3, 3),
(16, 'Fog Lights',  'fog-lights',  'foggy',        3, 4);

-- Cargo & Utility Subcategories (ParentCategoryId = 4)
INSERT INTO Categories (Id, Name, Slug, Icon, ParentCategoryId, SortOrder) VALUES
(17, 'Bed Liners',       'bed-liners',       'crop_landscape', 4, 1),
(18, 'Tonneau Covers',   'tonneau-covers',   'roofing',        4, 2),
(19, 'Roof Racks',       'roof-racks',        'luggage',        4, 3),
(20, 'Bed Accessories',  'bed-accessories',   'handyman',       4, 4);

SET IDENTITY_INSERT Categories OFF;
