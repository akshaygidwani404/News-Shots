import 'package:flutter/material.dart';
import 'package:flutter_image/network.dart';
import 'package:news_shots/helper/news.dart';
import 'package:news_shots/models/blog_model.dart';
import 'package:news_shots/views/article_view.dart';

class CategoryNews extends StatefulWidget {
  final String category;
  CategoryNews({this.category});

  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  // ignore: deprecated_member_use
  List<BlogModel> blogs = new List<BlogModel>();
  bool _loading = true;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    getCategoryNews();
  }

  getCategoryNews() async {
    CategoryNewsClass newsClass = CategoryNewsClass();
    await newsClass.getNews(widget.category);
    blogs = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("News "),
            Text(
              "Shots",
              style: TextStyle(color: Colors.red),
            )
          ],
        ),
        actions: <Widget>[
          Opacity(
            opacity: 0,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.ac_unit)),
          )
        ],
        elevation: 0.0,
      ),
      body: _loading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                ),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 16),
                      child: ListView.builder(
                          // scrollDirection: Axis.vertical,
                          itemCount: blogs.length,
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return BlogCard(
                              imageUrl: blogs[index].urlToImage,
                              title: blogs[index].title,
                              desc: blogs[index].description,
                              dop: blogs[index].dateOfPublish,
                              url: blogs[index].url,
                            );
                          }),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}

class BlogCard extends StatelessWidget {
  final String imageUrl, title, desc, dop, url;
  BlogCard(
      {@required this.imageUrl,
      @required this.title,
      @required this.desc,
      @required this.dop,
      @required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleView(
                      blogUrl: url,
                      blogTitle: title,
                    )));
      },
      child: Container(
          margin: EdgeInsets.only(bottom: 20),
          child: Column(
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image(
                      image: NetworkImageWithRetry(
                    imageUrl,
                    // errorBuilder: (BuildContext context, Object exception,
                    //     StackTrace stackTrace) {
                    //   return Text('image not available');
                    // },
                  ))),
              SizedBox(
                height: 5,
              ),
              Text(
                title,
                style: TextStyle(
                    fontSize: 17,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                desc,
                style: TextStyle(color: Colors.black54),
              ),
              SizedBox(
                height: 5,
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  dop,
                  // textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
