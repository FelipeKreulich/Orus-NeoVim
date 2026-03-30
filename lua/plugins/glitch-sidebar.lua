return {
  {
    name = "glitch-sidebar",
    dir = vim.fn.stdpath("config") .. "/lua/glitch",
    config = function()
      local buf = nil
      local win = nil
      local timer = nil
      local width = 22

      local blocks = { "█", "▓", "▒", "░", "▄", "▀", "▌", "▐", "▆", "▇", "▊", "▋", "▍", "▎", "▏", "▖", "▗", "▘", "▙", "▚", "▛", "▜", "▝", "▞", "▟" }
      local glitch_chars = { "╔", "╗", "╚", "╝", "║", "═", "╠", "╣", "╦", "╩", "╬", "┼", "┤", "├", "┴", "┬", "│", "─", "◈", "◇", "◆", "●", "○", "◐", "◑", "⬡", "⬢", "⎔", "⏣", "⏢" }
      local syms = { "0", "1", ":", ";", ".", "|", "/", "\\", "-", "=", "+", "*", "#", "@", "!", "?", "$", "%", "&", "~" }

      local function rand_char(set)
        return set[math.floor(math.random() * #set) + 1]
      end

      local function gen_glitch_frame()
        local lines = {}
        local h = vim.api.nvim_win_get_height(win)
        local phase = (vim.loop.now() / 1000) % 10

        for i = 1, h do
          local line = ""
          local mode = math.random(1, 6)

          if mode == 1 then
            -- Matrix rain
            for _ = 1, width do
              if math.random() > 0.6 then
                line = line .. rand_char(syms)
              else
                line = line .. " "
              end
            end
          elseif mode == 2 then
            -- Block glitch
            local seg = math.random(2, 6)
            for _ = 1, seg do
              local len = math.random(1, math.floor(width / seg))
              for _ = 1, len do
                line = line .. rand_char(blocks)
              end
              if #line < width then
                line = line .. string.rep(" ", math.random(1, 3))
              end
            end
          elseif mode == 3 then
            -- Box drawing circuit
            for _ = 1, width do
              if math.random() > 0.4 then
                line = line .. rand_char(glitch_chars)
              else
                line = line .. " "
              end
            end
          elseif mode == 4 then
            -- Sine wave
            local offset = math.floor(math.sin((i + phase * 3) * 0.5) * (width / 3) + (width / 2))
            offset = math.max(1, math.min(width - 2, offset))
            line = string.rep(" ", offset) .. rand_char(blocks) .. rand_char(blocks)
          elseif mode == 5 then
            -- Scanline
            if math.random() > 0.7 then
              line = string.rep(rand_char({ "─", "═", "━", "▬" }), width)
            else
              line = string.rep(" ", width)
            end
          else
            -- Sparse noise
            for _ = 1, width do
              if math.random() > 0.85 then
                line = line .. rand_char(syms)
              else
                line = line .. " "
              end
            end
          end

          -- Truncar ao tamanho certo
          local result = ""
          local count = 0
          for p, c in vim.fn.strcharidx and string.gmatch(line, "[%z\1-\127\194-\244][\128-\191]*") or string.gmatch(line, ".") do
            if count >= width then break end
            result = result .. p
            count = count + 1
          end
          while count < width do
            result = result .. " "
            count = count + 1
          end

          table.insert(lines, result)
        end
        return lines
      end

      local function open_sidebar()
        if win and vim.api.nvim_win_is_valid(win) then return end

        buf = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
        vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
        vim.api.nvim_buf_set_option(buf, "swapfile", false)
        vim.api.nvim_buf_set_option(buf, "filetype", "glitch")

        vim.cmd("topleft vsplit")
        win = vim.api.nvim_get_current_win()
        vim.api.nvim_win_set_buf(win, buf)
        vim.api.nvim_win_set_width(win, width)

        vim.api.nvim_win_set_option(win, "number", false)
        vim.api.nvim_win_set_option(win, "relativenumber", false)
        vim.api.nvim_win_set_option(win, "signcolumn", "no")
        vim.api.nvim_win_set_option(win, "foldcolumn", "0")
        vim.api.nvim_win_set_option(win, "cursorline", false)
        vim.api.nvim_win_set_option(win, "wrap", false)
        vim.api.nvim_win_set_option(win, "winfixwidth", true)

        -- Voltar pra janela anterior
        vim.cmd("wincmd l")

        -- Highlights
        vim.api.nvim_set_hl(0, "GlitchGreen", { fg = "#00ff41" })
        vim.api.nvim_set_hl(0, "GlitchRed", { fg = "#ff0040" })
        vim.api.nvim_set_hl(0, "GlitchCyan", { fg = "#00d4ff" })
        vim.api.nvim_set_hl(0, "GlitchDim", { fg = "#333333" })
        vim.api.nvim_set_hl(0, "GlitchPurple", { fg = "#b000ff" })

        local hl_groups = { "GlitchGreen", "GlitchRed", "GlitchCyan", "GlitchDim", "GlitchPurple" }
        local ns = vim.api.nvim_create_namespace("glitch")

        timer = vim.loop.new_timer()
        timer:start(0, 150, vim.schedule_wrap(function()
          if not buf or not vim.api.nvim_buf_is_valid(buf) then
            if timer then timer:stop(); timer:close(); timer = nil end
            return
          end
          if not win or not vim.api.nvim_win_is_valid(win) then
            if timer then timer:stop(); timer:close(); timer = nil end
            return
          end

          local lines = gen_glitch_frame()
          vim.api.nvim_buf_set_option(buf, "modifiable", true)
          vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
          vim.api.nvim_buf_set_option(buf, "modifiable", false)

          -- Colorir linhas aleatoriamente
          vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
          for i = 0, #lines - 1 do
            local hl = hl_groups[math.random(1, #hl_groups)]
            vim.api.nvim_buf_add_highlight(buf, ns, hl, i, 0, -1)
          end
        end))
      end

      local function close_sidebar()
        if timer then timer:stop(); timer:close(); timer = nil end
        if win and vim.api.nvim_win_is_valid(win) then
          vim.api.nvim_win_close(win, true)
        end
        win = nil
        buf = nil
      end

      local function toggle_sidebar()
        if win and vim.api.nvim_win_is_valid(win) then
          close_sidebar()
        else
          open_sidebar()
        end
      end

      vim.keymap.set("n", "<leader>gg", toggle_sidebar, { desc = "Toggle glitch sidebar" })
    end,
  },
}
