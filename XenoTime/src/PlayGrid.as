package
{
    import org.flixel.FlxGroup;
    import org.flixel.FlxPoint;

    public class PlayGrid extends FlxGroup
    {
        protected var tiles:Array;
        protected var TILEWIDTH:uint = 64;
        protected var TILEHEIGHT:uint = 64;

        public function PlayGrid(width:uint, height:uint, x:uint, y:uint, tileData:Array)
        {
            tiles = new Array(width);
            for (var i:int=0; i<width; i++)
            {
                tiles[i] = new Array(height);
            }

            for (i=0; i<width; i++)
            {
                for (var j:int=0; j<height; j++)
                {
                    var tempTile:Tile = new Tile(i*TILEWIDTH + x, j*TILEWIDTH + y);
                    tempTile.loadGraphic(PlayState.MapTile, true, false, TILEWIDTH, TILEHEIGHT, false);
                    tempTile.frame = tileData[j*height +i];
                    tempTile.setSides(tileData[j*height + i]);
                    tiles[i][j] = tempTile
                    add(tiles[i][j]);
                }
            }
        }

        public function changeTile(point:FlxPoint, tileType:uint):void
        {
            var tileX:uint = Math.floor(point.x/TILEWIDTH);
            var tileY:uint = Math.floor(point.y/TILEHEIGHT);

            tiles[tileX][tileY].frame = tileType;
            tiles[tileX][tileY].setSides(tileType);
        }
    }
}