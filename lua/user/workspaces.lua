local status_ok, workspaces = pcall(require, "workspaces")
if not status_ok then
	return
end

workspaces.setup({
   hooks = {
        open = { "NvimTreeOpen", "Telescope find_files" },
    }
})
