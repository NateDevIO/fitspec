-- ============================================================================
-- FitSpec Seed Data: Fitment Mappings
-- 500+ mappings between products and vehicles with realistic compatibility.
-- InstallDifficulty: 1=bolt-on, 2=easy, 3=moderate, 4=advanced, 5=professional
-- IsVerified ~70%
-- ============================================================================

SET IDENTITY_INSERT FitmentMappings ON;

INSERT INTO FitmentMappings (Id, ProductId, VehicleId, InstallDifficulty, IsVerified, FitmentNotes) VALUES
-- ==========================================================================
-- TRAILER HITCHES (Products 1-12) -> Trucks, SUVs
-- ==========================================================================
-- CURT Class III Receiver Hitch (Product 1) — fits many trucks/SUVs
(1,   1,  1,  2, 1, 'Direct bolt-on replacement. No drilling required.'),
(2,   1,  2,  2, 1, NULL),
(3,   1,  5,  2, 1, NULL),
(4,   1,  9,  2, 1, NULL),
(5,   1, 21,  2, 1, 'Direct bolt-on. Uses factory frame holes.'),
(6,   1, 22,  2, 1, NULL),
(7,   1, 36,  2, 1, NULL),
(8,   1, 41,  2, 1, NULL),
(9,   1, 50,  2, 1, NULL),
(10,  1, 52,  2, 1, NULL),
(11,  1, 69,  2, 1, NULL),
(12,  1, 74,  2, 1, NULL),
(13,  1, 81,  2, 1, NULL),
(14,  1, 83,  2, 1, NULL),
(15,  1, 60,  2, 1, NULL),

-- Draw-Tite Max-Frame Hitch (Product 2) — full-size trucks
(16,  2,  1,  2, 1, NULL),
(17,  2,  3,  2, 1, 'Max-Frame design for added strength.'),
(18,  2,  4,  2, 1, NULL),
(19,  2, 21,  2, 1, NULL),
(20,  2, 23,  2, 1, NULL),
(21,  2, 41,  2, 1, NULL),
(22,  2, 42,  2, 1, NULL),
(23,  2, 50,  2, 1, NULL),
(24,  2, 53,  2, 0, NULL),
(25,  2, 74,  2, 1, NULL),
(26,  2, 75,  2, 1, NULL),
(27,  2, 83,  2, 1, NULL),

-- B&W Turnoverball Gooseneck (Product 3) — heavy-duty trucks only
(28,  3,  1,  4, 1, 'Requires cutting bed floor for ball pocket.'),
(29,  3,  3,  4, 1, 'Professional installation recommended.'),
(30,  3, 21,  4, 1, NULL),
(31,  3, 22,  4, 1, NULL),
(32,  3, 41,  4, 1, NULL),
(33,  3, 50,  4, 1, NULL),
(34,  3, 53,  4, 0, NULL),
(35,  3, 55,  4, 1, 'Ideal for heavy towing applications.'),
(36,  3, 56,  4, 1, NULL),
(37,  3, 58,  4, 1, NULL),
(38,  3, 74,  4, 1, NULL),
(39,  3, 75,  4, 0, NULL),

-- Reese Towpower Class IV (Product 4) — full-size trucks and large SUVs
(40,  4,  1,  2, 1, NULL),
(41,  4,  2,  2, 1, NULL),
(42,  4, 21,  2, 1, NULL),
(43,  4, 31,  2, 1, NULL),
(44,  4, 41,  2, 1, NULL),
(45,  4, 50,  2, 0, NULL),
(46,  4, 55,  2, 1, NULL),
(47,  4, 74,  2, 1, NULL),
(48,  4, 79,  2, 1, NULL),

-- CURT Front Mount Hitch (Product 5) — trucks
(49,  5,  1,  3, 1, 'May require minor trimming of air dam.'),
(50,  5, 21,  3, 1, NULL),
(51,  5, 50,  3, 0, NULL),
(52,  5, 55,  3, 1, NULL),

-- Husky Towing Class III (Product 6) — mid-size trucks/SUVs
(53,  6,  9,  2, 1, NULL),
(54,  6, 10,  2, 1, NULL),
(55,  6, 28,  2, 1, NULL),
(56,  6, 36,  2, 1, NULL),
(57,  6, 60,  2, 0, NULL),
(58,  6, 77,  2, 1, NULL),
(59,  6, 81,  2, 1, NULL),
(60,  6, 87,  2, 1, NULL),

-- EcoHitch Hidden (Product 7) — SUVs and crossovers
(61,  7, 13,  3, 1, 'Hidden design maintains factory bumper appearance.'),
(62,  7, 34,  3, 1, NULL),
(63,  7, 48,  3, 1, NULL),
(64,  7, 64,  3, 0, NULL),
(65,  7, 89,  3, 1, NULL),
(66,  7, 91,  3, 1, NULL),
(67,  7, 98,  3, 1, NULL),
(68,  7,103,  3, 1, NULL),

