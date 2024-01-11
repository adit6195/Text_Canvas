import 'dart:math';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:text_canvas/textclass.dart';

class CanvasScreen extends StatefulWidget {
  const CanvasScreen({super.key});

  @override
  State<CanvasScreen> createState() => _CanvasScreenState();
}

class _CanvasScreenState extends State<CanvasScreen> {
  final List<TextProperties> textList = [];
  List<String> fontFamilyList = [
    "Lato",
    "Montserrat",
    "Lobster",
    "Pacifico",
    "Spectral SC",
    "Dancing Script",
    "Oswald",
    "Bangers",
    "Turret Road",
    "Anton"
  ];
  // TextProperties? activeItem;
  bool activeItem = false;
  String selectedFont = 'Lato';
  TextEditingController _textcontroller = TextEditingController();
  TextEditingController _sizecontroler = TextEditingController();
  double currentSize = 16;
  String currentText = "";
  Color currentColor = Colors.black;
  Color pickerColor = Colors.black;
  late double _left;
  late double _top;

  @override
  Widget build(BuildContext context) {
    void changeColor(Color color) {
      setState(() {
        currentColor = color;
      });
    }

    void onDelete(TextProperties item) {
      setState(() {
        textList.remove(item);
        activeItem == false;
      });
    }

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      floatingActionButton: activeItem == true
          ? FloatingActionButton(
              onPressed: () {
                // onDelete()
              },
              backgroundColor: Colors.red,
              child: Icon(Icons.delete, color: Colors.white),
            )
          : Container(),
      backgroundColor: Colors.grey[800],
      body: Stack(
        children: [
          Positioned(
            top: 55,
            left: 29.5,
            child: Container(
                height: 500,
                width: 300,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Stack(
                  children: [
                    ...textList.map((e) => MyWidget(textProperties: e))
                    // ...textList.map(buildText).toList(),

                    // Positioned(
                    //   left: _left,
                    //   top: _top,
                    //   child: GestureDetector(
                    //     onPanUpdate: (details) {
                    //       _left = max(0, _left + details.delta.dx);
                    //       _top = max(0, _top + details.delta.dy);
                    //       setState(() {});
                    //     },
                    //     onTap: () {
                    //       textSelect = true;
                    //     },
                    //     onDoubleTap: () {
                    //       textSelect = false;
                    //     },
                    //     child: ...textList.map(buildText).toList(),
                    //     // child: textList,
                    //   ),
                    // ),
                  ],
                )),
          ),
          Positioned(
            bottom: 181,
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  color: Colors.black,
                  border: Border(
                    top: BorderSide(color: Colors.white),
                  )),
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      const Row(
                        children: [
                          Text(
                            "Colors :",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Pick a Color!"),
                                content: SingleChildScrollView(
                                  child: ColorPicker(
                                    pickerColor: pickerColor,
                                    onColorChanged: (value) {
                                      setState(() {
                                        pickerColor = value;
                                      });
                                    },
                                    pickerAreaHeightPercent: 0.8,
                                  ),
                                ),
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          currentColor = pickerColor;
                                        });
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("Done")),
                                ],
                              );
                            },
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: currentColor,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white)),
                          child: const Padding(
                            padding: EdgeInsets.all(2.7),
                            child: Icon(
                              Icons.colorize,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          changeColor(Colors.white);
                        },
                        child: Container(
                          height: 28,
                          width: 28,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white)),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          changeColor(Colors.black);
                        },
                        child: Container(
                          height: 28,
                          width: 28,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white)),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          changeColor(Colors.red);
                        },
                        child: Container(
                          height: 28,
                          width: 28,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white)),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          changeColor(Colors.orange);
                        },
                        child: Container(
                          height: 28,
                          width: 28,
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white)),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          changeColor(Colors.yellow);
                        },
                        child: Container(
                          height: 28,
                          width: 28,
                          decoration: BoxDecoration(
                              color: Colors.yellow,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white)),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          changeColor(Colors.green);
                        },
                        child: Container(
                          height: 28,
                          width: 28,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white)),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          changeColor(Colors.blue);
                        },
                        child: Container(
                          height: 28,
                          width: 28,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.black,
                  border: Border(
                    top: BorderSide(color: Colors.white),
                  )),
              width: MediaQuery.of(context).size.width,
              height: 180,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 20, bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 200,
                          child: TextField(
                            onChanged: (value) {
                              currentText = value;
                            },
                            style: const TextStyle(color: Colors.white),
                            controller: _textcontroller,
                            decoration: InputDecoration(
                              labelStyle: const TextStyle(
                                color: Colors.white,
                              ),
                              labelText: "Enter you text",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const Text(
                                  "Size :",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  height: 45,
                                  width: 45,
                                  child: TextField(
                                    onChanged: (value) {
                                      currentSize = double.parse(value);
                                    },
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 18),
                                    decoration: const InputDecoration(
                                        labelStyle:
                                            TextStyle(color: Colors.white)),
                                    controller: _sizecontroler,
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white)),
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 5, right: 8),
                                child: Text(
                                  "Font:",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: DropdownButton<String>(
                                  value: selectedFont,
                                  items: fontFamilyList.map((e) {
                                    return DropdownMenuItem<String>(
                                        value: e,
                                        child: Text(e,
                                            style: GoogleFonts.getFont(e,
                                                color: selectedFont == e
                                                    ? Colors.white
                                                    : Colors.black)));
                                  }).toList(),
                                  onChanged: (String? value) {
                                    setState(() {
                                      selectedFont = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              if (activeItem == false) {
                                setState(() {
                                  activeItem = false;
                                });
                                if (currentText.isNotEmpty) {
                                  setState(() {
                                    textList.add(TextProperties(
                                        text: currentText,
                                        fontSize: currentSize,
                                        color: currentColor,
                                        fontfamily: selectedFont,
                                        position: const Offset(0.4, 0.4)));
                                  });
                                  print("ho rha hai");
                                  print(activeItem);
                                  _textcontroller.clear();
                                  _sizecontroler.clear();
                                }
                              } else {
                                setState(() {
                                  activeItem = false;
                                });
                                for (TextProperties item in textList) {
                                  updateValue(item);
                                }
                                _sizecontroler.clear();
                                _textcontroller.clear();
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: activeItem == false
                                  ? const Text("Add Text")
                                  : const Text("Edit Text"),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget buildText(TextProperties e) {
  //   return Positioned(
  //     top: _top,
  //     left: _left,
  //     child: GestureDetector(
  //       onPanUpdate: (details) {
  //         setState(() {
  //           _left = max(0, _left + details.delta.dx);
  //           _top = max(0, _top + details.delta.dy);
  //         });
  //       },
  //       onTap: () {
  //         for (TextProperties item in textList) {
  //           loadValue(item);
  //           activeItem = true;
  //           print("ho rha hai tap");
  //           print(activeItem);
  //         }
  //       },
  //       child: Text(e.text,
  //           style: GoogleFonts.getFont(
  //             e.fontfamily,
  //           ).copyWith(color: e.color, fontSize: e.fontSize)),
  //     ),
  //   );
  // }
  loadValue(TextProperties item) {
    _textcontroller.text = item.text;
    currentColor = item.color;
    selectedFont = item.fontfamily;
    _sizecontroler.text = item.fontSize.toString();
    activeItem = true;
    print(activeItem);
  }

  updateValue(TextProperties item) {
    setState(() {
      item.text = currentText;
      item.fontSize = currentSize;
      item.color = currentColor;
      item.fontfamily = selectedFont;
    });
  }
}

class MyWidget extends StatefulWidget {
  final TextProperties textProperties;

  const MyWidget({Key? key, required this.textProperties}) : super(key: key);

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  late double _left;
  late double _top;

  @override
  void initState() {
    super.initState();
    // Initialize the position based on the widget's properties
    _left = widget.textProperties.position.dx;
    _top = widget.textProperties.position.dy;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: _top,
      left: _left,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            _left = max(0, _left + details.delta.dx);
            _top = max(0, _top + details.delta.dy);
          });
        },
        onTap: () {
          useFuctionfromCanvas();
        },
        child: Text(
          widget.textProperties.text,
          style: GoogleFonts.getFont(
            widget.textProperties.fontfamily,
          ).copyWith(
              color: widget.textProperties.color,
              fontSize: widget.textProperties.fontSize),
        ),
      ),
    );
  }

  void useFuctionfromCanvas() {
    _CanvasScreenState canvasScreenInstance = _CanvasScreenState();
    canvasScreenInstance.loadValue(TextProperties(
        text: widget.textProperties.text,
        fontSize: widget.textProperties.fontSize,
        color: widget.textProperties.color,
        fontfamily: widget.textProperties.fontfamily,
        position: Offset(_top, _left)));
  }
}
