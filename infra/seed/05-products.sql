-- ============================================================================
-- FitSpec Seed Data: Products
-- 150 products across 16 subcategories with realistic names, SKUs, brands,
-- and prices. IsVerified = 1 for ~70% of products.
-- SKU format: CAT-BRAND-NNN
-- ============================================================================

SET IDENTITY_INSERT Products ON;

-- ==========================================================================
-- TOWING > Trailer Hitches (CategoryId=5) — Products 1-12
-- ==========================================================================
INSERT INTO Products (Id, CategoryId, Name, SKU, Brand, Description, Price, ImageUrl, IsVerified) VALUES
(1,   5, 'CURT Class III Receiver Hitch', 'HIT-CURT-001', 'CURT',       'Heavy-duty Class III receiver hitch with 2-inch opening. 5,000 lb GTW, 500 lb TW.', 189.99, NULL, 1),
(2,   5, 'Draw-Tite Max-Frame Hitch', 'HIT-DRAW-002', 'Draw-Tite',  'Max-Frame Class III/IV hitch receiver with e-coat finish for corrosion resistance.', 219.95, NULL, 1),
(3,   5, 'B&W Turnoverball Gooseneck Hitch', 'HIT-BW-003',   'B&W',        'Turnoverball gooseneck hitch with patented ball-in-bed design. 30,000 lb GTW.', 899.99, NULL, 1),
(4,   5, 'Reese Towpower Class IV Hitch', 'HIT-REES-004', 'Reese',      'Professional-grade Class IV hitch with 10,000 lb GTW capacity.', 279.99, NULL, 1),
(5,   5, 'CURT Front Mount Hitch', 'HIT-CURT-005', 'CURT',       'Front mount receiver hitch for winch or snow plow mounting. 9,000 lb GTW.', 249.95, NULL, 0),
(6,   5, 'Husky Towing Class III Hitch', 'HIT-HUSK-006', 'Husky',      'Class III hitch with powder coat finish. 5,000 lb GTW, 500 lb TW.', 159.99, NULL, 1),
(7,   5, 'EcoHitch Hidden Hitch', 'HIT-ECO-007',  'EcoHitch',   'Hidden receiver hitch that maintains factory appearance. Class III rated.', 399.99, NULL, 1),
(8,   5, 'Draw-Tite Sportframe Hitch', 'HIT-DRAW-008', 'Draw-Tite',  'Lightweight Class I hitch for sedans and small SUVs. 2,000 lb GTW.', 149.99, NULL, 0),
(9,   5, 'CURT Class V Commercial Hitch', 'HIT-CURT-009', 'CURT',       'Heavy-duty Class V hitch with 2.5-inch receiver. 17,000 lb GTW.', 349.99, NULL, 1),
(10,  5, 'Smittybilt JH46 Class III Hitch', 'HIT-SMIT-010', 'Smittybilt', 'Bolt-on Class III hitch for Jeep Wrangler JL. 3,500 lb GTW.', 199.99, NULL, 1),
(11,  5, 'WeatherTech Hitch BumpStep XL', 'HIT-WEAT-011', 'WeatherTech','Hitch-mounted bumper step with integrated BumpStep. Fits 2-inch receivers.', 99.95,  NULL, 1),
(12,  5, 'Ranch Hand Legend Hitch', 'HIT-RANC-012', 'Ranch Hand', 'Heavy-gauge steel Class V hitch for full-size trucks. Built-in step.', 449.99, NULL, 0),