-- Draw-Tite Sportframe (Product 8) — small SUVs/crossovers
(69,  8, 34,  2, 1, NULL),
(70,  8, 35,  2, 1, NULL),
(71,  8, 49,  2, 0, NULL),
(72,  8, 64,  2, 1, NULL),
(73,  8, 65,  2, 1, NULL),
(74,  8, 86,  2, 1, NULL),
(75,  8, 94,  2, 1, NULL),
(76,  8, 97,  2, 1, NULL),
(77,  8,100,  2, 0, NULL),

-- Smittybilt JH46 (Product 10) — Jeep Wrangler/Gladiator
(78, 10, 66,  2, 1, 'Designed specifically for JL platform.'),
(79, 10, 67,  2, 1, NULL),
(80, 10, 68,  2, 1, NULL),
(81, 10, 69,  2, 1, NULL),

-- WeatherTech BumpStep XL (Product 11) — universal 2-inch receivers
(82, 11,  1,  1, 1, 'Fits any 2-inch receiver. No tools required.'),
(83, 11, 21,  1, 1, NULL),
(84, 11, 31,  1, 1, NULL),
(85, 11, 50,  1, 1, NULL),
(86, 11, 72,  1, 1, NULL),
(87, 11, 85,  1, 0, NULL),

-- ==========================================================================
-- WIRING HARNESSES (Products 13-22) -> Trucks, SUVs
-- ==========================================================================
-- CURT T-Connector (Product 13) — broad truck/SUV fitment
(88, 13,  1,  1, 1, 'Plug-and-play. No wire splicing needed.'),
(89, 13,  2,  1, 1, NULL),
(90, 13,  5,  1, 1, NULL),
(91, 13,  9,  1, 1, NULL),
(92, 13, 21,  1, 1, NULL),
(93, 13, 23,  1, 1, NULL),
(94, 13, 36,  1, 1, NULL),
(95, 13, 38,  1, 1, NULL),
(96, 13, 41,  1, 1, NULL),
(97, 13, 50,  1, 1, NULL),
(98, 13, 52,  1, 1, NULL),
(99, 13, 60,  1, 0, NULL),
(100,13, 69,  1, 1, NULL),
(101,13, 74,  1, 1, NULL),
(102,13, 81,  1, 1, NULL),

-- Tekonsha OEM Replacement (Product 14) — premium trucks
(103,14,  1,  1, 1, NULL),
(104,14,  2,  1, 1, NULL),
(105,14,  3,  1, 1, NULL),
(106,14, 21,  1, 1, 'OEM-quality replacement harness.'),
(107,14, 22,  1, 1, NULL),
(108,14, 41,  1, 1, NULL),
(109,14, 42,  1, 0, NULL),
(110,14, 50,  1, 1, NULL),
(111,14, 53,  1, 1, NULL),
(112,14, 74,  1, 1, NULL),
(113,14, 75,  1, 1, NULL),
(114,14, 83,  1, 1, NULL),

-- Hopkins Plug-In Simple (Product 15) — mid-size trucks and SUVs
(115,15, 9,   1, 1, NULL),
(116,15, 13,  1, 1, NULL),
(117,15, 28,  1, 1, NULL),
(118,15, 36,  1, 1, NULL),
(119,15, 45,  1, 0, NULL),
(120,15, 60,  1, 1, NULL),
(121,15, 62,  1, 1, NULL),
(122,15, 72,  1, 1, NULL),
(123,15, 77,  1, 1, NULL),
(124,15, 81,  1, 1, NULL),
(125,15, 85,  1, 1, NULL),
(126,15, 87,  1, 0, NULL),

-- Bargman 7-Way Connector Kit (Product 17) — heavy-duty trucks
(127,17,  1,  2, 1, NULL),
(128,17,  3,  2, 1, NULL),
(129,17, 21,  2, 1, NULL),
(130,17, 41,  2, 1, NULL),
(131,17, 50,  2, 1, NULL),
(132,17, 55,  2, 1, 'Full 7-way for trailer brakes and aux power.'),
(133,17, 58,  2, 0, NULL),
(134,17, 74,  2, 1, NULL),

-- Tekonsha ZCI (Product 20) — newer model trucks
(135,20,  1,  1, 1, 'Zero-contact interface. No physical splicing.'),
(136,20,  2,  1, 1, NULL),
(137,20, 21,  1, 1, NULL),
(138,20, 22,  1, 1, NULL),
(139,20, 50,  1, 1, NULL),
(140,20, 51,  1, 0, NULL),

-- ==========================================================================
-- BALL MOUNTS (Products 23-31) -> universal / receiver-based
-- ==========================================================================
-- CURT Adjustable Ball Mount (Product 23) — universal
(141,23,  1,  1, 1, 'Fits any 2-inch receiver. Adjustable drop/rise.'),
(142,23,  2,  1, 1, NULL),
(143,23, 21,  1, 1, NULL),
(144,23, 36,  1, 1, NULL),
(145,23, 41,  1, 1, NULL),
(146,23, 50,  1, 1, NULL),
(147,23, 55,  1, 0, NULL),
(148,23, 60,  1, 1, NULL),
(149,23, 69,  1, 1, NULL),
(150,23, 74,  1, 1, NULL),
(151,23, 81,  1, 1, NULL),
(152,23, 83,  1, 1, NULL),
(153,23, 87,  1, 1, NULL),

