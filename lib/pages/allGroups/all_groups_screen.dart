import 'package:college_platform_mobile/pages/allGroups/group_list.dart';
import 'package:college_platform_mobile/pages/groupList/group_list_screen.dart';
import 'package:college_platform_mobile/services/auth_service.dart';

import 'package:college_platform_mobile/pages/groupDetails/group_details_screen.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/page_group.dart';

class AllGroupsScreen extends StatefulWidget {
  const AllGroupsScreen({required Key key}) : super(key: key);

  @override
  State<AllGroupsScreen> createState() => _AllGroupsScreenState();
}

class _AllGroupsScreenState extends State<AllGroupsScreen> {
  UserService userService = UserService();
  List<GroupPage> _groups = [];
  int _pageNumber = 1;
  int _pageSize = 11;
  bool _isLoading = false;
  bool _hasMoreData = true;

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
    if (!_hasMoreData || _isLoading) return;
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

        if (groups.length < _pageSize) {
          _hasMoreData = false;
        }
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error: $e');
    }
  }

  Widget _buildGroupList() {
    return ListView.builder(
      controller: _scrollController,
      itemCount: _groups.length + (_hasMoreData ? 1 : 0),
      itemBuilder: (context, index) {
        if (index < _groups.length) {
          return Column(
            children: [
              ListTile(
                title: Text(
                  _groups[index].name,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  _navigateToGroupDetails(_groups[index]);
                },
              ),
              const Divider(
                color: Color.fromRGBO(224, 225, 235, 1),
                thickness: 1.8,
              ),
            ],
          );
        } else if (_hasMoreData) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Color.fromRGBO(30, 26, 82, 1),
                ),
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  void _navigateToGroupDetails(GroupPage groupPage) {
    Navigator.push(
      context,
      // MaterialPageRoute(
      //   builder: (context) => GroupDetailsScreen(groupPage: groupPage),
      // ),
      MaterialPageRoute(
        builder: (context) => GroupListScreen(
          groupId: groupPage.id,
          groupPage: groupPage,
        ),
      ),
    );
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
      body: _buildGroupList(),
    );
  }
}
