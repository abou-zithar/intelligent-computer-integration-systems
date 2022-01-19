import 'package:flutter/material.dart';
import '../Screens/Software_info_screen.dart';
import 'package:provider/provider.dart';
import '../providers/software.dart';
import '../providers/software_provider.dart';
import '../providers/Models.dart';

class software_item extends StatelessWidget {
  void selectSoftware(BuildContext ctx) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return SoftwareInfoScreen();
    }));
  }

  @override
  Widget build(BuildContext context) {
    final softwareitem = Provider.of<Software>(context);

    final models = Provider.of<Models>(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          child: Image.network(
            softwareitem.imagePath,
            fit: BoxFit.cover,
          ),
          onTap: () => Navigator.of(context).pushNamed(
              SoftwareInfoScreen.routName,
              arguments: softwareitem.id),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.lightBlue,
          leading: IconButton(
              onPressed: () => softwareitem.togglefavoritestatus(),
              icon: Icon(softwareitem.isFavorite
                  ? Icons.favorite
                  : Icons.favorite_border),
              color: Colors.white),
          title: Text(
            softwareitem.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                models.addItem(
                    softwareitem.id,
                    softwareitem.price,
                    softwareitem.title,
                    softwareitem.rating,
                    softwareitem.imagePath,
                    softwareitem.color,
                    softwareitem.swhw,
                    softwareitem.discription,null,null,null);
                Scaffold.of(context).hideCurrentSnackBar();

                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(
                    "Added item to Model",
                  ),
                  action: SnackBarAction(
                    label: ' UNDO',
                    onPressed: () {
                      models.removeItem(softwareitem.id);
                    },
                  ),
                  duration: Duration(seconds: 2),
                ));
              }),
        ),
      ),
    );
  }
}
