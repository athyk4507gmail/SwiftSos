
# Emergency SOS App 🚨

## 📖 Description

The **Emergency Distress Signal Web App** is a lightweight, easy-to-use platform designed to help users send emergency alerts instantly during critical situations.

When a user clicks the emergency button, the app captures key details (such as time, user location if available, or other incident info) and immediately stores them securely in a **Firebase Firestore database**. This helps security personnel like Highway Patrols, Police Outposts, and Check Gates to monitor and act on emergency events quickly.

This app is particularly useful for:
- **Highway Security Monitoring**
- **Accident Reporting**
- **Criminal Activity Reporting**
- **critical case**
- **Emergency Situations** like harassment, theft, or medical crises

Its simple architecture ensures fast performance

## 🏗 Technology Stack
The system architecture is composed of:
- **Flutter Mobile App (Frontend)** — A fast, modern, and user-friendly mobile application for sending distress signals.
- **Node.js Backend Server** — Handles API requests, processes incoming emergency data, and manages communication with the database.
- **Firebase Firestore Database** — A scalable, NoSQL cloud database used to store emergency alert records securely and retrieve them in real-time.

## 🎯 Use Cases
- Reporting road accidents
- Alerting police about criminal or suspicious activity
- Medical emergencies
- Public safety situations (e.g., harassment, theft, fights)

## 🌟 Goal
The primary goal of the system is to enable users to request help instantly and allow authorities to respond efficiently, thereby improving public safety and emergency handling.

## 📂 Project Structure


## 🛠 Installation

Follow these steps to set up the project locally:

### Backend (Node.js Server)
1. Open a terminal and navigate to the backend folder:
   ```bash
   cd Backend
### Frontend (Flutter)
2. open a terminal and navigate to the Frontend folder:
   

## 🚀 How to Use

1. **Launch the Flutter App:**
   - Open the app on your mobile device or emulator.

2. **Press the "Emergency" Button:**
   - When you encounter an accident, unlawful activity, or need immediate help, tap the Emergency button.

3. **Send Distress Signal:**
   - The Flutter app sends an API request to the Node.js backend server.

4. **Backend Processing:**
   - The Node.js server receives the distress signal.
   - The server stores emergency information in Firebase Firestore.

5. **Authorities Notification:**
   - Authorized personnel (e.g., Highway Patrol, Police Checkposts) can monitor emergency cases through the stored data and take appropriate action.

---

✅ The whole process happens **in real-time** to ensure rapid response during emergencies.


## 🔒 Authentication

- Firebase Authentication used for secure user login/signup.
- Supports:
  - Email and Password login
  - (Phone OTP / Google login can be added later)
- User identity is verified before sending emergency reports.
- Firebase Admin SDK is used on backend for token verification.




## 📡 API Reference

### 1. Send Emergency Signal

- **Endpoint:** `/api/emergency/send`
- **Method:** `POST`
- **Description:** Receives emergency distress signals from the Flutter frontend and stores them in Firebase Firestore.

#### Request Body (Form Fields):
| Field | Type | Description |
|:---|:---|:---|
| `userId` | `String` | Unique ID of the user sending the emergency. |
| `latitude` | `Number` | Latitude coordinate of the user location. |
| `longitude` | `Number` | Longitude coordinate of the user location. |
| `emergencyType` | `String` | Type of emergency (e.g., Accident, Crime, Medical). |
| `timestamp` | `String` | Timestamp when the emergency is reported. |
| `details` | `String` | (Optional) Additional information about the situation. |
| `database` | `String` | (Optional) stores information about the situation and the users data. |

#### Sample Request (Body):