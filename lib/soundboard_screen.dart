import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'soundboard_bloc.dart';

class SoundboardScreen extends StatelessWidget {
  const SoundboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SoundboardBloc>();

    return Scaffold(
      appBar: AppBar(title: const Text('Soundboard')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: [
            _SoundButton(label: 'Krilin', soundName: 'krilin', bloc: bloc, color: Colors.pink[100]),
            _SoundButton(label: 'Pepetapia', soundName: 'pepetapia', bloc: bloc, color: Colors.brown[200]),
            _SoundButton(label: 'Helao', soundName: 'helao', bloc: bloc, color: Colors.blue[200]),
          ],
        ),
      ),
    );
  }
}

class _SoundButton extends StatelessWidget {
  final String label;
  final String soundName;
  final SoundboardBloc bloc;
  final Color? color;

  const _SoundButton({
    required this.label,
    required this.soundName,
    required this.bloc,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        bloc.add(PlaySoundEvent(soundName));
      },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(100, 100),
        textStyle: const TextStyle(fontSize: 20),
        backgroundColor: color,
      ),
      child: Text(label),
    );
  }
}
