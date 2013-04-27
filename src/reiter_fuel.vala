using Gee;
public class Reiter_fuel : Darkcore.Sprite {
	 
  
	public bool activ=false;
	public int index;
	public double fuel; 

 
    //public bool pause=false;
         
    public Reiter_fuel (ref Darkcore.Engine engine) {
        base.from_file (engine, "resources/reiter.png");
        this.id = "Reiter_Fuel";
        this.width =32.00;
        this.height = 12.00;
        this.world = engine;
        this.x = 890;
        this.y = 9;
        this.fuel=100;
        
      	 }  
        public override void on_key_press() {
		var fuelx=3.57*fuel;
		x=890+fuelx;
        
       
		}
		
			
    }


   
