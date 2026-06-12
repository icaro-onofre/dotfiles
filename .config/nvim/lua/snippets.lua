local ls = require("luasnip")
local s  = ls.snippet
local t  = ls.text_node
local i  = ls.insert_node
local f  = ls.function_node

ls.add_snippets("python", {

    -- Static snippet
    s("def", {
        t("def "), i(1, "function_name"), t("("), i(2, "args"), t("):"),
        t({"", "    "}), i(3, "pass"),
    }),

    -- With dynamic content
    s("class", {
        t("class "), i(1, "ClassName"), t(":"),
        t({"", "    def __init__(self):"}),
        t({"", "        "}), i(2, "pass"),
    }),
})
