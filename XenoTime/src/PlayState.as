package
{
    import org.flixel.*;
    import org.flixel.plugin.photonstorm.FlxMouseControl;

    public class PlayState extends FlxState
    {
        protected var tileType:uint = 0;

        override public function create():void
        {
            FlxG.addPlugin(new FlxMouseControl);
            FlxG.mouse.show();
            FlxG.bgColor = 0xff000000;
            Common.level = new Level();
            Common.hud = new HUD();

            Common.mouseTile = new FlxSprite();
            Common.mouseTile.loadGraphic(Common.MapTile, true, false, 64, 64, false);
            add(Common.level);
            add(Common.mouseTile);
            add(Common.hud);
        }

        override public function update():void
        {
            var point:FlxPoint = FlxG.mouse.getWorldPosition();
            if (FlxG.mouse.justReleased())
            {
                handleClick(point);
            }
            Common.mouseTile.x = point.x - 32;
            Common.mouseTile.y = point.y - 32;
            super.update();
        }

        public function handleClick(point:FlxPoint):void
        {
            var handledTile:uint = Common.hud.handleClick(point);
            if (handledTile >= 15)
            {
                FlxG.mouse.hide();
                Common.mouseTile.frame = handledTile;
                tileType = handledTile
            }
            else
            {
                switch (handledTile)
                {
                    case 1:
                        Common.level.save();
                        break;
                    case 2:
                        Common.level.load();
                        break;
                    default:
                        break;
                }
            }
            Common.level.placeTile(point, tileType);
            if (Common.canPlaceTile == false && Common.activePoint)
            {
                Common.hud.showTileHandlers(Common.activePoint);
                Common.mouseTile.frame = 0;
                FlxG.mouse.show();
            }
        }
    }
}
