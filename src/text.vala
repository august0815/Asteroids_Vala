public class FPSText : Darkcore.SpriteNS.Text {
  public int level;
  public int life;
  public int bombe;
  public int hit;
  public int fuel;
  public string aktuell;
  
    public FPSText.from_texture(Darkcore.Engine world, int texture_index, 
      ref int level, ref int life, ref int bombe, ref int hit) {
        base.from_texture(world, texture_index);
        this.level = level;
        this.life = life;
        this.bombe = bombe;
        this.hit = hit;
        this.aktuell="Level : "+level.to_string() +" Life lost: "+ life.to_string() +  " Torpedo fired : "+ bombe.to_string() + 
						" Asteroids hit : " +hit.to_string() + " Fuel : "+fuel.to_string();
    }
    
    public override void on_render (uint32 ticks) {
        data = @aktuell;
    }
    public void update(){
		this.aktuell="Level : "+level.to_string() +" Life lost: "+ life.to_string() +  " Torpedo fired : "+ bombe.to_string() + 
					" Asteroids hit : " +hit.to_string() + " Fuel : "+fuel.to_string();
		}
} 
