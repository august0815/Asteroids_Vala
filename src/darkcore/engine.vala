using SDL;
using SDLMixer;
using GL;
using GLU;

namespace Darkcore { public class Engine : Object {
    public delegate void DelegateType ();
    public Gee.ArrayList<EventManager> timed_events; 
    public Gee.ArrayList<EventManager> render_events; 
    public Gee.ArrayList<Texture*> textures; 
    public Gee.ArrayList<Sprite> sprites; 
    public Gee.ArrayList<int> remove_queue;  
    public Gee.ArrayList<Sound> sounds;
    public GLuint tids[32];
    public KeyState keys;
    public Sprite player;
    public unowned SDL.Screen screen;
    public bool done;
    public int width;
    public int height;
    public int frames_per_second { get; set; default = 0; }
    public double camera_x { get; set; default = 0.00; }
    public double camera_y { get; set; default = 0.00; }
    public double mouse_x { get; set; default = 0.00; }
    public double mouse_y { get; set; default = 0.00; }
    public string title { get; set; default = ""; }
    public Object gamestate;
    public int[] background_color = {255, 255, 255, 255};
    
    public Engine(int width, int height) {
        SDL.init (InitFlag.VIDEO |  InitFlag.AUDIO);
        this.textures = new Gee.ArrayList<Texture>();
        this.sprites = new Gee.ArrayList<Sprite>();
        this.remove_queue = new Gee.ArrayList<int>();
        this.sounds = new Gee.ArrayList<Sound>();
        this.timed_events = new Gee.ArrayList<Darkcore.EventManager>(); 
        this.render_events = new Gee.ArrayList<Darkcore.EventManager>(); 
        this.keys = new KeyState();
        this.width = width;
        this.height = height;
        
        this.init_video ();
    }
    
    public int add_event (EventTypes evt_type, EventCallback evt) {
        if (evt_type == EventTypes.Render) {
            var mgr = new Darkcore.EventManager ();
            mgr.add_callback (evt);
            render_events.add (mgr);
            return 1;
        }
        return -1;
    }
    
    public int add_timer (EventCallback evt, int timeout) {
        var mgr = new Darkcore.EventManager ();
        mgr.add_callback_timer (evt, timeout);
        timed_events.add (mgr);
        return 1;
    }
    
    public void process_events () {
        Event event = Event ();
        while (Event.poll (out event) == 1) {
            switch (event.type) {
            case EventType.MOUSEMOTION:
                mouse_x = event.motion.x;
                mouse_y = event.motion.y;
                break;
            case EventType.QUIT:
                this.done = true;
                break;
            case EventType.MOUSEBUTTONUP:
                print("up\n");
                this.on_mouse_event (event.button, false);
                break;
            case EventType.MOUSEBUTTONDOWN:
                print("down\n");
                this.on_mouse_event (event.button, true);
                break;
            case EventType.KEYDOWN:
                this.on_keyboard_event (event.key, true);
                break;
            case EventType.KEYUP:
                this.on_keyboard_event (event.key, false);
                break;
            }
        }
    }
    
    public double get_abs_mouse_x () {
        return mouse_x + (-1 * camera_x);
    }
    
    public double get_abs_mouse_y () {
        return (height - mouse_y) - camera_y;
    }

    public void on_mouse_event (MouseButtonEvent event, bool isdown) {
        switch (event.button) {
            case MouseButton.LEFT:
                this.keys.mouse_left = isdown;
                break;
        }
    }

    public void on_keyboard_event (KeyboardEvent event, bool isdown) {
        switch (event.keysym.sym) {
            case KeySymbol.SPACE:
                this.keys.space = isdown;
                break;
            case KeySymbol.UP:
                this.keys.up = isdown;
                break;
            case KeySymbol.DOWN:
                this.keys.down = isdown;
                break;
            case KeySymbol.LEFT:
                this.keys.left = isdown;
                break;
            case KeySymbol.RIGHT:
                this.keys.right = isdown;
                break;
            case KeySymbol.w:
                this.keys.w = isdown;
                break;
            case KeySymbol.s:
                this.keys.s = isdown;
                break;
            case KeySymbol.a:
                this.keys.a = isdown;
                break;
            case KeySymbol.d:
                this.keys.d = isdown;
                break;
            case KeySymbol.ESCAPE:
                this.done = true;
                break;
        }
        
        if (isdown && is_alt_enter (event.keysym)) {
            WindowManager.toggle_fullscreen (screen);
        }
    }

