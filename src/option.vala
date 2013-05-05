
public class Option : Darkcore.Sprite {
	
	public bool activ;
	public double px;
	public double py;
	public bool state;
	
	public Option (ref Darkcore.Engine engine) {
		base.from_file (engine, "resources/option.png");
		this.id = "Option";
		this.width =200;
		this.height = 40;
		this.world = engine;
		this.x = 400;
		this.y = 660;
		this.activ=true;
		this.tile_width = 1;
        this.tile_height = 0.333;
       
        anima_tile(0,0);
     
		var gamestate = (GameState) world.gamestate;
		}  
		public override void on_key_press() {
		var gamestate = (GameState) world.gamestate;
		px=world.keys.mx;
		py=world.keys.my;
		state=world.keys.mouse_left;
		if (( (px>300) && (px<500)) && ((py>650)&& (py<670))){ 
				//state=true;
				anima_tile(0,1);
				if (state){
					anima_tile(0,2);
					}
			}
			else {
				anima_tile(0,0);
			}
			
		}
	
	}
