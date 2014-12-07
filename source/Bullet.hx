package ;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxSound;
import flixel.util.FlxCollision;

/**
 * ...
 * @author Thomas MALICET
 */
class Bullet extends FlxSprite
{
	
	private var speed:Float = 10;
	private var speedY:Float = 0.3;
	private var direction:Int = 1;
	var boomSnd:FlxSound;

	public function new(X:Float=0, Y:Float=0) 
	{
		super(X, Y);
		boomSnd = FlxG.sound.load("assets/sounds/boom.wav");
		makeGraphic(4, 4);
		
		direction = (Reg.player.facing == FlxObject.LEFT) ? -1 : 1;
	}
	
	override public function update():Void
	{
		x += speed * direction;
		y += speedY;
		
		if (!inWorldBounds())
		{
			destroy();
		}
		
		if (Reg.tileMaps[0].getTile(Std.int(x / Reg.brickSize), Std.int(y / Reg.brickSize)) == 1)
		{
			Reg.tileMaps[0].setTile(Std.int(x / Reg.brickSize), Std.int(y / Reg.brickSize), 0);
			boomSnd.play();
			destroy();
		}
		if (Reg.tileMaps[1].getTile(Std.int(x / Reg.brickSize), Std.int(y / Reg.brickSize)) == 1)
		{
			Reg.tileMaps[1].setTile(Std.int(x / Reg.brickSize), Std.int(y / Reg.brickSize), 0);
			boomSnd.play();
			destroy();
		}
		
	}
	
}