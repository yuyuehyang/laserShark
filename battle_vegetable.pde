//variable
final int GAME_START   = 0;
final int GAME_RUN_1   = 1;
final int GAME_WIN     = 2;
final int GAME_LOSE    = 3;
int gameState = 0 ;
Shark shark; 

PImage img ;
int health = 0 ;
int laser =0;

//Background
PImage background1 ;
PImage background2 ;
float background1X=0;
float background2X=-1920;

float backgroundSpeed = 1 ;

//astroid
PImage astroid;
float astroidX;
float astroidY;

float astroidXSpeed = 2 ;
float astroidYSpeed = 0 ;
float rotationAngle = 0;
float floatOffset = 0;
float floatSpeed = 0.005;

void setup() {
  size(640, 360);
  background1 = loadImage("data/background (1).png");
  background2 = loadImage("data/background2.png");
  astroid = loadImage("data/astroid.png");
  
  
  astroidX = 0;   
  astroidY = random(height - 180);
  
  health = 100;
  laser = 100;
}

void draw() {
  switch(gameState) {
  case GAME_START:
    background(0);
    break;
  case GAME_RUN_1:
    // Show Background
    image(background1, background1X, 0);
    image(background2, background2X, 0);

    // Move the Background
    background1X += backgroundSpeed ;
    background2X += backgroundSpeed ;
    if (background1X >= width) {
      background1X = -640;
    }
    if (background2X >= width) {
      background2X = -640;
    }
    
    // Show hp
    fill(255, 0, 0);
    rect(15, 10, health * 2, 20);
    
    // Update and display shark
    shark.update();
    shark.display();
    
    // Move and display astroid
    moveAndDisplayAstroid();
    break;
  case GAME_WIN:
    break;
  case GAME_LOSE:
    break;
  }
}
void moveAndDisplayAstroid() {
  // Move the astroid horizontally
  astroidX += astroidXSpeed;

  // Calculate floating motion using sine function
  floatOffset = sin(frameCount * floatSpeed) * 10; // 调整振幅和速度以控制漂浮的幅度和速度

  // Update astroid's vertical position with floating motion
  astroidY += floatOffset;

  // Check if astroid hits top or bottom edge of the screen
  if (astroidY < 0 || astroidY + 180 > height) {
    // Reverse the vertical speed to make the astroid bounce
    floatSpeed *= -0.1;
    // Adjust astroid's position to stay within canvas bounds
    astroidY = constrain(astroidY, 0, height - 180);
  }

  // Check if astroid goes off screen on the left side and reset its position
  if (astroidX > width) {
    astroidX = -180; // Reset to the left side of the screen
    astroidY = random(height - 180); // Randomize Y position
  }

  // Update rotation angle to make astroid slowly rotate
  rotationAngle += 0.01; // 调整旋转速度以控制旋转的速度

  // Display astroid with slow rotation
  pushMatrix(); // Save current transformation state
  translate(astroidX + 90, astroidY + 90); // Move the origin to astroid's center
  rotate(rotationAngle); // Apply rotation
  image(astroid, -90, -90, 180, 180); // Draw astroid with its actual size centered at the origin
  popMatrix(); // Restore previous transformation state
}

void keyPressed() {
  // DO NOT REMOVE THIS PART!!!
  // USED FOR DEBUGGING
  switch (key) {
    case '1':
      gameState = GAME_START;
      break;
    case '2':
      gameState = GAME_RUN_1;
      shark = new Shark(); // 创建一个新的鯊魚对象
      break;
    case '3':
      gameState = GAME_LOSE;
      break; // 添加 break 语句
  }
  
  if (keyCode == UP && gameState == GAME_RUN_1) {
    shark.startJump(); // 按住上箭头键时开始鯊魚跳跃
  }
}

void keyReleased() {
  if (keyCode == UP && gameState == GAME_RUN_1) {
    shark.stopJump(); // 松开上箭头键时停止鯊魚跳跃
  }
}

void mousePressed() {
  if (gameState == GAME_RUN_1) {
    shark.jump(); // 鼠标点击时鯊魚跳跃
  }
}
