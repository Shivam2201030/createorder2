import 'package:flutter/material.dart';
void main() {
  runApp(MaterialApp(
    home: OrderDetailsPage(),
  ));
}
class OrderDetailsPage extends StatefulWidget {
  @override
  _OrderDetailsPageState createState() => _OrderDetailsPageState();
}
class _OrderDetailsPageState extends State<OrderDetailsPage> {
  TextEditingController orderInfoController = TextEditingController();
  TextEditingController orderDescriptionController = TextEditingController();
  TextEditingController shippingAddressController = TextEditingController();
  TextEditingController planDetailsController = TextEditingController();
  TextEditingController taxController = TextEditingController();
  TextEditingController orderNameController = TextEditingController();
  List<String> todoList = [];


  void _onMenuOptionSelected(String option) {
    setState(() {
      print('Selected option: $option');
    });
  }

  void _onSubmitPressed() {
    setState(() {
      print('Submit button pressed');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order Details',
          style: TextStyle(fontWeight: FontWeight.bold), // Bold text for the title
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.blue.shade100], // Two colors for the gradient
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    // Container inside the body with some padding and rounded corners
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 5), // Border width 5
                      borderRadius: BorderRadius.circular(8), // Rounded corners
                    ),
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTextFieldSection(
                          controller: orderInfoController,
                          hintText: 'Select Shopping Address:',
                          isWithDropdown: true,
                        ),
                        _buildTextFieldSection(
                          controller: orderDescriptionController,
                          hintText: 'Plants*:',
                          isWithDropdown: true,
                        ),
                        _buildTextFieldSection(
                          controller: shippingAddressController,
                          hintText: 'Remarks:',
                        ),
                        _buildTextFieldSection(
                          controller: planDetailsController,
                          hintText: 'Shipping Address:',
                        ),
                        _buildTextFieldSection(
                          controller: taxController,
                          hintText: 'Finish Types*:',
                          isWithDropdown: true,
                        ),
                        _buildTextFieldSection(
                          controller: orderNameController,
                          hintText: 'Order Status:',
                        ),
                        SizedBox(height: 20),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: todoList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                todoList[index],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold, // Bold text
                                  color: Colors.black, // Black text color
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Transform.translate(
                              offset: Offset(0, -20), // Move button 10 pixels upwards
                              child: Container(
                                width: 100, // Button width
                                height: 50, // Button height
                                child: ElevatedButton(
                                  onPressed: _onSubmitPressed,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue, // Button background color
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8), // Slightly rounded corners
                                    ),
                                  ),
                                  child: Text(
                                    'Save',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold, // Bold text
                                      color: Colors.black, // Black text color
                                      fontSize: 16, // Text size
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFieldSection({
    required TextEditingController controller,
    required String hintText,
    bool isWithDropdown = false,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: hintText,
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold, // Bold label text
            color: Colors.black, // Black label text color
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 5), // Border width 5
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 5), // Focused border width 5
          ),
          suffixIcon: isWithDropdown
              ? PopupMenuButton<String>(
            icon: Icon(Icons.keyboard_arrow_down, color: Colors.blue),
            onSelected: _onMenuOptionSelected,
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'Option 1',
                  child: Text(
                    'Option 1',
                    style: TextStyle(
                      fontWeight: FontWeight.bold, // Bold dropdown text
                      color: Colors.black, // Black dropdown text
                    ),
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'Option 2',
                  child: Text(
                    'Option 2',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'Option 3',
                  child: Text(
                    'Option 3',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ];
            },
          )
              : null,
        ),
      ),
    );
  }
}
