using Gee;
public class Background : Darkcore.Sprite {
    
	public bool activ=true;
   
    public Background (ref Darkcore.Engine engine) {
        base.from_file (engine, "resources/bg.png");
        this.x = 0;
        this.y = 0;
        this.world = engine;
    }

   
    public override void on_render () {
		
   }   
}
