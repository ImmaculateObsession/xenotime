package
{
    import org.flixel.FlxGroup;
    import org.flixel.FlxPoint;
    import org.flixel.FlxSave;
    import org.flixel.FlxG;

    public class Level extends FlxGroup
    {
        

        protected var startPoint:FlxPoint;
        protected var endPoint:FlxPoint;

        //holds the save object
        private static var saveState:FlxSave;
        //temporary holder in case the game can't find a previous save
        private static var tempSaveData:Array;
        //if the level has loaded correctly
        private var hasLoaded:Boolean = false;

        public function Level()
        {
            Common.background = new PlayGrid(Common.GRIDWIDTH,Common.GRIDHEIGHT,Common.LEVELX,Common.LEVELY,Common.backLevel);
            Common.obstacleMap = new PlayGrid(Common.GRIDWIDTH,Common.GRIDHEIGHT,Common.LEVELX,Common.LEVELY,Common.obstacles);
            Common.playerGrid = new PlayGrid(Common.GRIDWIDTH,Common.GRIDHEIGHT,Common.LEVELX,Common.LEVELY,Common.blank);

            startPoint = new FlxPoint(0,0);
            endPoint = new FlxPoint(9, 4);
            
            add(Common.background);
            add(Common.obstacleMap);
            add(Common.playerGrid);

            //instantiate the saveState variable
            saveState = new FlxSave();
            //true if there is a level data in existence
            hasLoaded = saveState.bind("levelData");

            //if there's level data, but it's null, create a new place to put data
            if (hasLoaded && saveState.data.tileData == null)
            {
                //should prime the savestate's tileData with a blank tileData
                saveState.data.tileData = Common.blank;
            } 
        }
        
        public function placeTile(point:FlxPoint, tileType:uint):void
        {
            if (Common.canPlaceTile && Common.playerGrid.isInGrid(point) && (Common.obstacleMap.getTileType(point) == 0))
            {
                Common.playerGrid.changeTile(point, tileType);
                checkForWin();
            }
        }
        
        //save the current player tile layout
        //
        //returns: if the save was successful
        public function save():void
        {
            //if we have a save state to work with, save the current player tile positions
            //into the save state
            if (hasLoaded)
            {
                FlxG.log("Retrieving data");
                var tileData:Array = Common.playerGrid.getTileData();
                FlxG.log("Saving level data:");
                FlxG.log(tileData);
                saveState.data.tileData = tileData;
                saveState.data.number = 1;
                //saveState.flush();
            }
            //otherwise put the tile positions into a temporary holder
            else
            {
                tempSaveData = Common.playerGrid.getTileData();
            }
        }

        public function load():void
        {
            //if the level data has loaded successfully, take the data from the savestate
            var loadData:Array;
            if (hasLoaded)
            {
                loadData = saveState.data.tileData;

            }
            //otherwise, take the data from the temp save
            else
            {
                loadData = tempSaveData;
            }

            if (loadData != null)
            {
                FlxG.log(saveState.data.number);
                FlxG.log("Loading level data:")
                FlxG.log(loadData);
                Common.playerGrid.setTileData(loadData);
                Common.playerGrid.refreshTiles();
            }
            else
            {
                FlxG.log("Nothing to load.");
            }
        }

        public function checkForWin():void {
            var result:Boolean = Common.playerGrid.isPath(startPoint, endPoint);
            trace(result);
            if (result == true) {
                Common.hud.showWin();
            }
        }
    }
}