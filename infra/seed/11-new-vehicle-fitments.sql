-- ============================================================================
-- Fitment mappings for all new vehicles (165-388)
-- Uses INSERT ... WHERE NOT EXISTS to avoid duplicates
-- ============================================================================

-- Sedans & Minivans get: Headlights, Tail Lights, Fog Lights, Mud Flaps, Running Boards, Roof Racks
-- SUVs get: All of above + Hitches, Wiring, Ball Mounts, Brake Controllers, Grille Guards, Light Bars, Fender Flares
-- Trucks get: Everything

-- All new vehicle IDs for reference:
-- Sedans: 165-173(Camry), 174-180(Corolla), 243-247(Malibu), 269-274(Altima), 275-278(Sentra),
--         285-289(Elantra), 336-339(Forte), 351-353(Mazda3), 359-363(Charger),
--         197-205(Civic), 206-213(Accord)
-- Minivans: 181-188(Sienna)
-- SUVs: 189-196(Highlander), 214-217(HR-V), 218-223(Escape), 224-228(Edge),
--        237-242(Expedition), 248-253(Traverse), 254-258(Blazer), 259-262(Trailblazer),
--        263-268(Rogue), 279-284(Santa Fe), 290-295(Palisade), 296-299(Cherokee),
--        300-303(Compass), 304-307(Terrain), 308-311(Acadia), 312-316(Forester),
--        317-320(Ascent), 321-326(Telluride), 327-331(Sorento), 332-335(Sportage),
--        340-344(CX-5), 345-347(CX-50), 348-350(CX-90), 354-358(Durango)
-- Coupe: 229-236(Mustang)
-- Extra trucks: 364-388

-- ============================================================================
-- HEADLIGHTS (Cat 13, Products 78-87) → ALL new vehicles
-- ============================================================================
INSERT INTO FitmentMappings (ProductId, VehicleId, IsVerified, InstallDifficulty, FitmentNotes)
SELECT p.Id, v.Id, 1, ABS(CHECKSUM(NEWID())) % 2 + 2,
  'Direct replacement - plug and play with factory wiring'
FROM Products p
CROSS JOIN Vehicles v
WHERE p.CategoryId = 13
  AND v.Id BETWEEN 165 AND 388
  AND NOT EXISTS (SELECT 1 FROM FitmentMappings fm WHERE fm.ProductId = p.Id AND fm.VehicleId = v.Id);

-- ============================================================================
-- TAIL LIGHTS (Cat 14, Products 88-96) → ALL new vehicles
-- ============================================================================
INSERT INTO FitmentMappings (ProductId, VehicleId, IsVerified, InstallDifficulty, FitmentNotes)
SELECT p.Id, v.Id, 1, ABS(CHECKSUM(NEWID())) % 2 + 1,
  'LED upgrade - direct factory replacement'
FROM Products p
CROSS JOIN Vehicles v
WHERE p.CategoryId = 14
  AND v.Id BETWEEN 165 AND 388
  AND NOT EXISTS (SELECT 1 FROM FitmentMappings fm WHERE fm.ProductId = p.Id AND fm.VehicleId = v.Id);

-- ============================================================================
-- FOG LIGHTS (Cat 16, Products 107-115) → ALL new vehicles except base sedans
-- ============================================================================
INSERT INTO FitmentMappings (ProductId, VehicleId, IsVerified, InstallDifficulty, FitmentNotes)
SELECT p.Id, v.Id, 1, ABS(CHECKSUM(NEWID())) % 2 + 2,
  'OEM replacement fog light assembly'
FROM Products p
CROSS JOIN Vehicles v
WHERE p.CategoryId = 16
  AND v.Id BETWEEN 165 AND 388
  AND NOT EXISTS (SELECT 1 FROM FitmentMappings fm WHERE fm.ProductId = p.Id AND fm.VehicleId = v.Id);

-- ============================================================================
-- MUD FLAPS (Cat 11, Products 60-68) → ALL new vehicles
-- ============================================================================
INSERT INTO FitmentMappings (ProductId, VehicleId, IsVerified, InstallDifficulty, FitmentNotes)
SELECT p.Id, v.Id, 1, 1, 'Custom-molded for vehicle - no-drill install'
FROM Products p
CROSS JOIN Vehicles v
WHERE p.CategoryId = 11
  AND v.Id BETWEEN 165 AND 388
  AND NOT EXISTS (SELECT 1 FROM FitmentMappings fm WHERE fm.ProductId = p.Id AND fm.VehicleId = v.Id);

-- ============================================================================
-- RUNNING BOARDS (Cat 9, Products 41-50) → SUVs, Minivans, Trucks (not sedans/coupes)
-- ============================================================================
INSERT INTO FitmentMappings (ProductId, VehicleId, IsVerified, InstallDifficulty, FitmentNotes)
SELECT p.Id, v.Id, 1, ABS(CHECKSUM(NEWID())) % 2 + 2,
  CASE WHEN v.BodyStyle = 'Minivan' THEN 'Minivan-length running boards' ELSE 'Vehicle-specific brackets included' END
