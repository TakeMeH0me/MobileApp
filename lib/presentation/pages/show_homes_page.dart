import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:take_me_home/domain/entities/home_entity.dart';
import 'package:take_me_home/presentation/bloc/home/home_bloc.dart';
import 'package:take_me_home/presentation/router/app_router.dart';
import 'package:take_me_home/presentation/router/args/create_or_edit_home_args.dart';
import 'package:take_me_home/presentation/router/args/show_way_to_home_args.dart';
import 'package:take_me_home/presentation/widgets/current_location_card.dart';
import 'package:take_me_home/presentation/widgets/home_button_widget.dart';

/// Shows all created homes.
class ShowHomesPage extends StatefulWidget {
  const ShowHomesPage({super.key});

  @override
  State<ShowHomesPage> createState() => _ShowHomesPageState();
}

class _ShowHomesPageState extends State<ShowHomesPage> {
  @override
  void initState() {
    super.initState();
    _sendGetAllHomes();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _sendGetAllHomes();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Scrollbar(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Center(child: _buildHomeWidgets(context)),
          ),
        ),
      ),
    );
  }

  BlocBuilder<HomeBloc, HomeState> _buildHomeWidgets(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) =>
          current is HomeEmpty ||
          current is GetAllHomesFetching ||
          current is GetAllHomesSuccess ||
          current is GetAllHomesError,
      builder: (context, state) {
        if (state is GetAllHomesFetching) {
          return const CircularProgressIndicator();
        } else if (state is GetAllHomesSuccess) {
          return Column(children: _buildHomesList(state.homes));
        } else if (state is GetAllHomesError) {
          return Text(state.message);
        } else {
          return const Text('No homes found. Create one!');
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
                  homeName: home.name,
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
      DeleteHomeEvent(id: home.id),
    );

    _sendGetAllHomes();
  }

  void _sendGetAllHomes() {
    BlocProvider.of<HomeBloc>(context).add(
      GetAllHomesEvent(),
    );
  }
}

TimeOfDay onResultRecieved(dynamic result) {
  TimeOfDay time = TimeOfDay(hour: result.hour, minute: result.minute);

  return time;
}
