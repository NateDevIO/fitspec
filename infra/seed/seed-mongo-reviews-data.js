// seed-mongo-reviews-data.js
// Seeds realistic customer reviews for all 150 products into MongoDB.
// Generates 5-15 reviews per product with varied, realistic content.
// Usage: mongosh < seed-mongo-reviews-data.js

db = db.getSiblingDB('fitspec');

db.reviews.drop();
db.createCollection('reviews');

// ---------------------------------------------------------------------------
// Deterministic pseudo-random (seeded LCG)
// ---------------------------------------------------------------------------
var seed = 7919; // different seed from the other script for different data
function rand() {
    seed = (seed * 1103515245 + 12345) & 0x7fffffff;
    return seed / 0x7fffffff;
}

function pick(arr) {
    return arr[Math.floor(rand() * arr.length)];
}

function pickN(arr, n) {
    var result = [];
    for (var i = 0; i < n; i++) {
        result.push(pick(arr));
    }
    return result;
}

function randInt(min, max) {
    return Math.floor(rand() * (max - min + 1)) + min;
}

// ---------------------------------------------------------------------------
// Reviewer names
// ---------------------------------------------------------------------------
var firstNames = [
    'James', 'Robert', 'Michael', 'David', 'William', 'Richard', 'Joseph',
    'Thomas', 'Christopher', 'Charles', 'Daniel', 'Matthew', 'Anthony',
    'Mark', 'Steven', 'Paul', 'Andrew', 'Kenneth', 'Joshua', 'Kevin',
    'Brian', 'George', 'Timothy', 'Ronald', 'Edward', 'Jason', 'Jeffrey',
    'Ryan', 'Jacob', 'Gary', 'Nicholas', 'Eric', 'Jonathan', 'Stephen',
    'Larry', 'Justin', 'Scott', 'Brandon', 'Benjamin', 'Samuel',
    'Maria', 'Jennifer', 'Linda', 'Patricia', 'Elizabeth', 'Barbara',
    'Susan', 'Jessica', 'Sarah', 'Karen', 'Lisa', 'Nancy', 'Betty',
    'Margaret', 'Sandra', 'Ashley', 'Kimberly', 'Emily', 'Donna',
    'Michelle', 'Dorothy', 'Carol', 'Amanda', 'Melissa', 'Deborah',
    'Mike', 'Dan', 'Chris', 'Matt', 'Tom', 'Joe', 'Nick', 'Alex',
    'Sam', 'Ben', 'Jake', 'Tony', 'Pete', 'Steve', 'Greg', 'Doug',
    'Jen', 'Kate', 'Amy', 'Rachel', 'Heather', 'Laura', 'Angela',
    'Tina', 'Brenda', 'Megan', 'Stephanie', 'Christine', 'Diane', 'Kelly'
];

var lastInitials = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('');

// ---------------------------------------------------------------------------
// Vehicle descriptions (~60% of reviews will include one)
// ---------------------------------------------------------------------------
var vehicles = [
    '2023 Ford F-150 XLT', '2022 Ford F-150 Lariat', '2024 Ford F-150 STX',
    '2021 Ford F-150 King Ranch', '2023 Ford F-150 Platinum',
    '2023 Chevrolet Silverado 1500 LT', '2022 Chevrolet Silverado 1500 RST',
    '2024 Chevrolet Silverado 1500 Custom', '2021 Chevrolet Silverado 1500 High Country',
    '2023 RAM 1500 Big Horn', '2022 RAM 1500 Laramie', '2024 RAM 1500 Rebel',
    '2021 RAM 1500 Limited', '2023 RAM 1500 Tradesman',
    '2023 Toyota Tacoma SR5', '2022 Toyota Tacoma TRD Sport',
    '2024 Toyota Tacoma TRD Off-Road', '2023 Toyota Tundra SR5',
    '2024 Toyota Tundra Limited', '2022 Toyota Tundra 1794 Edition',
    '2023 GMC Sierra 1500 SLE', '2022 GMC Sierra 1500 Elevation',
    '2024 GMC Sierra 1500 AT4', '2023 GMC Sierra 1500 Denali',
    '2023 Nissan Frontier SV', '2024 Nissan Titan PRO-4X',
    '2022 Nissan Frontier PRO-4X',
    '2023 Jeep Gladiator Sport', '2022 Jeep Gladiator Rubicon',
    '2024 Jeep Gladiator Mojave',
    '2023 Honda Ridgeline Sport', '2024 Honda Ridgeline RTL',
    '2024 Ford Ranger XLT', '2023 Ford Ranger Lariat',
    '2023 Chevrolet Colorado LT', '2024 Chevrolet Colorado ZR2',
    '2022 Toyota 4Runner SR5', '2023 Toyota 4Runner TRD Pro',
    '2023 Ford Bronco Badlands', '2024 Ford Bronco Outer Banks',
    '2024 Chevrolet Tahoe LT', '2023 Chevrolet Suburban RST',
    '2023 Ford Expedition XLT', '2024 Ford Expedition Limited',
    '2022 RAM 2500 Tradesman', '2023 RAM 2500 Laramie',
    '2023 Ford F-250 XLT', '2024 Ford F-250 Lariat',
    '2024 Chevrolet Silverado 2500HD LTZ', '2023 Chevrolet Silverado 2500HD WT',
    '2022 GMC Canyon AT4', '2023 GMC Canyon Denali',
    '2021 Ford F-150 XL', '2020 Chevrolet Silverado 1500 LT',
    '2020 RAM 1500 Big Horn', '2021 Toyota Tacoma SR',
    '2020 Ford Ranger XL', '2021 Chevrolet Colorado WT'
];

