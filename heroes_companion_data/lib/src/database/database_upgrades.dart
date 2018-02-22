import 'dart:async';

import 'package:heroes_companion_data/src/models/playable_map.dart';
import 'package:sqflite/sqflite.dart';
import 'package:heroes_companion_data/src/tables/hero_table.dart' as hero_table;
import 'package:heroes_companion_data/src/tables/ability_table.dart'
    as ability_table;
import 'package:heroes_companion_data/src/tables/talent_table.dart'
    as talent_table;

import 'package:heroes_companion_data/src/tables/map_table.dart' as map_table;

import 'package:heroes_companion_data/src/tables/patch_table.dart' as patch_table;

import 'package:flutter/foundation.dart';

Future upgradeTo2(Database database) async {
  await database.execute('''
    ALTER TABLE ${hero_table.table_name}
    ADD COLUMN ${hero_table.column_last_rotation_date} DATETIME 
    ''');
}

Future upgradeTo3(Database database) async {
  await database.execute('''
    ALTER TABLE ${hero_table.table_name}
    ADD COLUMN ${hero_table.column_have_assets} INTEGER DEFAULT 0 
    ''');
}

Future upgradeTo4(Database database) async {
  await database.execute('''
    ALTER TABLE ${hero_table.table_name}
    ADD COLUMN ${hero_table.column_modified_date} DATETIME 
    ''');
}

Future upgradeTo5(Database database) async {
  await database.execute('''
      ALTER TABLE ${hero_table.table_name}
      ADD COLUMN ${hero_table.column_sha3_256} TEXT 
      ''');

  await database.execute('''
      ALTER TABLE ${talent_table.table_name}
      ADD COLUMN ${talent_table.column_sha3_256} TEXT 
      ''');

  await database.execute('''
      ALTER TABLE ${ability_table.table_name}
      ADD COLUMN ${ability_table.column_sha3_256} TEXT 
    ''');
}

Future upgradeTo6(Database database) async {
  // Add columns for abilities and talents having an asset stored on device
  await database.execute('''
    ALTER TABLE ${ability_table.table_name}
    ADD COLUMN ${ability_table.column_have_asset} INTEGER DEFAULT 0
    ''');

  await database.execute('''
    ALTER TABLE ${talent_table.table_name}
    ADD COLUMN ${talent_table.column_have_asset} INTEGER DEFAULT 0
    ''');

  // Ensure all current heroes, talents, and abilities are marked as being on device
  await database.execute('''
    UPDATE ${ability_table.table_name}
    SET ${ability_table.column_have_asset} = 1
    ''');

  await database.execute('''
    UPDATE ${talent_table.table_name}
    SET ${talent_table.column_have_asset}  = 1
    ''');

  await database.execute('''
    UPDATE ${hero_table.table_name}
    SET ${hero_table.column_have_assets}  = 1
    ''');
}

Future upgradeTo8(Database database) async {
  await database.execute('''
    CREATE TABLE 
    IF NOT EXISTS patches (
      Id INTEGER PRIMARY KEY,
      PatchName TEXT,
      OfficialLink TEXT,
      AlternateLink TEXT,
      PatchType TEXT,
      GameVersion TEXT NOT NULL UNIQUE,
      FullVersion TEXT NOT NULL UNIQUE,
      LiveDate DATETIME,
      PatchNotesUrl TEXT
    );
    ''');
}

