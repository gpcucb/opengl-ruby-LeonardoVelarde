require 'opengl'
require 'glu'
require 'glut'

include Gl
include Glu
include Glut

def initGL
	glDepthFunc(GL_LEQUAL)
	glEnable(GL_DEPTH_TEST)

	glEnable(GL_LIGHTING)
	glEnable(GL_LIGHT0)
	glEnable(GL_COLOR_MATERIAL)
	glEnable(GL_NORMALIZE)
	glShadeModel(GL_SMOOTH)

	position = [80.0, 0.0, 100.0]
	color = [1.0, 1.0, 1.0]
	ambient = [0.2, 0.2, 0.2, 1.0]

	glLightfv(GL_LIGHT0, GL_POSITION, position)
	glLightfv(GL_LIGHT0, GL_DIFFUSE, color)
	glLightfv(GL_LIGHT0, GL_SPECULAR, color)
	glLightModelfv(GL_LIGHT_MODEL_AMBIENT, ambient)

	glClearColor(0.0, 0.0, 0.0, 0.0)
	glClearDepth(1.0)

	glColorMaterial(GL_FRONT_AND_BACK, GL_AMBIENT_AND_DIFFUSE)
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)

	glMatrixMode(GL_PROJECTION)
	glLoadIdentity
	gluPerspective(60.0, 1.0, 1.0, 100.0)

	glMatrixMode(GL_MODELVIEW)
	glTranslatef(0.0, 0.0, -10.0)
end


def display
	initGL

	glPushMatrix
		glColor3f(1.0, 0.3, 0.0)
		glScalef(2, 2, 2)
	    glutSolidSphere(1,100,100)
	glPopMatrix

	glPushMatrix
	    glTranslatef(7.0, 0.0, 0.0)
	    glColor3f(0.0, 0.3, 1.0)
	    glutSolidSphere(3, 100, 100)
    glPopMatrix

	glPushMatrix
	    glTranslatef(-7.0, 0.0, 0.0)
	    glColor3f(0.0, 0.3, 1.0)
	    glutSolidSphere(3, 100, 100)
    glPopMatrix


	glPushMatrix
	    glTranslatef(0.0, 7.0, 0.0)
	    glColor3f(0.0, 1.3, 0.3)
	    glutSolidSphere(3, 100, 100)
    glPopMatrix


	glPushMatrix
	    glTranslatef(0.0, -7.0, 0.0)
	    glColor3f(0.4, 0.7, 0.3)
	    glutSolidSphere(3, 100, 100)
    glPopMatrix


	glFlush
end

glutInit
glutInitDisplayMode(GLUT_SINGLE | GLUT_RGBA | GLUT_DEPTH)
glutInitWindowPosition(20, 20)
glutInitWindowSize(500, 500)
glutCreateWindow("Humanoide OpenGL")
glutDisplayFunc(:display)
glutMainLoop