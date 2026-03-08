// seed-mongo-reviews.js
// Seeds ~800 product reviews into MongoDB for the FitSpec project.
// Usage: mongosh < seed-mongo-reviews.js

db = db.getSiblingDB('fitspec');

db.reviews.drop();
db.createCollection('reviews');

// Deterministic pseudo-random (seeded LCG)
var seed = 42;
function rand() {
    seed = (seed * 1103515245 + 12345) & 0x7fffffff;
    return seed / 0x7fffffff;
}

function pick(arr) {
    return arr[Math.floor(rand() * arr.length)];
}

function randInt(min, max) {
    return Math.floor(rand() * (max - min + 1)) + min;
}

// Reviewer names
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
    'Michelle', 'Dorothy', 'Carol', 'Amanda', 'Melissa', 'Deborah'
];

var lastInitials = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('');

// Vehicle descriptions for reviews that reference a vehicle
var vehicleDescs = [
    '2023 Ford F-150 XLT', '2022 Ford F-150 Lariat', '2024 Ford F-150 STX',
    '2023 Chevrolet Silverado 1500 LT', '2022 Chevrolet Silverado 1500 RST',
    '2024 Chevrolet Silverado 1500 Custom', '2023 RAM 1500 Big Horn',
    '2022 RAM 1500 Laramie', '2024 RAM 1500 Rebel',
    '2023 Toyota Tacoma SR5', '2022 Toyota Tacoma TRD Sport',
    '2024 Toyota Tundra Limited', '2023 GMC Sierra 1500 SLE',
    '2022 GMC Sierra 1500 Elevation', '2023 Nissan Frontier SV',
    '2024 Nissan Titan PRO-4X', '2023 Jeep Gladiator Sport',
    '2022 Jeep Gladiator Rubicon', '2023 Honda Ridgeline Sport',
    '2024 Ford Ranger XLT', '2023 Chevrolet Colorado LT',
    '2022 Toyota 4Runner SR5', '2023 Ford Bronco Badlands',
    '2024 Chevrolet Tahoe LT', '2023 Ford Expedition XLT',
    '2022 RAM 2500 Tradesman', '2023 Ford F-250 XLT',
    '2024 Chevrolet Silverado 2500HD LTZ', '2023 Toyota Tundra SR5',
    '2022 GMC Canyon AT4'
];

// Review titles by sentiment
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
    'Best purchase this year', 'Absolutely love it'
];

var neutralTitles = [
    'Decent product overall', 'Gets the job done',
    'Good but not perfect', 'Solid middle of the road option',
    'Works as described', 'Acceptable quality',
    'Fair product for the price', 'Nothing special but functional',
    'Does what it says', 'Average quality product',
    'Meets basic expectations', 'Serviceable option'
];

var negativeTitles = [
    'Not what I expected', 'Quality could be better',
    'Disappointed with the fit', 'Would not buy again',
    'Poor instructions included', 'Overpriced for what you get',
    'Cheaply made product', 'Broke after a few months',
    'Save your money', 'Terrible customer experience'
];

// Review bodies by sentiment
var positiveBodies = [
    'Installed this on my truck last weekend and I am extremely impressed with the quality. The fit was perfect and the finish matches the factory look. Highly recommend to anyone looking for a solid upgrade.',
    'I have tried several brands over the years and this one is by far the best. The build quality is exceptional and installation took less than an hour with basic tools. Well worth the investment.',
    'After doing extensive research I decided to go with this product and I am glad I did. It looks great and performs even better. The attention to detail in the manufacturing is evident.',
    'This was a straightforward install and the end result looks amazing. My neighbors have already asked me where I got it. Great product that does exactly what it claims.',
    'Bought this based on a friend recommendation and it did not disappoint. Rock solid construction, easy to install, and it looks like it came from the factory. Could not ask for more.',
    'I am a professional mechanic and I install these regularly for customers. This brand consistently delivers quality products that fit correctly and last. This one is no exception.',
    'The packaging was excellent and every piece was accounted for. Instructions were clear and the install went smoothly. Been using it for three months now with zero issues.',
    'Upgraded from a cheaper brand and the difference is night and day. The materials are clearly superior and the finish is much more refined. You get what you pay for.',
    'I was hesitant about the price but after installing it I can see why it costs more. The engineering and fit are spot on. This is a premium product that delivers premium results.',
    'Second one I have purchased for my fleet vehicles. Consistent quality and reliable performance. These hold up extremely well to daily commercial use.'
];

