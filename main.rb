require 'opengl'
require 'glu'
require 'glut'

include Gl
include Glu
include Glut

def initGL
  glClearColor(0.0,0.0,0.0,0.0)
  # Color de fondo: negro
  glClear(GL_COLOR_BUFFER_BIT)
  # Boramos la pantalla
  glMatrixMode(GL_PROJECTION)
  # Modo proyección
  glLoadIdentity
  # Cargamos la matriz identidad
  glOrtho(-1.0,1.0,-1.0,1.0,-1.0,1.0)
  # Proyección ortográfica, dentro del cubo señalado
  glMatrixMode(GL_MODELVIEW)
end

def endGl
  glEnd
  glFlush
end


def displaySquare
  initGL
  glBegin(GL_QUADS)
  # Dibujamos un cuadrado
  glColor3f(0.5,0.5,0.5)
  # Color para el cuadrado
  glVertex3f(-0.5,0.5,-0.5)
  # Coordenadas del primer vértice (superior-izquierda)
  glVertex3f(-0.5,-0.5,0.5)
  # Coordenadas del segundo vértice (inferior-izquierda)
  glVertex3f(0.5,-0.5,0.5)
  # Coordenadas del primer vértice (inferior-derecha)
  glVertex3f(0.5,0.5,-0.5)
  # Coordenadas del primer vértice (superior-derecha)
  endGl
end

def displayTriangle
  initGL
  glBegin(GL_TRIANGLES)
  # Dibujamos un triángulo
  glColor3f(1.0,0.0,0.0)
  # Color del primer vértice: rojo
  glVertex3f(0.0,0.8,0.0)
  # Coordenadas del primer vértice
  glColor3f(0.0,1.0,0.0)
  # Color del segundo vértice: verde
  glVertex3f(-0.6,-0.2,0.0)
  # Coordenadas del segundo vértice
  glColor3f(0.0,0.0,1.0)
  # Color del tercer vértice: azúl
  glVertex3f(0.6,-0.2,0.0)
  # Coordenadas del tercer vértice
  endGl
end

glutInit
glutInitDisplayMode(GLUT_SINGLE | GLUT_RGBA)
glutInitWindowSize(500,500)
glutInitWindowPosition(20,20)
glutCreateWindow("OpenGL en Ruby")
glutDisplayFunc :displaySquare
glutMainLoop
