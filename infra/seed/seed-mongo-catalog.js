// seed-mongo-catalog.js
// Seeds extended catalog specs into MongoDB for the FitSpec project.
// Usage: mongosh < seed-mongo-catalog.js

db = db.getSiblingDB('fitspec');

db.catalog_extended.drop();
db.createCollection('catalog_extended');

var catalog = [];

// ============================================================
// Category 1: Hitches (product IDs 1-20)
// ============================================================
catalog.push({
    productId: 1,
    specs: { receiverSize: '2 inch', tongueWeight: 500, grossTrailerWeight: 5000, material: 'Carbon Steel', finish: 'Powder Coated Black', boltsIncluded: true },
    features: ['No-drill installation', 'Full-size 2-inch receiver', 'Lifetime warranty', 'Rust-resistant powder coat finish'],
    installGuideUrl: 'https://docs.fitspec.com/install/hitch-001',
    compatibilityNotes: ['Fits standard frame rail spacing', 'May require exhaust relocation on dual exhaust models', 'Compatible with factory bumper']
});

catalog.push({
    productId: 2,
    specs: { receiverSize: '2.5 inch', tongueWeight: 800, grossTrailerWeight: 10000, material: 'Structural Steel', finish: 'E-Coat and Powder Coat', boltsIncluded: true },
    features: ['Heavy-duty construction', 'Dual-layer corrosion protection', 'Designed for commercial towing', 'Includes hardware kit'],
    installGuideUrl: 'https://docs.fitspec.com/install/hitch-002',
    compatibilityNotes: ['Requires removal of spare tire for installation', 'Not compatible with rear-mounted bike racks without adapter', 'Professional installation recommended for HD models']
});

catalog.push({
    productId: 3,
    specs: { receiverSize: '2 inch', tongueWeight: 350, grossTrailerWeight: 3500, material: 'Aluminum', finish: 'Anodized Black', boltsIncluded: true },
    features: ['Lightweight aluminum construction', 'Corrosion-proof design', 'Easy bolt-on installation', 'Low-profile design'],
    installGuideUrl: 'https://docs.fitspec.com/install/hitch-003',
    compatibilityNotes: ['Designed for light-duty towing only', 'Compatible with most ball mounts', 'Will not interfere with factory sensors']
});

catalog.push({
    productId: 4,
    specs: { receiverSize: '2 inch', tongueWeight: 600, grossTrailerWeight: 6000, material: 'Carbon Steel', finish: 'Gloss Black Powder Coat', boltsIncluded: true },
    features: ['Welded construction', 'Includes safety chain loops', 'J-pin and clip included', 'Backed by lifetime warranty'],
    installGuideUrl: 'https://docs.fitspec.com/install/hitch-004',
    compatibilityNotes: ['Compatible with factory wiring harness', 'No trimming required on most vehicles', 'Fits both gas and diesel variants']
});

catalog.push({
    productId: 5,
    specs: { receiverSize: '2 inch', tongueWeight: 700, grossTrailerWeight: 7500, material: 'High-Strength Steel', finish: 'Carbide Black Powder Coat', boltsIncluded: true },
    features: ['Tested to SAE J684 standard', 'Integrated wiring bracket', 'Reinforced receiver tube', 'Custom-fit design'],
    installGuideUrl: 'https://docs.fitspec.com/install/hitch-005',
    compatibilityNotes: ['May require bumper fascia trim on some models', 'Compatible with weight distribution systems', 'Not for use with 5th wheel adapters']
});

// ============================================================
// Category 2: Headlights (product IDs 21-40)
// ============================================================
catalog.push({
    productId: 21,
    specs: { lumens: 12000, colorTemperature: '6000K', bulbType: 'LED', projectorType: 'Bi-LED Projector', beamPattern: 'High/Low', dotApproved: true },
    features: ['Plug-and-play installation', 'DOT/SAE compliant', 'Built-in LED driver', 'Sequential turn signals', 'DRL accent light'],
    installGuideUrl: 'https://docs.fitspec.com/install/headlight-021',
    compatibilityNotes: ['Direct replacement for factory halogen housing', 'No additional wiring harness needed', 'Auto-leveling compatible on equipped vehicles']
});

