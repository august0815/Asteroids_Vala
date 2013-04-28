using Gee;
public class Torpedo : Darkcore.Sprite {
	 
  
	public bool activ=false;
	public int index;
	
  public Torpedo (ref Darkcore.Engine engine) {
        base.from_file (engine, "resources/TorpedoBar.png");
        this.id = "Torpedo";
        this.width =200.00;
        this.height = 60.00;
        this.world = engine;
        this.x = 570;
        this.y = 18;
        this.tile_width =1;
        this.tile_height = 0.125;
		anima_tile (0, 0);
		
      	 }  
       public override void on_key_press() {
		}
		public void update_bomb(int tile){
			var gamestate = (GameState) world.gamestate;
		anima_tile (0, tile);
		if (tile>7){
			anima_tile (0, 7);
			}
		}
    }


   
