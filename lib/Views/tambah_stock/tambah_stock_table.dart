import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Controllers/Templates/setting.dart';

import '../../Controllers/stock controller/tambah_stock.dart';

class tambah_stock_table extends GetView<tambah_stockController> {
  const tambah_stock_table({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height / 2,
      // color: Colors.red,
      margin: EdgeInsets.symmetric(vertical: 15),
      width: context.width_query,
      child: SingleChildScrollView(
        child: DataTable(
          columns: const <DataColumn>[
            DataColumn(
              label: Expanded(
                child: Text(
                  'kode',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'nama produk',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'jumlah',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'harga beli',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'total',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
          ],
          rows: const <DataRow>[
            DataRow(
              cells: <DataCell>[
                DataCell(Text('Sarah')),
                DataCell(Text('19')),
                DataCell(Text('Student')),
                DataCell(Text('Student')),
                DataCell(Text('Student')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
