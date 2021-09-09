import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MARequestListScreen extends StatelessWidget {
  const MARequestListScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(child: ResponsiveView())),
    );
  }
}
class ResponsiveView extends GetResponsiveView {
  ResponsiveView() : super(alwaysUseBuilder: false);

  Widget phone() => Column(
        children: [
          SizedBox(
            height: Get.height,
            width: Get.width,
            child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                maReqList(),             
            ]),
          )
        ],
      );

  @override
  Widget tablet() => Column(
        children: [
          SizedBox(
            height: Get.height,
            width: Get.width,
            child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                maReqList(),
            ]),
          )
        ],
      );

  @override
  Widget desktop() => Column(
        children: [
          SizedBox(
            height: Get.height,
            width: screen.width,
            child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                maReqList(),
            ]),
          ),
        ],
      );

    Widget maReqList() {
      return DataTable(
      headingTextStyle: 
      const TextStyle( color: Colors.white),
      columnSpacing: 90,
      showBottomBorder: true,
      headingRowColor: MaterialStateColor.resolveWith((states) =>
       Colors.blue.shade200),
      columns: const <DataColumn>[
        DataColumn(
          label: Text(
            'Patient Name',
            style: body16Bold,
          ),
        ),
        DataColumn(
          label: Text(
            'Address',
            style: body16Bold,
          ),
        ),
        DataColumn(
          label: Text(
            'Date',
            style: body16Bold,
          ),
        ),
        DataColumn(
          label: Text(
            'Patient Type',
            style: body16Bold,
          ),
        ),
        DataColumn(
          label: Text(
            'Action',
            style: body16Bold,
          ),
        ),
      ],
      rows: const <DataRow>[
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Olivia Broken', style: body14Medium,)),
            DataCell(Text('Tagum', style: body14Medium,)),
            DataCell(Text('July 10, 2021', style: body14Medium,)),
            DataCell(Text('Senior', style: body14Medium,)),
            DataCell(Text('View',style: body14MediumUnderline,)),

          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Arya Stark', style: body14Medium,)),
            DataCell(Text('Visayan, Tagum', style: body14Medium,)),
            DataCell(Text('July 23, 2021', style: body14Medium,)),
             DataCell(Text('Senior', style: body14Medium,)),
            DataCell(Text('View', style: body14MediumUnderline,)),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Daenerys Targaryen', style: body14Medium,)),
            DataCell(Text('Visayan, Tagum', style: body14Medium,)),
            DataCell(Text('July 23, 2021', style: body14Medium,)),
             DataCell(Text('Pregnant Woman', style: body14Medium,)),
            DataCell(Text('View', style: body14MediumUnderline,)),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Olivia Broken', style: body14Medium,)),
            DataCell(Text('Tagum', style: body14Medium,)),
            DataCell(Text('July 10, 2021', style: body14Medium,)),
            DataCell(Text('Senior', style: body14Medium,)),
            DataCell(Text('View',style: body14MediumUnderline,)),

          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Arya Stark', style: body14Medium,)),
            DataCell(Text('Visayan, Tagum', style: body14Medium,)),
            DataCell(Text('July 23, 2021', style: body14Medium,)),
             DataCell(Text('Senior', style: body14Medium,)),
            DataCell(Text('View', style: body14MediumUnderline,)),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Daenerys Targaryen', style: body14Medium,)),
            DataCell(Text('Visayan, Tagum', style: body14Medium,)),
            DataCell(Text('July 23, 2021', style: body14Medium,)),
             DataCell(Text('Pregnant Woman', style: body14Medium,)),
            DataCell(Text('View', style: body14MediumUnderline,)),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Olivia Broken', style: body14Medium,)),
            DataCell(Text('Tagum', style: body14Medium,)),
            DataCell(Text('July 10, 2021', style: body14Medium,)),
            DataCell(Text('Senior', style: body14Medium,)),
            DataCell(Text('View',style: body14MediumUnderline,)),

          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Arya Stark', style: body14Medium,)),
            DataCell(Text('Visayan, Tagum', style: body14Medium,)),
            DataCell(Text('July 23, 2021', style: body14Medium,)),
             DataCell(Text('Senior', style: body14Medium,)),
            DataCell(Text('View', style: body14MediumUnderline,)),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Daenerys Targaryen', style: body14Medium,)),
            DataCell(Text('Visayan, Tagum', style: body14Medium,)),
            DataCell(Text('July 23, 2021', style: body14Medium,)),
             DataCell(Text('Pregnant Woman', style: body14Medium,)),
            DataCell(Text('View', style: body14MediumUnderline,)),
          ],
        ),
      ],
    );
  }
  
}