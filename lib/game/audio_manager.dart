import 'package:flame/effects.dart';
import 'package:flame_audio/flame_audio.dart';

class AudioManager {
  // Singleton pattern
  static final AudioManager _instance = AudioManager._internal();
  factory AudioManager() => _instance;
  AudioManager._instance();

  bool _isMusicEnabled = true;
  bool _isSfxEnabled = true;
  double _musicVolume = 0.7;
  double _sfxVolume = 1.0;

  // Getters
  bool get isMusicEnabled => _isMusicEnabled;
  bool get isSfxEnabled => _isSfxEnabled;
  double get musicVolume => _musicVolume;
  double get sfxVolume => _sfxVolume;

  // Initialize audio system - preload all audio files
  Future<void> initialize() async {
    try {
      // Preload all sound effects
      await FlameAudio.audioCache.loadAll(
        [
          'music/background_music.mp3',
          'sfx/collect.mp3',
          'sfx/explosion.mp3',
          'sfx/jump.mp3',
        ]
      );
      print('Audio initialized successfully');
    }
    catch (e) {
      print('Error initializing audio: $e');
    }
  }
  // Play background music
  void playBackgroundMusic() {
    if (_isMusicEnabled) {
      try {
        FlameAudio.bgm.play('music/background_music.mp3', volume: _musicVolume);
      }
      catch (e) {
        print('Error playing background music: $e');
      }
    }
  }
  // Stop background music
  void stopBackgroundMusic() {
    try {
      FlameAudio.bgm.stop();
    }
    catch (e) {
      print('Error stopping background music: $e');
    }
  }
  // Pause background music
  void pauseBackgroundMusic() {
    try {
      FlameAudio.bgm.pause();
    }
    catch (e) {
      print('Error pausing background music: $e');
    }
  }
  // Resume background music
  void resumeBackgroundMusic() {
    if (_isMusicEnabled) {
      try {
        FlameAudio.bgm.resume();
      } catch (e) {
        print ('Error resuming background music: $e');
      }
    }
  }
  // Play sound Effect
  void playSfx(String fileName) {
    if (_isSfxEnabled) {
      try {
        FlameAudio.play('sfx/$fileName', volume: _sfxVolume);
      } catch (e) {
        print('Error playing SFX: $e');
      }
    }
  }
  // Play sound effect with custom volume
  void playSfxWithVolume(String fileName, double volume) {
    if (_isSfxEnabled) {
      try {
        final adjustedVolume = (volume * _sfxVolume).clamp(0.0, 1.0);
        FlameAudio.play('sfx/$fileName', volume: adjustedVolume);
      } catch (e) {
        print('Error playing SFX with volume: $e');
      }
    }
  }
  // Set music volume (0.0 - 1.0)
  void setMusicVolume(double volume) {
    _musicVolume = volume.clamp(0.0, 1.0);
    try {
      FlameAudio.bgm.audioPlayer.setVolume(_musicVolume);
    } catch (e) {
      print('Error setting music volume: $e');
    }
  }
  // Set sound effect volume (0.0 - 1.0)
void setSfxVolume(double volume) {
  _sfxVolume = volume.clamp(0.0, 1.0);
}
  // Toggle music on/off
void toggleMusic() {
  _isMusicEnabled = !_isMusicEnabled;
  if (_isMusicEnabled) {
    resumeBackgroundMusic();
  } else {
    pauseBackgroundMusic();
  }
}
// Toggle sound effect on/off
void toggleSfx() {
  _isSfxEnabled = !_isSfxEnabled;
}
// Enable music
void enableMusic() {
  if (!_isMusicEnabled) {
    _isMusicEnabled = true;
    resumeBackgroundMusic();
  }
}
// Disable music
void disableMusic() {
  if (_isMusicEnabled) {
    _isMusicEnabled = false;
    pauseBackgroundMusic();
  }
}
// Enable sound effects
void enableSfx() {
  _isSfxEnabled = true;
}

}