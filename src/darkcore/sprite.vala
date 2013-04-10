using SDL;
using GL;
using GLU;

namespace Darkcore { public class Sprite : Object {
    public delegate void DelegateType (Engine world, Sprite sprite);
    public string id { get; set; default = ""; }
    public double x { get; set; default = 0.00; }
    public double y { get; set; default = 0.00; }
    public double rotation { get; set; default = 0.00; }
    public double width { get; set; default = 32.00; }
    public double height { get; set; default = 32.00; }
    public double coords_top_left_x { get; set; default = 0.00; }
    public double coords_top_left_y { get; set; default = 0.00; }
    public double coords_bottom_left_x { get; set; default = 1.00; }
    public double coords_bottom_left_y { get; set; default = 0.00; }
    public double coords_bottom_right_x { get; set; default = 1.00; }
    public double coords_bottom_right_y { get; set; default = 1.00; }
    public double coords_top_right_x { get; set; default = 0.00; }
    public double coords_top_right_y { get; set; default = 1.00; }
    public uchar color_r { get; set; default = 255; }
    public uchar color_g { get; set; default = 255; }
    public uchar color_b { get; set; default = 255; }
    public double scale_x { get; set; default = 1.00; }
    public double scale_y { get; set; default = 1.00; }
    public int texture_index { get; set; default = -1; }
    public DelegateType? on_key_press;
    public DelegateType? on_render;
    public unowned Engine world;
    
    public Sprite() {
    }
    
    public Sprite.from_file(Engine world, string filename) {
        this.world = world;
        this.texture_index = this.world.add_texture(filename);
    }
    
    public Sprite.from_texture(Engine world, int texture_index) {
        this.world = world;
        this.texture_index = texture_index;
    }
    
    public void fire_key_press(DelegateType key_press, Engine world, Sprite sprite) {
        key_press (world, sprite);
    }
    
    public void fire_render(DelegateType render, Engine world, Sprite sprite) {
        render (world, sprite);
    }
    
    public virtual void render() {
        Texture? texture = null;
        if (this.texture_index > -1) {
            glEnable(GL_TEXTURE_2D);
            texture = this.world.getTexture(this.texture_index);
        }
        if (texture != null && texture.loaded > 0) {
            glBindTexture(GL_TEXTURE_2D, texture.texture_id + 1);
                    
	        glDepthFunc(GL_LEQUAL);
	        glEnable(GL_DEPTH_TEST);
	        glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
	        glEnable(GL_BLEND);          
        }
        
        double half_width = this.width / 2;
        double half_height = this.height / 2;
        glPushMatrix();
        glTranslated(x, y, 0.00);
        
        if (scale_x != 1.00 || scale_y != 1.00) {
            glScaled(scale_x, scale_y, 1.00);
        }
        
        if (rotation != 0.00) {
            glRotated(rotation, 0.00, 0.00, 1.00);
        }
        glColor3ub((GLubyte) color_r, (GLubyte) color_g, (GLubyte) color_b);
         glBegin(GL_QUADS);
            
            glTexCoord2f((GLfloat) coords_top_left_x, (GLfloat) coords_top_left_y);
            glVertex3d(
                -half_width,
                half_height,
                1
            );
            
            glTexCoord2f((GLfloat) coords_top_right_x, (GLfloat) coords_top_right_y);
            glVertex3d(
                -half_width,
                -half_height,
                1
            );
            
            glTexCoord2f((GLfloat) coords_bottom_right_x, (GLfloat) coords_bottom_right_y);
            glVertex3d(
                half_width,
                -half_height,
                1
            );
            
            glTexCoord2f((GLfloat) coords_bottom_left_x, (GLfloat) coords_bottom_left_y);
            glVertex3d(
                half_width,
                half_height,
                1
            );
            
        glEnd();
        glPopMatrix();
        
        
        if (texture != null && texture.loaded > 0) {
	        glDisable(GL_BLEND);
	        glDisable(GL_DEPTH_TEST);    
            glBindTexture(GL_TEXTURE_2D, (GLuint) 0);
        }
        glDisable(GL_TEXTURE_2D);
    }
}}
