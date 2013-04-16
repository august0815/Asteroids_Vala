public class Rock : Darkcore.Sprite {
    public double velocity_x;
    public double velocity_y;
    public double acceleration {
        get; set; default = 0.100;
    }
    public double rot=Random.int_range(5,30)/10;
    public int i;
     
    public Rock (ref Darkcore.Engine engine,int level) {
        var rock_sprite=engine.add_texture ("resources/rock.png");
        base.from_texture(engine ,rock_sprite);
        this.width = 64.00;
        this.height = 64.00;
        this.world = engine;
        this.x = Random.int_range(1000, 90000)/100;;
        this.y = Random.int_range(1000, 90000)/100;
        this.velocity_x = Random.int_range(30, 500+(100*level))/100;
        this.velocity_y = Random.int_range(30, 500+(100*level))/100;
    }
    
    public override void on_render (uint32 ticks) {
		var half_height = height / 2.00;
        var half_width = width / 2.00;
        // test if rock hits the screen border
        if (y + half_height + velocity_y >= world.height) {
            velocity_y = -Math.fabs(velocity_y);
        }
        if (y - half_height - velocity_y <= 0) {
            velocity_y = Math.fabs(velocity_y);
        }
        if (x + half_width + velocity_x >= world.width) {
            velocity_x = -Math.fabs(velocity_x);
        }
        if (x - half_width - velocity_x <= 0) {
            velocity_x = Math.fabs(velocity_x);
        }
                   
     
        x += velocity_x;
        y += velocity_y;
        
        rotation += rot;
    }
    
   
}
