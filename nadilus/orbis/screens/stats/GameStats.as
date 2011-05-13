package nadilus.orbis.screens.stats
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import nadilus.orbis.GameConstants;
	import nadilus.orbis.screens.game.GameScreen;
	import nadilus.orbis.screens.game.Player;
	import flash.display.DisplayObject;
	
	public class GameStats extends MovieClip
	{
		private var blocksScoreCountTf:TextField;
		private var blocksScoreTf:TextField;
		
		private var bonusScoreCountTf:TextField;
		private var bonusScoreBonusTf:TextField;
		private var bonusScoreTf:TextField;

		private var scoreTf:TextField;
		private var bouncesTf:TextField;
		
		private var totalScoreTf:TextField;
		private var totalBouncesTf:TextField;
		private var totalBlocksDestTf:TextField;
		
		private var playNext:DisplayObject;
		
		private var _gScreen:GameScreen;
		private var _player:Player;
		
		public function GameStats(gameScreen:GameScreen, player, destBlocks:uint, blocksScore:uint, bonusScore:uint, totalBounces:uint)
		{
			trace("GamesStats: GameStats(): Called");
			this.x = GameConstants.GAMESCREEN_LEFT;
			this.y = GameConstants.ORBSHOOTER_HEIGHT;
			
			_player = player;
			
			blocksScoreCountTf = this.blocksScoreCountTxt;
			blocksScoreTf = this.blocksScoreTxt;
			
			bonusScoreCountTf = this.bonusScoreCountTxt;
			bonusScoreBonusTf = this.bonusScoreBonusTxt;
			bonusScoreTf = this.bonusScoreTxt;
			
			scoreTf = this.scoreTxt;
			bouncesTf = this.bouncesTxt;
			
			totalScoreTf = this.totalScoreTxt;
			totalBouncesTf = this.totalBouncesTxt;
			totalBlocksDestTf = this.totalBlocksDestTxt;
			
			playNext = this.playNextBtn;
			
			_gScreen = gameScreen;
			
			blocksScoreCountTf.text = String(destBlocks);
			blocksScoreTf.text = String(blocksScore);
			
			bonusScoreCountTf.text = String(bonusScore/GameConstants.ORB_BONUSSCORE);
			bonusScoreBonusTf.text = String(GameConstants.ORB_BONUSSCORE);
			bonusScoreTf.text = String(bonusScore);
			
			scoreTf.text = String(blocksScore+bonusScore);
			bouncesTf.text = String(totalBounces);
			
			totalScoreTf.text = String(_player.totalScore);
			totalBouncesTf.text = String(_player.totalBounces);
			totalBlocksDestTf.text = String(_player.totalBlocksDestroyed);
			
			playNext.addEventListener(MouseEvent.CLICK, nextLevel, false, 0, true);
		}
		
		private function nextLevel(event:MouseEvent) {
			trace("GameStats: nextLevel(): Called");
			playNext.removeEventListener(MouseEvent.CLICK, nextLevel);
			_gScreen.nextLevel();
		}
		
		
	}
}