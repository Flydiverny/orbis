package nadilus.orbis
{
	public class GameConstants
	{
		public static const EMPTY_BLOCK:String	= "_";

		public static const SCREEN_WIDTH:uint	= 640;
		public static const SCREEN_HEIGHT:uint	= 360;
		
		public static const ORBSHOOTER_HEIGHT:uint = 25;
		public static const ORBSHOOTER_WIDTH:uint = 15;
		public static const ORBSHOOTER_RELOAD:uint = 3000;
		
		public static const GAMESCREEN_LEFT:uint = 25;
		public static const GAMESCREEN_RIGHT:uint = 25;
		
		public static const LEVEL_WIDTH:uint	= SCREEN_WIDTH-GAMESCREEN_LEFT-GAMESCREEN_RIGHT;
		public static const LEVEL_HEIGHT:uint	= SCREEN_HEIGHT-ORBSHOOTER_HEIGHT;
		
		public static const BLOCK_WIDTH:uint	= 30;
		public static const BLOCK_HEIGHT:uint	= 10;
		public static const BLOCK_SPACING:uint	= 3;
		
		public static const ORB_BONUSSCORE:uint = 200;
		
		public static const POWER:Number = 2.5;
		public static const FRICTION:Number= 0.09;
	}
}