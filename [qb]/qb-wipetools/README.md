# qb-wipetools
A resource for managing wipes across economies.

# Requirements
1. qb-core
2. qb-phone
3. OxMysql

## How it works
Let's say you want to wipe your server, but you want your players to be able to keep X amount of cars based on conditions - you would use this resource to manage that.

1. Create a copy of your player_vehicles table and name it player_vehicles_old

2. Install qb-wipetools and run the SQL

3. Wipe your server (keep player_vehicles_old)

4. Players login post wipe, and do `/importcarlist`. This creates an entry in the DB table `wipe_tools_vehicles`. It defaults to allowing them to migrate 1 car from the old economy. You can edit the DB for each person to increase it if you wanted to.

5. They get an e-mail on their phones with a list of ALL the cars they had in the old economy

6. They type `/importcar <PLATE>` 

7. That car shows up in motelgarage (can be changed in server.)

