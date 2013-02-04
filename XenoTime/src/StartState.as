package
{
    import org.flixel.*;

    import flash.events.MouseEvent;

    public class StartState extends FlxState
    {

        public function StartState() {
            super();
        }

        override public function create():void {
            FlxG.mouse.show();
            var startSprite:FlxSprite = new FlxSprite(500,500);
            startSprite.loadGraphic(Common.Logo, true, false, 100, 100, false);
            startSprite.frame = Common.cityTile;

            add(startSprite)

            FlxG.stage.addEventListener(MouseEvent.CLICK, onClick);
        }

        protected function onClick(event:MouseEvent):void {
            FlxG.switchState(new PlayState());
        }

        override public function destroy():void {
            FlxG.stage.removeEventListener(MouseEvent.CLICK, onClick);
            super.destroy();
        }
    }
} 