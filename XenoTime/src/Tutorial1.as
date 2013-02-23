package
{
    import org.flixel.*;

    import flash.events.MouseEvent;

    public class Tutorial1 extends FlxState
    {

        var introString = "Welcome to XenoTime. Let's introduce to the tools you'll be using to guide your people to safety"
        var mapString = "This is the game board. Here, you'll place segments of path from the forest to the city."
        var tileString = "This is a path segment. Click on it, then click where on the board you want it to go."
        var firstPlaceString = "Good! place two more and you'll have a complete path!"
        var completeString = "You've built your first path! You're on your way to saving your people."

        public function Tutorial1() {
            super();
        }

        override public function create():void {
            FlxG.mouse.show();
            var startSprite:FlxSprite = new FlxSprite(500,500);
            startSprite.loadGraphic(Common.MapTile, true, false, 64, 64, false);
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