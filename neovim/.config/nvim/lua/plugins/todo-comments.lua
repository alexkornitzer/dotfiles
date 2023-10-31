-- Todo-Comments: Highlight, list and search todo comments in your projects
return {
  "folke/todo-comments.nvim",
  opts = {
		keywords = {
			FIX = {icon = "F "},
    	TODO = { icon = "T "},
    	HACK = { icon = "H "},
    	WARN = { icon = "W "},
    	PERF = { icon = "P "},
    	NOTE = { icon = "  "},
    	TEST = { icon = "⏲ "},
		}
	},
  config = function(_, opts)
    require('todo-comments').setup(opts)
	end
}
