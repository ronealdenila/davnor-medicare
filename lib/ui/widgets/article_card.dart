import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';

class ArticleCard extends StatelessWidget {
  const ArticleCard({
    Key? key,
    required this.title,
    required this.content,
    required this.photoURL,
    required this.textStyleTitle,
    required this.textStyleContent,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final String content;
  final String photoURL;
  final TextStyle textStyleTitle;
  final TextStyle textStyleContent;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Card(
            elevation: 9,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              width: screenWidth(context),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 17.5, horizontal: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 80,
                      height: 80,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(13),
                        child: Hero(
                          tag: title,
                          child: Image.network(
                            photoURL,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(grayBlank, fit: BoxFit.cover);
                            },
                          ),
                        ),
                      ),
                    ),
                    horizontalSpace18,
                    Flexible(
                      child: SizedBox(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 4,
                              style: textStyleTitle,
                            ),
                            verticalSpace10,
                            Text(
                              content,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: textStyleContent,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        verticalSpace15,
      ],
    );
  }
}
