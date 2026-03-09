// seed-mongo-qa.js
// Seeds product Q&A data into MongoDB for the FitSpec project.
// Usage: mongosh < seed-mongo-qa.js
//    or: mongosh "mongodb+srv://..." --file seed-mongo-qa.js

db = db.getSiblingDB('fitspec');

// Load the exported Q&A data
var qaData = JSON.parse(cat('/seed/seed-mongo-qa.json'));

// Drop existing and re-insert
db.questions.drop();
db.questions.insertMany(qaData.map(function(doc) {
  delete doc._id;
  return doc;
}));

print('Seeded ' + db.questions.countDocuments() + ' Q&A entries into fitspec.questions');

// Create indexes
db.questions.createIndex({ productId: 1 });
db.questions.createIndex({ createdAt: -1 });
print('Indexes created on productId and createdAt.');
