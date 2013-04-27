using Gee;
public class Reiter_shild : Darkcore.Sprite {
	 
  
	public bool activ=false;
	public int index;
	public double shild; 

 
    //public bool pause=false;
         
    public Reiter_shild (ref Darkcore.Engine engine) {
        base.from_file (engine, "resources/reiter.png");
        this.id = "Reiter_shild";
        this.width =32.00;
        this.height = 12.00;
        this.world = engine;
        this.x = 890;
        this.y = 36;
        this.shild=100;
        
      	 }  
        public override void on_key_press() {
		var fuelx=3.57*shild;
		x=890+fuelx;
        
       
		}
		
			
    }


   