-- ==========================================================================
-- TOWING > Wiring Harnesses (CategoryId=6) — Products 13-22
-- ==========================================================================
(13,  6, 'CURT T-Connector Wiring Harness', 'WIR-CURT-013', 'CURT',       'Custom vehicle-specific T-connector. Plug-and-play installation, no splicing.', 49.99,  NULL, 1),
(14,  6, 'Tekonsha OEM Replacement Harness', 'WIR-TEKO-014', 'Tekonsha',   'OEM-quality replacement wiring harness with pre-installed connectors.', 64.95,  NULL, 1),
(15,  6, 'Hopkins Plug-In Simple Harness', 'WIR-HOPK-015', 'Hopkins',    'Plug-in simple vehicle wiring harness with integrated circuit protection.', 39.99,  NULL, 1),
(16,  6, 'CURT 4-Way Flat Connector', 'WIR-CURT-016', 'CURT',       'Universal 4-way flat trailer wiring connector with 60-inch lead.', 24.99,  NULL, 0),
(17,  6, 'Bargman 7-Way Connector Kit', 'WIR-BARG-017', 'Bargman',    'Complete 7-way RV blade connector kit with 8-foot harness.', 54.99,  NULL, 1),
(18,  6, 'Draw-Tite Modulite HD Plus', 'WIR-DRAW-018', 'Draw-Tite',  'Heavy-duty protector with integrated circuit protection module.', 79.95,  NULL, 1),
(19,  6, 'Hopkins Endurance 5th Wheel Harness', 'WIR-HOPK-019', 'Hopkins',    'In-bed 7-way wiring harness for 5th wheel and gooseneck trailers.', 89.99,  NULL, 0),
(20,  6, 'Tekonsha ZCI Zero Contact Interface', 'WIR-TEKO-020', 'Tekonsha',   'Zero-contact wiring interface that connects without physical splicing.', 74.99,  NULL, 1),
(21,  6, 'CURT Powered Tail Light Converter', 'WIR-CURT-021', 'CURT',       '3-to-2 powered tail light converter for vehicles with separate turn signals.', 34.99,  NULL, 1),
(22,  6, 'Pollak 7-Way OEM Connector', 'WIR-POLL-022', 'Pollak',     'OEM-style 7-way RV blade trailer connector for factory replacement.', 44.95,  NULL, 1),

-- ==========================================================================
-- TOWING > Ball Mounts (CategoryId=7) — Products 23-31
-- ==========================================================================
(23,  7, 'CURT Adjustable Ball Mount', 'BAL-CURT-023', 'CURT',       'Adjustable channel-style ball mount with 6-inch drop/rise. 10,000 lb GTW.', 59.99,  NULL, 1),
(24,  7, 'B&W Tow & Stow Ball Mount', 'BAL-BW-024',   'B&W',        'Tri-ball adjustable ball mount with stow position. 10,000 lb GTW.', 229.99, NULL, 1),
(25,  7, 'Blue Ox BX88302 Ball Mount', 'BAL-BLUE-025', 'Blue Ox',    'Immobilizer II adjustable ball mount with anti-rattle design.', 169.95, NULL, 1),
(26,  7, 'CURT Pintle Mount', 'BAL-CURT-026', 'CURT',       'Heavy-duty pintle mount for 2-inch receivers. 20,000 lb GTW.', 89.99,  NULL, 0),
(27,  7, 'Reese Strait-Line Hitch Ball Mount', 'BAL-REES-027', 'Reese',      'Weight distribution ball mount with sway control. 12,000 lb GTW.', 299.99, NULL, 1),
(28,  7, 'Fastway Flash E-Series Ball Mount', 'BAL-FAST-028', 'Fastway',    'Solid steel adjustable ball mount with integrated locks. 10,000 lb GTW.', 189.95, NULL, 1),
(29,  7, 'CURT Tow Ball 2-5/16 inch', 'BAL-CURT-029', 'CURT',       'Chrome-plated trailer ball, 2-5/16 inch diameter, 1-inch shank.', 21.99,  NULL, 1),
(30,  7, 'Weigh Safe Adjustable Ball Mount', 'BAL-WEIG-030', 'Weigh Safe', 'Built-in tongue weight scale with adjustable ball mount. 10,000 lb GTW.', 299.99, NULL, 1),
(31,  7, 'B&W Continuum Weight Distribution', 'BAL-BW-031',   'B&W',        'Weight distribution hitch head with sway control and dual-cam design.', 649.99, NULL, 0),