// ---------------------------------------------------------------------------
// Review titles by sentiment
// ---------------------------------------------------------------------------
var positiveTitles = [
    'Excellent quality product!', 'Perfect fit for my truck',
    'Best upgrade I have made', 'Highly recommended!',
    'Great value for the price', 'Exceeded my expectations',
    'Solid build quality', 'Easy install, great result',
    'Exactly what I needed', 'Top notch product',
    'Worth every penny', 'Could not be happier',
    'Outstanding performance', 'Five stars all the way',
    'A must have accessory', 'Transformed my truck',
    'Professional grade quality', 'Better than expected',
    'Best purchase this year', 'Absolutely love it',
    'OEM quality at aftermarket price', 'Rock solid',
    'Like it came from the factory', 'Looks and works great',
    'Impressed with the quality', 'No complaints here',
    'Built like a tank', 'Fantastic product',
    'Really happy with this purchase', 'Makes a huge difference',
    'Premium quality all around', 'Just what the truck needed',
    'Clean look, great fit', 'My mechanic was impressed',
    'Second one I have bought', 'Would buy again in a heartbeat'
];

var neutralTitles = [
    'Decent product overall', 'Gets the job done',
    'Good but not perfect', 'Solid middle of the road option',
    'Works as described', 'Acceptable quality',
    'Fair product for the price', 'Nothing special but functional',
    'Does what it says', 'Average quality product',
    'Meets basic expectations', 'Serviceable option',
    'Okay for the money', 'Not bad, not great',
    'Mixed feelings on this one', 'It works, but...',
    'Three stars is fair', 'Room for improvement'
];

var negativeTitles = [
    'Not what I expected', 'Quality could be better',
    'Disappointed with the fit', 'Would not buy again',
    'Poor instructions included', 'Overpriced for what you get',
    'Cheaply made product', 'Broke after a few months',
    'Save your money', 'Terrible customer experience',
    'Fitment issues out of the box', 'Returning this one',
    'Does not match the description', 'Waste of money',
    'Very frustrating install', 'Paint started peeling quickly'
];

