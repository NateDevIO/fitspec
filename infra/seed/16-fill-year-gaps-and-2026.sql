-- ============================================================================
-- Fill all year gaps and add 2026 models
-- Ensures every model has continuous year coverage from its start year
-- Adds 2026 for models that would realistically have 2026 MY by March 2026
-- Starting IDs from 645
-- ============================================================================

SET IDENTITY_INSERT Vehicles ON;

-- ==========================================================================
-- GAP FILLS — Chevrolet Colorado missing 2021
-- ==========================================================================
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(645, 2021, 2, 7, 'Z71', 'Crew Cab', '4WD', 7000);

-- Chevrolet Equinox missing 2023
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(646, 2023, 2, 9, 'RS', 'SUV', 'AWD', 1500);

-- Chevrolet Tahoe missing 2020, 2021, 2023
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(647, 2020, 2, 8, 'LT', 'SUV', '4WD', 8600),
(648, 2021, 2, 8, 'Premier', 'SUV', '4WD', 8600),
(649, 2023, 2, 8, 'RST', 'SUV', '4WD', 8600);

-- Ford Bronco missing 2022
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(650, 2022, 1, 4, 'Badlands', 'SUV', '4WD', 3500);

-- Ford Explorer missing 2021, 2023
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(651, 2021, 1, 3, 'Limited', 'SUV', 'AWD', 5600),
(652, 2023, 1, 3, 'ST', 'SUV', 'AWD', 5600);

-- Ford Maverick missing 2023
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(653, 2023, 1, 5, 'XLT', 'Crew Cab', 'AWD', 4000);

-- GMC Canyon missing years before 2023 — extend back to 2017
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(654, 2017, 7, 24, 'SLE', 'Crew Cab', '4WD', 7000),
(655, 2018, 7, 24, 'All Terrain', 'Crew Cab', '4WD', 7000),
(656, 2019, 7, 24, 'Denali', 'Crew Cab', '4WD', 7000),
(657, 2020, 7, 24, 'SLE', 'Crew Cab', '4WD', 7000),
(658, 2021, 7, 24, 'AT4', 'Crew Cab', '4WD', 7000),
(659, 2022, 7, 24, 'Elevation', 'Crew Cab', '4WD', 7000);

-- GMC Yukon missing 2023
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(660, 2023, 7, 25, 'Denali', 'SUV', '4WD', 8500);

-- Honda Ridgeline missing 2022
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(661, 2022, 5, 17, 'TrailSport', 'Crew Cab', 'AWD', 5000);

-- Hyundai Santa Cruz missing 2023
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(662, 2023, 9, 30, 'SEL Premium', 'Crew Cab', 'AWD', 5000);

-- Nissan Titan missing 2021, 2022
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(663, 2021, 8, 27, 'SV', 'Crew Cab', '4WD', 9390),
(664, 2022, 8, 27, 'PRO-4X', 'Crew Cab', '4WD', 9390);

-- RAM 2500 missing 2021, 2023
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(665, 2021, 4, 15, 'Laramie', 'Crew Cab', '4WD', 17980),
(666, 2023, 4, 15, 'Limited', 'Crew Cab', '4WD', 17980);

-- RAM 3500 missing 2023
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(667, 2023, 4, 16, 'Limited', 'Crew Cab', '4WD', 31210);

-- Toyota Tundra missing 2020
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(668, 2020, 3, 11, 'SR5', 'Crew Cab', '4WD', 10200);

-- VW Atlas missing 2023
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(669, 2023, 13, 37, 'SEL', 'SUV', 'AWD', 5000);

-- Tesla Model Y missing 2021-2023, 2025
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(670, 2021, 14, 40, 'Long Range', 'SUV', 'AWD', 3500),
(671, 2022, 14, 40, 'Performance', 'SUV', 'AWD', 3500),
(672, 2023, 14, 40, 'Long Range', 'SUV', 'AWD', 3500),
(673, 2025, 14, 40, 'Long Range', 'SUV', 'AWD', 3500);

-- Rivian R1S missing 2025
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(674, 2025, 15, 42, 'Adventure', 'SUV', 'AWD', 7700);

-- Nissan Pathfinder missing 2025
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(675, 2025, 8, 28, 'SL', 'SUV', '4WD', 6000);

