import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class MLoutput extends StatelessWidget {
  List<dynamic> cpus;
  List<dynamic> gpus;
  List<dynamic> motherboards;
  List<dynamic> storages;
  List<dynamic> rams;
  List<dynamic> coolers;
  List<dynamic> casepcs;
  List<dynamic> powersupplys;
  List<dynamic> price;
  String type;

  MLoutput(
      {required this.cpus,
      required this.gpus,
      required this.motherboards,
      required this.storages,
      required this.rams,
      required this.coolers,
      required this.casepcs,
      required this.powersupplys,
      required this.price,
      required this.type});
  @override
  Widget build(BuildContext context) {
    if (cpus.isNotEmpty) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              GFCard(
                boxFit: BoxFit.cover,
                image: Image.asset('assets/new_images/computer.png'),
                title: GFListTile(
                  avatar: GFAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage:
                        AssetImage('assets/new_images/computer.png'),
                  ),
                  title: Text('model 1'),
                  subTitle: Text('the PC Gen by ML Model'),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              GFCard(
                boxFit: BoxFit.cover,
                image: Image.asset('assets/new_images/chip.png'),
                title: GFListTile(
                  avatar: GFAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage('assets/new_images/chip.png'),
                  ),
                  title: Text('CPU :'),
                  subTitle: Text('${cpus[0]}'),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              GFCard(
                boxFit: BoxFit.cover,
                image: Image.asset('assets/new_images/vga-card.png'),
                title: GFListTile(
                  avatar: GFAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage:
                        AssetImage('assets/new_images/vga-card.png'),
                  ),
                  title: Text('GPU :'),
                  subTitle: Text('${gpus[0]}'),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              GFCard(
                boxFit: BoxFit.cover,
                image: Image.asset('assets/new_images/motherboard.png'),
                title: GFListTile(
                  avatar: GFAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage:
                        AssetImage('assets/new_images/motherboard.png'),
                  ),
                  title: Text('Motherboard :'),
                  subTitle: Text('${motherboards[0]}'),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              GFCard(
                boxFit: BoxFit.cover,
                image: Image.asset('assets/new_images/harddisk.png'),
                title: GFListTile(
                  avatar: GFAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage:
                        AssetImage('assets/new_images/harddisk.png'),
                  ),
                  title: Text('Storage : '),
                  subTitle: Text('${storages[0]}'),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              GFCard(
                boxFit: BoxFit.cover,
                image: Image.asset('assets/new_images/ram.png'),
                title: GFListTile(
                  avatar: GFAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage('assets/new_images/ram.png'),
                  ),
                  title: Text('Ram : '),
                  subTitle: Text('${rams[0]}'),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              GFCard(
                boxFit: BoxFit.cover,
                image: Image.asset('assets/new_images/cooler.png'),
                title: GFListTile(
                  avatar: GFAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage('assets/new_images/cooler.png'),
                  ),
                  title: Text('Coolers :'),
                  subTitle: Text('${coolers[0]}'),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              GFCard(
                boxFit: BoxFit.cover,
                image: Image.asset('assets/new_images/computer-tower.png'),
                title: GFListTile(
                  avatar: GFAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage:
                        AssetImage('assets/new_images/computer-tower.png'),
                  ),
                  title: Text('Case :'),
                  subTitle: Text('${casepcs[0]}'),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              GFCard(
                boxFit: BoxFit.cover,
                image: Image.asset('assets/new_images/powerSupply.png'),
                title: GFListTile(
                  avatar: GFAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage:
                        AssetImage('assets/new_images/powerSupply.png'),
                  ),
                  title: Text('powersupply :'),
                  subTitle: Text('${powersupplys[0]}'),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              GFCard(
                boxFit: BoxFit.cover,
                image: Image.asset('assets/new_images/dollar.jpg'),
                title: GFListTile(
                  avatar: GFAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage('assets/new_images/dollar.jpg'),
                  ),
                  title: Text('price :'),
                  subTitle: Text('${price[0]}'),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              GFCard(
                boxFit: BoxFit.cover,
                image: Image.asset('assets/new_images/1.png'),
                title: GFListTile(
                  avatar: GFAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage('assets/new_images/1.png'),
                  ),
                  title: Text('type :'),
                  subTitle: Text('${type}'),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }
}
