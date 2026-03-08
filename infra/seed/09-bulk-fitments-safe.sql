-- ============================================================================
-- FitSpec Bulk Fitments: Safe INSERT with duplicate avoidance
-- Uses INSERT ... WHERE NOT EXISTS to skip any existing combos
-- Targets: ALL 150 products × relevant vehicles from the 164 total
-- ============================================================================

-- Helper: Insert fitment only if not already present
-- We'll use a series of INSERT ... SELECT ... WHERE NOT EXISTS

-- ============================================================================
-- TRUCKS (Crew Cab) - Vehicles: 1-12,21-24,36-42,50-53,60-61,69,74-75,
--   81-84,101-102,104-105,108-113,116-121,122-130,137-140,141-143,
--   151-152,155-160,163-164
-- SUVs - Vehicles: 13-20,25-35,43-49,54-59,62-68,70-73,76-80,85-100,
--   103,106-107,114-115,131-136,144-150,153-154,161-162
-- ============================================================================

-- Truck vehicle IDs (all Crew Cab/Trucks)
-- Ford F-150: 1,2,3,4,5,108,109,110,111
-- Ford Ranger: 6,7,112,113
-- Chevy Silverado: 21,22,23,116,117,118,119
-- Chevy Colorado: 24,120,121
-- Toyota Tacoma: 36,37,38,39,122,123,124,125,126,127
-- Toyota Tundra: 40,41,42,128,129,130
-- RAM 1500: 50,51,52,53,137,138,139,140
-- Honda Ridgeline: 60,61,141,142,143
-- Jeep Gladiator: 69,151,152
-- GMC Sierra: 74,75,155,156,157
-- Nissan Frontier: 81,82,158,159
-- Nissan Titan: 83,84,160
-- Tesla Cybertruck: 101,102,163
-- Rivian R1T: 104,105,164

-- SUV vehicle IDs
-- Ford Bronco: 8,9,114,115
-- Ford Explorer: 10
-- Chevy Tahoe: 25,26
-- Chevy Trailblazer: 27
-- Toyota 4Runner: 43,44,45,131,132,133
-- Toyota RAV4: 46,47,134,135,136
-- Toyota Highlander: 48,49
-- RAM 1500 (some): --
-- Honda Pilot: 62,63,144,145
-- Honda CR-V: 64,65,146,147
-- Jeep Wrangler: 66,67,68,148,149,150
-- Jeep Grand Cherokee: 70,71,72,73,153,154
-- GMC Yukon: 76,77
-- Nissan Pathfinder: 85,86
-- Subaru Forester: 87,88
-- Subaru Outback: 89,90,161,162
-- Hyundai Tucson: 91,92
-- Hyundai Santa Fe: 93,94
-- Kia Telluride: 95,96
-- Mercedes GLC: 97
-- VW Atlas: 98,99
-- VW Tiguan: 100
-- Tesla Model Y: 103
-- Rivian R1S: 106,107

-- ============================================================================
-- CATEGORY: Trailer Hitches (Products 1-12) → Trucks + large SUVs
-- ============================================================================
INSERT INTO FitmentMappings (ProductId, VehicleId, IsVerified, InstallDifficulty, FitmentNotes)
SELECT p.Id, v.Id, 1, ABS(CHECKSUM(NEWID())) % 3 + 2,
  CASE WHEN v.BodyStyle = 'SUV' THEN 'Custom bracket may be required for SUV' ELSE 'Direct bolt-on for truck frame' END
FROM Products p
CROSS JOIN Vehicles v
WHERE p.CategoryId = 5
  AND v.Id IN (1,2,3,4,5,6,7,21,22,23,24,36,37,38,39,40,41,42,50,51,52,53,60,61,69,74,75,81,82,83,84,
               101,102,104,105,108,109,110,111,112,113,116,117,118,119,120,121,122,123,124,125,126,127,
               128,129,130,137,138,139,140,141,142,143,151,152,155,156,157,158,159,160,163,164,
               8,9,25,26,43,44,45,48,49,66,67,68,70,71,72,73,76,77,85,86,89,90,95,96,98,99,
               114,115,131,132,133,148,149,150,153,154,161,162)
  AND NOT EXISTS (
    SELECT 1 FROM FitmentMappings fm WHERE fm.ProductId = p.Id AND fm.VehicleId = v.Id
  );

-- ============================================================================
-- CATEGORY: Wiring Harnesses (Products 13-22) → Same as hitches
-- ============================================================================
INSERT INTO FitmentMappings (ProductId, VehicleId, IsVerified, InstallDifficulty, FitmentNotes)
SELECT p.Id, v.Id, 1, ABS(CHECKSUM(NEWID())) % 2 + 2,
  'Vehicle-specific wiring connector included'
