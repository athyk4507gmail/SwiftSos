// routes/emergencyRoutes.js
const express = require('express');
const router = express.Router();
const emergencyController = require('../controllers/emergencyController');

// Route to get all emergency types
router.get('/', emergencyController.getEmergencyTypes);

// Route to add a new emergency type
router.post('/', emergencyController.addEmergencyType);

module.exports = router;
