public class Rock : Darkcore.Sprite {
    public double velocity_x;
    public double velocity_y;
    public double acceleration {
        get; set; default = 0.100;
    }
    public double rot=Random.int_range(5,30)/10;
    public int i;
     
    public Rock (ref Darkcore.Engine engine) {
        base.from_file (engine, "resources/rock.png");
        
        this.width = 64.00;
        this.height = 64.00;
        this.x = Random.int_range(1000, 90000)/100;;
        this.y = Random.int_range(1000, 90000)/100;
        this.velocity_x = Random.int_range(30, 500)/100;
        this.velocity_y = Random.int_range(30, 500)/100;
        
        this.on_render = (engine, rock) => {
			var half_height = height / 2.00;
            var half_width = width / 2.00;
            if (y + half_height + velocity_y >= engine.height) {
                velocity_y = -Math.fabs(velocity_y);
            }
            if (y - half_height - velocity_y <= 0) {
                velocity_y = Math.fabs(velocity_y);
            }
            if (x + half_width + velocity_x >= engine.width) {
                velocity_x = -Math.fabs(velocity_x);
            }
            if (x - half_width - velocity_x <= 0) {
                velocity_x = Math.fabs(velocity_x);
            }
                       
            foreach (var sprite in engine.sprites) {
                if (sprite == this) {
                    continue;
                }
                
           
            }

            x += velocity_x;
            y += velocity_y;
            
            rotation += rot;
            //print("Rock "+i.to_string()+"\n");
            
        };
    }
    
   
}
