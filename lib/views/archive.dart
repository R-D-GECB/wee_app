import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wee_app/data/archive_model.dart';
import 'package:wee_app/data/workspace_model.dart';

class ArchiveView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              backgroundColor: Theme.of(context).backgroundColor,
              elevation: 0,
              title: Text(
                'Archive',
                style: TextStyle(
                    color: Theme.of(context).primaryColorLight, fontSize: 30),
              ),
              centerTitle: true,
            ),
            SliverAppBar(
              leading: IconButton(
                icon: Icon(Provider.of<ArchiveModel>(context).allSelected
                    ? Icons.check_box
                    : Icons.check_box_outline_blank),
                onPressed: () =>
                    Provider.of<ArchiveModel>(context, listen: false)
                        .selectAllToggle(),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: AnimatedCrossFade(
                    duration: Duration(milliseconds: 300),
                    crossFadeState:
                        Provider.of<ArchiveModel>(context, listen: false)
                                .alteastOneSelected
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                    firstChild: Container(),
                    secondChild: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.delete_outline),
                          color: Colors.red,
                          onPressed: () {
                            Provider.of<ArchiveModel>(context, listen: false)
                                .deleteSelected();
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.unarchive_outlined),
                          color: Colors.yellow,
                          onPressed: () {
                            List.from(Provider.of<ArchiveModel>(context,
                                        listen: false)
                                    .selected)
                                .forEach((id) {
                              Provider.of<WorkspaceModel>(context,
                                      listen: false)
                                  .add(Provider.of<ArchiveModel>(context,
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
            ArchiveList()
          ],
        ));
  }
}

class ArchiveList extends StatelessWidget {
  const ArchiveList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List keys = Provider.of<ArchiveModel>(context).keys;
    return keys.isEmpty
        ? SliverFillRemaining(
            hasScrollBody: false,
            child: Opacity(
              opacity: 0.5,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(40, 0, 40, 100),
                  child: Text(
                    'No items in the archive',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Theme.of(context).primaryColorLight,
                        fontSize: 25),
                  ),
                ),
              ),
            ),
          )
        : SliverFillRemaining(
            child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
                showCheckboxColumn: false,
                columnSpacing: 20,
                headingRowColor:
                    MaterialStateProperty.all(Theme.of(context).primaryColor),
                dataTextStyle: TextStyle(
                  color: Theme.of(context).primaryColorLight,
                ),
                headingTextStyle: TextStyle(
                    color: Theme.of(context).primaryColorLight,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
                columns: [
                  DataColumn(label: Text(''), numeric: true),
                  DataColumn(
                      label: Text('Scientific Name & Author'),
                      onSort: (i, j) {
                        print('$i $j');
                      }),
                  DataColumn(label: Text('Family')),
                  DataColumn(label: Text('Collected By')),
                  DataColumn(label: Text('Date')),
                ],
                rows: generateList(keys, context)),
          ));
  }

  List<DataRow> generateList(List keys, BuildContext context) {
    List<DataRow> out = [];

    keys.forEach((id) {
      final Map values =
          Provider.of<ArchiveModel>(context, listen: false).valueOf("$id");
      final bool selected = Provider.of<ArchiveModel>(context, listen: false)
          .selected
          .contains("$id");
      out.add(DataRow(
          selected: selected,
          color: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return Theme.of(context).accentColor.withOpacity(0.3);
            }
            return null;
          }),
          onSelectChanged: (s) {
            selected
                ? Provider.of<ArchiveModel>(context, listen: false)
                    .deselect("$id")
                : Provider.of<ArchiveModel>(context, listen: false)
                    .select("$id");
          },
          cells: [
            DataCell(Icon(
              selected
                  ? Icons.check_box
                  : Icons.check_box_outline_blank_rounded,
              color: Theme.of(context).primaryColorLight,
            )),
            DataCell(Text(values['Scientific Name & Author'])),
            DataCell(Text(values['Family'])),
            DataCell(Text(values['Collected By'])),
            DataCell(Text(values['Date'])),
          ]));
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
  Widget build(BuildContext context) {}
}
