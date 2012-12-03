package
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;

	public class PlayState extends FlxState
	{		
		[Embed(source='../assets/tilemap.png')] public static const MapTile:Class;

		public var tile1:FlxSprite;
		public var tile2:FlxSprite;
		protected var hud:HUD;
		protected var level:Level;
		protected var tileType:uint = 0;
		protected var mouseTile:FlxSprite;
		protected var HORIZONTAL:uint = 0x1100;
		protected var LEFTDOWN:uint = 0x1001;
		protected var HORIZONTALDOWN:uint = 0x1101;
		

		
		override public function create():void
		{
			FlxG.mouse.show();
			FlxG.bgColor = 0xff000000;
			
			level = new Level()
			hud = new HUD();
			
			mouseTile = new FlxSprite();
			mouseTile.loadGraphic(MapTile, true, false, 64, 64, false);
			tile1 = new FlxSprite();
			tile1.loadGraphic(MapTile, true, false, 64, 64, false);
			
			add(hud);
			add(level);
			add(tile1);
			add(mouseTile);
		}
		
		override public function update():void
		{
			var point:FlxPoint = FlxG.mouse.getWorldPosition();
			if (FlxG.mouse.justReleased())
			{
				handleClick(point);
			}
			mouseTile.x = point.x;
			mouseTile.y = point.y;
			super.update();
		}
		
		public function handleClick(point:FlxPoint):void
		{
			var handledTile:uint = hud.handleClick(point);
			if (handledTile >= 15)
			{
				mouseTile.frame = handledTile;
				tileType = handledTile
			}
			level.placeTile(point, tileType);
		}
	}
}