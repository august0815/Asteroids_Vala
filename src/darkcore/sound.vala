using SDLMixer;

namespace Darkcore { class Sound : Object {
    public SDLMixer.Music audio; 
    public Sound (string filename) {
        int audio_frequency = 44100;
        uint16 audio_format = 0x8010; // 16-bit stereo?
        int audio_channels = 2;
        int audio_buffers = 4096;
        SDLMixer.open(audio_frequency, audio_format, audio_channels, audio_buffers);
        audio = new SDLMixer.Music (filename);
    }
    
    public void play () {
        audio.play(0);
    }
}}
