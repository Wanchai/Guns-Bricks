package ;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.util.FlxMath;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
	var music:FlxSound;
	/**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void
	{
		Reg.touchSound = FlxG.sound.load("assets/sounds/touch.mp3");
		Reg.clickSound = FlxG.sound.load("assets/sounds/click.mp3");
		
		music = FlxG.sound.load("assets/sounds/music.mp3", 0.6, true);
		music.play();
		
		add(new FlxSprite(0, 0, "assets/images/blue_back.png"));
		
		var pl1:FlxSprite = new FlxSprite(50, 105);
		pl1.loadGraphic("assets/images/player.png", true, 34, 50);
		pl1.animation.add("win", [30, 31, 32, 33, 34], 5, true);
		pl1.animation.play("win");
		add(pl1);
		
		var pl2:FlxSprite = new FlxSprite(430, 105);
		pl2.loadGraphic("assets/images/player.png", true, 34, 50);
		pl2.animation.add("cry", [35, 36], 5, true);
		pl2.animation.play("cry");
		add(pl2);
		
		add(new FlxSprite(20, 300, "assets/images/logo.png"));
		
		add(new FlxText(100, 100, 400, "Guns & Bricks", 38));
		add(new FlxText(100, 140, 350, "by Thomas MALICET", 11));
		
		add(new FlxText(100, 190, 300, "Place bricks to grab the red square and collect ammunitions.", 11));
		
		add(new FlxText(100, 280, 300, "LEFT or RIGHT: Arrows", 16));
		add(new FlxText(100, 310, 300, "JUMP: Space", 16));
		add(new FlxText(100, 340, 300, "BRICK: B", 16));
		add(new FlxText(100, 370, 300, "SHOOT: V", 16));
		
		var startBtn:FlxButton = new FlxButton(400, 380, "START", next);
		startBtn.loadGraphic("assets/images/btn1.png", false, 120, 28);
		startBtn.label.size = 16;
		startBtn.label.color = FlxColor.WHITE;
		add(startBtn);
		
		add(new FlxText(10, 455, 450, "Made for Ludum Dare #31: Entire Game on One Screen", 11));
		
		super.create();
	}
	
	function next() 
	{
		Reg.clickSound.play();
		FlxG.switchState(new PlayState());
	}

	/**
	 * Function that is called when this state is destroyed - you might want to
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
	}
}