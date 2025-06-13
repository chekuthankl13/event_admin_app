import 'package:event_admin/core/config/config.dart';
import 'package:event_admin/core/utils/utils.dart';
import 'package:event_admin/features/event/cubit/event_cubit.dart';
import 'package:event_admin/features/event/domain/entity/event_arguments.dart';
import 'package:event_admin/widget/custom_btn.dart';
import 'package:event_admin/widget/custom_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';

class EventCreateUpdateScreen extends StatefulWidget {
  final EventArguments arg;
  const EventCreateUpdateScreen({super.key, required this.arg});

  @override
  State<EventCreateUpdateScreen> createState() =>
      _EventCreateUpdateScreenState();
}

class _EventCreateUpdateScreenState extends State<EventCreateUpdateScreen> {
  TextEditingController titleCntr = TextEditingController();
  TextEditingController locationCntr = TextEditingController();
  TextEditingController dateCntr = TextEditingController();
  TextEditingController disCntr = TextEditingController();
  GlobalKey<FormState> fkey = GlobalKey<FormState>();

  @override
  void dispose() {
    titleCntr.dispose();
    locationCntr.dispose();
    dateCntr.dispose();
    disCntr.dispose();
    EasyLoading.dismiss();
    super.dispose();
  }

  @override
  void initState() {
    titleCntr.text = widget.arg.title;
    locationCntr.text = widget.arg.location;
    dateCntr.text = widget.arg.date;
    disCntr.text = widget.arg.description;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.arg.isCreate ? "Create Event" : "Update Event"),
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        padding: EdgeInsets.all(10),
        child: Form(
          key: fkey,
          child: Column(
            spacing: 15,
            children: [
              CustomField().simple(
                hint: "eg: sample ",
                cntr: titleCntr,
                leadingIc: Icons.numbers,
                label: "Event Name",
                isReq: true,
                isfilter: true,
              ),
              CustomField().simple(
                hint: "eg: new york ",
                cntr: locationCntr,
                leadingIc: Icons.location_on_outlined,
                label: "Event Location",
                isReq: true,
                isfilter: true,
              ),
              CustomField().readOnly(
                isdense: false,
                cntr: dateCntr,
                hint: "Event Date",
                ontap: () async {
                  date(
                    context,
                    cntr: dateCntr,
                    firstdate: DateTime(2000),
                    lastdate: DateTime(DateTime.now().year + 1),
                  );
                },
              ),
              CustomField().simple(
                hint: "eg: gggg... ",
                cntr: disCntr,
                leadingIc: Icons.messenger_outline,
                label: "Event Description",
                isReq: true,
                isTwoLine: true,
                isfilter: true,
              ),

              CustomBtn().normal(
                size: Size(sW(context) / 2, 40),
                txt: widget.arg.isCreate ? "Create" : "Update",
                onPressed: () async {
                  if (fkey.currentState!.validate()) {
                    EasyLoading.show();
                    var res = widget.arg.isCreate
                        ? (await context.read<EventCubit>().create(
                            date: dateCntr.text,
                            description: disCntr.text,
                            location: locationCntr.text,
                            title: titleCntr.text,
                          ))
                        : (await context.read<EventCubit>().update(
                            id: widget.arg.id,
                            date: dateCntr.text,
                            description: disCntr.text,
                            location: locationCntr.text,
                            title: titleCntr.text,
                          ));

                    if (res['status'] == "ok") {
                      EasyLoading.dismiss();
                      EasyLoading.showSuccess(
                        widget.arg.isCreate
                            ? "event successfully created !!"
                            : "event successfully updated !!",
                      );
                      navigatorKey.currentState!.pop(true);
                    } else {
                      EasyLoading.dismiss();
                      EasyLoading.showError(res['message']);
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future date(
  context, {
  required TextEditingController cntr,
  firstdate,
  lastdate,
}) async {
  var pickeddate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: firstdate,
    lastDate: lastdate,
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: Config.violetClr,
            onPrimary: Config.whiteClr,
            onSurface: Colors.black,
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(foregroundColor: Colors.black),
          ),
        ),
        child: child!,
      );
    },
  );

  if (pickeddate != null) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(pickeddate);
    cntr.text = formattedDate;
  }
}
