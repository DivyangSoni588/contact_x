# **ContactX**

ContactX is a **Flutter application** designed for **managing contacts with categories, profile
images, and search/filtering options**. The app follows **Clean Architecture** and utilizes the *
*BLoC pattern** for state management, ensuring a scalable and maintainable structure.

## **Project Structure**

The project is divided into well-defined layers:

### **1. Presentation Layer**

- Contains **UI components and widgets**.
- Communicates with the **BLoC layer** to fetch and display data.
- Handles user interactions and passes them to the **BLoC layer**.

### **2. Application Layer (BLoC)**

- Manages the **state and business logic** of the application.
- Fetches and processes data from the **Repository layer**.
- Uses **Flutter BLoC** for structured state management.

### **3. Domain Layer (Use Cases & Models)**

- Defines **business rules, use cases, and entities**.
- Ensures separation between logic, UI, and data layers.

### **4. Data Layer (Repository & Database)**

- Acts as an **intermediary** between BLoC and the database.
- Uses **SQLite for persistent storage**.

---

## **Features**

✔ **Add/Edit/Delete Categories** with persistent storage.  
✔ **Add Contacts** with profile images (Gallery/Camera).  
✔ **Assign Categories** to contacts.  
✔ **Store Contacts in Database (SQLite)**.  
✔ **Optional: Save to Device's Native Contacts**.  
✔ **Search Contacts** with incremental search.  
✔ **Filter Contacts** by category.  
✔ **BLoC for State Management** ensuring scalability.

---

## **Installation & Setup**

### **Prerequisites**

- Install **Flutter SDK 3.29.2**.
- Set up your development environment (**Android Studio / VS Code**).

### **Clone the Repository**

```sh
git clone git@github.com:DivyangSoni588/contactx.git
cd contactx
```

### **Install Dependencies**

```sh
flutter pub get
```

### **Run the App**

```sh
flutter run
```

---

## **File Structure**

```
lib/
│── core/                     # Core utilities (constants, theme, etc.)
│── data/
│   ├── models/                # Data models (Contact, Category)
│   ├── repositories/          # Repository layer for database operations
│   ├── sources/               # Local storage (SQLite)
│── domain/
│   ├── entities/              # Business entities
│   ├── usecases/              # Business logic (e.g., AddContact, GetCategories)
│── presentation/
│   ├── blocs/                 # BLoC State Management
│   ├── pages/                 # UI Pages (Categories, Add Contact, Contact List)
│   ├── widgets/               # Reusable UI Components
│── main.dart                  # Entry point
```

---

## **Dependencies**

This project uses the following dependencies:

- `flutter_bloc` → State management.
- `sqflite` → SQLite database for persistent storage.
- `path_provider` → File path utilities.
- `image_picker` → Capture/select profile images.
- `equatable` → Value-based equality for BLoC.

To install missing dependencies, run:

```sh
flutter pub get
```

---

## **Contact**

For any inquiries or issues, please reach out to **[sonidivyang58@gmail.com]**.

