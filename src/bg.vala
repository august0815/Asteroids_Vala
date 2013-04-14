using Gee;
public class Background : Darkcore.Sprite {
    
	public bool activ=true;
   
    public Background (ref Darkcore.Engine engine) {
        base.from_file (engine, "resources/bg.png");
        this.x = 400;//why??
        this.y = 300;//why??
        this.world = engine;
        this.width = 800.00;
        this.height = 600.00;
    }

   
    public override void on_render () {
		
   }   
}
