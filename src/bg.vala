using Gee;
public class Background : Darkcore.Sprite {
    
	public bool activ=true;
   
    public Background (ref Darkcore.Engine engine) {
        base.from_file (engine, "resources/bg.png");
        this.world = engine;
        this.width = 1260.00;
        this.height = 960.00;
        this.x = this.width/2;
        this.y = this.height/2;
        this.id = "Background";
    }

   
 
}
