using Gee;
public class Ship_ex : Darkcore.Sprite {
    public double velocity_x;
    public double velocity_y;
	public bool activ=false;
   
    public Ship_ex (ref Darkcore.Engine engine) {
        base.from_file (engine, "resources/ship.png");
        this.width = 64.00;
        this.height = 64.00;
        this.x = 0;
        this.y = 0;
        this.velocity_x = Random.int_range(100, 400)/100;
        this.velocity_y = Random.int_range(100, 400)/100;
		
        
        this.on_render = (engine, bomb) => {
			var gamestate = (GameState) engine.gamestate;
			var half_height = height / 2.00;
            var half_width = width / 2.00;
            if (y + half_height + velocity_y >= engine.height) {
				//ship.fired=flase;
				activ=true;
				// engine.sprites.remove (this);
				 gamestate.fire_score ();
				}
            if (y - half_height - velocity_y <= 0) {
				//ship.fired=flase;
				activ=true;
				//engine.sprites.remove (this);
				gamestate.fire_score ();
            }
            if (x + half_width + velocity_x >= engine.width) {
				//ship.fired=flase;
				activ=true;
				//engine.sprites.remove (this);
				gamestate.fire_score ();
            }
            if (x - half_width - velocity_x <= 0) {
				//ship.fired=flase;
				activ=true;
				//engine.sprites.remove (this);
				gamestate.fire_score ();
            }


            x += velocity_x;
            y += velocity_y;
           // rotation +=10;
           
            
            
        };
    }

   
}
