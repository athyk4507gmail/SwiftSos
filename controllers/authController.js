require('dotenv').config();
const jwt = require('jsonwebtoken');
const admin = require('../config/firebase');

// Test route to verify auth routes are working
exports.test = (req, res) => {
  res.json({ message: 'Auth route working fine!' });
};

// Simulated login to issue JWT token
exports.login = async (req, res) => {
  const { email } = req.body;

  if (!email) {
    return res.status(400).json({ error: 'Email is required' });
  }

  if (!process.env.JWT_SECRET) {
    return res.status(500).json({ error: 'JWT_SECRET not configured in environment' });
  }

  try {
    const user = await admin.auth().getUserByEmail(email);

    const token = jwt.sign(
      { uid: user.uid, email: user.email },
      process.env.JWT_SECRET,
      { expiresIn: '1h' }
    );

    res.json({ token });
  } catch (error) {
    console.error('Login error:', error);
    res.status(400).json({ error: 'User not found or other login error' });
  }
};