-- B&W Tow & Stow (Product 24) — universal premium
(154,24,  1,  1, 1, NULL),
(155,24,  3,  1, 1, NULL),
(156,24, 21,  1, 1, NULL),
(157,24, 22,  1, 1, NULL),
(158,24, 41,  1, 1, NULL),
(159,24, 50,  1, 1, NULL),
(160,24, 53,  1, 0, NULL),
(161,24, 55,  1, 1, NULL),
(162,24, 74,  1, 1, NULL),
(163,24, 75,  1, 1, NULL),
(164,24, 83,  1, 1, NULL),

-- Blue Ox BX88302 (Product 25) — premium trucks
(165,25,  1,  1, 1, NULL),
(166,25, 21,  1, 1, NULL),
(167,25, 41,  1, 1, NULL),
(168,25, 50,  1, 1, NULL),
(169,25, 74,  1, 0, NULL),

-- Weigh Safe Adjustable (Product 30) — universal premium
(170,30,  1,  1, 1, 'Built-in tongue weight scale.'),
(171,30,  3,  1, 1, NULL),
(172,30, 21,  1, 1, NULL),
(173,30, 50,  1, 1, NULL),
(174,30, 55,  1, 1, NULL),
(175,30, 74,  1, 0, NULL),

-- ==========================================================================
-- BRAKE CONTROLLERS (Products 32-40) -> Trucks
-- ==========================================================================
-- Tekonsha Prodigy P3 (Product 32)
(176,32,  1,  2, 1, NULL),
(177,32,  2,  2, 1, NULL),
(178,32,  3,  2, 1, NULL),
(179,32, 21,  2, 1, NULL),
(180,32, 41,  2, 1, NULL),
(181,32, 50,  2, 1, 'Premium proportional braking for heavy loads.'),
(182,32, 55,  2, 1, NULL),
(183,32, 58,  2, 0, NULL),
(184,32, 74,  2, 1, NULL),
(185,32, 83,  2, 1, NULL),

-- CURT TriFlex (Product 33)
(186,33,  1,  2, 1, NULL),
(187,33,  5,  2, 1, NULL),
(188,33,  9,  2, 1, NULL),
(189,33, 21,  2, 1, NULL),
(190,33, 36,  2, 1, NULL),
(191,33, 50,  2, 0, NULL),
(192,33, 69,  2, 1, NULL),
(193,33, 74,  2, 1, NULL),
(194,33, 81,  2, 1, NULL),

-- CURT Echo Mobile (Product 36) — Bluetooth controller
(195,36,  1,  1, 1, 'Wireless Bluetooth connection. Smartphone required.'),
(196,36,  2,  1, 1, NULL),
(197,36, 21,  1, 1, NULL),
(198,36, 41,  1, 1, NULL),
(199,36, 50,  1, 1, NULL),
(200,36,101,  1, 1, NULL),
(201,36,104,  1, 0, NULL),

-- ==========================================================================
-- RUNNING BOARDS (Products 41-50) -> Trucks, SUVs
-- ==========================================================================
-- N-Fab Podium LG (Product 41)
(202,41,  1,  2, 1, NULL),
(203,41,  2,  2, 1, NULL),
(204,41, 21,  2, 1, NULL),
(205,41, 23,  2, 1, NULL),
(206,41, 36,  2, 1, NULL),
(207,41, 41,  2, 1, NULL),
(208,41, 50,  2, 1, NULL),
(209,41, 74,  2, 0, NULL),

-- Westin HDX Drop Steps (Product 42)
(210,42,  1,  2, 1, 'Direct bolt-on with included hardware.'),
(211,42,  2,  2, 1, NULL),
(212,42,  3,  2, 1, NULL),
(213,42,  9,  2, 1, NULL),
(214,42, 21,  2, 1, NULL),
(215,42, 22,  2, 1, NULL),
(216,42, 41,  2, 1, NULL),
(217,42, 42,  2, 0, NULL),
(218,42, 50,  2, 1, NULL),
(219,42, 52,  2, 1, NULL),
(220,42, 55,  2, 1, NULL),
(221,42, 69,  2, 1, NULL),
(222,42, 74,  2, 1, NULL),
(223,42, 75,  2, 1, NULL),
(224,42, 83,  2, 0, NULL),

-- AMP Research PowerStep (Product 43) — premium trucks/SUVs
(225,43,  1,  4, 1, 'Professional installation recommended. Wiring required.'),
(226,43,  2,  4, 1, NULL),
(227,43, 21,  4, 1, NULL),
(228,43, 22,  4, 1, NULL),
(229,43, 41,  4, 1, NULL),
(230,43, 50,  4, 1, NULL),
(231,43, 53,  4, 0, NULL),
(232,43, 55,  4, 1, NULL),
(233,43, 74,  4, 1, NULL),

