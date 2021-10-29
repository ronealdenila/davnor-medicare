import 'package:data_table_2/paginated_data_table_2.dart';
import 'package:davnor_medicare/core/controllers/pswd/on_progress_req_controller.dart';
import 'package:davnor_medicare/core/controllers/pswd/menu_controller.dart';
import 'package:davnor_medicare/core/models/med_assistance_model.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:data_table_2/data_table_2.dart';

class OnProgressReqListScreen extends GetView<OnProgressReqController> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        verticalSpace50,
        Container(
          margin: const EdgeInsets.only(top: 20),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              MenuController.to.activeItem.value,
              style: title32Regular,
            ),
          ),
        ),
        verticalSpace20,
        Expanded(
          child: MARequestListTable(),
          // ClipRRect(
          //   borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
          //   child: PaginatedDataTable2(
          //     columnSpacing: 12,
          //     horizontalMargin: 12,
          //     minWidth: 600,
          //     columns: _columns,
          //     source: controller.dataSource,
          //   ),
          // ),
        ),
      ],
    );
  }
}

class MARequestListTable extends StatefulWidget {
  @override
  State<MARequestListTable> createState() => _MARequestListTableState();
}

class _MARequestListTableState extends State<MARequestListTable> {
  // final int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  late DataSource _dataSource;
  bool _initialized = false;
  // PaginatorController? _controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _dataSource = DataSource(context);
      // _controller = PaginatorController();
      _initialized = true;
    }
  }

  @override
  void dispose() {
    _dataSource.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
      child: PaginatedDataTable2(
        columnSpacing: 12,
        horizontalMargin: 12,
        minWidth: 600,
        columns: _columns,
        source: _dataSource,
        // rowsPerPage: _rowsPerPage,
      ),
    );
  }
}

class DataSource extends DataTableSource {
  DataSource(this.context) {
    maRequests = controller.medicalAssistances;
  }
  DataSource.empty(this.context) {
    maRequests = [];
  }
  final BuildContext context;
  late List<OnProgressMAModel> maRequests;

  final int _selectedCount = 0;

  OnProgressReqController controller = Get.find();

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= maRequests.length) {
      throw 'index > _medicalAssistanceData.length';
    }
    final maRequest = maRequests[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(maRequest.fullName!)),
        DataCell(Text(maRequest.address!)),
        DataCell(Text(maRequest.dateRqstd!.toString())),
        DataCell(Text(maRequest.type!)),
        DataCell(
          TextButton(
            onPressed: () {},
            child: const Text('View'),
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => maRequests.length;

  @override
  int get selectedRowCount => _selectedCount;
}

List<DataColumn> get _columns {
  return const [
    DataColumn2(
      label: Text('PATIENT NAME'),
      size: ColumnSize.L,
    ),
    DataColumn(
      label: Text('ADDRESS'),
    ),
    DataColumn(
      label: Text('DATE'),
    ),
    DataColumn(
      label: Text('PATIENT TYPE'),
    ),
    DataColumn(
      label: Text('ACTION'),
    ),
  ];
}

// class MARequestListTable extends GetView<HomeController> {
//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => ClipRRect(
//         borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
//         child: DataTable2(
//           columnSpacing: 12,
//           horizontalMargin: 12,
//           minWidth: 600,
//           headingRowColor: MaterialStateColor.resolveWith(
//             (states) => Colors.blue.shade200,
//           ),
//           headingTextStyle: body16Bold.copyWith(color: neutralColor[10]),
//           columns: const [
//             DataColumn2(
//               label: Text('PATIENT NAME'),
//               size: ColumnSize.L,
//             ),
//             DataColumn(
//               label: Text('ADDRESS'),
//             ),
//             DataColumn(
//               label: Text('DATE'),
//             ),
//             DataColumn(
//               label: Text('PATIENT TYPE'),
//             ),
//             DataColumn(
//               label: Text('ACTION'),
//             ),
//           ],
//           rows: List<DataRow>.generate(
//             controller.medicalAssistances.length,
//             (index) => DataRow(
//               cells: [
//                 DataCell(Text(controller.medicalAssistances[index].fullName!)),
//                 DataCell(Text(controller.medicalAssistances[index].address!)),
//                 //TODO(R): Fetched date must be on proper format
//                 DataCell(Text(controller.medicalAssistances[index].dateRqstd!
//                     .toString())),
//                 DataCell(Text(controller.medicalAssistances[index].type!)),
//                 DataCell(TextButton(
//                   onPressed: () {},
//                   child: const Text('View'),
//                 )),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
