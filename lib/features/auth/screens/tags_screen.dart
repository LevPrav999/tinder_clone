import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tinder_clone/common/utils/coloors.dart';
import 'package:tinder_clone/features/auth/controller/auth_controller.dart';
import 'package:tinder_clone/features/home/controller/cards_controller.dart';
import 'package:tinder_clone/features/matchers/controller/match_controller.dart';

class TagsScreen extends ConsumerStatefulWidget {
  TagsScreen({super.key, required this.userTagsSelected});

  static const routeName = '/tags-screen';

  final List<dynamic> userTagsSelected;

  @override
  ConsumerState<TagsScreen> createState() => _TagsScreenState();
}

class _TagsScreenState extends ConsumerState<TagsScreen> {
  List<String> tags = ["Anime", "Travel", "Fitness", "Movies", "Cooking", "Music", "Games", "Sports", "Art", "Psychology", "Photography", "Technology", "Fashion", "Nature", "Literature", "Design", "Food", "Health", "Marketing", "Relationshipy", "City Travel", "Dance", "Automobiles", "Entertainment", "Volunteering", "Investments", "Programming", "Interior", "Drawing", "Self-Defense", "Painting", "Gardening", "Crafts"];
  List<String> tags_view = ["anime".tr(), "travel".tr(), "fitness".tr(), "movies".tr(), "cooking".tr(), "music".tr(), "games".tr(), "sports".tr(), "art".tr(), "psychology".tr(), "photography".tr(), "technology".tr(), "fashion".tr(), "nature".tr(), "literature".tr(), "design".tr(), "food".tr(), "health".tr(), "marketing".tr(), "relationshipy".tr(), "city_travel".tr(), "dance".tr(), "automobiles".tr(), "entertainment".tr(), "volunteering".tr(), "investments".tr(), "programming".tr(), "interior".tr(), "drawing".tr(), "self_defense".tr(), "painting".tr(), "gardening".tr(), "crafts".tr()];
  List<dynamic> selected = [];

  @override
  void initState() {
    super.initState();
    selected = widget.userTagsSelected;
  }

  void saveSelected(){
    ref.read(authControllerProvider).setUserTags(selected, context);
    ref.read(matchControllerProvider.notifier).setCards();
    ref.read(cardsControllerProvider.notifier).setCards();
  }
  
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
          "preferences".tr(),
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20.w, color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.check, color: Colors.white),
            onPressed: () {
              saveSelected();
            })
        ],
      ),
      body: SafeArea(
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
                      if(selected.contains(tags[index])){
                        selected.remove(tags[index]);
                      }else{
                        selected.add(tags[index]);
                      }
                      setState(() {});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: selected.contains(tags[index]) ? Coloors.mintGreen : Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Center(
                        child: Text(
                          tags_view[index],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13.0,
                            color:
                                selected.contains(tags[index]) ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
      ));
  }
}
