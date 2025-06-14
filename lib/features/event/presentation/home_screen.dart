import 'package:event_admin/core/config/config.dart';
import 'package:event_admin/core/db/db_service.dart';
import 'package:event_admin/core/utils/utils.dart';
import 'package:event_admin/features/event/cubit/event_cubit.dart';
import 'package:event_admin/features/event/domain/entity/event_arguments.dart';
import 'package:event_admin/features/event/domain/entity/event_entity.dart';
import 'package:event_admin/widget/custom_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventCubit, EventState>(
      builder: (context, state) {
        switch (state) {
          case Loading _:
            return scafoldloading(txt: "ADMIN PANEL");

          case Error e:
            return scafolderror(
              e.error,
              "ADMIN PANEL",
              onPressed: () => context.read<EventCubit>().load(),
            );

          case Loaded e:
            return Scaffold(
              appBar: AppBar(
                title: Text("ADMIN PANEL"),
                actions: [
                  IconButton(
                    icon: Icon(Icons.exit_to_app),
                    onPressed: () async {
                      await showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) => AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          title: Text("Log Out !!"),
                          insetPadding: EdgeInsets.all(10),
                          backgroundColor: Colors.white,
                          titlePadding: EdgeInsets.all(20),
                          titleTextStyle: TextStyle(
                            // fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Config.violetClr,
                          ),
                          contentPadding: EdgeInsets.all(10),
                          content: SizedBox(
                            width: sW(context),
                            child: Text(
                              "Are you sure, you want to Logout from the app ?",
                            ),
                          ),
                          actions: [
                            TextButton(
                              child: Text("cancel"),
                              onPressed: () {
                                navigatorKey.currentState!.pop();
                              },
                            ),

                            CustomBtn().normal(
                              txt: "Log out",
                              color: Config.violetClr,
                              size: Size(80, 30),
                              onPressed: () async {
                                EasyLoading.show();
                                await DbService().clear();
                                navigatorKey.currentState!
                                    .pushNamedAndRemoveUntil(
                                      "/splash",
                                      (route) => false,
                                    );

                                EasyLoading.dismiss();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  navigatorKey.currentState!
                      .pushNamed(
                        "/create_update",
                        arguments: EventArguments(
                          date: "",
                          description: "",
                          id: "",
                          location: "",
                          title: "",
                          isCreate: true,
                        ),
                      )
                      .then((value) {
                        if (value != null && value == true) {
                          // ignore: use_build_context_synchronously
                          context.read<EventCubit>().load();
                        }
                      });
                },
                backgroundColor: Config.violetClr,
                child: Icon(Icons.add, color: Colors.white),
              ),
              body: body(e.events),
            );
          default:
            return scafoldloading(txt: "ADMIN PANEL");
        }
      },
    );
  }

  body(List<EventEntity> events) {
    return events.isEmpty
        ? itemEmpty(context, "NO EVENTS FOUND !!")
        : ListView.builder(
            shrinkWrap: true,
            padding:  EdgeInsets.all(5),
            physics: AlwaysScrollableScrollPhysics(),
            itemCount: events.length,
            itemBuilder: (context, index) {
              var data = events[index];
              final List<Color> clr = List.generate(
                events.length,
                (i) => _getColorFromBase(i, events.length),
              );
              return InkWell(
                splashColor: Config.whiteClr,
                onTap: () async {
                  await viewDialog(context, data);
                },
                child: Container(
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(10),
                  // height: 100,
                  width: sW(context),
                  decoration: BoxDecoration(
                    color: Config.orangeAccent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    spacing: 10,
                    children: [
                      Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: clr[index],
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          data.title.split("")[0].toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 5,
                          children: [
                            Row(
                              spacing: 2,
                              children: [
                                Icon(Icons.numbers, color: Config.grey2Clr),
                                Text(
                                  data.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              spacing: 2,
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  color: Config.grey2Clr,
                                ),
                                Expanded(
                                  child: Text(
                                    data.location,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              spacing: 2,
                              children: [
                                Icon(
                                  Icons.calendar_month_outlined,
                                  color: Config.grey2Clr,
                                ),
                                Text(
                                  data.date,
                                  style: TextStyle(
                                    color: Config.redAccentLigthClr,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }

  Future<void> viewDialog(BuildContext context, EventEntity data) async {
    showDialog(
      context: context,
      builder: (BuildContext contexts) {
        return AlertDialog(
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          title: Row(
            children: [
              Icon(Icons.numbers, color: Config.violetClr),
              Text(data.title),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              spacing: 10,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 2,
                  children: [
                    Text(
                      'Description:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(data.description),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Location:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    spaceWidth(4),
                    Expanded(child: Text(data.location)),
                  ],
                ),
                Row(
                  spacing: 2,
                  children: [
                    Text(
                      'Date:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    spaceWidth(2),
                    Text(data.date),
                  ],
                ),
                // Add more fields as needed
              ],
            ),
          ),
          actions: [
            CustomBtn().normal(
              onPressed: () async {
                await showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    title: Text("Delete !!"),
                    insetPadding: EdgeInsets.all(10),
                    backgroundColor: Colors.white,
                    titlePadding: EdgeInsets.all(20),
                    titleTextStyle: TextStyle(
                      // fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Config.violetClr,
                    ),
                    contentPadding: EdgeInsets.all(10),
                    content: SizedBox(
                      width: sW(context),
                      child: Text(
                        "Are you sure, you want to delete ${data.title}?",
                      ),
                    ),
                    actions: [
                      TextButton(
                        child: Text("cancel"),
                        onPressed: () {
                          navigatorKey.currentState!.pop();
                        },
                      ),

                      CustomBtn().normal(
                        txt: "Delete",
                        color: Config.redAccentLigthClr,
                        size: Size(80, 30),
                        onPressed: () async {
                          EasyLoading.show();
                          var res = await BlocProvider.of<EventCubit>(
                            context,
                          ).delete(data.id);

                          if (res['status'] == "ok") {
                            EasyLoading.dismiss();
                            EasyLoading.showSuccess(
                              "event successfully delete !!",
                            );
                            navigatorKey.currentState!.pop();
                            navigatorKey.currentState!.pop();
                            // ignore: use_build_context_synchronously
                            context.read<EventCubit>().load();
                          } else {
                            EasyLoading.dismiss();
                            EasyLoading.showError(res['message']);
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
              txt: "Delete",
              size: Size(100, 20),
              color: Colors.red,
            ),
            CustomBtn().normal(
              onPressed: () async {
                navigatorKey.currentState!.pop();
                navigatorKey.currentState!
                    .pushNamed(
                      "/create_update",
                      arguments: EventArguments(
                        date: data.date,
                        description: data.description,
                        id: data.id,
                        location: data.location,
                        title: data.title,
                        isCreate: false,
                      ),
                    )
                    .then((value) {
                      if (value != null && value == true) {
                        // ignore: use_build_context_synchronously
                        context.read<EventCubit>().load();
                      }
                    });
              },
              txt: "Edit",
              size: Size(100, 20),
              color: Colors.green,
            ),
            TextButton(
              onPressed: () => navigatorKey.currentState!.pop(),
              child: Text('Close', style: TextStyle(color: Config.violetClr)),
            ),
          ],
        );
      },
    );
  }
}

Color _getColorFromBase(int index, int totalItems) {
  // Convert violetClr to HSL for easier hue manipulation
  HSLColor hslColor = HSLColor.fromColor(
    const Color.fromARGB(255, 206, 223, 255),
  );
  // Calculate hue shift to evenly distribute colors
  double hueShift = (360.0 / totalItems) * index;
  // Apply hue shift, keeping saturation and lightness constant
  HSLColor shiftedColor = hslColor.withHue((hslColor.hue + hueShift) % 360);
  return shiftedColor.toColor();
}
