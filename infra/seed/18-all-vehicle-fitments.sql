-- ============================================================================
-- FitSpec Seed #18: Generate fitment mappings for ALL vehicles
-- Targets any vehicle that is missing fitments, regardless of ID range.
-- Uses INSERT ... WHERE NOT EXISTS to avoid duplicates.
-- Category-to-vehicle logic matches scripts 09 and 11.
-- ============================================================================

-- ============================================================================
-- HEADLIGHTS (Cat 13) → ALL vehicles
-- ============================================================================
INSERT INTO FitmentMappings (ProductId, VehicleId, IsVerified, InstallDifficulty, FitmentNotes)
SELECT p.Id, v.Id, 1, ABS(CHECKSUM(NEWID())) % 2 + 2,
  'Direct replacement - plug and play with factory wiring'
FROM Products p
CROSS JOIN Vehicles v
WHERE p.CategoryId = 13
  AND NOT EXISTS (SELECT 1 FROM FitmentMappings fm WHERE fm.ProductId = p.Id AND fm.VehicleId = v.Id);

-- ============================================================================
-- TAIL LIGHTS (Cat 14) → ALL vehicles
-- ============================================================================
INSERT INTO FitmentMappings (ProductId, VehicleId, IsVerified, InstallDifficulty, FitmentNotes)
SELECT p.Id, v.Id, 1, ABS(CHECKSUM(NEWID())) % 2 + 1,
  'LED upgrade - direct factory replacement'
FROM Products p
CROSS JOIN Vehicles v
WHERE p.CategoryId = 14
  AND NOT EXISTS (SELECT 1 FROM FitmentMappings fm WHERE fm.ProductId = p.Id AND fm.VehicleId = v.Id);

-- ============================================================================
-- FOG LIGHTS (Cat 16) → ALL vehicles except Coupes
-- ============================================================================
INSERT INTO FitmentMappings (ProductId, VehicleId, IsVerified, InstallDifficulty, FitmentNotes)
SELECT p.Id, v.Id, 1, ABS(CHECKSUM(NEWID())) % 2 + 2,
  'OEM replacement fog light assembly'
FROM Products p
CROSS JOIN Vehicles v
WHERE p.CategoryId = 16
  AND v.BodyStyle <> 'Coupe'
  AND NOT EXISTS (SELECT 1 FROM FitmentMappings fm WHERE fm.ProductId = p.Id AND fm.VehicleId = v.Id);

-- ============================================================================
-- MUD FLAPS (Cat 11) → ALL vehicles
-- ============================================================================
INSERT INTO FitmentMappings (ProductId, VehicleId, IsVerified, InstallDifficulty, FitmentNotes)
SELECT p.Id, v.Id, 1, 1, 'Custom-molded for vehicle - no-drill install'
FROM Products p
CROSS JOIN Vehicles v
WHERE p.CategoryId = 11
  AND NOT EXISTS (SELECT 1 FROM FitmentMappings fm WHERE fm.ProductId = p.Id AND fm.VehicleId = v.Id);

-- ============================================================================
-- RUNNING BOARDS (Cat 9) → SUVs, Minivans, Trucks (not Sedans/Coupes)
-- ============================================================================
INSERT INTO FitmentMappings (ProductId, VehicleId, IsVerified, InstallDifficulty, FitmentNotes)
SELECT p.Id, v.Id, 1, ABS(CHECKSUM(NEWID())) % 2 + 2,
  CASE WHEN v.BodyStyle = 'Minivan' THEN 'Minivan-length running boards'
       ELSE 'Vehicle-specific brackets included' END
FROM Products p
CROSS JOIN Vehicles v
WHERE p.CategoryId = 9
  AND v.BodyStyle IN ('SUV', 'Minivan', 'Crew Cab')
  AND NOT EXISTS (SELECT 1 FROM FitmentMappings fm WHERE fm.ProductId = p.Id AND fm.VehicleId = v.Id);

-- ============================================================================
-- ROOF RACKS (Cat 19) → SUVs, Minivans, Trucks
-- ============================================================================
INSERT INTO FitmentMappings (ProductId, VehicleId, IsVerified, InstallDifficulty, FitmentNotes)
SELECT p.Id, v.Id, 1, ABS(CHECKSUM(NEWID())) % 2 + 2,
  CASE WHEN v.BodyStyle = 'SUV' THEN 'Factory roof rail mount'
       WHEN v.BodyStyle = 'Minivan' THEN 'Roof rail mount for minivan'
       ELSE 'Cab-mount rack system' END
