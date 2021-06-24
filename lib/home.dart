import 'package:flutter/material.dart';

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String customerName = '';
  bool popupVisible = false;
  TapDownDetails tapDetails;
  String filter = '';
  int selectedCustomerName = 0;
  FocusNode _focusNode = FocusNode();
  FocusNode _textNode = FocusNode();
  List<String> customerNames = [
    'Fortescue Metals Group Ltd (FMG)',
    'Future Engineering : Future Engineering BIB',
    'MLG OZ Pty Ltd : MLG OZ Bib',
    'Rivet Mining Service',
    'Freo Stone Paving (COD)',
    'Roy Hill Iron Ore Pty Ltd : Mine Site',
    'Total Rubber (Cu) (C7)',
  ];
  List<String> filteredNames = [];
  List<String> subsections = [
    'Customer Name',
    'Job Lookup',
    'Update Fleet #',
    'Update Job Over...',
    'Customer Name',
    'Job Lookup',
    'Update Fleet #',
    'Update Job Over...',
  ];

  showPopup(TapDownDetails details) {
    setState(() {
      // filteredNames = customerNames;
      popupVisible = true;
      tapDetails = details;
      selectedCustomerName = 0;
    });

    _textNode.addListener(() {
      print(_textNode);
    });
    FocusScope.of(context).unfocus();
  }

  closePopup() {
    setState(() {
      popupVisible = false;
      filter = '';
      filteredNames = [];
      selectedCustomerName = 0;
    });
    _textNode.dispose();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(_focusNode);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        closePopup();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white.withOpacity(0.9),
        body: Stack(
          children: [
            SafeArea(
              child: Padding(
                padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.025),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Section 1',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.035,
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.symmetric(
                              vertical: BorderSide(
                            color: Colors.grey,
                            width: 2.0,
                          )),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
                          child: Column(
                            children: List.generate(
                              subsections.length,
                              (index) {
                                return GestureDetector(
                                  onTapDown: (details) {
                                    if (subsections[index] == 'Customer Name') {
                                      showPopup(details);
                                    }
                                  },
                                  child: Container(
                                    // height: MediaQuery.of(context).size.height * 0.15,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          subsections[index],
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context).size.height * 0.025,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        ListTile(
                                          title: Text(
                                            subsections[index] == 'Customer Name' ? customerName : '',
                                            style: TextStyle(
                                              fontSize: MediaQuery.of(context).size.height * 0.025,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            popupVisible
                ? tapDetails.globalPosition.dy < MediaQuery.of(context).size.height / 2
                    ? Positioned(
                        top: tapDetails.globalPosition.dy - 50,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.center,
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              Positioned(
                                top: 75,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                    color: Colors.blueGrey,
                                  ),
                                  height: MediaQuery.of(context).size.height * 0.475,
                                  width: MediaQuery.of(context).size.width * 0.6,
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(15.0),
                                            topLeft: Radius.circular(15.0),
                                          ),
                                          color: Colors.blueAccent,
                                        ),
                                        height: MediaQuery.of(context).size.height * 0.075,
                                        width: MediaQuery.of(context).size.width * 0.6,
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Please Select Option',
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context).size.height * 0.025,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                            ),
                                            height: MediaQuery.of(context).size.height * 0.075,
                                            width: MediaQuery.of(context).size.width * 0.6,
                                            alignment: Alignment.center,
                                            child: Container(
                                              height: MediaQuery.of(context).size.height * 0.05,
                                              width: MediaQuery.of(context).size.width * 0.55,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                                color: Colors.white,
                                              ),
                                              alignment: Alignment.center,
                                              child: TextField(
                                                focusNode: _focusNode,
                                                onChanged: (input) {
                                                  setState(() {
                                                    filter = input;
                                                  });

                                                  if (filter != '') {
                                                    for (int i = 0; i < customerNames.length; i++) {
                                                      if (customerNames[i].toLowerCase().startsWith(filter.toLowerCase()) && !filteredNames.contains(customerNames[i])) {
                                                        setState(() {
                                                          filteredNames.add(customerNames[i]);
                                                        });
                                                      }

                                                      if (!customerNames[i].toLowerCase().startsWith(filter.toLowerCase()) && filteredNames.contains(customerNames[i])) {
                                                        setState(() {
                                                          filteredNames.remove(customerNames[i]);
                                                        });
                                                      }
                                                    }
                                                  } else {
                                                    setState(() {
                                                      filteredNames = [];
                                                    });
                                                  }
                                                },
                                                style: TextStyle(
                                                  fontSize: MediaQuery.of(context).size.height * 0.02,
                                                ),
                                                decoration: InputDecoration(
                                                  hintText: "Filter",
                                                  hintStyle: TextStyle(
                                                    fontSize: MediaQuery.of(context).size.height * 0.02,
                                                  ),
                                                  border: InputBorder.none,
                                                  prefixIcon: Icon(
                                                    Icons.search,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          RawKeyboardListener(
                                            focusNode: _focusNode,
                                            onKey: (event) {
                                              print(event);
                                              if (event.toString().contains('RawKeyDownEvent') && event.toString().contains('Arrow Down')) {
                                                if (filter != '') {
                                                  if (selectedCustomerName < filteredNames.length - 1) {
                                                    setState(() {
                                                      selectedCustomerName++;
                                                    });
                                                  }
                                                } else {
                                                  if (selectedCustomerName < customerNames.length - 1) {
                                                    setState(() {
                                                      selectedCustomerName++;
                                                    });
                                                  }
                                                }
                                              }

                                              if (event.toString().contains('RawKeyDownEvent') && event.toString().contains('Arrow Up')) {
                                                if (selectedCustomerName > 0) {
                                                  setState(() {
                                                    selectedCustomerName--;
                                                  });
                                                }
                                              }

                                              if (event.toString().contains('RawKeyDownEvent') && event.toString().contains('Enter')) {
                                                setState(() {
                                                  if (filter != '') {
                                                    customerName = filteredNames[selectedCustomerName];
                                                  } else {
                                                    customerName = customerNames[selectedCustomerName];
                                                  }
                                                  filteredNames = [];
                                                  closePopup();
                                                });
                                              }
                                            },
                                            child: Container(
                                              height: MediaQuery.of(context).size.height * 0.275,
                                              width: MediaQuery.of(context).size.width * 0.6,
                                              color: Colors.white,
                                              child: ListView.builder(
                                                itemCount: filter != '' ? filteredNames.length : customerNames.length,
                                                itemBuilder: (context, index) {
                                                  return
                                                      // customerNames[index].toLowerCase().startsWith(filter.toLowerCase())
                                                      //     ?
                                                      Column(
                                                    children: [
                                                      Container(
                                                        color: selectedCustomerName == index ? Colors.black.withOpacity(0.175) : Colors.white,
                                                        child: ListTile(
                                                          leading: Container(
                                                            height: MediaQuery.of(context).size.width * 0.02,
                                                            width: MediaQuery.of(context).size.width * 0.02,
                                                            decoration: BoxDecoration(
                                                              shape: BoxShape.circle,
                                                              color: Colors.grey,
                                                            ),
                                                          ),
                                                          title: Text(
                                                            filter != '' ? filteredNames[index] : customerNames[index],
                                                            style: TextStyle(
                                                              fontSize: MediaQuery.of(context).size.height * 0.02,
                                                              color: Colors.black,
                                                              fontWeight: FontWeight.w500,
                                                            ),
                                                          ),
                                                          dense: false,
                                                          onTap: () {
                                                            setState(() {
                                                              if (filter != '') {
                                                                customerName = filteredNames[index];
                                                              } else {
                                                                customerName = customerNames[index];
                                                              }
                                                              filteredNames = [];
                                                              closePopup();
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      Divider(
                                                        color: Colors.grey,
                                                        thickness: 1.0,
                                                        height: 1.0,
                                                        indent: 25.0,
                                                      ),
                                                    ],
                                                  );
                                                  // : SizedBox();
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        height: MediaQuery.of(context).size.height * 0.05,
                                        width: MediaQuery.of(context).size.width * 0.6,
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.025),
                                          child: GestureDetector(
                                            behavior: HitTestBehavior.translucent,
                                            onTap: () {
                                              setState(() {
                                                filter = '';
                                              });
                                            },
                                            child: Text(
                                              'Clear Selection',
                                              style: TextStyle(
                                                fontSize: MediaQuery.of(context).size.height * 0.02,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height * 0.475 + 75,
                                alignment: Alignment.topCenter,
                                child: Icon(
                                  tapDetails.globalPosition.dy > MediaQuery.of(context).size.height / 2 ? Icons.arrow_drop_down_rounded : Icons.arrow_drop_up_rounded,
                                  size: 150,
                                  color: Colors.blueAccent,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Positioned(
                        bottom: MediaQuery.of(context).size.height - tapDetails.globalPosition.dy - 60,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.center,
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Positioned(
                                bottom: 75,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                    color: Colors.blueGrey,
                                  ),
                                  height: MediaQuery.of(context).size.height * 0.475,
                                  width: MediaQuery.of(context).size.width * 0.6,
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(15.0),
                                            topLeft: Radius.circular(15.0),
                                          ),
                                          color: Colors.blueAccent,
                                        ),
                                        height: MediaQuery.of(context).size.height * 0.075,
                                        width: MediaQuery.of(context).size.width * 0.6,
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Please Select Option',
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context).size.height * 0.025,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                        ),
                                        height: MediaQuery.of(context).size.height * 0.075,
                                        width: MediaQuery.of(context).size.width * 0.6,
                                        alignment: Alignment.center,
                                        child: Container(
                                          height: MediaQuery.of(context).size.height * 0.05,
                                          width: MediaQuery.of(context).size.width * 0.55,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                            color: Colors.white,
                                          ),
                                          alignment: Alignment.center,
                                          child: TextField(
                                            onChanged: (input) {
                                              filter = input;
                                              setState(() {});
                                            },
                                            style: TextStyle(
                                              fontSize: MediaQuery.of(context).size.height * 0.02,
                                            ),
                                            decoration: InputDecoration(
                                              hintText: "Filter",
                                              hintStyle: TextStyle(
                                                fontSize: MediaQuery.of(context).size.height * 0.02,
                                              ),
                                              border: InputBorder.none,
                                              prefixIcon: Icon(
                                                Icons.search,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: MediaQuery.of(context).size.height * 0.275,
                                        width: MediaQuery.of(context).size.width * 0.6,
                                        color: Colors.white,
                                        child: ListView.builder(
                                          itemCount: customerNames.length,
                                          itemBuilder: (context, index) {
                                            return customerNames[index].toLowerCase().startsWith(filter.toLowerCase())
                                                ? Column(
                                                    children: [
                                                      ListTile(
                                                        // tileColor: Colors.black,
                                                        leading: Container(
                                                          height: MediaQuery.of(context).size.width * 0.02,
                                                          width: MediaQuery.of(context).size.width * 0.02,
                                                          decoration: BoxDecoration(
                                                            shape: BoxShape.circle,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                        title: Text(
                                                          customerNames[index],
                                                          style: TextStyle(
                                                            fontSize: MediaQuery.of(context).size.height * 0.025,
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                        ),
                                                        dense: false,
                                                        onTap: () {
                                                          setState(() {
                                                            customerName = filteredNames[index];
                                                            filteredNames = customerNames;
                                                            closePopup();
                                                          });
                                                        },
                                                      ),
                                                      Divider(
                                                        color: Colors.grey,
                                                        thickness: 1.0,
                                                        height: 1.0,
                                                        indent: 25.0,
                                                      ),
                                                    ],
                                                  )
                                                : SizedBox();
                                          },
                                        ),
                                      ),
                                      Container(
                                        height: MediaQuery.of(context).size.height * 0.05,
                                        width: MediaQuery.of(context).size.width * 0.6,
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.025),
                                          child: GestureDetector(
                                            behavior: HitTestBehavior.translucent,
                                            onTap: () {
                                              setState(() {
                                                filter = '';
                                              });
                                            },
                                            child: Text(
                                              'Clear Selection',
                                              style: TextStyle(
                                                fontSize: MediaQuery.of(context).size.height * 0.02,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height * 0.475 + 75,
                                alignment: Alignment.bottomCenter,
                                child: Icon(
                                  tapDetails.globalPosition.dy > MediaQuery.of(context).size.height / 2 ? Icons.arrow_drop_down_rounded : Icons.arrow_drop_up_rounded,
                                  size: 150,
                                  color: Colors.blueGrey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
