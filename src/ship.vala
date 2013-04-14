using Gee;
public class Ship : Darkcore.Sprite {
	
    public string space { get; set; default = "space"; }
    public double rot=0.25;
	public bool fired=false;
	
 
    public bool pause=false;
         
    public Ship (ref Darkcore.Engine engine) {
        base.from_file (engine, "resources/ship.png");
        this.width = 256.00;
        this.height = 256.00;
        this.world = engine;
        this.x = engine.width/2;
        this.y = engine.height/2;
        }  
        public override void on_key_press() {
			var gamestate = (GameState) world.gamestate;
			
            if ((space == "space" && world.keys.space)  ) {
                fired=true;
                gamestate.fire_score ();
                
            }
          
            rotation += rot;
           
		}

			 
        
        
    }

   

