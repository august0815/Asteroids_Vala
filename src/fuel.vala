using Gee;
public class Fuel : Darkcore.Sprite {
	 
  
	public bool activ=false;
	public int index;

 
    //public bool pause=false;
         
    public Fuel (ref Darkcore.Engine engine) {
        base.from_file (engine, "resources/RedBar.png");
        this.id = "Fuel";
        this.width =390.00;
        this.height = 30.00;
        this.world = engine;
        this.x = 1070;
        this.y = 8;       
		
      	 }  
        public override void on_key_press() {
		
        
       
		}
		
			
    }


   
