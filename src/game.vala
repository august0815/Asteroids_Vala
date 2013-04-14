using GL;
using Gee;


public class Circle : Darkcore.Sprite {
    public double radius { get; set; default = 0.00; }
    public bool activ=false;
    public override void render () {
        const double DEG2RAD = 3.14159 / 180.00;

        glPushMatrix ();
        glTranslated (x, y, 0.00);
        
        if (scale_x != 1.00 || scale_y != 1.00) {
            glScaled (scale_x, scale_y, 1.00);
        }
        
        if (rotation != 0.00) {
            glRotated (rotation, 0.00, 0.00, 1.00);
        }
        
        glColor3ub ((GLubyte) color_r, (GLubyte) color_g, (GLubyte) color_b);
        
        glLineWidth ((GL.GLfloat) 3.00);
        
        glBegin(GL_LINE_LOOP);
        for (int i=0; i < 360; i++) {
            double degInRad = i * DEG2RAD;
            glVertex2d(
                Math.cos (degInRad) * radius, Math.sin (degInRad) * radius
            );
        }
        glEnd ();
        
        glPopMatrix ();
    } 
}





public class GameDemo : Object {
    
    public GameDemo(){
        var engine = new Darkcore.Engine(800, 600);
        var state = new GameState();

		// Load textures
        engine.add_texture ("resources/font.png");
     
        
        // Add an event to the renderer
        engine.add_event(Darkcore.EventTypes.Render, () => {
            });
        
    
		var ship = new Ship (ref engine);
		engine.sprites.add (ship); 
		var plasma = new Plasma (ref engine);
		//engine.sprites.add (plasma); 
		var exp = new Exp (ref engine);
		//engine.sprites.add (exp);
		
		// This must be defined outside the score event
		// If defined inside the anon on score function
		// you'd get a segment fault :(
		 Circle c = new Circle();
        c.x = engine.width / 2;
        c.y = engine.height / 2;
        c.radius = 150.00;
        
		state.on_score = () => {
			//ball.reset_location (engine);
            //ball.pause ();
            if (ship.plasma){
			plasma.x=ship.x;//16
			plasma.y=ship.y;//16
             engine.sprites.add (plasma);
             engine.add_timer(() => {
				 ship.plasma=false;
				  engine.sprites.remove (plasma);
			}, 50);
			}
             
            if (ship.fired && !c.activ){
			c.activ=true;
			exp.activ=true;
            engine.sprites.add (c);
            print("Start animation"+"\n");
            engine.sprites.remove (ship);
				exp.dx=0;
				exp.dy=0;
            engine.sprites.add (exp);
            engine.add_timer(() => {
                ship.fired=false;
                 print("Animation Ends"+"\n");
                 c.activ=false;
                 exp.activ=false;
                 engine.sprites.add (ship);
                engine.sprites.remove (c);
                engine.sprites.remove (exp);
            }, 500);
            
		}
        
		};
        
        engine.gamestate = state;
                
        engine.run ();

    }
}