FROM Products p
CROSS JOIN Vehicles v
WHERE p.CategoryId = 6
  AND v.Id IN (1,2,3,4,5,6,7,21,22,23,24,36,37,38,39,40,41,42,50,51,52,53,60,61,69,74,75,81,82,83,84,
               101,102,104,105,108,109,110,111,112,113,116,117,118,119,120,121,122,123,124,125,126,127,
               128,129,130,137,138,139,140,141,142,143,151,152,155,156,157,158,159,160,163,164,
               8,9,25,26,43,44,45,48,49,66,67,68,70,71,72,73,76,77,85,86,89,90,95,96,
               114,115,131,132,133,148,149,150,153,154,161,162)
  AND NOT EXISTS (
    SELECT 1 FROM FitmentMappings fm WHERE fm.ProductId = p.Id AND fm.VehicleId = v.Id
  );

-- ============================================================================
-- CATEGORY: Ball Mounts (Products 23-31) → Trucks + towing SUVs
-- ============================================================================
INSERT INTO FitmentMappings (ProductId, VehicleId, IsVerified, InstallDifficulty, FitmentNotes)
SELECT p.Id, v.Id, 1, 1, 'Universal ball mount - verify drop/rise for vehicle'
FROM Products p
CROSS JOIN Vehicles v
WHERE p.CategoryId = 7
  AND v.Id IN (1,2,3,4,5,6,7,21,22,23,24,36,37,38,39,40,41,42,50,51,52,53,60,61,69,74,75,81,82,83,84,
               101,102,104,105,108,109,110,111,112,113,116,117,118,119,120,121,122,123,124,125,126,127,
               128,129,130,137,138,139,140,141,142,143,151,152,155,156,157,158,159,160,163,164,
               25,26,43,44,45,48,49,70,71,72,73,76,77,85,86,95,96,
               131,132,133,153,154)
  AND NOT EXISTS (
    SELECT 1 FROM FitmentMappings fm WHERE fm.ProductId = p.Id AND fm.VehicleId = v.Id
  );

-- ============================================================================
-- CATEGORY: Brake Controllers (Products 32-40) → Trucks + towing SUVs
-- ============================================================================
INSERT INTO FitmentMappings (ProductId, VehicleId, IsVerified, InstallDifficulty, FitmentNotes)
SELECT p.Id, v.Id, 1, ABS(CHECKSUM(NEWID())) % 2 + 2,
  'Plug-and-play brake controller adapter included'
FROM Products p
CROSS JOIN Vehicles v
WHERE p.CategoryId = 8
  AND v.Id IN (1,2,3,4,5,6,7,21,22,23,24,40,41,42,50,51,52,53,74,75,83,84,
               101,102,104,105,108,109,110,111,116,117,118,119,128,129,130,
               137,138,139,140,155,156,157,160,163,164,
               25,26,48,49,70,71,72,73,76,77,95,96,153,154)
  AND NOT EXISTS (
    SELECT 1 FROM FitmentMappings fm WHERE fm.ProductId = p.Id AND fm.VehicleId = v.Id
  );

-- ============================================================================
-- CATEGORY: Running Boards (Products 41-50) → Trucks + SUVs
-- ============================================================================
INSERT INTO FitmentMappings (ProductId, VehicleId, IsVerified, InstallDifficulty, FitmentNotes)
SELECT p.Id, v.Id, 1, ABS(CHECKSUM(NEWID())) % 2 + 2,
  CASE WHEN v.BodyStyle = 'SUV' THEN 'SUV-length running boards' ELSE 'Crew cab length - includes all brackets' END
FROM Products p
CROSS JOIN Vehicles v
WHERE p.CategoryId = 9
  AND v.Id IN (1,2,3,4,5,6,7,21,22,23,24,36,37,38,39,40,41,42,50,51,52,53,60,61,69,74,75,81,82,83,84,
               108,109,110,111,112,113,116,117,118,119,120,121,122,123,124,125,126,127,
               128,129,130,137,138,139,140,141,142,143,151,152,155,156,157,158,159,160,163,164,
               8,9,25,26,43,44,45,48,49,62,63,66,67,68,70,71,72,73,76,77,85,86,89,90,95,96,98,99,
               114,115,131,132,133,144,145,148,149,150,153,154,161,162)
  AND NOT EXISTS (
    SELECT 1 FROM FitmentMappings fm WHERE fm.ProductId = p.Id AND fm.VehicleId = v.Id
  );

