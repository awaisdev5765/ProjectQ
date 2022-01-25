import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//confirmed=>book has been done
enum ReservationStatus { pending, booked, confirmed }

class ReservationPage extends StatefulWidget {
  @override
  _ReservationPageState createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  final Color mainColor = Color(0xffa020f0);
  int selectedDateIndex;
  bool mainIsIndoor = true;
  bool _autoValidate = false;
  int noOfTable = 1;
  TimeOfDay selectedTime = TimeOfDay.now();
  final Color boxColor = const Color(0xffe7e7e7);
  ReservationStatus reservationStatus = ReservationStatus.pending;

  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController numberController = TextEditingController();
  GlobalKey<FormState> form = GlobalKey();

  clearFormData() {
    nameController.clear();
    emailController.clear();
    numberController.clear();
    mainIsIndoor = true;
    selectedTime = TimeOfDay.now();
    selectedDateIndex = null;
    noOfTable = 1;
    reservationStatus = ReservationStatus.pending;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: reservationStatus == ReservationStatus.booked
          ? Container(
              height: 1,
              width: 1,
            )
          : Container(
              width: double.maxFinite,
              child: FlatButton(
                onPressed: () {
                  if (reservationStatus == ReservationStatus.pending) {
                    //time table data saves here
                    setState(() {
                      reservationStatus = ReservationStatus.confirmed;
                    });
                  } else {
                    ///save user details for confirmation
                    if (form.currentState.validate()) {
                      setState(() {
                        reservationStatus = ReservationStatus.booked;
                      });
                    }
                  }
                },
                color: mainColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    reservationStatus == ReservationStatus.confirmed
                        ? 'Confirm Reserve'
                        : 'Reserve',
                    style: TextStyle(
                      fontSize: 25,
                      color: const Color(0xffffffff),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
      body: reservationStatus == ReservationStatus.booked
          ? bookingFinalizedWidget()
          : SingleChildScrollView(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset(
                  'assets/img1.png',
                  height: 160,
                  width: double.maxFinite,
                  fit: BoxFit.fill,
                ),
                SizedBox(
                  height: 10,
                ),
                if (reservationStatus != ReservationStatus.booked)
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          offset: Offset(0, 6),
                          blurRadius: 4,
                        )
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 30),
                      child: Row(
                        children: <Widget>[
                          InkWell(
                              onTap: () {
                                if (reservationStatus ==
                                    ReservationStatus.confirmed)
                                  setState(() {
                                    reservationStatus =
                                        ReservationStatus.pending;
                                  });
                                else
                                  Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.grey,
                              )),
                          Expanded(
                              child: Text(
                            reservationStatus == ReservationStatus.confirmed
                                ? 'Your Details'
                                : 'Book Your Table',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: mainColor, fontSize: 25),
                          ))
                        ],
                      ),
                    ),
                  ),
                SizedBox(
                  height: 30,
                ),
                getRespectiveWidget()
              ],
            )),
    );
  }

  Widget getRespectiveWidget() {
    switch (reservationStatus) {
      case ReservationStatus.confirmed:
        return getReservationDetail();
      case ReservationStatus.pending:
        return getTimeTableWidget();

      default:
        return getTimeTableWidget();
    }
  }

  bookingFinalizedWidget() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/img1.png',
            height: 180,
            width: double.maxFinite,
            fit: BoxFit.fill,
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 40,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: CircleAvatar(
                  backgroundColor: mainColor,
                  radius: MediaQuery.of(context).size.width < 300
                      ? MediaQuery.of(context).size.width * 0.3
                      : 130,
                  child: Center(
                    child: Icon(
                      Icons.check,
                      size: 150,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Reservation Confirmed.\nYour reservation number is',
                style: TextStyle(
                  fontSize: 17,
                  color: const Color(0xff898989),
                  letterSpacing: -0.17,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '#5678',
                style: TextStyle(
                  fontSize: 26,
                  color: const Color(0xffc600ef),
                  letterSpacing: -0.26,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.keyboard_backspace,
                          color: Color(0xff748A9D),
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: () {
                          reservationStatus = ReservationStatus.pending;
                          clearFormData();
                        },
                        child: Icon(
                          Icons.add_circle,
                          color: Color(0xff748A9D),
                          size: 50,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  getReservationDetail() {
    return Form(
      key: form,

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Kindly Fill In The Below Information',
                style: TextStyle(
                  fontSize: 15,
                  color: const Color(0xff748a9d),
                  letterSpacing: -0.15,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width < 350
                    ? MediaQuery.of(context).size.width - 50
                    : 350,
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                decoration: BoxDecoration(
                    color: Color(0xff748A9D).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Full Name',
                      style: TextStyle(
                        fontSize: 16,
                        color: const Color(0xff748a9d),
                        letterSpacing: -0.16,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    TextFormField(
                      validator: (value) => value.toString().trim().isEmpty
                          ? 'Name Required'
                          : null,
                      controller: nameController,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(0)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Email',
                      style: TextStyle(
                        fontSize: 16,
                        color: const Color(0xff748a9d),
                        letterSpacing: -0.16,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    TextFormField(
                      validator: (value) => value.toString().trim().isEmpty
                          ? 'Email Address Required'
                          : null,
                      controller: emailController,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(0)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Mobile Number',
                      style: TextStyle(
                        fontSize: 16,
                        color: const Color(0xff748a9d),
                        letterSpacing: -0.16,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    TextFormField(
                      validator: (value) => value.toString().trim().isEmpty
                          ? 'Number Required'
                          : null,
                      controller: numberController,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(0)),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  getTimeTableWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          'Where Do You Want To Eat?',
          style: TextStyle(
            fontSize: 20,
            color: const Color(0xff000000),
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            rectangleWidget(true),
            SizedBox(
              width: 70,
            ),
            rectangleWidget(false),
          ],
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          'How Many Persons?',
          style: TextStyle(
            fontSize: 20,
            color: const Color(0xff000000),
          ),
          textAlign: TextAlign.left,
        ),
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: () {
                  if (noOfTable > 1) {
                    setState(() {
                      noOfTable--;
                    });
                  }
                },
                child: Icon(
                  Icons.remove,
                  color: mainColor,
                  size: 55,
                ),
              ),
              SizedBox(
                width: 30,
              ),
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                    color: mainColor, borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    noOfTable.toString(),
                    style: TextStyle(
                      fontSize: 40,
                      color: const Color(0xffffffff),
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                width: 30,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    noOfTable++;
                  });
                },
                child: Icon(
                  Icons.add,
                  color: mainColor,
                  size: 55,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          'Date',
          style: TextStyle(
            fontSize: 20,
            color: const Color(0xff000000),
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          '(${getMonthFromInt(DateTime.now().month)})',
          style: TextStyle(
            color: const Color(0xffc600ef),
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            dateWidget(29, 'Tue'),
            SizedBox(
              width: 25,
            ),
            dateWidget(30, 'Wed'),
            SizedBox(
              width: 25,
            ),
            dateWidget(31, 'Fri'),
            SizedBox(
              width: 25,
            ),
            dateWidget(null, 'Fri', isDatePicker: true),
          ],
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          'Time',
          style: TextStyle(
            fontSize: 20,
            color: const Color(0xff000000),
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 20,
        ),
        InkWell(
          onTap: () async {
            final data = await showTimePicker(
                context: context, initialTime: TimeOfDay.now());
            if (data != null) {
              setState(() {
                selectedTime = data;
              });
            }
          },
          child: Container(
            width: 350,
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
            decoration: BoxDecoration(
              color: boxColor,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    selectedTime.hour.toString() +
                        ':' +
                        selectedTime.minute.toString(),
                    style: TextStyle(
                      fontSize: 20,
                      color: const Color(0xff000000),
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Icon(Icons.keyboard_arrow_up),
                    Icon(Icons.keyboard_arrow_down)
                  ],
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 60,
        ),
      ],
    );
  }

  dateWidget(int date, String day, {bool isDatePicker = false}) {
    return InkWell(
      onTap: () async {
        if (date == null) {
          final d = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2099));
          if (d != null) {
            setState(() {
              selectedDateIndex = date;
            });
          }
        } else
          setState(() {
            selectedDateIndex = date;
          });
      },
      child: Container(
        height: 55,
        width: 70,
        //padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: isDatePicker
            ? Center(
                child: Icon(Icons.event,
                    size: 35,
                    color:
                        selectedDateIndex == date ? Colors.white : mainColor))
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      date.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: selectedDateIndex == date
                              ? Colors.white
                              : Colors.black),
                    ),
                    Text(
                      day.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: selectedDateIndex == date
                              ? Colors.white
                              : Colors.black),
                    ),
                  ],
                ),
              ),
        decoration: BoxDecoration(
          color: selectedDateIndex == date ? mainColor : boxColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: Offset(0, 6),
              blurRadius: 4,
            )
          ],
        ),
      ),
    );
  }

  rectangleWidget(bool isIndoor) {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: () {
            setState(() {
              mainIsIndoor = !mainIsIndoor;
            });
          },
          child: Container(
            height: 100,
            width: 120,
            decoration: BoxDecoration(
              color: !mainIsIndoor
                  ? isIndoor ? boxColor : mainColor
                  : !isIndoor ? boxColor : mainColor,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: Offset(0, 6),
                  blurRadius: 4,
                )
              ],
            ),
            child: Center(
              child: Icon(Icons.restaurant, color: Colors.white),
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          isIndoor ? 'Indoor' : 'Outdoor',
          style: TextStyle(
            fontSize: 16,
            color: const Color(0xff000000),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  getMonthFromInt(int index) {
    switch (index) {
      case DateTime.january:
        return 'January';
      case DateTime.february:
        return 'February';
      case DateTime.march:
        return 'March';
      case DateTime.april:
        return 'April';
      case DateTime.may:
        return 'May';
      case DateTime.june:
        return 'June';
      case DateTime.july:
        return 'July';
      case DateTime.august:
        return 'August';
      case DateTime.september:
        return 'September';
      case DateTime.october:
        return 'October';
      case DateTime.november:
        return 'November';
      case DateTime.december:
        return 'December';

      default:
        return 'January';
    }
  }
}

const String _svg_6veaem =
    '<svg viewBox="4.5 0.0 1.0 9.0" ><path transform="translate(4.48, 0.0)" d="M 0 0 L 0 8.954836845397949" fill="none" stroke="#ffffff" stroke-width="4" stroke-linecap="round" stroke-linejoin="round" /></svg>';
const String _svg_ft3gq =
    '<svg viewBox="0.0 4.5 9.0 1.0" ><path transform="translate(0.0, 4.48)" d="M 8.954836845397949 0 L 0 0" fill="none" stroke="#ffffff" stroke-width="4" stroke-linecap="round" stroke-linejoin="round" /></svg>';
const String _svg_hfnj72 =
    '<svg viewBox="44.7 57.2 59.6 41.9" ><path transform="translate(465.86, -334.45)" d="M -421.1812744140625 415.7786254882813 L -403.4408569335938 433.5189208984375 L -361.5759582519531 391.6539001464844" fill="none" stroke="#ffffff" stroke-width="9" stroke-linecap="round" stroke-linejoin="round" /></svg>';
const String _svg_mzmb6c =
    '<svg viewBox="144.5 183.3 20.4 8.7" ><path transform="translate(144.51, 183.31)" d="M 20.39994239807129 0 L 0 8.726544380187988" fill="none" stroke="#ffffff" stroke-width="4" stroke-linecap="round" stroke-linejoin="round" /></svg>';
const String _svg_sr7rb6 =
    '<svg viewBox="144.5 192.5 13.9 6.0" ><path transform="translate(144.51, 192.53)" d="M 13.9495964050293 0 L 0 5.967260360717773" fill="none" stroke="#ffffff" stroke-width="4" stroke-linecap="round" stroke-linejoin="round" /></svg>';
