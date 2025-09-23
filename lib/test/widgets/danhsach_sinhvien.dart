import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_app/test/widgets/quanly_sinhvien.dart';

class StudentList extends StatelessWidget {
  final List<SinhVien> students;

  const StudentList({super.key, required this.students});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: students.length,
      itemBuilder: (context, i) {
        final sv = students[i];
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.purple.shade100,
              child: Text(
                sv.diemTotNghiep.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
            ),
            title: Text("${sv.masv} - ${sv.hoTenSV}",
            ),
          ),
        );
      },
    );
  }
}
