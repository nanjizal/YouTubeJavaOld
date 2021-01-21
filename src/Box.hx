package episode_4;

import org.lwjgl.opengl.GL11;

class Box {
    
    public var x: Int;
    public var y: Int;
    public var selected: Bool = false;
    
    var colorRed: Float;
    var colorBlue: Float;
    var colorGreen: Float;
    
    public function new( x_: Int, y_: Int ) {
        x = x_;
        y = y_;
        randomiseColors();
    }
    
    public function isInBounds( mouseX: Int, mouseY: Int ): Bool {
            return mouseX > x && mouseX < x + 50 && mouseY > y && mouseY < y + 50;
    }
    
    public function update( dx: Int, dy: Int ) {
        x += dx;
        y += dy;
    }
    
    public function randomiseColors() {
        colorRed = Math.random();
        colorBlue = Math.random();
        colorGreen = Math.random();
    }
    
    public function draw() {
        var gl = GL11;
        gl.glColor3f( colorRed, colorGreen, colorBlue );
        gl.glBegin( gl.GL_QUADS );
        gl.glVertex2f( x, y );
        gl.glVertex2f( x + 50, y );
        gl.glVertex2f( x + 50, y + 50 );
        gl.glVertex2f( x, y + 50 );
        gl.glEnd();
    }
}