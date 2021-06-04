import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wee_app/data/archive_model.dart';
import 'package:wee_app/data/default_model.dart';
import 'package:wee_app/data/workspace_model.dart';

class WorkspaceView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map defaults = Provider.of<DefaultsModel>(context).data;
    return Scaffold(
        drawer: AppDrawer(),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterFloat,
        floatingActionButton: AnimatedOpacity(
          duration: Duration(milliseconds: 1000),
          opacity: defaults == null ? 0 : 1,
          child: TextButton.icon(
            label: Text(
              Provider.of<WorkspaceModel>(context, listen: false)
                      .alteastOneSelected
                  ? 'Generate'
                  : 'Add',
              style: TextStyle(fontSize: 17),
            ),
            icon: Icon(Provider.of<WorkspaceModel>(context, listen: false)
                    .alteastOneSelected
                ? Icons.insert_drive_file_rounded
                : Icons.add),
            style: ButtonStyle(
              foregroundColor:
                  MaterialStateProperty.all(Theme.of(context).primaryColor),
              backgroundColor:
                  MaterialStateProperty.all(Theme.of(context).accentColor),
              padding: MaterialStateProperty.all(
                  EdgeInsets.fromLTRB(10, 10, 20, 10)),
              elevation: MaterialStateProperty.all(10),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50))),
            ),
            onPressed: Provider.of<WorkspaceModel>(context, listen: false)
                    .alteastOneSelected
                ? () {
                    Navigator.of(context).pushNamed('/processing',
                        arguments:
                            Provider.of<WorkspaceModel>(context, listen: false)
                                .selectedValues);
                  }
                : () async {
                    final response = await Navigator.of(context)
                        .pushNamed('/add', arguments: Map.from(defaults));
                    if (response != null) {
                      Provider.of<WorkspaceModel>(context, listen: false)
                          .add(response);
                    }
                  },
          ),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              floating: true,
              backgroundColor: Theme.of(context).backgroundColor,
              elevation: 100,
              title: Text(
                'Workspace',
                style: TextStyle(
                    color: Theme.of(context).primaryColorLight, fontSize: 30),
              ),
              centerTitle: true,
            ),
            SliverAppBar(
              leading: IconButton(
                icon: Icon(Provider.of<WorkspaceModel>(context).allSelected
                    ? Icons.check_box
                    : Icons.check_box_outline_blank),
                onPressed: () =>
                    Provider.of<WorkspaceModel>(context, listen: false)
                        .selectAllToggle(),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: AnimatedCrossFade(
                    duration: Duration(milliseconds: 300),
                    crossFadeState:
                        Provider.of<WorkspaceModel>(context, listen: false)
                                .alteastOneSelected
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                    firstChild: Container(),
                    secondChild: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.delete_outline),
                          color: Colors.red,
                          onPressed: () async {
                            await showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          title: Text('Confirm Delete'),
                                          backgroundColor:
                                              Theme.of(context).backgroundColor,
                                          titleTextStyle: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColorLight,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                          contentTextStyle: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColorLight,
                                              fontSize: 16),
                                          content: Text(
                                              'Do you really want to delete ${Provider.of<WorkspaceModel>(context, listen: false).selected.length} Items(s) ?'),
                                          actions: [
                                            TextButton(
                                                onPressed: () => Navigator.pop(
                                                    context, false),
                                                style: ButtonStyle(
                                                    foregroundColor:
                                                        MaterialStateProperty
                                                            .all(Theme.of(
                                                                    context)
                                                                .accentColor),
                                                    overlayColor:
                                                        MaterialStateProperty
                                                            .all(Theme.of(
                                                                    context)
                                                                .accentColor
                                                                .withOpacity(
                                                                    0.5))),
                                                child: Text('Cancel')),
                                            TextButton(
                                                onPressed: () => Navigator.pop(
                                                    context, true),
                                                style: ButtonStyle(
                                                    foregroundColor:
                                                        MaterialStateProperty
                                                            .all(Theme.of(
                                                                    context)
                                                                .accentColor),
                                                    overlayColor:
                                                        MaterialStateProperty
                                                            .all(Theme.of(
                                                                    context)
                                                                .accentColor
                                                                .withOpacity(
                                                                    0.5))),
                                                child: Text('Confirm')),
                                          ],
                                        ))
                                ? Provider.of<WorkspaceModel>(context,
                                        listen: false)
                                    .deleteSelected()
                                : print('Cancelled');
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.archive_outlined),
                          color: Colors.blue,
                          onPressed: () {
                            List.from(Provider.of<WorkspaceModel>(context,
                                        listen: false)
                                    .selected)
                                .forEach((id) {
                              Provider.of<ArchiveModel>(context, listen: false)
                                  .add(Provider.of<WorkspaceModel>(context,
                                          listen: false)
                                      .valueOf(id, d: true));
                            });
                          },
                        )
                      ],
                    ),
                  ),
                )
              ],
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
    List keys = Provider.of<WorkspaceModel>(context).keys;
    bool archiveReady = Provider.of<ArchiveModel>(context).isReady;
    return keys.isEmpty || !archiveReady
        ? SliverFillRemaining(
            hasScrollBody: false,
            child: Opacity(
              opacity: 0.5,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(40, 0, 40, 100),
                  child: Text(
                    'Press "+ Add" to add your first entry',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Theme.of(context).primaryColorLight,
                        fontSize: 25),
                  ),
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
        Provider.of<WorkspaceModel>(context, listen: false).valueOf(id);
    final bool selected = Provider.of<WorkspaceModel>(context, listen: false)
        .selected
        .contains(id);
    return Dismissible(
      key: Key('$id'),
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
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          return await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text('Confirm Delete'),
                    backgroundColor: Theme.of(context).backgroundColor,
                    titleTextStyle: TextStyle(
                        color: Theme.of(context).primaryColorLight,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                    contentTextStyle: TextStyle(
                        color: Theme.of(context).primaryColorLight,
                        fontSize: 16),
                    content: Text(
                        'Do you really want to delete "${values['Scientific Name & Author']}" ?'),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all(
                                  Theme.of(context).accentColor),
                              overlayColor: MaterialStateProperty.all(
                                  Theme.of(context)
                                      .accentColor
                                      .withOpacity(0.5))),
                          child: Text('Cancel')),
                      TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all(
                                  Theme.of(context).accentColor),
                              overlayColor: MaterialStateProperty.all(
                                  Theme.of(context)
                                      .accentColor
                                      .withOpacity(0.5))),
                          child: Text('Confirm')),
                    ],
                  ));
        } else {
          return true;
        }
      },
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          Provider.of<WorkspaceModel>(context, listen: false)
              .delete(id, images: true);
        } else {
          Provider.of<ArchiveModel>(context, listen: false).add(
              Provider.of<WorkspaceModel>(context, listen: false)
                  .valueOf(id, d: true));
        }
      },
      child: Container(
        color: Theme.of(context).backgroundColor,
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
        child: Card(
          color: Theme.of(context).primaryColor,
          child: ListTile(
            onTap: () async {
              var response = await Navigator.of(context)
                  .pushNamed('/edit', arguments: Map.from(values));
              if (response != null) {
                Provider.of<WorkspaceModel>(context, listen: false)
                    .update(id, response);
              }
            },
            leading: IconButton(
                onPressed: () {
                  selected
                      ? Provider.of<WorkspaceModel>(context, listen: false)
                          .deselect(id)
                      : Provider.of<WorkspaceModel>(context, listen: false)
                          .select(id);
                },
                icon: Icon(
                  selected
                      ? Icons.check_box
                      : Icons.check_box_outline_blank_rounded,
                  color: Theme.of(context).primaryColorLight,
                )),
            title: Text(
              values['Scientific Name'],
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              DrawerHeader(
                child: Image.asset('assets/logo.png'),
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
                icon: Icons.notes,
                name: 'Notes',
                route: '/notes',
              ),
              LinkTile(
                icon: Icons.help,
                name: 'FAQ',
                route: '/faq',
              ),
              LinkTile(
                icon: Icons.format_list_numbered_sharp,
                name: 'Procedure',
                route: '/procedure',
              ),
              LinkTile(
                icon: Icons.grading_rounded,
                name: 'Herbarium',
                route: '/herbarium',
              ),
              LinkTile(
                icon: Icons.info,
                name: 'About',
                route: '/about',
              ),
            ],
          ),
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
          Navigator.of(context).pop();
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
