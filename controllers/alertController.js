// Example alert handler
exports.sendAlert = (req, res) => {
  res.send('Alert sent successfully!');
  
    // Here you could push this info to Firebase Firestore later if needed
    res.json({ message: 'Emergency alert received', location, emergencyType });
  };
  