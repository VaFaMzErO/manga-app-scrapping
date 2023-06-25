import 'package:flutter/material.dart';
import 'package:web_scraper/web_scraper.dart';

import '../constants/constants.dart';

class ContentScreen extends StatefulWidget {
final String  mangaTitle, mangaLink;
  const ContentScreen({Key key, this.mangaTitle, this.mangaLink})
      : super(key: key);
  @override
  _ContentScreenState createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
 List<Map<String, dynamic>> contentPages;
 bool dataFetched = false;

 void getContent() async{
    String tempBaseUrl = widget.mangaLink.split(".com")[0] + ".com";
    String tempRoute = widget.mangaLink.split(".com")[1];
    final webscrapper = WebScraper(tempBaseUrl);
   //String tempRoute ='wan-gu-shen-wang/344/all-pages';
    print(tempRoute);
      if(await webscrapper.loadWebPage(tempRoute+"/all-pages")){
        
       contentPages = webscrapper.getElement('div.content-inner.inner-page > div > img', ['src']);
       setState(() {
         dataFetched = true;
       });
      }
 }
 @override
  void initState() {
    super.initState();
    getContent();
 //   precacheImage(NetworkImage(contentPages));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.mangaTitle),
        backgroundColor: Constants.darkgray,
      ),
      body: dataFetched 
          ? Container(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: contentPages.length,
              itemBuilder: (context, index){
                return Image.network(
                  contentPages[index]['attributes']['src'], 
                  fit: BoxFit.fitWidth,
                  loadingBuilder: (context, child, loadingProgress)
                  {
                    if(loadingProgress == null) return child;

                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );
              },
            ),
          )
        : Center(
            child: CircularProgressIndicator(),
        ),
    );
  }
}