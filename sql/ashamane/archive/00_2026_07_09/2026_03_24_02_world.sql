-- cleanup startup logs

DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_warr_lambs_to_the_slaughter';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_pri_phantasm';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_pri_divine_aegis';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_warr_sword_and_board';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_hun_improved_mend_pet';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_sha_lightning_shield';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_sha_earth_shield';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_dru_mark_of_the_wild';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_pri_lightwell_renew';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_shaman_windfury_weapon';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_pal_blessing_of_might';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_pal_blessing_of_kings';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_warr_retaliation';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_pri_power_word_fortitude';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_mark_of_nature';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_pri_shadow_protection';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_sha_glyph_of_shamanistic_rage';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_sha_nature_guardian';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_archimonde_drain_world_tree_dummy';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_dk_plague_strike';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_pri_pain_and_suffering_proc';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_warl_molten_core_dot';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_pri_mind_sear';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_dk_blood_gorged';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_warr_vigilance';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_warr_vigilance_trigger';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_hun_invigoration';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_sha_glyph_of_healing_wave';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_gen_dungeon_credit';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_dk_glyph_of_deaths_embrace';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_warr_improved_spell_reflection';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_gen_ds_flush_knockback';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_xt002_heart_overload_periodic';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_pri_hymn_of_hope';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_pos_ice_shards';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_putricide_slime_puddle_aura';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_halion_spawn_living_embers';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_sha_fulmination';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_springvale_forsaken_ability';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_wind_burst';

UPDATE `creature_template` SET `ScriptName`='' WHERE `entry` IN (36283, 36269, 37694, 37953, 37067, 36231, 36459, 38762, 43337, 36332, 36440, 37065, 36268,
34571, 36267, 36452, 36488, 38765, 43336, 44928, 36743, 37876, 36331, 36290, 38764, 37783, 36405, 36409, 36555, 36606, 36540, 36205, 24616, 37078, 38051, 36741);

UPDATE `creature_template` SET `ScriptName`='' WHERE `ScriptName`='npc_velen_shadowmoon_begin';
UPDATE `creature_template` SET `ScriptName`='' WHERE `ScriptName`='npc_velen_shadowmoon_follower';