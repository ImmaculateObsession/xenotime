package
{
	import org.flixel.*;

	public class HUD extends FlxGroup
	{	
		protected var forestStraight:FlxSprite;
		protected var forestCorner:FlxSprite;
		protected var forestQuad:FlxSprite;
		protected var forestThree:FlxSprite;
		protected var cityStraight:FlxSprite;
		protected var cityCorner:FlxSprite;
		protected var cityQuad:FlxSprite;
		protected var cityThree:FlxSprite;
		
		public var cityTile:FlxSprite;
		public var plantTile:FlxSprite;

		public function HUD()
		{
			forestStraight = new FlxSprite(800, 100);
			forestStraight.loadGraphic(PlayState.MapTile, true, false, 64, 64, false);
			forestStraight.frame = 15;
			forestCorner = new FlxSprite(900, 100);
			forestCorner.loadGraphic(PlayState.MapTile, true, false, 64, 64, false);
			forestCorner.frame = 16;
			forestQuad = new FlxSprite(800, 200);
			forestQuad.loadGraphic(PlayState.MapTile, true, false, 64, 64, false);
			forestQuad.frame = 17;
			forestThree = new FlxSprite(900, 200);
			forestThree.loadGraphic(PlayState.MapTile, true, false, 64, 64, false);
			forestThree.frame = 18;
			cityStraight = new FlxSprite(800, 400);
			cityStraight.loadGraphic(PlayState.MapTile, true, false, 64, 64, false);
			cityStraight.frame = 19;
			cityCorner = new FlxSprite(900, 400);
			cityCorner.loadGraphic(PlayState.MapTile, true, false, 64, 64, false);
			cityCorner.frame = 20;
			cityQuad = new FlxSprite(800, 500);
			cityQuad.loadGraphic(PlayState.MapTile, true, false, 64, 64, false);
			cityQuad.frame = 22;
			cityThree = new FlxSprite(900, 500);
			cityThree.loadGraphic(PlayState.MapTile, true, false, 64, 64, false);
			cityThree.frame = 21;

			add(forestStraight);
			add(forestCorner);
			add(forestQuad);
			add(forestThree);
			add(cityStraight);
			add(cityCorner);
			add(cityQuad);
			add(cityThree);
		}
		
		public function handleClick(point:FlxPoint):uint
		{
			var typeClicked:uint;
			if (forestStraight.overlapsPoint(point))
			{
				typeClicked = 15;
			}
			else if (forestCorner.overlapsPoint(point))
			{
				typeClicked = 16;
			}
			else if (forestQuad.overlapsPoint(point))
			{
				typeClicked = 17;
			}
			else if (forestThree.overlapsPoint(point))
			{
				typeClicked = 18;
			}
			else if (cityStraight.overlapsPoint(point))
			{
				typeClicked = 19;
			}
			else if (cityCorner.overlapsPoint(point))
			{
				typeClicked = 20;
			}
			else if (cityThree.overlapsPoint(point))
			{
				typeClicked = 21;
			}
			else if (cityQuad.overlapsPoint(point))
			{
				typeClicked = 22;
			}
			return typeClicked;
		}
	}
}