import java.net.*;
import java.io.*;

public class NetworkConnection extends Thread {

  private Socket socket;
  private BufferedReader reader;
  private PrintWriter writer;
  private ArrayList<Player> players;
  private Game hostGame;

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

  public void setGame(Game game) {
    this.hostGame = game;
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
    String[] args = input.split("_");
    switch(args[0].trim()) {
    case "m":     
      move(players.get(Integer.parseInt(args[1] + "")), args[2]);
      break;
    case "ap":
      addPlayers(Integer.parseInt(args[1]));
      break;
    case "sg":
      this.hostGame.startGame();
      break;
    case "eg":
      this.endGame();
      break;
    }
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

  private void addPlayers(int count) {
    for (int i = 0; i < count; i++) {
      int id = game.addPlayer();
      writer.printf("np_%d\n", id);
    }
    writer.flush();
  }


  private void endGame() {
    this.hostGame.end();
    for (Player p : players) {
      writer.printf("pstats_%d_%.0f\n", p.getId(), p.getHighest());
    }
    writer.flush();
  }
}