-- Rough Country HD2 (Product 44) — budget trucks
(234,44,  1,  2, 1, NULL),
(235,44,  5,  2, 1, NULL),
(236,44,  6,  2, 0, NULL),
(237,44,  7,  2, 1, NULL),
(238,44, 21,  2, 1, NULL),
(239,44, 25,  2, 1, NULL),
(240,44, 36,  2, 1, NULL),
(241,44, 38,  2, 1, NULL),
(242,44, 50,  2, 1, NULL),
(243,44, 54,  2, 0, NULL),
(244,44, 74,  2, 1, NULL),
(245,44, 76,  2, 1, NULL),
(246,44, 81,  2, 1, NULL),
(247,44, 84,  2, 1, NULL),

-- Westin R7 Nerf Steps (Product 46) — SUVs
(248,46, 13,  2, 1, NULL),
(249,46, 31,  2, 1, NULL),
(250,46, 45,  2, 1, NULL),
(251,46, 62,  2, 0, NULL),
(252,46, 66,  2, 1, NULL),
(253,46, 72,  2, 1, NULL),
(254,46, 79,  2, 1, NULL),
(255,46, 85,  2, 1, NULL),
(256,46, 92,  2, 1, NULL),
(257,46, 95,  2, 0, NULL),

-- ==========================================================================
-- FENDER FLARES (Products 51-59) -> Trucks, Jeeps
-- ==========================================================================
-- Bushwacker Pocket Style (Product 51)
(258,51,  1,  2, 1, NULL),
(259,51,  2,  2, 1, NULL),
(260,51,  5,  2, 1, NULL),
(261,51, 21,  2, 1, 'Pocket-bolt style with OEM-quality fit.'),
(262,51, 23,  2, 1, NULL),
(263,51, 36,  2, 1, NULL),
(264,51, 41,  2, 0, NULL),
(265,51, 50,  2, 1, NULL),
(266,51, 74,  2, 1, NULL),
(267,51, 81,  2, 1, NULL),

-- Bushwacker Extend-A-Fender (Product 52)
(268,52,  1,  2, 1, NULL),
(269,52,  7,  2, 1, NULL),
(270,52,  9,  2, 0, NULL),
(271,52, 21,  2, 1, NULL),
(272,52, 36,  2, 1, NULL),
(273,52, 50,  2, 1, NULL),
(274,52, 69,  2, 1, NULL),
(275,52, 74,  2, 1, NULL),

-- Rough Country Pocket Fender Flares (Product 54)
(276,54,  1,  2, 0, NULL),
(277,54,  5,  2, 1, NULL),
(278,54,  7,  2, 1, NULL),
(279,54, 21,  2, 1, NULL),
(280,54, 25,  2, 1, NULL),
(281,54, 36,  2, 0, NULL),
(282,54, 50,  2, 1, NULL),
(283,54, 74,  2, 1, NULL),

-- Smittybilt M1 (Product 55) — Jeeps and trucks
(284,55, 66,  3, 1, 'Integrated LED markers require wiring.'),
(285,55, 67,  3, 1, NULL),
(286,55, 68,  3, 1, NULL),
(287,55, 69,  3, 0, NULL),
(288,55, 71,  3, 1, NULL),

-- Mopar Production Flares (Product 57) — RAM trucks
(289,57, 50,  2, 1, 'Factory Mopar part for perfect fit.'),
(290,57, 51,  2, 1, NULL),
(291,57, 52,  2, 1, NULL),
(292,57, 53,  2, 1, NULL),
(293,57, 54,  2, 0, NULL),
(294,57, 55,  2, 1, NULL),

-- ==========================================================================
-- MUD FLAPS (Products 60-68) -> Trucks, SUVs
-- ==========================================================================
-- WeatherTech No-Drill (Product 60)
(295,60,  1,  1, 1, 'No-drill installation with proprietary fasteners.'),
(296,60,  2,  1, 1, NULL),
(297,60,  9,  1, 1, NULL),
(298,60, 13,  1, 1, NULL),
(299,60, 21,  1, 1, NULL),
(300,60, 31,  1, 1, NULL),
(301,60, 36,  1, 1, NULL),
(302,60, 41,  1, 0, NULL),
(303,60, 45,  1, 1, NULL),
(304,60, 50,  1, 1, NULL),
(305,60, 62,  1, 1, NULL),
(306,60, 66,  1, 1, NULL),
(307,60, 72,  1, 1, NULL),
(308,60, 74,  1, 1, NULL),
(309,60, 85,  1, 0, NULL),
(310,60, 89,  1, 1, NULL),
(311,60, 92,  1, 1, NULL),

