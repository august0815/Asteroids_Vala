using GL;
using Gee;

public class GameDemo : Object {
    public Ship ship;
    public Exp exp;
    public Rock rock;
    public Bomb bomb;
    //public Plasma plasma;
    public Darkcore.Engine engine;
    
    public ArrayList<Rock> rocks=new  ArrayList<Rock> ();
    public GameDemo(){
        engine = new Darkcore.Engine(1260, 960);
        var state = new GameState();
        int level=1;
        
        int life=0;
        int bombe=0;
        int hit=0;
        
        //ArrayList<Rock> rocks=new  ArrayList<Rock> ();
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
        var item_index = engine.sprites.index_of (bg);
    	print("ITEM '%s' has Indexnumber %d\n", bg.id,item_index);
        // Add an event to the renderer
        engine.add_event(Darkcore.EventTypes.Render, () => {
            });
        // display some game variables
        var text = new FPSText.from_texture(engine, 0, ref level, ref life, ref bombe, ref hit);
        text.set_text (""); // Testing
        //is this needed??
        //text.x = 0;//why ??
        engine.sprites.add (text);
         item_index = engine.sprites.index_of (text);
    	print("ITEM '%s' has Indexnumber %d\n", text.id,item_index);
        //engine.add_sprite (ref text);
        ship = new Ship (ref engine);
		exp= new Exp (ref engine);
		//plasma = new Plasma (ref engine);
		engine.sprites.add (ship); 
		 item_index = engine.sprites.index_of (ship);
    	print("ITEM '%s' has Indexnumber %d\n", ship.id,item_index);
		bomb = new Bomb (ref engine);
		
        start_level(ref engine , 0);
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
			if (ship.move){
			text.fuel=(int)ship.fuel;
			text.update();
			ship.move=false;
			}
			if (ship.fired) {
			// display bomb  in the given direction
				if (!bomb.activ) {
					print_index();
					// Umrechnung zwischen Grad und Radiant
					var r = ((ship.richtung + 90) * 3.14) / 180;
					bombe ++;
					text.bombe=bombe;
					text.update();
					bomb.velocity_x = Math.cos (r)*10;
					bomb.velocity_y = Math.sin (r)*10;
					bomb.x = ship.x;
					bomb.y = ship.y;
					bomb.activ = true;
					print("Bomb fires\n");
					engine.sprites.add (bomb);
					item_index = engine.sprites.index_of (bomb);
					bomb.index=item_index;
					print_index();
					engine.sounds[0].play ();
				}
			}
			
			
			if (ship.dead && !ship.pause && !exp.activ) {
				
					print_index();
				print ("Ship died\n");
				engine.sounds[2].play ();
				 exp.activ=true;
				life++;
				text.life=life;
				text.update();
				ship.pause = true;
				exp.x = ship.x;
				exp.y = ship.y;
				var index = engine.sprites.index_of (ship);
				exp.index=index;
				engine.sprites.set (index,exp);
					print_index();
				exp.animation_start(0, 15, 60);
					engine.add_timer(() => {
					ship.fired=false;
					print("Animation Ends"+"\n");
					exp.activ=false;
					exp.animation_stop();
					ship.x = engine.width/2;
					ship.y = engine.height/2;
					engine.sprites.set (exp.index,ship);
					print_index();
					ship.pause = false;
					ship.dead = false;
					exp.activ = false;
				}, 500);
				
			}
			
			if (bomb.explosion) {
				bomb.x = 0;
				bomb.y = 0;
				print ("Bomb Exploded\n");
				var index = bomb.rock_index;
				var r = rocks.get (index);
				item_index = engine.sprites.index_of (r);
				var bomb_index=engine.sprites.index_of (bomb);
				hit++;
				text.hit=hit;
				text.update();
				engine.sounds[1].play ();
					print_index();
				if (bomb_index>index){
				engine.sprites.remove (bomb);
					print_index();
				engine.sprites.remove (r);
				}
				else {
				engine.sprites.remove (r);
					print_index();
				engine.sprites.remove (bomb);
				}
				rocks.remove_at (bomb.rock_index); 
				bomb.rocks.remove_at (bomb.rock_index);
				int rs=bomb.rocks.size;
					if (rs==0){
					// all ? 
					bomb.game_over=true;
					//gamestate.fire_score ();
					}
				ship.rocks.remove_at (bomb.rock_index);
				bomb.explosion=false;
				print("ROCK and Bomb exploding\n");
					print_index();
			}
			if (bomb.out_of_screen){
				print("Bomb out of screen "+bomb.index.to_string()+"\n");
					print_index();
				bomb.x=0;
				bomb.y=0;
				bomb.out_of_screen=false;
				engine.sprites.remove  (bomb);
				ship.fired=false;
				
					print_index();
				}
			
			if (bomb.game_over){
				level++;
				if (level>4){
				ship.fired=false;
				engine.sprites.remove (ship);
				//engine.sprites.remove (text);
				text.aktuell="G A M E  O V E R : YOU WIN";
				//engine.sprites.add (text);
				}
				else {
					text.level=level;
					text.update();
					bomb.game_over=false;
					start_level(ref engine ,level);
					ship.levelup();
				}
			}
		};
        
        engine.gamestate = state;
                
        engine.run ();

    }
    public void start_level(ref Darkcore.Engine engine,int level){
		int anzahl=2+(level*2);
		//load the other sprites
		// the rocks in an array
		for (int j=0;j<anzahl;j++){
			rock = new Rock (ref engine,level);
			rock.i = j;
			engine.sprites.add (rock);
			var item_index = engine.sprites.index_of (rock);
			print("ITEM '%s' has Indexnumber %d\n", rock.id,item_index);
			rocks.add (rock);
			ship.add_rock (rock);
			bomb.add_rock (rock);
		}
	}
	public void print_index(){
	foreach(var s in engine.sprites){
		var item_index = engine.sprites.index_of (s);
		print("ITEM '%s' has Indexnumber %d\n", s.id,item_index);
		}
		print("\n");
	}
	
}
