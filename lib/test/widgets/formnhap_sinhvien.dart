import 'package:flutter/material.dart';

class StudentInputForm extends StatelessWidget {
  final TextEditingController masvController;
  final TextEditingController nameController;
  final TextEditingController diemController;
  final VoidCallback onAddStudent;

  const StudentInputForm({
    super.key,
    required this.masvController,
    required this.nameController,
    required this.diemController,
    required this.onAddStudent,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: masvController,
          decoration: const InputDecoration(
            labelText: "Mã sinh viên",
            border: UnderlineInputBorder(),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: nameController,
          decoration: const InputDecoration(
            labelText: "Họ và tên",
            border: UnderlineInputBorder(),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: diemController,
          decoration: const InputDecoration(
            labelText: "Điểm tốt nghiệp",
            border: UnderlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
            onPressed: onAddStudent,
            child: const Text("Thêm sinh viên"),
          ),
        ),
      ],
    );
  }
}
