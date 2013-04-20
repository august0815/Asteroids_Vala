using Gee;
public class Shild : Darkcore.Sprite {
	 
  
	public bool activ=false;
	public int index;

 
    //public bool pause=false;
         
    public Shild (ref Darkcore.Engine engine) {
        base.from_file (engine, "resources/RedBar.png");
        this.id = "Fuel";
        this.width =390.00;
        this.height = 30.00;
        this.world = engine;
        this.x = 1070;//engine.width/2;
        this.y = 35;//engine.height/2;
        //this.tile_width = 0.25;
        //this.tile_height = 0.25;
		//anima_tile (0, 0);
		
      	 }  
        public override void on_key_press() {
		
        
       
		}
		
			
    }


   
