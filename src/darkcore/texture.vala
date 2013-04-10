using SDL;
using GL;
using GLU;

namespace Darkcore { public class Texture : Object {
    public Surface *surface;
    public GLuint texture;
    public GLenum texture_format;
    public int nOfColors;
    public GLsizei texture_id;
    public int loaded;
    public int width;
    public int height;

    public Texture() {
    
    }

    public Texture.from_file(string filename, Engine world) {
        this.texture_id = (GLsizei) texture_inc;
        texture_inc += 1;
        this.loaded = 0;
        
        this.surface = SDLImage.load(filename);

        if(this.surface == null) {
            print("SDL Error: '%s'\n", SDL.get_error());
        } else {
            this.surface->set_alpha(0, 0);
        	// Check that the image's width is a power of 2
        	this.width = this.surface->w;
	        if ( (this.surface->w & (this.surface->w - 1)) != 0 ) {
	            Log.write("warning: " + filename + "'s width is not a power of 2\n");
	        }
         
	        // Also check if the height is a power of 2
        	this.height = this.surface->h;
	        if ( (this.surface->h & (this.surface->h - 1)) != 0 ) {
	            Log.write("warning: " + filename + "'s height is not a power of 2\n");
	        }
     
            // get the number of channels in the SDL surface
            this.nOfColors = this.surface->format.BytesPerPixel;
            if (this.nOfColors == 4) { // contains an alpha channel
                if (this.surface->format.Rmask == 0x000000ff) {
                    this.texture_format = GL_RGBA;
                } else {
                    //this.texture_format = GL_BGRA;
                }
            } else if (this.nOfColors == 3) {    // no alpha channel
                if (this.surface->format.Rmask == 0x000000ff) {
                    this.texture_format = GL_RGB;
                } else {
                    //this.texture_format = GL_BGR;
                }
            } else {
	            Log.write("warning: the image is not truecolor..  this will probably break\n");
                // this error should not go unhandled
            }
            glEnable(GL_TEXTURE_2D);
     
            glBindTexture(GL_TEXTURE_2D, world.tids[this.texture_id]);

            glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
            glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
            
            glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
            glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);

            glTexImage2D(
                GL_TEXTURE_2D, 0, (GLint) this.nOfColors, 
                (GLsizei) this.surface->w, (GLsizei) this.surface->h,
                0, this.texture_format, GL_UNSIGNED_BYTE, this.surface->pixels
            );
            
            glDisable(GL_TEXTURE_2D);
            this.loaded = 1;
        }
    }
}}