-- ==========================================================================
-- TOWING > Brake Controllers (CategoryId=8) — Products 32-40
-- ==========================================================================
(32,  8, 'Tekonsha Prodigy P3 Brake Controller', 'BRK-TEKO-032', 'Tekonsha',   'Proportional brake controller with LCD display. Up to 4 axle trailers.', 189.99, NULL, 1),
(33,  8, 'CURT TriFlex Brake Controller', 'BRK-CURT-033', 'CURT',       'Proportional triple-axis brake controller with custom screen.', 149.99, NULL, 1),
(34,  8, 'Tekonsha Voyager Brake Controller', 'BRK-TEKO-034', 'Tekonsha',   'Time-delayed brake controller for trailers up to 4 axles. LED display.', 79.99,  NULL, 1),
(35,  8, 'Reese Brakeman IV Controller', 'BRK-REES-035', 'Reese',      'Timed-based brake controller with manual override. Easy installation.', 59.99,  NULL, 0),
(36,  8, 'CURT Echo Mobile Brake Controller', 'BRK-CURT-036', 'CURT',       'Bluetooth-enabled wireless brake controller. Smartphone app control.', 249.99, NULL, 1),
(37,  8, 'Hayes Sway Master Controller', 'BRK-HAYE-037', 'Hayes',      'Electronic sway control with proportional braking. Digital display.', 199.99, NULL, 1),
(38,  8, 'Tekonsha P2 Proportional Controller', 'BRK-TEKO-038', 'Tekonsha',   'Compact proportional brake controller with boost feature. 1-4 axles.', 129.99, NULL, 0),
(39,  8, 'Draw-Tite I-Command Controller', 'BRK-DRAW-039', 'Draw-Tite',  'Proportional brake controller with accelerometer technology.', 159.99, NULL, 1),
(40,  8, 'CURT Venturer Brake Controller', 'BRK-CURT-040', 'CURT',       'Time-delayed brake controller with manual override lever.', 69.99,  NULL, 1),

-- ==========================================================================
-- EXTERIOR > Running Boards (CategoryId=9) — Products 41-50
-- ==========================================================================
(41,  9, 'N-Fab Podium LG Steps', 'RUN-NFAB-041', 'N-Fab',      'Full-length running boards with textured step pads. Stainless steel.', 549.99, NULL, 1),
(42,  9, 'Westin HDX Drop Steps', 'RUN-WEST-042', 'Westin',     'Heavy-duty drop steps with stainless steel construction. Non-skid pads.', 499.99, NULL, 1),
(43,  9, 'AMP Research PowerStep', 'RUN-AMP-043',  'AMP Research','Electric-powered running boards that deploy automatically on door open.', 1599.99,NULL, 1),
(44,  9, 'Rough Country HD2 Running Boards', 'RUN-ROUG-044', 'Rough Country','Heavy-duty steel running boards with textured black finish.', 349.99, NULL, 1),
(45,  9, 'Go Rhino RB20 Running Boards', 'RUN-GORH-045', 'Go Rhino',   'Slim-profile bedliner-coated running boards. Direct bolt-on.', 469.99, NULL, 0),
(46,  9, 'Westin R7 Nerf Steps', 'RUN-WEST-046', 'Westin',     'Round tube nerf steps with stainless steel finish and step pads.', 389.99, NULL, 1),
(47,  9, 'Lund Summit Ridge Running Boards', 'RUN-LUND-047', 'Lund',       'Aluminum running boards with built-in LED courtesy lights.', 429.99, NULL, 1),
(48,  9, 'Tyger Auto Star Armor Steps', 'RUN-TYGE-048', 'Tyger Auto', 'Textured black nerf bars with step pads. No-drill mounting.', 259.99, NULL, 0),
(49,  9, 'AMP Research BedStep2', 'RUN-AMP-049',  'AMP Research','Retractable truck bed side step. Mounts behind rear wheel.', 299.99, NULL, 1),
(50,  9, 'Ionic Pro Series Running Boards', 'RUN-IONI-050', 'Ionic',      'Wide 6-inch running boards with UV-resistant polymer treads.', 319.99, NULL, 1),