FROM Products p
CROSS JOIN Vehicles v
WHERE p.CategoryId = 19
  AND v.BodyStyle IN ('SUV', 'Minivan', 'Crew Cab')
  AND NOT EXISTS (SELECT 1 FROM FitmentMappings fm WHERE fm.ProductId = p.Id AND fm.VehicleId = v.Id);

-- ============================================================================
-- TRAILER HITCHES (Cat 5) → Tow-capable vehicles (TowCapacityLbs > 0)
-- ============================================================================
INSERT INTO FitmentMappings (ProductId, VehicleId, IsVerified, InstallDifficulty, FitmentNotes)
SELECT p.Id, v.Id, 1, ABS(CHECKSUM(NEWID())) % 3 + 2,
  CASE WHEN v.TowCapacityLbs > 5000 THEN 'Heavy-duty receiver hitch'
       ELSE 'Class I/II receiver hitch' END
FROM Products p
CROSS JOIN Vehicles v
WHERE p.CategoryId = 5
  AND v.TowCapacityLbs > 0
  AND NOT EXISTS (SELECT 1 FROM FitmentMappings fm WHERE fm.ProductId = p.Id AND fm.VehicleId = v.Id);

-- ============================================================================
-- WIRING HARNESSES (Cat 6) → Tow-capable vehicles
-- ============================================================================
INSERT INTO FitmentMappings (ProductId, VehicleId, IsVerified, InstallDifficulty, FitmentNotes)
SELECT p.Id, v.Id, 1, ABS(CHECKSUM(NEWID())) % 2 + 2,
  'Vehicle-specific wiring connector included'
FROM Products p
CROSS JOIN Vehicles v
WHERE p.CategoryId = 6
  AND v.TowCapacityLbs > 0
  AND NOT EXISTS (SELECT 1 FROM FitmentMappings fm WHERE fm.ProductId = p.Id AND fm.VehicleId = v.Id);

-- ============================================================================
-- BALL MOUNTS (Cat 7) → Tow-capable vehicles
-- ============================================================================
INSERT INTO FitmentMappings (ProductId, VehicleId, IsVerified, InstallDifficulty, FitmentNotes)
SELECT p.Id, v.Id, 1, 1, 'Universal ball mount - verify drop/rise for vehicle'
FROM Products p
CROSS JOIN Vehicles v
WHERE p.CategoryId = 7
  AND v.TowCapacityLbs > 0
  AND NOT EXISTS (SELECT 1 FROM FitmentMappings fm WHERE fm.ProductId = p.Id AND fm.VehicleId = v.Id);

-- ============================================================================
-- BRAKE CONTROLLERS (Cat 8) → Heavy tow (>= 3000 lbs)
-- ============================================================================
INSERT INTO FitmentMappings (ProductId, VehicleId, IsVerified, InstallDifficulty, FitmentNotes)
SELECT p.Id, v.Id, 1, ABS(CHECKSUM(NEWID())) % 2 + 2,
  'Plug-and-play brake controller adapter'
FROM Products p
CROSS JOIN Vehicles v
WHERE p.CategoryId = 8
  AND v.TowCapacityLbs >= 3000
  AND NOT EXISTS (SELECT 1 FROM FitmentMappings fm WHERE fm.ProductId = p.Id AND fm.VehicleId = v.Id);

-- ============================================================================
-- FENDER FLARES (Cat 10) → Trucks + AWD/4WD SUVs
-- ============================================================================
INSERT INTO FitmentMappings (ProductId, VehicleId, IsVerified, InstallDifficulty, FitmentNotes)
SELECT p.Id, v.Id, 1, ABS(CHECKSUM(NEWID())) % 2 + 3,
  'Paintable ABS - matches factory fender lines'
FROM Products p
CROSS JOIN Vehicles v
WHERE p.CategoryId = 10
  AND v.BodyStyle IN ('Crew Cab', 'SUV')
  AND v.DriveType IN ('4WD', 'AWD')
  AND NOT EXISTS (SELECT 1 FROM FitmentMappings fm WHERE fm.ProductId = p.Id AND fm.VehicleId = v.Id);

