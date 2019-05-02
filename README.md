
# jumpIt
## Connection
___JumpIt___ runs on port 8099. To connect to it, you just have to open a TCP-socket session to `<host-address\>:8099`.
To try and test the game you could either use telnet or [NetKeys](https://github.com/alexStrickner00/NetKeys).

## Commands to play/use/control the game
To control the game all you have to do is sending the following commands:
* Adding players: `ap_<player_count>`
* Start game: `sg`
* move specific player: `m_<player_id>_<{l|r}>`

  * l: move player to left

  * r: move player to right

* reset game: `rg`
* end game: `eg`
* get stats of specific player: `status_<player_id>`

**Every command has to end with a `newline (\n)` character!**

## Responses from JumpIt
Some commands you send expect a response from JumpIt. The syntax is nearly the same like the command syntax.

* status: if you send the `status` command you receive the following response: `<player_id>_<y-velocity>_<x-distance-to-next-platform>_<fitness>`

* when the game finished JumpIt sends the final stats in following format: `pstats_<player_id>_<fitness>`