-- ==========================================================================
-- EXTERIOR > Fender Flares (CategoryId=10) — Products 51-59
-- ==========================================================================
(51, 10, 'Bushwacker Pocket Style Flares', 'FEN-BUSH-051', 'Bushwacker', 'OEM-quality pocket-style fender flares with matte black finish.', 449.99, NULL, 1),
(52, 10, 'Bushwacker Extend-A-Fender Flares', 'FEN-BUSH-052', 'Bushwacker', 'Extended coverage fender flares. Adds 2.5 inches of tire coverage.', 349.99, NULL, 1),
(53, 10, 'EGR Rugged Look Flares', 'FEN-EGR-053',  'EGR',        'Rugged bolt-on style fender flares with factory-matched paint option.', 529.99, NULL, 1),
(54, 10, 'Rough Country Pocket Fender Flares', 'FEN-ROUG-054', 'Rough Country','Textured black pocket-style flares with stainless hardware.', 299.99, NULL, 0),
(55, 10, 'Smittybilt M1 Fender Flares', 'FEN-SMIT-055', 'Smittybilt', 'Bolt-on steel fender flares with integrated LED markers.', 599.99, NULL, 1),
(56, 10, 'Lund RX-Rivet Style Flares', 'FEN-LUND-056', 'Lund',       'Rivet-style fender flares with UV-protected matte finish.', 379.99, NULL, 1),
(57, 10, 'Mopar Production Fender Flares', 'FEN-MOPR-057', 'Mopar',      'Factory-style production fender flares for RAM trucks.', 499.99, NULL, 1),
(58, 10, 'Bushwacker Forge Style Flares', 'FEN-BUSH-058', 'Bushwacker', 'Sleek factory-style flares with matte black textured finish.', 419.99, NULL, 0),
(59, 10, 'Stampede Ruff Riderz Flares', 'FEN-STAM-059', 'Stampede',   'No-drill fender flares with rugged textured finish. Easy install.', 219.99, NULL, 1),

-- ==========================================================================
-- EXTERIOR > Mud Flaps (CategoryId=11) — Products 60-68
-- ==========================================================================
(60, 11, 'WeatherTech No-Drill MudFlaps', 'MUD-WEAT-060', 'WeatherTech','Custom-fit no-drill mud flaps with QuickTurn fastener system.', 124.95, NULL, 1),
(61, 11, 'Husky Liners Custom Mud Guards', 'MUD-HUSK-061', 'Husky Liners','Form-fitted custom mud guards with rubberized finish.', 99.95,  NULL, 1),
(62, 11, 'Bushwacker Trail Armor Mud Flaps', 'MUD-BUSH-062', 'Bushwacker', 'Heavy-duty trail armor mud flaps for off-road protection.', 89.99,  NULL, 1),
(63, 11, 'Gatorback Premium Mud Flaps', 'MUD-GATO-063', 'Gatorback',  'Full-width premium mud flaps with removable stainless weights.', 149.99, NULL, 0),
(64, 11, 'Putco Mud Skins', 'MUD-PUTC-064', 'Putco',      'Form-fitting mud flaps with carbon fiber look finish.', 79.99,  NULL, 1),
(65, 11, 'Rough Country Mud Flaps w/ Logo', 'MUD-ROUG-065', 'Rough Country','Heavy-duty mud flaps with Rough Country branding.', 69.99,  NULL, 0),
(66, 11, 'Rokblokz Rally Mud Flaps', 'MUD-ROKB-066', 'Rokblokz',   'Rally-style polyurethane mud flaps. Available in multiple colors.', 109.99, NULL, 1),
(67, 11, 'Luverne Textured Mud Guards', 'MUD-LUVR-067', 'Luverne',    'Textured rubber mud guards with polished stainless trim.', 134.99, NULL, 1),
(68, 11, 'Mopar Splash Guards', 'MUD-MOPR-068', 'Mopar',      'Factory-style molded splash guards for RAM and Jeep vehicles.', 74.99,  NULL, 1),

-- ==========================================================================
-- EXTERIOR > Grille Guards (CategoryId=12) — Products 69-77
-- ==========================================================================
(69, 12, 'Ranch Hand Legend Grille Guard', 'GRI-RANC-069', 'Ranch Hand', 'Full front-end grille guard with heavy-gauge steel construction.', 1099.99,NULL, 1),
(70, 12, 'Westin HDX Grille Guard', 'GRI-WEST-070', 'Westin',     'Heavy-duty stainless steel grille guard with punch plate inserts.', 799.99, NULL, 1),
(71, 12, 'Go Rhino 3100 Series StepGuard', 'GRI-GORH-071', 'Go Rhino',   'Grille guard with integrated step for windshield access.', 849.99, NULL, 1),
(72, 12, 'N-Fab Full Replacement Grille Guard', 'GRI-NFAB-072', 'N-Fab',      'Pre-runner style full replacement grille guard. Gloss black.', 749.99, NULL, 0),
(73, 12, 'Aries Pro Series Grille Guard', 'GRI-ARIE-073', 'Aries',      'Modular Pro Series grille guard with brushed stainless finish.', 599.99, NULL, 1),
(74, 12, 'Frontier Truck Gear Xtreme Guard', 'GRI-FRON-074', 'Frontier Truck Gear', '7-gauge steel grille guard with replaceable rubber pads.', 949.99, NULL, 1),
(75, 12, 'Lund Bull Bar with LED Light Bar', 'GRI-LUND-075', 'Lund',       'Black bull bar with integrated 20-inch LED light bar mount.', 329.99, NULL, 0),
(76, 12, 'Steelcraft HD Grille Guard', 'GRI-STEE-076', 'Steelcraft', 'One-piece HD grille guard with headlight guards. Powder coat.', 679.99, NULL, 1),
(77, 12, 'Ranch Hand Midnight Bumper', 'GRI-RANC-077', 'Ranch Hand', 'Full replacement front bumper with grille guard and fog light cutouts.', 1499.99,NULL, 1),

