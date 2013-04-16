using Gee;
public class Exp : Darkcore.Sprite {
	 
    //public double rot=0.25;
	//public bool fired=false;
	public bool activ=false;

 
    //public bool pause=false;
         
    public Exp (ref Darkcore.Engine engine) {
        base.from_file (engine, "resources/exp2.png");
        this.width = 64.00;
        this.height = 64.00;
        this.world = engine;
        this.x = engine.width/2;
        this.y = engine.height/2;
        this.tile_width = 0.25;
        this.tile_height = 0.25;
		anima_tile (0, 0);
		
      	 }  
        public override void on_key_press() {
			
		}
		
			
    }


   
