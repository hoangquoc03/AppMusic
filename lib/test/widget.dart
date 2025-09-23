import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'model/items.dart';

Container buildContainer(DataItems item, void Function(String) onDelete, BuildContext context,int index) {
  return Container(
    width: double.infinity,
    height: 74,
    margin: const EdgeInsets.only(bottom: 20),
    decoration: BoxDecoration(

      color:(index%2 ==0) ? Colors.blue : Colors.amber,

      borderRadius: BorderRadius.circular(12),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          item.name,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        InkWell(
          onTap: () async {
            /// confirm() sẽ tự hiện ra dialog với 2 nút OK / Cancel
            if (await confirm(
              context,
              title: const Text('Xác nhận'),
              content: Text("Bạn có chắc muốn xóa '${item.name}' không?"),
              textOK: const Text('Xóa'),
              textCancel: const Text('Hủy'),
            )) {
              // Nếu bấm "Xóa"
              onDelete(item.id);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("${item.name} đã bị xóa")),
              );
            } else {
              // Nếu bấm "Hủy"
              print("Đã hủy xóa");
            }
          },
          child: const Icon(Icons.delete, color: Colors.black, size: 30),
        ),
      ],
    ),
  );
}
