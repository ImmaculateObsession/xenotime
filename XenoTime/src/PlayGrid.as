package
{
    import org.flixel.FlxGroup;
    import org.flixel.FlxPoint;

    public class PlayGrid extends FlxGroup
    {
        protected var tiles:Array;
        protected var gridWidth:uint;
        protected var gridHeight:uint;
        protected var gridStart:FlxPoint;
        protected var gridEnd:FlxPoint;
        public var activeTile:FlxPoint;

        public function PlayGrid(width:uint, height:uint, x:uint, y:uint, tileData:Array)
        {
            gridWidth = width;
            gridHeight = height;
            gridStart = new FlxPoint(x, y);
            gridEnd = new FlxPoint(x + width * Common.TILEWIDTH, y + height * Common.TILEHEIGHT);
            tiles = new Array(width);
            for (var i:int=0; i<width; i++)
            {
                tiles[i] = new Array(height);
            }

            for (i=0; i<width; i++)
            {
                for (var j:int=0; j<height; j++)
                {
                    var tileX = i*Common.TILEWIDTH + x;
                    var tileY = j*Common.TILEWIDTH + y;
                    var gridX = Math.floor((tileX - x)/Common.TILEWIDTH);
                    var gridY = Math.floor((tileY - y)/Common.TILEHEIGHT);
                    var tempTile:Tile = new Tile(tileX, tileY, Common.MapTile, tileData[j*height +i], gridX, gridY);
                    tempTile.loadGraphic(Common.MapTile, true, false, Common.TILEWIDTH, Common.TILEHEIGHT, false);
                    tempTile.setFrame(tileData[j*height +i]);
                    tempTile.setSides(tileData[j*height + i]);
                    tiles[i][j] = tempTile; 
                    add(tiles[i][j]);
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

        public function getTileType(point:FlxPoint):uint
        {
            var tileIndex:FlxPoint = translatePoint(point);
            return tiles[tileIndex.x][tileIndex.y].frame;
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

        // protected function pathWalker(start:FlxPoint, end:FlxPoint):Boolean
        // {
        //     if (start.x == end.x && start.y == end.y)
        //     {
        //         return true;
        //     }
        //     if (tiles[start.x][start.y].isClosed())
        //     {
        //         return false;
        //     }
        //     if (tiles[start.x][start.y].rightOpen())
        //     {
        //         return pathWalker(new FlxPoint(start.x + 1, start.y), end);
        //     }
        //     if (tiles[start.x][start.y].bottomOpen())
        //     {
        //         return pathWalker(new FlxPoint(start.x, start.y + 1), end);
        //     }
        //     if (tiles[start.x][start.y].topOpen())
        //     {
        //         return pathWalker(new FlxPoint(start.x, start.y - 1), end);
        //     }
        //     if (tiles[start.x][start.y].leftOpen())
        //     {
        //         return pathWalker(new FlxPoint(start.x - 1, start.y), end);
        //     }
        // }
    }
}