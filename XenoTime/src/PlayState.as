package
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;

	public class PlayState extends FlxState
	{		
		[Embed(source='../assets/tilemap.png')] public static const MapTile:Class;

		public var tile1:FlxSprite;
		public var tile2:FlxSprite;
		protected var backGrid:Grid;
		protected var player:Player;
		protected var positionText:FlxText;
		protected var hud:HUD;
		protected var gridCam:FlxCamera;
		protected var tileType:uint = 0;
		protected var mouseTile:FlxSprite;
		protected var collisionGrid:Grid;
		protected var obstacleGrid:Grid;
		protected var playerGrid:Grid;
		protected var path:FlxPath;
		protected var HORIZONTAL:uint = 0x1100;
		protected var LEFTDOWN:uint = 0x1001;
		protected var HORIZONTALDOWN:uint = 0x1101;
		

		
		override public function create():void
		{
			var backLevel:Array = new Array(
				1,2,1,2,1,2,1,2,1,2,
				3,4,3,4,3,4,3,4,3,4,
				1,2,1,2,1,2,1,2,1,2,
				3,4,3,4,3,4,3,4,3,4,
				1,2,1,2,1,2,1,2,1,2,
				3,4,3,4,3,4,3,4,3,4,
				1,2,1,2,1,2,1,2,1,2,
				3,4,3,4,3,4,3,4,3,4,
				1,2,1,2,1,2,1,2,1,2,
				3,4,3,4,3,4,3,4,3,4);
			var obstacles:Array = new Array(
				0,0,0,0,0,0,14,0,0,0,
				0,0,0,0,0,0,13,0,0,0,
				0,0,0,0,0,0,14,0,0,0,
				0,0,0,0,0,0,13,0,0,0,
				0,0,0,0,0,0,14,0,0,0,
				0,0,0,0,0,0,13,0,0,0,
				0,0,0,0,0,0,14,0,0,0,
				0,0,0,0,0,0,13,0,0,0,
				0,0,0,0,0,0,14,0,0,0,
				0,0,0,0,0,0,13,0,0,0);
			var level:Array = new Array(
				0,0,0,0,0,0,0,0,0,0,
				0,0,0,0,0,0,0,0,0,0,
				0,0,0,0,0,0,0,0,0,0,
				0,0,0,0,0,0,0,0,0,0,
				0,0,0,0,0,0,0,0,0,0,
				0,0,0,0,0,0,0,0,0,0,
				0,0,0,0,0,0,0,0,0,0,
				0,0,0,0,0,0,0,0,0,0,
				0,0,0,0,0,0,0,0,0,0,
				0,0,0,0,0,0,0,0,0,0);
			FlxG.mouse.show();
			FlxG.bgColor = 0xff000000;
			
			backGrid = new Grid(backLevel);
			obstacleGrid = new Grid(obstacles);
			collisionGrid = new Grid(obstacles);
			collisionGrid.visible = false;
			playerGrid = new Grid(level);
			
			player = new Player();		
			hud = new HUD();
			
			mouseTile = new FlxSprite();
			mouseTile.loadGraphic(MapTile, true, false, 64, 64, false);
			tile1 = new FlxSprite();
			tile1.loadGraphic(MapTile, true, false, 64, 64, false);
			
			
			collisionGrid.setTileProperties(0, 0x1111);
			collisionGrid.setTileProperties(13, 0x1111);
			collisionGrid.setTileProperties(14, 0x1111);
			collisionGrid.setTileProperties(15, 0x0000);
			collisionGrid.setTileProperties(16, 0x0000);
			collisionGrid.setTileProperties(17, 0x0000);
			path = collisionGrid.findPath(new FlxPoint(10,10), new FlxPoint(600, 600));
			trace(path);
			
			add(hud);
			add(backGrid);
			add(obstacleGrid);
			add(collisionGrid);
			add(playerGrid);
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
			playerGrid.changeTile(point, tileType);
			collisionGrid.changeTile(point, tileType);
//			collisionGrid.setTileProperties(15, 0x0000);
			path = collisionGrid.findPath(new FlxPoint(10,10), new FlxPoint(600, 600));
			trace(path);
		}
	}
}