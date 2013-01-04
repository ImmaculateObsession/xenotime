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
                    var tileX = i*Common.TILEWIDTH + x;
                    var tileY = j*Common.TILEWIDTH + y;
                    var gridX = Math.floor((tileX - x)/Common.TILEWIDTH);
                    var gridY = Math.floor((tileY - y)/Common.TILEHEIGHT);
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

        public function isPath(start:FlxPoint, end:FlxPoint):Boolean
        {
            trace(start.x, start.y);
            trace(end.x, end.y);
            var startTile:FlxPoint = translatePoint(start);
            var endTile:FlxPoint = translatePoint(end);
            return pathWalker(startTile, endTile);
        }

        protected function pathWalker(start:FlxPoint, end:FlxPoint):Boolean
        {
            var path:Array = [start]
            var index:uint = 0;
            var hasSolution:Boolean;
            trace(start.x, start.y);
            trace(end.x, end.y);
            trace("index =", index);
            while (path.length != 0)
            {
                trace("index in loop = ", index);
                trace("path length = ", path.length);
                trace(path[index].x, path[index].y);
                if (path[index].x < 0 || path[index].y < 0)
                {
                    trace(index, "off end");
                    path.pop();
                    index--;
                    continue;
                }
                var tile = tiles[path[index].x][path[index].y]
                if (tile.gridX == end.x && tile.gridY == end.y)
                {
                    hasSolution = true;
                    trace("We did it!");        
                    break;
                }
                if (tile.isClosed())
                {
                    trace(index, "Tile is closed");
                    path.pop();
                    index--;
                    continue;
                }
                if (tile.rightOpen())
                {
                    trace(index, "Pushing right");
                    path.push(new FlxPoint(tile.gridX + 1, tile.gridY));
                    index++;
                    continue;
                }
                if (tile.bottomOpen())
                {
                    trace(index, "Pushing bottom");
                    path.push(new FlxPoint(tile.gridX, tile.gridY + 1));
                    index++;
                    continue;
                }
                if (tile.topOpen())
                {
                    trace(index, "Pushing top");
                    path.push(new FlxPoint(tile.gridX, tile.gridY - 1));
                    index++;
                    continue;
                }
                if (tile.leftOpen())
                {
                    trace(index, "Pushing left");
                    path.push(new FlxPoint(tile.gridX - 1, tile.gridY));
                    index++;
                    continue;
                }
            }
            if (path.length != 0)
            {
                return true;
            }
            return false;
        }

    }
}