-- Nissan Titan missing 2025
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(676, 2025, 8, 27, 'SV', 'Crew Cab', '4WD', 9390);

-- Chevrolet Equinox missing 2025
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(677, 2025, 2, 9, 'RS', 'SUV', 'AWD', 1500);

-- Chevrolet Tahoe missing 2025
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(678, 2025, 2, 8, 'High Country', 'SUV', '4WD', 8600);

-- Ford Explorer missing 2025
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(679, 2025, 1, 3, 'ST', 'SUV', 'AWD', 5600);

-- Ford Maverick missing 2025
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(680, 2025, 1, 5, 'Tremor', 'Crew Cab', 'AWD', 4000);

-- GMC Yukon missing 2025
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(681, 2025, 7, 25, 'Denali', 'SUV', '4WD', 8500);

-- GMC Canyon missing 2025
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(682, 2025, 7, 24, 'AT4', 'Crew Cab', '4WD', 7700);

-- Hyundai Santa Cruz missing 2025
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(683, 2025, 9, 30, 'SEL', 'Crew Cab', 'AWD', 5000);

-- RAM 2500 missing 2025
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(684, 2025, 4, 15, 'Laramie', 'Crew Cab', '4WD', 17980);

-- RAM 3500 missing 2025
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(685, 2025, 4, 16, 'Limited', 'Crew Cab', '4WD', 31210);

-- Nissan Sentra — extend back to 2020
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(686, 2020, 8, 60, 'SV', 'Sedan', 'FWD', 0),
(687, 2021, 8, 60, 'SR', 'Sedan', 'FWD', 0);

-- Kia Forte — extend back to 2019
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(688, 2019, 16, 74, 'EX', 'Sedan', 'FWD', 0),
(689, 2020, 16, 74, 'GT-Line', 'Sedan', 'FWD', 0),
(690, 2021, 16, 74, 'LXS', 'Sedan', 'FWD', 0);

-- Mazda CX-50 — extend back to 2022 (launch year)
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(691, 2022, 17, 76, 'Turbo', 'SUV', 'AWD', 3500);

-- Mazda CX-90 — add 2023 (launch year)
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(692, 2023, 17, 77, 'Turbo S', 'SUV', 'AWD', 5000);

-- Mazda3 — extend back to 2019
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(693, 2019, 17, 78, 'Preferred', 'Sedan', 'AWD', 0),
(694, 2020, 17, 78, 'Select', 'Sedan', 'AWD', 0),
(695, 2021, 17, 78, 'Premium', 'Sedan', 'AWD', 0),
(696, 2022, 17, 78, 'Turbo', 'Sedan', 'AWD', 0);

-- GMC Acadia — extend back to 2017
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(697, 2017, 7, 68, 'SLE', 'SUV', 'AWD', 4000),
(698, 2018, 7, 68, 'SLT', 'SUV', 'AWD', 4000),
(699, 2019, 7, 68, 'Denali', 'SUV', 'AWD', 4000),
(700, 2020, 7, 68, 'AT4', 'SUV', 'AWD', 4000),
(701, 2021, 7, 68, 'SLE', 'SUV', 'AWD', 4000);

-- GMC Terrain — extend back to 2018
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(702, 2018, 7, 67, 'SLE', 'SUV', 'AWD', 1500),
(703, 2019, 7, 67, 'SLT', 'SUV', 'AWD', 1500),
(704, 2020, 7, 67, 'SLE', 'SUV', 'AWD', 1500),
(705, 2021, 7, 67, 'AT4', 'SUV', 'AWD', 1500);

-- Jeep Compass — extend back to 2017
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(706, 2017, 6, 66, 'Latitude', 'SUV', '4WD', 2000),
(707, 2018, 6, 66, 'Trailhawk', 'SUV', '4WD', 2000),
(708, 2019, 6, 66, 'Limited', 'SUV', '4WD', 2000),
(709, 2020, 6, 66, 'Sport', 'SUV', '4WD', 2000),
(710, 2021, 6, 66, 'Latitude', 'SUV', '4WD', 2000);

-- Jeep Gladiator — add 2020 (launch year)
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(711, 2020, 6, 21, 'Sport', 'Crew Cab', '4WD', 7650);

