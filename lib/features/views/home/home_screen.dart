import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:opticash/core/widgets/app_text.dart';
import 'package:opticash/core/widgets/custom_appbar.dart';
import 'package:opticash/features/blocs/authentication/authentication_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const route = "home_screen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;

  PreferredSizeWidget get _appBar {
    final state = context.watch<AuthenticationBloc>().state;
    final model = (state as Authenticated).model;
    // double height = Platform.isAndroid ? 72 : 64;
    return CustomAppBar(
      elevation: 1,
      leadingItemWidth: 68,
      leadingItem: Container(
        width: 48,
        height: 48,
        margin: EdgeInsets.only(left: 20, top: 12, bottom: 12),
        decoration: BoxDecoration(shape: BoxShape.circle),
        child: Image.asset("assets/images/avatar.png"),
      ),
      titleWidget: Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                AppText(
                  "Hello, ${model.user?.firstName ?? ''}!",
                  size: 20,
                  weight: FontWeight.w700,
                  color: Color(0xFF0A0707),
                ),
              ],
            ),
            AppText(
              model.user?.userName ?? '',
              size: 12,
              color: Color(0xFF9E9E9E),
            )
          ],
        ),
      ),
      action: [
        ActionItem(asset: "assets/svg/history.svg"),
        ActionItem(asset: "assets/svg/bell.svg", count: 2),
        SizedBox(width: 15),
      ],
    );
  }

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/money_pattern.png"),
                fit: BoxFit.fitWidth,
              ),
            ),
            height: MediaQuery.sizeOf(context).height,
            child: PageView(
              controller: _pageController,
              children: [
                HomeTap(),
                Center(child: AppText("Card Tab Screen")),
                Center(child: AppText("Send Tab Screen")),
                Center(child: AppText("Swap Tab Screen")),
                Center(child: AppText("Account Tab Screen")),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Material(
              elevation: 4,
              shadowColor: Color(0xff000000).withOpacity(0.1),
              color: Colors.transparent,
              child: Stack(
                children: [
                  Container(
                    height: 80,
                    color: Color(0xFFFFFFFF),
                    margin: EdgeInsets.only(top: 28),
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        NavItem(
                          asset: "assets/svg/home.svg",
                          title: "Home",
                          onTap: () => _animateToPage(0),
                        ),
                        NavItem(
                          asset: "assets/svg/card_icon.svg",
                          title: "Card",
                          onTap: () => _animateToPage(1),
                        ),
                        Container(
                          width: 65,
                          height: 65,
                          constraints: BoxConstraints(minHeight: 65),
                          margin: EdgeInsets.only(bottom: 20),
                        ),
                        NavItem(
                          asset: "assets/svg/swap.svg",
                          title: "Swap",
                          onTap: () => _animateToPage(3),
                        ),
                        NavItem(
                          asset: "assets/svg/account.svg",
                          title: "Account",
                          onTap: () => _animateToPage(4),
                        ),
                      ],
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () => _animateToPage(2),
                        child: Column(
                          children: [
                            Container(
                              width: 65,
                              height: 65,
                              constraints: BoxConstraints(minHeight: 65),
                              margin: EdgeInsets.only(bottom: 3, right: 4),
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(color: Color(0xFF2C3E02), borderRadius: BorderRadius.circular(24)),
                              child: Center(child: Image.asset("assets/images/logo.png")),
                            ),
                            AppText(
                              "Send",
                              size: 10,
                              color: Color(0xFFA7A7A7),
                              family: "Poppins",
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _animateToPage(int i) {
    _pageController.animateToPage(
      i,
      duration: Duration(milliseconds: 100),
      curve: Curves.easeInOut,
    );
  }
}

class HomeTap extends StatefulWidget {
  const HomeTap({super.key});

  @override
  State<HomeTap> createState() => _HomeTapState();
}

class _HomeTapState extends State<HomeTap> {
  Widget get _balanceDropdown {
    return SizedBox(
      child: Center(
        child: FittedBox(
          child: Container(
            padding: EdgeInsets.only(top: 6, bottom: 4, left: 10, right: 10),
            decoration: BoxDecoration(
              color: Color(0xFF749000),
              borderRadius: BorderRadius.circular(17),
            ),
            child: Row(
              children: [
                Image.asset("assets/images/coin.png", width: 24, height: 21),
                Padding(
                  padding: EdgeInsets.only(left: 4, right: 8),
                  child: AppText(
                    "Opticash Balance",
                    color: Colors.white,
                    size: 14,
                    weight: FontWeight.w500,
                  ),
                ),
                Icon(
                  CupertinoIcons.chevron_down_circle_fill,
                  color: Colors.white,
                  size: 18,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get _balance {
    return Padding(
      padding: EdgeInsets.only(top: 20.0, bottom: 10),
      child: Column(
        children: [
          AppText(
            "\$243,998",
            size: 40,
            weight: FontWeight.w700,
            color: Colors.white,
          ),
          AppText(
            "123848492920304.234 (OPCH)",
            size: 10,
            color: Color(0xFFCDFF00),
            weight: FontWeight.w500,
          )
        ],
      ),
    );
  }

  Widget get _balanceVisibilityToggle {
    return SvgPicture.asset("assets/svg/hide.svg");
  }

  Widget get _divider {
    return Container(
      width: 1,
      height: 35,
      color: Color(0xFFEAEAEA),
      margin: EdgeInsets.symmetric(horizontal: 4),
    );
  }

  Widget get _cards {
    return Container(
      margin: EdgeInsets.only(left: 20, bottom: 34),
      width: MediaQuery.sizeOf(context).width,
      height: 112,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          CardItem(
            asset: "assets/images/card1.png",
            text: "Refer a friend and earn \$3 per referral",
          ),
          CardItem(
            asset: "assets/images/card2.png",
            text: "Create Virtual Card and pay online with ease",
          ),
        ],
      ),
    );
  }

  Widget get _quickActionsContainer {
    return Container(
      height: 240,
      decoration: BoxDecoration(
        color: Color(0xFFF4F4F4),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(4),
          bottomRight: Radius.circular(4),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 38, vertical: 10),
      child: Column(
        children: [
          Expanded(child: SizedBox()),
          Row(
            children: [
              QuickActionItem(
                label: "Send Money",
                asset: "assets/svg/send.svg",
              ),
              _divider,
              QuickActionItem(
                label: "Top-Up",
                asset: "assets/svg/fund_wallet.svg",
              ),
              _divider,
              VerticalDivider(),
              QuickActionItem(
                label: "Account Details",
                asset: "assets/svg/bank_account.svg",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget get _balanceContainer {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    return Container(
      height: 168,
      padding: EdgeInsets.only(top: 24, bottom: 12),
      constraints: BoxConstraints(minHeight: 168, maxHeight: 168, minWidth: width - 40),
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage("assets/images/bg_balance.png"),
        ),
      ),
      child: Column(
        children: [
          _balanceDropdown,
          _balance,
          _balanceVisibilityToggle,
        ],
      ),
    );
  }

  Widget get _transactionsTitle {
    return Padding(
      padding: EdgeInsets.only(left: 20.0, bottom: 16),
      child: AppText(
        "Today, 26 June 2023",
        weight: FontWeight.w600,
        color: Color(0xFF273240),
      ),
    );
  }

  Widget get _transactionsList {
    return ListView.builder(
      itemCount: 1,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 20),
      itemBuilder: (context, index) {
        return Container(
          height: 66,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          decoration: BoxDecoration(
            color: Color(0xFFF4F4F4),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Container(
                width: 28,
                height: 28,
                margin: EdgeInsets.only(right: 13),
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: Image.asset("assets/images/flag.png"),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      "Transfer To James",
                      size: 12,
                      weight: FontWeight.w600,
                      color: Color(0xFF273240),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Icon(Icons.circle, size: 8, color: Color(0xFFCA8215)),
                        Padding(
                          padding: EdgeInsets.only(left: 4),
                          child: AppText(
                            "Pending",
                            size: 12,
                            weight: FontWeight.w600,
                            color: Color(0xFFCA8215),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  AppText(
                    "- N18.90",
                    size: 12,
                    align: TextAlign.end,
                    family: "Poppins",
                    weight: FontWeight.w600,
                    color: Color(0xFFD82C0D),
                  ),
                  Spacer(),
                  AppText(
                    "10th July, 2023",
                    size: 10,
                    color: Color(0xFF9E9E9E),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Stack(
                children: [
                  _quickActionsContainer,
                  _balanceContainer,
                ],
              ),
            ),
            _cards,
            _transactionsTitle,
            _transactionsList,
          ],
        ),
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  const NavItem({
    super.key,
    required this.asset,
    required this.title,
    this.onTap,
  });

  final String asset;
  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AbsorbPointer(
        absorbing: true,
        child: Column(
          children: [
            SizedBox(height: 24, child: SvgPicture.asset(asset)),
            AppText(title, size: 10, color: Color(0xFFA7A7A7), family: "Poppins"),
          ],
        ),
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  const CardItem({super.key, required this.asset, required this.text});

  final String asset;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 261,
      height: 112,
      margin: EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        image: DecorationImage(
          image: AssetImage(asset),
        ),
      ),
      child: Row(
        children: [
          SizedBox(width: 120),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 4),
              child: AppText(
                text,
                size: 15,
                color: Colors.white,
                weight: FontWeight.w600,
                height: 1.5,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class QuickActionItem extends StatelessWidget {
  const QuickActionItem({
    super.key,
    required this.label,
    required this.asset,
  });

  final String label;
  final String asset;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 33,
            height: 33,
            padding: EdgeInsets.all(4),
            margin: EdgeInsets.only(bottom: 6),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF749000),
            ),
            child: Center(child: SvgPicture.asset(asset)),
          ),
          AppText(
            label,
            size: 10,
            weight: FontWeight.w500,
            color: Color(0xFF2C3504),
          ),
        ],
      ),
    );
  }
}

class ActionItem extends StatelessWidget {
  const ActionItem({super.key, required this.asset, this.count});

  final String asset;
  final int? count;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 12),
      child: Center(
        child: Stack(
          children: [
            Container(
              width: 42,
              height: 42,
              margin: EdgeInsets.only(top: 2, bottom: 12, right: 5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFF5F5F5),
              ),
              child: Center(
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: SvgPicture.asset(asset),
                ),
              ),
            ),
            Positioned(
              right: 10,
              child: Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(shape: BoxShape.circle, color: Color(0xFFFF4040)),
                child: FittedBox(
                  child: AppText(
                    "${count ?? ''}",
                    size: 10,
                    weight: FontWeight.w600,
                    family: "Poppins",
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
