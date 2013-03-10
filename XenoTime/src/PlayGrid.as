package
{
    import org.flixel.FlxGroup;
    import org.flixel.FlxPoint;
    import org.flixel.FlxG;

    public class PlayGrid extends FlxGroup
    {
        protected var tiles:Array;
        protected var tileGraph:Array;
        protected var tileData:Array;
        protected var gridWidth:uint;
        protected var gridHeight:uint;
        protected var gridStart:FlxPoint;
        protected var gridEnd:FlxPoint;
        public var gridX:uint;
        public var gridY:uint;
        public var activeTile:FlxPoint;
        protected var path:Array = [];

        public function PlayGrid(width:uint = 0, height:uint = 0, x:uint = 0, y:uint = 0, tileData:Array = null, doBuildTiles:Boolean = true)
        {
            this.tileData = tileData;
            gridWidth = width;
            gridHeight = height;
            gridX = x;
            gridY = y;
            gridStart = new FlxPoint(x, y);
            gridEnd = new FlxPoint(x + width * Common.TILEWIDTH, y + height * Common.TILEHEIGHT);

            tiles = new Array(width);

            for (var i:int=0; i<width; i++)
            {
                tiles[i] = new Array(height);
                for (var j:int=0; j<height; j++)
                {
                    var tileX:uint = i*Common.TILEWIDTH + x;
                    var tileY:uint = j*Common.TILEWIDTH + y;
                    var gridX:uint = Math.floor((tileX - x)/Common.TILEWIDTH);
                    var gridY:uint = Math.floor((tileY - y)/Common.TILEHEIGHT);
                    tiles[i][j] = new Tile(tileX, tileY, Common.MapTile, tileData[j*height +i], gridX, gridY);
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

        public function deleteTile():void {
            Common.hud.hideTileHandlers();
            tiles[activeTile.x][activeTile.y].resetTile();
        }

        protected function translatePoint(point:FlxPoint):FlxPoint
        {
            var tileX:uint = Math.floor((point.x-gridX)/Common.TILEWIDTH);
            var tileY:uint = Math.floor((point.y-gridY)/Common.TILEHEIGHT);
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

        public function isPath(start:FlxPoint, end:FlxPoint):Boolean
        {
            var startTile:Tile = tiles[start.x][start.y];
            startTile.parent = Common.emptyTile;
            var endTile:Tile = tiles[end.x][end.y];
            return pathWalker(startTile, endTile);
        }

        protected function pathWalker(start:Tile, end:Tile):Boolean
        {
            var closed:Boolean = start.isClosed();
            var type:uint = start.getType();
            if (closed == true || type == 0)
            {
                return false;
            }
            path.push(start);
            if (start == end){
                Common.path = path;
                return true;
            }
            var neighbors:Array = findNeighbors(start);
            for (var index:String in neighbors)
            {
                var neighbor:Tile = neighbors[index];
                if (neighbor != start.parent)
                {
                    neighbor.parent = start;
                    start.isParent = true;
                    var continuePath:Boolean = pathWalker(neighbor, end);
                }
                if (continuePath == true)
                {
                    Common.path = path;
                    return true;
                }
            }
            path.pop();
            return false;
        }

        // So it turns out this is the way we're going to determine the order 
        // sides are evaluated in. Who knew.
        protected function findNeighbors(tile:Tile):Array
        {
            var neighbor_array:Array = []
            var add:Tile;
            if (tile.sides[1] == true && tile.gridX != gridWidth - 1)
            {
                add = tiles[tile.gridX + 1][tile.gridY];
                if (add.sides[3] == true) {
                    neighbor_array.push(add);
                }
            }
            if (tile.sides[2] == true && tile.gridY != gridHeight - 1)
            {
                add = tiles[tile.gridX][tile.gridY + 1];
                if (add.sides[0] == true) {
                    neighbor_array.push(add);
                }
            }
            if (tile.sides[0] == true && tile.gridY != 0)
            {
                add = tiles[tile.gridX][tile.gridY - 1];
                if (add.sides[2] == true) {
                    neighbor_array.push(add);
                }
            }
            if (tile.sides[3] == true && tile.gridX != 0)
            {
                add = tiles[tile.gridX - 1][tile.gridY];
                if (add.sides[1] == true) {
                    neighbor_array.push(add);
                }
            }
            return neighbor_array;
        }
    }
}