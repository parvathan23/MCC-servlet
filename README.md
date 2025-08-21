# MCC-servlet
# 📚 Pahana Edu Bookshop – Billing & Inventory Management System

A full-stack Java web application for managing customer billing, inventory, and reporting operations at Pahana Edu Bookshop. Built using **Java Servlets**, **JSP**, **JDBC**, and **MVC Architecture** with **MySQL** database integration.

---

## 🚀 Features

✅ **User Authentication**  
- Secure login for Admin and Cashier  
- Role-based access control  

✅ **Customer Management**  
- Add, edit, and view customer records  
- Search and filter by customer name or ID  

✅ **Product/Item Management**  
- Add, update, delete items  
- Track available stock in real-time  

✅ **Invoice & Billing System**  
- Generate bills dynamically  
- Calculate total price + tax  
- Auto-update inventory after checkout  

✅ **Reports & Summaries**  
- Daily / Monthly invoice tracking  
- View sales by date or customer  

✅ **Responsive UI (Wireframes Implemented)**  
- Admin & cashier dashboards  
- Mobile-friendly interfaces  

✅ **Database-Driven**  
- Data stored securely in MySQL  
- ERD designed with relationships and constraints  

---

## 🧱 Technologies Used

| Layer        | Tools & Technologies                  |
|--------------|----------------------------------------|
| Frontend     | HTML, CSS, JSP                        |
| Backend      | Java Servlets, JDBC                   |
| Architecture | MVC Design Pattern + DAO              |
| Database     | MySQL (XAMPP / phpMyAdmin)            |
| Tools        | IntelliJ IDEA / Eclipse, Draw.io, Git |
| Testing      | JUnit (for DAO testing), Manual TDD   |

---

## 📁 Project Structure
Billing/
├── src/
│   ├── controller/
│   │   ├── LoginServlet.java
│   │   └── ItemController.java
│   ├── dao/
│   │   ├── AdminDAO.java
│   │   ├── UserDAO.java
│   │   └── ItemDAO.java
│   ├── model/
│   │   ├── Admin.java
│   │   ├── User.java
│   │   └── Item.java
│   └── util/
│       └── DBConnection.java
├── webapp/
│   ├── login.jsp
│   ├── userDashboard.jsp
│   ├── adminDashboard.jsp
│   └── views/…
└── README.md

---

## 🧪 Testing Plan

- Manual test cases written and executed for login, item management, and billing modules
- Sample test cases:
  - Valid/Invalid login
  - Add item and check updated table
  - Bill generation calculation accuracy
- JUnit used for DAO layer testing

---

## 🌐 Live Demo (Optional)
> [Add hosted link or deployment video if available]

---

## 📌 Setup Instructions

1. Clone the repository:

2. 2. Open in **IntelliJ IDEA** or **Eclipse**

3. Configure database:
- Import `pahana.sql` into **MySQL**
- Edit `DBConnection.java`:
  ```java
  private static final String URL = "jdbc:mysql://localhost:3306/pahana";
  private static final String USER = "root";
  private static final String PASS = "";
  ```

4. Deploy project using Apache Tomcat

5. Open `http://localhost:8080/Billing/login.jsp` in browser

---

## 📂 Version Control

- Tracked using Git with tagged commits:
- `v1.0`: Basic login + item entry
- `v1.1`: Bill generation working
- `v2.0`: Final submission with testing + report

---

## 🧑‍💻 Author

**👤 Muthukumarasamy Parvathan**  
HND Student | ICBT Campus  
Module: CIS6003 – Advanced Programming

---

## 📜 License

This project is for academic use only. All rights reserved © 2025.