-- ============================================================================
-- CATEGORY: Fender Flares (Products 51-59) → Trucks + off-road SUVs
-- ============================================================================
INSERT INTO FitmentMappings (ProductId, VehicleId, IsVerified, InstallDifficulty, FitmentNotes)
SELECT p.Id, v.Id, 1, ABS(CHECKSUM(NEWID())) % 2 + 3,
  'Paintable ABS - matches factory fender lines'
FROM Products p
CROSS JOIN Vehicles v
WHERE p.CategoryId = 10
  AND v.Id IN (1,2,3,4,5,6,7,21,22,23,24,36,37,38,39,40,41,42,50,51,52,53,69,74,75,81,82,83,84,
               108,109,110,111,112,113,116,117,118,119,120,121,122,123,124,125,126,127,
               128,129,130,137,138,139,140,151,152,155,156,157,158,159,160,163,164,
               8,9,66,67,68,70,71,72,73,43,44,45,
               114,115,148,149,150,153,154,131,132,133)
  AND NOT EXISTS (
    SELECT 1 FROM FitmentMappings fm WHERE fm.ProductId = p.Id AND fm.VehicleId = v.Id
  );

-- ============================================================================
-- CATEGORY: Mud Flaps (Products 60-68) → All trucks + SUVs
-- ============================================================================
INSERT INTO FitmentMappings (ProductId, VehicleId, IsVerified, InstallDifficulty, FitmentNotes)
SELECT p.Id, v.Id, 1, 1, 'No-drill installation - custom molded for vehicle'
FROM Products p
CROSS JOIN Vehicles v
WHERE p.CategoryId = 11
  AND v.Id IN (1,2,3,4,5,6,7,21,22,23,24,36,37,38,39,40,41,42,50,51,52,53,60,61,69,74,75,81,82,83,84,
               108,109,110,111,112,113,116,117,118,119,120,121,122,123,124,125,126,127,
               128,129,130,137,138,139,140,141,142,143,151,152,155,156,157,158,159,160,163,164,
               8,9,25,26,43,44,45,46,47,48,49,62,63,64,65,66,67,68,70,71,72,73,76,77,85,86,87,88,89,90,
               91,92,93,94,95,96,97,98,99,100,103,106,107,
               114,115,131,132,133,134,135,136,144,145,146,147,148,149,150,153,154,161,162)
  AND NOT EXISTS (
    SELECT 1 FROM FitmentMappings fm WHERE fm.ProductId = p.Id AND fm.VehicleId = v.Id
  );

-- ============================================================================
-- CATEGORY: Grille Guards (Products 69-77) → Trucks + rugged SUVs
-- ============================================================================
INSERT INTO FitmentMappings (ProductId, VehicleId, IsVerified, InstallDifficulty, FitmentNotes)
SELECT p.Id, v.Id, 1, ABS(CHECKSUM(NEWID())) % 2 + 3,
  'Heavy-duty steel construction - includes mounting hardware'
FROM Products p
CROSS JOIN Vehicles v
WHERE p.CategoryId = 12
  AND v.Id IN (1,2,3,4,5,6,7,21,22,23,24,36,37,38,39,40,41,42,50,51,52,53,69,74,75,81,82,83,84,
               108,109,110,111,112,113,116,117,118,119,120,121,122,123,124,125,126,127,
               128,129,130,137,138,139,140,151,152,155,156,157,158,159,160,163,164,
               8,9,66,67,68,70,71,72,73,43,44,45,25,26,76,77,85,86,95,96,
               114,115,148,149,150,153,154,131,132,133)
  AND NOT EXISTS (
    SELECT 1 FROM FitmentMappings fm WHERE fm.ProductId = p.Id AND fm.VehicleId = v.Id
  );

-- ============================================================================
-- CATEGORY: Headlights (Products 78-87) → All vehicles
-- ============================================================================
INSERT INTO FitmentMappings (ProductId, VehicleId, IsVerified, InstallDifficulty, FitmentNotes)
SELECT p.Id, v.Id, 1, ABS(CHECKSUM(NEWID())) % 2 + 2,
  'Direct replacement - plug and play with factory wiring'
