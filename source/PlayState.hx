package ;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.system.FlxSound;
import flixel.tile.FlxTilemap;
import flixel.ui.FlxButton;
import flixel.util.FlxCollision;
import flixel.util.FlxColor;
import flixel.util.FlxRandom;
import flixel.util.FlxStringUtil;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	var _border:FlxTilemap;
	var _blueTiles:FlxTilemap;
	var _target:Target;
	var _player:Player;
	var BRICK_SIZE:Int;
	var _bgArray:Array<FlxSprite>;
	
	var _limit:FlxGroup;
	var brickSnd:FlxSound;

	override public function create():Void
	{
		BRICK_SIZE = Reg.brickSize;
		brickSnd = FlxG.sound.load("assets/sounds/brick.mp3");

		_bgArray = [
			new FlxSprite(0, 0, "assets/images/blue_back.png"), 
			new FlxSprite(0, 0, "assets/images/green_back.png"), 
			new FlxSprite(0, 0, "assets/images/yellow_back.png")
		];
		
		add(_bgArray[0]);
		
		_border = new FlxTilemap();
		_border.loadMap(FlxStringUtil.imageToCSV("assets/images/default_map.png", false, 1), "assets/images/black_tile.png");
		add(_border);
		
		var bt:FlxTilemap = new FlxTilemap();
		bt.loadMap(FlxStringUtil.imageToCSV("assets/images/empty_map.png", false, 1), "assets/images/blue_tile.png");
		var gt:FlxTilemap = new FlxTilemap();
		gt.loadMap(FlxStringUtil.imageToCSV("assets/images/empty_map.png", false, 1), "assets/images/green_tile.png");
		var yt:FlxTilemap = new FlxTilemap();
		yt.loadMap(FlxStringUtil.imageToCSV("assets/images/empty_map.png", false, 1), "assets/images/yellow_tile.png");
		
		Reg.tileMaps = [gt, yt, bt];
		add(Reg.tileMaps[0]);
		
		_player = new Player (60, 395);
		Reg.player = _player;
		add(_player);
		
		_target = new Target();
		add(_target);
		
		// Reset Button
		var startBtn:FlxButton = new FlxButton(2, 450, "RESTART", reset);
		startBtn.loadGraphic("assets/images/btn1.png", false, 120, 28);
		startBtn.label.size = 16;
		startBtn.label.color = FlxColor.WHITE;
		add(startBtn);
		
		_limit = FlxCollision.createCameraWall(FlxG.camera, FlxCollision.CAMERA_WALL_INSIDE, 2);
		
		Reg.hud = new HUD();
		add(Reg.hud);
		
		super.create();
	}

	override public function destroy():Void
	{
		super.destroy();
	}

	override public function update():Void
	{
		FlxG.collide(_player, Reg.tileMaps[1]);
		FlxG.collide(_player, Reg.tileMaps[0]);
		
		// World Borders ... crappy
		FlxG.collide(_player, _border);
		FlxG.collide(_player, _limit);
		
		if (FlxG.keys.anyPressed(["B"]))
		{
			addBrick();
		}
		
		if(FlxCollision.pixelPerfectCheck(_target, _player))
		{
			newRound();
			Reg.score++;
			Reg.touchSound.play(true);
		}
		
		if (Reg.hud.time <= 0)
		{
			FlxG.switchState(new GameOver());
		}
		
		super.update();
	}
	
	function addBrick():Void
	{
		brickSnd.play();
		_player.animation.play("putbrick");
		Reg.tileMaps[0].setTile(Std.int(_player.x / BRICK_SIZE), Std.int(_player.y / BRICK_SIZE), 1);
	}
	
	function newRound():Void
	{
		Reg.hud.scored();
		Reg.hud.addTime();
		var prev1:FlxSprite = _bgArray.shift();
		var prev2:FlxTilemap = Reg.tileMaps.shift();
		
		remove(prev1);
		remove(prev2);
		remove(Reg.tileMaps[0]);
		
		_bgArray.push(prev1);
		Reg.tileMaps.push(prev2);
		
		
		add(_bgArray[0]);
		add(Reg.tileMaps[1]);
		add(Reg.tileMaps[0]);
		
		if (FlxRandom.intRanged(1, Reg.popAmmo) == 1)
		{
			placeAmmo();
		}
		_target.placeTarget();
	}
	
	function placeAmmo():Void 
	{
		var _newPos:Array<Int> = getPosition();
		
		// Checks so the target don't land on a brick
		while (Reg.tileMaps[0].getTile(_newPos[0], _newPos[1]) == 1 || Reg.tileMaps[1].getTile(_newPos[0], _newPos[1]) == 1 || _newPos[0] == 20 || _newPos[1] == 14) 
		{
			_newPos = getPosition();
		}
		
		add(new Ammo(_newPos[0] * BRICK_SIZE, _newPos[1] * BRICK_SIZE, "assets/images/ammo.png"));
		
	}
	
	function getPosition():Array<Int>
	{
		return [
			Math.floor(FlxRandom.intRanged(0, FlxG.width) / BRICK_SIZE), 
			Math.floor(FlxRandom.intRanged(BRICK_SIZE, FlxG.height - BRICK_SIZE) / BRICK_SIZE)
		];
	}
		
	function reset():Void
	{
		Reg.clickSound.play();
		FlxG.resetGame();
	}

}