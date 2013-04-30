using Gee;
public class Ani1 : Darkcore.Sprite {

	public bool activ=false;
	public int index;
         
    public Ani1 (ref Darkcore.Engine engine) {
        base.from_file (engine, "resources/ani7.png");
        this.id = "Explosion";
        this.width = 64.00;
        this.height = 64.00;
        this.world = engine;
        this.x = engine.width/2;
        this.y = engine.height/2;
        this.tile_width = 0.25;
        this.tile_height = 1;
		anima_tile (0, 0);
		
      	 }  
    }


   
