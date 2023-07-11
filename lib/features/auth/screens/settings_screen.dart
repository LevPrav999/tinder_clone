import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tinder_clone/common/utils/coloors.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  List<String> tags = ["Anime", "Travel", "Fitness", "Movies", "Cooking", "Music", "Games", "Sports", "Art", "Psychology", "Photography", "Technology", "Fashion", "Nature", "Literature", "Design", "Food", "Health", "Marketing", "Relationshipy", "City Travel", "Dance", "Automobiles", "Entertainment", "Volunteering", "Investments", "Programming", " Interior", "Drawing", "Self-Defense", "Painting", "Gardening", "Crafts"];
  List<bool> isSelected = List.generate(33, (index) => false);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Coloors.primaryColor,
        automaticallyImplyLeading: false,
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            }),
        elevation: 0.0,
        title: Text(
          "Preferences",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20.w, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Expanded(
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2.0,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                ),
                padding: EdgeInsets.all(16.0),
                itemCount: tags.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        isSelected[index] = !isSelected[index];
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected[index] ? Coloors.mintGreen : Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Center(
                        child: Text(
                          tags[index],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13.0,
                            color:
                                isSelected[index] ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
      )),
    );
  }
}