catalog.push({
    productId: 22,
    specs: { lumens: 9000, colorTemperature: '5500K', bulbType: 'LED', projectorType: 'Reflector', beamPattern: 'High/Low', dotApproved: true },
    features: ['OEM-style reflector design', 'Smoked lens option', 'Integrated amber side markers', 'Aluminum heat sink housing'],
    installGuideUrl: 'https://docs.fitspec.com/install/headlight-022',
    compatibilityNotes: ['Requires re-aiming after installation', 'Compatible with factory DRL module', 'Not compatible with HID retrofit kits']
});

catalog.push({
    productId: 23,
    specs: { lumens: 15000, colorTemperature: '6500K', bulbType: 'LED', projectorType: 'Bi-LED Projector', beamPattern: 'High/Low', dotApproved: true },
    features: ['Ultra-bright bi-LED projector', 'Switchback turn signals', 'Dynamic start-up animation', 'UV-resistant polycarbonate lens'],
    installGuideUrl: 'https://docs.fitspec.com/install/headlight-023',
    compatibilityNotes: ['May require CANBUS decoder on some vehicles', 'Professional aiming recommended', 'Check local regulations for color compliance']
});

catalog.push({
    productId: 24,
    specs: { lumens: 8000, colorTemperature: '4300K', bulbType: 'HID', projectorType: 'Projector', beamPattern: 'Low Beam Only', dotApproved: false },
    features: ['Warm white HID output', 'Crystal clear lens', 'Metal base mount', 'Quick-connect wiring'],
    installGuideUrl: 'https://docs.fitspec.com/install/headlight-024',
    compatibilityNotes: ['Requires ballast kit (sold separately)', 'Not road-legal in all states', 'For off-road or show use recommended']
});

catalog.push({
    productId: 25,
    specs: { lumens: 11000, colorTemperature: '6000K', bulbType: 'LED', projectorType: 'Bi-LED Projector', beamPattern: 'High/Low', dotApproved: true },
    features: ['Halo DRL rings', 'Fiber optic accent lighting', 'Anti-glare coating', 'Plug-and-play connectors'],
    installGuideUrl: 'https://docs.fitspec.com/install/headlight-025',
    compatibilityNotes: ['Direct OEM connector fitment', 'Compatible with auto headlight systems', 'Retains factory high-beam assist functionality']
});

// ============================================================
// Category 3: Tonneau Covers (product IDs 41-60)
// ============================================================
catalog.push({
    productId: 41,
    specs: { coverType: 'Tri-Fold Hard', material: 'Aluminum Panels', weight: 48, foldStyle: 'Tri-fold', lockable: true, bedAccess: '67%' },
    features: ['Flush-mount low profile design', 'Integrated drainage system', 'Pre-assembled for easy install', 'Prop rod for full bed access', 'Keyed tailgate lock'],
    installGuideUrl: 'https://docs.fitspec.com/install/tonneau-041',
    compatibilityNotes: ['Fits beds with or without bedliner', 'Compatible with most bed rail caps', 'Will not work with toolbox installations']
});

catalog.push({
    productId: 42,
    specs: { coverType: 'Roll-Up Soft', material: 'Heavy Duty Vinyl', weight: 22, rollUp: true, lockable: false, bedAccess: '100%' },
    features: ['Quick-release roll-up design', 'No-drill clamp-on install', 'UV-resistant vinyl material', 'Tension control adjustment', 'Full bed access when rolled'],
    installGuideUrl: 'https://docs.fitspec.com/install/tonneau-042',
    compatibilityNotes: ['Works with spray-in bedliners', 'Requires at least 1 inch of bed rail clearance', 'Compatible with tailgate assist systems']
});

catalog.push({
    productId: 43,
    specs: { coverType: 'Retractable Hard', material: 'Polycarbonate Slats', weight: 65, retractable: true, lockable: true, bedAccess: '100%' },
    features: ['One-hand retractable operation', 'Integrated T-slot for accessories', 'Flush rail mount', 'Sealed ball-bearing mechanism', 'Key-lockable in any position'],
    installGuideUrl: 'https://docs.fitspec.com/install/tonneau-043',
    compatibilityNotes: ['Reduces bed depth by 3.5 inches at canister', 'Not compatible with bed-mounted toolboxes', 'Requires clean bed rails for proper seal']
});