-- ============================================================================
-- GRILLE GUARDS (Cat 12) → Trucks + SUVs with towing capability
-- ============================================================================
INSERT INTO FitmentMappings (ProductId, VehicleId, IsVerified, InstallDifficulty, FitmentNotes)
SELECT p.Id, v.Id, 1, ABS(CHECKSUM(NEWID())) % 2 + 3,
  'Heavy-duty steel construction - includes mounting hardware'
FROM Products p
CROSS JOIN Vehicles v
WHERE p.CategoryId = 12
  AND v.BodyStyle IN ('Crew Cab', 'SUV')
  AND v.TowCapacityLbs >= 2000
  AND NOT EXISTS (SELECT 1 FROM FitmentMappings fm WHERE fm.ProductId = p.Id AND fm.VehicleId = v.Id);

-- ============================================================================
-- LIGHT BARS (Cat 15) → Trucks + AWD/4WD SUVs
-- ============================================================================
INSERT INTO FitmentMappings (ProductId, VehicleId, IsVerified, InstallDifficulty, FitmentNotes)
SELECT p.Id, v.Id, 1, ABS(CHECKSUM(NEWID())) % 2 + 3,
  'Roof mount or bumper mount - hardware included'
FROM Products p
CROSS JOIN Vehicles v
WHERE p.CategoryId = 15
  AND v.BodyStyle IN ('Crew Cab', 'SUV')
  AND v.DriveType IN ('4WD', 'AWD')
  AND NOT EXISTS (SELECT 1 FROM FitmentMappings fm WHERE fm.ProductId = p.Id AND fm.VehicleId = v.Id);

-- ============================================================================
-- BED LINERS (Cat 17) → Trucks only
-- ============================================================================
INSERT INTO FitmentMappings (ProductId, VehicleId, IsVerified, InstallDifficulty, FitmentNotes)
SELECT p.Id, v.Id, 1, 1, 'Custom-molded to truck bed dimensions'
FROM Products p
CROSS JOIN Vehicles v
WHERE p.CategoryId = 17
  AND v.BodyStyle = 'Crew Cab'
  AND NOT EXISTS (SELECT 1 FROM FitmentMappings fm WHERE fm.ProductId = p.Id AND fm.VehicleId = v.Id);

-- ============================================================================
-- TONNEAU COVERS (Cat 18) → Trucks only
-- ============================================================================
INSERT INTO FitmentMappings (ProductId, VehicleId, IsVerified, InstallDifficulty, FitmentNotes)
SELECT p.Id, v.Id, 1, ABS(CHECKSUM(NEWID())) % 2 + 1,
  'Custom fit for bed length - clamp-on install'
FROM Products p
CROSS JOIN Vehicles v
WHERE p.CategoryId = 18
  AND v.BodyStyle = 'Crew Cab'
  AND NOT EXISTS (SELECT 1 FROM FitmentMappings fm WHERE fm.ProductId = p.Id AND fm.VehicleId = v.Id);

-- ============================================================================
-- BED ACCESSORIES (Cat 20) → Trucks only
-- ============================================================================
INSERT INTO FitmentMappings (ProductId, VehicleId, IsVerified, InstallDifficulty, FitmentNotes)
SELECT p.Id, v.Id, 1, 1, 'Universal truck bed accessory'
FROM Products p
CROSS JOIN Vehicles v
WHERE p.CategoryId = 20
  AND v.BodyStyle = 'Crew Cab'
  AND NOT EXISTS (SELECT 1 FROM FitmentMappings fm WHERE fm.ProductId = p.Id AND fm.VehicleId = v.Id);

-- ============================================================================
-- Randomize IsVerified (about 33% unverified, matching local pattern)
-- ============================================================================
UPDATE FitmentMappings SET IsVerified = 0 WHERE Id % 3 = 0;

-- ============================================================================
-- Summary
-- ============================================================================
SELECT COUNT(*) AS TotalFitmentMappings FROM FitmentMappings;
SELECT COUNT(*) AS TotalVehicles FROM Vehicles;
SELECT COUNT(DISTINCT VehicleId) AS VehiclesWithFitments FROM FitmentMappings;
