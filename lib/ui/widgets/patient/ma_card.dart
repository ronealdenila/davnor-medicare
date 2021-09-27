import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/core/models/med_assistance_model.dart';

class MACard extends StatelessWidget {
  const MACard({
    Key? key,
    required this.maHistory,
    required this.onTap,
  }) : super(key: key);

  final MAHistoryModel? maHistory;
  final void Function()? onTap;

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
                        child: Image.asset(
                          maImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    horizontalSpace20,
                    SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${maHistory!.dateClaimed!}',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: body16SemiBold,
                          ),
                          verticalSpace5,
                          const Text(
                            'Medicine Worth',
                            style: caption12RegularNeutral,
                          ),
                          verticalSpace5,
                          Text(
                            'Php ${maHistory!.medWorth}',
                            style: caption12Medium,
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
}