catalog.push({
    productId: 44,
    specs: { coverType: 'Bi-Fold Hard', material: 'FRP Composite', weight: 55, foldStyle: 'Bi-fold', lockable: true, bedAccess: '50%' },
    features: ['FRP composite panels for durability', 'Gas strut assisted opening', 'All-weather rubber seals', 'Matte black textured finish'],
    installGuideUrl: 'https://docs.fitspec.com/install/tonneau-044',
    compatibilityNotes: ['Compatible with bed rail caps', 'Panels fold forward for partial bed access', 'Works with factory tie-down cleats']
});

catalog.push({
    productId: 45,
    specs: { coverType: 'Snap Soft', material: 'Canvas', weight: 15, snapOn: true, lockable: false, bedAccess: '100%' },
    features: ['Budget-friendly option', 'Lightweight canvas material', 'Snap-on installation', 'Folds compactly when removed', 'Water-resistant coating'],
    installGuideUrl: 'https://docs.fitspec.com/install/tonneau-045',
    compatibilityNotes: ['Requires snap rail installation on first use', 'Not recommended for heavy rain or snow regions', 'Compatible with most bed configurations']
});

// ============================================================
// Category 4: Running Boards / Side Steps (product IDs 61-80)
// ============================================================
catalog.push({
    productId: 61,
    specs: { width: '6 inch', material: 'Stainless Steel', weightCapacity: 600, illuminated: false, finish: 'Polished', stepPadMaterial: 'UV-resistant polymer' },
    features: ['Full-length cab coverage', 'Slip-resistant step pads', '6-inch wide platform', 'Custom vehicle-specific brackets', 'Polished stainless finish'],
    installGuideUrl: 'https://docs.fitspec.com/install/runningboard-061',
    compatibilityNotes: ['Uses factory mounting points', 'Compatible with mud flaps', 'May require bracket adjustment on lifted vehicles']
});

catalog.push({
    productId: 62,
    specs: { width: '5 inch', material: 'Aluminum', weightCapacity: 500, illuminated: true, finish: 'Textured Black', stepPadMaterial: 'Integrated grip surface' },
    features: ['Integrated LED courtesy lights', 'Lightweight aluminum body', 'Textured black powder coat', 'Auto-on with door opening', 'Corrosion-resistant construction'],
    installGuideUrl: 'https://docs.fitspec.com/install/runningboard-062',
    compatibilityNotes: ['LED wiring taps into door jamb switch', 'Professional installation recommended for lighting', 'Not for use on vehicles with deployed rock sliders']
});

catalog.push({
    productId: 63,
    specs: { width: '4 inch', material: 'Steel Tube', weightCapacity: 400, illuminated: false, finish: 'Satin Black', stepPadMaterial: 'Rubber insert' },
    features: ['Round tube nerf bar design', 'Step pad at cab entry points', 'Bolt-on no-drill install', 'Satin black powder coat'],
    installGuideUrl: 'https://docs.fitspec.com/install/runningboard-063',
    compatibilityNotes: ['Provides limited rocker panel protection', 'Compatible with factory rocker moldings', 'Step pad positions are fixed']
});

catalog.push({
    productId: 64,
    specs: { width: '7 inch', material: 'Die-Cast Aluminum', weightCapacity: 700, illuminated: false, finish: 'Black', stepPadMaterial: 'Full-length grip surface' },
    features: ['Extra-wide 7-inch platform', 'Die-cast aluminum for strength', 'Full-length step surface', 'Aerodynamic design', 'Cab-length coverage'],
    installGuideUrl: 'https://docs.fitspec.com/install/runningboard-064',
    compatibilityNotes: ['Fits crew cab and extended cab models', 'May affect ground clearance by 1 inch', 'Works with factory splash guards']
});

