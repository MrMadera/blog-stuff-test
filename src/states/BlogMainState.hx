package states;

class BlogMainState extends FlxState 
{
			override public function create() 
			{
						var bg:FlxSprite = new FlxSprite(0, 0, 'assets/images/bg.png');
						add(bg);
			}
}
