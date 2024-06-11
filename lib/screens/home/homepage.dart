import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:trip_plannerx/screens/home/add_trip.dart';
import 'package:trip_plannerx/screens/home/categories_screens/categories_page1.dart';
import 'package:trip_plannerx/screens/home/categories_screens/categories_page2.dart';
import 'package:trip_plannerx/screens/home/categories_screens/categories_page3.dart';
import 'package:trip_plannerx/screens/home/categories_screens/categories_page4.dart';
import 'package:trip_plannerx/screens/home/categories_screens/categoies_page5.dart';
import 'package:trip_plannerx/screens/home/categories_screens/catergories_page0.dart';
import 'package:trip_plannerx/screens/home/dream_destination.dart';

class HomeScreen extends StatefulWidget {
  final List<String> titles;
  final List<String> imageUrls;
  final List<String> descriptions;

  const HomeScreen({
    super.key,
    required this.titles,
    required this.imageUrls,
    required this.descriptions,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> images = [
    "https://as1.ftcdn.net/v2/jpg/01/40/51/56/1000_F_140515612_0MMpqpsIvs6xno5YXmPVy9FUmZ4uLnFB.jpg",
    "https://as2.ftcdn.net/v2/jpg/03/04/01/79/1000_F_304017914_06ibltT3eX4UID80q0dSUybLsrfzUubL.jpg",
    "https://th-thumbnailer.cdn-si-edu.com/0Tog4P1WeTD51sLUT4zUW4z-A-o=/1000x750/filters:no_upscale()/https://tf-cmsv2-smithsonianmag-media.s3.amazonaws.com/filer/morning-on-the-Ganges-River-Varanasi-631.jpg"
  ];

  final List<String> names = ['Goa', 'Manali', 'Varanasi'];

  final List<String> pics = [
    "https://cff2.earth.com/uploads/2023/06/02100547/Mountain-2-960x640.jpg",
    "https://www.fao.org/images/newsroomlibraries/breafing-notes/36949400340_030e4ae5f9_oab4ccd35-fd6a-4230-bd2e-f0113f50357d.jpg?sfvrsn=426ca1c_3",
    "https://www.sotc.in/blog/wp-content/uploads/2023/09/Beautiful-Beaches-in-Maldives.jpg",
    "https://outforia.com/wp-content/uploads/2022/02/Waterfalls-in-PA-1-02182022.webp",
    "https://www.letsroam.com/explorer/wp-content/uploads/sites/10/2022/06/best-beaches-in-the-world.jpg",
    "https://st.adda247.com/https://adda247jobs-wp-assets-prod.adda247.com/jobs/wp-content/uploads/sites/2/2022/12/31112725/01-8-1.png"
  ];

  final List<String> texts = [
    'Mountains',
    'Wild',
    'Islands',
    'Waterfalls',
    'Beaches',
    'Monuments'
  ];

  List<Widget> nav = [
    const Pagezero(),
    const PageOne(),
    const PageTwo(),
    const PageThree(),
    const PageFour(),
    const PageFive()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trip PlannerX'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              width: 40,
              height: 30,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const DreamDestination()));
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(4),
                  backgroundColor: Colors.white,
                ),
                child: const Icon(
                  Icons.add_location_outlined,
                  color: Colors.black,
                ),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Trending Now',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 20),
                CarouselSlider(
                  items: images.asMap().entries.map(
                    (entry) {
                      final int index = entry.key;
                      final String image = entry.value;
                      final String name = names[index];
                      return Builder(builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 218, 216, 207),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: FadeInImage.assetNetwork(
                                    placeholder: 'assets/image/pngtree-gray-network-placeholder-png-image_3416659.jpg',
                                    image: image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  bottom: 10,
                                  left: 10,
                                  child: Text(
                                    name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                    },
                  ).toList(),
                  options: CarouselOptions(
                    height: 120,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration: const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Popular Categories',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 6,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (ctx) => nav[index]),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        height: 120,
                        width: 80,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 218, 216, 207),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: FadeInImage.assetNetwork(
                                  placeholder: 'assets/image/pngtree-gray-network-placeholder-png-image_3416659.jpg',
                                  image: pics[index],
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                bottom: 10,
                                left: 10,
                                child: Text(
                                  texts[index],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddTrip()));
        },
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        child: const Icon(Icons.add),
      ),
    );
  }
}
