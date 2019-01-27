static class CollisionHelper {

  public static boolean collide(Player p, Platform pf) {
    //unten spieler unter oberkannte    unten spieler ober unterkannte            unten spieler ueber oberkannte platform und nach update unter unterkannte platform     Spieler links rechts von platform rechts und spieler rechts links von platform links

    if (((((p.y - p.sprite.height) <= pf.y) && (p.y - p.sprite.height) >= (pf.y-pf.H)) || (p.y - p.sprite.height >= pf.y && p.y - p.sprite.height - p.getVy() < pf.y - pf.H)) && !(p.x > (pf.x + pf.W)) && !((p.x + p.sprite.width) < pf.x)) {
      return true;
    }
    return false;
  }
}

//OLD : if (((((p.y + p.sprite.height) >= pf.y) && (p.y + p.sprite.height) <= (pf.y+pf.H)) || (p.y + p.sprite.height <= pf.y && p.y + p.sprite.height > pf.y + pf.H + p.getVy())) && p.x <= (pf.x + pf.W) && (p.x + p.sprite.width) >= pf.x) {
