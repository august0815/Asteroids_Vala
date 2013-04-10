using Gee;
public class Ship : Darkcore.Sprite {
	public string up { get; set; default = "up"; }
    public string down { get; set; default = "down"; }
    public string left { get; set; default = "left"; }
    public string right { get; set; default = "right"; }
    public string space { get; set; default = "space"; }
    public double rot=0.25;
    public double richtung;
    public bool fired=false;
    public ArrayList<Rock> rocks;
    public bool dead=false;
    public bool pause=false;
         
    public Ship (ref Darkcore.Engine engine) {
        base.from_file (engine, "resources/ship.png");
        this.width = 64.00;
        this.height = 64.00;
        this.x = engine.width/2;
        this.y = engine.height/2;
        rocks=new  ArrayList<Rock> ();
               
        this.on_key_press = ((engine, ship) => {
			var gamestate = (GameState) engine.gamestate;
			var x = 0;
            var y = 0;
            // keyspressed?
            if (up == "up" && engine.keys.up || up == "w" && engine.keys.w) {
                y += 4;
            }
            if (down == "down" && engine.keys.down || down == "s" && engine.keys.s) {
                y -= 4;
            }
            if (right == "right" && engine.keys.right || right == "d" && engine.keys.w) {
                x += 4;
            }
            if (left == "left" && engine.keys.left || left == "a" && engine.keys.s) {
                x -= 4;
            }
            if ((space == "space" && engine.keys.space)  ) {
                fired=true;
                gamestate.fire_score ();
            }
            // in screen?
            if (this.x + x + (width / 2) >= engine.width) {
                x = 0;
            }
            else if (this.x + x - (width / 2) <= 0) {
                x = 0;
            }
            if (this.y + y + (height / 2) >= engine.height) {
                y = 0;
            }
            else if (this.y + y - (height / 2) <= 0) {
                y = 0;
            }
            
            if (!pause) {          
            this.x += x;
            this.y += y;
            rotation += rot;
            if (rotation>360) {rotation=0;}
            richtung=rotation;
			}
             
            foreach (Rock r in rocks){
						
				if (has_hit_rock (r) ){
					dead=true;
					gamestate.fire_score ();
				}
			}
			 
        }); 
        
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
