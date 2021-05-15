import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wee_app/data/workspace_model.dart';

class WorkspaceView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: AppDrawer(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).accentColor,
          child: Icon(
            Icons.add,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () async {
            final response = await Navigator.of(context).pushNamed('/add');
            if (response != null) {
              Provider.of<WorkspaceModal>(context, listen: false).add(response);
            }
          },
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              floating: true,
              backgroundColor: Theme.of(context).backgroundColor,
              elevation: 0,
              title: Text(
                'Workspace',
                style: TextStyle(
                    color: Theme.of(context).primaryColorLight, fontSize: 30),
              ),
              centerTitle: true,
            ),
            SliverAppBar(
              leading: Icon(Icons.check_box_outline_blank_rounded),
              backgroundColor: Theme.of(context).backgroundColor,
              pinned: true,
            ),
            WorkspaceList()
          ],
        ));
  }
}

class WorkspaceList extends StatelessWidget {
  const WorkspaceList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List keys = Provider.of<WorkspaceModal>(context).keys;
    return keys.isEmpty
        ? SliverFillRemaining(
            hasScrollBody: false,
            child: Opacity(
              opacity: 0.5,
              child: Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.all(70),
                child: Text(
                  'Press "+" to add your first entry',
                  style: TextStyle(
                      color: Theme.of(context).primaryColorLight, fontSize: 30),
                ),
              ),
            ),
          )
        : SliverList(
            delegate: SliverChildListDelegate(generateList(keys)),
          );
  }

  List<Widget> generateList(List keys) {
    List<Widget> out = [];

    keys.forEach((element) {
      out.add(DataTile(id: '$element'));
    });
    return out;
  }
}

class DataTile extends StatelessWidget {
  const DataTile({
    Key key,
    @required this.id,
  }) : super(key: key);

  final String id;
  @override
  Widget build(BuildContext context) {
    final Map values =
        Provider.of<WorkspaceModal>(context, listen: false).valueOf(id);
    return Dismissible(
      key: Key('$id'),
      confirmDismiss: (d) async {
        return await ScaffoldMessenger.of(context)
            .showSnackBar(
              SnackBar(
                duration: Duration(seconds: 2),
                content: Text('Press Undo to restore'),
                action: SnackBarAction(
                  label: 'Undo',
                  onPressed: () {},
                ),
              ),
            )
            .closed
            .then((reason) {
          if (reason == SnackBarClosedReason.action) {
            return false;
          }
          if (reason == SnackBarClosedReason.swipe) {
            return true;
          }
          return true;
        });
      },
      secondaryBackground: Container(
        alignment: Alignment.centerRight,
        color: Colors.red,
        child: Icon(
          Icons.delete_outlined,
          size: 30,
        ),
      ),
      background: Container(
        alignment: Alignment.centerLeft,
        color: Colors.blue,
        child: Icon(
          Icons.archive_outlined,
          size: 30,
        ),
      ),
      onDismissed: (direction) {
        direction == DismissDirection.endToStart
            ? print('Deleted')
            : print('Archived');
      },
      child: Container(
        color: Theme.of(context).backgroundColor,
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
        child: Card(
          color: Theme.of(context).primaryColor,
          child: ListTile(
            enableFeedback: true,
            onTap: () {},
            leading: Icon(
              Icons.check_box_outline_blank_rounded,
              color: Theme.of(context).primaryColorLight,
            ),
            title: Text(
              values['Scientific Name & Author'],
              style: TextStyle(
                  color: Theme.of(context).primaryColorLight,
                  fontStyle: FontStyle.italic),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).backgroundColor,
        child: Column(
          children: [
            DrawerHeader(
              child: Container(
                color: Theme.of(context).accentColor,
              ),
            ),
            LinkTile(
              icon: Icons.archive_rounded,
              name: 'Archive',
              route: '/archive',
            ),
            LinkTile(
              icon: Icons.assignment,
              name: 'Defaults',
              route: '/defaults',
            ),
            LinkTile(
              icon: Icons.info,
              name: 'About',
              route: '/about',
            ),
          ],
        ),
      ),
    );
  }
}

class LinkTile extends StatelessWidget {
  final IconData icon;
  final String route;
  final String name;
  LinkTile({
    Key key,
    @required this.icon,
    @required this.name,
    @required this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).primaryColor,
      child: ListTile(
        leading: Icon(
          icon,
          size: 30,
          color: Theme.of(context).primaryColorLight,
        ),
        onTap: () {
          Navigator.of(context).pushNamed(route);
        },
        enableFeedback: true,
        title: Text(
          name,
          style: TextStyle(
              color: Theme.of(context).primaryColorLight, fontSize: 20),
        ),
      ),
    );
  }
}
