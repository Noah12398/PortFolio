import 'package:flutter/material.dart';

class CustomTab extends StatefulWidget {
  final Size size;
  CustomTab({super.key, required this.size});

  @override
  _CustomTabState createState() => _CustomTabState();
}

class _CustomTabState extends State<CustomTab>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this); // 3 tabs
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: [
      TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: Colors.white,
        ),
        labelColor: Colors.teal,
        unselectedLabelColor: Colors.white,
        tabs: [
          Tab(text: "Tab 1"),
          Tab(text: "Tab 2"),
          Tab(text: "Tab 3"),
        ],
      ),
      Expanded(
        child: TabBarView(
          controller: _tabController,
          children: [
            _buildtabcontent(size: widget.size, tabController: _tabController),
            _buildtabcontent(size: widget.size, tabController: _tabController),
            _buildtabcontent(size: widget.size, tabController: _tabController),
          ],
        ),
      ),
    ]));
  }
}

class _buildtabcontent extends StatelessWidget {
  final Size size;

  _buildtabcontent({required this.size, required TabController tabController});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: size.width*0.05,
        mainAxisSpacing: size.height*0.05,
      ),
      itemBuilder: (context, index) {
        return Container(
          width: size.width * 0.4,
          height: size.height * 0.2,
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.teal,
            borderRadius: BorderRadius.circular(50.0),
          ),
          child: SizedBox(
            child: Card(
              elevation: 3,
              color: Colors.red,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                'Project $index',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        );
      },
    );
  }
}
