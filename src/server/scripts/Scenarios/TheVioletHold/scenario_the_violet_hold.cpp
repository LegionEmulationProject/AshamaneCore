/*
 * This file is part of the The Legion Emulation Project. See AUTHORS file for Copyright information
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

#include "Creature.h"
#include "GameObject.h"
#include "PhasingHandler.h"
#include "Player.h"
#include "Log.h"
#include "InstanceScenario.h"
#include "InstanceScript.h"
#include "Scenario.h"
#include "scenario_the_violet_hold.h"

struct scenario_the_violet_hold : public InstanceScript
{
    scenario_the_violet_hold(InstanceMap* map) : InstanceScript(map) { Initialize(); }

    void Initialize()
    {
        KillCount = 0;
        m_meryl_felstormGUID = ObjectGuid::Empty;
        m_kathra_natirGUID = ObjectGuid::Empty;
        m_forge_of_the_guardianGUID = ObjectGuid::Empty;
        m_alodiGUID = ObjectGuid::Empty;
    }

    void OnPlayerEnter(Player* player)
    {
        player->SendDungeonDifficulty(DIFFICULTY_3_MAN_SCENARIO_N);
    }

    void OnCreatureCreate(Creature* creature)
    {
        InstanceScript::OnCreatureCreate(creature);
        switch (creature->GetEntry())
        {
        case NPC_MERYL_FELSTORM:
            m_meryl_felstormGUID = creature->GetGUID();
            break;
        case NPC_KATHRA_NATIR:
            m_kathra_natirGUID = creature->GetGUID();
            break;
        case NPC_FORGE_OF_THE_GUARDIAN:
            m_forge_of_the_guardianGUID = creature->GetGUID();
            break;
        case NPC_ALODI:
            m_alodiGUID = creature->GetGUID();
            break;
        }
    }

    void OnUnitDeath(Unit* who)
    {

    }
    int32 needKillCount = 4;
    int32 KillCount;
    ObjectGuid m_meryl_felstormGUID;
    ObjectGuid m_kathra_natirGUID;
    ObjectGuid m_forge_of_the_guardianGUID;
    ObjectGuid m_prison_sealGUID;
    ObjectGuid m_alodiGUID;
};

void AddSC_scenario_the_violet_hold()
{
    RegisterInstanceScript(scenario_the_violet_hold, 1494);
}
