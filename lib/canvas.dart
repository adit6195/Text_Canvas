import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:text_canvas/textclass.dart';

// ignore: use_key_in_widget_constructors
class CanvasScreen extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _CanvasScreenState createState() => _CanvasScreenState();
}

class _CanvasScreenState extends State<CanvasScreen> {
  String selectedFont = 'Lato';
  final TextEditingController _textcontroller = TextEditingController();
  final TextEditingController _sizecontroler = TextEditingController();
  double canvasHeight = 510;
  double canvasWidth = 320;
  TextProperties? activeItem;
  Offset initalPosition = const Offset(20, 20);
  Offset currentPosition = const Offset(20, 20);
  bool inAction = false;
  List<TextProperties> textList = [];
  String currentText = "Sample";
  Color currentColor = const Color(0xff000000);
  Color pickerColor = Colors.green;
  double currentFontSize = 20.0;

  List<TextProperties> undoStack = [];
  List<TextProperties> redoStack = [];

  List<String> fontFamilyList = [
    "Lato",
    "Montserrat",
    "Lobster",
    "Pacifico",
    "Spectral SC",
    "Oswald",
    "Bangers",
    "Anton"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[500],
      // appBar: AppBar(title: Text("Check")),
      body: Stack(
        children: [
          Positioned(top: 47, left: 20, child: canvas()),
          Positioned(
            bottom: 181,
            child: colorPalette(context),
          ),
          Positioned(
            bottom: 0,
            child: bottomToolBar(),
          ),
        ],
      ),
    );
  }

  void undo() {
    setState(() {
      if (textList.isNotEmpty) {
        redoStack.add(textList.removeLast());
      }
    });
  }

  void redo() {
    setState(() {
      if (redoStack.isNotEmpty) {
        textList.add(redoStack.removeLast());
      }
    });
  }

  Widget bottomToolBar() {
    return Container(
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
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 15),
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
                SizedBox(
                  width: 90,
                  child: TextField(
                    onChanged: (value) {
                      currentFontSize = double.parse(value);
                    },
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                    decoration: InputDecoration(
                      labelStyle: const TextStyle(
                        color: Colors.white,
                      ),
                      labelText: "Size",
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
                    controller: _sizecontroler,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 60,
                  width: 200,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.white)),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 5, right: 8),
                        child: Text(
                          "Font:",
                          style: TextStyle(color: Colors.white, fontSize: 18),
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
                      setState(() {
                        activeItem = null;
                      });

                      if (currentText.isNotEmpty) {
                        setState(() {
                          textList.add(TextProperties(
                              text: currentText,
                              fontSize: currentFontSize,
                              color: currentColor,
                              fontfamily: selectedFont,
                              position: const Offset(0.4, 0.4)));
                        });
                        _sizecontroler.clear();
                        _textcontroller.clear();
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        "Add Text",
                        style: TextStyle(fontSize: 16),
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  colorPalette(BuildContext context) {
    return Container(
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
                  setState(() {
                    currentColor = Colors.white;
                  });
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
                  setState(() {
                    currentColor = Colors.black;
                  });
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
                  setState(() {
                    currentColor = Colors.red;
                  });
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
                  setState(() {
                    currentColor = Colors.orange;
                  });
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
                  setState(() {
                    currentColor = Colors.yellow;
                  });
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
                  setState(() {
                    currentColor = Colors.green;
                  });
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
                  setState(() {
                    currentColor = Colors.blue;
                  });
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
    );
  }

  GestureDetector canvas() {
    return GestureDetector(
      onScaleStart: (details) {
        if (activeItem == null) return;
        initalPosition = details.focalPoint;
        currentPosition = activeItem!.position;
      },
      onScaleUpdate: (details) {
        if (activeItem == null) return;
        final delta = details.focalPoint - initalPosition;
        final left = (delta.dx / canvasWidth) + currentPosition.dx;
        final top = (delta.dy / canvasHeight) + currentPosition.dy;

        activeItem!.position = Offset(left, top);
      },
      onTapUp: (details) {
        // Check if tapped on an existing item
        for (TextProperties item in textList) {
          if (isTapInside(details.localPosition, item)) {
            editDialog(item);
            break;
          }
        }
      },
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.white,
        ),
        height: canvasHeight,
        width: canvasWidth,
        child: Stack(
          children: [
            Positioned(
              top: 20,
              left: 20,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      undo();
                    },
                    child: const Icon(
                      Icons.undo,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      redo();
                    },
                    child: const Icon(
                      Icons.redo,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            ...textList.map(buildItemWidget).toList(),
          ],
        ),
      ),
    );
  }

  bool isTapInside(Offset tapPosition, TextProperties item) {
    double itemLeft = item.position.dx * canvasWidth;
    double itemTop = item.position.dy * canvasHeight;

    if (tapPosition.dx >= itemLeft &&
        tapPosition.dx <= itemLeft + (canvasWidth / 4) &&
        tapPosition.dy >= itemTop &&
        tapPosition.dy <= itemTop + (canvasHeight / 4)) {
      return true;
    }

    return false;
  }

  void editDialog(TextProperties item) {
    TextEditingController textcontroller =
        TextEditingController(text: item.text);
    TextEditingController sizecontroller =
        TextEditingController(text: item.fontSize.toString());

    showDialog(
      context: context,
      builder: (ctx) {
        String selectedFontFamily = item.fontfamily;
        Color selectedColor = item.color;
        double selectedFontSize = item.fontSize;
        return AlertDialog(
          backgroundColor: Colors.black,
          title: const Text('Edit Font Properties',
              style: TextStyle(color: Colors.white)),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: textcontroller,
                      // onChanged: (value) {
                      //   setState(() {
                      //     item.value = value;
                      //   });
                      // },
                      style: const TextStyle(color: Colors.white),
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
                    const SizedBox(
                      height: 15,
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: sizecontroller,
                      onChanged: (value) {
                        setState(() {
                          selectedFontSize = double.parse(value);
                        });
                      },
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        labelText: "Enter Size",
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
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 60,
                      width: 230,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 5, right: 8),
                            child: Text(
                              "Font:",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                          DropdownButton<String>(
                            value: selectedFontFamily,
                            onChanged: (String? value) {
                              setState(() {
                                selectedFontFamily = value!;
                              });
                            },
                            items: fontFamilyList
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,
                                    style: GoogleFonts.getFont(value,
                                        color: selectedFontFamily == value
                                            ? Colors.white
                                            : Colors.black)),
                              );
                            }).toList(),
                            hint: const Text('Font Family'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          border: Border.all(color: Colors.white)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Column(
                          children: [
                            Row(children: [
                              const Text(
                                "Colors :",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              const SizedBox(
                                width: 10,
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
                                                  selectedColor = pickerColor;
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
                                      color: selectedColor,
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
                                  setState(() {
                                    selectedColor = Colors.white;
                                  });
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
                                  setState(() {
                                    selectedColor = Colors.black;
                                  });
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
                                  setState(() {
                                    selectedColor = Colors.red;
                                  });
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
                            ]),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 79,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedColor = Colors.orange;
                                    });
                                  },
                                  child: Container(
                                    height: 28,
                                    width: 28,
                                    decoration: BoxDecoration(
                                        color: Colors.orange,
                                        shape: BoxShape.circle,
                                        border:
                                            Border.all(color: Colors.white)),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedColor = Colors.yellow;
                                    });
                                  },
                                  child: Container(
                                    height: 28,
                                    width: 28,
                                    decoration: BoxDecoration(
                                        color: Colors.yellow,
                                        shape: BoxShape.circle,
                                        border:
                                            Border.all(color: Colors.white)),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedColor = Colors.green;
                                    });
                                  },
                                  child: Container(
                                    height: 28,
                                    width: 28,
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        shape: BoxShape.circle,
                                        border:
                                            Border.all(color: Colors.white)),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedColor = Colors.blue;
                                    });
                                  },
                                  child: Container(
                                    height: 28,
                                    width: 28,
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        shape: BoxShape.circle,
                                        border:
                                            Border.all(color: Colors.white)),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actionsPadding: const EdgeInsets.all(30),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Set the button color to red
              ),
              child: const Text('Delete'),
              onPressed: () {
                setState(() {
                  textList.remove(item);
                  activeItem = null;
                });
                Navigator.of(ctx).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Edit Text'),
              onPressed: () {
                setState(() {
                  item.text = textcontroller.text;
                  item.color = selectedColor;
                  item.fontfamily = selectedFontFamily;
                  item.fontSize = selectedFontSize;
                });
                Navigator.of(ctx).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget buildItemWidget(TextProperties e) {
    return Positioned(
      top: e.position.dy * canvasHeight,
      left: e.position.dx * canvasWidth,
      child: Listener(
        onPointerDown: (details) {
          if (inAction) return;
          inAction = true;
          activeItem = e;
          initalPosition = details.position;
          currentPosition = e.position;
        },
        onPointerUp: (details) {
          inAction = false;

          setState(() {
            activeItem = null;
          });
        },
        onPointerCancel: (details) {},
        onPointerMove: (details) {
          if (e.position.dy >= 0.8 &&
              e.position.dx >= 0.0 &&
              e.position.dx <= 1.0) {
            setState(() {});
          } else {
            setState(() {});
          }
        },
        child: Text(
          e.text,
          style: GoogleFonts.getFont(e.fontfamily)
              .copyWith(color: e.color, fontSize: e.fontSize),
        ),
      ),
    );
  }
}
