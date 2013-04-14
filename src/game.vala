using GL;
using Gee;



public class FPSText : Darkcore.SpriteNS.Text {
	public int level;
	public int life;
	public int bombe;
	public int hit;
	
    public FPSText.from_texture(Darkcore.Engine world, int texture_index, 
    	ref int level, ref int life, ref int bombe, ref int hit) {
        base.from_texture(world, texture_index);
        this.level = level;
        this.life = life;
        this.bombe = bombe;
        this.hit = hit;
    }
    
    public override void on_render () {
        data = @"Level : $level \n Life lost: $life  Torpedo fired : $bombe   Asteroids hit : $hit\n";
    }
}

public class GameDemo : Object {
    
    public GameDemo(){
        var engine = new Darkcore.Engine(800, 600);
        var state = new GameState();
        int anzahl=5;
        int life=0;
        int bombe=0;
        int hit=0;
        int level=1;
        ArrayList<Rock> rocks=new  ArrayList<Rock> ();
        var bomb_fired = new Darkcore.Sound ("resources/bomb_launch.ogg");
        engine.sounds.add (bomb_fired);
        var explode = new Darkcore.Sound ("resources/explosion.ogg");
        engine.sounds.add (explode);
        var ship_explode = new Darkcore.Sound ("resources/ship_explode.ogg");
        engine.sounds.add (ship_explode);
		// Load textures
        engine.add_texture ("resources/font.png");
        var bg=new Background (ref engine);
        engine.sprites.add (bg);
        // Add an event to the renderer
        engine.add_event(Darkcore.EventTypes.Render, () => {
            });
        // display some game variables
        var text = new FPSText.from_texture(engine, 0, ref level, ref life, ref bombe, ref hit);
        text.set_text (""); // Testing
        text.x = 0;
        engine.sprites.add (text);
        //engine.add_sprite (ref text);
        
		//load the other sprites
		var ship = new Ship (ref engine);
		var ship_ex = new Ship_ex (ref engine);
		engine.sprites.add (ship); 
		var bomb = new Bomb (ref engine);
		// the rocks in an array
		for (int j=0;j<anzahl;j++){
			var rock = new Rock (ref engine);
			rock.i = j;
			engine.sprites.add (rock);
			rocks.add (rock);
			ship.add_rock (rock);
			bomb.add_rock (rock);
		}

		state.bomb = bomb;
		state.ship = ship;
		//is this needed??
		foreach (Rock r in rocks) {
			state.rock = r;
		}
		// This must be defined outside the score event
		// If defined inside the anon on score function
		// you'd get a segment fault :(
		state.on_score = () => {
			// some event fired !
			if (ship.fired) {
			// display bomb  in the given direction
				if (!bomb.activ) {
					// Umrechnung zwischen Grad und Radiant
					var r = ((ship.richtung + 90) * 3.14) / 180;
					bombe ++;
					bomb.velocity_x = Math.cos (r)*10;
					bomb.velocity_y = Math.sin (r)*10;
					bomb.x = ship.x;
					bomb.y = ship.y;
					bomb.activ = true;
					engine.sprites.add (bomb);
					engine.sounds[0].play ();
				}
			}
			
			
			if (ship.dead && !ship.pause) {
				print ("Ship died\n");
				engine.sounds[2].play ();
				 
				life++;
				ship.pause = true;
				ship_ex.x = ship.x;
				ship_ex.y = ship.y;
				engine.remove_sprite (ship);
				engine.sprites.add (ship_ex);
				//ship_ex.anima_tile (0,3);
			}
			
			if (bomb.explosion) {
				bomb.x = 10000;
				bomb.y = 10000;
				print ("Bomb Exploded\n");
				engine.remove_sprite (bomb);
				hit++;
				engine.sounds[1].play ();
				var index = bomb.rock_index;
				var r = rocks.get (index);
				engine.sprites.remove (r);
				rocks.remove_at (bomb.rock_index); 
				bomb.rocks.remove_at (bomb.rock_index);
				ship.rocks.remove_at (bomb.rock_index);
				bomb.explosion=false;
			}
			if (bomb.out_of_screen){
				engine.sprites.remove (bomb);
				bomb.out_of_screen=false;
				ship.fired=false;
				}
			if (ship_ex.activ && ship.dead) {
				ship.pause = false;
				ship.dead = false;
				ship_ex.activ = false;
				ship.x = engine.width/2;
				ship.y = engine.height/2;
				//engine.sprites.add (ship);
				engine.sprites.remove (ship_ex);
			}
			if (bomb.game_over){
				text.set_text (@"\nG A M E  O V E R : YOU WIN");
				ship.fired=false;
				engine.sprites.remove (ship);
			}
		};
        
        engine.gamestate = state;
                
        engine.run ();

    }
}
