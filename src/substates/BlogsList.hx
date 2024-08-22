package substates;

import objects.CustomButton;
import flixel.FlxSubState;
import flixel.FlxObject;

import states.CreatePostState;

class BlogsList extends FlxSubState
{
  var createButton:CustomButton;

  var postsArrayHere:Array<Dynamic> = [];

  var camFollow:FlxObject;
  var grp:FlxTypedGroup<FlxSprite>;

  override function create()
  {
    super.create();
    
    postsArrayHere = FlxG.save.data.postsArray;

    grp = new FlxTypedGroup<FlxSprite>();
    add(grp);

    var num:Int = 0;
    for(array in cast(postsArrayHere, Array<Dynamic>))
    {
      var spr:FlxSprite = new FlxSprite(0, 50 + (220 * num)).makeGraphic(700, 200, 0xFF000000);
      spr.screenCenter(X);
      spr.scrollFactor.set(0, 1);
      spr.ID = num;
      grp.add(spr);

      var titleText:FlxText = new FlxText(spr.x + 10, spr.y + 10, spr.width - 20, array[0], 24);
      titleText.setFormat('assets/fonts/leaguespartan-bold.ttf', 20, 0xFFFFFFFF);
      titleText.scrollFactor.set(0, 1);
      add(titleText);
      
      var descText:FlxText = new FlxText(titleText.x, titleText.y + 30, spr.width - 20, array[1], 24);
      descText.setFormat('assets/fonts/leaguespartan-bold.ttf', 20, 0xFFFFFFFF);
      descText.scrollFactor.set(0, 1);
      add(descText);

      num++;
    }

    camFollow = new FlxObject(0, 0, 1, 1);
    add(camFollow);

    FlxG.camera.follow(camFollow);

    createButton = new CustomButton(0, 50, 100, 33, 0xFF000000, 'Create', 16, 0xFFFFFFFF, function()
    {
      FlxG.switchState(new CreatePostState());
    });
    createButton.x = FlxG.width - createButton.width - 50;
    createButton.scrollFactor.set();
    add(createButton);

    camFollow.y = clamp(camFollow.y, 400, 1000);
  }

  override function update(elapsed:Float) 
  {
    super.update(elapsed);
    
    if(FlxG.mouse.wheel != 0 && postsArrayHere.length > 3)
    {
      camFollow.y += -FlxG.mouse.wheel * 40;
      grp.forEach(function(spr:FlxSprite)
      {
        if(spr.ID == postsArrayHere.length - 1)
        {
          camFollow.y = clamp(camFollow.y, 400, spr.y + 40);
        }
      });
    }

    trace('Stuff',postsArrayHere.length,'Lol',postsArrayHere.length - 1);
  }

  function clamp(value:Float, min:Float, max:Float)
  {
    if(value < min) return min;
    if(value > max) return max;
    return value;
  }
}