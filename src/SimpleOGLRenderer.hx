/*
 * Copyright (c) 2013, Oskar Veerhoek
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice, this
 *    list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
 * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * The views and conclusions contained in the software and documentation are those
 * of the authors and should not be interpreted as representing official policies,
 * either expressed or implied, of the FreeBSD Project.
 */

package;
//episode_3;

import org.lwjgl.LWJGLException;
import org.lwjgl.opengl.Display;
import org.lwjgl.opengl.DisplayMode;

import org.lwjgl.opengl.GL11;

// Terminology:
// - Vertex: a point in either 2D or 3D space
// - Primitive: a simple shape consisting of one or more vertices

/**
 * Shows some basic shape drawing.
 *
 * @author Oskar
 */
class SimpleOGLRenderer {
    public static function main() { new SimpleOGLRenderer(); } public function new()
    {
        try {
            // Sets the width of the display to 640 and the height to 480
            Display.setDisplayMode(new DisplayMode(640, 480));
            // Sets the title of the display to "Episode 2 - Display"
            Display.setTitle("Episode 3 - OpenGL Rendering");
            // Creates and shows the display
            Display.create();
        } catch ( e: LWJGLException ) {
            e.printStackTrace();
            Display.destroy();
            Sys.exit(1);
        }
        var gl = GL11;
        // Enter the state that is required for modify the projection. Note that, in contrary to Java2D, the vertex
        // coordinate system does not have to be equal to the window coordinate space. The invocation to glOrtho creates
        // a 2D vertex coordinate system like this:
        // Upper-Left:  (0,0)   Upper-Right:  (640,0)
        // Bottom-Left: (0,480) Bottom-Right: (640,480)
        // If you skip the glOrtho method invocation, the default 2D projection coordinate space will be like this:
        // Upper-Left:  (-1,+1) Upper-Right:  (+1,+1)
        // Bottom-Left: (-1,-1) Bottom-Right: (+1,-1)
        gl.glMatrixMode( gl.GL_PROJECTION );
        gl.glOrtho( 0, 640, 480, 0, 1, -1 );
        gl.glMatrixMode( gl.GL_MODELVIEW );
        // While we aren't pressing the red button on the display
        while ( !Display.isCloseRequested() ) {
            // Clear the 2D contents of the window.
            gl.glClear( gl.GL_COLOR_BUFFER_BIT );
            // ">>" denotes a possibly modified piece of OpenGL documentation (http://www.opengl.org/sdk/docs/man/)
            // >> glBegin and glEnd delimit the vertices that define a primitive or a group of like primitives.
            // >> glBegin accepts a single argument that specifies how the vertices are interpreted.
            // All upcoming vertex calls will be taken as points of a quadrilateral until glEnd is called. Since
            // this primitive requires four vertices, we will have to call glVertex four times.
            gl.glBegin( gl.GL_QUADS );
            // >> glVertex commands are used within glBegin/glEnd pairs to specify point, line, and polygon vertices.
            // >> glColor sets the current colour. (All subsequent calls to glVertex will be assigned this colour)
            // >> The number after 'glVertex'/'glColor' indicates the amount of components. (xyzw/rgba)
            // >> The character after the number indicates the type of arguments.
            // >>      (for 'glVertex' = d: Double, f: Float, i: Integer)
            // >>      (for 'glColor'  = d: Double, f: Float, b: Signed Byte, ub: Unsigned Byte)
            gl.glColor3f( 1.0, 0.0, 0.0 );                    // Pure Green
            gl.glVertex2i( 0, 0 );                               // Upper-left
            gl.glColor3b( 0, 127, 0);      // Pure Red
            gl.glVertex2d( 640.0, 0.0 );                         // Upper-right
            gl.glColor3ub( 255, 255, 255 ); // White
            gl.glVertex2f( 640.0, 480.0 );                     // Bottom-right
            gl.glColor3d( 0.0, 0.0, 1.0 );                    // Pure Blue
            gl.glVertex2i( 0, 480 );                             // Bottom-left
            
            // If we put another four calls to glVertex2i here, a second quadrilateral will be drawn.
            gl.glEnd();
            // Update the contents of the display and check for input.
            Display.update();
            // Wait until we reach 60 frames-per-second.
            Display.sync( 60 );
        }
        Display.destroy();
        Sys.exit( 0 );
    }
}
