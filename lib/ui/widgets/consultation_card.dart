import 'package:flutter/material.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/constants/asset_paths.dart';

class ConsultationCard extends StatelessWidget {
  const ConsultationCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.data,
    required this.profileImage,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String data;
  final String profileImage;
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
              height: 95,
              width: screenWidth(context),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    SizedBox(
                      width: 75,
                      height: 75,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: getPhoto()),
                    ),
                    horizontalSpace20,
                    SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: body16SemiBold,
                          ),
                          verticalSpace5,
                          Text(
                            subtitle,
                            style: caption12Medium,
                          ),
                          verticalSpace5,
                          Text(
                            data,
                            style: caption12RegularNeutral,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
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

  Widget getPhoto() {
    if (profileImage.isEmpty) {
      return Image.asset(blankProfile, fit: BoxFit.cover);
    }
    return Image.network(
      profileImage,
      fit: BoxFit.cover,
    );
  }
}
