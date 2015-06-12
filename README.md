# BCBezierPath

`BCBezierPath` is a simple library to learn Animations for different type of routes/curves.
Currently it includes the class that prepares the Bezier Path for a Spiral route. You can use it to animate the object along that path.

`BCBezierPath` creates a `UIBezierPath` object for an Archimedean spiral.

**Inputs:**

 - The center point of the spiral. The spiral starts this far from the    center.
 - The amount that the spiral grows in one revolution.
 - The angle, in radians, at which to start the inside of the spiral.
 - The angle, in radians, at which to end the spiral. Every 2π radians    equals 1 full turn.
 - The distance, in radians, between each control point on the resulting Bézier path. A smaller theta step results in a smoother curve, but with more points, which could impact performance.

**Output:**

 - A new path object with the specified spiral.
