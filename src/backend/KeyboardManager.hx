package backend;

import flixel.input.keyboard.FlxKey;

class KeyboardManager
{
    public static var time:Float;
    public static var delay:Float = 0.7;
    public static var instantMoment:Float;
    public static var instantMomentTexting:Float;
    public static var isRemoving:Bool = false;
    public static var isTexting:Bool = false;
    public static var lastKey:Int;
    public static var isShift:Bool = false;

    /**
     * If enabled, text will be written with "*"
     * NOTE: If you want to use the text written with password mode enabled, take realText instead
    **/
    public static var passwordMode:Bool = false;
    public static var realText:String = "";

    /**
     * Public function which plays when you write a letter
    **/
    public static var callback:Void -> Null<Void>;

    /**
     * Static function which allows you write with your keyboard in any text
     @param elapsed time elapsed
     @param textToChange the text where you are going to write
     @param actionOnEnter if you press ENTER, this function will be played
     @param onlyCapitals if **true**, the text will be only written in capital letters
    **/
    public static function _keyboardManager(elapsed:Float, textToChange:FlxText, ?actionOnEnter:Void -> Null<Void>, ?onlyCapitals:Bool = true)
    {
        time += elapsed;

        // Letters & numbers
        for(i in 48...91) // There's no problem between 58 and 65 cuz getKeyCode doesn't implement them
        {
            var key:FlxKey = getKeyCode(i);

            if(FlxG.keys.checkStatus(key, JUST_PRESSED))
            {
                if(callback != null) callback();

                if(onlyCapitals)
                {
                    if(passwordMode)
                    {
                        textToChange.text += "*";
                        realText += String.fromCharCode(i);
                    }
                    else
                        textToChange.text += String.fromCharCode(i);
                }
                else
                {
                    if(passwordMode)
                    {
                        if(isShift || (i >= 48 && i <= 57))
                        {
                            textToChange.text += "*";
                            realText += String.fromCharCode(i);
                        }
                        else
                        {
                            textToChange.text += "*";
                            realText += String.fromCharCode(i).toLowerCase();
                        }
                    }
                    else
                    {
                        if(isShift || (i >= 48 && i <= 57))
                            textToChange.text += String.fromCharCode(i);
                        else
                            textToChange.text += String.fromCharCode(i).toLowerCase();
                    }
                }


                trace("Key just pressed: " + String.fromCharCode(i));
                instantMomentTexting = time;
                
            }
            else if (FlxG.keys.checkStatus(key, PRESSED))
            {
                if(callback != null) callback();

                if (time > instantMomentTexting + delay)
                {
                    isTexting = true;
                    lastKey = key;
                }
            }
            else if (FlxG.keys.checkStatus(key, JUST_RELEASED))
            {
                if(callback != null) callback();

                isTexting = false;
            }

            if(isTexting && FlxG.keys.checkStatus(key, PRESSED) && lastKey == key)
            {
                if(callback != null) callback();

                if(passwordMode)
                {
                    textToChange.text += "*";
                    realText += String.fromCharCode(i);
                }
                else
                {
                    textToChange.text += String.fromCharCode(i);
                }
            }
        }

        // Remove
        if (FlxG.keys.justPressed.BACKSPACE)
        {
            if(callback != null) callback();

            if (textToChange.text.length > 0)
            {
                textToChange.text = textToChange.text.substr(0, textToChange.text.length - 1);
                realText = realText.substr(0, textToChange.text.length - 1);
                instantMoment = time;
            }
        }
        else if (FlxG.keys.pressed.BACKSPACE)
        {
            if(callback != null) callback();

            if (time > instantMoment + delay)
            {
                isRemoving = true;
            }
        }
        else if (FlxG.keys.justReleased.BACKSPACE)
        {
            if(callback != null) callback();

            isRemoving = false;
        }
        // Space
        else if (FlxG.keys.justPressed.SPACE)
        {
            if(callback != null) callback();

            if(passwordMode)
            {
                textToChange.text += " ";
                realText += " ";
            }
            else
            {
                textToChange.text += " ";
            }
        }

        //Continue bakcspace

        if(isRemoving)
        {
            if(FlxG.keys.pressed.BACKSPACE)
            {
                if(callback != null) callback();

                if(passwordMode)
                {
                    textToChange.text = textToChange.text.substr(0, textToChange.text.length - 1);
                    realText = realText.substr(0, textToChange.text.length - 1);
                }
                else
                {
                    textToChange.text = textToChange.text.substr(0, textToChange.text.length - 1);
                }
            }
            else if(FlxG.keys.justReleased.BACKSPACE)
            {
                if(callback != null) callback();

                isRemoving = false;
            }
        }

        //Enter
        if(FlxG.keys.justPressed.ENTER)
        {
            if(callback != null) callback();

            if(actionOnEnter != null)
                actionOnEnter();
        }

        //Special stuff

        if(FlxG.keys.justPressed.PERIOD)
        {
            if(callback != null) callback();
            
            if(passwordMode)
            {
                textToChange.text += '.';
                realText += '.';
            }
            else
            {
                textToChange.text += '.';
            }
        }
        
        if (FlxG.keys.justPressed.COMMA)
        {
            if(callback != null) callback();
            
            if(passwordMode)
            {
                textToChange.text += ',';
                realText += ',';
            }
            else
            {
                textToChange.text += ',';
            }
        }
        if(FlxG.keys.justPressed.PLUS || FlxG.keys.justPressed.NUMPADPLUS)
        {
            if(callback != null) callback();
            
            if(passwordMode)
            {
                textToChange.text += '+';
                realText += '+';
            }
            else
            {
                textToChange.text += '+';
            }
        }
        
        if(FlxG.keys.justPressed.MINUS || FlxG.keys.justPressed.NUMPADMINUS)
        {
            if(callback != null) callback();
            
            if(passwordMode)
            {
                textToChange.text += '-';
                realText += '-';
            }
            else
            {
                textToChange.text += '-';
            }
        }

        //Shift
        if(FlxG.keys.pressed.SHIFT) isShift = true
        else isShift = false;
    }
    
    /**
     *Static function to get the key code from a number
    **/
    public static function getKeyCode(num:Int):FlxKey
    {
        switch(num)
        {
            case 48: return FlxKey.ZERO;
            case 49: return FlxKey.ONE;
            case 50: return FlxKey.TWO;
            case 51: return FlxKey.THREE;
            case 52: return FlxKey.FOUR;
            case 53: return FlxKey.FIVE;
            case 54: return FlxKey.SIX;
            case 55: return FlxKey.SEVEN;
            case 56: return FlxKey.EIGHT;
            case 57: return FlxKey.NINE;
            case 65: return FlxKey.A;
            case 66: return FlxKey.B;
            case 67: return FlxKey.C;
            case 68: return FlxKey.D;
            case 69: return FlxKey.E;
            case 70: return FlxKey.F;
            case 71: return FlxKey.G;
            case 72: return FlxKey.H;
            case 73: return FlxKey.I;
            case 74: return FlxKey.J;
            case 75: return FlxKey.K;
            case 76: return FlxKey.L;
            case 77: return FlxKey.M;
            case 78: return FlxKey.N;
            case 79: return FlxKey.O;
            case 80: return FlxKey.P;
            case 81: return FlxKey.Q;
            case 82: return FlxKey.R;
            case 83: return FlxKey.S;
            case 84: return FlxKey.T;
            case 85: return FlxKey.U;
            case 86: return FlxKey.V;
            case 87: return FlxKey.W;
            case 88: return FlxKey.X;
            case 89: return FlxKey.Y;
            case 90: return FlxKey.Z;
        }
        return 0;
    }
}