Future upgradeTo9(Database database) async {
  await database.execute(
  '''
  CREATE TABLE IF NOT EXISTS ${map_table.table_name} (
	Id INTEGER PRIMARY KEY,
	Name TEXT NOT NULL UNIQUE,
	ObjectiveName TEXT,
	ObjectiveStartPrompt TEXT,
	ObjectiveFinishPrompt TEXT,
	ObjectiveStartTime INTEGER,
	ObjectiveInterval INTEGER,
  MapIconFileName TEXT
  );
  '''
  );

  final List<PlayableMap> maps = [
    new PlayableMap(1, 'Battlefield of Eternity', 'The Immortal', 'Capture The Immortal', 'when the Immortal dies', 180, 105, 'legendary-event-1-boe.png'),
    new PlayableMap(2, 'Blackheart\'s Bay', 'The Doubloon Chests', 'Collect treaure from the chests', 'when both chests have been destroyed', 90,180, 'legendary-event-2-blackhearts-bay.png'),
    new PlayableMap(3, 'Braxis Holdout', 'The Beacons', 'Capture the beacons', 'when both Zerg Swarms have been defeated', 90, 130, 'zerg_waves.png'),
    new PlayableMap(4, 'Dragon Shire', 'The Shrines', 'Capture the shrines', 'when the Dragon Knight is defeated', 90, 120, 'legendary-event-2-dragon-shire.png'),
    new PlayableMap(5, 'Garden of Terror', 'Night Time', 'Collect seeds', 'when the garden shamblers are defeated', 180, 200, 'legendary-event-2-garden.png'),
    new PlayableMap(6, 'Haunted Mines', 'The Mines', 'Collect the skulls from the mines','when the Golem is defeated', 180, 120, 'legendary-event-1.png'),
    new PlayableMap(7, 'Infernal Shrines', 'The Shrine', 'Activate the shrine and slay the Guardians', 'when the Punisher is defeated', 180, 115, 'legendary-event-2.png'),
    new PlayableMap(8, 'Sky Temple', 'The Temples', 'Capture the temples', 'when the temples are exhausted', 180, 120, 'legendary-event-3-sky-temple.png'),
    new PlayableMap(9, 'Tomb of the Spider Queen', 'The Webeavers', 'Turn in gems', 'After the webweavers are destroyed', 30, 15, 'legendary-event-3-tomb.png'),
    new PlayableMap(10, 'Tower of Doom', 'The Altars', 'Capture the altars', 'After all the altars have been captured', 180, 110, 'legendary-event-3.png'),
    new PlayableMap(11, 'Volskaya', 'The Protector', 'Capture the objectives', 'When the The Protector has been destroyed', 140, 170, 'objective-volskaya-2.png'),
    new PlayableMap(12, 'Warhead Junction', 'The Warheads', 'Collect the warheads', 'When all the warheads have been collected', 180, 175, 'call_down.png'),
  ];
  Batch batch = database.batch();

  for (PlayableMap map in maps) {
      batch.insert(map_table.table_name, map.toMap());
  }
  await batch.commit(exclusive: true, noResult: true);
}

Future upgradeTo10 (Database database) async {
  await database.execute(
    '''
    DELETE FROM ${patch_table.table_name};
    '''
  );

  await database.execute(
    '''
    ALTER TABLE ${patch_table.table_name}
    ADD COLUMN ${patch_table.column_hots_dog_id} TEXT
    '''
  );
}

Future markAllAbilitiesTalentsOnDevice(Database database) async {
  await database.execute('''
    UPDATE ${ability_table.table_name}
    SET ${ability_table.column_have_asset} = 1
    ''');

  await database.execute('''
    UPDATE ${talent_table.table_name}
    SET ${talent_table.column_have_asset}  = 1
    ''');

  await database.execute('''
    UPDATE ${hero_table.table_name}
    SET ${hero_table.column_have_assets}  = 1
    ''');
}

Future upgradeTo12(Database database) async {
  await database.execute(
    '''
    UPDATE heroes
    SET [AdditionalSearchText] = 'Firebat Terran Heroes of the Storm'
    WHERE [heroes].ShortName = 'blaze'
    '''
  );

  await database.execute(
    '''
    UPDATE heroes
    SET [AdditionalSearchText] = 'Shadowsong Warden Watcher Night Elf Alliance WoW World of Warcraft War3 WC3 Warcraft3 III 3 Frozen Throne FT Warlords Draenor WoD Legion Hearthstone HS'
    WHERE [heroes].ShortName = 'maiev'
    '''
  );
}


