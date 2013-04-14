using Gee;
public class Exp : Darkcore.Sprite {
	 
    //public double rot=0.25;
	//public bool fired=false;
	public bool activ=false;
	public int dx;
	public int dy;
	public int delay;
 
    //public bool pause=false;
         
    public Exp (ref Darkcore.Engine engine) {
        base.from_file (engine, "resources/exp2.png");
        this.width = 64.00;
        this.height = 64.00;
        this.world = engine;
        this.x = engine.width/2;
        this.y = engine.height/2;
        this.tile_width = 0.25;
        this.tile_height = 0.25;
        this.dx=0;
        this.dy=0;
        this.delay=0;
        anima_tile (0, 0);
		
      	 }  
        public override void on_key_press() {
			var gamestate = (GameState) world.gamestate;
			 
			if (activ){
			next_anim();
			
			}
		}
		public void next_anim(){
			
			delay++;
			if (delay>20){
			//print("dy "+dy.to_string()+" dx "+dx.to_string()+"\n");
			anima_tile(dy,dx);
			delay=0;
			dx++;
			if (dx>4){ 
				dx=0;dy++;
				if (dy>4){dy=0; activ=false;}
				}
			}
		
		}
		
			
    }


   
