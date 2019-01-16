static class CollisionHelper{

  public static boolean collide(Player p , Platform pf){
            //unten spieler unter oberkannte    unten spieler ober unterkannte            unten spieler unter oberkannte    unten spieler 
    if (((((p.y - p.sprite.height) <= pf.y) && (p.y - p.sprite.height) >= (pf.y-pf.H)) || (p.y - p.sprite.height >= pf.y && p.y - p.sprite.height < pf.y - pf.H + p.getVy())) && p.x <= (pf.x + pf.W) && (p.x + p.sprite.width) >= pf.x) {
    return true;
  }
  return false;
  }

}

//OLD : if (((((p.y + p.sprite.height) >= pf.y) && (p.y + p.sprite.height) <= (pf.y+pf.H)) || (p.y + p.sprite.height <= pf.y && p.y + p.sprite.height > pf.y + pf.H + p.getVy())) && p.x <= (pf.x + pf.W) && (p.x + p.sprite.width) >= pf.x) {
