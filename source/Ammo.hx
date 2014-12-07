package ;

import flixel.FlxSprite;
import flixel.util.FlxCollision;

/**
 * ...
 * @author Thomas MALICET
 */
class Ammo extends FlxSprite
{

	public function new(X:Float=0, Y:Float=0, ?SimpleGraphic:Dynamic) 
	{
		super(X, Y, SimpleGraphic);
	}
	override public function update():Void
	{
		if(FlxCollision.pixelPerfectCheck(this, Reg.player))
		{
			Reg.hud.gainAmmo();
			Reg.touchSound.play(true);
			
			destroy();
		}
	}
	
}