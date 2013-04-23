public class FPSText : Darkcore.SpriteNS.Text {
  public int level;
  public int life;
  public int bombe;
  public int hit;
  public int fuel;
  public string aktuell;
  
    public FPSText.from_texture(Darkcore.Engine world, int texture_index, 
      ref int level, ref int bombe, ref int hit) {
        base.from_texture(world, texture_index);
        this.level = level;
       
        this.bombe = bombe;
        this.hit = hit;
        this.id = "TEXT";
        this.aktuell="      Press space to start !!";
    }
    
    public override void on_render (uint32 ticks) {
        data = @aktuell;
    }
  
} 
