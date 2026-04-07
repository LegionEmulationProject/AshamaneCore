/*
 * Copyright (C) 2008-2018 TrinityCore <https://www.trinitycore.org/>
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "ScriptMgr.h"
#include "Player.h"
#include "LFGMgr.h"

enum BattleForBrokenshore
{
   SPELL_LEAVE_FOR_BROKENSHORE_CLIENT_SCENE = 216356,
   SPELL_LEAVE_FOR_BROKENSHORE_ALLIANCE     = 217273,
   LFG_SCENARIO_BROKENSHORE                 = 908,
};

uint8 GetRoleMask(Player* player)
{
   uint8 roleMask = lfg::LfgRoles::PLAYER_ROLE_NONE;
   if (auto const& group = player->GetGroup())
       roleMask |= lfg::LfgRoles::PLAYER_ROLE_LEADER;
   return roleMask | lfg::LfgRoles::PLAYER_ROLE_DAMAGE;
}

class scene_battle_for_brokenshore_alliance : public SceneScript
{
public:
    scene_battle_for_brokenshore_alliance() : SceneScript("scene_battle_for_brokenshore_alliance") { }

    void OnSceneEnd(Player* player, uint32 /*sceneInstanceID*/, SceneTemplate const* /*SceneTemplate*/) override
    {
        lfg::LfgDungeonSet dungeons = { LFG_SCENARIO_BROKENSHORE };
        sLFGMgr->JoinLfg(player, GetRoleMask(player), dungeons);
        player->TeleportTo(WorldLocation(1460, Position(-1063.734741, 1918.939697f, 10.205732f, 6.272131f)), TeleportToOptions::TELE_TO_NOT_LEAVE_TRANSPORT);
    }
};

void AddSC_stormwind_city()
{
    new scene_battle_for_brokenshore_alliance();
}
