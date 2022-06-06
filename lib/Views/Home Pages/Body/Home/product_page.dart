import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marketplace/Data/Pria/pria.dart';
import 'package:marketplace/Data/Wanita/wanita.dart';
import 'package:marketplace/Views/Home%20Pages/Body/Home/Description/des.dart';
import 'package:marketplace/Views/Home%20Pages/Body/Home/list.dart';
import 'package:marketplace/models/model.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ProductList extends StatefulWidget {
  const ProductList({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final uid = FirebaseAuth.instance.currentUser!.uid;

  bool gender = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => body(),
              childCount: 1,
            ),
          ),
        ],
      ),
    );
    // return Container(
    //   padding: const EdgeInsets.all(10),
    //   child: GridView.builder(
    //     itemCount: list.length,
    //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //       crossAxisCount: 2,
    //       mainAxisSpacing: 5,
    //       crossAxisSpacing: 5,
    //       childAspectRatio: 0.65,
    //     ),
    //     itemBuilder: (context, index) {
    //       return ProductCards(
    //         list: list[index],
    //         uid: uid,
    //       );
    //     },
    //   ),
    // );
  }

  body() {
    return SingleChildScrollView(
      // child: Padding(
      // padding: const EdgeInsets.only(top: 40, bottom: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 25),
            child: Text(
              "Pria",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 24,
              ),
            ),
          ),
          buildbody1(),
          const SizedBox(height: 40),
          const Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 25),
            child: Text(
              "Wanita",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 24,
              ),
            ),
          ),
          buildbody2(),
        ],
      ),
      // ),
    );
  }

  buildbody1() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 210,
        enlargeCenterPage: true,
        disableCenter: true,
        viewportFraction: .75,
      ),
      items: List.generate(
        list1.length,
        (index) => ProductCards(list: list1[index], uid: uid),
      ),
    );
  }

  buildbody2() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 210,
        enlargeCenterPage: true,
        disableCenter: true,
        viewportFraction: .75,
      ),
      items: List.generate(
        list2.length,
        (index) => ProductCards(list: list2[index], uid: uid),
      ),
    );
  }
}

class ProductCards extends StatelessWidget {
  const ProductCards({
    Key? key,
    required this.list,
    required this.uid,
  }) : super(key: key);
  final Model list;
  final String uid;

  @override
  Widget build(BuildContext context) {
    final image = list.image.toString();
    final laptop = list.laptop.toString();
    final harga = list.harga as int;
    final lokasi = list.lokasi.toString();

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => Descrip(
              image: image,
              laptop: laptop,
              harga: harga,
              lokasi: lokasi,
              uid: uid,
            ),
          ),
        );
      },
      child: CardPages(
        image: image,
        laptop: laptop,
        harga: harga,
        lokasi: lokasi,
        uid: uid,
      ),
    );
  }
}