FROM Products p
CROSS JOIN Vehicles v
WHERE p.CategoryId = 9
  AND v.Id BETWEEN 165 AND 388
  AND v.BodyStyle IN ('SUV', 'Minivan', 'Crew Cab')
  AND NOT EXISTS (SELECT 1 FROM FitmentMappings fm WHERE fm.ProductId = p.Id AND fm.VehicleId = v.Id);

-- ============================================================================
-- ROOF RACKS (Cat 19, Products 136-143) → SUVs, Minivans, some Sedans with roof rails
-- ============================================================================
INSERT INTO FitmentMappings (ProductId, VehicleId, IsVerified, InstallDifficulty, FitmentNotes)
SELECT p.Id, v.Id, 1, ABS(CHECKSUM(NEWID())) % 2 + 2,
  CASE WHEN v.BodyStyle = 'SUV' THEN 'Factory roof rail mount' WHEN v.BodyStyle = 'Minivan' THEN 'Roof rail mount for minivan' ELSE 'Cab-mount rack system' END
FROM Products p
CROSS JOIN Vehicles v
WHERE p.CategoryId = 19
  AND v.Id BETWEEN 165 AND 388
  AND v.BodyStyle IN ('SUV', 'Minivan', 'Crew Cab')
  AND NOT EXISTS (SELECT 1 FROM FitmentMappings fm WHERE fm.ProductId = p.Id AND fm.VehicleId = v.Id);

-- ============================================================================
-- TRAILER HITCHES (Cat 5, Products 1-12) → SUVs, Minivans, Trucks (tow-capable)
-- ============================================================================
INSERT INTO FitmentMappings (ProductId, VehicleId, IsVerified, InstallDifficulty, FitmentNotes)
SELECT p.Id, v.Id, 1, ABS(CHECKSUM(NEWID())) % 3 + 2,
  CASE WHEN v.TowCapacityLbs > 5000 THEN 'Heavy-duty receiver hitch' ELSE 'Class I/II receiver hitch' END
FROM Products p
CROSS JOIN Vehicles v
WHERE p.CategoryId = 5
  AND v.Id BETWEEN 165 AND 388
  AND v.TowCapacityLbs > 0
  AND NOT EXISTS (SELECT 1 FROM FitmentMappings fm WHERE fm.ProductId = p.Id AND fm.VehicleId = v.Id);

-- ============================================================================
-- WIRING HARNESSES (Cat 6, Products 13-22) → Same as hitches (tow-capable)
-- ============================================================================
INSERT INTO FitmentMappings (ProductId, VehicleId, IsVerified, InstallDifficulty, FitmentNotes)
SELECT p.Id, v.Id, 1, ABS(CHECKSUM(NEWID())) % 2 + 2,
  'Vehicle-specific wiring connector included'
FROM Products p
CROSS JOIN Vehicles v
WHERE p.CategoryId = 6
  AND v.Id BETWEEN 165 AND 388
  AND v.TowCapacityLbs > 0
  AND NOT EXISTS (SELECT 1 FROM FitmentMappings fm WHERE fm.ProductId = p.Id AND fm.VehicleId = v.Id);

-- ============================================================================
-- BALL MOUNTS (Cat 7, Products 23-31) → Tow-capable vehicles
-- ============================================================================
INSERT INTO FitmentMappings (ProductId, VehicleId, IsVerified, InstallDifficulty, FitmentNotes)
SELECT p.Id, v.Id, 1, 1, 'Universal ball mount - verify drop/rise for vehicle'
FROM Products p
CROSS JOIN Vehicles v
WHERE p.CategoryId = 7
  AND v.Id BETWEEN 165 AND 388
  AND v.TowCapacityLbs > 0
  AND NOT EXISTS (SELECT 1 FROM FitmentMappings fm WHERE fm.ProductId = p.Id AND fm.VehicleId = v.Id);

-- ============================================================================
-- BRAKE CONTROLLERS (Cat 8, Products 32-40) → Heavy tow (>3000 lbs)
-- ============================================================================
INSERT INTO FitmentMappings (ProductId, VehicleId, IsVerified, InstallDifficulty, FitmentNotes)
SELECT p.Id, v.Id, 1, ABS(CHECKSUM(NEWID())) % 2 + 2,
  'Plug-and-play brake controller adapter'
FROM Products p
CROSS JOIN Vehicles v
WHERE p.CategoryId = 8
  AND v.Id BETWEEN 165 AND 388
  AND v.TowCapacityLbs >= 3000
  AND NOT EXISTS (SELECT 1 FROM FitmentMappings fm WHERE fm.ProductId = p.Id AND fm.VehicleId = v.Id);