-- Husky Liners Custom Mud Guards (Product 61)
(312,61,  1,  1, 1, NULL),
(313,61, 21,  1, 1, NULL),
(314,61, 36,  1, 1, NULL),
(315,61, 41,  1, 1, NULL),
(316,61, 50,  1, 1, NULL),
(317,61, 60,  1, 0, NULL),
(318,61, 69,  1, 1, NULL),
(319,61, 74,  1, 1, NULL),
(320,61, 81,  1, 1, NULL),
(321,61, 87,  1, 1, NULL),

-- Mopar Splash Guards (Product 68) — RAM and Jeep
(322,68, 50,  1, 1, NULL),
(323,68, 51,  1, 1, NULL),
(324,68, 52,  1, 1, NULL),
(325,68, 55,  1, 0, NULL),
(326,68, 66,  1, 1, NULL),
(327,68, 67,  1, 1, NULL),
(328,68, 69,  1, 1, NULL),
(329,68, 72,  1, 1, NULL),

-- ==========================================================================
-- GRILLE GUARDS (Products 69-77) -> Trucks, SUVs
-- ==========================================================================
-- Ranch Hand Legend (Product 69)
(330,69,  1,  3, 1, 'Requires removal of factory bumper.'),
(331,69,  3,  3, 1, NULL),
(332,69, 21,  3, 1, NULL),
(333,69, 22,  3, 1, NULL),
(334,69, 41,  3, 0, NULL),
(335,69, 42,  3, 1, NULL),
(336,69, 50,  3, 1, NULL),
(337,69, 53,  3, 1, NULL),
(338,69, 55,  3, 1, NULL),
(339,69, 74,  3, 1, NULL),
(340,69, 83,  3, 0, NULL),

-- Westin HDX Grille Guard (Product 70)
(341,70,  1,  3, 1, NULL),
(342,70,  2,  3, 1, NULL),
(343,70,  5,  3, 1, NULL),
(344,70,  7,  3, 1, NULL),
(345,70, 21,  3, 1, NULL),
(346,70, 23,  3, 0, NULL),
(347,70, 41,  3, 1, NULL),
(348,70, 50,  3, 1, NULL),
(349,70, 52,  3, 1, NULL),
(350,70, 74,  3, 1, NULL),
(351,70, 81,  3, 1, NULL),
(352,70, 83,  3, 0, NULL),

-- Lund Bull Bar with LED (Product 75)
(353,75,  1,  2, 1, NULL),
(354,75,  9,  2, 0, NULL),
(355,75, 21,  2, 1, NULL),
(356,75, 28,  2, 1, NULL),
(357,75, 36,  2, 1, NULL),
(358,75, 50,  2, 1, NULL),
(359,75, 69,  2, 1, NULL),
(360,75, 74,  2, 1, NULL),
(361,75, 77,  2, 0, NULL),
(362,75, 81,  2, 1, NULL),

-- ==========================================================================
-- HEADLIGHTS (Products 78-87) -> Vehicle-specific
-- ==========================================================================
-- Morimoto XB LED (Product 78) — Ford F-150
(363,78,  1,  3, 1, 'Direct plug-and-play. No modifications needed.'),
(364,78,  2,  3, 1, NULL),
(365,78,  4,  3, 1, NULL),
(366,78,  5,  3, 1, NULL),
(367,78,  6,  3, 0, NULL),
(368,78,  7,  3, 1, NULL),
(369,78,  8,  3, 1, NULL),

-- Morimoto XB LED — Silverado
(370,78, 21,  3, 1, NULL),
(371,78, 22,  3, 1, NULL),
(372,78, 23,  3, 1, NULL),

-- AlphaRex NOVA (Product 79) — F-150, RAM, Silverado, Tacoma
(373,79,  1,  3, 1, NULL),
(374,79,  2,  3, 1, NULL),
(375,79, 21,  3, 1, NULL),
(376,79, 36,  3, 1, NULL),
(377,79, 37,  3, 0, NULL),
(378,79, 50,  3, 1, NULL),
(379,79, 52,  3, 1, NULL),

-- Spyder Auto PRO-YD (Product 80) — broad fitment
(380,80,  1,  2, 1, NULL),
(381,80,  5,  2, 1, NULL),
(382,80,  7,  2, 0, NULL),
(383,80, 21,  2, 1, NULL),
(384,80, 25,  2, 1, NULL),
(385,80, 36,  2, 1, NULL),
(386,80, 39,  2, 1, NULL),
(387,80, 50,  2, 1, NULL),
(388,80, 54,  2, 0, NULL),

-- Rough Country LED Headlight Kit (Product 83) — universal bulb upgrade
(389,83,  1,  1, 1, 'Drop-in LED bulb. Fits H11, 9005, 9006 sockets.'),
(390,83, 13,  1, 1, NULL),
(391,83, 21,  1, 1, NULL),
(392,83, 31,  1, 1, NULL),
(393,83, 36,  1, 1, NULL),
(394,83, 45,  1, 0, NULL),
(395,83, 50,  1, 1, NULL),
(396,83, 60,  1, 1, NULL),
(397,83, 62,  1, 1, NULL),
(398,83, 66,  1, 1, NULL),
(399,83, 69,  1, 1, NULL),
(400,83, 74,  1, 1, NULL),
(401,83, 81,  1, 0, NULL),
(402,83, 85,  1, 1, NULL),
(403,83, 89,  1, 1, NULL),

