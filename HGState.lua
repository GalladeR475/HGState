-- << STATE >> --
-- A minimalist state module functionality

local RunService = game:GetService("RunService");

local State = {
	Unknown = -1;
	Patrolling = 1;
	Chasing = 2;
	Hearing = 3;
	Teleporting = 4;
};
State.__index = State;

-- << CONSTRUCTOR >> --
function State.new(): {}
	local self = setmetatable({
		Value = State.Unknown;
		OnStateChange = Instance.new("BindableEvent") :: BindableEvent;
	}, State);
	return self;
end;

-- << EMIT STATE >> --
function State:EmitState(value: number): ()
	local oldValue = rawget(self, "Value")
	rawset(self, "Value", value);
	self.OnStateChange:Fire(value, oldValue);
end;

-- << WHILE STATE >> --
function State:WhileState(value: number, func: (...any) -> (...any)): ()
	RunService.Heartbeat:Connect(function(dt: number)
		if (rawget(self, "Value") == value) then
			func();
		end
	end);
end;

return State;
