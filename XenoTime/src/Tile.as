package
{
    import org.flixel.FlxSprite;
    
    public class Tile extends FlxSprite
    {

        protected var left:Boolean = false;
        protected var right:Boolean = false;
        protected var top:Boolean = false;
        protected var bottom:Boolean = false;
        protected var closed:Boolean = true;
        protected var startFrame:uint;
        public var gridX:uint;
        public var gridY:uint;

         public function Tile(X:Number, Y:Number, Graphic:Class, tileType:uint, coordX:uint, coordY:uint)
        {
            this.x = X;
            this.y = Y;
            this.loadGraphic(Graphic, true, false, Common.TILEWIDTH, Common.TILEHEIGHT, false);
            this.frame = tileType;
            gridX = coordX;
            gridY = coordY;
        }

        public function setSides(tileType:uint):void
        {
            if ((tileType == Common.forestPipe1) || (tileType == Common.cityPipe1))
            {
                closed = false;
                left = true;
                right = true;
            }
            if ((tileType) == Common.forestPipe2 || (tileType == Common.cityPipe2))
            {
                closed = false;
                left = true;
                bottom = true;
            }
            if ((tileType == Common.forestPipe3) || (tileType == Common.cityPipe4))
            {
                closed = false;
                left = true;
                right = true;
                bottom = true;
            }
            if ((tileType == Common.forestPipe4) || (tileType == Common.cityPipe4))
            {
                closed = false;
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
            if (this.frame != tileType)
            {
                startFrame = tileType;
            }
            this.frame = tileType;
        }

        public function isClosed():Boolean
        {
            return closed;
        }

        public function rightOpen():Boolean
        {
            return right;
        }

        public function leftOpen():Boolean
        {
            return left;
        }

        public function topOpen():Boolean
        {
            return top;
        }

        public function bottomOpen():Boolean
        {
            return bottom;
        }
    }
}