catalog.push({
    productId: 65,
    specs: { width: '3 inch', material: 'Stainless Steel Tube', weightCapacity: 350, illuminated: false, finish: 'Chrome', stepPadMaterial: 'None' },
    features: ['Sleek round tube design', 'Chrome finish for classic look', 'Lightweight construction', 'Simple bracket mount system'],
    installGuideUrl: 'https://docs.fitspec.com/install/runningboard-065',
    compatibilityNotes: ['Primarily aesthetic - limited step utility', 'Compatible with leveling kits up to 2 inches', 'Not recommended as primary entry point for lifted trucks']
});

// ============================================================
// Category 5: Bed Liners (product IDs 81-100)
// ============================================================
catalog.push({
    productId: 81,
    specs: { type: 'Spray-In', thickness: '0.25 inch', coverage: 'Full Bed and Tailgate', uvProtection: true, textureType: 'Medium', colorMatch: false },
    features: ['Permanent spray-in application', 'Chemical and abrasion resistant', 'UV-stabilized formula', 'Deadens road noise', 'Non-slip textured surface'],
    installGuideUrl: 'https://docs.fitspec.com/install/bedliner-081',
    compatibilityNotes: ['Professional installation required', 'Bed must be clean and sanded prior to application', 'Covers factory tie-down hooks - drill-out required']
});

catalog.push({
    productId: 82,
    specs: { type: 'Drop-In', thickness: '0.19 inch', coverage: 'Full Bed', uvProtection: true, textureType: 'Ribbed', colorMatch: false },
    features: ['Custom-molded to vehicle', 'Removable for cleaning', 'Impact-resistant HDPE material', 'Raised ribs for cargo ventilation', 'Tailgate liner included'],
    installGuideUrl: 'https://docs.fitspec.com/install/bedliner-082',
    compatibilityNotes: ['Sits on top of bed floor', 'May trap moisture underneath if not maintained', 'Compatible with over-rail or under-rail mounting']
});

catalog.push({
    productId: 83,
    specs: { type: 'Bed Mat', thickness: '0.375 inch', coverage: 'Floor Only', uvProtection: true, textureType: 'Flat Rubber', colorMatch: false },
    features: ['Heavy-duty rubber construction', 'Custom-cut to fit bed floor', 'Easy to remove and clean', 'Protects bed from scratches and dents', 'No installation hardware needed'],
    installGuideUrl: 'https://docs.fitspec.com/install/bedliner-083',
    compatibilityNotes: ['Does not cover bed walls or tailgate', 'Compatible with all bed rail accessories', 'Can be used under drop-in liners']
});

catalog.push({
    productId: 84,
    specs: { type: 'Spray-In', thickness: '0.30 inch', coverage: 'Full Bed, Tailgate, and Bed Rails', uvProtection: true, textureType: 'Aggressive', colorMatch: true },
    features: ['Premium color-matched formula', 'Extra-thick application', 'Aggressive texture for maximum grip', 'Lifetime warranty against peeling', 'Covers bed rails for full protection'],
    installGuideUrl: 'https://docs.fitspec.com/install/bedliner-084',
    compatibilityNotes: ['Color matching adds 2-3 days lead time', 'Professional installation only', 'Not compatible with bed rail caps after application']
});

catalog.push({
    productId: 85,
    specs: { type: 'Roll-On', thickness: '0.125 inch', coverage: 'Full Bed', uvProtection: false, textureType: 'Fine', colorMatch: false },
    features: ['DIY roll-on application', 'Kit includes roller and instructions', 'Two-coat system for durability', 'Budget-friendly option', 'Black textured finish'],
    installGuideUrl: 'https://docs.fitspec.com/install/bedliner-085',
    compatibilityNotes: ['Surface preparation is critical for adhesion', 'Allow 24-48 hour cure time before use', 'May require touch-up after heavy use']
});

// ============================================================
// Category 6: Light Bars (product IDs 101-120)
// ============================================================
catalog.push({
    productId: 101,
    specs: { wattage: 300, lumens: 52000, beamPattern: 'Combo (Spot/Flood)', ipRating: 'IP68', barLength: '50 inch', ledCount: 96, voltage: '10-30V DC' },
    features: ['Dual-row CREE LED chips', 'Combo spot and flood beam', 'IP68 waterproof rated', 'Die-cast aluminum housing', 'Adjustable mounting brackets', 'Built-in EMI filter'],
    installGuideUrl: 'https://docs.fitspec.com/install/lightbar-101',
    compatibilityNotes: ['Requires wiring harness with relay (included)', 'Roof mount may require drilling', 'Check local road-use regulations before installing', 'Not DOT approved for on-road use']
});

