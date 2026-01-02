require("zoxide"):setup {
  update_db = true,
}
require("projects"):setup({
                         })


-- Old tab bar style https://github.com/sxyazi/yazi/pull/2782
-- This implementation, with names came from:
-- https://github.com/boydaihungst/.config/blob/c696dddf66720cb6cae41db76fe8d59c9f29ed03/yazi/init.lua#L189-L207

function Tabs.height()
  return 0
end

Header:children_add(function()
    if #cx.tabs <= 1 then
      return ""
    end
    local spans = {}
    for i = 1, #cx.tabs do
      local name = ui.truncate(string.format(" %d %s ", i, cx.tabs[i].name), { max = 20 })
      if i == cx.tabs.idx then
        spans[#spans + 1] = ui.Span(" " .. name .. " "):style(th.tabs.active)
      else
        spans[#spans + 1] = ui.Span(" " .. name .. " "):style(th.tabs.inactive)
      end
    end
    return ui.Line(spans)
end, 9000, Header.RIGHT)
-- END: Old tab bar style https://github.com/sxyazi/yazi/pull/2782
