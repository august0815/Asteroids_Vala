namespace Darkcore {
    public class Vector : Gsl.Vector {
        public Vector (size_t n) {
            base (n);
        }
            
        public Vector.copy (Gsl.Vector vector) {
            base (vector.size);
            this.memcpy (vector);
        }
        
        public int mul_scalar (double val) {
            this.scale(val);
            
            return 0;
        }
        
        public int div_scalar (double val) {
            this.scale(1 / val);
            
            return 0;
        }
        
        public int add_scalar (double val) {
            this.add_constant(val);
            
            return 0;
        }
        
        public int sub_scalar (double val) {
            this.add_constant(-val);
            
            return 0;
        }
        
        public double dot (Gsl.Vector vector) {
            var length = this.size;
            double result = 0.00;
	        for (var index = 0; index < length; index++) {
		        result += this.get (index) * vector.get (index);
	        }
            
            return result;
        }
        
        public double length () {
            var length = this.size;
            double result = 0.00;
	        for (var index = 0; index < length; index++) {
		        result += this.get (index) * this.get (index);
	        }
	        
            return Math.sqrt (result);
        }
        
        public string to_string () {
            var length = this.size;
            var result = "(";
	        for (var index = 0; index < length; index++) {
	            if (index != 0) {
	                result += ", ";
	            }
		        result += this.get (index).to_string ();
	        }
	        result += ")";
	        
	        return result;
        }
    }
}
