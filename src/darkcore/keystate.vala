using SDL;
using GL;
using GLU;

namespace Darkcore { public class KeyState : Object {
    public bool up { get; set; default = false; }
    public bool down { get; set; default = false; }
    public bool left { get; set; default = false; }
    public bool right { get; set; default = false; }
    public bool space { get; set; default = false; }
    public bool w { get; set; default = false; }
    public bool s { get; set; default = false; }
    public KeyState() {
    
    }
    
    public bool is_up () {
        return this.up;
    }
}}