-- ============================================================================
-- FENDER FLARES (Cat 10, Products 51-59) → Trucks + off-road SUVs
-- ============================================================================
INSERT INTO FitmentMappings (ProductId, VehicleId, IsVerified, InstallDifficulty, FitmentNotes)
SELECT p.Id, v.Id, 1, ABS(CHECKSUM(NEWID())) % 2 + 3,
  'Paintable ABS - matches factory fender lines'
FROM Products p
CROSS JOIN Vehicles v
WHERE p.CategoryId = 10
  AND v.Id BETWEEN 165 AND 388
  AND v.BodyStyle IN ('Crew Cab', 'SUV')
  AND v.DriveType IN ('4WD', 'AWD')
  AND NOT EXISTS (SELECT 1 FROM FitmentMappings fm WHERE fm.ProductId = p.Id AND fm.VehicleId = v.Id);

-- ============================================================================
-- GRILLE GUARDS (Cat 12, Products 69-77) → Trucks + SUVs
-- ============================================================================
INSERT INTO FitmentMappings (ProductId, VehicleId, IsVerified, InstallDifficulty, FitmentNotes)
SELECT p.Id, v.Id, 1, ABS(CHECKSUM(NEWID())) % 2 + 3,
  'Heavy-duty steel construction - includes mounting hardware'
FROM Products p
CROSS JOIN Vehicles v
WHERE p.CategoryId = 12
  AND v.Id BETWEEN 165 AND 388
  AND v.BodyStyle IN ('Crew Cab', 'SUV')
  AND v.TowCapacityLbs >= 2000
  AND NOT EXISTS (SELECT 1 FROM FitmentMappings fm WHERE fm.ProductId = p.Id AND fm.VehicleId = v.Id);

-- ============================================================================
-- LIGHT BARS (Cat 15, Products 97-106) → Trucks + off-road SUVs
-- ============================================================================
INSERT INTO FitmentMappings (ProductId, VehicleId, IsVerified, InstallDifficulty, FitmentNotes)
SELECT p.Id, v.Id, 1, ABS(CHECKSUM(NEWID())) % 2 + 3,
  'Roof mount or bumper mount - hardware included'
FROM Products p
CROSS JOIN Vehicles v
WHERE p.CategoryId = 15
  AND v.Id BETWEEN 165 AND 388
  AND v.BodyStyle IN ('Crew Cab', 'SUV')
  AND v.DriveType IN ('4WD', 'AWD')
  AND NOT EXISTS (SELECT 1 FROM FitmentMappings fm WHERE fm.ProductId = p.Id AND fm.VehicleId = v.Id);

-- ============================================================================
-- BED LINERS (Cat 17, Products 116-124) → Trucks only
-- ============================================================================
INSERT INTO FitmentMappings (ProductId, VehicleId, IsVerified, InstallDifficulty, FitmentNotes)
SELECT p.Id, v.Id, 1, 1, 'Custom-molded to truck bed dimensions'
FROM Products p
CROSS JOIN Vehicles v
WHERE p.CategoryId = 17
  AND v.Id BETWEEN 165 AND 388
  AND v.BodyStyle = 'Crew Cab'
  AND NOT EXISTS (SELECT 1 FROM FitmentMappings fm WHERE fm.ProductId = p.Id AND fm.VehicleId = v.Id);

-- ============================================================================
-- TONNEAU COVERS (Cat 18, Products 125-135) → Trucks only
-- ============================================================================
INSERT INTO FitmentMappings (ProductId, VehicleId, IsVerified, InstallDifficulty, FitmentNotes)
SELECT p.Id, v.Id, 1, ABS(CHECKSUM(NEWID())) % 2 + 1,
  'Custom fit for bed length - clamp-on install'
FROM Products p
CROSS JOIN Vehicles v
WHERE p.CategoryId = 18
  AND v.Id BETWEEN 165 AND 388
  AND v.BodyStyle = 'Crew Cab'
  AND NOT EXISTS (SELECT 1 FROM FitmentMappings fm WHERE fm.ProductId = p.Id AND fm.VehicleId = v.Id);

-- ============================================================================
-- BED ACCESSORIES (Cat 20, Products 144-150) → Trucks only
-- ============================================================================
INSERT INTO FitmentMappings (ProductId, VehicleId, IsVerified, InstallDifficulty, FitmentNotes)
SELECT p.Id, v.Id, 1, 1, 'Universal truck bed accessory'
FROM Products p
CROSS JOIN Vehicles v
WHERE p.CategoryId = 20
  AND v.Id BETWEEN 165 AND 388
  AND v.BodyStyle = 'Crew Cab'
  AND NOT EXISTS (SELECT 1 FROM FitmentMappings fm WHERE fm.ProductId = p.Id AND fm.VehicleId = v.Id);

-- ============================================================================
SELECT COUNT(*) AS TotalFitmentMappings FROM FitmentMappings;
SELECT COUNT(*) AS TotalVehicles FROM Vehicles;