-- ==========================================================================
-- TAIL LIGHTS (Products 88-96) -> Vehicle-specific
-- ==========================================================================
-- Morimoto XB Tail Lights (Product 88)
(404,88,  1,  2, 1, NULL),
(405,88,  2,  2, 1, NULL),
(406,88,  5,  2, 1, NULL),
(407,88, 21,  2, 1, NULL),
(408,88, 36,  2, 0, NULL),

-- AlphaRex PRO Tails (Product 89)
(409,89,  1,  2, 1, NULL),
(410,89, 21,  2, 1, NULL),
(411,89, 36,  2, 1, NULL),
(412,89, 50,  2, 1, NULL),

-- Spyder Auto LED Tails (Product 90) — budget broad fitment
(413,90,  1,  2, 1, NULL),
(414,90,  5,  2, 0, NULL),
(415,90,  7,  2, 1, NULL),
(416,90, 21,  2, 1, NULL),
(417,90, 25,  2, 1, NULL),
(418,90, 36,  2, 1, NULL),
(419,90, 50,  2, 1, NULL),
(420,90, 54,  2, 0, NULL),
(421,90, 69,  2, 1, NULL),
(422,90, 74,  2, 1, NULL),

-- ==========================================================================
-- LIGHT BARS (Products 97-106) -> Trucks, Jeeps, SUVs
-- ==========================================================================
-- Rigid E-Series 50-inch (Product 97)
(423,97,  1,  3, 1, 'Requires roof mount brackets (sold separately).'),
(424,97, 21,  3, 1, NULL),
(425,97, 41,  3, 1, NULL),
(426,97, 50,  3, 1, NULL),
(427,97, 55,  3, 0, NULL),
(428,97, 66,  3, 1, NULL),
(429,97, 74,  3, 1, NULL),

-- KC HiLiTES C-Series (Product 98)
(430,98,  1,  3, 1, NULL),
(431,98,  9,  3, 1, NULL),
(432,98, 21,  3, 1, NULL),
(433,98, 36,  3, 0, NULL),
(434,98, 41,  3, 1, NULL),
(435,98, 50,  3, 1, NULL),
(436,98, 66,  3, 1, NULL),
(437,98, 69,  3, 1, NULL),
(438,98, 74,  3, 1, NULL),

-- Rough Country 30-inch Curved (Product 99) — budget light bar
(439,99,  1,  2, 1, NULL),
(440,99,  5,  2, 1, NULL),
(441,99,  9,  2, 0, NULL),
(442,99, 21,  2, 1, NULL),
(443,99, 28,  2, 1, NULL),
(444,99, 36,  2, 1, NULL),
(445,99, 50,  2, 1, NULL),
(446,99, 66,  2, 1, NULL),
(447,99, 69,  2, 1, NULL),
(448,99, 74,  2, 0, NULL),
(449,99, 77,  2, 1, NULL),
(450,99, 81,  2, 1, NULL),

-- Nilight 22-inch (Product 102) — universal budget bar
(451,102,  1,  2, 1, NULL),
(452,102, 21,  2, 1, NULL),
(453,102, 36,  2, 0, NULL),
(454,102, 50,  2, 1, NULL),
(455,102, 66,  2, 1, NULL),
(456,102, 69,  2, 1, NULL),

-- ==========================================================================
-- FOG LIGHTS (Products 107-115) -> Vehicle-specific
-- ==========================================================================
-- Morimoto XB Fog (Product 107)
(457,107,  1,  2, 1, 'Direct OEM fog light replacement.'),
(458,107,  2,  2, 1, NULL),
(459,107,  5,  2, 1, NULL),
(460,107, 21,  2, 1, NULL),
(461,107, 22,  2, 0, NULL),
(462,107, 36,  2, 1, NULL),
(463,107, 41,  2, 1, NULL),
(464,107, 50,  2, 1, NULL),
(465,107, 74,  2, 1, NULL),

-- Diode Dynamics SS3 Sport Fog (Product 108)
(466,108,  1,  2, 1, NULL),
(467,108,  9,  2, 1, NULL),
(468,108, 13,  2, 1, NULL),
(469,108, 21,  2, 0, NULL),
(470,108, 36,  2, 1, NULL),
(471,108, 45,  2, 1, NULL),
(472,108, 50,  2, 1, NULL),
(473,108, 66,  2, 1, NULL),
(474,108, 69,  2, 1, NULL),
(475,108, 72,  2, 1, NULL),
(476,108, 74,  2, 1, NULL),

