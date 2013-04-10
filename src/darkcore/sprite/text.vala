namespace Darkcore {
    namespace SpriteNS {
        public class Text : Sprite {
            public string data { get; set; default = ""; }
            public int character_height { get; set; default = 32; }
            public int character_width { get; set; default = 32; }
            public Text() {
                base();
            }
            public Text.from_texture(Engine world, int texture_index) {
                base.from_texture(world, texture_index);
            }
            
            public void set_text (string text) {
                data = text;
            }
            
            public override void render() {
                var texture = this.world.textures[this.texture_index];
                var fw = 1.00 / (texture->width / character_width);
                var no_of_chars_per_line = texture->width / character_width;
                var i = 0;
                var word = data;
                var c = word.get_char ();
                while (c != '\0') {
                    // Change the Character to an ordinal value (Ascii)
                    var ord = (int) c;
                    
                    // Find the position as to where the character is in the 
                    // texture map
                    int cy = ord / no_of_chars_per_line; 
                    int cx = ord % no_of_chars_per_line;
                    
                    this.width = 32;
                    this.height = 32;
                    
                    // Push the character over to render next to the previous
                    // character
                    this.x = 230 + (no_of_chars_per_line * i);
                    this.y = 200; // + (16 * i);
                    
                    this.coords_top_left_x = 0.00 + (fw * cx);
                    this.coords_top_left_y = 0.00 + (fw * cy);
                    
                    this.coords_bottom_left_x = fw + (fw * cx);
                    this.coords_bottom_left_y = 0.00 + (fw * cy);
                    
                    this.coords_top_right_x = 0.00 + (fw * cx);
                    this.coords_top_right_y = fw + (fw * cy);
                    
                    this.coords_bottom_right_x = fw + (fw * cx);
                    this.coords_bottom_right_y = fw + (fw * cy);
                    
                    word = word.next_char ();
                    c = word.get_char ();
                    i++;
                    base.render();
                }
            }
        }
    }
}
