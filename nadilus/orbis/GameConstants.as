package nadilus.orbis
{
	public class GameConstants
	{
		public static const EMPTY_BLOCK:String	= "_";

		public static const SCREEN_WIDTH:uint	= 1280;
		public static const SCREEN_HEIGHT:uint	= 720;
		
		public static const ORBSHOOTER_HEIGHT:uint = 50;
		public static const ORBSHOOTER_WIDTH:uint = 30;
		
		public static const GAMESCREEN_LEFT:uint = 50;
		public static const GAMESCREEN_RIGHT:uint = 50;
		
		public static const LEVEL_WIDTH:uint	= SCREEN_WIDTH-GAMESCREEN_LEFT-GAMESCREEN_RIGHT;
		public static const LEVEL_HEIGHT:uint	= SCREEN_HEIGHT-ORBSHOOTER_HEIGHT;
		
		public static const BLOCK_WIDTH:uint	= 40;
		public static const BLOCK_HEIGHT:uint	= 15;
		public static const BLOCK_SPACING:uint	= 3;
	}
}