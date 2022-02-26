## prepare

install [direnv](https://direnv.net)

`direnv allow`


## database

See `backup/table` for table structure .

I use [yugabyte cloud](https://cloud.yugabyte.com) databse .

This is a opensource cloud database compatible with the postgresql protocol, with free credits .

After creating the yugabyte cloud database, add 0.0.0.0/0 to the IP whitelist for ease of use , as shown in the figure below .

![](https://raw.githubusercontent.com/gcxfd/img/gh-pages/vcLXDk.png)

Use (dbeaver)[https://dbeaver.io/download] can gui admin it.

Then, `cd config`, then mv `./config.sh.example` to `./.config.sh` , can edit it .


