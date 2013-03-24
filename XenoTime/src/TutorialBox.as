package {
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;

	public class TutorialBox extends FlxGroup {
		protected var bubble1:FlxSprite;
		protected var bubble2:FlxSprite;
		protected var bubble3:FlxSprite;
		protected var bubble4:FlxSprite;

		public function TutorialBox(x:uint=0, y:uint=0) {
			bubble1 = new FlxSprite(150 + x, 150 + y);
			bubble1.loadGraphic(Common.Bubble1, true, false, 300, 300, false);
			bubble2 = new FlxSprite(0 + x, 150 + y);
			bubble2.loadGraphic(Common.Bubble2, true, false, 300, 300, false);
			bubble3 = new FlxSprite(150 + x, 0 + y);
			bubble3.loadGraphic(Common.Bubble3, true, false, 300, 300, false);
			bubble4 = new FlxSprite(0 + x, 0 + y);
			bubble4.loadGraphic(Common.Bubble4, true, false, 300, 300, false);

			add(bubble1);
			add(bubble2);
			add(bubble3);
			add(bubble4);
		}
	}
}