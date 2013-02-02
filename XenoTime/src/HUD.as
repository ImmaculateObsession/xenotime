package
{
    import org.flixel.FlxSprite;
    import org.flixel.FlxGroup;
    import org.flixel.FlxPoint;
    import org.flixel.FlxText;
    import org.flixel.plugin.photonstorm.FlxExtendedSprite;

    public class HUD extends FlxGroup
    {
        protected var forestStraight:FlxSprite;
        protected var forestCorner:FlxSprite;
        protected var forestQuad:FlxSprite;
        protected var forestThree:FlxSprite;
        protected var cityStraight:FlxSprite;
        protected var cityCorner:FlxSprite;
        protected var cityQuad:FlxSprite;
        protected var cityThree:FlxSprite;

        protected var logo:FlxSprite;

        public var cityTile:FlxSprite;
        public var plantTile:FlxSprite;

        protected var clockRot:FlxExtendedSprite;
        protected var counterClockRot:FlxExtendedSprite;
        protected var deleteButton:FlxExtendedSprite;

        //TEMP buttons for saving and loading
        protected var saveButton:FlxExtendedSprite;
        protected var loadButton:FlxExtendedSprite;

        public function HUD()
        {
            forestStraight = new FlxSprite(800, 100);
            forestStraight.loadGraphic(Common.MapTile, true, false, 64, 64, false);
            forestStraight.frame = Common.forestPipe1;
            forestCorner = new FlxSprite(900, 100);
            forestCorner.loadGraphic(Common.MapTile, true, false, 64, 64, false);
            forestCorner.frame = Common.forestPipe2;
            forestQuad = new FlxSprite(800, 200);
            forestQuad.loadGraphic(Common.MapTile, true, false, 64, 64, false);
            forestQuad.frame = Common.forestPipe4;
            forestThree = new FlxSprite(900, 200);
            forestThree.loadGraphic(Common.MapTile, true, false, 64, 64, false);
            forestThree.frame = Common.forestPipe3;
            cityStraight = new FlxSprite(800, 400);
            cityStraight.loadGraphic(Common.MapTile, true, false, 64, 64, false);
            cityStraight.frame = Common.cityPipe1;
            cityCorner = new FlxSprite(900, 400);
            cityCorner.loadGraphic(Common.MapTile, true, false, 64, 64, false);
            cityCorner.frame = Common.cityPipe2;
            cityQuad = new FlxSprite(800, 500);
            cityQuad.loadGraphic(Common.MapTile, true, false, 64, 64, false);
            cityQuad.frame = Common.cityPipe4;
            cityThree = new FlxSprite(900, 500);
            cityThree.loadGraphic(Common.MapTile, true, false, 64, 64, false);
            cityThree.frame = Common.cityPipe3;

            plantTile = new FlxSprite(Common.LEVELX - Common.TILEWIDTH, Common.LEVELY);
            plantTile.loadGraphic(Common.MapTile, true, false, 64, 64, false);
            cityTile = new FlxSprite((Common.TILEWIDTH * Common.GRIDWIDTH) + Common.LEVELX, Common.GRIDHEIGHT * Common.TILEHEIGHT/2);
            cityTile.loadGraphic(Common.MapTile, true, false, 64, 64, false);
            plantTile.frame = Common.forestTile;
            cityTile.frame = Common.cityTile;

            clockRot = new FlxExtendedSprite();
            clockRot.loadGraphic(Common.MapTile, true, false, 64, 64, false);
            clockRot.frame = Common.clockWiseButton;
            clockRot.visible = false;
            clockRot.enableMouseClicks(true);
            counterClockRot = new FlxExtendedSprite();
            counterClockRot.loadGraphic(Common.MapTile, true, false, 64, 64, false);
            counterClockRot.frame = Common.counterClockButton;
            counterClockRot.visible = false;
            counterClockRot.enableMouseClicks(true);

            deleteButton = new FlxExtendedSprite();
            deleteButton.loadGraphic(Common.MapTile, true, false, 64, 64, false);
            deleteButton.frame = Common.deleteSymbol;
            deleteButton.visible = false;
            deleteButton.enableMouseClicks(true);


            //TEMP save and load buttons for testing save and load
            saveButton = new FlxExtendedSprite(700, 20);
            saveButton.loadGraphic(Common.MapTile, true, false, 64, 64, false);
            saveButton.frame = 38;
            saveButton.visible = true;
            saveButton.enableMouseClicks(true);
            loadButton = new FlxExtendedSprite(900, 20);
            loadButton.loadGraphic(Common.MapTile, true, false, 64, 64, false);
            loadButton.frame = 39;
            loadButton.visible = true;
            loadButton.enableMouseClicks(true);

            logo = new FlxSprite(800, 650);
            logo.loadGraphic(Common.Logo, true, false, 100, 100, false);

            add(saveButton);
            add(loadButton);

            add(plantTile);
            add(cityTile);

            add(clockRot);
            add(counterClockRot);
            add(deleteButton);

            add(forestStraight);
            add(forestCorner);
            add(forestQuad);
            add(forestThree);
            add(cityStraight);
            add(cityCorner);
            add(cityQuad);
            add(cityThree);
            add(logo);
        }

        public function handleClick(point:FlxPoint):uint
        {
            var typeClicked:uint;
            if (forestStraight.overlapsPoint(point))
            {
                typeClicked = Common.forestPipe1;
            }
            else if (forestCorner.overlapsPoint(point))
            {
                typeClicked = Common.forestPipe2;
            }
            else if (forestQuad.overlapsPoint(point))
            {
                typeClicked = Common.forestPipe4;
            }
            else if (forestThree.overlapsPoint(point))
            {
                typeClicked = Common.forestPipe3;
            }
            else if (cityStraight.overlapsPoint(point))
            {
                typeClicked = Common.cityPipe1;
            }
            else if (cityCorner.overlapsPoint(point))
            {
                typeClicked = Common.cityPipe2;
            }
            else if (cityThree.overlapsPoint(point))
            {
                typeClicked = Common.cityPipe3;
            }
            else if (cityQuad.overlapsPoint(point))
            {
                typeClicked = Common.cityPipe4;
            }
            if (typeClicked) {
                Common.canPlaceTile = true;
                Common.activePoint = null;
                hideTileHandlers();
            }

            // Hack to get save buttons in without messing
            // with tile selection
            if (saveButton.overlapsPoint(point))
            {
                typeClicked = 1;
            }
            else if (loadButton.overlapsPoint(point))
            {
                typeClicked = 2;
            }
            return typeClicked;
        }
        // Show the rotation and deletion buttons when a tile is placed.
        // TODO: Remove magic numbers from math.
        public function showTileHandlers(point:FlxPoint):void
        {
            var startX:uint = (Math.floor((point.x - Common.playerGrid.gridX)/Common.TILEWIDTH) * Common.TILEWIDTH) + Common.playerGrid.gridX;
            var startY:uint = (Math.floor((point.y - Common.playerGrid.gridY)/Common.TILEHEIGHT) * Common.TILEHEIGHT) + Common.playerGrid.gridY;
            clockRot.x = startX - (Common.TILEWIDTH / 2);
            counterClockRot.x = startX + (Common.TILEHEIGHT / 2);
            clockRot.y = startY;
            counterClockRot.y = startY;
            clockRot.visible = true;
            counterClockRot.visible = true;
            clockRot.mouseReleasedCallback = clockwiseHandler;
            counterClockRot.mouseReleasedCallback = counterClockwiseHandler;
            deleteButton.x = startX;
            deleteButton.y = startY;
            deleteButton.visible = true;
            deleteButton.mouseReleasedCallback = deleteHandler;
        }

        public function hideTileHandlers():void {
            clockRot.visible = false;
            counterClockRot.visible = false;
            clockRot.x = -100;
            clockRot.y = -100;
            counterClockRot.x = -100;
            counterClockRot.y = -100;
            deleteButton.x = -100;
            deleteButton.y = -100;
            deleteButton.visible = false;
        }

        protected function clockwiseHandler(sprite:FlxExtendedSprite, mouseX:uint, mouseY:uint):void
        {
            Common.playerGrid.rotateTile(true);
        }

        protected function counterClockwiseHandler(sprite:FlxExtendedSprite, mouseX:uint, mouseY:uint):void
        {
            Common.playerGrid.rotateTile(false);
        }

        protected function deleteHandler(sprite:FlxExtendedSprite, mouseX:uint, mouseY:uint):void {
            hideTileHandlers();
            Common.playerGrid.deleteTile();
        }

        public function showWin():void {
            add(new FlxText(100, 800, 100, "You win!"));
        }
    }
}