var neutralBodies = [
    'The product works fine for what it is. Installation was a bit tricky in a few spots but nothing too difficult. The finish could be a little better at this price point but overall it gets the job done.',
    'It does what it is supposed to do. The fit was okay but required some minor adjustments. Quality seems decent enough for the price. Time will tell how it holds up long term.',
    'Average product overall. Not bad but not great either. The install instructions could be clearer and some of the hardware felt a bit cheap. It looks alright once installed though.',
    'Functional product that meets basic expectations. Had to do some modifications to get a perfect fit which was a bit annoying. Quality is acceptable for a mid-range option.',
    'It is fine. Does the job adequately. I have seen better and I have seen worse. The price is fair for what you get. Would consider other options if I had to buy again.',
    'Decent quality for the money. A couple of the mounting points did not line up perfectly but I made it work. Looks okay from a normal viewing distance.'
];

var negativeBodies = [
    'Really disappointed with this purchase. The fit was off by almost half an inch and I had to drill new holes to make it work. For this price I expected much better quality control.',
    'The product arrived with scratches on the finish and one of the mounting brackets was bent. Customer service was slow to respond. Would not recommend based on my experience.',
    'Installed it and it started showing rust spots within two months. The coating is clearly not up to standard. Save your money and buy a better brand.',
    'Instructions were basically useless. Took four hours to install something that should have taken one. Some of the pre-drilled holes did not align with my vehicle at all.',
    'Looks nothing like the pictures online. The finish is cheap looking and the materials feel flimsy. Already regretting this purchase. You definitely get what you pay for with this one.'
];

// Rating distribution: 40% 5-star, 25% 4-star, 20% 3-star, 10% 2-star, 5% 1-star
function weightedRating() {
    var r = rand();
    if (r < 0.40) return 5;
    if (r < 0.65) return 4;
    if (r < 0.85) return 3;
    if (r < 0.95) return 2;
    return 1;
}

function randomDate() {
    // Spread across 2024-01-01 to 2025-12-31
    var start = new Date('2024-01-01T00:00:00Z').getTime();
    var end = new Date('2025-12-31T23:59:59Z').getTime();
    var ts = start + Math.floor(rand() * (end - start));
    return new Date(ts);
}

var reviews = [];
var reviewId = 1;

for (var productId = 1; productId <= 150; productId++) {
    // Each product gets between 3 and 10 reviews
    var numReviews = randInt(3, 10);

    for (var r = 0; r < numReviews; r++) {
        var rating = weightedRating();
        var hasVehicle = rand() < 0.7;
        var vehicleId = hasVehicle ? randInt(1, 107) : null;
        var vehicleDescription = hasVehicle ? pick(vehicleDescs) : null;
        var verifiedPurchase = rand() < 0.6;

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

        reviews.push({
            productId: productId,
            vehicleId: vehicleId,
            reviewerName: reviewerName,
            rating: rating,
            title: title,
            body: body,
            verifiedPurchase: verifiedPurchase,
            createdAt: randomDate(),
            vehicleDescription: vehicleDescription
        });

        reviewId++;
    }
}

db.reviews.insertMany(reviews);

// Create indexes for query performance
db.reviews.createIndex({ productId: 1, createdAt: -1 });
db.reviews.createIndex({ productId: 1, vehicleId: 1 });
db.reviews.createIndex({ productId: 1, rating: 1 });

print('Seeded ' + reviews.length + ' product reviews into fitspec.reviews');
print('Indexes created on productId, createdAt, vehicleId, and rating.');
