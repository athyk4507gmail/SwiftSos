const { db } = require('../config/firebase');

// Send an emergency alert
exports.sendAlert = async (req, res) => {
  try {
    const { message, location, emergencyType, timestamp } = req.body;

    if (![message, location, emergencyType].every(field => typeof field === 'string' && field.trim() !== '')) {
      return res.status(400).json({ error: 'Missing or empty required fields' });
    }

    const alertData = {
      message,
      location,
      emergencyType,
      timestamp: timestamp || new Date().toISOString(),
    };

    await db.collection('alerts').add(alertData);

    res.status(201).json({ message: 'Emergency alert received', data: alertData });
  } catch (error) {
    console.error('Error sending alert:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
};

// Get all live alerts
exports.getLiveAlerts = async (req, res) => {
  try {
    const snapshot = await db.collection('alerts').orderBy('timestamp', 'desc').get();
    const alerts = snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));

    res.status(200).json(alerts);
  } catch (error) {
    console.error('Error fetching alerts:', error);
    res.status(500).json({ error: 'Failed to fetch alerts' });
  }
};

