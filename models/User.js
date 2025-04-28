const mongoose = require('mongoose');

const UserSchema = new mongoose.Schema({
  phone: { type: String, required: true, unique: true },
  role: { type: String, enum: ['citizen', 'police', 'admin'], default: 'citizen' },
  name: { type: String },
  unitAssigned: { type: String }, // for police
}, { timestamps: true });

module.exports = mongoose.model('User', UserSchema);