-- ==========================================================================
-- LIGHTING > Headlights (CategoryId=13) — Products 78-87
-- ==========================================================================
(78, 13, 'Morimoto XB LED Headlights', 'HEA-MORI-078', 'Morimoto',   'Full LED projector headlights with sequential turn signals.', 1299.99,NULL, 1),
(79, 13, 'AlphaRex NOVA Series Headlights', 'HEA-ALPH-079', 'AlphaRex',   'Full LED DRL headlights with programmable sequential signals.', 1149.99,NULL, 1),
(80, 13, 'Spyder Auto PRO-YD Projector Headlights', 'HEA-SPYD-080', 'Spyder Auto','Halo projector headlights with LED DRL bar. DOT/SAE approved.', 399.99, NULL, 1),
(81, 13, 'Anzo USA LED Projector Headlights', 'HEA-ANZO-081', 'Anzo USA',   'Plank-style LED projector headlights with halo accent.', 549.99, NULL, 0),
(82, 13, 'RECON Projector Headlights', 'HEA-RECO-082', 'RECON',      'Smoked/black projector headlights with OLED halos.', 699.99, NULL, 1),
(83, 13, 'Rough Country LED Headlight Kit', 'HEA-ROUG-083', 'Rough Country','Drop-in LED headlight bulb conversion kit. 6500K.', 79.99,  NULL, 1),
(84, 13, 'Morimoto 2Stroke 3.0 LED Bulbs', 'HEA-MORI-084', 'Morimoto',   'Plug-and-play LED bulb upgrade with integrated drivers.', 119.99, NULL, 1),
(85, 13, 'Diode Dynamics SS3 Fog-to-Headlight Kit', 'HEA-DIOD-085', 'Diode Dynamics','LED conversion with Type SV optic for 3x stock brightness.', 289.99, NULL, 0),
(86, 13, 'ORACLE Lighting ColorSHIFT Halos', 'HEA-ORAC-086', 'ORACLE',     'Bluetooth-controlled ColorSHIFT halo headlight kit.', 349.99, NULL, 1),
(87, 13, 'Putco LED Headlight Conversion', 'HEA-PUTC-087', 'Putco',      'Plug-in LED headlight conversion. 4000 lumens, 5500K daylight.', 149.99, NULL, 1),

-- ==========================================================================
-- LIGHTING > Tail Lights (CategoryId=14) — Products 88-96
-- ==========================================================================
(88, 14, 'Morimoto XB LED Tail Lights', 'TAL-MORI-088', 'Morimoto',   'Full LED tail lights with sequential turn signals. DOT approved.', 799.99, NULL, 1),
(89, 14, 'AlphaRex PRO Series Tail Lights', 'TAL-ALPH-089', 'AlphaRex',   'Sequential LED tail lights with red lens and smoked housing.', 649.99, NULL, 1),
(90, 14, 'Spyder Auto LED Tail Lights', 'TAL-SPYD-090', 'Spyder Auto','LED tail lights with fiber optic light tube design.', 299.99, NULL, 1),
(91, 14, 'Anzo USA LED Tail Lights', 'TAL-ANZO-091', 'Anzo USA',   'G2 LED tail lights with 3D light bar design.', 349.99, NULL, 0),
(92, 14, 'RECON OLED Tail Lights', 'TAL-RECO-092', 'RECON',      'Smoked OLED tail lights with scanning LED turn signals.', 599.99, NULL, 1),
(93, 14, 'Putco LED Tail Light Bulbs', 'TAL-PUTC-093', 'Putco',      'Drop-in LED replacement tail light bulbs. Red. 360-degree.', 39.99,  NULL, 1),
(94, 14, 'Raxiom Axial Series LED Tails', 'TAL-RAXI-094', 'Raxiom',     'Euro-style LED tail lights with clear lens option.', 449.99, NULL, 1),
(95, 14, 'ORACLE Lighting LED Tail Lights', 'TAL-ORAC-095', 'ORACLE',     'Flush-mount LED tail lights with halo rings.', 529.99, NULL, 0),
(96, 14, 'Winjet OE-Style Tail Lights', 'TAL-WINJ-096', 'Winjet',     'Direct OE-replacement tail lights with improved LED output.', 199.99, NULL, 1),

