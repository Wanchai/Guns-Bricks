package ;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.FlxRandom;

/**
 * ...
 * @author Thomas MALICET
 */
class Target extends FlxSprite
{
	var BRICK_SIZE:Int;
	var _newPos:Array<Int>;

	public function new() 
	{
		super();
		BRICK_SIZE = Reg.brickSize;
		
		makeGraphic(BRICK_SIZE, BRICK_SIZE, FlxColor.CRIMSON);
		
		placeTarget();
	}
		
	public function placeTarget():Void 
	{
		_newPos = getPosition();
		
		// Check so the target don't land on a brick
		while (Reg.tileMaps[0].getTile(_newPos[0], _newPos[1]) == 1 || Reg.tileMaps[1].getTile(_newPos[0], _newPos[1]) == 1 || _newPos[0] == 20 || _newPos[1] == 14) 
		{
			_newPos = getPosition();
		}
		
		x = _newPos[0] * BRICK_SIZE;
		y = _newPos[1] * BRICK_SIZE;
	}
	
	function getPosition():Array<Int>
	{
		return [
			Math.floor(FlxRandom.intRanged(0, FlxG.width) / BRICK_SIZE), 
			Math.floor(FlxRandom.intRanged(BRICK_SIZE, FlxG.height - BRICK_SIZE) / BRICK_SIZE)
		];
	}
}