-- Rough Country LED Fog Light Kit (Product 112) — budget
(477,112,  1,  1, 1, NULL),
(478,112, 21,  1, 0, NULL),
(479,112, 36,  1, 1, NULL),
(480,112, 50,  1, 1, NULL),
(481,112, 66,  1, 1, NULL),
(482,112, 69,  1, 1, NULL),
(483,112, 74,  1, 1, NULL),
(484,112, 81,  1, 1, NULL),

-- ==========================================================================
-- BED LINERS (Products 116-124) -> Trucks only
-- ==========================================================================
-- BedRug Classic (Product 116)
(485,116,  1,  2, 1, 'Custom-molded for specific truck bed.'),
(486,116,  2,  2, 1, NULL),
(487,116,  5,  2, 1, NULL),
(488,116,  9,  2, 1, NULL),
(489,116, 21,  2, 1, NULL),
(490,116, 23,  2, 0, NULL),
(491,116, 36,  2, 1, NULL),
(492,116, 41,  2, 1, NULL),
(493,116, 50,  2, 1, NULL),
(494,116, 55,  2, 1, NULL),
(495,116, 69,  2, 1, NULL),
(496,116, 74,  2, 1, NULL),
(497,116, 81,  2, 0, NULL),
(498,116, 83,  2, 1, NULL),

-- LINE-X Premium Spray-In (Product 117) — professional application
(499,117,  1,  5, 1, 'Professional spray-in application required.'),
(500,117,  2,  5, 1, NULL),
(501,117, 21,  5, 1, NULL),
(502,117, 41,  5, 1, NULL),
(503,117, 50,  5, 1, NULL),
(504,117, 55,  5, 0, NULL),
(505,117, 69,  5, 1, NULL),
(506,117, 74,  5, 1, NULL),

-- Husky Liners UltraGrip Bed Mat (Product 118) — drop-in
(507,118,  1,  1, 1, 'Drop-in installation. No adhesive needed.'),
(508,118,  9,  1, 1, NULL),
(509,118, 21,  1, 1, NULL),
(510,118, 28,  1, 0, NULL),
(511,118, 36,  1, 1, NULL),
(512,118, 50,  1, 1, NULL),
(513,118, 60,  1, 1, NULL),
(514,118, 69,  1, 1, NULL),
(515,118, 74,  1, 1, NULL),
(516,118, 77,  1, 1, NULL),
(517,118, 81,  1, 1, NULL),
(518,118, 87,  1, 0, NULL),

-- ==========================================================================
-- TONNEAU COVERS (Products 125-135) -> Trucks only
-- ==========================================================================
-- BAKFlip MX4 (Product 125)
(519,125,  1,  2, 1, 'Clamp-on installation. No drilling required.'),
(520,125,  2,  2, 1, NULL),
(521,125,  5,  2, 1, NULL),
(522,125,  9,  2, 1, NULL),
(523,125, 21,  2, 1, NULL),
(524,125, 23,  2, 0, NULL),
(525,125, 36,  2, 1, NULL),
(526,125, 41,  2, 1, NULL),
(527,125, 42,  2, 1, NULL),
(528,125, 50,  2, 1, NULL),
(529,125, 55,  2, 1, NULL),
(530,125, 69,  2, 1, NULL),
(531,125, 74,  2, 1, NULL),
(532,125, 81,  2, 0, NULL),
(533,125, 83,  2, 1, NULL),
(534,125, 87,  2, 1, NULL),

-- TruXedo TruXport (Product 126) — budget roll-up
(535,126,  1,  1, 1, NULL),
(536,126,  5,  1, 1, NULL),
(537,126,  9,  1, 1, NULL),
(538,126, 21,  1, 1, NULL),
(539,126, 28,  1, 1, NULL),
(540,126, 36,  1, 0, NULL),
(541,126, 41,  1, 1, NULL),
(542,126, 50,  1, 1, NULL),
(543,126, 60,  1, 1, NULL),
(544,126, 69,  1, 1, NULL),
(545,126, 74,  1, 1, NULL),
(546,126, 77,  1, 0, NULL),
(547,126, 81,  1, 1, NULL),

-- Roll-N-Lock M-Series (Product 127) — premium retractable
(548,127,  1,  3, 1, 'Requires rail installation along bed sides.'),
(549,127,  2,  3, 1, NULL),
(550,127, 21,  3, 1, NULL),
(551,127, 41,  3, 1, NULL),
(552,127, 50,  3, 1, NULL),
(553,127, 55,  3, 0, NULL),
(554,127, 74,  3, 1, NULL),

-- Extang Trifecta 2.0 (Product 128)
(555,128,  1,  1, 1, NULL),
(556,128,  9,  1, 1, NULL),
(557,128, 21,  1, 1, NULL),
(558,128, 36,  1, 1, NULL),
(559,128, 50,  1, 0, NULL),
(560,128, 69,  1, 1, NULL),
(561,128, 74,  1, 1, NULL),
(562,128, 81,  1, 1, NULL),

