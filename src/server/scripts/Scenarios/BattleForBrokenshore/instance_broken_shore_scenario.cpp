/*
 * Copyright (C) 2017-2018 AshamaneProject <https://github.com/AshamaneProject>
 * Copyright (C) 2008-2026 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2025-2026 LegionEmulationProject <https://github.com/LegionEmulationProject>
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
#include "Scenario.h"
#include "InstanceScenario.h"
#include "InstanceScript.h"
#include "ScenarioMgr.h"
#include "broken_shore_scenario.h"
#include "GameObject.h"
#include "Vehicle.h"
#include "Transport.h"
#include "MoveSplineInit.h"
#include "EventMap.h"
#include "Player.h"
#include "Map.h"
#include "Creature.h"
#include "Log.h"


class instance_broken_shore_scenario : public InstanceMapScript
{
public:
    instance_broken_shore_scenario() : InstanceMapScript("scenario_broken_shore_7.0", 1460) {}

    struct instance_broken_shore_scenario_InstanceScript : public InstanceScript
    {
        instance_broken_shore_scenario_InstanceScript(InstanceMap* map) : InstanceScript(map) {}

        void OnPlayerEnter(Player* player) override
        {
            if (!player)
                return;

            if (!player->GetScenario())
                return;
        }
    };

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_broken_shore_scenario_InstanceScript(map);
    }
};

void AddSC_scenario_broken_shore()
{
    new instance_broken_shore_scenario();
}