require 'opengl'
require 'glu'
require 'glut'

include Gl
include Glu
include Glut

def initOrthoGL
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

def initPerspectiveGL
  glDepthFunc(GL_LEQUAL)
  glEnable(GL_DEPTH_TEST)
  glClearDepth(1.0)

  glClearColor(0.0,0.0,0.0,0.0) # Color de fondo: negro
  glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)# Borramos la pantalla
  glMatrixMode(GL_PROJECTION) # Modo proyección
  glLoadIdentity # Cargamos la matriz identidad
  gluPerspective(60.0,1.0,1.0,100.0) # Proyección perspectiva.
  glTranslatef(0.0,0.0,-2.0)

  glMatrixMode(GL_MODELVIEW)
end

def addSquare
  # glTranslatef(0.0,0.0,-3.0)
  glBegin(GL_QUADS)  #Dibujamos un cuadrado
    glColor3f(0.5,0.5,0.5) #Color del primer vertice
    glVertex3f(-0.5,0.5,-0.5) #Coordenadas del primer vértice (superior-izquierda)
    glVertex3f(-0.5,-0.5,0.5) #Coordenadas del segundo vértice (inferior-izquierda)
    glVertex3f(0.5,-0.5,0.5) #Coordenadas del primer vértice (inferior-derecha)
    glVertex3f(0.5,0.5,-0.5) # Coordenadas del primer vértice (superior-derecha)
  glEnd
end

def addTriangle
  glBegin(GL_TRIANGLES)
    # Dibujamos un triángulo
    glColor3f(1.0,0.0,0.0)
    # Color del primer vértice: rojo
    glVertex3f(0.0,0.5,0.0)
    # Coordenadas del primer vértice
    glColor3f(0.0,1.0,0.5)
    # Color del segundo vértice: verde
    glVertex3f(-0.7,-0.5,0.0)
    # Coordenadas del segundo vértice
    glColor3f(0.0,0.0,1.0)
    # Color del tercer vértice: azúl
    glVertex3f(0.7,-0.5,0.0)
    # Coordenadas del tercer vértice
  glEnd
end

def drawFunctionOrWhateverForNow
  initPerspectiveGL
  addSquare
  addTriangle
  glFlush
end

glutInit
glutInitDisplayMode(GLUT_SINGLE | GLUT_RGBA | GLUT_DEPTH) # Reservar espacio para el z buffer con GLUT_DEPTH
glutInitWindowSize(500,500)
glutInitWindowPosition(20,20)
glutCreateWindow("OpenGL en Ruby")
glutDisplayFunc :drawFunctionOrWhateverForNow
glutMainLoop