-- ==========================================================================
-- LIGHTING > Light Bars (CategoryId=15) — Products 97-106
-- ==========================================================================
(97,  15, 'Rigid Industries E-Series 50-inch', 'LBR-RIGI-097', 'Rigid Industries','50-inch combo spot/flood LED light bar. 33,600 lumens.', 1399.99,NULL, 1),
(98,  15, 'KC HiLiTES C-Series 40-inch', 'LBR-KC-098',   'KC HiLiTES', '40-inch C-Series LED light bar with combo beam. IP68 rated.', 899.99, NULL, 1),
(99,  15, 'Rough Country 30-inch Curved LED Bar', 'LBR-ROUG-099', 'Rough Country','30-inch curved single row LED bar with DRL function.', 189.99, NULL, 1),
(100, 15, 'Baja Designs OnX6+ 40-inch', 'LBR-BAJA-100', 'Baja Designs','OnX6+ 40-inch LED bar with High Speed Spot pattern.', 2199.99,NULL, 1),
(101, 15, 'Rigid Industries Radiance+ 30-inch', 'LBR-RIGI-101', 'Rigid Industries','30-inch Radiance+ with broad spot and multi-color backlight.', 699.99, NULL, 0),
(102, 15, 'Nilight 22-inch LED Light Bar', 'LBR-NILI-102', 'Nilight',    'Budget-friendly 22-inch combo beam LED light bar. 120W.', 49.99,  NULL, 1),
(103, 15, 'Heretic Studio 6-Series 20-inch', 'LBR-HERE-103', 'Heretic Studio','20-inch billet aluminum LED light bar. Made in USA.', 799.99, NULL, 1),
(104, 15, 'Diode Dynamics SS12 Stage Series', 'LBR-DIOD-104', 'Diode Dynamics','12-inch Stage Series light bar with SAE/DOT compliance.', 349.99, NULL, 0),
(105, 15, 'Vision X XPR Halo 30-inch', 'LBR-VISI-105', 'Vision X',   '30-inch mixed beam LED bar with built-in halo backlight.', 1099.99,NULL, 1),
(106, 15, 'Auxbeam V-Series 52-inch', 'LBR-AUXB-106', 'Auxbeam',    '52-inch curved LED light bar. 300W, 30,000 lumens.', 129.99, NULL, 1),

-- ==========================================================================
-- LIGHTING > Fog Lights (CategoryId=16) — Products 107-115
-- ==========================================================================
(107, 16, 'Morimoto XB LED Fog Lights', 'FOG-MORI-107', 'Morimoto',   'Projector LED fog lights with wide beam pattern. DOT compliant.', 249.99, NULL, 1),
(108, 16, 'Diode Dynamics SS3 Sport Fog Lights', 'FOG-DIOD-108', 'Diode Dynamics','SS3 Sport LED fog light pods with interchangeable optics.', 319.99, NULL, 1),
(109, 16, 'KC HiLiTES Gravity G4 Fog Lights', 'FOG-KC-109',   'KC HiLiTES', 'Gravity G4 LED fog lights with amber and clear options.', 279.99, NULL, 1),
(110, 16, 'Rigid Industries D-Series Dually', 'FOG-RIGI-110', 'Rigid Industries','3-inch D-Series Dually LED fog light pair. Flood beam.', 229.99, NULL, 0),
(111, 16, 'Baja Designs Squadron Sport', 'FOG-BAJA-111', 'Baja Designs','Squadron Sport LED pod lights. Spot or driving pattern.', 299.99, NULL, 1),
(112, 16, 'Rough Country LED Fog Light Kit', 'FOG-ROUG-112', 'Rough Country','Direct replacement LED fog lights with wiring harness.', 99.99,  NULL, 1),
(113, 16, 'Putco Luminix LED Fog Lights', 'FOG-PUTC-113', 'Putco',      'High-output LED fog lights with clear lens. 2400 lumens.', 159.99, NULL, 1),
(114, 16, 'ORACLE Lighting High Performance Fogs', 'FOG-ORAC-114', 'ORACLE',     'LED fog light conversion with plug-and-play harness.', 189.99, NULL, 0),
(115, 16, 'Spyder Auto OEM Fog Lights', 'FOG-SPYD-115', 'Spyder Auto','OEM-replacement fog lights with clear lens and H11 bulb.', 79.99,  NULL, 1),

