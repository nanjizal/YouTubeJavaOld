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
//episode_4;

import org.lwjgl.LWJGLException;
import org.lwjgl.input.Keyboard;
import org.lwjgl.input.Mouse;
import org.lwjgl.opengl.Display;
import org.lwjgl.opengl.DisplayMode;
import java.lang.System;
import org.lwjgl.opengl.GL11;
import haxe.Int64;
/**
 * Shows how to use input to achieve cool results. Thanks to Azziplekkus1337 for the better way of handling the
 * cool-down!
 *
 * @author Oskar
 */
class InputDemo {

    var shapes: Array<Box> = [];
    var somethingIsSelected: Bool = false;
    var lastColourChange: Int;
    
    public static function main() { new InputDemo(); } public function new()
    {
        try {
            Display.setDisplayMode( new DisplayMode( 640, 480 ) );
            Display.setTitle( "Input Demo" );
            Display.create();
        } catch ( e: LWJGLException ) {
            e.printStackTrace();
            Display.destroy();
            Sys.exit(1);
        }
        shapes.push( new Box( 15, 15 ) );
        shapes.push( new Box( 100, 150 ) );
        var gl = GL11;
        gl.glMatrixMode( gl.GL_PROJECTION );
        gl.glOrtho( 0, 640, 480, 0, 1, -1 );
        gl.glMatrixMode( gl.GL_MODELVIEW );
        
        while ( !Display.isCloseRequested() ) {
            gl.glClear( gl.GL_COLOR_BUFFER_BIT );
            while ( Keyboard.next() ) {
                if ( Keyboard.getEventKey() == Keyboard.KEY_C && Keyboard.getEventKeyState() ) {
                    shapes.push( new Box( 15, 15 ) );
                }
            }
            if ( Keyboard.isKeyDown( Keyboard.KEY_ESCAPE ) ) {
                Display.destroy();
                Sys.exit( 0 );
            }
            var miliSec: Int = Int64.toInt( System.currentTimeMillis() );
            for ( box in shapes ) {
                if ( Mouse.isButtonDown(0) && box.isInBounds( Mouse.getX(), 480 - Mouse.getY() ) && !somethingIsSelected ) {
                    somethingIsSelected = true;
                    box.selected = true;
                }
                if ( Mouse.isButtonDown(2) && box.isInBounds( Mouse.getX(), 480 - Mouse.getY() ) && !somethingIsSelected ) {
                    if (( miliSec - lastColourChange ) >= 200 /* milliseconds */) {
                        box.randomiseColors();
                        lastColourChange = miliSec;
                    }
                }
                if ( Mouse.isButtonDown(1) ) {
                    box.selected = false;
                    somethingIsSelected = false;
                }

                if ( box.selected ) {
                    box.update( Mouse.getDX(), -Mouse.getDY() );
                }

                box.draw();
            }

            Display.update();
            Display.sync(60);
        }

        Display.destroy();
    }
}
