using Gee;
public class Ship : Darkcore.Sprite {
	public string up { get; set; default = "up"; }
    public string down { get; set; default = "down"; }
    public string left { get; set; default = "left"; }
    public string right { get; set; default = "right"; }
    public string space { get; set; default = "space"; }
    public double rot=0.25;
	public bool fired=false;
	public bool plasma;
	
 
    public bool pause=false;
         
    public Ship (ref Darkcore.Engine engine) {
        base.from_file (engine, "resources/ship.png");
        this.width = 64.00;
        this.height = 64.00;
        this.world = engine;
        this.x = engine.width/2;
        this.y = engine.height/2;
        this.plasma=false;
        }  
        public override void on_key_press() {
			var gamestate = (GameState) world.gamestate;
			        // keyspressed?
        if ((up == "up" && world.keys.up || up == "w" && world.keys.w)&&!plasma) {
           
            plasma=true;
            gamestate.fire_score ();
        }
            if ((space == "space" && world.keys.space)  ) {
                fired=true;
                gamestate.fire_score ();
                
            }
          
            //rotation += rot;
           
		}

			 
        
        
    }

   

