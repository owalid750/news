
import 'package:flutter/material.dart';

import '../../screens/web_view.dart';

Widget buildArticleItem(article, context) {
  return InkWell(
    onTap: () {
      navigateTo(context, WebViewScreen(url: article['url'],));
    },
    child: Container(
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: NetworkImage(
                      "${article['urlToImage']}",
                    ),
                    fit: BoxFit.cover)),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Container(
              height: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      "${article["title"]}",
                      style: Theme.of(context).textTheme.bodyText1,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    "${article["publishedAt"]}",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Widget myDivider() {
  return Padding(
    padding: EdgeInsets.only(left: 20, right: 20),
    child: Divider(
      color: Colors.grey,
      thickness: 1,
    ),
  );
}

void navigateTo(context, Widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => Widget));
