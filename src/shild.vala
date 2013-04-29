using Gee;
public class Shild : Darkcore.Sprite {
	 
  
	public bool activ=false;
	public int index;

 
    //public bool pause=false;
         
    public Shild (ref Darkcore.Engine engine) {
        base.from_file (engine, "resources/RedBar.png");
        this.id = "Shild";
        this.width =390.00;
        this.height = 30.00;
        this.world = engine;
        this.x = 1070;;
        this.y = 35;
		}  
        
    }


   