-- Rough Country Soft Tri-Fold (Product 131) — budget
(563,131,  1,  1, 1, NULL),
(564,131,  5,  1, 0, NULL),
(565,131,  9,  1, 1, NULL),
(566,131, 21,  1, 1, NULL),
(567,131, 28,  1, 1, NULL),
(568,131, 36,  1, 1, NULL),
(569,131, 50,  1, 1, NULL),
(570,131, 69,  1, 1, NULL),
(571,131, 74,  1, 0, NULL),
(572,131, 81,  1, 1, NULL),

-- ==========================================================================
-- ROOF RACKS (Products 136-143) -> SUVs, crossovers
-- ==========================================================================
-- Yakima StreamLine (Product 136)
(573,136, 13,  2, 1, NULL),
(574,136, 31,  2, 1, NULL),
(575,136, 45,  2, 1, NULL),
(576,136, 48,  2, 1, NULL),
(577,136, 62,  2, 0, NULL),
(578,136, 72,  2, 1, NULL),
(579,136, 79,  2, 1, NULL),
(580,136, 85,  2, 1, NULL),
(581,136, 89,  2, 1, NULL),
(582,136, 92,  2, 1, NULL),
(583,136, 95,  2, 1, NULL),
(584,136, 98,  2, 0, NULL),
(585,136,103,  2, 1, NULL),
(586,136,106,  2, 1, NULL),

-- Thule WingBar Evo (Product 137)
(587,137, 13,  2, 1, NULL),
(588,137, 31,  2, 1, NULL),
(589,137, 34,  2, 1, NULL),
(590,137, 45,  2, 1, NULL),
(591,137, 62,  2, 0, NULL),
(592,137, 72,  2, 1, NULL),
(593,137, 85,  2, 1, NULL),
(594,137, 89,  2, 1, NULL),
(595,137, 92,  2, 1, NULL),
(596,137, 94,  2, 1, NULL),
(597,137, 95,  2, 0, NULL),
(598,137, 97,  2, 1, NULL),
(599,137,103,  2, 1, NULL),

-- Front Runner Slimline II (Product 140) — off-road SUVs
(600,140, 45,  3, 1, 'Full-length platform with modular T-track.'),
(601,140, 47,  3, 1, NULL),
(602,140, 66,  3, 1, NULL),
(603,140, 67,  3, 0, NULL),
(604,140, 72,  3, 1, NULL),
(605,140, 79,  3, 1, NULL),
(606,140, 89,  3, 1, NULL),
(607,140,106,  3, 1, NULL),

-- CURT Roof Rack Crossbars (Product 143) — budget universal
(608,143, 13,  1, 1, NULL),
(609,143, 31,  1, 0, NULL),
(610,143, 48,  1, 1, NULL),
(611,143, 62,  1, 1, NULL),
(612,143, 64,  1, 1, NULL),
(613,143, 85,  1, 1, NULL),
(614,143, 89,  1, 1, NULL),
(615,143, 98,  1, 1, NULL),

-- ==========================================================================
-- BED ACCESSORIES (Products 144-150) -> Trucks
-- ==========================================================================
-- Putco LED Bed Rail Lights (Product 144)
(616,144,  1,  2, 1, NULL),
(617,144, 21,  2, 1, NULL),
(618,144, 36,  2, 1, NULL),
(619,144, 50,  2, 0, NULL),
(620,144, 69,  2, 1, NULL),
(621,144, 74,  2, 1, NULL),

-- DECKED Storage System (Product 146)
(622,146,  1,  2, 1, 'Drop-in system. Maintains full bed access above drawers.'),
(623,146,  2,  2, 1, NULL),
(624,146, 21,  2, 1, NULL),
(625,146, 41,  2, 1, NULL),
(626,146, 50,  2, 0, NULL),
(627,146, 55,  2, 1, NULL),
(628,146, 69,  2, 1, NULL),
(629,146, 74,  2, 1, NULL),

-- AMP Research BedXTender (Product 148)
(630,148,  1,  2, 1, NULL),
(631,148, 21,  2, 1, NULL),
(632,148, 36,  2, 1, NULL),
(633,148, 41,  2, 0, NULL),
(634,148, 50,  2, 1, NULL),
(635,148, 69,  2, 1, NULL),
(636,148, 74,  2, 1, NULL),
(637,148, 81,  2, 1, NULL),

-- WeatherTech Roll-Up Bed Mat (Product 150)
(638,150,  1,  1, 1, NULL),
(639,150,  9,  1, 1, NULL),
(640,150, 21,  1, 1, NULL),
(641,150, 36,  1, 0, NULL),
(642,150, 50,  1, 1, NULL),
(643,150, 60,  1, 1, NULL),
(644,150, 69,  1, 1, NULL),
(645,150, 74,  1, 1, NULL),
(646,150, 81,  1, 1, NULL),
(647,150, 87,  1, 1, NULL);

SET IDENTITY_INSERT FitmentMappings OFF;
