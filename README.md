
# Tamunodein Lead System 🚀

This is a full-featured **lead generation and management system** built using **Flutter** and **Firebase**. It allows potential customers to express interest in multiple services and enables the company to view, filter, and analyze the leads via a secure admin dashboard.

---

## ✨ Features

### 🔹 Public (Customer) Side
- **Welcome Screen** to introduce customers to Tamunodein
- **Discovery Screen** to ask how they heard about us
- **Multi-service selection form** with name, phone, email, and preferred consultation time
- **Success screen** after submission

### 🔹 Admin Side
- **Email/password login for staff**
- **Admin dashboard** (accessible only by authenticated admins)
  - View and filter leads by selected services
  - See combined or individual service interests
  - Built-in **bar chart** for daily/weekly lead insights
  - Built-in **pie chart** for service distribution
  - Export capabilities (optional future upgrade)
  - Secure sign-out flow

---

## 🧱 Tech Stack

- **Flutter** (UI & app logic)
- **Firebase**:
  - Firestore (database)
  - Firebase Auth (admin login)
- **Provider** (or setState for simple state)
- **charts_flutter** for charts (or `fl_chart`, depending on config)

---

## 📂 Project Structure

```
lib/
│
├── admin/              # Admin flow (login, dashboard, signup)
│   ├── login_screen.dart
│   ├── signup_screen.dart
│   └── dashboard_screen.dart
│
├── public/             # Customer-facing flow
│   ├── welcome_screen.dart
│   ├── discovery_screen.dart
│   ├── service_form_screen.dart
│   └── success_screen.dart
│
├── shared/             # Shared utilities or widgets
│   └── firebase_options.dart
│
└── main.dart           # App entry point with routing logic
```

---

## 🛠️ Setup Instructions

1. **Clone the repo:**
   ```bash
   git clone https://github.com/yourusername/tamunodein-leadsystem.git
   cd tamunodein-leadsystem
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Set up Firebase:**
   - Add your `google-services.json` (for Android) and `firebase_options.dart` (already included).
   - Make sure your Firebase project is set up with:
     - Firestore
     - Authentication (Email/Password)

4. **Run the app:**
   ```bash
   flutter run -d chrome    # For web
   flutter run              # For mobile
   ```

---

## 🔐 Admin Setup

- Use the **admin signup screen** to create new company staff accounts.
- Admins are stored in the `admins` collection with `isAdmin: true`.
- Only these accounts can access the dashboard.

---

## 📈 Charts Preview

- **Bar Chart:** Shows lead count over time (by day/week).
- **Pie Chart:** Shows percentage of leads per selected service.
- Automatically updates in real-time with Firestore.

---

## 🙋‍♂️ Author

**Prince Odein**  
[GitHub](https://github.com/PrinceOdein) • [Email](mailto:odeinanyanwu@gmail.com)

---

## 💡 Future Improvements

- Export leads to Excel or Google Sheets
- Add lead status tracking (e.g., contacted, pending)
- Add notification/email alerts for new leads
- Refine responsive UI for smaller screens

---

## 🏁 Final Words

This system is production-ready and designed with flexibility in mind.  
If you're looking to manage leads across different services efficiently — you're in the right place.

Built with 💙 by PrinceOdein.
