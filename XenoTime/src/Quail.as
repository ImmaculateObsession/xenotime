package {
	import org.flixel.FlxSprite;

	public class Quail extends FlxSprite {

		protected var upAnimFrames:Array = [0,1,2,3,4,5,6,7];
        protected var downAnimFrames:Array = [8,9,10,11,12,13,14,15];
        protected var leftAnimFrames:Array = [16,17,18,19,20,21,22,23];
        protected var rightAnimFrames:Array = [24,25,26,27,28,29,30,31];
        protected var currentTile:uint = 0;

		public function Quail(X:Number, Y:Number) {
			super(X, Y);
			loadGraphic(Common.Animation, true, false, 64, 64, false);
			addAnimation('up', upAnimFrames, 10, true);
            addAnimation('down', downAnimFrames, 10, true);
            addAnimation('left', leftAnimFrames, 10, true);
            addAnimation('right', rightAnimFrames, 10, true);
		}

		override public function update():void {

			if (currentTile != (Common.path.length -1)) {
				if (Common.path[currentTile + 1].x > this.x) {
					this.x++;
					this.play('right');
				} else if (Common.path[currentTile + 1].y > this.y) {
					this.y++;
					this.play('down');
				} else if (Common.path[currentTile + 1].x < this.x) {
					this.x--;
					this.play('left');
				} else if (Common.path[currentTile + 1].y < this.y) {
					this.y--;
					this.play('up');
				}
			}

			if (this.x == (Common.path[currentTile].x + Common.TILEWIDTH)) {
				currentTile = currentTile + 1;
			} else if (this.y == (Common.path[currentTile].y + Common.TILEHEIGHT)) {
				currentTile = currentTile + 1;
			}

			super.update();
		}
	}
}