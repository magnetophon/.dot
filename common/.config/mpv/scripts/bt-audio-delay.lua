-- Automatically compensate for Bluetooth audio latency in MPV.
-- Bluetooth typically adds 100-300ms of delay, causing video to
-- appear ahead of audio. This script detects BT audio and applies
-- a negative audio-delay to shift audio earlier, keeping sync.

local BT_DELAY = -0.2  -- seconds; adjust to match your BT device

local function check_bluetooth()
  local current = mp.get_property("audio-device") or "auto"
  local bt = false

  -- Scan MPV's known audio devices for Bluetooth indicators.
  -- PipeWire exposes BT sinks with "bluez" or "bluetooth" in
  -- the device name/description. When the active device is "auto",
  -- MPV delegates to PipeWire's default sink, so we check if any
  -- default-like device is a BT sink.
  local devices = mp.get_property_native("audio-device-list", {})
  for _, dev in ipairs(devices) do
    local name = dev.name or ""
    local desc = dev.description or ""
    if name:find("[Bb]luez") or desc:find("[Bb]luetooth") then
      if name:find("default") or current == "auto" then
        bt = true
        break
      end
    end
  end

  -- Apply delay for BT, reset to 0 otherwise
  mp.set_property_number("audio-delay", bt and BT_DELAY or 0)
end

-- file-loaded: check on each new file
-- audio-reconfig: re-check when audio output changes (e.g. BT connect/disconnect)
mp.register_event("audio-reconfig", check_bluetooth)
mp.register_event("file-loaded", check_bluetooth)
