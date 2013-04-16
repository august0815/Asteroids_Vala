using Gee;
public class Plasma : Darkcore.Sprite {
	public string up { get; set; default = "up"; }
    public string down { get; set; default = "down"; }
    public string left { get; set; default = "left"; }
    public string right { get; set; default = "right"; }
    public string space { get; set; default = "space"; }
    public double rot=0.25;
	public bool fired=false;
	
 
    public bool pause=false;
         
    public Plasma (ref Darkcore.Engine engine) {
        base.from_file (engine, "resources/plasma.png");
        this.width = 64.00;
        this.height = 64.00;
        this.world = engine;
        this.x =0;
        this.y =0;
        }  
        public override void on_render(uint32 ticks) {
		var gamestate = (GameState) world.gamestate;
		rotation += rot;
           
		}

			 
        
        
    }

   

