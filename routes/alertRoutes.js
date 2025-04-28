const express = require('express');
const router = express.Router();
const alertController = require('../controllers/alertController');

// Send emergency alert
router.post('/send', alertController.sendAlert);

module.exports = router;