    public static bool is_alt_enter (Key key) {
        return ((key.mod & KeyModifier.LALT)!=0)
            && (key.sym == KeySymbol.RETURN
                    || key.sym == KeySymbol.KP_ENTER);
    }

    public void init_video () {
        var bpp = VideoInfo.get().vfmt.BitsPerPixel;

        SDL.GL.set_attribute(SDL.GLattr.RED_SIZE, 5);
        SDL.GL.set_attribute(SDL.GLattr.GREEN_SIZE, 5);
        SDL.GL.set_attribute(SDL.GLattr.BLUE_SIZE, 5);
        SDL.GL.set_attribute(SDL.GLattr.DEPTH_SIZE, 16);
        SDL.GL.set_attribute(SDL.GLattr.DOUBLEBUFFER, 1);

        uint32 video_flags = SurfaceFlag.OPENGL;

        this.screen = Screen.set_video_mode (this.width, this.height,
                                             bpp, video_flags);
        if (this.screen == null) {
            stderr.printf ("Could not set video mode.\n");
        }

        SDL.WindowManager.set_caption ("TODO: Allow Title", "");
        
        glShadeModel(GL_SMOOTH);
        glCullFace(GL_BACK);
        glFrontFace(GL_CCW);
        glEnable(GL_CULL_FACE);
        glClearColor(
		    this.background_color[0], this.background_color[1], 
		    this.background_color[3], this.background_color[4]
        );
        glViewport(0, 0, (GL.GLsizei) this.screen.w, (GL.GLsizei) this.screen.h);
        glMatrixMode(GL_PROJECTION);
        glLoadIdentity();
        
        glOrtho(0,this.screen.w,0,this.screen.h,-100,100);
        
        glGenTextures(32, this.tids);
        
    }
    
    public void add_sprite (Sprite item) {
    	sprites.add (item);
    }
    
    public void remove_sprite (Sprite item) {
    	var item_index = sprites.index_of (item);
    	
    	//-- Make sure we only need to remove it once.
    	if (remove_queue.index_of (item_index) > -1) {
        	remove_queue.add (sprites.index_of (item));
    	}
    }
    

    public void draw (uint32 ticks) {
        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
        glMatrixMode(GL_MODELVIEW);
        glLoadIdentity();
        // This is where the camera would translate
        glTranslated(camera_x, camera_y, -10);
        
        if (sprites != null && sprites.size > 0) {
			foreach (var sprite in sprites) {
		        sprite.on_render (ticks);
		        sprite.render (ticks);
			}
        }
        
        if (remove_queue != null && remove_queue.size > 0) {
			foreach (var sprite_index in remove_queue) {
				var item = sprites[sprite_index];
		        sprites.remove_at(sprite_index);
			}
			remove_queue.clear();
        }
        
        // Run Render Events
        foreach (var mgr in render_events) {
            mgr.call_callback();
        }
        
        SDL.GL.swap_buffers();
    }
    
    public void run () {
        this.render();
        SDLMixer.close();
        SDL.quit ();
    }

    public void render () {
        var old_time = SDL.Timer.get_ticks();
        int fps = 0;
        int minticks = 1000 / 60;

        while (!this.done) {
            var new_time = SDL.Timer.get_ticks();
            var time_since_last_frame = new_time - old_time;
            
            for (var i = 0; i < 4; i++) {
                this.process_events ();

                foreach (var sprite in this.sprites) {
                    sprite.on_key_press();
                }      

                foreach (var mgr in timed_events) {
                    var current = SDL.Timer.get_ticks();
                    
                    if (current - mgr.get_active_time () > mgr.get_timeout ()) {
                        mgr.call_callback ();
                        // Remove the event from the stack
                        timed_events.remove (mgr);
                    }
                }    
                
                SDL.Timer.delay(1000 / (60 * 6));
            }
            
            this.draw (new_time);
            fps++;
            
            SDL.Timer.delay(minticks);
                
            // If all works well you should get about 30 frames a second
            if (time_since_last_frame > 1000) {
                print("FPS: %i\n", fps);
                old_time = new_time;
                frames_per_second = fps;
                fps = 0;
            } 
        }  
    }
    
    public Texture? getTexture(int index) {
        Texture? texture = null;
        if (index < this.textures.size) {
            texture = this.textures.get(index);
        }
        
        return texture;
    }
    
    public int add_texture(string filename) {
        this.textures.add(new Texture.from_file(filename, this));
        return this.textures.size - 1;
    }
    
    public void set_background_color (int r, int g, int b, int a) {
    	this.background_color[0] = r;
    	this.background_color[1] = g;
    	this.background_color[2] = b;
    	this.background_color[3] = a;
    }
}}
