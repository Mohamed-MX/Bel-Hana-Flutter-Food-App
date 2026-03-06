# 🍽️ Bel Hana - بالهنا
<img width="2160" height="2160" alt="ic_launcher" src="https://github.com/user-attachments/assets/cb7e82a5-2f92-4b38-b141-02cd67f49a5f" />


A modern **Flutter food ordering application** with full Arabic (RTL) support. Bel Hana features a beautiful coral-themed UI, allowing users to browse dishes, explore trending restaurants, manage a shopping cart, and track their orders.

---

## ✨ Features

- **Splash Screen** — Branded launch screen with smooth transition
- **Home Screen** — Category chips, search bar, promotional banners, and dish cards
- **Trending Restaurants** — Discover popular restaurants with details and ratings
- **Item Details** — Full dish details with quantity selection and add-to-cart functionality
- **Shopping Cart** — Add/remove items with real-time badge count on the navigation bar
- **Favorites** — Save your favorite dishes for quick access
- **Orders** — View your order history
- **Order Tracking** — Track the status of your current order with delivery illustration
- **Profile** — User profile management
- **Full Arabic (RTL) Support** — Native right-to-left layout with NotoKufiArabic font

---

## 🏗️ Architecture

The project follows a **clean layered architecture**:

```
lib/
├── core/                   # App-wide utilities
│   ├── constants/          # Colors (AppColors), asset paths (AppAssets)
│   └── theme/              # Material theme configuration (AppTheme)
├── data/
│   └── models/             # Data models (DishModel, CategoryModel)
├── presentation/           # UI layer — screens, widgets, state management
│   ├── splash/             # Splash screen
│   ├── home/               # Home screen, ViewModel, widgets
│   │   └── widgets/        # CategoryChips, DishCard, NavigationBar,
│   │                         OfferBanner, SearchBar
│   ├── trending/           # Trending screen & ViewModel
│   ├── item_details/       # Item details (BLoC pattern)
│   ├── cart/               # Cart management (BLoC pattern)
│   ├── favorites/          # Favorites screen
│   ├── orders/             # Orders screen
│   ├── track_order/        # Order tracking screen
│   └── profile/            # Profile screen
└── main.dart               # App entry point
```

---

## 🛠️ Tech Stack

| Layer              | Technology                          |
|--------------------|-------------------------------------|
| **Framework**      | Flutter (Dart)                      |
| **State Management** | Provider + flutter_bloc (BLoC)    |
| **Localization**   | flutter_localizations (Arabic RTL)  |
| **Font**           | NotoKufiArabic (custom)             |
| **Icons**          | Material Icons + Cupertino Icons    |
| **App Icon**       | flutter_launcher_icons              |

---

## 🎨 Design

- **Primary Color:** Coral / Salmon (`#F55540`)
- **Card Style:** Soft pink gradients with white surfaces
- **Typography:** NotoKufiArabic for seamless Arabic rendering
- **Layout:** RTL-first design with `Locale('ar', 'EG')`

---

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (≥ 3.9.2)
- Dart SDK (bundled with Flutter)
- Android Studio / VS Code with Flutter extensions

### Installation

```bash
# Clone the repository
git clone https://github.com/Mohamed-MX/Food_App.git
cd Food_App

# Install dependencies
flutter pub get

# Run the app
flutter run
```

### Generate App Icon

```bash
flutter pub run flutter_launcher_icons
```

---

## 📂 Assets

```
assets/
├── fonts/
│   └── NotoKufiArabic-VariableFont_wght.ttf
└── images/
    ├── bel_hana_logo.png
    ├── delivery_illustration.png
    ├── promo_banner.jpg
    ├── profile_avatar.png
    └── ... (dish images)
```

---

## 📄 License

This project is for educational purposes as part of the **DEPI** program.
