/// @description Increase Jump & Die
other.jumpPower += powerLevel;
audio_play_sound(sndPowerUp, 10, false);
instance_destroy();
ShowMessage("Your jumping power has increased! Use it wisely.");