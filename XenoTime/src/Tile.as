package
{
    import org.flixel.FlxSprite;
    
    public class Tile extends FlxSprite
    {
        protected var closed:Boolean = true;
        public var sides:Array;
        public var sides_copy:Array;
        protected var startFrame:uint;
        public var gridX:uint;
        public var gridY:uint;
        public var parent:Tile = null;
        public var isParent:Boolean = false;

         public function Tile(X:Number, Y:Number, Graphic:Class, tileType:uint, coordX:uint, coordY:uint)
        {
            this.x = X;
            this.y = Y;
            this.loadGraphic(Graphic, true, false, Common.TILEWIDTH, Common.TILEHEIGHT, false);
            this.frame = tileType;
            gridX = coordX;
            gridY = coordY;
            closed = true;

            // the array of sides goes (like CSS): top right bottom left)
            sides = [false, false, false, false];
        }

        public function setSides(tileType:uint):void
        {
            closed = false;
            if ((tileType == Common.forestPipe1) || (tileType == Common.cityPipe1))
            {
                sides = [false, true, false, true];
            }
            if ((tileType) == Common.forestPipe2 || (tileType == Common.cityPipe2))
            {
                sides = [false, false, true, true];
            }
            if ((tileType == Common.forestPipe3) || (tileType == Common.cityPipe4))
            {
                sides = [false, true, true, true];
            }
            if ((tileType == Common.forestPipe4) || (tileType == Common.cityPipe4))
            {
                sides = [true, true, true, true];
            }
        }

        public function rotateClockwise():void
        {
            if (this.frame == startFrame + 3)
            {
                this.frame = startFrame;
            }
            else
            {
                this.frame = this.frame + 1;
            }
            var temp:Boolean = sides[0];
            sides[0] = sides[1];
            sides[1] = sides[2];
            sides[2] = sides[3];
            sides[3] = temp;
        }

        public function rotateCounterClockwise():void
        {
            if (this.frame == startFrame)
            {
                this.frame = startFrame + 3;
            }
            else
            {
                this.frame = this.frame - 1;
            }
            var temp:Boolean = sides[0];
            sides[0] = sides[3];
            sides[3] = sides[2];
            sides[2] = sides[1];
            sides[1] = temp;
        }

        public function resetTile():void {
            this.frame = 0;
            parent = null;
            isParent = false;
            closed = true;
            sides = [false, false, false, false];
        }

        public function setFrame(tileType:uint):void
        {
            if (this.frame != tileType)
            {
                startFrame = tileType;
            }
            this.frame = tileType;
        }

        public function getType():uint
        {
            return this.frame;
        }

        public function isClosed():Boolean
        {
            return closed;
        }

        public function rightOpen():Boolean
        {
            return sides[1];
        }

        public function leftOpen():Boolean
        {
            return sides[3];
        }

        public function topOpen():Boolean
        {
            return sides[0];
        }

        public function bottomOpen():Boolean
        {
            return sides[2];
        }
    }
}
