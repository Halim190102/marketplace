import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marketplace/Component/Theme/theme.dart';
import 'package:marketplace/Provider/buy.dart';
import 'package:marketplace/Provider/profil.dart';
import 'package:marketplace/Provider/shopping_cart.dart';
import 'package:marketplace/Views/Home%20Pages/Body/About/about.dart';
import 'package:marketplace/Views/Home%20Pages/Body/Home/product_page.dart';
import 'package:marketplace/Views/Home%20Pages/Body/Keranjang/card_page.dart';
import 'package:marketplace/Views/Home%20Pages/Body/Riwayat/riwayat.dart';
import 'package:provider/provider.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  late PageController _pageController;
  int selectedIndex = 0;

  bool isInit1 = true;

  final uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final data1 = Provider.of<ShoppingCart>(context).allDataShopping;
    final data2 = Provider.of<BuyCart>(context).allDataBuy;
    final data3 = Provider.of<DataProfil>(context).dataProfil;

    if (data1.isEmpty && data2.isEmpty && data3.isEmpty) {
      if (isInit1) {
        Provider.of<ShoppingCart>(context).initialData1(uid);
        Provider.of<BuyCart>(context).initialData2(uid);
        Provider.of<DataProfil>(context).initialProfil(uid);
      }
      isInit1 = false;
    }
  }

  ///
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: selectedIndex);
  }

  void onButtonPressed(int index) {
    setState(() {
      selectedIndex = index;
    });
    _pageController.animateToPage(selectedIndex,
        duration: const Duration(milliseconds: 400), curve: Curves.easeOutQuad);
  }

  final List<dynamic> _title = <dynamic>[
    const SearchingBar(),
    const Text('Riwayat'),
    const Text('Pengaturan'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: _title.elementAt(selectedIndex),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const CardPageList(),
                ),
              );
            },
            icon: const Icon(Icons.shopping_cart_rounded),
          ),
          // IconButton(
          //   onPressed: () {
          //     showModalBottomSheet(
          //       shape: const RoundedRectangleBorder(
          //         borderRadius: BorderRadius.vertical(
          //           top: Radius.circular(20),
          //         ),
          //       ),
          //       context: context,
          //       builder: (context) => const BottomSheets(),
          //     );
          //   },
          //   icon: const Icon(
          //     Icons.account_circle,
          //     size: 30,
          //   ),
          // ),
        ],
      ),
      backgroundColor: ThemesColor().primaryBody,
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: _listOfWidget,
      ),

      /// Bottom Navigation Bar
      bottomNavigationBar: SlidingClippedNavBar(
        backgroundColor: Colors.white,
        onButtonPressed: onButtonPressed,
        iconSize: 30,
        activeColor: const Color(0xFF01579B),
        selectedIndex: selectedIndex,
        barItems: <BarItem>[
          BarItem(
            icon: Icons.home,
            title: 'Home',
          ),
          BarItem(
            icon: Icons.history,
            title: 'Riwayat',
          ),
          BarItem(
            icon: Icons.tune_rounded,
            title: 'Settings',
          ),
        ],
      ),
    );
  }
}

TextStyle fontstyle = GoogleFonts.oxygen(
    fontSize: 20, fontWeight: FontWeight.w400, color: Colors.white);
double iconSize = 200;

/// LIST OF SCREENS
List<Widget> _listOfWidget = <Widget>[
  /// EVENT
  const ProductList(),

  /// SERACH
  const Riwayat(),

  /// SETTINGS
  const Abouts(),
];

class SearchingBar extends StatefulWidget {
  const SearchingBar({Key? key}) : super(key: key);

  @override
  State<SearchingBar> createState() => _SearchingBarState();
}

class _SearchingBarState extends State<SearchingBar> {
  final _clear = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: TextField(
          controller: _clear,
          decoration: InputDecoration(
            prefixIcon: const Icon(
              Icons.search,
              size: 17,
            ),
            suffixIcon: IconButton(
              icon: const Icon(
                Icons.clear,
                size: 17,
              ),
              onPressed: () {
                _clear.clear();
              },
            ),
            hintText: 'Search...',
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
