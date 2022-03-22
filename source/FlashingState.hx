package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.effects.FlxFlicker;
import lime.app.Application;
import flixel.addons.transition.FlxTransitionableState;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;

class FlashingState extends MusicBeatState
{
	public static var leftState:Bool = false;

	var warnText:FlxText;
	override function create()
	{
		super.create();

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		add(bg);

		warnText = new FlxText(-160, 50, FlxG.width,
			"GREETINGS PLAYER:\n
			FOR LEGAL REASONS, This mod contains the following items,\n
			Flesh, Blood,Flashing lights, Jumpscares in mechanics, mentions of adult stuff etc.\n
                        If you can get scared/have senetive eyes, we suggest\n
                        To keep all players safe turn off these 3 following in the option menu.\n
                        Flashing Lights\n
                        Enable Mechanics\n
                        Groosom Dialouge\n
                        Thanky you and enjoy the mod",
			0);
		warnText.setFormat(Paths.font("HelpMe.ttf"), 20, FlxColor.RED, CENTER);
		//warnText.screenCenter();
		add(warnText);

		var disclaimText = new FlxText(220, 480, FlxG.width,
			"DISCLAIMER:\n
			This Mod also contains some hard gameplay,\n
			along with a bit of gore in some visuals!\n
                        But working of collaboration with the wulsy mod and the denso mod\n
                        Their maybe lots and lots of gore and senetive text in dialouge
			You've been warned!",
			44);
		disclaimText.setFormat(Paths.font("HelpMe.ttf"), 20, FlxColor.RED, CENTER);
		//disclaimText.screenCenter(X);
		add(disclaimText);
	}

	override function update(elapsed:Float)
	{
		if(!leftState) {
			var back:Bool = controls.BACK;
			if (controls.ACCEPT || back) {
				leftState = true;
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
				if(!back) {
					ClientPrefs.flashing = false;
					ClientPrefs.saveSettings();
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxFlicker.flicker(warnText, 1, 0.1, false, true, function(flk:FlxFlicker) {
						new FlxTimer().start(0.5, function (tmr:FlxTimer) {
							MusicBeatState.switchState(new TitleState());
						});
					});
				} else {
					FlxG.sound.play(Paths.sound('cancelMenu'));
					FlxTween.tween(warnText, {alpha: 0}, 1, {
						onComplete: function (twn:FlxTween) {
							MusicBeatState.switchState(new TitleState());
						}
					});
				}
			}
		}
		super.update(elapsed);
	}
}
