package
{
    import org.flixel.*;

    public class Common
    {
        public static var TILEHEIGHT:uint = 64;
        public static var TILEWIDTH:uint = 64;
        public static var LEVELX:uint = 345;
        public static var LEVELY:uint = 40;
        public static var GRIDWIDTH:uint = 10;
        public static var GRIDHEIGHT:uint = 10;
        
        [Embed(source='../assets/tilemap.png')] public static const MapTile:Class;
        [Embed(source='../assets/logo.png')] public static const Logo:Class;
        [Embed(source='../assets/hud.png')] public static const Background:Class;
        [Embed(source='../assets/animation_spritesheet.png')] public static const Animation:Class;
        [Embed(source='../assets/title_screen.png')] public static const TitleScreen:Class;

        public static var hud:HUD;
        public static var level:Level;
        public static var mouseTile:FlxSprite;
        public static var emptyTile:Tile;

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
        public static var forestPipe1:uint = 15;
        public static var forestPipe2:uint = 19;
        public static var forestPipe3:uint = 23;
        public static var forestPipe4:uint = 27;
        public static var forestSpecial1:uint = 32;
        public static var forestSpecial2:uint = 35;
        public static var cityPipe1:uint = 37;
        public static var cityPipe2:uint = 41;
        public static var cityPipe3:uint = 45;
        public static var cityPipe4:uint = 49;
        public static var citySpecial1:uint = 54;
        public static var citySpecial2:uint = 57;
        public static var clockWiseButton:uint = 65;
        public static var counterClockButton:uint = 66;
        public static var deleteSymbol:uint = 67;

        public static var backLevel:Array = new Array(
            5,2,1,2,1,2,1,2,1,2,
            3,4,3,4,3,4,3,4,3,4,
            1,2,1,2,1,2,1,2,1,2,
            3,4,3,4,3,4,3,4,3,4,
            1,2,1,2,1,2,1,2,1,6,
            3,4,3,4,3,4,3,4,3,4,
            1,2,1,2,1,2,1,2,1,2,
            3,4,3,4,3,4,3,4,3,4,
            1,2,1,2,1,2,1,2,1,2,
            3,4,3,4,3,4,3,4,3,4);
        public static var obstacles:Array = new Array(
            0,0,7,0,0,0,0,13,0,0,
            0,0,8,0,0,0,0,14,0,0,
            0,0,0,11,12,0,0,7,0,0,
            0,0,0,0,0,0,0,8,0,0,
            7,0,0,0,0,0,0,0,0,0,
            8,0,0,13,0,0,0,0,0,0,
            0,0,0,14,0,9,10,0,0,0,
            0,0,0,0,0,0,0,0,0,0,
            0,13,0,0,0,0,0,11,12,0,
            0,14,0,0,0,0,0,0,0,0);
        public static var blank:Array = new Array(
            0,0,0,0,0,0,0,0,0,0,
            0,0,0,0,0,0,0,0,0,0,
            0,0,0,0,0,0,0,0,0,0,
            0,0,0,0,0,0,0,0,0,0,
            0,0,0,0,0,0,0,0,0,0,
            0,0,0,0,0,0,0,0,0,0,
            0,0,0,0,0,0,0,0,0,0,
            0,0,0,0,0,0,0,0,0,0,
            0,0,0,0,0,0,0,0,0,0,
            0,0,0,0,0,0,0,0,0,0);

        public function Common()
        {}
    }
}