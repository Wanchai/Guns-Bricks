package ;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

/**
 * ...
 * @author Thomas MALICET
 */
class GameOver extends FlxState
{
	
	override public function create():Void
	{
		add(new FlxText(100, 100, 250, "TIME IS OVER", 22));
		add(new FlxText(100, 150, 250, "SCORE: " + Reg.hud.score, 22));
		
		var startBtn:FlxButton = new FlxButton(100, 200, 'Restart', reset);
		startBtn.loadGraphic("assets/images/btn1.png", false, 120, 28);
		startBtn.label.size = 16;
		startBtn.label.color = FlxColor.WHITE;
		add(startBtn);
		
		super.create();
	}
	
	function reset() 
	{
		Reg.clickSound.play();
		FlxG.resetGame();
	}
}