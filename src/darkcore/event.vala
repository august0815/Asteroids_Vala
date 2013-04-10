using SDL;

namespace Darkcore {
    public enum EventTypes {
        Render
    }
    
    public delegate void EventCallback();

    public class EventManager {
        private class EventWrapper {
            public EventCallback evt;
            public uint32 active_time;
            public int? timeout;
        }

        private EventWrapper wrapper = new EventWrapper();

        public void add_callback(EventCallback evt) {
            EventWrapper wrapper = new EventWrapper();
            wrapper.evt = evt;
            wrapper.active_time = SDL.Timer.get_ticks();
            this.wrapper = wrapper;
        }

        public void add_callback_timer(EventCallback evt, int milliseconds) {
            EventWrapper wrapper = new EventWrapper();
            wrapper.evt = evt;
            wrapper.active_time = SDL.Timer.get_ticks();
            wrapper.timeout = milliseconds;
            this.wrapper = wrapper;
        }
        
        public void call_callback() {
            var wrapper = this.wrapper;
            wrapper.evt();
        }
        
        public uint32 get_active_time() {
            return this.wrapper.active_time;
        }
        
        public int get_timeout() {
            return this.wrapper.timeout;
        }
    }
}
