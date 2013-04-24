using Gee;
public class Ship : Darkcore.Sprite {
	public string up { get; set; default = "up"; }
    public string down { get; set; default = "down"; }
    public string left { get; set; default = "left"; }
    public string right { get; set; default = "right"; }
    public string space { get; set; default = "space"; }
    public string lf { get; set; default = "w"; }
    public double rot=0;
    public double richtung;
    public bool fired=false;
    public bool laser_fired=false;
    public ArrayList<Rock> rocks;
    public bool dead=false;
    public bool pause=false;
    public double fuel;
    public bool move;
    public bool flip;
    public double dx;
    public double dy;
         
    public Ship (ref Darkcore.Engine engine) {
		base.from_file(engine ,"resources/ship.png");
        this.world = engine;
        this.width = 64.00;
        this.height = 64.00;
        this.x = engine.width/2;
        this.y = engine.height/2;
        this.dx=0;
        this.dy=0;
        
        rocks=new  ArrayList<Rock> ();
        this.fuel=100;//prozent
        this.tile_width = 0.5;
        this.tile_height = 1;
        this.flip=true;
        anima_tile(0,0);
        this.id = "Ship";
    }
		
        public bool has_hit_rock (Darkcore.Sprite sprite) {
        var circle_vector = new Darkcore.Vector(2);
        circle_vector.set (0, x);
        circle_vector.set (1, y);
        
        
        var min_vector = new Darkcore.Vector(2);
        var max_vector = new Darkcore.Vector(2);
        
        // Bottom Left
        min_vector.set (0, sprite.x - (sprite.width / 5));
        min_vector.set (1, sprite.y - (sprite.height / 5));
        
        // Top Right
        max_vector.set (0, sprite.x + (sprite.width / 5));
        max_vector.set (1, sprite.y + (sprite.height / 5));
        
        var hit = Darkcore.Collision.circle_in_rectangle (
            min_vector,
            max_vector,
            circle_vector,
            width / 2.00
        );
        
        return hit;
    }
    
    
    public override void on_key_press() {
		var gamestate = (GameState) world.gamestate;
		 // keyspressed?
        if ((up == "up" && world.keys.up || up == "w" && world.keys.w) && (fuel>0)&&!move) {
            animate(3);
        }
        if ((down == "down" && world.keys.down || down == "s" && world.keys.s) && (fuel>0)&&!move) {
           
            animate(-3);
          }
        if ((right == "right" && world.keys.right || right == "d" && world.keys.w) && (fuel>0)&&!move) {
            rot = -2;
			}
        if ((left == "left" && world.keys.left || left == "a" && world.keys.s) && (fuel>0)&&!move) {
            rot = 2;
            }
        if ((space == "space" && world.keys.space)  ) {
            laser_fired=true;
            gamestate.fire_score ();
            laser_fired=false;
        }
        if ((lf == "w" && world.keys.w)  ) {
			fired=true;
            gamestate.fire_score ();
            fired=false;
        }
        // in screen?
        if (this.x + dx + (width / 2) >= world.width) {
            dx = 0;
        }
        else if (this.x + dx - (width / 2) <= 0) {
            dx = 0;
        }
        if (this.y + dy + (height / 2) >= world.height) {
            dy = 0;
        }
        else if (this.y + dy - (height / 2) <= 0) {
            dy = 0;
        }
        
        if (!pause) {          
        this.x += dx;
        this.y += dy;
        rotation += rot;
        if (rotation>360) {rotation=0;}
        richtung=rotation;
        rot=0;
        dx=0;dy=0;
		}
         
        foreach (Rock r in rocks){
					
			if (has_hit_rock (r) ){
				dead=true;
				gamestate.fire_score ();
			}
		}
    }
    
    public void add_rock(Rock r){
		rocks.add(r);
	}
	public void levelup(){
		//rot=rot + 0.02;
	}
	public void animate(int go){
			var r = ((richtung + 90) * 3.14) / 180;
			dx = Math.cos (r)*go;
			dy = Math.sin (r)*go;
			if (flip){flip=false;
			animation_start(0, 1, 40);
			}
			else{flip=true;
			animation_stop();
			}
			var gamestate = (GameState) world.gamestate;
			//for (int i=0;i<50000;i++){var j=0;}
			//print(flip.to_string()+"\n");
		    fuel= fuel-0.01;
            move=true;
            
            gamestate.fire_score ();
            }
}
