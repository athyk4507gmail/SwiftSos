const { getFirestore } = require('firebase-admin/firestore');
const db = getFirestore();

// Get all emergency categories/types
exports.getEmergencyTypes = async (req, res) => {
  try {
    const snapshot = await db.collection('emergencyTypes').get();
    const types = snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
    res.status(200).json(types);
  } catch (error) {
    console.error('Error fetching emergency types:', error);
    res.status(500).json({ error: 'Failed to fetch emergency types' });
  }
};

// Add a new emergency type
exports.addEmergencyType = async (req, res) => {
    try {
      const { name, description } = req.body;
      console.log('Request body:', req.body);
  
      if (!name) {
        return res.status(400).json({ error: 'Emergency type name is required' });
      }
  
      const newType = { name, description: description || '' };
      const ref = await db.collection('emergencyTypes').add(newType);
  
      res.status(201).json({ message: 'Emergency type added', id: ref.id });
    } catch (error) {
      console.error('Error adding emergency type:', error);
      res.status(500).json({ error: 'Failed to add emergency type', details: error.message });
    }
  };
  
