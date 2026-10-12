-- Fakes just enough of an hs.axuielement object for hs.spaces' Mission Control lookup:
-- field access for attributes and attributeValue("AXChildren").
local function fakeElement(identifier, children)
  return {
    AXIdentifier   = identifier,
    AXChildren     = children or {},
    attributeValue = function(self, name) return rawget(self, name) end,
  }
end

function testMissionControlGroupInDock()
  local mcGroup = fakeElement("mc", { fakeElement("mc.display") })
  local dock = fakeElement(nil, { fakeElement(nil), mcGroup })
  local windowManager = fakeElement(nil, {})

  assertIsEqual(mcGroup, hs.spaces._missionControlGroupFrom(dock, windowManager))
  return success()
end

function testMissionControlGroupInWindowManager()
  -- macOS 27: the Dock only keeps an empty `mc` stub, the tree lives in WindowManager
  local dock = fakeElement(nil, { fakeElement(nil), fakeElement("mc") })
  local windowManager = fakeElement(nil, { fakeElement("mc.display"), fakeElement("mc.display") })

  assertIsEqual(windowManager, hs.spaces._missionControlGroupFrom(dock, windowManager))
  return success()
end

function testMissionControlGroupNotPopulated()
  -- Mission Control is showing but its tree is not built yet: keep waiting rather than return the stub
  local dock = fakeElement(nil, { fakeElement("mc") })
  local windowManager = fakeElement(nil, {})

  assertIsNil(hs.spaces._missionControlGroupFrom(dock, windowManager))
  return success()
end

function testMissionControlGroupClosed()
  local dock = fakeElement(nil, { fakeElement(nil) })
  local windowManager = fakeElement(nil, {})

  assertIsNil(hs.spaces._missionControlGroupFrom(dock, windowManager))
  assertIsNil(hs.spaces._missionControlGroupFrom(dock, nil))
  return success()
end
