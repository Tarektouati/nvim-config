local status_ok, spectre = pcall(require, "spectre")
if not status_ok then
	return
end


local status_ok, actions = pcall(require, "spectre_actions")
if not status_ok then
	return
end


spectre.setup({
  color_devicons = true,
  open_cmd = 'vnew',
  live_update = false, -- auto excute search again when you write any file in vim
  line_sep_start = '┌-----------------------------------------',
  result_padding = '¦  ',
  line_sep       = '└-----------------------------------------',
  highlight = {
      ui = "String",
      search = "DiffChange",
      replace = "DiffDelete"
  },
  mapping={
    ['toggle_line'] = {
        map = "dd",
        cmd = spectre.toggle_line,
        desc = "toggle current item"
    },
    ['enter_file'] = {
        map = "<cr>",
        cmd = actions.select_entry,
        desc = "goto current file"
    },
    ['send_to_qf'] = {
        map = "<leader>q",
        cmd = actions.send_to_qf,
        desc = "send all item to quickfix"
    },
    ['replace_cmd'] = {
        map = "<leader>c",
        cmd = actions.replace_cmd,
        desc = "input replace vim command"
    },
    ['show_option_menu'] = {
        map = "<leader>o",
        cmd = spectre.show_options,
        desc = "show option"
    },
    ['run_replace'] = {
        map = "<leader>R",
        cmd = actions.run_replace,
        desc = "replace all"
    },
    ['change_view_mode'] = {
        map = "<leader>v",
        cmd = spectre.change_view,
        desc = "change result view mode"
    },
    ['toggle_live_update']={
      map = "tu",
      cmd = spectre.toggle_live_update,
      desc = "update change when vim write file."
    },
    ['toggle_ignore_case'] = {
      map = "ti",
      cmd = spectre.change_options('ignore-case'),
      desc = "toggle ignore case"
    },
    ['toggle_ignore_hidden'] = {
      map = "th",
      cmd = spectre.change_options('hidden'),
      desc = "toggle search hidden"
    },
    -- you can put your mapping here it only use normal mode
  },
  find_engine = {
    -- rg is map with finder_cmd
    ['rg'] = {
      cmd = "rg",
      -- default args
      args = {
        '--color=never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
      } ,
      options = {
        ['ignore-case'] = {
          value= "--ignore-case",
          icon="[I]",
          desc="ignore case"
        },
        ['hidden'] = {
          value="--hidden",
          desc="hidden file",
          icon="[H]"
        },
        -- you can put any rg search option you want here it can toggle with
        -- show_option function
      }
    },
    ['ag'] = {
      cmd = "ag",
      args = {
        '--vimgrep',
        '-s'
      } ,
      options = {
        ['ignore-case'] = {
          value= "-i",
          icon="[I]",
          desc="ignore case"
        },
        ['hidden'] = {
          value="--hidden",
          desc="hidden file",
          icon="[H]"
        },
      },
    },
  },
  replace_engine={
      ['sed']={
          cmd = "sed",
          args = nil
      },
      options = {
        ['ignore-case'] = {
          value= "--ignore-case",
          icon="[I]",
          desc="ignore case"
        },
      }
  },
  default = {
      find = {
          --pick one of item in find_engine
          cmd = "rg",
          options = {"ignore-case"}
      },
      replace={
          --pick one of item in replace_engine
          cmd = "sed"
      }
  },
  replace_vim_cmd = "cdo",
  is_open_target_win = true, --open file on opener window
  is_insert_mode = false  -- start open panel on is_insert_mode
})

vim.cmd [[
  nnoremap <leader>S :lua require('spectre').open()<CR>
  nnoremap <leader>sw :lua require('spectre').open_visual({select_word=true})<CR>
  vnoremap <leader>s :lua require('spectre').open_visual()<CR>
  nnoremap <leader>sp viw:lua require('spectre').open_file_search()<cr>
]]
