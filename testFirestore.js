const admin = require('./config/firebase');


const db = admin.firestore();

async function testWrite() {
  try {
    const res = await db.collection('alerts').add({
      test: true,
      timestamp: new Date().toISOString()
    });
    console.log('✅ Document written with ID:', res.id);
  } catch (err) {
    console.error('❌ Firestore write failed:', err);
  }
}

testWrite();
