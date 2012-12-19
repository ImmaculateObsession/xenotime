package
{
    import org.flixel.FlxSprite;
    
    public class Tile extends FlxSprite
    {

        protected var left:Boolean = false;
        protected var right:Boolean = false;
        protected var top:Boolean = false;
        protected var bottom:Boolean = false;
        protected var startFrame:uint;

         public function Tile(X:Number, Y:Number, Graphic:Class, tileType:uint)
        {
            this.x = X;
            this.y = Y;
            this.loadGraphic(Graphic, true, false, Common.TILEWIDTH, Common.TILEHEIGHT, false);
            this.frame = tileType;
        }

        public function setSides(tileType:uint):void
        {
            if ((tileType == 15) || (tileType == 19))
            {
                left = true;
                right = true;
            }
            if ((tileType) == 16 || (tileType == 20))
            {
                left = true;
                bottom = true;
            }
            if ((tileType == 17) || (tileType == 21))
            {
                left = true;
                right = true;
                bottom = true;
            }
            if ((tileType == 18) || (tileType == 22))
            {
                left = true;
                right = true;
                bottom = true;
                top = true;
            }
        }

        public function rotateClockwise():void
        {
            if (this.frame == startFrame)
            {
                this.frame = startFrame - 3;
            }
            else
            {
                this.frame = this.frame + 1;
            }
            var temp:Boolean = top;
            top = right;
            right = bottom;
            bottom = left
            left = temp;
        }

        public function rotateCounterClockwise():void
        {
            if (this.frame == startFrame - 3)
            {
                this.frame = startFrame;
            }
            else
            {
                this.frame = this.frame - 1;
            }
            var temp:Boolean = top;
            top = left;
            left = bottom;
            bottom = right;
            right = temp;
        }

        public function setFrame(tileType:uint):void
        {
            if (this.frame == 0)
            {
                startFrame = tileType;
            }
            this.frame = tileType;
        }
    }
}