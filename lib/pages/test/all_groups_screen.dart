import 'package:college_platform_mobile/services/auth_service.dart';
import 'package:college_platform_mobile/pages/allGroups/group_list.dart';
import 'package:college_platform_mobile/widgets/group_item_in_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:college_platform_mobile/routs.dart' as route;

import '../../models/page_group.dart';

class AllGroupsScreen extends StatefulWidget {
  const AllGroupsScreen({super.key});

  @override
  State<AllGroupsScreen> createState() => _AllGroupsScreenState();
}

class _AllGroupsScreenState extends State<AllGroupsScreen> {
  UserService userService = UserService();
  List<GroupPage> _groups = [];
  int _pageNumber = 1;
  int _pageSize = 20;
  bool _isLoading = false;

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchGroups();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _fetchGroups();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _fetchGroups() async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });

    try {
      List<GroupPage> groups =
          await userService.getGroups(_pageNumber, _pageSize);

      setState(() {
        _groups.addAll(groups);
        _pageNumber++;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Row(
          children: [
            const SizedBox(width: 8),
            IconButton(
              color: Colors.white,
              icon: const Icon(CupertinoIcons.chevron_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        backgroundColor: const Color.fromRGBO(30, 26, 82, 1),
        elevation: 0,
        title: const Text(
          "Список усіх груп",
        ),
        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
      ),
      // body: ListView(
      //   padding: const EdgeInsets.symmetric(
      //     horizontal: 20,
      //     vertical: 30,
      //   ),
      //   children: const [
      //     // GroupList(),
      //   ],
      // ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              // physics: NeverScrollableScrollPhysics(),
              itemCount: _groups.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      title: Text(
                        _groups[index].name,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      // shape: const Border(
                      //   top: BorderSide(color: Colors.grey),
                      // ),
                    ),
                    Divider(
                      color: Color.fromRGBO(224, 225, 235, 1),
                      // height: 30,
                      thickness: 1.8,
                    ),
                  ],
                );
              },
            ),
            _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SizedBox(),
            // GroupList(),
          ],
        ),
      ),
    );
  }
}
