import 'package:flutter/material.dart';

class LinkData {
  final String title;
  final IconData? icon;
  bool isEnabled;

  LinkData({required this.title, this.icon, this.isEnabled = false});
}

class AddLinkPage extends StatefulWidget {
  final Function(List<LinkData>) onLinkAdded;

  AddLinkPage({required this.onLinkAdded});

  @override
  _AddLinkPageState createState() => _AddLinkPageState();
}

class _AddLinkPageState extends State<AddLinkPage> {
  List<TextEditingController> _controllers = [];

  get linkDataList => null;

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Links'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            buildLinkCard(
              label: 'Instagram',
              imageAsset: 'assets/images/instagram.png',
            ),
            SizedBox(height: 16.0),
            buildLinkCard(
              label: 'YouTube',
              imageAsset: 'assets/images/youtube.png',
            ),
            SizedBox(height: 16.0),
            buildLinkCard(
              label: 'WhatsApp',
              imageAsset: 'assets/images/whatsapp.png',
            ),
            SizedBox(height: 16.0),
            SizedBox(height: 16.0),
            buildLinkCard(
              label: 'Phone',
              imageAsset: 'assets/images/telephone.png',
            ),
            SizedBox(height: 16.0),
            buildLinkCard(
              label: 'Website',
              imageAsset: 'assets/images/internet.png',
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _onAddButtonPressed,
              child: Text('Add'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLinkCard({
    required String label,
    required String imageAsset,
  }) {
    bool isAdded = false; // Track whether the link is added or not

    return Card(
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Image.asset(
              imageAsset,
              height: 40,
              width: 40,
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: TextFormField(
                enabled: false,
                decoration: InputDecoration(
                  labelText: label,
                  border: InputBorder.none,
                ),
              ),
            ),
            Switch(
              value: isAdded,
              onChanged: (value) {
                setState(() {
                  isAdded = value;
                });
                if (isAdded) {
                  showDialog(
                    context: context,
                    builder: (context) => _buildLinkCardDialog(context),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLinkCardDialog(BuildContext context) {
    TextEditingController controller = _createTextEditingController();
    IconData? selectedIcon;

    return AlertDialog(
      title: Text('Add Link'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            DropdownButtonFormField<IconData>(
              value: selectedIcon,
              hint: Text('Select an icon'),
              items: [
                DropdownMenuItem(
                  value: Icons.mail,
                  child: Row(
                    children: [
                      Icon(Icons.mail),
                      SizedBox(width: 8.0),
                      Text('Mail'),
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: Icons.youtube_searched_for,
                  child: Row(
                    children: [
                      Icon(Icons.youtube_searched_for),
                      SizedBox(width: 8.0),
                      Text('YouTube'),
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: Icons.chat_bubble,
                  child: Row(
                    children: [
                      Icon(Icons.chat_bubble),
                      SizedBox(width: 8.0),
                      Text('WhatsApp'),
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: Icons.phone,
                  child: Row(
                    children: [
                      Icon(Icons.phone),
                      SizedBox(width: 8.0),
                      Text('Phone'),
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: Icons.web,
                  child: Row(
                    children: [
                      Icon(Icons.web),
                      SizedBox(width: 8.0),
                      Text('Website'),
                    ],
                  ),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  selectedIcon = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: 'Link',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final text = controller.text;
            if (text.isNotEmpty && selectedIcon != null) {
              final linkData = LinkData(title: text, icon: selectedIcon);
              setState(() {
                linkDataList.add(linkData);
              });
            }
            Navigator.pop(context);
          },
          child: Text('Add'),
        ),
      ],
    );
  }

  TextEditingController _createTextEditingController() {
    final controller = TextEditingController();
    _controllers.add(controller);
    return controller;
  }

  void _onAddButtonPressed() {
    final linkDataList = <LinkData>[];
    for (int i = 0; i < _controllers.length; i++) {
      final text = _controllers[i].text;
      if (text.isNotEmpty) {
        final icon = _getIconByIndex(i);
        linkDataList.add(LinkData(title: text, icon: icon));
      }
    }

    // Pass the list of LinkData objects back to the previous screen
    widget.onLinkAdded(linkDataList);

    // Close the page or navigate back to the previous screen.
    Navigator.pop(context);
  }

  IconData? _getIconByIndex(int index) {
    switch (index) {
      case 0:
        return Icons.mail;
      case 1:
        return Icons.youtube_searched_for;
      case 2:
        return Icons.chat_bubble;
      case 3:
        return Icons.mail;
      case 4:
        return Icons.phone;
      case 5:
        return Icons.web;
      default:
        return null;
    }
  }
}

// class PreviousScreen extends StatefulWidget {
//   @override
//   _PreviousScreenState createState() => _PreviousScreenState();
// }

// class _PreviousScreenState extends State<PreviousScreen> {
//     List<LinkData> linkDataList = [];


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Previous Screen'),
//       ),
//       body: ListView.builder(
//         itemCount: linkDataList.length,
//         itemBuilder: (context, index) {
//           final linkData = linkDataList[index];
//           return ListTile(
//             leading: Icon(linkData.icon),
//             title: Text(linkData.title),
//             trailing: Switch(
//               value: linkData.isEnabled,
//               onChanged: (value) {
//                 setState(() {
//                   linkData.isEnabled = value;
//                 });
//               },
//             ),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           _navigateToAddLinkPage(context);
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }

//   void _navigateToAddLinkPage(BuildContext context) async {
//     final result = await Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => AddLinkPage(
//           onLinkAdded: (newLinkDataList) {
//             setState(() {
//               linkDataList.addAll(newLinkDataList);
//             });
//           },
//         ),
//       ),
//     );

//     // Handle any result if needed
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     theme: ThemeData(primaryColor: Colors.blue),
//     home: PreviousScreen(),
//   ));
// }
