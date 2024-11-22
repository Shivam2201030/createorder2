import 'package:createorder2/ViewOrder1.dart';
import 'package:createorder2/ViewOrder2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue, // Set primarySwatch globally
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue, // Set AppBar color to blue
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.blue, // Set FAB color to blue
        ),
      ),
      home: TodoListScreen(),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<Map<String, String>> _todos = [];

  void _addTodo() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String orderId = "";
        String orderDate = "";
        String planName = "";
        String orderStatus = "";
        String packingType = ""; // New packing type field
        return AlertDialog(
          title: Text(
            "Add a new To-Do",
            style: TextStyle(
              fontWeight: FontWeight.bold, // Make title bold
              color: Colors.blue, // Title color
            ),
          ),
          backgroundColor: Colors.white, // Set background color of dialog to white
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Search Bar for Order ID
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search, color: Colors.blue), // Search icon
                      labelText: "Search Order ID", // Label text
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold, // Bold label
                        color: Colors.black, // Label color
                      ),
                      border: InputBorder.none, // Removes border of TextField
                      contentPadding: EdgeInsets.all(10), // Padding inside the text field
                    ),
                    onChanged: (value) {
                      orderId = value;
                    },
                  ),
                ),
                SizedBox(height: 10),
                // Order Date - Only valid date format allowed
                TextField(
                  decoration: InputDecoration(
                    labelText: "Order Date (YYYY-MM-DD)",
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold, // Bold text for label
                      color: Colors.black, // Label color
                    ),
                  ),
                  keyboardType: TextInputType.datetime,
                  onChanged: (value) {
                    orderDate = value;
                  },
                ),
                SizedBox(height: 10),
                // Plan Name - Text field
                TextField(
                  decoration: InputDecoration(
                    labelText: "Plan Name",
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold, // Bold text for label
                      color: Colors.black, // Label color
                    ),
                  ),
                  onChanged: (value) {
                    planName = value;
                  },
                ),
                SizedBox(height: 10),
                // Order Status - Text field
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: "Order Status", // Label text for order status
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold, // Bold text for label
                      color: Colors.black, // Label color
                    ),
                    border: OutlineInputBorder(), // Adds a border to match TextField style
                  ),
                  value: orderStatus.isNotEmpty ? orderStatus : null, // Initial value
                  items: [
                    DropdownMenuItem(
                      value: 'Pending',
                      child: Text("Pending"),
                    ),
                    DropdownMenuItem(
                      value: 'Shipped',
                      child: Text("Shipped"),
                    ),
                    DropdownMenuItem(
                      value: 'Delivered',
                      child: Text("Delivered"),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      orderStatus = value!; // Update the orderStatus variable
                    });
                  },
                  hint: Text("Select Order Status"), // Placeholder text
                ),

                SizedBox(height: 10),
                // Packing Type - New field
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: "Packing Type", // Label text for packing type
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold, // Bold text for label
                      color: Colors.black, // Label color
                    ),
                    border: OutlineInputBorder(), // Adds a border to match TextField style
                  ),
                  value: packingType.isNotEmpty ? packingType : null, // Initial value
                  items: [
                    DropdownMenuItem(
                      value: 'Box',
                      child: Text("Box"),
                    ),
                    DropdownMenuItem(
                      value: 'Bag',
                      child: Text("Bag"),
                    ),
                    DropdownMenuItem(
                      value: 'Wrapper',
                      child: Text("Wrapper"),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      packingType = value!; // Update the packingType variable
                    });
                  },
                  hint: Text("Select Packing Type"), // Placeholder text
                ),

              ],
            ),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue), // Blue background
              onPressed: () {
                // Validate fields before adding the To-Do
                if (orderId.isNotEmpty && int.tryParse(orderId) != null &&
                    orderDate.isNotEmpty && _isValidDate(orderDate) &&
                    planName.isNotEmpty && orderStatus.isNotEmpty &&
                    packingType.isNotEmpty) {
                  setState(() {
                    _todos.add({
                      "Order ID": orderId,
                      "Order Date": orderDate,
                      "Plan Name": planName,
                      "Order Status": orderStatus,
                      "Packing Type": packingType, // Add packing type to the data
                      "Action": "Edit Delete Submit", // Default Action name
                    });
                  });
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Please enter valid data for all fields."),
                    ),
                  );
                }
              },
              child: Text(
                "Save",
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white), // Make button text bold
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue), // Blue background
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Cancel",
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white), // Make button text bold
              ),
            ),
          ],
        );
      },
    );
  }

  // Date validation function
  bool _isValidDate(String date) {
    try {
      DateFormat("yyyy-MM-dd").parseStrict(date);
      return true;
    } catch (e) {
      return false;
    }
  }

  // Function to handle "Create Account" action
  void _createAccount() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OrderDetailsPage()),
    );
  }


  // Function to handle Pending option and submenu options
  void _handlePendingOption(String value) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("$value option selected."),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert), // Three-dot icon
            onSelected: (value) {
              if (value == 'Create Account') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => OrderDetailsPage()), // Navigate to MyApp1
                );
              } else if (value == 'Pending') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => TodoList()), // Navigate to MyApp2
                );
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'Create Account',
                  child: Text("Create Account"), // "Create Account" option
                ),
                PopupMenuItem<String>(
                  value: 'Pending',
                  child: Text("Pending"), // "Pending" option
                ),
              ];
            },
          ),




          SizedBox(width: 16), // Space between the icon and edge of the screen
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade200, Colors.white], // Gradient colors
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView.builder(
          itemCount: _todos.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ListTile(
                title: RichText(
                  text: TextSpan(
                    style: TextStyle(fontSize: 16, color: Colors.black),
                    children: [
                      TextSpan(
                        text: "Order ID: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: "${_todos[index]["Order ID"]}\n"),
                      TextSpan(
                        text: "Order Date: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: "${_todos[index]["Order Date"]}\n"),
                      TextSpan(
                        text: "Plan Name: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: "${_todos[index]["Plan Name"]}\n"),
                      TextSpan(
                        text: "Order Status: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: "${_todos[index]["Order Status"]}\n"),
                      TextSpan(
                        text: "Packing Type: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: "${_todos[index]["Packing Type"]}\n"),
                      TextSpan(
                        text: "Action: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: "${_todos[index]["Action"]}",
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),

              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodo,
        backgroundColor: Colors.blue, // Button color
        child: Icon(Icons.add), // Icon inside the button
        shape: CircleBorder(), // Ensures the button remains circular
      ),
    );
  }
}