catalog.push({
    productId: 102,
    specs: { wattage: 120, lumens: 20000, beamPattern: 'Spot', ipRating: 'IP67', barLength: '20 inch', ledCount: 40, voltage: '12V DC' },
    features: ['Focused spot beam pattern', 'Compact 20-inch form factor', 'Behind-grille mount compatible', 'Quick-disconnect wiring', 'Vibration-resistant mounting'],
    installGuideUrl: 'https://docs.fitspec.com/install/lightbar-102',
    compatibilityNotes: ['Fits behind most factory grilles', 'May obstruct front sensors on some models', 'Wiring harness included with 40A relay']
});

catalog.push({
    productId: 103,
    specs: { wattage: 240, lumens: 40000, beamPattern: 'Flood', ipRating: 'IP68', barLength: '40 inch', ledCount: 80, voltage: '10-30V DC' },
    features: ['Wide flood beam pattern', 'Osram LED chips', 'Heavy-duty aluminum fins for cooling', 'Polycarbonate lens cover', 'Stainless steel hardware'],
    installGuideUrl: 'https://docs.fitspec.com/install/lightbar-103',
    compatibilityNotes: ['Ideal for bumper or roof rack mounting', 'Wide beam may cause glare - use with covers on public roads', 'Compatible with universal mounting clamps']
});

catalog.push({
    productId: 104,
    specs: { wattage: 72, lumens: 12000, beamPattern: 'Combo (Spot/Flood)', ipRating: 'IP67', barLength: '14 inch', ledCount: 24, voltage: '12V DC' },
    features: ['Ultra-compact design', 'Single-row LED layout', 'Slim profile for stealth mounting', 'Black housing blends with vehicle', 'Simple two-bolt mount'],
    installGuideUrl: 'https://docs.fitspec.com/install/lightbar-104',
    compatibilityNotes: ['Fits behind bumper openings', 'Low profile does not obstruct airflow', 'Compatible with most aftermarket bumpers']
});

catalog.push({
    productId: 105,
    specs: { wattage: 180, lumens: 30000, beamPattern: 'Combo (Spot/Flood)', ipRating: 'IP69K', barLength: '30 inch', ledCount: 60, voltage: '10-30V DC' },
    features: ['IP69K rated for pressure washing', 'Curved design follows cab contour', 'Amber and white selectable modes', 'Over-voltage protection circuit', 'Backed by 3-year warranty'],
    installGuideUrl: 'https://docs.fitspec.com/install/lightbar-105',
    compatibilityNotes: ['Curved design fits roof line of most trucks', 'Windshield mount brackets sold separately', 'Amber mode legal for off-road auxiliary in most states']
});

// ============================================================
// Category 7: Fender Flares (product IDs 121-135)
// ============================================================
catalog.push({
    productId: 121,
    specs: { style: 'Pocket/Bolt', material: 'ABS Plastic', width: '2.5 inch', finish: 'Matte Black', hardware: 'Stainless Steel' },
    features: ['Rugged pocket/bolt style', 'Covers up to 2.5 inches of extra tire width', 'UV-resistant ABS construction', 'Stainless steel mounting hardware', 'Front and rear set included'],
    installGuideUrl: 'https://docs.fitspec.com/install/fender-121',
    compatibilityNotes: ['Covers factory wheel wells', 'May require minor trimming of inner fender liner', 'Compatible with lifted trucks up to 4-inch lift']
});

catalog.push({
    productId: 122,
    specs: { style: 'OE', material: 'Thermoplastic', width: '1 inch', finish: 'Paintable', hardware: 'Clips and Screws' },
    features: ['Factory OE-style appearance', 'Paintable surface for custom color match', 'Slim 1-inch extension', 'No drilling required', 'Easy clip-on installation'],
    installGuideUrl: 'https://docs.fitspec.com/install/fender-122',
    compatibilityNotes: ['Replaces factory fender trim', 'Uses factory clip locations', 'Recommended to be painted within 30 days of install']
});

