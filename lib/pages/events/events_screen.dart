import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';

class EventData {
  final String name;
  final String location;
  final String time;
  final String participants;
  final DateTime date;

  EventData({
    required this.name,
    required this.location,
    required this.time,
    required this.participants,
    required this.date,
  });
}

class Event implements EventInterface {
  final EventData data;

  Event(this.data);

  @override
  DateTime getDate() {
    return data.date;
  }

  @override
  Widget getDot() {
    return Container(
      width: 6,
      height: 6,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue,
      ),
    );
  }

  @override
  String getDescription() {
    return data.name;
  }

  @override
  Widget? getIcon() {
    return Icon(Icons.event);
  }

  @override
  int? getId() {
    return data.date.millisecondsSinceEpoch;
  }

  @override
  String getLocation() {
    return data.location;
  }

  @override
  String getTitle() {
    return data.name;
  }
}

class EventsPage extends StatefulWidget {
  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  late DateTime _selectedDate;
  late List<Event> _events;
  late EventList<Event> _markedDateMap;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _events = [
      Event(
        EventData(
          name: 'Вишиванковий флешмоб "Слава ЗСУ!"',
          location: 'Стадіон',
          time: '10:20-10:35',
          participants: 'III-IV курс, викладачі',
          date: DateTime.now(),
        ),
      ),
      Event(
        EventData(
          name: 'Педрада за підсумками атестації',
          location: 'Музей',
          time: '...',
          participants: 'Викладачі, ЕК-201, ЕК-202',
          date: DateTime.now().add(Duration(days: 1)),
        ),
      ),
      // Add other events
    ];

    _markedDateMap = EventList<Event>(
      events: {
        for (var event in _events) event.data.date: [event]
      },
    );
  }

  List<Event> _getEventsForDay(DateTime day) {
    return _events.where((event) {
      return event.data.date.year == day.year &&
          event.data.date.month == day.month &&
          event.data.date.day == day.day;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Події'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: CalendarCarousel<Event>(
              onDayPressed: (DateTime date, List<Event> events) {
                setState(() {
                  _selectedDate = date;
                });
              },
              weekendTextStyle: TextStyle(color: Colors.red),
              thisMonthDayBorderColor: Colors.grey,
              daysHaveCircularBorder: true,
              markedDatesMap: _markedDateMap,
              markedDateShowIcon: true,
              markedDateIconBuilder: (event) {
                return event.getDot();
              },
              markedDateMoreShowTotal: null,
              markedDateIconMargin: 0,
              markedDateIconOffset: 3,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Text(
              'Події на $_selectedDate',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _getEventsForDay(_selectedDate).length,
              itemBuilder: (context, index) {
                Event event = _getEventsForDay(_selectedDate)[index];
                return ListTile(
                  title: Text(event.data.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Місце: ${event.data.location}'),
                      Text(
                          'На яку годину і хто: ${event.data.time} - ${event.data.participants}'),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
