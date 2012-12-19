package
{
    import org.flixel.*;

    public class Common
    {
        public static var TILEHEIGHT:uint = 64;
        public static var TILEWIDTH:uint = 64;
        [Embed(source='../assets/tilemap.png')] public static const MapTile:Class;

        public static var hud:HUD;
        public static var level:Level;
        public static var mouseTile:FlxSprite;

        public static var background:PlayGrid;
        public static var obstacleMap:PlayGrid;
        public static var playerGrid:PlayGrid;

        public static var canPlaceTile:Boolean = false;
        public static var activePoint:FlxPoint;

        public static var blankTile:uint = 0;
        public static var bgTile1:uint = 1;
        public static var bgTile2:uint = 2;
        public static var bgTile3:uint = 3;
        public static var bgTile4:uint = 4;
        public static var forestTile:uint = 5;
        public static var cityTile:uint = 6;
        public static var forestObstacle11:uint = 7;
        public static var forestObstacle12:uint = 8;
        public static var forestObstacle21:uint = 9;
        public static var forestObstacle22:uint = 10;
        public static var cityObstacle11:uint = 11;
        public static var cityObstacle12:uint = 12;
        public static var cityObstacle21:uint = 13;
        public static var cityObstacle22:uint = 14;
        public static var forestPipe1:uint = 18;
        public static var forestPipe2:uint = 22;
        public static var forestPipe3:uint = 26;
        public static var forestPipe4:uint = 30;
        public static var forestSpecial1:uint = 32;
        public static var forestSpecial2:uint = 35;
        public static var cityPipe1:uint = 40;
        public static var cityPipe2:uint = 44;
        public static var cityPipe3:uint = 48;
        public static var cityPipe4:uint = 52;
        public static var citySpecial1:uint = 54;
        public static var citySpecial2:uint = 57;
        public static var clockWiseButton:uint = 59;
        public static var counterClockButton:uint = 60;
        public static var coin:uint = 61;

        public function Common()
        {}
    }
}