FROM Products p
CROSS JOIN Vehicles v
WHERE p.CategoryId = 13
  AND v.Id IN (1,2,3,4,5,6,7,21,22,23,24,36,37,38,39,40,41,42,50,51,52,53,60,61,69,74,75,81,82,83,84,
               108,109,110,111,112,113,116,117,118,119,120,121,122,123,124,125,126,127,
               128,129,130,137,138,139,140,141,142,143,151,152,155,156,157,158,159,160,163,164,
               8,9,10,25,26,27,43,44,45,46,47,48,49,62,63,64,65,66,67,68,70,71,72,73,76,77,
               85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,103,106,107,
               114,115,131,132,133,134,135,136,144,145,146,147,148,149,150,153,154,161,162)
  AND NOT EXISTS (
    SELECT 1 FROM FitmentMappings fm WHERE fm.ProductId = p.Id AND fm.VehicleId = v.Id
  );

-- ============================================================================
-- CATEGORY: Tail Lights (Products 88-96) → All vehicles
-- ============================================================================
INSERT INTO FitmentMappings (ProductId, VehicleId, IsVerified, InstallDifficulty, FitmentNotes)
SELECT p.Id, v.Id, 1, ABS(CHECKSUM(NEWID())) % 2 + 1,
  'LED upgrade - direct factory replacement'
FROM Products p
CROSS JOIN Vehicles v
WHERE p.CategoryId = 14
  AND v.Id IN (1,2,3,4,5,6,7,21,22,23,24,36,37,38,39,40,41,42,50,51,52,53,60,61,69,74,75,81,82,83,84,
               108,109,110,111,112,113,116,117,118,119,120,121,122,123,124,125,126,127,
               128,129,130,137,138,139,140,141,142,143,151,152,155,156,157,158,159,160,163,164,
               8,9,10,25,26,27,43,44,45,46,47,48,49,62,63,64,65,66,67,68,70,71,72,73,76,77,
               85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,103,106,107,
               114,115,131,132,133,134,135,136,144,145,146,147,148,149,150,153,154,161,162)
  AND NOT EXISTS (
    SELECT 1 FROM FitmentMappings fm WHERE fm.ProductId = p.Id AND fm.VehicleId = v.Id
  );

-- ============================================================================
-- CATEGORY: Light Bars (Products 97-106) → Trucks + off-road SUVs
-- ============================================================================
INSERT INTO FitmentMappings (ProductId, VehicleId, IsVerified, InstallDifficulty, FitmentNotes)
SELECT p.Id, v.Id, 1, ABS(CHECKSUM(NEWID())) % 2 + 3,
  'Roof mount or bumper mount - hardware included'
FROM Products p
CROSS JOIN Vehicles v
WHERE p.CategoryId = 15
  AND v.Id IN (1,2,3,4,5,6,7,21,22,23,24,36,37,38,39,40,41,42,50,51,52,53,60,61,69,74,75,81,82,83,84,
               108,109,110,111,112,113,116,117,118,119,120,121,122,123,124,125,126,127,
               128,129,130,137,138,139,140,141,142,143,151,152,155,156,157,158,159,160,163,164,
               8,9,66,67,68,70,71,72,73,43,44,45,25,26,76,77,85,86,95,96,
               114,115,148,149,150,153,154,131,132,133)
  AND NOT EXISTS (
    SELECT 1 FROM FitmentMappings fm WHERE fm.ProductId = p.Id AND fm.VehicleId = v.Id
  );

-- ============================================================================
-- CATEGORY: Fog Lights (Products 107-115) → All vehicles
-- ============================================================================
INSERT INTO FitmentMappings (ProductId, VehicleId, IsVerified, InstallDifficulty, FitmentNotes)
SELECT p.Id, v.Id, 1, ABS(CHECKSUM(NEWID())) % 2 + 2,
  'Direct fog light replacement - OEM housing compatible'
FROM Products p
CROSS JOIN Vehicles v
WHERE p.CategoryId = 16
  AND v.Id IN (1,2,3,4,5,6,7,21,22,23,24,36,37,38,39,40,41,42,50,51,52,53,60,61,69,74,75,81,82,83,84,
               108,109,110,111,112,113,116,117,118,119,120,121,122,123,124,125,126,127,
               128,129,130,137,138,139,140,141,142,143,151,152,155,156,157,158,159,160,163,164,
               8,9,10,25,26,43,44,45,46,47,48,49,62,63,66,67,68,70,71,72,73,76,77,85,86,89,90,
               91,92,93,94,95,96,97,98,99,100,
               114,115,131,132,133,134,135,136,144,145,148,149,150,153,154,161,162)
  AND NOT EXISTS (
    SELECT 1 FROM FitmentMappings fm WHERE fm.ProductId = p.Id AND fm.VehicleId = v.Id
  );

