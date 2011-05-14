package nadilus.orbis.screens.stats
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import nadilus.orbis.GameConstants;
	import nadilus.orbis.screens.OrbisGame;
	import nadilus.orbis.screens.game.GameScreen;
	import nadilus.orbis.screens.game.Player;
	
	public class Victory extends MovieClip
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
		private var _orbisGame:OrbisGame;
		
		public function Victory(orbisGame:OrbisGame, gameScreen:GameScreen, player, destBlocks:uint, blocksScore:uint, bonusScore:uint, totalBounces:uint)
		{
			trace("Victory: Victory(): Called");
			this.x = GameConstants.GAMESCREEN_LEFT;
			this.y = GameConstants.ORBSHOOTER_HEIGHT;
			
			_player = player;
			_orbisGame = orbisGame;
			
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
			
			playNext = this.menuBtn;
			
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
			
			menuBtn.addEventListener(MouseEvent.CLICK, backToMenu, false, 0, true);
		}
		
		private function backToMenu(event:MouseEvent) {
			trace("Victory: backToMenu(): Called");
			menuBtn.removeEventListener(MouseEvent.CLICK, backToMenu);
			_orbisGame.runMenuScreen();
		}
		
		
	}
}