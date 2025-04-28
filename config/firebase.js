const path = require('path');
const admin = require('firebase-admin');
const fs = require('fs');

// Read the JSON file manually
const serviceAccount = JSON.parse(
  fs.readFileSync(path.join(__dirname, '../serviceAccountKey.json')).toString()
);

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

module.exports = admin;


