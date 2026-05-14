# E-Commerce App - Documentation

## Project Overview

এটি একটি সিম্পল single-page e-commerce application যা Dart এর **Map** এবং **Collections** ব্যবহার করে তৈরি করা হয়েছে। এই প্রজেক্টটি শুধুমাত্র **testing purpose** এর জন্য তৈরি এবং কোন database ব্যবহার করা হয় না।

## Key Features

### 1. **Product Management (Map & Collections)**
- প্রতিটি পণ্য একটি **Map** হিসেবে সংরক্ষিত থাকে
- সমস্ত পণ্য একটি **List of Maps** এ রাখা হয়
- কোন ডেটাবেস নেই, শুধুমাত্র in-memory data storage

```dart
List<Map<String, dynamic>> products = [];


Map<String, dynamic> product = {
  'id': 'prod_001',
  'name': 'Product Name',
  'price': 99.99,
  'description': 'Product Description',
  'image': null, 
  'timestamp': DateTime.now(),
};
```

### 2. **Form Submission & Product Addition**
- একটি **Form** তৈরি করা হয় যেখানে:
  - Product নাম ইনপুট করা যায়
  - Price ইনপুট করা যায়
  - Description লেখা যায়
  - Image picker থেকে ছবি নির্বাচন করা যায়
  
- Form submit করলে নতুন product **List এ add** হয়

```dart
void addProduct(String name, double price, String description, File? image) {
  final newProduct = {
    'id': 'prod_${products.length + 1}',
    'name': name,
    'price': price,
    'description': description,
    'image': image,
    'timestamp': DateTime.now(),
  };
  products.add(newProduct);
}
```

### 3. **Product Display**
- সমস্ত added products main screen এ display হয়
- প্রতিটি product card এ:
  - পণ্যের ছবি
  - পণ্যের নাম
  - মূল্য
  - সংক্ষিপ্ত বর্ণনা
  - Delete option

### 4. **Search Functionality**
- একটি **Search Button/Icon** থাকে main screen এ
- Search click করলে **নতুন Screen** এ যাওয়া হয়
- Search screen এ:
  - একটি **TextField** থাকে search query এর জন্য
  - **Real-time filtering** হয় product names অনুযায়ী

```dart
List<Map> searchProducts(String query) {
  return products
      .where((product) => 
          product['name'].toString().toLowerCase()
          .contains(query.toLowerCase()))
      .toList();
}
```

### 5. **Image Gallery Integration**
- `image_picker` package ব্যবহার করা হয়
- Product add করার সময় Gallery থেকে image pick করা যায়
- Picked image display হয় form এ preview হিসেবে

```dart

import 'package:image_picker/image_picker.dart';

Future<File?> pickImage() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  if (pickedFile != null) {
    return File(pickedFile.path);
  }
  return null;
}
```

## Project Structure

```
lib/
├── main.dart              # সবকিছু entry point
├── homescreen.dart        # Main product display screen
├── searching.dart         # Search functionality screen
```

## Data Flow

```
┌─────────────────────────────────────┐
│     Main Screen (Home)              │
│  - Add Product Form                 │
│  - Display All Products (List)      │
│  - Search Button                    │
└────────────┬────────────────────────┘
             │ onClick(Search Button)
             ↓
┌─────────────────────────────────────┐
│     Search Screen                   │
│  - Search TextField                 │
│  - Filtered Products Display        │
│  - Real-time Search Result          │
└─────────────────────────────────────┘
```



## Collections Used

### 1. **List** - Products Storage
```dart
List<Map<String, dynamic>> products = [];
```

### 2. **Map** - Individual Product Data
```dart
{
  'id': String,
  'name': String,
  'price': double,
  'description': String,
  'image': File,
  'timestamp': DateTime
}
```

### 3. **Where (Iterable)** - Search Filtering
```dart
products.where((p) => p['name'].contains(query))
```

## Key Functions

### 1. addProduct()
- নতুন product Map তৈরি করে
- List এ add করে
- UI refresh হয়

### 2. searchProducts(query)
- Search query অনুযায়ী filter করে
- Filtered List return করে

### 3. deleteProduct(id)
- Product id দিয়ে product খুঁজে বের করে
- List থেকে remove করে

### 4. pickImage()
- Image gallery খুলে
- User দ্বারা নির্বাচিত image return করে

## Testing Points

✅ **Add Product Test**
- Form fill করুন
- Submit করুন
- Product list এ নতুন product দেখা যাবে

✅ **Search Test**
- Search screen এ যান
- কোনো letter type করুন
- সেই letter অনুযায়ী filter হবে

✅ **Image Pick Test**
- Add Product form এ
- "Pick Image" button click করুন
- Gallery থেকে image select করুন
- Preview তে image দেখা যাবে

✅ **Delete Product Test**
- Product item এ delete icon click করুন
- Product list থেকে delete হবে

## Important Notes

⚠️ **Data Persistence**: 
- কোন data persistence নেই
- App restart করলে সব data হারিয়ে যাবে
- এটি শুধু testing এবং UI demonstration এর জন্য

⚠️ **No Database**:
- Firebase নেই
- SQL Database নেই
- শুধুমাত্র Dart Collections (List, Map)

⚠️ **Performance**:
- Small dataset এর জন্য suitable
- Large dataset এর জন্য অপটিমাইজেশন প্রয়োজন

## Required Packages

```yaml
dependencies:
  flutter:
    sdk: flutter
  image_picker: ^latest_version
```

## Development Flow

1. **Home Screen Setup**
   - Product form তৈরি করুন
   - Add button functionality implement করুন
   - Products list display করুন

2. **Search Screen Setup**
   - New screen generate করুন
   - Search textfield তৈরি করুন
   - Real-time filtering implement করুন

3. **Image Picker Integration**
   - image_picker dependency add করুন
   - Gallery থেকে pick functionality add করুন
   - Preview show করুন

4. **Testing & Refinement**
   - সব features test করুন
   - UI/UX improve করুন

## Example Usage

```dart

addProduct('Apple', 50.0, 'Fresh Red Apple', pickedImageFile);


List<Map> results = searchProducts('App');



deleteProduct('prod_1');
```

---

**Created**: May 2026
**Purpose**: Testing & Learning Flutter Collections
**Status**: Development
