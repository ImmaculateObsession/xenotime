package
{
    import org.flixel.FlxGroup;
    import org.flixel.FlxPoint;
    import org.flixel.FlxG;

    public class PlayGrid extends FlxGroup
    {
        protected var tiles:Array;
        protected var tileData:Array;
        protected var gridWidth:uint;
        protected var gridHeight:uint;
        protected var gridStart:FlxPoint;
        protected var gridEnd:FlxPoint;
        public var activeTile:FlxPoint;

        public function PlayGrid(width:uint = 0, height:uint = 0, x:uint = 0, y:uint = 0, tileData:Array = null, doBuildTiles:Boolean = true)
        {
            this.tileData = tileData;
            gridWidth = width;
            gridHeight = height;
            gridStart = new FlxPoint(x, y);
            gridEnd = new FlxPoint(x + width * Common.TILEWIDTH, y + height * Common.TILEHEIGHT);

            tiles = new Array(width);

            for (var i:int=0; i<width; i++)
            {
                tiles[i] = new Array(height);
                for (var j:int=0; j<height; j++)
                {
                    tiles[i][j] = new Tile(i*Common.TILEWIDTH + x, j*Common.TILEWIDTH + y);
                    tiles[i][j].loadGraphic(Common.MapTile, true, false, Common.TILEWIDTH, Common.TILEHEIGHT, false);
                    add(tiles[i][j]);
                }
            }
            refreshTiles();

        }

        // Load the right image and sides for each tile
        public function refreshTiles():void
        {
            for (var i:int=0; i<gridWidth; i++)
            {
                for (var j:int=0; j<gridHeight; j++)
                {
                    tiles[i][j].setFrame(tileData[j*gridHeight +i]);
                    tiles[i][j].setSides(tileData[j*gridHeight + i]);
                }
            }
        }

        public function changeTile(point:FlxPoint, tileType:uint):void
        {
            if (tileType == 0) {return;}
            var tileIndex:FlxPoint = translatePoint(point);
            tiles[tileIndex.x][tileIndex.y].setFrame(tileType);
            tiles[tileIndex.x][tileIndex.y].setSides(tileType);
            activeTile = tileIndex;
            Common.activePoint = point;
            Common.canPlaceTile = false;
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

        protected function translatePoint(point:FlxPoint):FlxPoint
        {
            var tileX:uint = Math.floor((point.x-10)/Common.TILEWIDTH);
            var tileY:uint = Math.floor((point.y-10)/Common.TILEHEIGHT);
            return new FlxPoint(tileX, tileY);
        }

        public function isInGrid(point:FlxPoint):Boolean
        {
            return ((point.x > gridStart.x && point.x <= gridEnd.x) && (point.y > gridStart.y && point.y <= gridEnd.y));
        }

        public function getTile(i:int, j:int):Tile
        {
            return tiles[i][j];
        }

        public function getTileType(point:FlxPoint):uint
        {
            var tileIndex:FlxPoint = translatePoint(point);
            return tiles[tileIndex.x][tileIndex.y].frame;

        }

        public function getTileData():Array
        {
            var retData:Array = new Array();
            for (var j:int=0; j<gridHeight; j++)
            {
                for (var i:int=0; i<gridWidth; i++)
                {
                    retData.push(tiles[i][j].getType());
                }
            }
            return retData;        
        }

        public function setTileData(newData:Array):void
        {
            tileData = newData;
        }

    }
}