-- ==========================================================================
-- CARGO > Bed Liners (CategoryId=17) — Products 116-124
-- ==========================================================================
(116, 17, 'BedRug Classic Bed Liner', 'BED-BEDR-116', 'BedRug',     'Full carpet-like bed liner. 100% waterproof, mold resistant.', 449.99, NULL, 1),
(117, 17, 'LINE-X Premium Spray-In Liner', 'BED-LINX-117', 'LINE-X',     'Factory-applied spray-in bed liner with UV protection.', 599.99, NULL, 1),
(118, 17, 'Husky Liners UltraGrip Bed Mat', 'BED-HUSK-118', 'Husky Liners','Heavy-duty rubberized bed mat with textured grip surface.', 149.99, NULL, 1),
(119, 17, 'Rugged Liner Over-Rail Bed Liner', 'BED-RUGL-119', 'Rugged Liner','One-piece over-rail polyethylene bed liner with tailgate liner.', 299.99, NULL, 0),
(120, 17, 'DualLiner Truck Bed Liner System', 'BED-DUAL-120', 'DualLiner',  'Five-piece custom-fit bed liner system with ZeroSkid rubber mat.', 489.99, NULL, 1),
(121, 17, 'BedRug XLT Bed Mat', 'BED-BEDR-121', 'BedRug',     'Polyester fiber bed mat with hook-and-loop installation.', 179.99, NULL, 1),
(122, 17, 'Rough Country Bed Mat', 'BED-ROUG-122', 'Rough Country','Heavy-duty recycled rubber bed mat. 3/8-inch thick.', 99.99,  NULL, 0),
(123, 17, 'WeatherTech TechLiner', 'BED-WEAT-123', 'WeatherTech','Custom-fit thermoplastic bed liner. No drilling required.', 189.99, NULL, 1),
(124, 17, 'Penda Bed Liner', 'BED-PEND-124', 'Penda',      'Drop-in pendaliner with built-in tailgate protector.', 249.99, NULL, 1),

-- ==========================================================================
-- CARGO > Tonneau Covers (CategoryId=18) — Products 125-135
-- ==========================================================================
(125, 18, 'BAKFlip MX4 Tonneau Cover', 'TON-BAKF-125', 'BAKFlip',    'Hard folding tonneau with matte finish. Aluminum panels, FRP top.', 1099.99,NULL, 1),
(126, 18, 'TruXedo TruXport Roll-Up Cover', 'TON-TRUX-126', 'TruXedo',    'Soft roll-up tonneau cover with quick-release clamp system.', 329.99, NULL, 1),
(127, 18, 'Roll-N-Lock M-Series Retractable', 'TON-ROLL-127', 'Roll-N-Lock','Retractable hard tonneau cover with integrated key lock.', 1499.99,NULL, 1),
(128, 18, 'Extang Trifecta 2.0 Tri-Fold', 'TON-EXTA-128', 'Extang',     'Soft tri-fold tonneau with engineered leather grain vinyl.', 449.99, NULL, 1),
(129, 18, 'BAKFlip G2 Hard Folding Cover', 'TON-BAKF-129', 'BAKFlip',    'Hard folding cover with durable FRP panels and prop rod system.', 899.99, NULL, 0),
(130, 18, 'Retrax RetraxPRO MX Retractable', 'TON-RETR-130', 'Retrax',     'Polycarbonate retractable tonneau with key-lockable positions.', 1349.99,NULL, 1),
(131, 18, 'Rough Country Soft Tri-Fold Cover', 'TON-ROUG-131', 'Rough Country','Budget-friendly soft tri-fold tonneau cover with clamp installation.', 279.99, NULL, 1),
(132, 18, 'UnderCover Flex Hard Folding', 'TON-UNDR-132', 'UnderCover', 'Hard folding cover with matte black finish and weather seals.', 949.99, NULL, 1),
(133, 18, 'Pace Edwards UltraGroove Retractable', 'TON-PACE-133', 'Pace Edwards','Metal retractable tonneau with powder-coated finish.', 1699.99,NULL, 0),
(134, 18, 'Access Original Roll-Up Cover', 'TON-ACCS-134', 'Access',     'Roll-up tonneau with patented AUTOLATCH II system.', 369.99, NULL, 1),
(135, 18, 'DiamondBack HD Tonneau', 'TON-DIAM-135', 'DiamondBack','Aluminum hard tonneau rated for 1,600 lbs. Haul-on-top design.', 2199.99,NULL, 1),

