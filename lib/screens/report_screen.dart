import 'package:budget_flows/models/record.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:budget_flows/services/util.dart' as util;
import 'package:rflutter_alert/rflutter_alert.dart';

class ReportScreen extends StatefulWidget {
  static final String route = 'report';

  final String email;
  final List<Record> records;

  const ReportScreen({@required this.email, this.records});

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  double total = 0;

  @override
  void initState() {
    super.initState();
    updateRecordsView(widget.records);
  }

  void updateRecordsView(List<Record> records) {
    total = 0;
    for (Record record in records) {
      total += record.money;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Total: ${total.toStringAsFixed(0)} VND'),
      ),
      body: SafeArea(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return RecordView(
              id: widget.records[index].id,
              money: widget.records[index].money,
              reason: widget.records[index].reason,
              created: widget.records[index].created,
              deleteTap: () {
                Alert(
                  context: context,
                  title: 'Delete record',
                  desc:
                      '${widget.records[index].money} - ${widget.records[index].reason}',
                  buttons: [
                    DialogButton(
                      child: Text('OK'),
                      onPressed: () async {
                        await util.deleteRecord(widget.records[index].id);
                        setState(() {
                          total -= widget.records[index].money;
                          widget.records.removeAt(index);
                        });
                        Navigator.pop(context);
                      },
                    ),
                    DialogButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ).show();
              },
            );
          },
          itemCount: widget.records.length,
        ),
      ),
    );
  }
}

class RecordView extends StatelessWidget {
  final int id;
  final double money;
  final String reason;
  final DateTime created;
  final Function deleteTap;

  RecordView({
    this.id,
    this.money,
    this.reason,
    this.created,
    this.deleteTap,
  });

  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        leading: Text(money.toStringAsFixed(0)),
        title: Text(reason),
        subtitle: Text(DateFormat('yyyy-MM-dd HH:mm:ss').format(created)),
        trailing: GestureDetector(
          child: Icon(
            Icons.delete,
          ),
          onTap: deleteTap,
        ),
      ),
    );
  }
}
