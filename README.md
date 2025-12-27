A full-stack Notes application built with Flutter as a frontend
and PHP + MySQL as a backend using REST API.

The app allows users to:
- Sign up & login
- Create, update, delete notes
- Upload images for notes
- View notes per user

## Tech Stack

### Frontend
- Flutter
- Provider (State Management)
- HTTP
- Image Picker

### Backend
- PHP (REST API)
- MySQL
- PDO
- XAMPP (Apache + MySQL)

## Backend Setup

1. Install XAMPP
2. Move the `php_restAPI` folder to:
   C:/xampp/htdocs/
3. Start Apache & MySQL from XAMPP
4. Create a database named:testrestapi
5. Import the SQL file from the folder lib/SQLdatabase
6. Configure database connection in:
   connectDb.php

## ▶ For real device use your local IP
http://192.168.x.x/php_restAPI
