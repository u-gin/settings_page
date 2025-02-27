import 'package:settings_page/screens/events/empty_create_event_page.dart';

import '../../util/exports.dart';

class AllEvents extends StatefulWidget {
  const AllEvents({Key? key}) : super(key: key);

  @override
  State<AllEvents> createState() => _AllEventsState();
}

class _AllEventsState extends State<AllEvents> {
  late final eventsList = <EventDataModel>[event1, event2, event3];
  late var activeEventsList = <EventDataModel>[];
  late var draftEventsList = <EventDataModel>[];
  late var expiredEventsList = <EventDataModel>[];
  int currentTab = 0;
  final List<Tab> tabs = <Tab>[
    const Tab(text: 'All'),
    const Tab(text: 'Active'),
    const Tab(text: 'Draft'),
    const Tab(text: 'Expired'),
  ];

  @override
  void initState() {
    eventsList.forEach((element) {
      element.eventStatus == "Active"
          ? activeEventsList.add(element)
          : element.eventStatus == "Draft"
              ? draftEventsList.add(element)
              : element.eventStatus == "Expired"
                  ? expiredEventsList.add(element)
                  : null;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _height = Get.height;
    double _width = Get.width;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppbarWidget(
            appBarTitle: "lbl_events".tr,
            hasActions: true,
            trailingWidget:
                CommonImageView(imagePath: "assets/images/filter.png"),
          ),
        ),
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ButtonIcon(
              icon: Icons.add_rounded,
              onPressed: () {
                Get.to(EmptyCreateEventPage());
              },
              text: "lbl_create_program".tr),
        ),
        body: Container(
          height: _height,
          width: _width,
          color: Colors.white,
          child: Column(
            children: [
              Constants.spaceMediumColumn,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CustomTabs(
                  tabs: tabs,
                  switchTab: (index) {
                    setState(() {
                      currentTab = index;
                    });
                  },
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 8.0, left: 16, right: 16, bottom: 100),
                  child: currentTab == 0
                      ? ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount:
                              eventsList.length == 0 ? 1 : eventsList.length,
                          itemBuilder: ((context, index) {
                            return eventsList.length == 0
                                ? emptyEvents()
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0, horizontal: 5),
                                    child: EventCard(
                                        eventDataModel: eventsList[index]));
                          }),
                        )
                      : currentTab == 1
                          ? ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              padding: EdgeInsets.zero,
                              itemCount: activeEventsList.length == 0
                                  ? 1
                                  : activeEventsList.length,
                              itemBuilder: ((context, index) {
                                return activeEventsList.length == 0
                                    ? emptyEvents()
                                    : Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4.0),
                                        child: EventCard(
                                            eventDataModel:
                                                activeEventsList[index]));
                              }),
                            )
                          : currentTab == 2
                              ? ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  itemCount: draftEventsList.length == 0
                                      ? 1
                                      : draftEventsList.length,
                                  itemBuilder: ((context, index) {
                                    return draftEventsList.length == 0
                                        ? emptyEvents()
                                        : Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 4.0),
                                            child: EventCard(
                                                eventDataModel:
                                                    draftEventsList[index]));
                                  }),
                                )
                              : currentTab == 3
                                  ? ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      padding: EdgeInsets.zero,
                                      itemCount: expiredEventsList.length == 0
                                          ? 1
                                          : expiredEventsList.length,
                                      itemBuilder: ((context, index) {
                                        return expiredEventsList.length == 0
                                            ? emptyEvents()
                                            : Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 4.0),
                                                child: EventCard(
                                                    eventDataModel:
                                                        expiredEventsList[
                                                            index]));
                                      }),
                                    )
                                  : const SizedBox(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  emptyEvents() {
    return Column(
      children: [
        Constants.spaceLargeColumn,
        Constants.spaceLargeColumn,
        CommonImageView(
            svgPath: "assets/images/img_ill.svg",
            height: getVerticalSize(246.00),
            width: getHorizontalSize(222.00)),
        Constants.spaceLargeColumn,
        Text("msg_there_is_no_eve".tr,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: AppStyle.poppinsTextstyle(
                16, FontWeight.w500, Constants.fromHex("#34405E"))),
      ],
    );
  }
}
