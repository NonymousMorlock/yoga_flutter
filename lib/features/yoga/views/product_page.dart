import 'package:flutter/material.dart';

import '../components/session_widgets.dart';
import '../widgets/session_widget.dart';

class ProductPage extends StatefulWidget {
  static const id = "/product";
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    String selectedImg = arguments['image'];
    String selectTitle = arguments['title'];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: (){Navigator.pop(context);},
          icon: const Icon(Icons.arrow_back_ios,
          color: Colors.black,
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height*0.43,
            width: MediaQuery.of(context).size.width,
            color: const Color(0xffc7b8f5),
            child: Container(
              margin: const EdgeInsets.only(right: 40, top: 20, bottom: 20),
              alignment: Alignment.centerLeft,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('asset/path.png'),
                  fit: BoxFit.contain
                )
              ),
            ),
          ),
          Column(
            children: <Widget>[
              const SizedBox(height: 90,),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Text(selectTitle, style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w700
                          ),),
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.only(left: 20),
                              width: MediaQuery.of(context).size.width*0.7,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Text('3-10 Min Course', style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w600
                                  ),),
                                  const SizedBox(height: 10,),
                                  const Text('Live happier and healthier by learning the fundamentals of meditation and mindfulness', style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600
                                  ),),
                                  const SizedBox(height: 10,),
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.9,
                                    margin: const EdgeInsets.only(right: 20),
                                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(Radius.circular(40)),

                                    ),
                                    child: Row(
                                      children: const <Widget>[
                                        Icon(Icons.search, size: 30,),
                                        SizedBox(width: 20,),
                                        Expanded(
                                          child: TextField(
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Search',
                                              hintStyle: TextStyle(
                                                fontSize: 20,
                                              )
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(70),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('asset/$selectedImg.png'),
                                    fit: BoxFit.contain
                                  )
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 5,),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.all(10),
                          child: const Sessions(),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: Text(selectTitle, style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w700
                          ),),
                        ),
                        const SizedBox(height: 10,),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                            color: Colors.white,
                            boxShadow: [BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 15,
                              spreadRadius: 1
                            )]
                          ),
                          child: Row(
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.all(50),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('asset/$selectedImg.png')
                                  )
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const <Widget>[
                                    Text('Basics 2', style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                    ),),
                                    Text('Start and deepen your patience', style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),)
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: (){},
                                icon: const Icon(
                                  Icons.lock_outline,
                                  size: 30,
                                  color: Colors.black,
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 30,)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
