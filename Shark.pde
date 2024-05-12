class Shark {

  PImage img ;
  float w, h, SharkX, SharkY, xSpeed, ySpeed ;
  float gravity = 0.1; // 重力加速度
  float jumpStrength = -3; // 跳跃力量
  boolean isAlive = true;

  Shark () {
    // Construct the shark
    img = loadImage("data/shark.png") ;
    float ratio = random(0.5, 0.7) ;
    w = img.width * ratio ;
    h = img.height * ratio ;
    SharkX = width - 100; // 初始位置在右側中間
    SharkY = height/2;
    xSpeed = 0; // 初始速度为0
    ySpeed = 0; // 初始速度为0
  }

  void update() {
    // 更新鯊魚位置
    SharkX += xSpeed;
    SharkY += ySpeed;
    ySpeed += gravity; // 添加重力效果
    if (SharkY + h/2 >= height) { // 如果鯊魚触底
      SharkY = height - h/2; // 将鯊魚放置在底部
      ySpeed = 0; // 停止向下运动
    }
  }

  void display() {
    // 显示鯊魚
    image(img, SharkX - w/2, SharkY - h/2, w, h);
  }

  void jump() {
    // 鯊魚跳跃
    if (SharkY + h/2 >= height) { // 只有在鯊魚在地面时才能跳跃
      ySpeed = jumpStrength; // 设置向上的速度
    }
  }
  void stopJump() {
    // Stop the shark's upward movement
    if (ySpeed < 0) { // Only stop if the shark is moving upwards
      ySpeed = 0; // Set the vertical speed to 0
    }
  }
  void startJump() {
  // Start the shark's upward movement
  ySpeed = jumpStrength; // Set the vertical speed to the jump strength
}
}
