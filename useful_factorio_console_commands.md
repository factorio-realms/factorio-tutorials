[date]: meta "2017-01-15T05:51:08+0800"
[author]: meta "pjincz"
[tags]: meta "factorio console for-beginer for-game-master"

Useful factorio console commands
================================

Hi friends, welcome to [Factorio Realms][homepage].

Today I will show you some useful commands. I known you are not a cheater, :p.
But somethings we need some tools to test or manage our server. Is not it?

I will update this article occasionally. Keep an eye on it, if you wanna known
more commands. Leave a message if you need a command not listed here.

NOTICE: **Using these commands will disable achievements!!!**

Character
---------

### Teleport

Teleport:

    /c game.player.teleport{X,Y}
    # fill X, Y as you want
    # for example:
    /c game.player.teleport{100, 100}

Teleport to the end of the world:

    /c game.player.teleport{999999, 0}
    # or
    /c game.player.teleport{999999, 999999}
    # or
    /c game.player.teleport{-999999, -999999}
    # or ...

Teleport to spawn position:

    /c game.player.teleport(game.player.force.get_spawn_position(game.player.surface))

Teleport another player:

    /c game.players['name'].teleport{X,Y}

    # for example:
    /c game.palyers['tom'].teleport{0,0}

Teleport to another player:

    /c game.player.teleport(game.players['name'].position)

### Run

Run fast:

    /c game.player.character_running_speed_modifier = 1

Run faster:

    /c game.player.character_running_speed_modifier = 2
    # and so on...

Resume running speed:

    /c game.player.character_running_speed_modifier = 0

Change running speed of another player:

    /c game.players["name"].character_running_speed_modifier = X

### Mine

Mine fast:

    /c game.player.character_mining_speed_modifier = 1

Mine faster:

    /c game.player.character_mining_speed_modifier = 10
    # and so on...

Resume mining speed:

    /c game.player.character_mining_speed_modifier = 0

Change mining speed of another player:

    /c game.players["name"].character_mining_speed_modifier = X

### Craft

Craft fast:

    /c game.player.character_crafting_speed_modifier = 1

Craft faster:

    /c game.player.character_crafting_speed_modifier = 10

Resume crafting speed:

    /c game.player.character_crafting_speed_modifier = 0

Change crafting speed of another player:

    /c game.players["name"].character_crafting_speed_modifier = X

### Inventory

More inventory slots:

    /c game.player.character_inventory_slots_bonus = 50

More quickbar:

    /c game.player.quickbar_count_bonus = 2

### God mode

Enter god mode:

    /c game.player.character.destroy()

Leave god mode:

    /c game.player.create_character()

### Show player online/afk time

Show online time:

    # by minutes
    /c game.print(game.players['name'].online_time/3600)
    # by hours
    /c game.print(game.players['name'].online_time/216000)

Show afk time:

    # by minutes
    /c game.print(game.players['name'].afk_time/3600)

Item
----

### Cheat mode

Enable Cheat mode:

    /c game.player.cheat_mode = true

Disable Cheat mode:

    /c game.player.cheat_mode = false

### Duplicate items

Duplicate items:

    # pick something up, the run following command
    /c game.player.insert(game.player.cursor_stack)

Duplicate blueprint:

    # 1. pick source blueprint up, then run following command
    /c tmp = game.player.cursor_stack.get_blueprint_entities()

    # 2. pick another blueprint up, then run following command
    /c game.player.cursor_stack.set_blueprint_entities(tmp)

### Receive an item

Get item internal name:

    # pick something up, the run following command
    /c game.player.print(game.player.cursor_stack.name)

Receive an item:

    /c game.player.insert{name='item-name', count=COUNT}
    # for example
    /c game.player.insert{name='power-armor-mk2', count=10}

Team
----

### List all teams

List all teams:

    /c for n, _ in pairs(game.forces) do game.player.print(n) end

### Create new team

Create new team:

    /c game.forces.create_force('name of force')

### Move player X to team Y

Move player X to team Y:

    /c game.players['X'].force = game.forces['Y']

### Cease fire

Set cease fire between team X and Y

    /c game.forces['X'].set_cease_fire('Y', true)

Resume:

    /c game.forces['X'].set_cease_fire('Y', false)

Technology
----------

### Unlock all technology

Unlock all technology

    /c game.player.force.research_all_technologies()

Map
---

### Chart

Chart area {X1, Y1} - {X2, Y2}:

    /c game.player.force.chart(game.player.surface, {{x=X1,y=Y1},{x=X2,y=Y2}})
    # for example
    /c game.player.force.chart(game.player.surface, {{x=-1000, y=-1000}, {x=1000, y=1000}})
    # NOTICE: this command is really slow, needs 2-3 minutes

Chart all generated areas:

    /c game.player.force.chart_all()

Rechart all charted areas:

    /c game.player.force.rechart()

Unchart:

    /c game.player.force.clear_chart()

### Remove trees, decorations, etc

Remove all trees on the generated areas:

    /c for _, o in pairs(game.player.surface.find_entities_filtered({type='tree'})) do o.destroy() end; game.player.force.rechart()
    # NOTICE: this command may block game for a long time

Remove all decorations on the generated areas:

    /c for _, o in pairs(game.player.surface.find_entities_filtered({type='decorative'})) do o.destroy() end; game.player.force.rechart()
    # NOTICE: this command may block game for a long time

### Statistics

Show how many belt on the map: (include basic/fast/express belt)

    /c game.player.print(game.player.surface.count_entities_filtered({type='transport-belt'}))

Show how many express belt on the map: (only include express belt)

    /c game.player.print(game.player.surface.count_entities_filtered({name='express-transport-belt'}))

Show how many X on the map: (filter by type)

    # mouse over the entry and get entity type first
    /c game.player.print(game.player.selected.type)
    # then
    /c game.player.print(game.player.surface.count_entities_filtered({type='fill type here'}))

Show how many X on the map: (filter by name)

    # mouse over the entry and get entity name first
    /c game.player.print(game.player.selected.name)
    # then
    /c game.player.print(game.player.surface.count_entities_filtered({name='fill name here'}))

Show how many ores in the mine:

    # Move over one piece of the mine
    # copy all following code and paste once, do not copy one line by one line
    /c q={game.player.selected}; f={}; c=0
    while #q > 0 do
        p = q[1].position
        if not f[p.x..','..p.y] then
            c = c + q[1].amount
            f[p.x..','..p.y] = 1
            for _, x in pairs(game.player.surface.find_entities_filtered{area={{p.x-1.1,p.y-1.1},{p.x+1.1,p.y+1.1}},name=q[1].name}) do table.insert(q, x) end
        end
        table.remove(q, 1)
    end
    game.player.print(c)

Misc
----

Change game running speed:

    /c game.speed = X;
    # NOTICE: !!! DO NOT FILL A TOO SMALL VALUE !!!

Show map seed:

    /c game.player.print(game.player.surface.map_gen_settings.seed)
