
public class GameOver: Darkcore.Sprite {
	public string up { get; set; default = "up"; }
	public bool welcome_done=false;
	public bool activ;
	     
    public GameOver (ref Darkcore.Engine engine) {
        base.from_file (engine, "resources/game_over.png");
        this.id = "GameOver";
        this.width =1200.00;
        this.height = 900.00;
        this.world = engine;
        this.x = engine.width/2;
        this.y = engine.height/2;
        this.activ=true;
        var gamestate = (GameState) world.gamestate;
      	 }  
        public override void on_render(uint32 ticks) {
		
		}
	
    }


   
