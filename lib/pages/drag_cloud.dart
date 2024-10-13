import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:self_help/theme.dart';

class DraggableItemDemo extends StatefulWidget {
  const DraggableItemDemo({super.key});

  @override
  DraggableItemDemoState createState() => DraggableItemDemoState();
}

class DraggableItemDemoState extends State<DraggableItemDemo> {
  bool isItemVisible = true;
  // text field controller
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.5;
    final cloud = Material(
      child: Container(
        decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(10),
            // border: Border.all(color: Colors.grey),
            ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            FaIcon(FontAwesomeIcons.cloud, size: width, color: textColor),
            FaIcon(
              FontAwesomeIcons.cloud,
              size: width - 25,
              color: whiteSmoke,
            ),
            Container(
              padding: const EdgeInsets.only(top: 60),
              decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(10),
                  // border: Border.all(color: Colors.grey),
                  ),
              width: width - 50,
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                    // border: InputBorder.none,
                    ),
                maxLines: 3,
              ),
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Draggable to Trash')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          isItemVisible
              ? const Text(
                  'Drag the cloud to the trash icon below',
                )
              : ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isItemVisible = true;
                      controller.clear();
                    });
                  },
                  child: const Text(
                    'add new cloud',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
          // The draggable item
          SizedBox(
            height: 250,
            child: isItemVisible
                ? Draggable<int>(
                    data: 1,
                    feedback: Opacity(opacity: 0.5, child: cloud),
                    childWhenDragging: Container(),
                    child: cloud,
                  )
                : const SizedBox(),
          ),
          // Trash icon (DragTarget)
          DragTarget<int>(
            onAcceptWithDetails: (data) {
              setState(() => isItemVisible = false);
            },
            builder: (context, candidateData, rejectedData) {
              return Center(
                child: Icon(
                  Icons.delete,
                  size: 70,
                  color: candidateData.isNotEmpty ? Colors.red : Colors.grey,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
