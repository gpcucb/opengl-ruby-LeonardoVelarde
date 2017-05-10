require 'opengl'
require 'glu'
require 'glut'

include Gl
include Glu
include Glut

def initGL
	glDepthFunc(GL_LEQUAL)
	glEnable(GL_DEPTH_TEST)

	glClearColor(0.0,0.0,0.0,0.0)
	glClearDepth(1.0)
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)

	glMatrixMode(GL_PROJECTION)
	glLoadIdentity
	gluPerspective(60.0,1.0,1.0,100.0)

	glMatrixMode(GL_MODELVIEW)
	glTranslatef(0.0,0.0,-10.0)
	glRotatef(20, 20, 20, 1)
end

def createCube cube_side, r, g, b
	glPushMatrix
		glColor3f(r, g, b)
		glutWireCube(cube_side)
	glPopMatrix
end

def createTranslatedCube cube_side, r, g, b, translation
	glPushMatrix
		glTranslatef(translation, 0, 0)
		glColor3f(r, g, b)
		glutWireCube(cube_side)
	glPopMatrix
end

def createScaledCube cube_side, r, g, b, scale
	glPushMatrix
		glScalef(scale, scale, scale)
		glColor3f(r, g, b)
		glutWireCube(cube_side)
	glPopMatrix
end

def createRotatedCube cube_side, r, g, b, scale
	glPushMatrix
		glRotatef(scale, scale, scale, 1)
		glColor3f(r, g, b)
		glutWireCube(cube_side)
	glPopMatrix
end

def createTranslaRotatedCube cube_side, r, g, b, translation
	glPushMatrix
		glRotatef(20, 20, 20, 1)
		glTranslatef(translation, 0, 0)
		glColor3f(r, g, b)
		glutWireCube(cube_side)
	glPopMatrix
end

def displayCubes
	initGL

	createCube(3, 0, 0, 1)
	createScaledCube(3, 0, 1, 0, 2)
	createTranslatedCube(3, 1, 0, 0, 4)

	glTranslatef(-4, 0, 0)

	createRotatedCube(3, 1, 1, 0, 30)

	glTranslatef(4, -4, 0)

	createTranslaRotatedCube(3, 1, 1, 1, 4)
	
	glTranslatef(0, 4, 0)

	glFlush
end

glutInit
glutInitDisplayMode(GLUT_SINGLE | GLUT_RGBA | GLUT_DEPTH)
glutInitWindowPosition(20,20)
glutInitWindowSize(500,500)
glutCreateWindow("Humanoide OpenGL")
glutDisplayFunc(:displayCubes)
glutMainLoop