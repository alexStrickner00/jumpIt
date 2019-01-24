import java.net.*;
import java.io.*;

public class NetworkConnection extends Thread {

  private Socket socket;
  private BufferedReader reader;
  private PrintWriter writer;
  private ArrayList<Player> players;

  public NetworkConnection(Socket socket) {
    this.socket = socket;
    try {
      reader = new BufferedReader(new InputStreamReader(socket.getInputStream()));
      writer = new PrintWriter(socket.getOutputStream());
    } 
    catch(IOException e) {
      e.printStackTrace();
    }
  }

  public void setPlayers(ArrayList<Player> players) {
    this.players = players;
  }

  @Override
    public void run() {
    while (socket.isConnected()) {
      String input = waitForCommand();
      handleCommand(input);
    }
  }

  public String waitForCommand() {
    String input = null;
    try {
      while ((input = reader.readLine()) == null);
    } 
    catch(IOException e) {
      e.printStackTrace();
    }
    return input;
  }

  public void handleCommand(String input) {

    move(players.get(Integer.parseInt(input.charAt(0) + "")), input.split("_")[1]);
  }

  public void move(Player p, String direction) {
    switch (direction.charAt(0)) {
    case 'l': 
      p.left();
      break;
    case 'r': 
      p.right();
      break;
    }
  }
}
