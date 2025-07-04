import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

abstract class SoundboardEvent {}

class PlaySoundEvent extends SoundboardEvent {
  final String soundName;
  PlaySoundEvent(this.soundName);
}

abstract class SoundboardState {}

class SoundboardInitial extends SoundboardState {}

class SoundboardBloc extends Bloc<SoundboardEvent, SoundboardState> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final FirebaseAnalytics analytics;

  SoundboardBloc(this.analytics) : super(SoundboardInitial()) {
    on<PlaySoundEvent>(_onPlaySound);
  }
  // SoundboardBloc() : super(SoundboardInitial()) {
  //   on<PlaySoundEvent>(_onPlaySound);
  // }

  Future<void> _onPlaySound(PlaySoundEvent event, Emitter<SoundboardState> emit) async {
    final filePath = 'sounds/${event.soundName}.mp3';
    try {
      await _audioPlayer.stop();
      await _audioPlayer.play(AssetSource(filePath));
      await analytics.logEvent(
        name: '${event.soundName}_pressed',
        parameters: {'sound': event.soundName},
      );

      await FirebaseAnalytics.instance.logEvent(
        name: "select_content",
        parameters: {
          "content_type": "image",
          "item_id": 42,
        },
      );

    } catch (e) {
      print('Error playing sound: $e');
    }
  }
}
