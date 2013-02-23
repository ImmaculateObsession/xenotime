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
            var startSprite:FlxSprite = new FlxSprite(100,100);
            startSprite.loadGraphic(Common.TitleScreen, true, false, 640, 640, false);

            add(startSprite)

            FlxG.stage.addEventListener(MouseEvent.CLICK, onClick);
        }

        protected function onClick(event:MouseEvent):void {
            FlxG.switchState(new Tutorial1);
        }

        override public function destroy():void {
            FlxG.stage.removeEventListener(MouseEvent.CLICK, onClick);
            super.destroy();
        }
    }
} 