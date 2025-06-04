require("zoxide"):setup {
  update_db = true,
}
require("projects"):setup({
                         })


-- Old tab bar style https://github.com/sxyazi/yazi/pull/2782
function Tabs.height() return 0 end

Header:children_add(function()
    if #cx.tabs == 1 then return "" end
    local spans = {}
    for i = 1, #cx.tabs do
      spans[#spans + 1] = ui.Span(" " .. i .. " ")
    end
    spans[cx.tabs.idx]:reverse()
    return ui.Line(spans)
end, 9000, Header.RIGHT)
-- END: Old tab bar style https://github.com/sxyazi/yazi/pull/2782
