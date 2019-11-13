import java.net.*;

Game game;
ServerSocket server;
NetworkConnection con;


void setup() {
  size(400, 800);

  try {
    server = new ServerSocket(8099);
    Socket client = null;
    while (client == null || !client.isConnected()) {
      client = server.accept();
      con = new NetworkConnection(client);
    }
  } 
  catch(IOException e) {
    e.printStackTrace();
  }

  game = new Game(con);
  con.start();
}

void draw() {
  game.run();
}

void keyPressed() {
  if(key == 'v'){
    CAMERA_MODE_AUTO = !CAMERA_MODE_AUTO;
  }
  if (!CAMERA_MODE_AUTO) {
    if (keyCode == UP) {
      game.getCamera().up();
    }
    if(keyCode == DOWN){
      game.getCamera().down();
    }
  }
}

void mouseWheel(MouseEvent event){
  float e = event.getCount();
  if (!CAMERA_MODE_AUTO) {
    game.getCamera().move(e);
  }
}
