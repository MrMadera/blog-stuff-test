package;

import flixel.FlxGame;

import openfl.display.Sprite;

import states.BlogMainState;

class Main extends Sprite 
{
		public function new() 
		{
				super();

				FlxG.autoPause = false;

				addChild(new FlxGame(1280, 720, BlogMainState, true));
		}
}