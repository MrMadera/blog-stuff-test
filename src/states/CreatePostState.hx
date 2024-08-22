package states;

import objects.CustomButton;
import backend.KeyboardManager;

class CreatePostState extends FlxState
{
  var bg:FlxSprite;

  var enterTitleTxt:FlxText;
  var enterTitleTxt2:FlxText;
  var postContentTxt:FlxText;
  var postContentTxt2:FlxText;

  var saveButton:CustomButton;

  override function create()
  {
    super.create();

    bg = new FlxSprite(0, 0, 'assets/images/bg.png');
    bg.alpha = 0.25;
    add(bg);

    enterTitleTxt = new FlxText(250, 150, FlxG.width - 250 - 100, '', 16);
    enterTitleTxt.setFormat('assets/fonts/leaguespartan-bold.ttf', 20, 0xFF000000);
    add(enterTitleTxt);

    enterTitleTxt2 = new FlxText(250, 150, 0, 'Enter title...', 16);
    enterTitleTxt2.setFormat('assets/fonts/leaguespartan-bold.ttf', 20, 0xFFE212B5);
    enterTitleTxt2.alpha = 0.56;
    add(enterTitleTxt2);

    postContentTxt = new FlxText(250, 250, FlxG.width - 250 - 100, '', 16);
    postContentTxt.setFormat('assets/fonts/leaguespartan-bold.ttf', 20, 0xFF000000);
    add(postContentTxt);
    
    postContentTxt2 = new FlxText(250, 250, 0, 'Enter content...', 16);
    postContentTxt2.setFormat('assets/fonts/leaguespartan-bold.ttf', 20, 0xFFE212B5);
    postContentTxt2.alpha = 0.56;
    add(postContentTxt2);

    saveButton = new CustomButton(1160, 680, 100, 33, 0xFF000000, 'Save', 16, 0xFFFFFFFF, function()
    {
      savePost();
    });
    add(saveButton);
  }

  var isTitleSelected:Bool;
  var isDescriptionSelected:Bool;

  override function update(elapsed:Float)
  {
    super.update(elapsed);

    if(FlxG.mouse.overlaps(enterTitleTxt))
    {
      if(FlxG.mouse.justPressed)
      {
        isTitleSelected = true;
      }
    }
    else if(FlxG.mouse.justPressed) isTitleSelected = false;

    if(FlxG.mouse.overlaps(postContentTxt))
    {
      if(FlxG.mouse.justPressed)
      {
        isDescriptionSelected = true;
      }
    }
    else if(FlxG.mouse.justPressed) isDescriptionSelected = false;

    if(isTitleSelected)
    {
      KeyboardManager._keyboardManager(elapsed, enterTitleTxt, null, false);
    }
    if(isDescriptionSelected)
    {
      KeyboardManager._keyboardManager(elapsed, postContentTxt, null, false);
    }

    if(enterTitleTxt.text == '') enterTitleTxt2.text = 'Enter title...';
    else enterTitleTxt2.text = '';
    if(postContentTxt.text == '') postContentTxt2.text = 'Enter content...';
    else postContentTxt2.text = '';

    if(FlxG.keys.justPressed.ESCAPE)
    {
      FlxG.switchState(new BlogMainState());
    }
  }

  function savePost()
  {
    var newPost:Array<Dynamic> = [];

    var postTitle:String = enterTitleTxt.text;
    var postDescription:String = postContentTxt.text;
    var date = Date.now();

    newPost.push(postTitle);
    newPost.push(postDescription);
    newPost.push(date);

    var currentPosts = FlxG.save.data.postsArray;
    currentPosts.push(newPost);
    FlxG.save.data.postsArray = currentPosts;
    FlxG.save.flush();
  }
}