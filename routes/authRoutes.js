const express = require('express');
const router = express.Router();
const { test, login } = require('../controllers/authController');

// Test route
router.get('/test', test);

// Login route
router.post('/login', login);

module.exports = router;
