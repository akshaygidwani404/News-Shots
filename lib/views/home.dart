import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image/network.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_shots/helper/data.dart';
import 'package:news_shots/helper/news.dart';
import 'package:news_shots/models/blog_model.dart';
import 'package:news_shots/models/category_model.dart';
import 'package:news_shots/views/article_view.dart';
import 'package:news_shots/views/category_news.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // ignore: deprecated_member_use
  List<CategoryModel> categories = new List<CategoryModel>();
  // ignore: deprecated_member_use
  List<BlogModel> blogs = new List<BlogModel>();

  bool _loading = true;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    categories = getCategories();
    getNews();
  }

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    blogs = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // brightness: Brightness.light,
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
      drawer: Theme(
        data: Theme.of(context).copyWith(
          canvasColor:
              Colors.white, //This will change the drawer background to blue.
          //other styles
        ),
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Column(
                  children: [
                    SvgPicture.asset(
                      'assets/images/newspaper.svg',
                      width: 100,
                      height: 100,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("News ", style: TextStyle(fontSize: 20)),
                        Text("Shots",
                            style: TextStyle(color: Colors.red, fontSize: 20))
                      ],
                    )
                  ],
                ),
              ),
              ListTile(
                trailing: Icon(
                  Icons.info_outline,
                  size: 25,
                ),
                title: Text('About', style: TextStyle(fontSize: 16)),
                onTap: () {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => SimpleDialog(
                      // title: const Text('Dialog Title'),
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "About",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "News Shots brings to you the latest, breaking news in English. Whether it is politics, elections, sports, business, food, entertainment, movies, tech, or something going viral. This news app is the lite version and faster to ensure the smoothest reading experience. With full material design and multi-format news, this is the only news app you will ever need.",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
              ListTile(
                trailing: Icon(
                  Icons.person,
                  size: 25,
                ),
                title: Text('Contact', style: TextStyle(fontSize: 16)),
                onTap: () {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => SimpleDialog(
                      // title: const Text('Dialog Title'),
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        ListTile(
                          leading: CircleAvatar(
                            child: Text("AG",
                                style: TextStyle(fontWeight: FontWeight.w500)),
                          ),
                          title: Text(
                            'Akshay Gidwani',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        FractionallySizedBox(
                          widthFactor: 0.9,
                          child: Container(
                            height: 1,
                            // width: double.maxFinite - 10,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            InkWell(
                                onTap: () => _launchLinkedin(),
                                child: FaIcon(FontAwesomeIcons.linkedinIn)),
                            Container(
                              width: 1,
                              height: 30,
                              color: Colors.grey,
                            ),
                            InkWell(
                                onTap: () => _launchGithub(),
                                child: FaIcon(FontAwesomeIcons.github)),
                            Container(
                              width: 1,
                              height: 30,
                              color: Colors.grey,
                            ),
                            InkWell(
                                onTap: () => _launchInstagram(),
                                child: FaIcon(FontAwesomeIcons.instagram)),
                            Container(
                              width: 1,
                              height: 30,
                              color: Colors.grey,
                            ),
                            InkWell(
                                onTap: () => _launchEmail(),
                                child: FaIcon(FontAwesomeIcons.envelope)),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  );
                },
              ),
              ListTile(
                trailing: Icon(
                  Icons.mobile_screen_share,
                  size: 25,
                ),
                title: Text('Other Apps', style: TextStyle(fontSize: 16)),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
      body: _loading
          ? Center(
              child: Container(
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
              ),
            ))
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: <Widget>[
                    //Categories
                    Container(
                      height: 70,
                      //decoration: BoxDecoration(border: Border.all(width: 1)),
                      child: ListView.builder(
                        itemCount: categories.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return CategoryCard(
                            imageUrl: categories[index].imageUrl,
                            categoryName: categories[index].categoryName,
                          );
                        },
                      ),
                    ),
                    //Blogs
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

class CategoryCard extends StatelessWidget {
  final String imageUrl, categoryName;
  CategoryCard({this.imageUrl, this.categoryName});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryNews(
                      category: categoryName.toLowerCase(),
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        // decoration: BoxDecoration(border: Border.all(width: 1)),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CachedNetworkImage(
                width: 120,
                height: 60,
                fit: BoxFit.cover,
                imageUrl: imageUrl,
              ),
            ),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black26,
              ),
              width: 120,
              height: 60,
              child: Text(
                categoryName,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
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

const instagramUrl = "https://www.instagram.com/akagidwani/";
const linkedinUrl = "https://www.linkedin.com/in/akshay-g-581b75149/";
const githubUrl = "https://github.com/akshaygidwani404";
const emailId = "akagidwani@gmail.com";

_launchInstagram() async {
  if (await canLaunch(instagramUrl)) {
    await launch(instagramUrl);
  } else {
    throw 'Could not launch Instagram';
  }
}

_launchGithub() async {
  if (await canLaunch(githubUrl)) {
    await launch(githubUrl);
  } else {
    throw 'Could not launch Github';
  }
}

_launchLinkedin() async {
  if (await canLaunch(linkedinUrl)) {
    await launch(linkedinUrl);
  } else {
    throw 'Could not launch Linkedin';
  }
}

_launchEmail() async {
  // Android and iOS
  const uri = 'mailto:$emailId';
  // const uri = 'mailto:$emailId?subject=Greetings&body=Hello%20World';
  if (await canLaunch(uri)) {
    await launch(uri);
  } else {
    throw 'Could not launch Email';
  }
}
