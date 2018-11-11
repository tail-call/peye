-- Observable mixin for Lua tables

local observe = {}

local OBSERVE_KEY = {}

function changed(self, key, ...)
    for i, f in ipairs(self[OBSERVE_KEY]) do
	f(self, key, ...)
    end
end

function observe.it(model)
    model[OBSERVE_KEY] = {}
    model.changed = changed
end

function observe.watch(model, callback)
    assert(model[OBSERVE_KEY], "observe.watch: model not watchable");

    table.insert(model[OBSERVE_KEY], callback);
end

return observe
