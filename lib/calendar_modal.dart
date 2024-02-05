import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

/*
Calendar challenge sample implementation.
https://lazztech-blog.vercel.app/articles/ua90uofcrdx

 */

class Calendar extends StatefulWidget {
//  const Calendar({Key? key}) : super(key: key);
  DateTime selected_date = DateTime.now();
  Calendar({Key? key}) :super(key: key);
  late Function call_back;

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _forcusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: DateTime.now(),
      calendarFormat: _calendarFormat,
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: (selectedDay, forcusedDay) {
        print("[S]######" + widget.selected_date.toString());
        if (!isSameDay(_selectedDay, selectedDay)) {
          setState(() {
            _selectedDay = selectedDay;
            _forcusedDay = forcusedDay;
            widget.selected_date = _selectedDay;
            widget.call_back(_selectedDay);
            print("[M]######" + widget.selected_date.toString());
          });
        }
        print("[E]######" + widget.selected_date.toString());
      },
      onFormatChanged: (format) {
        if (_calendarFormat != format) {
          // Call `setState()` when updating calendar format
          setState(() {
            _calendarFormat = format;
          });
        }
      },
      onPageChanged: (forcusedDay) {
        _forcusedDay = forcusedDay;
      },
    );
  }
}

class CustomModal extends PopupRoute<void> {
  final Widget contents;

  CustomModal(this.contents): super();

  @override
  Duration get transitionDuration => Duration(milliseconds: 100);
  @override
  bool get barrierDismissible => false;
  @override
  Color get barrierColor => Colors.black.withOpacity(0.5);
  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return Material(
        type: MaterialType.transparency,
        child: SafeArea(child: _buildOverlayContent(context))
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
        opacity: animation,
        child: ScaleTransition(
            scale: animation,
            child: child
        )
    );
  }

  Widget _buildOverlayContent(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 32, vertical: 64),
        padding: EdgeInsets.all(16),
        color: Colors.white,
        child: Center(
            child: this.contents
        )
    );
  }
}



class CalendarModal {
  Calendar cal = Calendar();
  BuildContext context;
  CalendarModal(this.context) : super();

  void showCalendarModal(Function onHideCalender) {
    print("///////////////////////////INFO:start");
    Navigator.push(
        context,
        CustomModal(
            Column(
                children: [
                  cal,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
/*                      TextButton(
                        child: const Text('キャンセル'),
                        onPressed: () => hideModal(),
                      ),*/
                      TextButton(
                        child: const Text('閉じる'),
                        onPressed: () => {hideModal(),onHideCalender()}
                        //onPressed: () {},
                      ),
                    ],
                  )
                ]
            )
        )
    );
    print("///////////////////////////INFO:end");
  }

  void hideModal() {
    Navigator.of(context).pop();
  }
}