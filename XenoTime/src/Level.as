package
{
	import org.flixel.*;
	
	public class Level extends FlxGroup
	{
		
		protected var backLevel:Array = new Array(
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
		protected var obstacles:Array = new Array(
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
		protected var blank:Array = new Array(
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
		
		protected var background:FlxTilemap;
		protected var collisionGrid:Grid;
		protected var obstacleMap:FlxTilemap;
		protected var playerGrid:Grid;
		protected var TILEHEIGHT:uint = 64;
		protected var TILEWIDTH:uint = 64;
		
		public function Level()
		{
			background = new FlxTilemap();
			background.loadMap(FlxTilemap.arrayToCSV(backLevel, 10), PlayState.MapTile, TILEWIDTH, TILEHEIGHT, FlxTilemap.OFF, 0, 0);
			collisionGrid = new Grid(obstacles);
			collisionGrid.visible = false;
			obstacleMap = new FlxTilemap();
			obstacleMap.loadMap(FlxTilemap.arrayToCSV(obstacles, 10), PlayState.MapTile, TILEWIDTH, TILEHEIGHT, FlxTilemap.OFF, 0, 0);
			playerGrid = new Grid(blank);
			
			add(background);
			add(collisionGrid);
			add(obstacleMap);
			add(playerGrid);
		}
		
		public function placeTile(point:FlxPoint, tileType:uint):Boolean
		{
			var playerPlaced:Boolean = playerGrid.changeTile(point, tileType);
			var collisionPlaced:Boolean = collisionGrid.changeTile(point, tileType);
			return (playerPlaced && collisionPlaced);
		}
		
	}
}