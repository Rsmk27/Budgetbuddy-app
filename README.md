<div align="center">

<img src="https://img.shields.io/badge/version-1.0.0-terracotta?style=for-the-badge" alt="Version 1.0.0" />
<img src="https://img.shields.io/badge/platform-Android-3DDC84?style=for-the-badge&logo=android&logoColor=white" alt="Platform Android" />
<img src="https://img.shields.io/badge/built_with-React_Native-61DAFB?style=for-the-badge&logo=react&logoColor=black" alt="React Native" />
<img src="https://img.shields.io/badge/expo-SDK_51-000020?style=for-the-badge&logo=expo&logoColor=white" alt="Expo SDK 51" />
<img src="https://img.shields.io/badge/Firebase-RTDB-FFCA28?style=for-the-badge&logo=firebase&logoColor=black" alt="Firebase" />

<br /><br />

# 💰 BudgetBuddy

**Your personal finance companion — track income, expenses, and savings on the go.**

*A React Native port of the original BudgetBuddy web app, rebuilt for Android with offline-first UX and INR formatting.*

<br />

[📥 Download APK](#-installation) · [✨ Features](#-features) · [🛠 Tech Stack](#-tech-stack) · [🚀 Getting Started](#-getting-started-dev)

</div>

---

## 📖 About

BudgetBuddy is a personal budgeting app designed to help you stay on top of your money — without the clutter. Originally built as a Vite + React + Firebase web app, v1.0.0 is the full Android port built with **React Native + Expo**, featuring native navigation, offline capability, and INR-formatted currency display.

Whether you're tracking daily chai expenses or planning your monthly savings, BudgetBuddy keeps it simple and fast.

---

## ✨ Features

- 📊 **Dashboard Overview** — Instant snapshot of income, expenses, and remaining balance
- ➕ **Add Transactions** — Log income or expense entries with category, amount, and notes
- 🗂 **Category Management** — Organize spending by custom or preset categories
- 🔥 **Firebase Sync** — Real-time data sync via Firebase Realtime Database
- 📱 **Native Navigation** — Smooth stack + tab navigation with React Navigation
- 💸 **INR Formatting** — All amounts displayed in Indian Rupees (₹) with proper locale formatting
- 📊 **Charts & Insights** — Visual spending breakdowns powered by `gifted-charts`
- 🌐 **Offline-Ready** — View cached data when offline; syncs automatically on reconnect
- 🎨 **Clean UI** — Styled with NativeWind (Tailwind for React Native) for a consistent, minimal aesthetic

---

## 📸 Screenshots

> *Screenshots coming soon — add your own in the release assets!*

---

## 🛠 Tech Stack

| Layer | Technology |
|---|---|
| Framework | React Native + Expo SDK 51 |
| Navigation | React Navigation (Stack + Bottom Tabs) |
| Styling | NativeWind (Tailwind CSS for RN) |
| Backend / DB | Firebase Realtime Database |
| Charts | gifted-charts |
| Currency | INR (₹) — Indian Rupee locale formatting |
| Build Tool | EAS Build (Expo Application Services) |
| Distribution | GitHub Releases (APK) |

---

## 📥 Installation

### Android (Direct APK)

1. Go to the [**Releases**](../../releases) page
2. Download `BudgetBuddy-v1.0.0.apk`
3. On your Android device, enable **Install from unknown sources**
   - Settings → Apps → Special app access → Install unknown apps
4. Open the downloaded APK and tap **Install**
5. Launch **BudgetBuddy** and start tracking!

> ⚠️ **Minimum Android version:** Android 6.0 (API 23) or higher

---

## 🚀 Getting Started (Dev)

### Prerequisites

- Node.js 18+
- Expo CLI (`npm install -g expo-cli`)
- EAS CLI (`npm install -g eas-cli`)
- A Firebase project with Realtime Database enabled

### Setup

```bash
# Clone the repository
git clone https://github.com/rsmk-technologies/budgetbuddy.git
cd budgetbuddy

# Install dependencies
npm install

# Configure Firebase
# Add your Firebase config to src/config/firebase.js

# Start the dev server
npx expo start
```

### Build APK (EAS)

```bash
# Login to Expo
eas login

# Build Android APK
eas build --platform android --profile preview
```

---

## 🔧 Firebase Setup

1. Create a project at [Firebase Console](https://console.firebase.google.com)
2. Enable **Realtime Database** and set rules for authenticated/open access (for dev)
3. Copy your Firebase config and paste it into `src/config/firebase.js`:

```js
const firebaseConfig = {
  apiKey: "YOUR_API_KEY",
  authDomain: "YOUR_PROJECT.firebaseapp.com",
  databaseURL: "https://YOUR_PROJECT-default-rtdb.firebaseio.com",
  projectId: "YOUR_PROJECT_ID",
  storageBucket: "YOUR_PROJECT.appspot.com",
  messagingSenderId: "YOUR_SENDER_ID",
  appId: "YOUR_APP_ID"
};
```

---

## 📁 Project Structure

```
budgetbuddy/
├── src/
│   ├── components/       # Reusable UI components
│   ├── screens/          # App screens (Home, Add, History, Stats)
│   ├── navigation/       # Stack + Tab navigator config
│   ├── config/           # Firebase config
│   └── utils/            # Currency formatting, helpers
├── assets/               # Icons, splash screen
├── app.json              # Expo config
├── eas.json              # EAS Build config
└── package.json
```

---

## 🗺 Roadmap

- [ ] Authentication (Email / Google Sign-In)
- [ ] Budget limits & alerts
- [ ] Monthly reports (PDF export)
- [ ] iOS support
- [ ] Dark mode
- [ ] Recurring transaction support

---

## 👨‍💻 Author

**RSMK** (Srinivasa Manikanta Rajapantula)
🌐 [rsmk.me](https://rsmk.me) · 💼 [LinkedIn](https://linkedin.com/in/rsmk) · 🛠 RSMK Technologies

> *EEE student · Builder · Problem solver*

---

## 📄 License

This project is licensed under the **MIT License** — see the [LICENSE](LICENSE) file for details.

---

<div align="center">

Made with ☕ and a tight budget · **RSMK Technologies**

</div>
