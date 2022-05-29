-- COMMENT −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−


require('Comment').setup(
	{
	    ---Lines to be ignored while comment/uncomment.
	    ---Could be a regex string or a function that returns a regex string.
	    ---Example: Use '^$' to ignore empty lines
	    ---@type string|fun():string
	    ignore = '^$',
	}
)
