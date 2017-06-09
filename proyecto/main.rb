require 'opengl'
require 'glu'
require 'glut'
require 'chunky_png'
require 'wavefront'

require_relative 'model'

include Gl
include Glu
include Glut

FPS = 60.freeze
DELAY_TIME = (1000.0 / FPS)
DELAY_TIME.freeze

def load_objects
  puts "Loading..."
  @earth = Model.new('obj/planet', 'obj/planet.mtl')
  @lego_man = Model.new('obj/lego_man', 'obj/lego_man.mtl')
  puts "loaded"
end


def initGL
  glDepthFunc(GL_LEQUAL)
  glEnable(GL_DEPTH_TEST)
  glClearDepth(1.0)
  
  glClearColor(0.0, 0.0, 0.0, 0.0)
  glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)

  glEnable(GL_LIGHTING)
  glEnable(GL_LIGHT0)
  glEnable(GL_COLOR_MATERIAL)
  glColorMaterial(GL_FRONT_AND_BACK, GL_AMBIENT_AND_DIFFUSE)
  glEnable(GL_NORMALIZE)
  glShadeModel(GL_SMOOTH)
  glEnable(GL_CULL_FACE)
  glCullFace(GL_BACK)

  light_position = [0.0, 50.0, 100.0]
  light_color = [1.0, 1.0, 1.0, 1.0]
  specular = [1.0, 1.0, 1.0, 0.0]
  ambient = [0.15, 0.15, 0.15, 1.0]
  glLightfv(GL_LIGHT0, GL_POSITION, light_position)
  glLightfv(GL_LIGHT0, GL_DIFFUSE, light_color)
  glLightfv(GL_LIGHT0, GL_SPECULAR, specular)
  glLightModelfv(GL_LIGHT_MODEL_AMBIENT, ambient)
end

def draw
  @frame_start = glutGet(GLUT_ELAPSED_TIME)
  check_fps
  glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)

  glPushMatrix
    glTranslate(20.0, 10.0, 0.0)
    glRotatef(@spin, 0.0, 1.0, 0.0)
    glScalef(12.0, 12.0, 12.0)
    @earth.draw
  glPopMatrix

  glPushMatrix
    glTranslate(-40.0+@lego_y, -@lego_y-10, 0.0)
    glScalef(5.0 + @scale, 5.0 + @scale, 5.0 + @scale)
    glRotatef(90.0, 0.0, 1.0, 0.0)
    @lego_man.draw
  glPopMatrix

  glutSwapBuffers
end

def reshape(width, height)
  glViewport(0, 0, width, height)
  glMatrixMode(GL_PROJECTION)
  glLoadIdentity
  gluPerspective(45, (1.0 * width) / height, 0.001, 1000.0)
  glMatrixMode(GL_MODELVIEW)
  glLoadIdentity()
  gluLookAt(0.0, 50.0, 125.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0)
end

def idle
  @spin = @spin + 1
  @scale = @scale + @scale_factor
  @lego_y = @lego_y + (@scale_factor*2)

  if @scale > 8 || @scale < 1
    @scale_factor = @scale_factor * -1
  end

  if @spin > 360.0
    @spin = @spin - 360.0
  end

  @frame_time = glutGet(GLUT_ELAPSED_TIME) - @frame_start
  
  if (@frame_time< DELAY_TIME)
    sleep((DELAY_TIME - @frame_time) / 1000.0)
  end
  glutPostRedisplay
end

def check_fps
  current_time = glutGet(GLUT_ELAPSED_TIME)
  delta_time = current_time - @previous_time

  @frame_count += 1

  if (delta_time > 1000)
    fps = @frame_count / (delta_time / 1000.0)
    puts "FPS: #{fps}"
    @frame_count = 0
    @previous_time = current_time
  end
end

@spin = 0.0
@scale = 1
@lego_y = 0.0
@scale_factor = 0.05
@previous_time = 0
@frame_count = 0

load_objects
glutInit
glutInitDisplayMode(GLUT_RGBA | GLUT_DOUBLE | GLUT_DEPTH)
glutInitWindowSize(800,600)
glutInitWindowPosition(10,10)
glutCreateWindow("Hola OpenGL, en Ruby")
glutDisplayFunc :draw
glutReshapeFunc :reshape
glutIdleFunc :idle
initGL
glutMainLoop
