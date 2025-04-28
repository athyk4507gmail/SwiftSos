const jwt = require('jsonwebtoken');
const admin = require('../config/firebase');

// Example test route
exports.test = (req, res) => {
  res.json({ message: "Auth route working fine!" });
};

// Example of creating token manually (example login)
exports.login = async (req, res) => {
  const { email } = req.body;
  
  try {
    // Check user in Firebase
    const user = await admin.auth().getUserByEmail(email);

    const token = jwt.sign({ uid: user.uid, email: user.email }, process.env.JWT_SECRET, { expiresIn: '1h' });

    res.json({ token });
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};