catalog.push({
    productId: 123,
    specs: { style: 'Street', material: 'Urethane', width: '1.5 inch', finish: 'Smooth Black', hardware: 'Adhesive and Screws' },
    features: ['Smooth street-style look', 'Flexible urethane resists cracking', 'Low-profile design', 'Adhesive backing for clean lines', 'UV and weather resistant'],
    installGuideUrl: 'https://docs.fitspec.com/install/fender-123',
    compatibilityNotes: ['Best results on stock-height trucks', 'Surface must be clean and warm for adhesive bond', 'Not recommended for use with wheel spacers']
});

// ============================================================
// Category 8: Grille Guards / Bull Bars (product IDs 136-150)
// ============================================================
catalog.push({
    productId: 136,
    specs: { type: 'Bull Bar', material: '3-inch Steel Tube', finish: 'Black Powder Coat', skidPlate: true, lightMounts: 2, airbagCompatible: true },
    features: ['3-inch steel tube construction', 'Integrated skid plate', 'Two light mounting tabs', 'Airbag deployment compatible', 'No-drill bolt-on installation'],
    installGuideUrl: 'https://docs.fitspec.com/install/grille-136',
    compatibilityNotes: ['Mounts to frame horns using factory holes', 'Compatible with front parking sensors', 'Will not interfere with hood opening', 'May void bumper warranty on some manufacturers']
});

catalog.push({
    productId: 137,
    specs: { type: 'Grille Guard', material: 'Steel Tube', finish: 'Stainless Polish', skidPlate: true, lightMounts: 4, airbagCompatible: true },
    features: ['Full grille and headlight protection', 'Four auxiliary light mounting points', 'One-piece welded construction', 'Polished stainless steel finish', 'Removable center bar section'],
    installGuideUrl: 'https://docs.fitspec.com/install/grille-137',
    compatibilityNotes: ['Requires removal of factory air dam', 'May reduce approach angle slightly', 'Professional installation recommended', 'Check compatibility with adaptive cruise control']
});

catalog.push({
    productId: 138,
    specs: { type: 'Bull Bar', material: '3.5-inch Steel Tube', finish: 'Matte Black', skidPlate: false, lightMounts: 1, airbagCompatible: true },
    features: ['Heavy-duty 3.5-inch tube', 'Light-mount crossbar included', 'Matte black finish', 'Simple two-bolt install', 'Airbag tested and certified'],
    installGuideUrl: 'https://docs.fitspec.com/install/grille-138',
    compatibilityNotes: ['Clears factory tow hooks', 'Compatible with front license plate bracket', 'Not compatible with front camera-equipped bumpers']
});

catalog.push({
    productId: 139,
    specs: { type: 'Pre-Runner Guard', material: 'Steel Tube', finish: 'Textured Black', skidPlate: true, lightMounts: 6, airbagCompatible: true },
    features: ['Full front-end protection', 'Hoop-style pre-runner design', 'Six light mounting points', 'Heavy-duty skid plate', 'Textured powder coat finish'],
    installGuideUrl: 'https://docs.fitspec.com/install/grille-139',
    compatibilityNotes: ['Designed for off-road use', 'Replaces factory bumper fascia', 'Requires relocation of fog lights', 'Not compatible with parking assist sensors']
});

catalog.push({
    productId: 140,
    specs: { type: 'Bull Bar', material: 'Aluminum', finish: 'Brushed Aluminum', skidPlate: false, lightMounts: 2, airbagCompatible: true },
    features: ['Lightweight aluminum construction', 'Brushed aluminum appearance', 'Corrosion-proof design', 'Easy bolt-on installation', 'Clean modern styling'],
    installGuideUrl: 'https://docs.fitspec.com/install/grille-140',
    compatibilityNotes: ['Lightweight option for daily drivers', 'Uses factory frame mounting points', 'Compatible with front tow hooks']
});

db.catalog_extended.insertMany(catalog);

// Create index for fast lookup by productId
db.catalog_extended.createIndex({ productId: 1 }, { unique: true });

print('Seeded ' + catalog.length + ' extended catalog entries into fitspec.catalog_extended');
print('Index created on productId (unique).');