-- ============================================================================
-- CATEGORY: Bed Liners (Products 116-124) → Trucks only (with beds)
-- ============================================================================
INSERT INTO FitmentMappings (ProductId, VehicleId, IsVerified, InstallDifficulty, FitmentNotes)
SELECT p.Id, v.Id, 1, 1, 'Custom-molded to truck bed dimensions'
FROM Products p
CROSS JOIN Vehicles v
WHERE p.CategoryId = 17
  AND v.Id IN (1,2,3,4,5,6,7,21,22,23,24,36,37,38,39,40,41,42,50,51,52,53,60,61,69,74,75,81,82,83,84,
               101,102,104,105,108,109,110,111,112,113,116,117,118,119,120,121,122,123,124,125,126,127,
               128,129,130,137,138,139,140,141,142,143,151,152,155,156,157,158,159,160,163,164)
  AND NOT EXISTS (
    SELECT 1 FROM FitmentMappings fm WHERE fm.ProductId = p.Id AND fm.VehicleId = v.Id
  );

-- ============================================================================
-- CATEGORY: Tonneau Covers (Products 125-135) → Trucks only (with beds)
-- ============================================================================
INSERT INTO FitmentMappings (ProductId, VehicleId, IsVerified, InstallDifficulty, FitmentNotes)
SELECT p.Id, v.Id, 1, ABS(CHECKSUM(NEWID())) % 2 + 1,
  'Custom fit for bed length - clamp-on install'
FROM Products p
CROSS JOIN Vehicles v
WHERE p.CategoryId = 18
  AND v.Id IN (1,2,3,4,5,6,7,21,22,23,24,36,37,38,39,40,41,42,50,51,52,53,60,61,69,74,75,81,82,83,84,
               101,102,104,105,108,109,110,111,112,113,116,117,118,119,120,121,122,123,124,125,126,127,
               128,129,130,137,138,139,140,141,142,143,151,152,155,156,157,158,159,160,163,164)
  AND NOT EXISTS (
    SELECT 1 FROM FitmentMappings fm WHERE fm.ProductId = p.Id AND fm.VehicleId = v.Id
  );

-- ============================================================================
-- CATEGORY: Roof Racks (Products 136-143) → SUVs + some trucks
-- ============================================================================
INSERT INTO FitmentMappings (ProductId, VehicleId, IsVerified, InstallDifficulty, FitmentNotes)
SELECT p.Id, v.Id, 1, ABS(CHECKSUM(NEWID())) % 2 + 2,
  CASE WHEN v.BodyStyle = 'SUV' THEN 'Factory roof rail mount' ELSE 'Cab-mount rack system' END
FROM Products p
CROSS JOIN Vehicles v
WHERE p.CategoryId = 19
  AND v.Id IN (8,9,10,25,26,27,43,44,45,46,47,48,49,62,63,64,65,66,67,68,70,71,72,73,76,77,
               85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,103,106,107,
               114,115,131,132,133,134,135,136,144,145,146,147,148,149,150,153,154,161,162,
               1,2,3,4,5,21,22,23,40,41,42,50,51,52,53,74,75,
               108,109,110,111,116,117,118,119,128,129,130,137,138,139,140,155,156,157)
  AND NOT EXISTS (
    SELECT 1 FROM FitmentMappings fm WHERE fm.ProductId = p.Id AND fm.VehicleId = v.Id
  );

-- ============================================================================
-- CATEGORY: Bed Accessories (Products 144-150) → Trucks only (with beds)
-- ============================================================================
INSERT INTO FitmentMappings (ProductId, VehicleId, IsVerified, InstallDifficulty, FitmentNotes)
SELECT p.Id, v.Id, 1, 1, 'Universal truck bed accessory - fits standard bed rails'
FROM Products p
CROSS JOIN Vehicles v
WHERE p.CategoryId = 20
  AND v.Id IN (1,2,3,4,5,6,7,21,22,23,24,36,37,38,39,40,41,42,50,51,52,53,60,61,69,74,75,81,82,83,84,
               101,102,104,105,108,109,110,111,112,113,116,117,118,119,120,121,122,123,124,125,126,127,
               128,129,130,137,138,139,140,141,142,143,151,152,155,156,157,158,159,160,163,164)
  AND NOT EXISTS (
    SELECT 1 FROM FitmentMappings fm WHERE fm.ProductId = p.Id AND fm.VehicleId = v.Id
  );

-- ============================================================================
-- Summary: Should add ~8000-10000 new fitment mappings across all categories
-- ============================================================================
SELECT COUNT(*) AS TotalFitmentMappings FROM FitmentMappings;
