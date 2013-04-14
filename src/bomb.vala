using Gee;
public class Bomb : Darkcore.Sprite {
    public double velocity_x;
    public double velocity_y;
    public double acceleration {
        get; set; default = 0.100;
    }
    public bool activ=false;
    public bool explosion=false;
    public ArrayList<Rock> rocks;
    public int rock_index;
    public Bomb (ref Darkcore.Engine engine) {
        base.from_file (engine, "resources/bomb.png");
        
        this.width = 16.00;
        this.height = 16.00;
        this.x = 0;//Random.int_range(1000, 90000)/100;;
        this.y = 0;//Random.int_range(1000, 90000)/100;
        this.velocity_x = 0;
        this.velocity_y = 0;
        rocks=new  ArrayList<Rock> ();
        
        this.on_render = (engine, bomb) => {
			var gamestate = (GameState) engine.gamestate;
			var half_height = height / 2.00;
            var half_width = width / 2.00;
            if (y + half_height + velocity_y >= engine.height) {
				//ship.fired=flase;
				activ=false;
				 engine.sprites.remove (this);
				}
            if (y - half_height - velocity_y <= 0) {
				//ship.fired=flase;
				activ=false;
				engine.sprites.remove (this);
            }
            if (x + half_width + velocity_x >= engine.width) {
				//ship.fired=flase;
				activ=false;
				engine.sprites.remove (this);
            }
            if (x - half_width - velocity_x <= 0) {
				//ship.fired=flase;
				activ=false;
				engine.sprites.remove (this);
            }
            int rs=rocks.size;
            foreach (Rock r in rocks){	
					
				int rrs=rocks.size;
				if (rrs==rs){
				if (has_hit_rock (r) && activ ){
					           
					rock_index=rocks.index_of (r);
					print(rock_index.to_string());
					activ=false;
					explosion=true;
					gamestate.fire_score ();
					break;
				}
				}
			}

            x += velocity_x;
            y += velocity_y;
            rotation +=1;
           
            
            
        };
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
    public void add_rock(Rock r){
		rocks.add(r);
	}
   
}
