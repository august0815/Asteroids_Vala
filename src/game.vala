using GL;
using Gee;

public class GameDemo : Object {
    public Ship ship;
    public Exp exp;
    public Rock rock;
    public Bomb bomb;
    public Laser laser;
    public Fuel fuel;
    public Reiter_fuel reiter_fuel;
    public Reiter_shild reiter_shild;
    public Shild shild;
    public Life life;
    public Welcome welcome;
    public GameOver over;
    public int lifes;
    public Torpedo torpedo;
    public Darkcore.Engine engine;
    
    public ArrayList<Rock> rocks=new  ArrayList<Rock> ();
    public GameDemo(){
        engine = new Darkcore.Engine(1260, 960);
        var state = new GameState();
        int level=0;
        lifes=0;
        
        int bombe=0;
        int hit=0;
        
        //ArrayList<Rock> rocks=new  ArrayList<Rock> ();
        var bomb_fired = new Darkcore.Sound ("resources/bomb_launch.ogg");
        engine.sounds.add (bomb_fired);
        var explode = new Darkcore.Sound ("resources/explosion.ogg");
        engine.sounds.add (explode);
        var ship_explode = new Darkcore.Sound ("resources/ship_explode.ogg");
        engine.sounds.add (ship_explode);
        var ship_laser = new Darkcore.Sound ("resources/laser.ogg");
        engine.sounds.add (ship_laser);
        var hit_sound = new Darkcore.Sound ("resources/hit.ogg");
        engine.sounds.add (hit_sound);
		// Load textures
        engine.add_texture ("resources/font.png");
        var bg=new Background (ref engine);
        engine.sprites.add (bg);
        var item_index = engine.sprites.index_of (bg);
    	engine.add_event(Darkcore.EventTypes.Render, () => {
            });
           
        // display some game variables
        var text = new FPSText.from_texture(engine, 0, ref level,  ref bombe, ref hit);
        text.set_text (""); // Testing
        //is this needed??
        //text.x = 0;//why ??
        engine.sprites.add (text);
         welcome=new Welcome (ref engine);
        engine.sprites.add (welcome);
		over= new GameOver (ref engine);
        
		
		
		

		// This must be defined outside the score event
		// If defined inside the anon on score function
		// you'd get a segment fault :(
		state.on_score = () => {
			if (welcome.welcome_done && welcome.activ){
			engine.sprites.remove (welcome);
			welcome.welcome_done=false;
			welcome.activ=false;
			engine.sprites.remove (text);
			//StatusDisplay
			fuel=new Fuel (ref engine);
			engine.sprites.add (fuel); 
			reiter_fuel=new Reiter_fuel (ref engine);
			engine.sprites.add (reiter_fuel); 
			shild=new Shild (ref engine);
			engine.sprites.add (shild); 
			reiter_shild=new Reiter_shild (ref engine);
			engine.sprites.add (reiter_shild);
			life=new Life (ref engine);
			engine.sprites.add (life);
			torpedo=new Torpedo (ref engine);
			engine.sprites.add (torpedo);
			
			ship = new Ship (ref engine);
			exp= new Exp (ref engine);
			engine.sprites.add (ship); 
			item_index = engine.sprites.index_of (ship);
			print("ITEM '%s' has Indexnumber %d\n", ship.id,item_index);
			bomb = new Bomb (ref engine);
			laser= new Laser (ref engine);
			
			start_level( 0);
			state.bomb = bomb;
			state.ship = ship;
			//is this needed??
			foreach (Rock r in rocks) {
				state.rock = r;
				}
			
			}
			
			// some event fired !
			if (ship.move){
			reiter_fuel.fuel=ship.fuel;
			
			ship.move=false;
			}
			if (ship.fired) {
			// display bomb  in the given direction
				if (!bomb.activ && !laser.activ && (bombe<8)) {
					//print_index();
					// Umrechnung zwischen Grad und Radiant
					var r = ((ship.richtung + 90) * 3.14) / 180;
					bombe ++;
					torpedo.update_bomb(bombe);
					bomb.velocity_x = Math.cos (r)*10;
					bomb.velocity_y = Math.sin (r)*10;
					bomb.x = ship.x;
					bomb.y = ship.y;
					bomb.activ = true;
					print("Bomb fires\n");
					engine.sprites.add (bomb);
					item_index = engine.sprites.index_of (bomb);
					bomb.index=item_index;
					//print_index();
					engine.sounds[0].play ();
				}
			}
			if (ship.laser_fired) {
			// display bomb  in the given direction
				if (!laser.activ && !bomb.activ) {
					print_index();
					// Umrechnung zwischen Grad und Radiant
					var r = ((ship.richtung + 90) * 3.14) / 180;
					//bombe ++;
					//text.bombe=bombe;
					//text.update();
					laser.velocity_x = Math.cos (r)*35;
					laser.velocity_y = Math.sin (r)*35;
					laser.x = ship.x;
					laser.y = ship.y;
					laser.rotation=ship.rotation;
					laser.activ = true;
					print("LASER fires\n");
					engine.sprites.add (laser);
					item_index = engine.sprites.index_of (laser);
					laser.index=item_index;
					print_index();
					engine.sounds[3].play ();
				}
			}
			
			
			if (ship.dead && !ship.pause && !exp.activ) {
				
				//print_index();
				print ("Ship died\n");
				engine.sounds[2].play ();
				 exp.activ=true;
				lifes++;
				life.update_life(lifes);
				//text.update();
				ship.pause = true;
				exp.x = ship.x;
				exp.y = ship.y;
				var index = engine.sprites.index_of (ship);
				exp.index=index;
				engine.sprites.set (index,exp);
					//print_index();
				exp.animation_start(0, 15, 60);
					engine.add_timer(() => {
					ship.fired=false;
					print("Animation Ends"+"\n");
					exp.activ=false;
					exp.animation_stop();
					ship.x = engine.width/2;
					ship.y = engine.height/2;
					engine.sprites.set (exp.index,ship);
					//print_index();
					ship.pause = false;
					ship.was_hit = false;
					ship.dead=false;
					ship.shild=100;
					exp.activ = false;
				}, 500);
			
			}
			if (ship.was_hit && !ship.pause && !exp.activ && !ship.dead) {
				reiter_shild.shild=ship.shild;
				engine.sounds[4].play ();
				
				engine.add_timer(() => {
					ship.was_hit=false;
					}, 1000);
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
				//text.update();
				engine.sounds[1].play ();
					//print_index();
				if (bomb_index>index){
				engine.sprites.remove (bomb);
					//print_index();
				engine.sprites.remove (r);
				}
				else {
				engine.sprites.remove (r);
					//print_index();
				engine.sprites.remove (bomb);
				}
				rocks.remove_at (bomb.rock_index); 
				bomb.rocks.remove_at (bomb.rock_index);
				laser.rocks.remove_at (bomb.rock_index);
				int rs=bomb.rocks.size;
				print("Rocksize"+rs.to_string()+"\n");
					if (rs==0){
					// all ? 
					bomb.game_over=true;
					//gamestate.fire_score ();
					}
				ship.rocks.remove_at (bomb.rock_index);
				bomb.explosion=false;
				print("ROCK and Bomb exploding\n");
					//print_index();
			}
			if (laser.explosion) {
				laser.x = 0;
				laser.y = 0;
				print ("Laser Exploded\n");
				var index = laser.rock_index;
				var r = rocks.get (index);
				item_index = engine.sprites.index_of (r);
				var laser_index=engine.sprites.index_of (laser);
				hit++;
				text.hit=hit;
				//text.update();
				engine.sounds[1].play ();
					//print_index();
				r.hitpoint --;
				print("Hit.point"+r.hitpoint.to_string()+"\n");
				if (r.hitpoint<1){
					if (laser_index>index){
					engine.sprites.remove (laser);
					//print_index();
					engine.sprites.remove (r);
					}
					else {
					engine.sprites.remove (r);
					//print_index();
					engine.sprites.remove (laser);
					}
					int size=rock.size;
					
					rocks.remove_at (laser.rock_index); 
					laser.rocks.remove_at (laser.rock_index);
					bomb.rocks.remove_at (laser.rock_index);
					ship.rocks.remove_at (laser.rock_index);
					
					generate_rock (ref engine,level,2,size );
				
				} else {
					engine.sprites.remove (laser);
					}
				
				int rs=laser.rocks.size;
				print("Rocksize"+rs.to_string()+"\n");
					if (rs==0){
					// all ? 
					bomb.game_over=true;
					//gamestate.fire_score ();
					}
				
				laser.explosion=false;
				print("ROCK and Laser exploding\n");
					//print_index();
			}
			if (bomb.out_of_screen){
				print("Bomb out of screen "+bomb.index.to_string()+"\n");
				//	print_index();
				bomb.x=0;
				bomb.y=0;
				bomb.out_of_screen=false;
				//var bomb_index=engine.sprites.index_of (bomb);
				
				engine.sprites.remove(bomb);
				ship.fired=false;
				bomb.activ=false;
				
				//print_index();
				}
			if (laser.out_of_screen){
				print("laser out of screen "+laser.index.to_string()+"\n");
				//	print_index();
				laser.x=0;
				laser.y=0;
				laser.out_of_screen=false;
				//var laser_index=engine.sprites.index_of (laser);
				engine.sprites.remove(laser);
				ship.laser_fired=false;
				laser.activ=false;
				
				//print_index();
				}
			
			if (bomb.game_over){
				level++;
				if (level>4){
				ship.fired=false;
				engine.sprites.remove (ship);
				engine.done=true;
				print ("Done true\n");
				//engine.sprites.remove (text);
				text.aktuell="G A M E  O V E R : YOU WIN";
				//engine.sprites.add (text);
				}
				else {
					text.level=level;
					//text.update();
					bomb.game_over=false;
					start_level(level);
					ship.levelup();
				}
			}
			if (life.game_over&&over.activ){
				print ("you loser\n");
				
				engine.sprites.add (over);
				over.activ=false;
				ship.fuel=0;
				bomb.activ = true;
				//life.animate_tile(0,5); //TODO
				engine.add_timer(() => {
				engine.done=true;
				}, 5000);
				print ("Done true\n");
			}
			
		};
        
        engine.gamestate = state;
                
        engine.run ();

    }
    public void start_level (int level){
	var anz=2+(level*2);
	var size=2+level;
	 generate_rock(ref engine ,level,anz,size);
	}
    public void generate_rock(ref Darkcore.Engine engine,int level,int anzahl,int max_size){
		//load the other sprites
		// the rocks in an array
		for (int j=0;j<anzahl;j++){
			int size =Random.int_range(1,max_size);
			rock = new Rock (ref engine,level,size);
			rock.i = j;
			engine.sprites.add (rock);
			var item_index = engine.sprites.index_of (rock);
			print("ITEM '%s' has Indexnumber %d\n", rock.id,item_index);
			rocks.add (rock);
			ship.add_rock (rock);
			bomb.add_rock (rock);
			laser.add_rock(rock);
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
