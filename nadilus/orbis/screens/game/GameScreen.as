package nadilus.orbis.screens.game
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.ui.*;
	
	import nadilus.orbis.GameConstants;
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
			var orb:Orb =  new Orb(this._orbShooter.fireOrb());

			_currentLevel.addChild(orb);
			
			this.orbsActive.push(orb);
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
			var pp2:Point = new Point(_player.platform.x, _player.platform.y);
			var pp1:Point = new Point(_player.platform.x+_player.platform.width, _player.platform.y);
			
			var platform:Vect = new Vect(pp1,pp2);

			for(var n:int = 0; n < orbsActive.length; n++){
				var ob = orbsActive[n];
				var oc = ob;
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
						}
						else if(ob.x >= _currentLevel.centerPoint.x) {
							vectors = _currentLevel.topRightBlocks;
						}
					}
					
					else if(ob.y >= _currentLevel.centerPoint.y) {
						if(ob.x <= _currentLevel.centerPoint.x) {
							vectors = _currentLevel.bottomLeftBlocks;
						}
						else if(ob.x >= _currentLevel.centerPoint.x) {
							vectors = _currentLevel.bottomRightBlocks;
						}
					}
					
					for each(var block:Block in vectors){
						for each(var vect:Vect in block.vectors) {
							var v1:Vect = vect;
							var arr2 = Vect.b2Line (ob, v1);
							//0 point, 1 time, 2 vector to bounce from
							if(arr2[1] < arr1[1]){
								arr1 = arr2;
							}
						}
					}
					if(arr1[1] <= 1){
						//draw bounce vector
						ob.v = Vect.bounce(ob.v, arr1[2], arr1[0]);
						ob.v.p1 = arr1[0];
					}
					else {
						// Check Platform
						var v1:Vect = platform;
						var arr2 = Vect.b2Line(ob, v1);
						//0 point, 1 time, 2 vector to bounce from
						if(arr2[1] < arr1[1]){
							arr1 = arr2;
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
					ob.v.dx = Math.abs(ob.v.vx);
				}else if(ob.v.p1.x > GameConstants.LEVEL_WIDTH - ob.r){
					ob.v.dx = -Math.abs(ob.v.vx);
				}
				
				if(ob.v.p1.y < ob.r){
					ob.v.dy = Math.abs(ob.v.vy);
				}else if(ob.v.p1.y > GameConstants.LEVEL_HEIGHT - ob.r){
					ob.v.dy = -Math.abs(ob.v.vy);
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
				/*case Keyboard.SHIFT:
				changeWeapon(1);
				break;
				case Keyboard.CONTROL:
				changeWeapon(2);
				break;
				case 49:
				setWeapon(1);
				break;
				case 50:
				setWeapon(2);
				break;
				case 51:
				setWeapon(3);
				break;
				case 52:
				setWeapon(4);
				break;*/
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
	}
}