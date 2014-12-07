package ;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxSound;
import flixel.util.FlxColor;

/**
 * ...
 * @author Thomas MALICET
 */
class Player extends FlxSprite
{
	var shootSnd:FlxSound;
	var jumpSnd:FlxSound;

	public function new(X:Float=0, Y:Float=0, ?SimpleGraphic:Dynamic) 
	{
		super(X, Y);
		
		jumpSnd = FlxG.sound.load("assets/sounds/jump.mp3");
		shootSnd = FlxG.sound.load("assets/sounds/shoot.wav");
		
		loadGraphic("assets/images/player.png", true, 34, 50);
		
		animation.add("idle", [0,1,2,3,4], 2, true);
		animation.add("fall", [5,6], 10, true);
		animation.add("putbrick", [10, 11, 12, 13, 14], 12, false);
		animation.add("walk", [15,16,17,18], 7, true);
		animation.add("shoot", [20,21,22,23,24], 7, false);
		animation.add("jump", [25,26,27,28], 5, false);
		animation.add("win", [30,31,32,33,34], 5, true);
		animation.add("cry", [35,36], 5, true);
		
		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
		
		facing = FlxObject.RIGHT;
		
		// Walking speed
		maxVelocity.x = 140;
		// Gravity
		acceleration.y = 520;	
		// Deceleration (sliding to a stop)
		drag.x = maxVelocity.x * 4;
		
		
		setSize(20, 48);
		centerOffsets(true);
	}
	
	override public function update():Void
	{
		// Smooth slidey walking controls
		acceleration.x = 0;
		
		if (FlxG.keys.anyPressed(["LEFT", "A"]))
		{
			acceleration.x -= drag.x;
			facing = FlxObject.LEFT;
		}
		if (FlxG.keys.anyPressed(["RIGHT", "D"]))
		{
			acceleration.x += drag.x;
			facing = FlxObject.RIGHT;
		}
		
		if (isTouching(FlxObject.FLOOR))
		{
			// Jump controls
			if (FlxG.keys.anyJustPressed(["UP", "W", "SPACE"]))
			{
				velocity.y = -acceleration.y * 0.51;
				animation.play("jump");
				jumpSnd.play();
			}
			else if (velocity.x > 0 || velocity.x < 0)
			{
				animation.play("walk");
			}
			else
			{
				if (animation.curAnim != animation.getByName("shoot") && animation.curAnim != animation.getByName("putbrick")) {
					animation.play("idle");
				}
				
			}
		}
		else if (velocity.y < 150)
		{
			animation.play("jump");
		}
		else
		{
			animation.play("fall");
		}
		
		if (FlxG.keys.anyJustPressed(["V"]))
		{
			shoot();
		}

		
        super.update();
	}
	
	function shoot():Void
	{
		if (Reg.hud.ammo > 0)
		{
			shootSnd.play();
			animation.play("shoot");
			Reg.hud.looseAmmo();
			var bul:Bullet = new Bullet(x, y + 12);
			FlxG.state.add(bul);
		}
	}
}