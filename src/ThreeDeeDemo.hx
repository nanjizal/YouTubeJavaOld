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
//episode_15;

import org.lwjgl.LWJGLException;
import org.lwjgl.input.Keyboard;
import org.lwjgl.opengl.Display;
import org.lwjgl.opengl.DisplayMode;

//import java.util.Random;

import org.lwjgl.opengl.GL11;//.*;
import org.lwjgl.util.glu.GLU;//.gluPerspective;

/**
 * Shows a space-like particle simulation.
 *
 * @author Oskar
 */
class ThreeDeeDemo {
    
    public static function main() { new ThreeDeeDemo(); } public function new()
    {
        try {
            Display.setDisplayMode( new DisplayMode( 640, 480 ));
            Display.setTitle( "Three Dee Demo" );
            Display.create();
        } catch ( e: LWJGLException ) {
            e.printStackTrace();
            Display.destroy();
            Sys.exit(1);
        }
        //
        var gl = GL11;
        // Initialization code OpenGL
        gl.glMatrixMode( gl.GL_PROJECTION );
        gl.glLoadIdentity();
        // Create a new perspective with 30 degree angle (field of view), 640 / 480 aspect ratio, 0.001f zNear, 100 zFar
        // Note: 	+x is to the right
        //     		+y is to the top
        //			+z is to the camera
        GLU.gluPerspective( 30, 640/480, 0.001, 100 );
        gl.glMatrixMode( gl.GL_MODELVIEW );
        //

        // To make sure the points closest to the camera are shown in front of the points that are farther away.
        gl.glEnable( gl.GL_DEPTH_TEST );

        // Initialization code random points
        //Point[] points = new Point[1000];
        var points = new Array<Point>();
        // Iterate of every array index
        for ( i in 0...1000 ) {
            // Set the point at the array index to 
            // x = random between -50 and +50
            // y = random between -50 and +50
            // z = random between  0  and -200
            points[i] = new Point(  100*( Math.random() - 0.5 )
                                  , 100*( Math.random() - 0.5 )
                                  , -200*Math.random()
                                  );
        }
        // The speed in which the "camera" travels
        var speed = 0.0;
        //

        while (!Display.isCloseRequested()) {
            // Render

            // Clear the screen of its filthy contents
            gl.glClear( gl.GL_COLOR_BUFFER_BIT | gl.GL_DEPTH_BUFFER_BIT );

            // Push the screen inwards at the amount of speed
            gl.glTranslatef( 0, 0, speed );

            // Begin drawing points
            gl.glBegin( gl.GL_POINTS );
            // Iterate of every point
            for ( p in points ) {
                // Draw the point at its coordinates
                gl.glVertex3f( p.x, p.y, p.z );
            }
            // Stop drawing points
            gl.glEnd();

            // If we're pressing the "up" key increase our speed
            if ( Keyboard.isKeyDown( Keyboard.KEY_UP ) ) {
                speed += 0.01;
            }
            // If we're pressing the "down" key decrease our speed
            if ( Keyboard.isKeyDown( Keyboard.KEY_DOWN ) ) {
                speed -= 0.01;
            }
            // Iterate over keyboard input events
            while ( Keyboard.next() ) {
                // If we're pressing the "space-bar" key reset our speed to zero
                if ( Keyboard.isKeyDown( Keyboard.KEY_SPACE ) ) {
                    speed = 0;
                }
                // If we're pressing the "c" key reset our speed to zero and reset our position
                if ( Keyboard.isKeyDown( Keyboard.KEY_C ) ) {
                    speed = 0;
                    gl.glLoadIdentity();
                }
            }

            // Update the display
            Display.update();
            // Wait until the frame-rate is 60fps
            Display.sync( 60 );
        }

        // Dispose of the display
        Display.destroy();
        // Exit the JVM (for some reason this lingers on Macintosh)
        Sys.exit(0);
    }
}

class Point {

    public var x: Float;
    public var y: Float;
    public var z: Float;
    
    public function new( x_: Float, y_: Float, z_: Float) {
        x = x_;
        y = y_;
        z = z_;
    }
}
