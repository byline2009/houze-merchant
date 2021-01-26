import 'package:badges/badges.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:house_merchant/constant/theme_constant.dart';
import 'package:house_merchant/middle/bloc/overlay/index.dart';
import 'package:house_merchant/screen/main/menu_screen.dart';
import 'package:house_merchant/screen/main/more_screen.dart';
import 'package:house_merchant/screen/main/order_screen.dart';
import 'package:house_merchant/screen/main/promotion_screen.dart';
import 'package:house_merchant/screen/main/store_screen.dart';
import 'package:house_merchant/utils/localizations_util.dart';
import 'package:house_merchant/utils/progresshub.dart';
import 'package:house_merchant/utils/storage.dart';

class NaviagationBottom {
  final Widget screen;
  final BottomNavigationBarItem barItem;
  const NaviagationBottom(this.screen, this.barItem);
}

class MainScreen extends StatefulWidget {
  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  static PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );
  List<NaviagationBottom> navigationButtons = List();
  List<Widget> listPage = List<Widget>();
  int _currentIndex = 0;

  //Bloc
  final overlayBloc = OverlayBloc();

  Widget bottomNavItem(SvgPicture _image, {String badge = " "}) {
    return Container(
        width: 50,
        height: 25,
        child: Stack(
          children: <Widget>[
            Align(alignment: Alignment.bottomCenter, child: _image),
            badge == ""
                ? Center()
                : Positioned(
                    child: Badge(
                        animationDuration: Duration(milliseconds: 0),
                        animationType: BadgeAnimationType.fade,
                        badgeContent: Text(
                          badge,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        )),
                    right: 0,
                    top: -2)
          ],
        ));
  }

  @override
  void initState() {
    super.initState();
    debugPrint("MainScreen initState");
  }

  List<NaviagationBottom> listNaviagation() {
    return [
      NaviagationBottom(
          OrderScreen(),
          BottomNavigationBarItem(
            activeIcon: bottomNavItem(
                SvgPicture.asset('assets/images/ic-order-highlight.svg'),
                badge: ""),
            icon: bottomNavItem(
                SvgPicture.asset('assets/images/ic-order-default.svg'),
                badge: ""),
            label: LocalizationsUtil.of(context).translate('Đơn hàng'),
          )),
      NaviagationBottom(
          MenuScreen(),
          BottomNavigationBarItem(
            activeIcon: bottomNavItem(
                SvgPicture.asset("assets/images/ic-menu-highlight.svg"),
                badge: ""),
            icon: bottomNavItem(
                SvgPicture.asset('assets/images/ic-menu-default.svg'),
                badge: ""),
            label: LocalizationsUtil.of(context).translate('Menu'),
          )),
      NaviagationBottom(
          CouponScreen(),
          BottomNavigationBarItem(
            activeIcon: bottomNavItem(
                SvgPicture.asset("assets/images/ic-promotion-highlight.svg"),
                badge: ""),
            icon: bottomNavItem(
                SvgPicture.asset('assets/images/ic-promotion-default.svg'),
                badge: ""),
            label: LocalizationsUtil.of(context).translate('Ưu đãi'),
          )),
      NaviagationBottom(
          StoreScreen(),
          BottomNavigationBarItem(
            activeIcon: bottomNavItem(
                SvgPicture.asset("assets/images/ic-store-highlight.svg"),
                badge: ""),
            icon: bottomNavItem(
                SvgPicture.asset('assets/images/ic-store-default.svg'),
                badge: ""),
            label: LocalizationsUtil.of(context).translate('Cửa hàng'),
          )),
      NaviagationBottom(
          MoreScreen(),
          BottomNavigationBarItem(
            activeIcon: bottomNavItem(
                SvgPicture.asset("assets/images/ic-more-highlight.svg"),
                badge: ""),
            icon: bottomNavItem(
                SvgPicture.asset('assets/images/ic-more-default.svg'),
                badge: ""),
            label: LocalizationsUtil.of(context).translate('Thêm'),
          )),
    ];
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('*main_screen build');

    navigationButtons = listNaviagation();

    return MultiBlocProvider(
      providers: [
        BlocProvider<OverlayBloc>(
          create: (BuildContext context) => overlayBloc,
        ),
      ],
      child: WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Scaffold(
              key: Storage.scaffoldKey,
              body: OfflineBuilder(
                  connectivityBuilder: (
                    BuildContext context,
                    ConnectivityResult connectivity,
                    Widget child,
                  ) {
                    return Stack(children: <Widget>[
                      MultiBlocListener(
                          listeners: [
                            BlocListener<OverlayBloc, OverlayBlocState>(
                              bloc: overlayBloc,
                              listener: (context, overlayState) {},
                            )
                          ],
                          child: BlocBuilder<OverlayBloc, OverlayBlocState>(
                              bloc: overlayBloc,
                              builder: (BuildContext context,
                                  OverlayBlocState overlayState) {
                                if (overlayState is ShopInitial) {
                                  overlayBloc.add(ShopPicked());
                                }

                                listPage = List<Widget>();

                                listPage.add(PageView(
                                  controller: pageController,
                                  physics: NeverScrollableScrollPhysics(),
                                  onPageChanged: (index) {
                                    setState(() {
                                      _currentIndex = index;
                                    });
                                  },
                                  children: this.navigationButtons.map((f) {
                                    return f.screen;
                                  }).toList(),
                                ));

                                final bool connected =
                                    connectivity != ConnectivityResult.none;

                                listPage.add(SafeArea(
                                  child: Stack(
                                    children: <Widget>[
                                      Positioned(
                                          left: 0.0,
                                          right: 0.0,
                                          bottom: 0,
                                          child: Container(
                                            color: connected
                                                ? Colors.green
                                                : Color(0xFFEE4400),
                                            padding: EdgeInsets.all(10),
                                            child: Center(
                                              child: Text(
                                                  "${connected ? 'Đã kết nối mạng' : 'Không có kết nối mạng'}",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.white)),
                                            ),
                                          )),
                                    ],
                                  ),
                                ));

                                if (connected) {
                                  listPage.removeAt(1);
                                }

                                return Scaffold(
                                    backgroundColor: Colors.white,
                                    body: Stack(
                                      children: listPage,
                                    ),
                                    bottomNavigationBar: BottomNavigationBar(
                                        currentIndex: _currentIndex,
                                        onTap: (int index) {
                                          setState(() {
                                            HapticFeedback.heavyImpact();
                                            pageController.jumpToPage(index);
                                          });
                                        },
                                        selectedItemColor:
                                            ThemeConstant.primary_color,
                                        type: BottomNavigationBarType.fixed,
                                        items: this.navigationButtons.map((f) {
                                          return f.barItem;
                                        }).toList()));
                              })),
                      Progress.instance,
                    ]);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'There are no bottons to push :)',
                      ),
                      Text(
                        'Just turn off your internet.',
                      ),
                    ],
                  )))),
    );
  }

  @override
  void dispose() {
    print("MainScreen dispose!");
    super.dispose();
  }
}
