
public class Welcome : Darkcore.Sprite {
	public string go { get; set; default = "a"; }
	public bool welcome_done=false;
	public bool activ;
	
	public Welcome (ref Darkcore.Engine engine) {
		base.from_file (engine, "resources/welcome.png");
		this.id = "Welcome";
		this.width =1200.00;
		this.height = 900.00;
		this.world = engine;
		this.x = engine.width/2;
		this.y = engine.height/2;
		this.activ=true;
		var gamestate = (GameState) world.gamestate;
		}  
		public override void on_key_press() {
		var gamestate = (GameState) world.gamestate;
		 // keyspressed?
		if (go == "a" && world.keys.a && activ  ) {
			welcome_done=true;
			gamestate.fire_score ();
			}
		}
	
	}


   