// ---------------------------------------------------------------------------
// Review bodies by sentiment - varied and realistic
// ---------------------------------------------------------------------------
var positiveBodies = [
    'Installed this on my truck last weekend and I am extremely impressed with the quality. The fit was perfect and the finish matches the factory look.',
    'I have tried several brands over the years and this one is by far the best. The build quality is exceptional and installation took less than an hour with basic tools.',
    'After doing extensive research I decided to go with this product and I am glad I did. It looks great and performs even better.',
    'This was a straightforward install and the end result looks amazing. My neighbors have already asked me where I got it.',
    'Bought this based on a friend recommendation and it did not disappoint. Rock solid construction, easy to install, and it looks like it came from the factory.',
    'I am a professional mechanic and I install these regularly for customers. This brand consistently delivers quality products that fit correctly and last.',
    'The packaging was excellent and every piece was accounted for. Instructions were clear and the install went smoothly. Been using it for three months now with zero issues.',
    'Upgraded from a cheaper brand and the difference is night and day. The materials are clearly superior and the finish is much more refined.',
    'I was hesitant about the price but after installing it I can see why it costs more. The engineering and fit are spot on.',
    'Second one I have purchased for my fleet vehicles. Consistent quality and reliable performance.',
    'Bolted right up with no issues. Took about 45 minutes and the only tools I needed were a socket set and a torque wrench. Looks factory.',
    'Really well made. The powder coat finish is thick and even. No rust after six months of New England winters.',
    'My wife and I installed this together on a Saturday morning. Instructions were spot on and the hardware quality was great. Highly recommended.',
    'Fit like a glove on my truck. The alignment was dead on and the mounting hardware was high quality stainless steel. Very happy.',
    'This is my third purchase from this brand. Never had a single issue. You can tell they put thought into the engineering.',
    'Ordered on Monday, arrived Wednesday, installed Thursday evening. Perfect fit, great finish, and looks amazing. Could not ask for a better experience.',
    'The quality of the welds and the powder coat are top tier. I have seen professional fabrication shops put out worse work. Genuinely impressed.',
    'Installed this in my driveway with hand tools in under two hours. Everything lined up perfectly. The instructions even had torque specs which was a nice touch.',
    'Bought this to replace a worn out factory part and the aftermarket quality actually exceeded OEM. Pleasantly surprised by the fit and finish.',
    'This product made a noticeable difference right away. Great investment for anyone looking to upgrade their truck setup.',
    'Had a buddy help me install and we were done in about an hour. Both of us agreed the quality is outstanding for the price point.',
    'Just completed a 2000 mile road trip and this held up perfectly. No rattles, no vibrations, no issues whatsoever.',
    'The attention to detail on this product is impressive. Every edge is smooth, every hole is precisely drilled, and the finish is flawless.',
    'I compared this to three other brands before purchasing and I am confident I made the right choice. Superior quality in every way.'
];

var neutralBodies = [
    'The product works fine for what it is. Installation was a bit tricky in a few spots but nothing too difficult. The finish could be a little better at this price point.',
    'It does what it is supposed to do. The fit was okay but required some minor adjustments. Quality seems decent enough for the price.',
    'Average product overall. Not bad but not great either. The install instructions could be clearer and some of the hardware felt a bit cheap.',
    'Functional product that meets basic expectations. Had to do some modifications to get a perfect fit which was a bit annoying.',
    'It is fine. Does the job adequately. I have seen better and I have seen worse. The price is fair for what you get.',
    'Decent quality for the money. A couple of the mounting points did not line up perfectly but I made it work.',
    'Looks good from a distance but up close the finish has some imperfections. Installation was straightforward at least. It will do for now.',
    'The product itself is okay. Shipping took longer than expected and the packaging could have been better. No damage though so that is good.',
    'Had to make a trip to the hardware store for some extra bolts because the included hardware was not quite right. Product itself is fine once installed.',
    'Three stars because the product is decent but the instructions were poor. Watched a YouTube video instead and got it installed without too much trouble.',
    'Fit is about 90 percent there. Had to use a rubber mallet to persuade it into place on one side. Not a dealbreaker but not ideal either.',
    'Quality is acceptable for a mid-range option. Nothing to write home about but nothing to complain about either. Gets the job done.',
    'It works but the finish started to show minor wear after just a couple of weeks. We will see how it holds up over time.',
    'Product arrived on time and was mostly as described. The color was slightly different from the photos online but close enough.'
];

