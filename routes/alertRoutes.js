const express = require('express');
const router = express.Router();
const alertController = require('../controllers/alertController');

// Send emergency alert
router.post('/send', alertController.sendAlert);

// Get live alerts
router.get('/live', alertController.getLiveAlerts);

module.exports = router;
