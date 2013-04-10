using GL;
using Gee;

public class GameDemo : Object {
    
    public GameDemo(){
        var engine = new Darkcore.Engine(1200, 960);
        var state = new GameState();
        int anzahl=5;
        int life=0;
        int bombe=0;
        int hit=0;
        int level=1;
        ArrayList<Rock> rocks=new  ArrayList<Rock> ();
		// Load textures
        engine.add_texture ("resources/font.png");
        // Add an event to the renderer
        engine.add_event(Darkcore.EventTypes.Render, () => {
            });
        // display some game variables
        var text = new Darkcore.SpriteNS.Text.from_texture(engine, 0);
        text.on_render = (engine, self) => {
			text.data = @"Level : $level \n Life lost: $life  Torpedo fired : $bombe   Asteroids hit : $hit\n";
		};
		engine.sprites.add (text);
		//load the other sprites
		var ship = new Ship (ref engine);
		var ship_ex = new Ship_ex (ref engine);
		engine.sprites.add (ship); 
		var bomb = new Bomb (ref engine);
		// the rocks in an array
		for (int j=0;j<anzahl;j++){
		var rock = new Rock(ref engine);
		rock.i=j;
		engine.sprites.add (rock);
		rocks.add(rock);
		ship.add_rock(rock);
		bomb.add_rock(rock);
		}

		state.bomb = bomb;
		state.ship = ship;
		//is this needed??
		foreach ( Rock r in rocks){
		state.rock = r;
		}
		// This must be defined outside the score event
		// If defined inside the anon on score function
		// you'd get a segment fault :(
		state.on_score = () => {
			// some event fired !
           if (ship.fired){
			// display bomb  in the given direction
				if (!bomb.activ){
					// Umrechnung zwischen Grad und Radiant
					var r=((ship.richtung+90)*3.14)/180;
					bombe ++;
					var aa=Math.cos(r)*10;
					var ba=Math.sin(r)*10;
					bomb.x=ship.x;
					bomb.y=ship.y;
					bomb.velocity_x = aa;
					bomb.velocity_y = ba;
					bomb.activ=true;
				engine.sprites.add (bomb);
				state.ship = ship;}
			}
			
			if (ship.dead){
				life++;
				ship.pause=true;
			ship_ex.x=ship.x;
			ship_ex.y=ship.y;
				engine.sprites.remove (ship);
				engine.sprites.add (ship_ex);
			}
			
			if (bomb.explosion){
				bomb.x=10000;bomb.y=10000;
				engine.sprites.remove (bomb);
				hit++;
				var index=bomb.rock_index;
				var r=rocks.get (index);
				engine.sprites.remove (r);
				rocks.remove_at (bomb.rock_index); 
				bomb.rocks.remove_at (bomb.rock_index);
				ship.rocks.remove_at (bomb.rock_index);
				bomb.explosion=false;
				}
				
			if (ship_ex.activ && ship.dead){
			ship.pause=false;
			ship.dead=false;
			ship_ex.activ=false;
			ship.x = engine.width/2;
			ship.y = engine.height/2;
			engine.sprites.add (ship);
			engine.sprites.remove (ship_ex);
			}
			if (bomb.game_over){
						text.data = @"\nG A M E  O V E R : YOU WIN";
						ship.fired=false;
						engine.sprites.remove (ship);
			
			}
		};
        
        engine.gamestate = state;
                
        engine.run ();

    }
}
