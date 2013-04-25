using Gee;
public class Torpedo : Darkcore.Sprite {
	 
  
	public bool activ=false;
	public int index;

 
    //public bool pause=false;
         
    public Torpedo (ref Darkcore.Engine engine) {
        base.from_file (engine, "resources/EmptyBar.png");
        this.id = "Torpedo";
        this.width =200.00;
        this.height = 60.00;
        this.world = engine;
        this.x = 570;//engine.width/2;
        this.y = 18;//engine.height/2;
        //this.tile_width = 0.25;
        //this.tile_height = 0.25;
		//anima_tile (0, 0);
		
      	 }  
        public override void on_key_press() {
		
        
       
		}
		
			
    }


   