Future upgradeTo7(Database database) async {
  await database.execute('''
    ALTER TABLE [heroes]	
    ADD COLUMN [AdditionalSearchText] TEXT DEFAULT ''
    ''');

  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'Zerg Swarm HotS Heart of the Swarm StarCraft II 2 SC2 Star2 Starcraft2 SC slug'
    WHERE [heroes].ShortName = 'abathur'
  ''');

  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'Anubarak Noob Nub Undead Crypt Lord World of WoW Warcraft III 3 War3 WC3 Warcraft3 Frozen Throne FT WotLK Wrath of the Lich King'
    WHERE [heroes].ShortName = 'anubarak'
    ''');

  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'Protoss Aiur LotV Legacy of the Void StarCraft II 2 SC2 Brood War BW SC 1 SC1 Star2 Starcraft2'
    WHERE [heroes].ShortName = 'artanis'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'Lich King Artas LK Prince Menethil Death Knight Undead WoW World of Warcraft III 3 War3 WC3 Warcraft3 Reign of Chaos RoC Frozen Throne FT WotLK Wrath of the Lich King Hearthstone HS'
    WHERE [heroes].ShortName = 'arthas'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'Demon Lord Sin D3 Diablo3 Diablo 3 III dunk'
    WHERE [heroes].ShortName = 'azmodan'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'Sonia Barbarian Nephalem D3 Diablo 3 Diablo3 III Reaper of Souls RoS'
    WHERE [heroes].ShortName = 'sonya'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'The Butcher TheButcher Demon D1 D3 Diablo 1 3 I III Diablo1 Diablo3'
    WHERE [heroes].ShortName = 'butcher'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'Shen Stormstout Pandaren WoW World of Warcraft WC3 Warcraft3 Warcraft III 3 War3 Frozen Throne FT Mists of Pandaria MoP'
    WHERE [heroes].ShortName = 'chen'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'Johana Joana Joanna Crusader Nephalem D3 Diablo 3 Diablo3 III Reaper of Souls RoS'
    WHERE [heroes].ShortName = 'johanna'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'Demon Hunter demonhunter DH Nephalem Nephalem D3 Diablo 3 III  Diablo3 Reaper of Souls RoS'
    WHERE [heroes].ShortName = 'valla'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'Demon Lord Terror D1 D2 D3 Diablo 1 2 3 I II III Diablo1 Diablo2 Diablo3 red'
    WHERE [heroes].ShortName = 'diablo'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'Dryad Night Elf Cenarius WoW World of Warcraft Legion Heroes of the Storm'
    WHERE [heroes].ShortName = 'lunara'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'BW Sprite Darter Faerie Dragon WoW World of Warcraft Legion Heroes of the Storm'
    WHERE [heroes].ShortName = 'brightwing'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'Gryphonrider Wildhammer Dwarf Alliance WoW World of Warcraft Cataclysm'
    WHERE [heroes].ShortName = 'falstad'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'Genn GM Graymane Worgen Gilneas Alliance WoW World of Warcraft War2 WC2 Warcraft2 Tides of Darkness ToD II Cataclysm Legion'
    WHERE [heroes].ShortName = 'greymane'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'Ilidan Stormrage Demon Hunter DH Night Elf WoW World of Warcraft War3 WC3 Warcraft3 III 3 Reign of Chaos RoC Frozen Throne FT Burning Crusade BC Legion'
    WHERE [heroes].ShortName = 'illidan'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'Proudmoore Human Theramore Alliance WoW World of Warcraft War3 WC3 Warcraft3 III Reign of Chaos RoC Frozen Throne FT Burning Crusade BC Wrath Lich King WotLK Cataclysm Mists of Pandaria MoP Warlords Draenor WoD Legion Hearthstone HS'
    WHERE [heroes].ShortName = 'jaina'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'Kaelthas KT Prince Sunstrider Mage Blood Elf WoW World of Warcraft War3 WC3 Warcraft3 III 3 Frozen Throne FT Burning Crusade BC'
    WHERE [heroes].ShortName = 'kaelthas'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'Karrigan Kerigan Sarah Swarm Queen Blades Zerg HotS Heart of the Swarm StarCraft II 2 SC2 Brood War BW LotV Legacy Void Wings Liberty WoL SC 1 SC1 Star2 Starcraft2'
    WHERE [heroes].ShortName = 'kerrigan'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'E.T.C. Elite Tauren Chieftain ETC etc Level 90 Horde Heroes of the Storm WoW'
    WHERE [heroes].ShortName = 'etc'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'Skeleton King Tristram Undead Diablo Diablo1 Diablo3 D1 I 1 D3 III 3'
    WHERE [heroes].ShortName = 'leoric'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'Li Pandaren WoW World of Warcraft Mists of Pandaria MoP'
    WHERE [heroes].ShortName = 'lili'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'TLV LV TheLostVikings Olaf Eric Baleog 2 LV2 Classic'
    WHERE [heroes].ShortName = 'lostvikings'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'Stormrage Night Elf Druid Alliance WoW World of Warcraft War3 WC3 Warcraft3 War III 3 Reign of Chaos RoC Frozen Throne FT Cataclysm Warlords Draenor WoD Legion Hearthstone HS'
    WHERE [heroes].ShortName = 'malfurion'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'Lt. Morales Medic Lieutenant LtMorales Terran Heroes of the Storm SC Brood War BW'
    WHERE [heroes].ShortName = 'ltmorales'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'Karazim Monk Nephalem D3 Diablo 3 III Reaper of Souls RoS Diablo3'
    WHERE [heroes].ShortName = 'kharazim'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'Bronzebeard Dwarf Alliance Warcraft III War3 WC3 Warcraft3 3 Reign of Chaos RoC  WoW Wrath of the Lich King WotLK Cataclysm'
    WHERE [heroes].ShortName = 'muradin'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'Murloc WoW Legion Heroes of the Storm'
    WHERE [heroes].ShortName = 'murky'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'Xuul Zuul Zul Zool Necromancer Human D2 Diablo 2 II Diablo2'
    WHERE [heroes].ShortName = 'xul'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'Terra Ghost November Terran SC2 StarCraft 2 II Wings of Liberty WoL Heart of the Swarm HotS SC Covert Ops CO Star2 Starcraft2'
    WHERE [heroes].ShortName = 'nova'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'General James Jimmy Commander Marine Terran HotS Heart of the Swarm SC SC1 StarCraft II 2 SC2 Brood War BW LotV Legacy Void Wings Liberty WoL Star2 Starcraft2'
    WHERE [heroes].ShortName = 'raynor'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'Regar Earthfury Orc Shaman Horde WoW World of Warcraft Legion'
    WHERE [heroes].ShortName = 'rehgar'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'RexarMisha Chieftan Beastmaster Hunter Half Orc Ogre Horde WoW World of Warcraft War3 WC3 Warcraft3 III Frozen Throne FT Burning Crusade BC Warlords Draenor WoD Legion Hearthstone HS'
    WHERE [heroes].ShortName = 'rexxar'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'Sgt. Hammer Sergeant SgtHammer Sgt Siege Tank Terran Heroes of the Storm StarCraft II SC 2 SC2 Legacy of the Void LotV Star2 Starcraft2'
    WHERE [heroes].ShortName = 'sgthammer'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'Abomination Undead WoW World of Warcraft hook'
    WHERE [heroes].ShortName = 'stitches'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'Windrunner Queen Forsaken Undead Elf Horde WoW World of Warcraft War3 WC3 Warcraft3 III Reign of Chaos RoC Frozen Throne FT Cataclysm Warlords Draenor WoD Legion warchief'
    WHERE [heroes].ShortName = 'sylvanas'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'High Templar hightemplar HT Protoss Aiur SC StarCraft 1 SC1 Star1 Starcraft1'
    WHERE [heroes].ShortName = 'tassadar'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'Trall Go''el Goel Warchief Shaman Orc Horde WoW World of Warcraft War3 WC3 Warcraft3 III 3 Reign of Chaos RoC Frozen Throne FT Burning Crusade BC Wrath Lich King WotLK Cataclysm Mists of Pandaria MoP Legion Hearthstone HS'
    WHERE [heroes].ShortName = 'thrall'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'Tinker Goblin Horde WoW World of Warcraft War3 WC3 Warcraft3 III 3 Frozen Throne FT Cataclysm Warlords Draenor WoD'
    WHERE [heroes].ShortName = 'gazlowe'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'Findlay Marine Outlaw Terran SC2 SC 2 II StarCraft Wings of Liberty WoL Star2 Starcraft2'
    WHERE [heroes].ShortName = 'tychus'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'Angel Justice D2 D3 Diablo2 Diablo3 Diablo 2 3 III Lord of Destruction LoD Reaper of Souls RoS'
    WHERE [heroes].ShortName = 'tyrael'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'Whisperwind Priestess Elune Night Elf High Huntress Alliance WoW World of Warcraft War3 WC3 Warcraft3 III 3 Reign of Chaos RoC Frozen Throne FT Cataclysm Mists of Pandaria MoP Warlords Draenor WoD Legion Hearthstone HS'
    WHERE [heroes].ShortName = 'tyrande'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'Paladin Lightbringer Human Alliance WoW War2 WC2 Warcraft2 2 II Tides of Darkness ToD World of Warcraft War3 WC3 Warcraft3 III 3 Reign of Chaos RoC Hearthstone HS'
    WHERE [heroes].ShortName = 'uther'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'Witch Doctor Witchdoctor Nephalem D3 Diablo 3 Diablo3 III Reaper of Souls RoS WD'
    WHERE [heroes].ShortName = 'nazeebo'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'Li-Ming Li Ming LiMing LM Leeming Wizard Nephalem D3 Diablo 3 Diablo3 III Reaper of Souls RoS'
    WHERE [heroes].ShortName = 'liming'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'Broodmother Queen Zerg Swarm HotS Heart of the Swarm StarCraft II 2 SC2 SC Star2 Starcraft2'
    WHERE [heroes].ShortName = 'zagara'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'ZT Dark Templar DT Prelate Protoss HotS Heart of the Swarm StarCraft II 2 SC2 Brood War BW LotV Legacy Void Wings Liberty WoL SC 1 SC1 Star2 Starcraft2 Star1 Starcraft1'
    WHERE [heroes].ShortName = 'zeratul'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'Axethrower Troll Horde War2 WC2 Warcraft2 Warcraft II 2 Tides of Darkness ToD World of Warcraft WoW Burning Crusade BC'
    WHERE [heroes].ShortName = 'zuljin'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'Aleksandra Human Overwatch OW'
    WHERE [heroes].ShortName = 'zarya'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'Wrynn Logosh Lo''Gosh Stormwind Human Alliance WoW World of Warcraft Wrath of the Lich King WotLK Cataclysm Mists of Pandaria MoP Warlords of Draenor WoD Legion'
    WHERE [heroes].ShortName = 'varian'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'Valera Sanguinar Rogue Blood Elf WoW World of Warcraft Legion Hearthstone HS'
    WHERE [heroes].ShortName = 'valeera'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'Lena Oxton Human Overwatch OW'
    WHERE [heroes].ShortName = 'tracer'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'Firelord Molten Core MC Elemental WoW World of Warcraft Cataclysm Hearthstone HS'
    WHERE [heroes].ShortName = 'ragnaros'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'Stewkov Starcraft Brood War BW SC2 SC Heart of the Swarm HotS Legacy of the Void LotV Zerg Infested Terran UED'
    WHERE [heroes].ShortName = 'stukov'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'Orc Blademaster Horde Warcraft III 3 War3 Warcraft3 WC3 Frozen Throne FT WoW'
    WHERE [heroes].ShortName = 'samuro'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'Probe Protoss SC SC1 StarCraft II 2 SC2 Star2 Starcraft2'
    WHERE [heroes].ShortName = 'probius'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'Midivh Prophet War1 I WC1 Warcraft1 Warcraft3 Warcraft III WC3 War3 3 Reign of Chaos RoC WoW World of Warcraft Burning Crusade BC Hearthstone HS'
    WHERE [heroes].ShortName = 'medivh'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'Malthel Malthiel Angel Archangel Diablo 3 D3 Reaper of Souls RoS'
    WHERE [heroes].ShortName = 'malthael'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'Human Overwatch OW'
    WHERE [heroes].ShortName = 'lucio'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'KT Kelthuzad Archlich of Naxxramas esteemed Lich Lord of the Plaguelands Commander of the Dread Necropolis Master and Founder of the The Damned Return formerly of the Council of Six Creator of the Abomination Summoner of Archimonde the Defiler Betrayer of Humanity Hearthstone Enthusiast and Majordomo to the Lich King undead WC3 Reign of Chaos Frozen Throne FT WoW Wrath WotLK'
    WHERE [heroes].ShortName = 'kelthuzad'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'Junker Junkdude Grenademans Human Overwatch OW Jamison Fawkes'
    WHERE [heroes].ShortName = 'junkrat'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'Human Overwatch OW Shimada'
    WHERE [heroes].ShortName = 'hanzo'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'Orc Warlock War1 1 I War2 War3 WC1 WC2 WC3 Warcraft1 Warcraft2 Warcraft3 Warcraft 2 Tides of Darkness ToD II 2 III 3 Reign of Chaos RoC WoW World of Warcraft Burning Crusade BC Warlords of Draenor WoD Legion Horde Hearthstone HS'
    WHERE [heroes].ShortName = 'guldan'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'Human Cyborg Overwatch OW Shimada'
    WHERE [heroes].ShortName = 'genji'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'WoW Orc Warchief Mists of Pandaria MoP Warlords of Draenor WoD Burning Crusade BC Hearthstone HS Wrath of the Lich King WotLK Cataclysm Horde'
    WHERE [heroes].ShortName = 'garrosh'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'Dva Diva Hana Song Overwatch OW Human'
    WHERE [heroes].ShortName = 'dva'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'Dahaka Deaka Primal Zerg SC 2 SC2 Star2 Starcraft2 StarCraft II Heart of the Swarm HotS'
    WHERE [heroes].ShortName = 'dehaka'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'Chronormu Bronze Dragon WoW World of Warcraft Wrath of the Lich King WotLK Cataclysm Mists of Pandaria MoP Warlords of Draenor WoD'
    WHERE [heroes].ShortName = 'chromie'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'Cho''gall Chogall gall Ogre Twoheaded Two Headed Two-headed War2 Warcraft2 WC2 Warcraft II 2 Tides of Darkness ToD WoW World of Warcraft Cataclysm Warlords of Draenor WoD Horde'
    WHERE [heroes].ShortName = 'cho'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'Cho''gall Chogall Ogre Twoheaded Two Headed Two-headed War2 Warcraft2 WC2 Warcraft II 2 Tides of Darkness ToD WoW World of Warcraft Cataclysm Warlords of Draenor WoD Horde'
    WHERE [heroes].ShortName = 'gall'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'Ariel Angel Archangel Diablo 3 III D3 Diablo3'
    WHERE [heroes].ShortName = 'auriel'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'Anna Human EyeOfHorus OW Amari'
    WHERE [heroes].ShortName = 'ana'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'Casia Amazon Javazon D2 Diablo 2 II Diablo2 Human'
    WHERE [heroes].ShortName = 'cassia'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'Alexstraza Alekstrasza Alekstraza Warcraft 2 WC2 WoW Cataclysm Wrath of the Lich King WotLK dragon elf Queen of Dragons'
    WHERE [heroes].ShortName = 'alexstrasza'
    ''');
  await database.execute('''
    UPDATE [heroes]
    SET [AdditionalSearchText] = [heroes].[AdditionalSearchText] || 'Ascendant Protoss SC SC2 StarCraft Star2 Starcraft2 II 2 Legacy of the Void LotV Covert Ops CO'
    WHERE [heroes].ShortName = 'alarak'
    ''');
  //endregion
}
