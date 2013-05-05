
public class Welcome : Darkcore.Sprite {
	public string go { get; set; default = "a"; }
	
	public Welcome (ref Darkcore.Engine engine) {
		base.from_file (engine, "resources/top.png");
		this.id = "Welcome";
		this.width =1024;
		this.height = 256;
		this.world = engine;
		this.x =engine.width/2;
		this.y = 870;
		}  
	
	}
