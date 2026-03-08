-- ============================================================================
-- FitSpec Seed Data: Makes
-- 15 automotive makes covering domestic, import, luxury, and EV segments
-- ============================================================================

SET IDENTITY_INSERT Makes ON;

INSERT INTO Makes (Id, Name, Slug, LogoUrl) VALUES
(1,  'Ford',          'ford',          NULL),
(2,  'Chevrolet',     'chevrolet',     NULL),
(3,  'Toyota',        'toyota',        NULL),
(4,  'RAM',           'ram',           NULL),
(5,  'Honda',         'honda',         NULL),
(6,  'Jeep',          'jeep',          NULL),
(7,  'GMC',           'gmc',           NULL),
(8,  'Nissan',        'nissan',        NULL),
(9,  'Hyundai',       'hyundai',       NULL),
(10, 'Subaru',        'subaru',        NULL),
(11, 'BMW',           'bmw',           NULL),
(12, 'Mercedes-Benz', 'mercedes-benz', NULL),
(13, 'Volkswagen',    'volkswagen',    NULL),
(14, 'Tesla',         'tesla',         NULL),
(15, 'Rivian',        'rivian',        NULL);

SET IDENTITY_INSERT Makes OFF;
