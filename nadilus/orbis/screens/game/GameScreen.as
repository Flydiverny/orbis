package nadilus.orbis.screens.game
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.ui.*;
	
	import nadilus.orbis.GameConstants;
	import nadilus.orbis.Utilities;
	import nadilus.orbis.data.GameData;
	import nadilus.orbis.data.Level;
	import nadilus.orbis.screens.OrbisGame;
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
		
		public function GameScreen(game:OrbisGame, gameData:GameData) {
			trace("GameScreen: GameScreen(): Called");
			this._game			= game;
			this._levels 		= gameData.gameLevels;
			this._blockTypes	= gameData.blockTypes;
			
			this._currentLvlNum	= 0;
			
			this._player		= new Player();
			this._orbShooter	= _player.orbShooter;
			
			this.graphics.beginFill( 0x0FF000, 1.0 );
			this.graphics.drawRect( 0, 0, GameConstants.SCREEN_WIDTH, GameConstants.SCREEN_HEIGHT);
			this.graphics.endFill();
			
			this.width				= GameConstants.SCREEN_WIDTH;
			this.height				= GameConstants.SCREEN_HEIGHT;
			
			this._orbShooter.x		= this.width/2;
			this._orbShooter.y		= _orbShooter.height/2-3;
			
			//this._orbShooter.rotation = 75;
			
			startNextLevel();
			
			OrbisGame.gStage.addEventListener(KeyboardEvent.KEY_DOWN, keyPressed);
			OrbisGame.gStage.addEventListener(KeyboardEvent.KEY_UP, keyReleased);
			this.addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		private function spawnOrb():void {
			
			if(orbsMag.length > 0) {
				orbsMag.pop();
				
				var orb:Orb =  new Orb(this._orbShooter.fireOrb());
	
				_currentLevel.addChild(orb);
				
				this.orbsActive.push(orb);
			}
		}
		
		private function startNextLevel():void {
			trace("GameScreen: startNextLevel(): Called");
			if(_currentLevel != null) {
				_currentLevel.removeChild(_player.platform);
				this.removeChild(_currentLevel);
				this.removeChild(_orbShooter);
			}
			
			// Draw Level
			_currentLevel = _levels[_currentLvlNum];
			_currentLevel.drawLevel(_blockTypes);
			_currentLevel.x = GameConstants.GAMESCREEN_LEFT;
			_currentLevel.y = GameConstants.ORBSHOOTER_HEIGHT;
			_currentLevel.addChild(_player.platform);
			
			// Add Platform to level
			_player.platform.x = _currentLevel.width/2-_player.platform.width/2;
			_player.platform.y = _currentLevel.height-_player.platform.height*1.5;
			
			this.orbsMag = new Array();
			this.orbsActive = new Array();
			
			for(var i:uint = 0; i < _currentLevel.initialOrbCount; i++) {
				this.orbsMag.push(new Orb(new Vect(new Point(0,0), new Point(0,0))));
				orbsMag[i].x = GameConstants.GAMESCREEN_LEFT/2;
				orbsMag[i].y = GameConstants.SCREEN_HEIGHT-orbsMag[i].height*(i+1)+10;
				this.addChild(orbsMag[i]);
			}
			
			this.addChild(_currentLevel);
			this.addChild(_orbShooter);
		}
		
		private function enterFrame(event:Event):void {
			_player.platform.movePlatform(left,right,up,down);
			
			if(left) {
				if(_player.orbShooter.rotation < 75)
					_player.orbShooter.rotation += 2;
			}
			if(right) {
				if(_player.orbShooter.rotation > -75)
					_player.orbShooter.rotation -= 2;
			}
				
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
							if(hitBlock.hitBlock()) {
								//this._currentLevel.removeChild(block);
								
								vectors.indexOf(hitBlock);
								vectors.splice(vectors.indexOf(hitBlock),1);
							}
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
					this._currentLevel.removeChild(ob);
					var index:uint = this.orbsActive.indexOf(ob);
					this.orbsActive.splice(index,1);
				}
			}
			
			for each(var orb:Orb in orbsActive) {
				orb.moveMe();
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
			
			array.push(new Vect(bottomleft, topleft));
			array.push(new Vect(topright,topleft));
			array.push(new Vect(topright,bottomright));
			array.push(new Vect(bottomleft,bottomright));
			
			return array;
		}
	}
}