-- Ford Edge — extend back to 2015 (discontinued after 2024)
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(712, 2015, 1, 51, 'SEL', 'SUV', 'AWD', 3500),
(713, 2016, 1, 51, 'Titanium', 'SUV', 'AWD', 3500),
(714, 2017, 1, 51, 'Sport', 'SUV', 'AWD', 3500),
(715, 2018, 1, 51, 'SEL', 'SUV', 'AWD', 3500),
(716, 2019, 1, 51, 'ST', 'SUV', 'AWD', 3500);

-- Chevrolet Blazer — extend back to 2019 (launch year)
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(717, 2019, 2, 56, 'RS', 'SUV', 'AWD', 4500),
(718, 2020, 2, 56, 'LT', 'SUV', 'AWD', 4500);

-- Chevrolet Trailblazer — add missing 2021 (launch year)
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(719, 2021, 2, 57, 'RS', 'SUV', 'AWD', 1000);

-- ==========================================================================
-- 2026 MODELS — Most major models would have 2026 MY announced by March 2026
-- ==========================================================================

-- Ford
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(720, 2026, 1, 1, 'XLT', 'Crew Cab', '4WD', 11500),
(721, 2026, 1, 1, 'Lariat', 'Crew Cab', '4WD', 13500),
(722, 2026, 1, 2, 'XLT', 'Crew Cab', '4WD', 7500),
(723, 2026, 1, 3, 'XLT', 'SUV', 'AWD', 5600),
(724, 2026, 1, 4, 'Big Bend', 'SUV', '4WD', 3500),
(725, 2026, 1, 5, 'XLT', 'Crew Cab', 'AWD', 4000),
(726, 2026, 1, 50, 'Active', 'SUV', 'AWD', 3500),
(727, 2026, 1, 52, 'GT', 'Coupe', 'RWD', 0),
(728, 2026, 1, 53, 'XLT', 'SUV', '4WD', 9300);

-- Chevrolet
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(729, 2026, 2, 6, 'LT', 'Crew Cab', '4WD', 11200),
(730, 2026, 2, 6, 'ZR2', 'Crew Cab', '4WD', 9600),
(731, 2026, 2, 7, 'Z71', 'Crew Cab', '4WD', 7700),
(732, 2026, 2, 8, 'RST', 'SUV', '4WD', 8600),
(733, 2026, 2, 9, 'EV', 'SUV', 'AWD', 1500),
(734, 2026, 2, 55, 'RS', 'SUV', 'AWD', 5000),
(735, 2026, 2, 56, 'RS', 'SUV', 'AWD', 4500),
(736, 2026, 2, 57, 'RS', 'SUV', 'AWD', 1000);

-- Toyota
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(737, 2026, 3, 10, 'TRD Off-Road', 'Crew Cab', '4WD', 6800),
(738, 2026, 3, 11, 'Limited', 'Crew Cab', '4WD', 12000),
(739, 2026, 3, 12, 'TRD Pro', 'SUV', '4WD', 5000),
(740, 2026, 3, 13, 'XLE', 'SUV', 'AWD', 1750),
(741, 2026, 3, 43, 'XSE', 'Sedan', 'AWD', 0),
(742, 2026, 3, 44, 'SE', 'Sedan', 'FWD', 0),
(743, 2026, 3, 45, 'XLE', 'Minivan', 'AWD', 3500),
(744, 2026, 3, 46, 'XLE', 'SUV', 'AWD', 5000);

-- RAM
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(745, 2026, 4, 14, 'Laramie', 'Crew Cab', '4WD', 12750),
(746, 2026, 4, 14, 'Rebel', 'Crew Cab', '4WD', 10620),
(747, 2026, 4, 15, 'Power Wagon', 'Crew Cab', '4WD', 17980),
(748, 2026, 4, 16, 'Laramie', 'Crew Cab', '4WD', 31210);

-- Honda
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(749, 2026, 5, 47, 'Sport', 'Sedan', 'FWD', 0),
(750, 2026, 5, 48, 'EX-L', 'Sedan', 'FWD', 0),
(751, 2026, 5, 19, 'EX-L', 'SUV', 'AWD', 1500),
(752, 2026, 5, 18, 'TrailSport', 'SUV', 'AWD', 5000),
(753, 2026, 5, 17, 'Sport', 'Crew Cab', 'AWD', 5000),
(754, 2026, 5, 49, 'EX-L', 'SUV', 'AWD', 0);

