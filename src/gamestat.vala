using GL;

public class GameState : Object {
    public int ship_points { get; set; default = 0; }
    //public unowned Ball ball;
    public unowned Rock rock;
	public unowned Bomb bomb;
    public unowned Ship ship;
    public Darkcore.EventCallback? on_score;
    
    
    public GameState () {
        base();
    }
    
    public void ship_add_point () {
        ship_points++;
    }
    
   
    
    public void fire_score () {
        if (on_score != null) {
            on_score ();
        }
    }
    
}
