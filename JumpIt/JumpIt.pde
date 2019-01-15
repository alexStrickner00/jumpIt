
Player p;
ArrayList<Platform> platforms;

boolean play = false;

float playerHeight = 0;
float vy = 10;
float ay = -0.3;
boolean initial = true;
int score;

void setup() {
  size(400, 800);
  p = new Player(false);
  platforms = new ArrayList();
  platforms.add(new Platform(100, 600, false));
  platforms.add(new Platform(300, 200, false));
}

void draw() {
  background(240);
  updateSprites();

  drawScore();
  for (Platform pf : platforms) {
    pf.render();
  }
  p.render();
  if (vy < -28) {
    play = false;
  }

  if (!play && !initial) {
    textSize(40);
    text("you lost!", 100, 100);
  }
}


void updateSprites() {
  vy += ay;
  if (play) {
    playerHeight += vy;
    if (playerHeight > score) {
      score = (int)playerHeight;
    }
    p.update();
    for (Platform pf : platforms) {
      pf.update(vy);
    }
    if (vy < 0) {
      for (Platform pf : platforms) {
        if (collide(p, pf)) {
          jump();
          addPlatforms();
          return;
        }
      }
    }
  }
}


void keyPressed() {
  if (key == ' ' && initial) {
    initial = false;
    play = true;
  }
  if (key == 'a') {
    p.left();
  }
  if (key == 'd') {
    p.right();
  }
}

boolean collide(Player p, Platform pf) {

  if (((((p.y + p.sprite.height) >= pf.y) && (p.y + p.sprite.height) <= (pf.y+pf.H)) || (p.y + p.sprite.height <= pf.y && p.y + p.sprite.height > pf.y + pf.H + vy)) && p.x <= (pf.x + pf.W) && (p.x + p.sprite.width) >= pf.x) {
    return true;
  }
  return false;
}

void jump() {
  vy = 18;
}

void addPlatforms() {
  if (platforms.get(platforms.size() - 1).y > 0) {
    Platform t1 = platforms.get(platforms.size() - 1);
    platforms.clear();
    platforms.add(t1);
    for (int i = 0; i < 20; i++) {
      Platform temp = new Platform(((float)Math.random() * (width - 70.0)), -300 * i + (float)Math.random() * 100, false);
      platforms.add(temp);
    }
  }
}

void drawScore() {
  text("Score: " + score, 0, 40);
}