var negativeBodies = [
    'Really disappointed with this purchase. The fit was off by almost half an inch and I had to drill new holes to make it work. For this price I expected much better quality control.',
    'The product arrived with scratches on the finish and one of the mounting brackets was bent. Customer service was slow to respond.',
    'Installed it and it started showing rust spots within two months. The coating is clearly not up to standard. Save your money and buy a better brand.',
    'Instructions were basically useless. Took four hours to install something that should have taken one. Some of the pre-drilled holes did not align with my vehicle at all.',
    'Looks nothing like the pictures online. The finish is cheap looking and the materials feel flimsy. Already regretting this purchase.',
    'Returned this after trying to install it for three hours. The bolt holes were off by enough that I could not make it work without significant modification.',
    'The powder coat started chipping within the first week. I barely touched it during install and pieces were already flaking off. Very poor quality.',
    'Ordered two of these for my work trucks and both had quality issues. One had a bent bracket and the other had misaligned holes. Not acceptable.',
    'Spent more time trying to make this fit than it would have taken to fabricate one from scratch. Do not waste your time or money on this product.',
    'Hardware was missing from the box and the product itself had visible defects. Had to wait three weeks for replacement hardware. Very frustrating experience.',
    'The welds on this thing are terrible. Uneven beads and visible spatter everywhere. Looks like it was made by someone who just learned to weld yesterday.',
    'Product looked great in the photos but in person it is thin gauge metal that flexes way too much. Does not inspire confidence for daily use.'
];

// ---------------------------------------------------------------------------
// Rating distribution: skewed toward 4-5 stars
// 35% = 5-star, 30% = 4-star, 15% = 3-star, 12% = 2-star, 8% = 1-star
// ---------------------------------------------------------------------------
function weightedRating() {
    var r = rand();
    if (r < 0.35) return 5;
    if (r < 0.65) return 4;
    if (r < 0.80) return 3;
    if (r < 0.92) return 2;
    return 1;
}

// ---------------------------------------------------------------------------
// Date spread across the last 2 years (2024-03-06 to 2026-03-06)
// ---------------------------------------------------------------------------
function randomDate() {
    var start = new Date('2024-03-06T00:00:00Z').getTime();
    var end = new Date('2026-03-06T23:59:59Z').getTime();
    var ts = start + Math.floor(rand() * (end - start));
    return new Date(ts);
}

// ---------------------------------------------------------------------------
// Build all reviews
// ---------------------------------------------------------------------------
var reviews = [];

for (var productId = 1; productId <= 150; productId++) {
    // Each product gets between 5 and 15 reviews
    var numReviews = randInt(5, 15);

    for (var r = 0; r < numReviews; r++) {
        var rating = weightedRating();
        var hasVehicle = rand() < 0.6;
        var vehicleId = hasVehicle ? randInt(1, 107) : null;
        var vehicleDescription = hasVehicle ? pick(vehicles) : null;
        var verifiedPurchase = rand() < 0.65;

        var title, body;
        if (rating >= 4) {
            title = pick(positiveTitles);
            body = pick(positiveBodies);
        } else if (rating === 3) {
            title = pick(neutralTitles);
            body = pick(neutralBodies);
        } else {
            title = pick(negativeTitles);
            body = pick(negativeBodies);
        }

        var reviewerName = pick(firstNames) + ' ' + pick(lastInitials) + '.';

        var helpfulVotes = 0;
        // Older reviews tend to have more helpful votes
        var voteChance = rand();
        if (voteChance < 0.4) {
            helpfulVotes = 0;
        } else if (voteChance < 0.7) {
            helpfulVotes = randInt(1, 5);
        } else if (voteChance < 0.9) {
            helpfulVotes = randInt(3, 15);
        } else {
            helpfulVotes = randInt(8, 25);
        }

        reviews.push({
            productId: productId,
            vehicleId: vehicleId,
            reviewerName: reviewerName,
            rating: rating,
            title: title,
            body: body,
            verifiedPurchase: verifiedPurchase,
            createdAt: randomDate(),
            vehicleDescription: vehicleDescription,
            helpfulVotes: helpfulVotes
        });
    }
}

// ---------------------------------------------------------------------------
// Insert all reviews
// ---------------------------------------------------------------------------
db.reviews.insertMany(reviews);

// ---------------------------------------------------------------------------
// Create indexes for query performance
// ---------------------------------------------------------------------------
db.reviews.createIndex({ productId: 1, createdAt: -1 });
db.reviews.createIndex({ productId: 1, vehicleId: 1 });
db.reviews.createIndex({ productId: 1, rating: 1 });

print('Seeded ' + reviews.length + ' product reviews into fitspec.reviews');
print('Products covered: 1 through 150');
print('Indexes created on productId+createdAt, productId+vehicleId, and productId+rating.');
