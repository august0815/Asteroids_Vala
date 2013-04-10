namespace Darkcore {
    public class Collision {
            
        public Darkcore.Vector? closest_point_on_segment (
            Darkcore.Vector segment_1, Darkcore.Vector segment_2, Darkcore.Vector circle_position
        ) {
            var segment = new Darkcore.Vector.copy (segment_1);
            segment.sub(segment_2);
            
            var point = new Darkcore.Vector.copy (circle_position);
            point.sub(segment_2);
            
            // Length
            var segment_length = segment.length();
            
            if (segment_length <= 0) {
                /* Invalid segment length */
                return null;
            }
            
            // Divide against scalar
            var segment_unit = new Darkcore.Vector.copy (segment);
            segment_unit.div_scalar (segment_length);
            
            // Dot Product
            var projection_unit = new Darkcore.Vector.copy (point);
            double projection = projection_unit.dot (segment_unit);
            
            var result = new Darkcore.Vector(2);
            if (projection <= 0) {
                result.set(0, segment_1[0]);
                result.set(1, segment_1[1]);
                return result;
            }
            
            if (projection >= segment_length) {
                result.set(0, segment_2[0]);
                result.set(1, segment_2[1]);
                return result;
            }
            
            // Divide against scalar
            var projection_vector = new Darkcore.Vector.copy (segment_unit);
            projection_vector.scale(projection);
            
            // Closest
            result.memcpy(projection_vector);
            result.add(segment_1);

            return result;
        } 
        
        public static bool circle_in_rectangle (
            Darkcore.Vector v1, Darkcore.Vector v2, 
	        Darkcore.Vector position, double radius
        ) {
            var test = new Darkcore.Vector.copy (position);
            if (position.get (0) < v1.get (0)) {
                test.set (0, v1.get (0));
            }
            if (position.get (0) > v2.get (0)) {
                test.set (0, v2.get (0));
            }
            if (position.get (1) < v1.get (1)) {
                test.set (1, v1.get (1));
            }
            if (position.get (1) > v2.get (1)) {
                test.set (1, v2.get (1));
            }
            
            var result = new Darkcore.Vector.copy (position);
            result.sub (test);
            
            return result.length () < radius;
        }
        
        /*
            To be used for polygonal collision
            http://paulbourke.net/geometry/sphereline/
            
            a = (x2 - x1)2 + (y2 - y1)2 + (z2 - z1)2
            b = 2[ (x2 - x1) (x1 - x3) + (y2 - y1) (y1 - y3) + (z2 - z1) (z1 - z3) ]

            c = x32 + y32 + z32 + x12 + y12 + z12 - 2[x3 x1 + y3 y1 + z3 z1] - r2

            The solutions to this quadratic are described by


            The exact behaviour is determined by the expression within the square root

            b * b - 4 * a * c
            
            If this is less than 0 then the line does not intersect the sphere.

            If it equals 0 then the line is a tangent to the sphere intersecting it at one point, namely at u = -b/2a.

            If it is greater then 0 the line intersects the sphere at two points.
        */
        /*
	    public Darkcore.Vector? segment_circle (
	        Darkcore.Vector segment_1, Darkcore.Vector segment_2, 
	        Darkcore.Vector circle_position, double circle_radius
	    ) {
	        var closest = closest_point_on_segment (
	            segment_1, segment_2, circle_position
            );
            
            // Subtract Vectors
            var distance = new Darkcore.Vector(2);
            distance.set(0, circle_position.get (0) - closest.get (0));
            distance.set(1, circle_position.get (1) - closest.get (1));
            
            // Vector Length
            var distance_length = segment.length();
                
            var result = new Darkcore.Vector(2);
	        if (distance_length > circle_radius) {
	            result.set_zero ();
		        return result;
	        }
            
            if (distance_length <= 0) {
                /* Circle's center is exactly on segment */
                /*
                return null;
            }
            
            // Divide against scalar
            result.set (0, distance.get (0) / distance_length);
            result.set (1, distance.get (1) / distance_length);
            
            var radius_length = circle_radius - distance_length;
            
            result.set (0, result.get (0) * radius_length);
            result.set (1, result.get (1) * radius_length);
            
	        return result;
	    }
	    */
    }
}
