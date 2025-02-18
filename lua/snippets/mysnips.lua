local ls = require "luasnip"
-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require "luasnip.util.types"
local conds = require "luasnip.extras.conditions"
local conds_expand = require "luasnip.extras.conditions.expand"

-- If you're reading this file for the first time, best skip to around line 190
-- where the actual snippet-definitions start.

-- Every unspecified option will be set to the default.
-- ls.setup({
-- 	keep_roots = true,
-- 	link_roots = true,
-- 	link_children = true,
--
-- 	-- Update more often, :h events for more info.
-- 	update_events = "TextChanged,TextChangedI",
-- 	-- Snippets aren't automatically removed if their text is deleted.
-- 	-- `delete_check_events` determines on which events (:h events) a check for
-- 	-- deleted snippets is performed.
-- 	-- This can be especially useful when `history` is enabled.
-- 	delete_check_events = "TextChanged",
-- 	ext_opts = {
-- 		[types.choiceNode] = {
-- 			active = {
-- 				virt_text = { { "choiceNode", "Comment" } },
-- 			},
-- 		},
-- 	},
-- 	-- treesitter-hl has 100, use something higher (default is 200).
-- 	ext_base_prio = 300,
-- 	-- minimal increase in priority.
-- 	ext_prio_increase = 1,
-- 	enable_autosnippets = true,
-- 	-- mapping for cutting selected text so it's usable as SELECT_DEDENT,
-- 	-- SELECT_RAW or TM_SELECTED_TEXT (mapped via xmap).
-- 	store_selection_keys = "<Tab>",
-- 	-- luasnip uses this function to get the currently active filetype. This
-- 	-- is the (rather uninteresting) default, but it's possible to use
-- 	-- eg. treesitter for getting the current filetype by setting ft_func to
-- 	-- require("luasnip.extras.filetype_functions").from_cursor (requires
-- 	-- `nvim-treesitter/nvim-treesitter`). This allows correctly resolving
-- 	-- the current filetype in eg. a markdown-code block or `vim.cmd()`.
-- 	ft_func = function()
-- 		return vim.split(vim.bo.filetype, ".", true)
-- 	end,
-- })

-- args is a table, where 1 is the text in Placeholder 1, 2 the text in
-- placeholder 2,...
-- local function copy(args)
-- 	return args[1]
-- end

-- 'recursive' dynamic snippet. Expands to some text followed by itself.
local rec_ls
rec_ls = function()
  return sn(
    nil,
    c(1, {
      -- Order is important, sn(...) first would cause infinite loop of expansion.
      t "",
      sn(nil, { t { "", "\t\\item " }, i(1), d(2, rec_ls, {}) }),
    })
  )
end

-- complicated function for dynamicNode.
-- local function jdocsnip(args, _, old_state)
-- 	-- !!! old_state is used to preserve user-input here. DON'T DO IT THAT WAY!
-- 	-- Using a restoreNode instead is much easier.
-- 	-- View this only as an example on how old_state functions.
-- 	local nodes = {
-- 		t({ "/**", " * " }),
-- 		i(1, "A short Description"),
-- 		t({ "", "" }),
-- 	}
--
-- 	-- These will be merged with the snippet; that way, should the snippet be updated,
-- 	-- some user input eg. text can be referred to in the new snippet.
-- 	local param_nodes = {}
--
-- 	if old_state then
-- 		nodes[2] = i(1, old_state.descr:get_text())
-- 	end
-- 	param_nodes.descr = nodes[2]
--
-- 	-- At least one param.
-- 	if string.find(args[2][1], ", ") then
-- 		vim.list_extend(nodes, { t({ " * ", "" }) })
-- 	end
--
-- 	local insert = 2
-- 	for indx, arg in ipairs(vim.split(args[2][1], ", ", true)) do
-- 		-- Get actual name parameter.
-- 		arg = vim.split(arg, " ", true)[2]
-- 		if arg then
-- 			local inode
-- 			-- if there was some text in this parameter, use it as static_text for this new snippet.
-- 			if old_state and old_state[arg] then
-- 				inode = i(insert, old_state["arg" .. arg]:get_text())
-- 			else
-- 				inode = i(insert)
-- 			end
-- 			vim.list_extend(
-- 				nodes,
-- 				{ t({ " * @param " .. arg .. " " }), inode, t({ "", "" }) }
-- 			)
-- 			param_nodes["arg" .. arg] = inode
--
-- 			insert = insert + 1
-- 		end
-- 	end
--
-- 	if args[1][1] ~= "void" then
-- 		local inode
-- 		if old_state and old_state.ret then
-- 			inode = i(insert, old_state.ret:get_text())
-- 		else
-- 			inode = i(insert)
-- 		end
--
-- 		vim.list_extend(
-- 			nodes,
-- 			{ t({ " * ", " * @return " }), inode, t({ "", "" }) }
-- 		)
-- 		param_nodes.ret = inode
-- 		insert = insert + 1
-- 	end
--
-- 	if vim.tbl_count(args[3]) ~= 1 then
-- 		local exc = string.gsub(args[3][2], " throws ", "")
-- 		local ins
-- 		if old_state and old_state.ex then
-- 			ins = i(insert, old_state.ex:get_text())
-- 		else
-- 			ins = i(insert)
-- 		end
-- 		vim.list_extend(
-- 			nodes,
-- 			{ t({ " * ", " * @throws " .. exc .. " " }), ins, t({ "", "" }) }
-- 		)
-- 		param_nodes.ex = ins
-- 		insert = insert + 1
-- 	end
--
-- 	vim.list_extend(nodes, { t({ " */" }) })
--
-- 	local snip = sn(nil, nodes)
-- 	-- Error on attempting overwrite.
-- 	snip.old_state = param_nodes
-- 	return snip
-- end

