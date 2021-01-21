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
//episode_6;

import org.lwjgl.LWJGLException;
import org.lwjgl.input.Keyboard;
import org.lwjgl.opengl.Display;
import org.lwjgl.opengl.DisplayMode;

import org.lwjgl.opengl.GL11;

enum State
{
    INTRO;
    MAIN_MENU;
    GAME;
}
/**
 * Shows the use of different game states.
 *
 * @author Oskar
 */
class StateDemo {

    var state: State = INTRO;

    public static function main() { new StateDemo(); } public function new()
    {
        try {
            Display.setDisplayMode(new DisplayMode( 640, 480 ));
            Display.setTitle("State Demo");
            Display.create();
        } catch ( e: LWJGLException ) {
            e.printStackTrace();
            Display.destroy();
            Sys.exit(1);
        }
        var gl = GL11;
        gl.glMatrixMode( gl.GL_PROJECTION );
        gl.glOrtho(0, 640, 480, 0, 1, -1);
        gl.glMatrixMode( gl.GL_MODELVIEW );
        while (!Display.isCloseRequested()) {
            checkInput();
            render();
            Display.update();
            Display.sync(60);
        }

        Display.destroy();
    }

    function render() {
        var gl = GL11;
        gl.glClear( gl.GL_COLOR_BUFFER_BIT);
        switch ( state ) {
            case INTRO:
                gl.glColor3f(1.0, 0., 0.);
                gl.glRectf(0, 0, 640, 480);
            case GAME:
                gl.glColor3f(0., 1.0, 0.);
                gl.glRectf(0, 0, 640, 480);
            case MAIN_MENU:
                gl.glColor3f(0., 0., 1.0);
                gl.glRectf(0, 0, 640, 480);
        }
    }
    
    function checkInput() {
        switch (state) {
            case INTRO:
                if (Keyboard.isKeyDown(Keyboard.KEY_S)) {
                    state = MAIN_MENU;
                }
                if (Keyboard.isKeyDown(Keyboard.KEY_ESCAPE)) {
                    Display.destroy();
                    Sys.exit(0);
                }
            case GAME:
                if (Keyboard.isKeyDown(Keyboard.KEY_BACK)) {
                    state = MAIN_MENU;
                }
            case MAIN_MENU:
                if (Keyboard.isKeyDown(Keyboard.KEY_RETURN)) {
                    state = GAME;
                }
                if (Keyboard.isKeyDown(Keyboard.KEY_SPACE)) {
                    state = INTRO;
                }
        }
    }
}
