package
{
    import org.flixel.FlxGroup;
    import org.flixel.FlxPoint;
    
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
            0,0,0,0,0,0,0,0,0,0,
            0,0,8,0,0,0,0,14,0,0,
            0,0,0,11,12,0,0,0,0,0,
            0,0,0,0,0,0,0,7,0,0,
            7,0,0,0,0,0,0,8,0,0,
            8,0,0,13,0,0,0,0,0,0,
            0,0,0,14,0,9,10,0,0,0,
            0,0,0,0,0,0,0,0,0,0,
            0,13,0,0,0,0,0,11,12,0,
            0,14,0,0,0,0,0,0,0,0);
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

        public function Level()
        {
            Common.background = new PlayGrid(10,10,10,10,backLevel);
            Common.obstacleMap = new PlayGrid(10,10,10,10,obstacles);
            Common.playerGrid = new PlayGrid(10,10,10,10,blank);
            
            add(Common.background);
            add(Common.obstacleMap);
            add(Common.playerGrid);
        }
        
        public function placeTile(point:FlxPoint, tileType:uint):void
        {
            if (Common.canPlaceTile && Common.playerGrid.isInGrid(point) && (Common.obstacleMap.getTileType(point) == 0))
            {
                Common.playerGrid.changeTile(point, tileType);
                trace(Common.playerGrid.isPath(new FlxPoint(32, 32), new FlxPoint(80, 33)));
            }
        }
    }
}