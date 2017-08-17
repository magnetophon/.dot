ardour {
	["type"]    = "dsp",
	name        = "Lua Rider 4.1r",
	category    = "Lua",
	license     = "MIT",
	author      = "Russell//Nikolaus",
	description = [[Lua Rider v4.1r]]
}

function dsp_ioconfig () 
	return
	{
		{ audio_in = -1, audio_out = -1},
	}
end

function dsp_params ()
	return
	{
		{ ["type"] = "input", name = "Target", min = -24, max = 6, default = -6, doc = "Target volume" },
		{ ["type"] = "output", name = "Level", min = -120, max = 12 },
		{ ["type"] = "output", name = "Fader", min = -48, max = 6 },
		{ ["type"] = "input", name = "Range", min = 0, max = 48, default = 24, doc = "Fader ride range" },
		{ ["type"] = "input", name = "Max Gain", min = 0, max = 6, default = 0.5, doc = "Max positive gain" },
		{ ["type"] = "input", name = "Smoothing ", min = 0.1, max = 6, default = 1, doc = "Smoothing Control" },
		{ ["type"] = "input", name = "Switch Automation Write On Play", min = 0, max = 1, default = 0, toggled = true },
		{ ["type"] = "input", name = "Expansion Threshold", min = -48, max = 0, default = -48, doc = "Expansion control for tidying the track" },
		{ ["type"] = "input", name = "Expansion Depth", min = -24, max = 0, default = 0, doc = "Expansion depth" },

	}
end

local lpf = 0.2
local new_gain = 0
local a = 0

function dsp_init (rate)  
	local ctrl = CtrlPorts:array()
	lpf =   780 / rate
end

function dsp_configure (ins, outs)
	n_channels = ins:n_audio()
end

function low_pass_filter_param (old, now, limit)
	if math.abs (old - now) < limit  then
		return now
	else
		return old + lpf * (now - old)
	end
end

function dsp_runmap (bufs, in_map, out_map, n_samples, offset, ins, outs)
	local ctrl = CtrlPorts:array()
	
	if not wasRolling then
		local  wasRolling = true
	else 
		wasRolling = wasRolling
	end

	if Session:transport_rolling() and (ctrl[7] == 1)   then
		self:route():gain_control():set_automation_state(ARDOUR.AutoState.Write)
		wasRolling = true
	end
	if not Session:transport_rolling() and (wasRolling == true) and (ctrl[7] == 1) then
		self:route():gain_control():set_automation_state(ARDOUR.AutoState.Play)
		wasRolling = false
	end

	for c = 1,n_channels do
		local b = in_map:get(ARDOUR.DataType("audio"), c - 1)
		if b ~= ARDOUR.ChanMapping.Invalid then
			a = ARDOUR.DSP.accurate_coefficient_to_dB(ARDOUR.DSP.compute_peak(bufs:get_audio(b):data(offset), n_samples, 0))
			--a = low_pass_filter_param(a, d, (1 / ctrl[6]))
		end
	end

	function gain()
		gain = math.abs(a) + (ctrl[1]/0.3535)
		if gain > ctrl[5] then gain = ctrl[5] end
		if gain > ctrl[4]/4 then gain = gain + ctrl[4]/4 end
		if gain < 0 - ctrl[4] then gain = 0 - ctrl[4] end
		if a < ctrl[8] then gain = 0 + ctrl[9] end
		return gain
	end
	
	gain = gain()
	new_gain = low_pass_filter_param(new_gain, gain, (1 / ctrl[6]))
	self:route():gain_control():set_value(ARDOUR.DSP.dB_to_coefficient(new_gain), PBD.GroupControlDisposition.NoGroup)
	
	ctrl[2] = math.ceil(a)
	ctrl[3] = new_gain
end