-- Make sure to not pass an invalid command, as io.popen() may write over nvim-text.
-- local function bash(_, _, command)
-- 	local file = io.popen(command, "r")
-- 	local res = {}
-- 	for line in file:lines() do
-- 		table.insert(res, line)
-- 	end
-- 	return res
-- end

-- Returns a snippet_node wrapped around an insertNode whose initial
-- text value is set to the current date in the desired format.
-- local date_input = function(args, snip, old_state, fmt)
-- 	local fmt = fmt or "%Y-%m-%d"
-- 	return sn(nil, i(1, os.date(fmt)))
-- end

-- snippets are added via ls.add_snippets(filetype, snippets[, opts]), where
-- opts may specify the `type` of the snippets ("snippets" or "autosnippets",
-- for snippets that should expand directly after the trigger is typed).
--
-- opts can also specify a key. By passing an unique key to each add_snippets, it's possible to reload snippets by
-- re-`:luafile`ing the file in which they are defined (eg. this one).
--
-- 在 LuaSnip 中，代码片段由节点 (nodes) 组成。节点包括：
--    textNode：静态文本(t)
--    insertNode：可编辑的文本(i)
--           展开后，光标位于 InstertNode 1
--           跳跃后，将位于 InsertNode 2
--           再次跳跃后，将位于 InsertNode 0
--           如果在片段中未找到第 0 个 InsertNode，则会在所有其他节点之后自动插入一个。
--    functionNode：函数节点，可从其他节点的内容生成的文本(f)
--    其他节点
--        choiceNode：在两个节点（或更多节点）之间进行选择(c)
--        restoreNode：存储和恢复到节点的输入(r)
--    dynamicNode：动态节点，基于输入生成的节点(d)
-- 通常使用 s(trigger:string, nodes:table) 形式的函数创建代码片段。
-- s 接收以下可能选项的表作为第一个参数：
-- | 选项      | 类型            | 默认值 | 说明                                                                                   |
-- |-----------+-----------------+--------+----------------------------------------------------------------------------------------|
-- | trig      | string          |        | 唯一必须提供的选项，触发的文字(默认的第一个参数)                                       |
-- | name      | string          |        | 可用于 nvim-compe 等其他插件识别片段                                                   |
-- | dscr      | string 或 table |        | 片段的描述，多行时使用 \n 分隔的字符串或者表                                           |
-- | wordTrig  | boolean         | true   | true 时，片段只在光标前的字 ([%w_]+) 与 trigger 相符时展开                             |
-- | regTrig   | boolean         | false  | trigger 是否被解释成 lua 模式                                                          |
-- | docstring | string          |        | 片段的文本表示，类似于 dscr；覆盖从 json 中加载的 docstring                            |
-- | docTrig   | string          |        | 对于使用 lua 模式所触发的片段：定义用于生成 docstring 的 trigger                       |
-- | hidden    | boolean         | false  | 提示补全引擎：true 时，在查询片段时不应该展示该片段                                    |
-- | priority  | 正数            | 1000   | 片段的优先级：高优先级先于低优先级匹配触发；多个片段的优先级也可在 add_snippets 中设置 |
-- s 的第二个参数是一个表，其中包含属于该片段的所有节点。如果该表只有一个节点，则可以直接传递该节点，而无需将其包装在表中。
--
--  NOTE: too complicated for third parameter!
--
--  s 的第三个参数 (opts) 是一个包含以下有效键的表：
-- | 选项                                 | 形式                                                  | 默认值           |
-- |--------------------------------------+-------------------------------------------------------+------------------|
-- | condition                            | fn(line_to_cursor, matched_trigger, captures) -> bool | 返回 true 的函数 |
-- | show_condition                       | f(line_to_cursor) -> bool                             | 返回 true 的函数 |
-- | callbacks                            |                                                       |                  |
-- | child_ext_opts、merge_child_ext_opts |                                                       |                  |