-- Jeep
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(755, 2026, 6, 20, 'Rubicon', 'SUV', '4WD', 3500),
(756, 2026, 6, 21, 'Rubicon', 'Crew Cab', '4WD', 7650),
(757, 2026, 6, 22, 'Limited', 'SUV', '4WD', 7200),
(758, 2026, 6, 66, 'Trailhawk', 'SUV', '4WD', 2000);

-- GMC
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(759, 2026, 7, 23, 'Denali', 'Crew Cab', '4WD', 12100),
(760, 2026, 7, 24, 'AT4', 'Crew Cab', '4WD', 7700),
(761, 2026, 7, 25, 'Denali', 'SUV', '4WD', 8500),
(762, 2026, 7, 67, 'AT4', 'SUV', 'AWD', 1500),
(763, 2026, 7, 68, 'SLT', 'SUV', 'AWD', 4000);

-- Nissan
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(764, 2026, 8, 58, 'SL', 'SUV', 'AWD', 1350),
(765, 2026, 8, 26, 'PRO-4X', 'Crew Cab', '4WD', 6720),
(766, 2026, 8, 59, 'SV', 'Sedan', 'AWD', 0),
(767, 2026, 8, 28, 'SL', 'SUV', '4WD', 6000),
(768, 2026, 8, 60, 'SR', 'Sedan', 'FWD', 0);

-- Hyundai
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(769, 2026, 9, 29, 'SEL', 'SUV', 'AWD', 2000),
(770, 2026, 9, 61, 'Limited', 'SUV', 'AWD', 5000),
(771, 2026, 9, 62, 'N', 'Sedan', 'FWD', 0),
(772, 2026, 9, 63, 'Calligraphy', 'SUV', 'AWD', 5000),
(773, 2026, 9, 30, 'Limited', 'Crew Cab', 'AWD', 5000);

-- Subaru
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(774, 2026, 10, 31, 'Wilderness', 'Wagon', 'AWD', 3500),
(775, 2026, 10, 69, 'Sport', 'SUV', 'AWD', 1500),
(776, 2026, 10, 32, 'Wilderness', 'SUV', 'AWD', 3500),
(777, 2026, 10, 70, 'Touring', 'SUV', 'AWD', 5000);

-- BMW
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(778, 2026, 11, 33, 'xDrive40i', 'SUV', 'AWD', 7200),
(779, 2026, 11, 34, 'M40i', 'SUV', 'AWD', 4400);

-- Mercedes-Benz
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(780, 2026, 12, 35, 'GLE 450', 'SUV', 'AWD', 7700),
(781, 2026, 12, 36, 'GLC 300', 'SUV', 'AWD', 4400);

-- Volkswagen
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(782, 2026, 13, 37, 'SE', 'SUV', 'AWD', 5000),
(783, 2026, 13, 38, 'SE', 'SUV', 'AWD', 1500);

-- Tesla
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(784, 2026, 14, 39, 'Foundation', 'Crew Cab', 'AWD', 11000),
(785, 2026, 14, 40, 'Long Range', 'SUV', 'AWD', 3500);

-- Rivian
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(786, 2026, 15, 41, 'Adventure', 'Crew Cab', 'AWD', 11000),
(787, 2026, 15, 42, 'Adventure', 'SUV', 'AWD', 7700);

-- Kia
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(788, 2026, 16, 71, 'SX', 'SUV', 'AWD', 5000),
(789, 2026, 16, 72, 'EX', 'SUV', 'AWD', 5000),
(790, 2026, 16, 73, 'X-Pro', 'SUV', 'AWD', 2000),
(791, 2026, 16, 74, 'GT-Line', 'Sedan', 'FWD', 0);

-- Mazda
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(792, 2026, 17, 75, 'Turbo', 'SUV', 'AWD', 2000),
(793, 2026, 17, 76, 'Premium Plus', 'SUV', 'AWD', 3500),
(794, 2026, 17, 77, 'Turbo S', 'SUV', 'AWD', 5000),
(795, 2026, 17, 78, 'Turbo', 'Sedan', 'AWD', 0);

-- Dodge
INSERT INTO Vehicles (Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs) VALUES
(796, 2026, 18, 79, 'R/T', 'SUV', 'AWD', 7400),
(797, 2026, 18, 80, 'R/T', 'Sedan', 'AWD', 0);

SET IDENTITY_INSERT Vehicles OFF;
