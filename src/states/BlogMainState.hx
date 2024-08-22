package states;

import substates.BlogsList;

class BlogMainState extends FlxState 
{
			var bg:FlxSprite;
			var logo:FlxSprite;
			var txt:FlxText;
			var lilFlash:FlxSprite;

			var blackBG:FlxSprite;

			override public function create() 
			{
						FlxG.save.bind('data', getAppdata());
						if(FlxG.save.data.postsArray == null) FlxG.save.data.postsArray = [];
						FlxG.save.flush();

						FlxG.mouse.useSystemCursor = true;

						bg = new FlxSprite(0, 0, 'assets/images/bg.png');
						bg.scrollFactor.set();
						add(bg);

						logo = new FlxSprite(0, 170, 'assets/images/logo.png');
						logo.scrollFactor.set();
						logo.screenCenter(X);
						logo.alpha = 0;
						add(logo);

						logo.y += 20;
						FlxTween.tween(logo, {alpha: 1}, 1, {ease: FlxEase.cubeOut, startDelay: 0.8});

						txt = new FlxText(0, 375, 0, '> Enter <', 20);
						txt.setFormat('assets/fonts/leaguespartan-bold.ttf', 20, 0xFF000000);
						txt.screenCenter(X);
						txt.scrollFactor.set();
						txt.alpha = 0;
						add(txt);
						
						FlxTween.tween(txt, {alpha: 1}, 1, {ease: FlxEase.cubeOut, startDelay: 1.3});

						lilFlash = new FlxSprite().makeGraphic(1280, 720, 0xFFFFFFFF);
						lilFlash.alpha = 0;
						lilFlash.scrollFactor.set();
						add(lilFlash);

						blackBG = new FlxSprite().makeGraphic(1280, 720, 0xFF000000);
						blackBG.alpha = 0;
						blackBG.scrollFactor.set();
						add(blackBG);
			}

			var selectedSmth:Bool = false;

			override public function update(elapsed:Float)
			{
					super.update(elapsed);

					if(FlxG.keys.justPressed.ENTER && !selectedSmth)
					{
						selectedSmth = true;
						lilFlash.alpha = 1;
						FlxTween.tween(lilFlash, {alpha: 0}, 1.5, {ease: FlxEase.cubeOut});
						FlxTween.tween(txt, {alpha: 0}, 1, {ease: FlxEase.cubeIn, startDelay: 0.65});
						FlxTween.tween(logo, {alpha: 0}, 1, {ease: FlxEase.cubeIn, startDelay: 0.65});
						new FlxTimer().start(0.7, function(tmr:FlxTimer)
						{
							FlxTween.tween(blackBG, {alpha: 0.6}, 0.6, {ease: FlxEase.cubeOut});
							openSubState(new BlogsList());
						});
					}
			}

    public static function getAppdata(folder:String = 'MrMadera')
    {
        var company:String = #if (flixel < "5.0.0") folder #else FlxG.stage.application.meta.get('company');
        @:privateAccess
        var file:String = FlxSave.validate(FlxG.stage.application.meta.get('file')); #end
        #if sys
        return Sys.getEnv("APPDATA") + "/" + company + "/" + file;
        #end
    }
}