ls.add_snippets("all", {
  s("hello", t "hello world!"),
  s("ternary", {
    i(1, "cond"),
    t " ? ",
    i(2, "then"),
    t " : ",
    i(3, "else"),
  }),
}, {
  key = "all",
})

ls.add_snippets("cpp", {
  s(
    "sc",
    fmt(
      [[
      std::cout << {} << '\n';
      ]],
      {
        i(1, ""),
      }
    )
  ),
})

ls.add_snippets("tex", {
  -- rec_ls is self-referencing. That makes this snippet 'infinite' eg. have as many
  -- \item as necessary by utilizing a choiceNode.
  -- s("ls", {
  --   t { "\\begin{itemize}", "\t\\item " },
  --   i(1),
  --   d(2, rec_ls, {}),
  --   t { "", "\\end{itemize}" },
  -- }),
  s(
    "ilim",
    fmt(
      [[
\lim_{{{} \rightarrow \infty}}]],
      {
        i(1, "x"),
      }
    )
  ),
  s(
    "aa",
    fmt([[${1}$]], {
      i(1, ""),
    })
  ),
  s(
    "tj",
    fmt(
      [[
{{\scriptsize （{}\textcolor{{{}}}{{{}}}{}）}}
    ]],
      {
        i(1, ""),
        i(2, "red"),
        i(3, ""),
        i(4, ""),
      }
    )
  ),
  s(
    "dps",
    fmt(
      [[
       \tkzDefPoints{{{},{},{}}}\tkzDrawPolygon({})
       \tkzLabelPoint(B){{$B$}}\tkzLabelPoint(C){{$C$}}\tkzLabelPoint[above](A){{$A$}}
      ]],
      {
        i(1, "0/0/B"),
        i(2, "5/0/C"),
        i(3, "4/4/A"),
        i(4, "A,B,C"),
      }
    )
  ),
  s(
    "tri",
    fmt([[$\triangle {}$]], {
      i(1, "ABC"),
    })
  ),
  s(
    "tep",
    fmt(
      [[
	      \begin{{figure}}[H]
		      \raggedleft
		      \begin{{tikzpicture}}[scale=1]
          {}
		      \end{{tikzpicture}}
	      \end{{figure}}
      ]],
      {
        i(0),
      }
    )
  ),
  s(
    "twoasy",
    fmt(
      [[
\begin{{figure}}[ht]
	\centering
	\begin{{minipage}}[b]{{0.45\textwidth}}
		\begin{{asy}}
			unitsize({} cm);
			import patterns;
			add("bengal",hatch(0.8mm,blue));
			dot((0,0));
		\end{{asy}}
	\end{{minipage}}
	\qquad
	\begin{{minipage}}[b]{{0.45\textwidth}}
		\begin{{asy}}
			unitsize(1 cm);
			import patterns;
			add("bengal",hatch(0.8mm,blue));
			dot((0,0));
		\end{{asy}}
	\end{{minipage}}
\end{{figure}}
  ]],
      {
        i(1, "1"),
      }
    )
  ),
  s(
    "problem",
    fmt(
      [[
	\item {}
	      \begin{{figure}}[ht]
		      \raggedleft
		      \begin{{asy}}
			      unitsize(1 cm);
			      import patterns;
            // import olympiad;
			      add("bengal",hatch(0.8mm,blue+opacity(0.5)));
            pair A,B,C{};
            A=({});B=({});C=({});
            {}
		      \end{{asy}}
	      \end{{figure}}
      ]],
      {
        i(1, "Problem Description."),
        i(2, ",D,E,F;"),
        i(3, "0,0"),
        i(4, "4,0"),
        i(5, "0,4"),
        i(6, "dot((0,0));"),
      }
    )
  ),
}, {
  key = "tex",
})
