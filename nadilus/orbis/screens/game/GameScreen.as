package nadilus.orbis.screens.game
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.ui.*;
	
	import nadilus.orbis.GameConstants;
	import nadilus.orbis.Utilities;
	import nadilus.orbis.data.GameData;
	import nadilus.orbis.data.Level;
	import nadilus.orbis.screens.OrbisGame;
	import nadilus.orbis.screens.stats.GameStats;
	import nadilus.orbis.vector.Vect;
	
	public class GameScreen extends Sprite
	{
		private var _game:OrbisGame;
		private var _levels:Array;
		private var _blockTypes:Object;
		
		private var _currentLvlNum:uint;
		private var _currentLevel:Level;
		
		private var _player:Player;
		private var _orbShooter:OrbShooter;
		
		// Keys
		private var left:Boolean = false;
		private var right:Boolean = false;
		private var up:Boolean = false;
		private var down:Boolean = false;
		private var space:Boolean = false;
		
		private var orbsMag:Array;
		
		private var orbsActive:Array;
		
		private var curScoreText:TextField;
		private var goalScoreText:TextField;
		
		//Time
		private var lastOrbSpawn:Number = 0;
		
		private var curBounces:uint;
		private var curBlocksDestroyed:uint;
		private var curScore:uint;
		private var curBonusScore:uint;
		
		private var _activeMC:MovieClip;
		
		private var _nextMapBtn:TextField;
		
		private var orbsLost:uint;
		
		private var gs:GameStats;
		
		public function GameScreen(game:OrbisGame, gameData:GameData, player:Player) {
			trace("GameScreen: GameScreen(): Called");
			this._game			= game;
			this._levels 		= gameData.gameLevels;
			this._blockTypes	= gameData.blockTypes;
						
			this._player		= player;
			this._orbShooter	= _player.orbShooter;
			
			this.graphics.beginFill( 0x333333, 1.0 );
			this.graphics.drawRect( 0, 0, GameConstants.SCREEN_WIDTH, GameConstants.SCREEN_HEIGHT);
			this.graphics.endFill();
			
			this._currentLvlNum	= 0;
			
			this.width				= GameConstants.SCREEN_WIDTH;
			this.height				= GameConstants.SCREEN_HEIGHT;
			
			this._orbShooter.x		= this.width/2;
			this._orbShooter.y		= _orbShooter.height/2-3;
			
			setUpTexts();
													
			startNextLevel();
			
			_game.gStage.addEventListener(KeyboardEvent.KEY_DOWN, keyPressed);
			_game.gStage.addEventListener(KeyboardEvent.KEY_UP, keyReleased);
		}
		
		private function setUpTexts():void {
			trace("GameScreen: setUpTexts(): Called");
			var currentText:TextField = new TextField();
			var goalText:TextField = new TextField();
			this.goalScoreText = new TextField();
			_nextMapBtn = new TextField();
						
			// curScoreText
			this.curScoreText = new TextField();
			this.curScoreText.width = 120/2;
			this.curScoreText.height = GameConstants.ORBSHOOTER_HEIGHT;
			this.curScoreText.x = GameConstants.SCREEN_WIDTH-curScoreText.width-GameConstants.GAMESCREEN_RIGHT;
			this.curScoreText.y = 0;
			
			//Format
			var format:TextFormat = new TextFormat();
			format.font = "DS-Digital";
			format.color = 0xFF0000;
			format.size = 45/2;
			format.align = flash.text.TextFormatAlign.RIGHT;
			
			var left:TextFormat = new TextFormat();
			left.font = "DS-Digital";
			left.color = 0x00FF00;
			left.size = 45/2;
			left.align = flash.text.TextFormatAlign.LEFT;
			
			this.curScoreText.defaultTextFormat = format;
			this.goalScoreText.defaultTextFormat = format;
			currentText.defaultTextFormat = format;
			goalText.defaultTextFormat = format;
			
			_nextMapBtn.defaultTextFormat = left;
			
			// currentText
			currentText.height = curScoreText.height;
			currentText.text = "Current";
			currentText.width = 165/2;
			currentText.x = curScoreText.x - currentText.width;
			currentText.y = curScoreText.y;
			
			
			// goalScoreText
			
			this.goalScoreText.width = curScoreText.width;
			this.goalScoreText.height = curScoreText.height;
			this.goalScoreText.x = currentText.x - goalScoreText.width - 20/2;
			this.goalScoreText.y = curScoreText.y;
			
			// goalText
			goalText.height = goalText.height;
			goalText.text = "Goal";
			goalText.width = 100/2;
			goalText.x = goalScoreText.x - goalText.width;
			goalText.y = goalScoreText.y;
			
			_nextMapBtn.text = "Click for Next Level";
			_nextMapBtn.x = GameConstants.GAMESCREEN_LEFT;
			_nextMapBtn.y = 0;
			_nextMapBtn.width = this.width-GameConstants.GAMESCREEN_LEFT-GameConstants.ORBSHOOTER_WIDTH/2;
			_nextMapBtn.visible = false;
			_nextMapBtn.addEventListener(MouseEvent.CLICK, skipMap, false, 0, true);
			
			
			//add
			this.addChild(curScoreText);
			this.addChild(currentText);
			this.addChild(goalScoreText);
			this.addChild(goalText);
			this.addChild(_nextMapBtn);
		}
		
		private function skipMap(e:MouseEvent):void {
			trace("GameScreen: skipMap(): Called");
			_nextMapBtn.visible=false;
			gameOver();
		}
		
		private function spawnOrb():void {
			trace("GameScreen: spawnOrb(): Called");
			if(orbsMag.length > 0) {
				var time:Number = Utilities.getTime();
				if((lastOrbSpawn + GameConstants.ORBSHOOTER_RELOAD/orbsMag.length*2) < time) {
					lastOrbSpawn = time;
					this.removeChild(orbsMag.pop());
					
					var orb:Orb =  new Orb(this._orbShooter.fireOrb());
		
					_currentLevel.addChild(orb);
					this.orbsActive.push(orb);
				}
			}
		}
		
		public function nextLevel():void {
			if(_currentLvlNum < _levels.length) {
				startNextLevel();
			}
		}
		
		private function startNextLevel():void {
			trace("GameScreen: startNextLevel(): Called");
			if(_currentLevel != null) {
				_currentLevel.removeChild(_player.platform);
				if(_activeMC != null)
					this.removeChild(_activeMC);
				
				if(gs != null) {
					this.removeChild(gs);
					gs = null;
				}
				this.removeChild(_orbShooter);
				
				for each(var ob:Orb in this.orbsMag) {
					this.removeChild(ob);
				}
			}
			
			// Draw Level
			_currentLevel = _levels[_currentLvlNum];
			_currentLevel.drawLevel(_blockTypes);
			_currentLevel.x = GameConstants.GAMESCREEN_LEFT;
			_currentLevel.y = GameConstants.ORBSHOOTER_HEIGHT;
			_currentLevel.addChild(_player.platform);
			
			this.curScoreText.text = "0";			
			this.goalScoreText.text = String(_currentLevel.scoreToWin);	
			// Add Platform to level
			_player.platform.x = _currentLevel.width/2-_player.platform.width/2;
			_player.platform.y = _currentLevel.height-_player.platform.height*1.5;
			
			this.orbsMag = new Array();
			this.orbsActive = new Array();
			
			for(var i:uint = 0; i < _currentLevel.initialOrbCount; i++) {
				this.orbsMag.push(new Orb(new Vect(new Point(0,0), new Point(0,0))));
				orbsMag[i].x = GameConstants.GAMESCREEN_LEFT/2;
				orbsMag[i].y = GameConstants.SCREEN_HEIGHT-(orbsMag[i].height+5)*(i+1);
				this.addChild(orbsMag[i]);
			}
			
			_activeMC = _currentLevel;
			
			_currentLvlNum++;
			curBounces = 0;
			curBlocksDestroyed = 0;
			curScore = 0;
			curBonusScore = 0;
			
			var format:TextFormat = new TextFormat();
			format.color = 0xFF0000;
			this.curScoreText.defaultTextFormat = format;
			
			this._nextMapBtn.visible = false;
			
			this.addChild(_activeMC);
			this.addChild(_orbShooter);
			this.addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		private function enterFrame(event:Event):void {
			_player.platform.movePlatform(left,right);
			_player.orbShooter.rotateOrbshooter(left,right);
						
			/*if(up) {
				if(_player.orbShooter.rotation < 75)
					_player.orbShooter.rotation += 2;
			}
			if(down) {
				if(_player.orbShooter.rotation > -75)
					_player.orbShooter.rotation -= 2;
			}*/
				
			if(space) {
				spawnOrb();
			}
			
			
			handleOrbs();
		}
		
		private function handleOrbs():void {
			checkCollission();
		}
		
		private function checkCollission():void {
			var platform:Array = getPlatformVectors();

			for(var n:int = 0; n < orbsActive.length; n++){
				var ob:Orb = orbsActive[n];
				var oc:Orb = ob;
				//intersection with walls
				var arr1 = new Array(0, 1000000, 0);
				for(var m:int = n + 1; m < orbsActive.length; m++){
					var arr2 = Vect.b2Ball(ob, orbsActive[m]);
					//0 point, 1 time, 2 vector to bounce from
					if(arr2[1] < arr1[1]){
						arr1 = arr2;
						oc = orbsActive[m];
					}
				}
				var t = arr1[1];
				if(t <= 1){
					if(t == 0){
						var p1:Point = arr1[0];
						var p2:Point = arr1[2];
					}else{
						p1 = new Point(ob.v.p0.x + ob.v.vx * t, ob.v.p0.y + ob.v.vy * t);
						p2 = new Point(oc.v.p0.x + oc.v.vx * t, oc.v.p0.y + oc.v.vy * t);
					}
					
					var v:Vect = new Vect(p2, p1);
					var vn:Vect = Vect.vFrom1Point(v.p0, v.lx, v.ly);
					var proj1a:Vect = Vect.projectVector(ob.v, v);
					var proj1b:Vect = Vect.projectVector(ob.v, vn);
					var proj2a:Vect = Vect.projectVector(oc.v, v);
					var proj2b:Vect = Vect.projectVector(oc.v, vn);
					ob.v.p1 = p1;
					oc.v.p1 = p2;
					ob.v = Vect.vFrom1Point(p1, proj2a.vx + proj1b.vx, proj2a.vy + proj1b.vy);
					oc.v = Vect.vFrom1Point(p2, proj1a.vx + proj2b.vx, proj1a.vy + proj2b.vy);
					//n = 0;
				}
				else {
					// Check Blocks
					var vectors:Array;
					
					if(ob.y <= _currentLevel.centerPoint.y) {
						if(ob.x <= _currentLevel.centerPoint.x) {
							vectors = _currentLevel.topLeftBlocks;
							//Utilities.setHue(ob, 55);
						}
						if(ob.x >= _currentLevel.centerPoint.x) {
							vectors = _currentLevel.topRightBlocks;
							//Utilities.setHue(ob, 105);
						}
					}
					
					else if(ob.y >= _currentLevel.centerPoint.y) {
						if(ob.x <= _currentLevel.centerPoint.x) {
							vectors = _currentLevel.bottomLeftBlocks;
							//Utilities.setHue(ob, 155);
						}
						if(ob.x >= _currentLevel.centerPoint.x) {
							vectors = _currentLevel.bottomRightBlocks;
							//Utilities.setHue(ob, 205);
						}
					}
					
					var hitBlock:Block = null;
					
					for each(var block:Block in vectors){
						if(block.vectors != null) {
							for each(var vect:Vect in block.vectors) {
								var v1:Vect = vect;
								var arr2 = Vect.b2Line(ob, v1);
								//0 point, 1 time, 2 vector to bounce from
								if(arr2[1] < arr1[1]){
									arr1 = arr2;
									hitBlock = block;
								}
							}
						}
					}
					if(arr1[1] <= 1){
				        //draw bounce vector
						ob.v = Vect.bounce(ob.v, arr1[2], arr1[0]);
						ob.v.p1 = arr1[0];
						if(hitBlock != null) {
							
							var dest:Boolean = hitBlock.hitBlock();
							
							if(dest) {
								vectors.indexOf(hitBlock);
								vectors.splice(vectors.indexOf(hitBlock),1);
							}
							
							blockHit(hitBlock,dest);
						}
					}
					else {
						// Check Platform
						for each(var platVect in platform) {
							var v1:Vect = platVect;
							var arr2 = Vect.b2Line(ob, v1);
							//0 point, 1 time, 2 vector to bounce from
							if(arr2[1] < arr1[1]){
								arr1 = arr2;
							}
						}
						
						if(arr1[1] <= 1){
							//draw bounce vector
							ob.v = Vect.bounce(ob.v, arr1[2], arr1[0]);
							ob.v.p1 = arr1[0];
						}
					}
				}
				
				//edges
				if(ob.v.p1.x < ob.r){
					ob.v.dx = Math.abs(ob.v.dx);
				}else if(ob.v.p1.x > GameConstants.LEVEL_WIDTH - ob.r){
					ob.v.dx = -Math.abs(ob.v.dx);
				}
				
				if(ob.v.p1.y < ob.r){
					ob.v.dy = Math.abs(ob.v.dy);
				}else if(ob.v.p1.y > GameConstants.LEVEL_HEIGHT){
					//ob.v.dy = -Math.abs(ob.v.dy);
					removeOrb(ob);
				}
			}
			
			for each(var orb:Orb in orbsActive) {
				orb.moveMe();
			}
		}
		
		private function blockHit(block:Block, destroyed:Boolean):void {
			trace("GameScreen: blockHit(): Called: " + block + " " + destroyed);
			this.curBounces++;
			if(destroyed) {
				this.curBlocksDestroyed++;
				this.curScore += block.blockType.score;
				
				if(this.curScore >= _currentLevel.scoreToWin) {
					var format:TextFormat = new TextFormat();
					format.color = 0x00FF00;
					this.curScoreText.defaultTextFormat = format;
					this._nextMapBtn.visible = true;
				}
				
				this.curScoreText.text = String(curScore);
				
				if(this.curBlocksDestroyed == _currentLevel.amountDestroyableBlocks) {
					gameOver();
				}
			}
		}
		
		private function removeOrb(ob:Orb):void {
			this._currentLevel.removeChild(ob);
			var index:uint = this.orbsActive.indexOf(ob);
			this.orbsActive.splice(index,1);
			
			if(this.orbsMag.length == 0 || this.orbsLost > _currentLevel.maxOrbsToLose) {
				if(this.orbsActive.length == 0) {
					gameOver();
				}
			}
		}
		
		private function gameOver():void {
			trace("GameScreen: gameOver(): Called");
			if(this.curScore >= _currentLevel.scoreToWin) {
				this.removeEventListener(Event.ENTER_FRAME, enterFrame);
				
				for each(var orb:Orb in this.orbsActive) {
					curBonusScore += GameConstants.ORB_BONUSSCORE;
					this.curScoreText.text = String(this.curScore + this.curBonusScore);
				}
				
				_player.addBounces(this.curBounces);
				_player.addBlocksDestroyed(this.curBlocksDestroyed);
				_player.addTotalScore(this.curScore + this.curBonusScore);
				
				gs = new GameStats(this, this._player, this.curBlocksDestroyed,this.curScore, this.curBonusScore, this.curBounces);
				
				this.addChild(gs);
			}
		}
		
		private function keyPressed(event:KeyboardEvent):void {
			switch(event.keyCode) {
				case 37: 
					left = true;
					break;
				case 39:
					right = true;
					break;
				case 38:
					up = true;
					break;
				case 40:
					down = true;
					break;
				case Keyboard.SPACE:
					space = true;
					break;
			}
		}
		
		private function keyReleased(event:KeyboardEvent):void {
			switch(event.keyCode) {
				case 37: 
					left = false;
					break;
				case 39:
					right = false;
					break;
				case 38:
					up = false;
					break;
				case 40:
					down = false;
					break;
				case Keyboard.SPACE:
					space = false;
					break;
			}
		}
		
		private function getPlatformVectors():Array {
			var array:Array = new Array();
			var topleft:Point = new Point(_player.platform.x, _player.platform.y);
			var bottomleft:Point = new Point(_player.platform.x, _player.platform.y+_player.platform.height);
			var topright:Point = new Point(_player.platform.x+_player.platform.width, _player.platform.y);
			var bottomright:Point = new Point(_player.platform.x+_player.platform.width, _player.platform.y+_player.platform.height);
			
			array.push(new Vect(topleft, bottomleft));
			array.push(new Vect(topright,topleft));
			array.push(new Vect(topright,bottomright));
			array.push(new Vect(bottomleft,bottomright));
			
			return array;
		}
	}
}