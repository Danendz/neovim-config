local export = {}

local commentsForExtension = {
	css = { " /\\*", " \\*/" },
	html = { "<!--", "-->" },
	js = { " /\\*", " \\*/" },
	jsx = { " /\\*", " \\*/" },
	ts = { " /\\*", " \\*/" },
	tsx = { " /\\*", " \\*/" },
}

local closeBrackets = {
	["{"] = "}",
	["("] = ")",
	["["] = "]",
}

local openBrackets = { "\\{", "\\(", "\\[" }

local function getCommentsByExtension()
	local extension = vim.fn.expand("%:e")
	local comments = commentsForExtension[extension]
	return comments
end

local function commentLine()
	local comments = getCommentsByExtension()
	if comments == nil then
		return
	end
	local insertCommentPattern = "s/.*/" .. comments[1]:gsub("%/", "\\/") .. "&" .. comments[2]:gsub("%/", "\\/")

	local currentLine = vim.fn.getline(".")

	if string.find(currentLine, comments[1]) and string.find(currentLine, comments[2]) then
		vim.cmd("s:" .. comments[1] .. ":")
		vim.cmd("s:" .. comments[2] .. ":")
	else
		vim.cmd(insertCommentPattern)
	end
end

local function commentMultipleLines()
	local comments = getCommentsByExtension()
	if comments == nil then
		return
	end
	local insertCommentFisrtLine = "'<s/.*/" .. comments[1]:gsub("%/", "\\/") .. "&"
	local insertCommentSecondLine = "'>s/.*/" .. "&" .. comments[2]:gsub("%/", "\\/")
	vim.cmd(insertCommentFisrtLine)
	vim.cmd(insertCommentSecondLine)
end


export.commentLine = commentLine
export.commentMultipleLines = commentMultipleLines

return export
