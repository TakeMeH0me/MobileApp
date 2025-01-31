import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:take_me_home/domain/entities/home_entity.dart';
import 'package:take_me_home/presentation/bloc/home/home_bloc.dart';
import 'package:take_me_home/presentation/router/app_router.dart';
import 'package:take_me_home/presentation/router/args/create_or_edit_home_args.dart';
import 'package:take_me_home/presentation/router/args/show_way_to_home_args.dart';
import 'package:take_me_home/presentation/widgets/widgets.dart';

/// Shows all available homes.
///
/// When clicking on one of the homes, it shows the route to the home.
class ShowHomesPage extends StatefulWidget {
  const ShowHomesPage({super.key});

  @override
  State<ShowHomesPage> createState() => _ShowHomesPageState();
}

class _ShowHomesPageState extends State<ShowHomesPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scrollbar(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Center(
            child: _buildHomeWidgets(context),
          ),
        ),
      ),
    );
  }

  StreamBuilder<List<HomeEntity>> _buildHomeWidgets(BuildContext context) {
    return StreamBuilder<List<HomeEntity>>(
      stream: BlocProvider.of<HomeBloc>(context).homeListStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.isEmpty) {
            return const Text('No homes created yet. Create one!');
          }

          return Column(
            children: _buildHomesList(snapshot.data!),
          );
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  List<Widget> _buildHomesList(List<HomeEntity> homes) {
    return homes.map(
      (home) {
        return Column(
          children: [
            Dismissible(
              key: Key(home.id),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                _sendDeleteHome(home);
              },
              background: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20.0),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.90,
                height: 75.0,
                child: HomeButton(
                  home: home,
                  onPressed: () {
                    _navigateToShowWayToHomePage(context, home);
                  },
                  onTrailingPressed: () {
                    _navigateToCreateOrEditHomePage(context, home);
                  },
                ),
              ),
            ),
            const SizedBox(height: 10.0),
          ],
        );
      },
    ).toList();
  }

  void _navigateToCreateOrEditHomePage(
    BuildContext context,
    HomeEntity home,
  ) async {
    Navigator.of(context).pushNamed(
      AppRouter.createOrEditHome,
      arguments: CreateOrEditHomeArgs(
        home: home,
        isNewHome: false,
      ),
    );
  }

  void _navigateToShowWayToHomePage(BuildContext context, HomeEntity home) {
    Navigator.of(context).pushNamed(
      AppRouter.showWayToHome,
      arguments: ShowWayToHomeArgs(home: home),
    );
  }

  void _sendDeleteHome(HomeEntity home) {
    BlocProvider.of<HomeBloc>(context).add(
      DeleteHomeEvent(home: home),
    );
  }
}
