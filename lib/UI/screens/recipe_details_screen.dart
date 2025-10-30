import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_1/UI/utils/app_color.dart';
import 'package:flutter_project_1/UI/widgets/ingridient_tile.dart';
import 'package:flutter_project_1/cubit/auth_cubit.dart';
import 'package:flutter_project_1/cubit/auth_states.dart';
import 'package:flutter_project_1/data/models/recipe.dart';

class RecipeDetailScreen extends StatefulWidget {
  final Recipe data;
  const RecipeDetailScreen({super.key, required this.data});

  @override
  RecipeDetailScreenState createState() => RecipeDetailScreenState();
}

class RecipeDetailScreenState extends State<RecipeDetailScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _scrollController = ScrollController(initialScrollOffset: 0.0);
    _scrollController.addListener(() {
      changeAppBarColor(_scrollController);
    });
  }

  Color appBarColor = Colors.transparent;

  changeAppBarColor(ScrollController scrollController) {
    if (scrollController.position.hasPixels) {
      if (scrollController.position.pixels > 2.0) {
        setState(() {
          appBarColor = AppColor.primary;
        });
      }
      if (scrollController.position.pixels <= 2.0) {
        setState(() {
          appBarColor = Colors.transparent;
        });
      }
    } else {
      setState(() {
        appBarColor = Colors.transparent;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AnimatedContainer(
          color: appBarColor,
          duration: Duration(milliseconds: 200),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Text(
              'Recipe Details',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'inter',
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            actions: [
              BlocBuilder<AuthCubit, AuthStates>(
                builder: (context, state) => IconButton(
                  icon: Icon(
                    context.watch<AuthCubit>().isRecipeBookmarked(
                          widget.data.id,
                        )
                        ? Icons.bookmark
                        : Icons.bookmark_add_outlined,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    context.read<AuthCubit>().toggleBookmark(widget.data.id);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        controller: _scrollController,
        padding: EdgeInsets.zero,
        children: [
          // Section 1 - Recipe Image
          Container(
            height: 280,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.data.image),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(gradient: AppColor.linearBlackTop),
              height: 280,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          // Section 2 - Recipe Info
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(top: 14, bottom: 20, left: 16, right: 16),
            color: AppColor.primary,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Recipe Calories and Time
                Row(
                  children: [
                    Icon(
                      Icons.fireplace_outlined,
                      color: Colors.white,
                      size: 16,
                    ),
                    SizedBox(width: 5),
                    Text(
                      widget.data.caloriesPerServing,
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),

                    SizedBox(width: 10),

                    Icon(Icons.alarm, size: 16, color: Colors.white),
                    SizedBox(width: 5),
                    Text(
                      widget.data.time,
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
                // Recipe Title
                Container(
                  margin: EdgeInsets.only(top: 8),
                  child: Text(
                    widget.data.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'inter',
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Tabbar ( Ingridients, Tutorial )
          Container(
            height: 60,
            width: MediaQuery.of(context).size.width,
            color: AppColor.secondary,
            child: TabBar(
              controller: _tabController,
              onTap: (index) {
                setState(() {
                  _tabController.index = index;
                });
              },
              labelColor: Colors.black,
              unselectedLabelColor: Colors.black.withAlpha(60),
              labelStyle: TextStyle(
                fontFamily: 'inter',
                fontWeight: FontWeight.w500,
              ),
              indicatorColor: Colors.black,
              tabs: [
                Tab(text: 'Ingridients'),
                Tab(text: 'Instructions'),
              ],
            ),
          ),
          // IndexedStack based on TabBar index
          IndexedStack(
            index: _tabController.index,
            children: [
              // Ingridients
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: widget.data.ingridients.length,
                itemBuilder: (context, index) {
                  return DetailsTile(
                    data: widget.data.ingridients[index],
                    useBigFont: true,
                  );
                },
              ),
              // Instructions
              ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: widget.data.instructions.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return DetailsTile(
                    data: "${index + 1}. ${widget.data.instructions[index]}",
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
