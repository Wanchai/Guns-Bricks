package ;

import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.text.FlxText;

/**
 * ...
 * @author Thomas MALICET
 */
class HUD extends FlxGroup
{
	var ammoTxt:FlxText;
	var scoreTxt:FlxText;
	var timeTxt:FlxText;
	//var counter:Float;
	
	public var ammo:Int = 10;
	public var score:Int = 0;
	public var time:Float = 15;

	public function new() 
	{
		super();
		
		ammoTxt = new FlxText(15, 7, 80, "Ammo: " + ammo, 12);
		add(ammoTxt);
		scoreTxt = new FlxText(120, 7, 80, "Score: " + score, 12);
		add(scoreTxt);
		timeTxt = new FlxText(550, 7, 80, "TIME: " + time, 12);
		add(timeTxt);
	}
	
	public function gainAmmo():Void 
	{
		ammo += 2;
		ammoTxt.text = "Ammo: " + ammo;
	}	
	public function looseAmmo():Void 
	{
		ammo -= 1;
		ammoTxt.text = "Ammo: " + ammo;
	}
	
	public function scored():Void
	{
		score ++;
		scoreTxt.text = "Score: " + score;
	}
	
	public function addTime():Void
	{
		time += 6;
	}
	override public function update():Void
	{
		time -= FlxG.elapsed;
		timeTxt.text = "TIME: " + Math.floor(time);
	}
}