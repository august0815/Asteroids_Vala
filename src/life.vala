using Gee;
public class Life : Darkcore.Sprite {
	 
  
	public bool activ=false;
	public bool game_over;
	public int index;

   public Life (ref Darkcore.Engine engine) {
        base.from_file (engine, "resources/life.png");
        this.id = "Life";
        this.width =200.00;
        this.height = 60.00;
        this.world = engine;
        this.x = 770;
        this.y = 18;
        this.tile_width = 1;
        this.tile_height = 0.25;
        this.game_over=false;
		anima_tile (0, 0);
		
      	 }  
        public override void on_key_press() {
		}
		public void update_life(int tile){
			var gamestate = (GameState) world.gamestate;
		anima_tile (0, tile);
		if (tile>3){
			game_over=true;
			gamestate.fire_score ();
		}
		}
    }


   
