import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wallpaper_hub/api_call/get_wallpapers.dart';
import 'package:wallpaper_hub/data/data.dart';
import 'package:wallpaper_hub/model/categores_model.dart';
import 'package:wallpaper_hub/model/wallpaper_model.dart';
import 'package:wallpaper_hub/widgets/widgets.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoresModel> categories = [];
  List<WallpaperModel> walpapers = [];
  var _pageCount = 1;

  TextEditingController searchController = new TextEditingController();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
    print("onRefresh call");
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      _pageCount++;
    });
    await getWallpapers(_pageCount);
    if (mounted) setState(() {});
    _refreshController.loadComplete();
    print("onload call : $_pageCount");
  }

  getWallpapers(int pageIndex) async {
    if (walpapers.length > 0 && _pageCount > 1) {
      walpapers.addAll(await CallApi().getTrendingWallpapers(pageIndex));
    } else {
      walpapers = await CallApi().getTrendingWallpapers(pageIndex);
    }

    setState(() {});
  }

  searchWalpapers(String query, int pageIndex) async {
    walpapers.clear();
    walpapers = await CallApi().getSearchedWallpapers(query, pageIndex);
    setState(() {});
  }

  @override
  void initState() {
    getWallpapers(_pageCount);
    categories = getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            GestureDetector(
              child: Icon(Icons.arrow_back_sharp),
              onTap: () {
                if (walpapers.length > 0) {
                  walpapers.clear();
                }
                getWallpapers(_pageCount);
                searchController.clear();
              },
            ),
            Spacer(),
            Text(
              "Wallpaper",
              style: TextStyle(color: Colors.black87),
            ),
            Text("Hub", style: TextStyle(color: Colors.blue[800])),
            Spacer(),
          ],
        ),
        elevation: 0,
      ),
      body: SmartRefresher(
        enablePullDown: false,
        enablePullUp: true,
        header: WaterDropHeader(),
        footer: CustomFooter(
          builder: (context, mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text("pull up load");
            } else if (mode == LoadStatus.loading) {
              body = CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed) {
              body = Text("Load Failed!Click retry!");
            } else if (mode == LoadStatus.canLoading) {
              body = Text("release to load more");
            } else {
              body = Text("No more Data");
            }
            return Container(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Color(0xfff5f8fd),
                      borderRadius: BorderRadius.circular(30)),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  margin: EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                              hintText: "Search Wallpaper",
                              border: InputBorder.none),
                        ),
                      ),
                      InkWell(
                          onTap: () => searchWalpapers(
                              searchController.text, _pageCount),
                          child: Container(child: Icon(Icons.search)))
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  height: 80,
                  child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      itemCount: categories.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => searchWalpapers(
                              categories[index].categoryName.toString(),
                              _pageCount),
                          child: CategoriesTile(
                            title: categories[index].categoryName,
                            imageUrl: categories[index].imageUrl,
                          ),
                        );
                      }),
                ),
                walpaperList(wallpapers: walpapers, context: context)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CategoriesTile extends StatelessWidget {
  final String? imageUrl;
  final String? title;

  const CategoriesTile(
      {Key? key, @required this.imageUrl, @required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8),
      child: Stack(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imageUrl!,
                height: 50,
                width: 100,
                fit: BoxFit.cover,
              )),
          Container(
            height: 50,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.black26,
            ),
            alignment: Alignment.center,
            child: Text(
              title!,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16),
            ),
          )
        ],
      ),
    );
  }
}
