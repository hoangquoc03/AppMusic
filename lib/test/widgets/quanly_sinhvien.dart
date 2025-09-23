import 'package:flutter/material.dart';
import 'package:my_app/test/widgets/danhsach_sinhvien.dart';
import 'package:my_app/test/widgets/formnhap_sinhvien.dart';

class QuanLySinhVien extends StatefulWidget {
  const QuanLySinhVien({super.key});

  @override
  State<QuanLySinhVien> createState() => _QuanLySinhVienState();
}

class _QuanLySinhVienState extends State<QuanLySinhVien> {
  final List<SinhVien> danhsachsinhvien = [
    SinhVien(masv: '12345678', hoTenSV: 'Nguyen Van Cuong', diemTotNghiep: 9.0),
    SinhVien(masv: '87654321', hoTenSV: 'Tran Hong Nhung', diemTotNghiep: 8.0),
  ];

  final masv = TextEditingController();
  final hoVaTenSV = TextEditingController();
  final diemTotNghiep = TextEditingController();

  void addStudent() {
    final diem = double.tryParse(diemTotNghiep.text);
    if (masv.text.isNotEmpty &&
        hoVaTenSV.text.isNotEmpty &&
        diem != null) {
      setState(() {
        danhsachsinhvien.add(SinhVien(
          masv: masv.text,
          hoTenSV: hoVaTenSV.text,
          diemTotNghiep: diem,
        ));
      });
      masv.clear();
      hoVaTenSV.clear();
      diemTotNghiep.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Center(child: Text('Quản lý sinh viên')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // Form nhập liệu
            StudentInputForm(
              masvController: masv,
              nameController: hoVaTenSV,
              diemController: diemTotNghiep,
              onAddStudent: addStudent,
            ),
            const SizedBox(height: 10),

            // Danh sách sinh viên
            Expanded(
              child: StudentList(students: danhsachsinhvien),
            ),
          ],
        ),
      ),
    );
  }
}

// ================== MODEL ==================
class SinhVien {
  final String masv;
  final String hoTenSV;
  final double diemTotNghiep;

  SinhVien({
    required this.masv,
    required this.hoTenSV,
    required this.diemTotNghiep,
  });
}
