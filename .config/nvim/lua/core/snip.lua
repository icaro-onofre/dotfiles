local ls = require "lussnip"

local s, i,t= ls.s, ls.insert_node, ls.text_node
local fmt = require("luasnip.extras.fmt").fmt

local funcc = s("functional component", {
	t(" function componente(props,) return ( <>  </>); } "),
	i(1,"$1")
})
table.insert(funcc)
