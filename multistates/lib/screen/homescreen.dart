import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multistates/bloc/switch_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Notification'),
                BlocBuilder<SwitchBloc, SwitchState>(
                  buildWhen: (previous, current) =>
                      previous.isSwitch != current.isSwitch,
                  builder: (context, state) {
                    // print(state);
                    // print(context);
                    // print('notification');
                    return Switch(
                        value: state.isSwitch,
                        onChanged: (newValue) {
                          context
                              .read<SwitchBloc>()
                              .add(EnableOrDisableNotification());
                        });
                  },
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            BlocBuilder<SwitchBloc, SwitchState>(
              buildWhen: (previous, current) =>
                  previous.slider != current.slider,
              builder: (context, state) {
                // print('contianer');
                return Container(
                  height: 200,
                  color: Colors.red.withOpacity(state.slider),
                );
              },
            ),
            const SizedBox(
              height: 50,
            ),
            BlocBuilder<SwitchBloc, SwitchState>(
              builder: (context, state) {
                // print('i am slider');
                return Slider(
                    value: state.slider,
                    onChanged: (value) {
                      context
                          .read<SwitchBloc>()
                          .add(SliderEvent(slider: value));
                    });
              },
            )
          ],
        ),
      ),
    );
  }
}