-- ==========================================================================
-- CARGO > Roof Racks (CategoryId=19) — Products 136-143
-- ==========================================================================
(136, 19, 'Yakima StreamLine Crossbar System', 'ROO-YAKI-136', 'Yakima',     'Aerodynamic crossbar system with JetStream bars. Low-profile.', 349.99, NULL, 1),
(137, 19, 'Thule WingBar Evo Rack System', 'ROO-THUL-137', 'Thule',      'Sleek aerodynamic crossbars with T-track mounting. Ultra-quiet.', 389.99, NULL, 1),
(138, 19, 'Rhino-Rack Vortex StealthBar', 'ROO-RHIN-138', 'Rhino-Rack', 'Low-profile aero crossbars with quick-release mounting.', 329.99, NULL, 1),
(139, 19, 'Yakima OverHaul HD Truck Rack', 'ROO-YAKI-139', 'Yakima',     'Heavy-duty adjustable truck bed rack. 500 lb capacity.', 699.99, NULL, 0),
(140, 19, 'Frontrunner Slimline II Rack Kit', 'ROO-FRNT-140', 'Front Runner','Full-length low-profile roof rack with modular accessory options.', 899.99, NULL, 1),
(141, 19, 'Thule CapRock Roof Platform', 'ROO-THUL-141', 'Thule',      'Full-size roof platform with integrated T-tracks and flush design.', 749.99, NULL, 1),
(142, 19, 'Prinsu Design Studio Roof Rack', 'ROO-PRIN-142', 'Prinsu',     'Low-profile cab-only roof rack. Modular with accessory mounts.', 599.99, NULL, 1),
(143, 19, 'CURT Roof Rack Crossbars', 'ROO-CURT-143', 'CURT',       'Universal-fit aluminum crossbars for side-rail mounted racks.', 149.99, NULL, 1),

-- ==========================================================================
-- CARGO > Bed Accessories (CategoryId=20) — Products 144-150
-- ==========================================================================
(144, 20, 'Putco LED Bed Rail Lights', 'BDA-PUTC-144', 'Putco',      'Blade LED bed rail light kit with switch. 15-inch strips.', 89.99,  NULL, 1),
(145, 20, 'Rough Country Molle Panel System', 'BDA-ROUG-145', 'Rough Country','Bed-side MOLLE panel system for modular storage and gear.', 199.99, NULL, 1),
(146, 20, 'DECKED Truck Bed Storage System', 'BDA-DECK-146', 'DECKED',     'Full-size sliding drawer bed storage. 200 lb per drawer.', 1299.99,NULL, 1),
(147, 20, 'BullRing Truck Bed Tie-Down Anchors', 'BDA-BULL-147', 'BullRing',   'Retractable flush-mount tie-down anchors. Set of 4.', 79.99,  NULL, 0),
(148, 20, 'AMP Research BedXTender HD Max', 'BDA-AMP-148',  'AMP Research','Flip-out bed extender that adds 2 feet of cargo space.', 349.99, NULL, 1),
(149, 20, 'Yakima BedRock HD Truck Rack', 'BDA-YAKI-149', 'Yakima',     'Heavy-duty truck bed rack towers. Pairs with crossbars.', 399.99, NULL, 1),
(150, 20, 'WeatherTech Roll-Up Truck Bed Mat', 'BDA-WEAT-150', 'WeatherTech','Roll-up rubber truck bed mat with raised edges.', 139.99, NULL, 1);

SET IDENTITY_INSERT Products OFF;
