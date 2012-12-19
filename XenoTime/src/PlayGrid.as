package
{
    import org.flixel.FlxGroup;
    import org.flixel.FlxPoint;

    public class PlayGrid extends FlxGroup
    {
        protected var tiles:Array;
        protected var gridWidth:uint;
        protected var gridHeight:uint;
        public var activeTile:FlxPoint;

        public function PlayGrid(width:uint, height:uint, x:uint, y:uint, tileData:Array)
        {
            gridWidth = width;
            gridHeight = height;
            tiles = new Array(width);
            for (var i:int=0; i<width; i++)
            {
                tiles[i] = new Array(height);
            }

            for (i=0; i<width; i++)
            {
                for (var j:int=0; j<height; j++)
                {
                    var tempTile:Tile = new Tile(i*Common.TILEWIDTH + x, j*Common.TILEWIDTH + y, Common.MapTile, tileData[j*height +i]);
                    tempTile.loadGraphic(Common.MapTile, true, false, Common.TILEWIDTH, Common.TILEHEIGHT, false);
                    tempTile.setFrame(tileData[j*height +i]);
                    tempTile.setSides(tileData[j*height + i]);
                    tiles[i][j] = tempTile
                    add(tiles[i][j]);
                }
            }
        }

        public function changeTile(point:FlxPoint, tileType:uint):void
        {
            if (tileType == 0) {return;}
            var tileX:uint = Math.floor((point.x-10)/Common.TILEWIDTH);
            var tileY:uint = Math.floor((point.y-10)/Common.TILEHEIGHT);
            if ((tileX >= 0 && tileX <=gridWidth) && (tileY >=0 && tileY <= gridHeight))
            {
                tiles[tileX][tileY].setFrame(tileType);
                tiles[tileX][tileY].setSides(tileType);
                activeTile = new FlxPoint(tileX, tileY);
                Common.activePoint = point;
                Common.canPlaceTile = false;
            }
        }

        public function rotateTile(clockWise:Boolean):void
        {
            if (clockWise == true)
            {
                tiles[activeTile.x][activeTile.y].rotateClockwise();
            }
            else
            {
                tiles[activeTile.x][activeTile.y].rotateCounterClockwise();
            }
        }
    }
}