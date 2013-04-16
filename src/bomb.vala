using Gee;
public class Bomb : Darkcore.Sprite {
    public double velocity_x;
    public double velocity_y;
    public bool activ=false;
    public bool out_of_screen=false;
    public bool explosion=false;
    public ArrayList<Rock> rocks;
    public int rock_index;
    public bool game_over=false;
    public Bomb (ref Darkcore.Engine engine) {
        base.from_file (engine, "resources/bomb.png");
        this.id = "Bomb";
        this.width = 16.00;
        this.height = 16.00;
        this.world = engine;
        this.x = 0;//Random.int_range(1000, 90000)/100;;
        this.y = 0;//Random.int_range(1000, 90000)/100;
        this.velocity_x = 0;
        this.velocity_y = 0;
        rocks=new  ArrayList<Rock> ();
    }
    //collision test
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
    public override void on_render (uint32 ticks) {
		var gamestate = (GameState) world.gamestate;
		var half_height = height / 2.00;
        var half_width = width / 2.00;
        // test if bomb is running out of screen ?
        if (y + half_height + velocity_y >= world.height) {
			activ=false;
			out_of_screen=true;
			this.x = 0;
			this.y = 0;
			gamestate.fire_score ();
			// world.remove_sprite (this);
			 //print ("Bomb Fell Off Screen\n");
			}
        else if (y - half_height - velocity_y <= 0) {
			activ=false;
			out_of_screen=true;
			this.x = 0;
			this.y = 0;
			gamestate.fire_score ();
			//world.remove_sprite (this);
			// print ("Bomb Fell Off Screen\n");
        }
        else if (x + half_width + velocity_x >= world.width) {
			activ=false;
			out_of_screen=true;
			this.x = 0;
			this.y = 0;
			gamestate.fire_score ();
			//world.remove_sprite (this);
			// print ("Bomb Fell Off Screen\n");
        }
        else if (x - half_width - velocity_x <= 0) {
			activ=false;
			out_of_screen=true;
			this.x = 0;
			this.y = 0;
			gamestate.fire_score ();
			//world.remove_sprite (this);
			// print ("Bomb Fell Off Screen\n");
        }
        //how many rocks ?
        int rs=rocks.size;
        if (rs==0){
			// all ? 
			game_over=true;
			gamestate.fire_score ();
		}
		// test collision against bomb <->all rock
        foreach (Rock r in rocks){	
			// is one rock removed?
			int rrs=rocks.size;
			if (rrs==rs){
			if (has_hit_rock (r) && activ ){
				           
				rock_index=rocks.index_of (r);
				//print("Hit rock %s\n", rock_index.to_string());
				activ=false;
				explosion=true;
				gamestate.fire_score ();
				break;
			}
			}
		}
		//move bomb 
        x += velocity_x;
        y += velocity_y;
        rotation +=1;
		
    
    }
    public void add_rock(Rock r){
		rocks.add(r);
	}
   
}
