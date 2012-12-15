package
{
    import org.flixel.FlxSprite;
    
    public class Tile extends FlxSprite
    {

        protected var left:Boolean = false;
        protected var right:Boolean = false;
        protected var top:Boolean = false;
        protected var bottom:Boolean = false;

         public function Tile(X:Number, Y:Number)
        {
            this.x = X;
            this.y = Y;
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
    }
}