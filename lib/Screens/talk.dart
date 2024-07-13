import 'package:flutter/material.dart';
import 'package:myntra/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class talks extends StatefulWidget {
  const talks({Key? key}) : super(key: key);

  @override
  State<talks> createState() => _talksState();
}

class _talksState extends State<talks> {
  List<String> texts = [];
  late SharedPreferences _prefs;
  Map<int, bool> likedMap = {}; // Track liked state for each comment
  Map<int, int> likeCountMap = {}; // Track like counts for each comment

  @override
  void initState() {
    super.initState();
    _loadComments(); // Load comments when the widget initializes
  }

  void _loadComments() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      texts = _prefs.getStringList('comments') ?? [];
      for (int i = 0; i < texts.length; i++) {
        likedMap[i] = _prefs.getBool('liked_$i') ?? false;
        likeCountMap[i] = _prefs.getInt('likeCount_$i') ?? 0;
      }
    });
  }

  void _saveComments() {
    _prefs.setStringList('comments', texts);
    for (int i = 0; i < texts.length; i++) {
      _prefs.setBool('liked_$i', likedMap[i] ?? false);
      _prefs.setInt('likeCount_$i', likeCountMap[i] ?? 0);
    }
  }

  void _showInputDialog(BuildContext context) {
    TextEditingController _textFieldController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.red.shade100,
          title: const Text('Lets do some Fashion Talks'),
          content: TextField(
            maxLines: null,
            controller: _textFieldController,
            decoration: InputDecoration(hintText: "Enter your views"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel',style: TextStyle(color: Colors.black),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Post',style: TextStyle(color: Colors.black),),
              onPressed: () {
                setState(() {
                  texts.add(_textFieldController.text);
                  likedMap[texts.length - 1] = false;
                  likeCountMap[texts.length - 1] = 0;
                  _saveComments(); // Save comments after adding new comment
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _toggleLike(int index) {
    setState(() {
      if (likedMap[index] == true) {
        likedMap[index] = false;
        likeCountMap[index] = (likeCountMap[index] ?? 0) - 1;
      } else {
        likedMap[index] = true;
        likeCountMap[index] = (likeCountMap[index] ?? 0) + 1;
      }
      _saveComments();
    });
  }


  @override

  Widget build(BuildContext context) {

    return Scaffold(
      body: ListView.builder(
        itemCount: texts.length,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              children: [

                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/back_2.jpg'), // replace with your profile image asset
                  ),
                  title: Text('Kriti'),
                  subtitle: Text(texts[index]),
                  trailing: Icon(Icons.more_vert),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,


                  children: [
                    SizedBox(width: 50,),
                    IconButton(
                      icon: Icon(Icons.thumb_up_alt_outlined,
                          color: likedMap[index] == true ? Colors.red : Colors.grey.shade600),
                      onPressed: () {
                        _toggleLike(index);
                      },
                    ),
                    Text('${likeCountMap[index] ?? 0}'),
                    IconButton(
                      icon: Icon(Icons.insert_comment_outlined,color: Colors.grey.shade600,),
                      onPressed: () {
                        // Add comment functionality here
                      },
                    ),
                  ],
                ),
                Divider(
                  color: Colors.black,
                  thickness: 0.5, // Adjust thickness as needed
                  height: 0, // This hides the space taken by the divider itself

                   // Right margin for the divider
                ),
              ],
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.pushNamed(context,'/post');
          // showInformationDialogue(context);
          _showInputDialog(context);
        },
        backgroundColor: Colors.red,
        child: Icon(Icons.add),
      ),
    );
  }
}
