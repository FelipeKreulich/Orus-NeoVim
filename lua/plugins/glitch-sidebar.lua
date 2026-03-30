return {
  {
    name = "glitch-sidebar",
    dir = vim.fn.stdpath("config") .. "/lua/glitch",
    config = function()
      local panels = {
        left = { buf = nil, win = nil, timer = nil },
        right = { buf = nil, win = nil, timer = nil },
      }
      local width = 22

      local blocks = { "█", "▓", "▒", "░", "▄", "▀", "▌", "▐", "▆", "▇", "▊", "▋", "▍", "▎", "▏", "▖", "▗", "▘", "▙", "▚", "▛", "▜", "▝", "▞", "▟" }
      local glitch_chars = { "╔", "╗", "╚", "╝", "║", "═", "╠", "╣", "╦", "╩", "╬", "┼", "┤", "├", "┴", "┬", "│", "─", "◈", "◇", "◆", "●", "○", "◐", "◑", "⬡", "⬢", "⎔", "⏣", "⏢" }
      local syms = { "0", "1", ":", ";", ".", "|", "/", "\\", "-", "=", "+", "*", "#", "@", "!", "?", "$", "%", "&", "~" }
      local katakana = { "ア", "イ", "ウ", "エ", "オ", "カ", "キ", "ク", "ケ", "コ", "サ", "シ", "ス", "セ", "ソ", "タ", "チ", "ツ", "テ", "ト", "ナ", "ニ", "ヌ", "ネ", "ノ" }

      local function rand_char(set)
        return set[math.floor(math.random() * #set) + 1]
      end

      local function truncate_utf8(line, max)
        local result = ""
        local count = 0
        for p in string.gmatch(line, "[%z\1-\127\194-\244][\128-\191]*") do
          if count >= max then break end
          result = result .. p
          count = count + 1
        end
        while count < max do
          result = result .. " "
          count = count + 1
        end
        return result
      end

      -- Estilo esquerda: glitch caótico (blocos, circuitos, noise)
      local function gen_left_frame(h)
        local lines = {}
        local phase = (vim.loop.now() / 1000) % 10
        for i = 1, h do
          local line = ""
          local mode = math.random(1, 6)
          if mode == 1 then
            for _ = 1, width do
              line = line .. (math.random() > 0.6 and rand_char(syms) or " ")
            end
          elseif mode == 2 then
            local seg = math.random(2, 6)
            for _ = 1, seg do
              for _ = 1, math.random(1, math.floor(width / seg)) do
                line = line .. rand_char(blocks)
              end
              line = line .. string.rep(" ", math.random(1, 3))
            end
          elseif mode == 3 then
            for _ = 1, width do
              line = line .. (math.random() > 0.4 and rand_char(glitch_chars) or " ")
            end
          elseif mode == 4 then
            local offset = math.floor(math.sin((i + phase * 3) * 0.5) * (width / 3) + (width / 2))
            offset = math.max(1, math.min(width - 2, offset))
            line = string.rep(" ", offset) .. rand_char(blocks) .. rand_char(blocks)
          elseif mode == 5 then
            if math.random() > 0.7 then
              line = string.rep(rand_char({ "─", "═", "━", "▬" }), width)
            else
              line = ""
            end
          else
            for _ = 1, width do
              line = line .. (math.random() > 0.85 and rand_char(syms) or " ")
            end
          end
          table.insert(lines, truncate_utf8(line, width))
        end
        return lines
      end

      -- Estilo direita: matrix rain (katakana caindo)
      local columns = {}
      local function gen_right_frame(h)
        -- Inicializar colunas
        if #columns == 0 then
          for c = 1, width do
            columns[c] = {
              pos = math.random(1, h),
              speed = math.random(1, 3),
              len = math.random(4, math.floor(h / 2)),
              tick = 0,
            }
          end
        end

        -- Grid vazio
        local grid = {}
        local bright = {}
        for r = 1, h do
          grid[r] = {}
          bright[r] = {}
          for c = 1, width do
            grid[r][c] = " "
            bright[r][c] = 0
          end
        end

        -- Atualizar colunas e preencher grid
        for c = 1, width do
          local col = columns[c]
          col.tick = col.tick + 1
          if col.tick >= col.speed then
            col.tick = 0
            col.pos = col.pos + 1
            if col.pos - col.len > h then
              col.pos = math.random(-10, 0)
              col.speed = math.random(1, 3)
              col.len = math.random(4, math.floor(h / 2))
            end
          end

          for r = 1, h do
            local dist = col.pos - r
            if dist >= 0 and dist < col.len then
              if dist == 0 then
                -- Cabeça: char brilhante
                grid[r][c] = rand_char(katakana)
                bright[r][c] = 3
              elseif dist < 3 then
                grid[r][c] = rand_char(katakana)
                bright[r][c] = 2
              elseif dist < col.len then
                if math.random() > 0.3 then
                  grid[r][c] = rand_char(katakana)
                else
                  grid[r][c] = rand_char(syms)
                end
                bright[r][c] = 1
              end
            end
          end
        end

        -- Converter grid em linhas
        local lines = {}
        local brightness = {}
        for r = 1, h do
          local line = ""
          local row_bright = {}
          for c = 1, width do
            line = line .. grid[r][c]
            table.insert(row_bright, bright[r][c])
          end
          table.insert(lines, truncate_utf8(line, width))
          table.insert(brightness, row_bright)
        end
        return lines, brightness
      end

      local hl_left = { "GlitchGreen", "GlitchRed", "GlitchCyan", "GlitchDim", "GlitchPurple" }

      local function setup_highlights()
        vim.api.nvim_set_hl(0, "GlitchGreen", { fg = "#00ff41" })
        vim.api.nvim_set_hl(0, "GlitchRed", { fg = "#ff0040" })
        vim.api.nvim_set_hl(0, "GlitchCyan", { fg = "#00d4ff" })
        vim.api.nvim_set_hl(0, "GlitchDim", { fg = "#333333" })
        vim.api.nvim_set_hl(0, "GlitchPurple", { fg = "#b000ff" })
        vim.api.nvim_set_hl(0, "MatrixHead", { fg = "#ffffff", bold = true })
        vim.api.nvim_set_hl(0, "MatrixBright", { fg = "#00ff41" })
        vim.api.nvim_set_hl(0, "MatrixDim", { fg = "#006b1a" })
        vim.api.nvim_set_hl(0, "MatrixDark", { fg = "#002b0a" })
      end

      local function open_panel(side)
        local p = panels[side]
        if p.win and vim.api.nvim_win_is_valid(p.win) then return end

        p.buf = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_option(p.buf, "bufhidden", "wipe")
        vim.api.nvim_buf_set_option(p.buf, "buftype", "nofile")
        vim.api.nvim_buf_set_option(p.buf, "swapfile", false)
        vim.api.nvim_buf_set_option(p.buf, "filetype", "glitch")

        if side == "left" then
          vim.cmd("topleft vsplit")
        else
          vim.cmd("botright vsplit")
        end

        p.win = vim.api.nvim_get_current_win()
        vim.api.nvim_win_set_buf(p.win, p.buf)
        vim.api.nvim_win_set_width(p.win, width)

        vim.api.nvim_win_set_option(p.win, "number", false)
        vim.api.nvim_win_set_option(p.win, "relativenumber", false)
        vim.api.nvim_win_set_option(p.win, "signcolumn", "no")
        vim.api.nvim_win_set_option(p.win, "foldcolumn", "0")
        vim.api.nvim_win_set_option(p.win, "cursorline", false)
        vim.api.nvim_win_set_option(p.win, "wrap", false)
        vim.api.nvim_win_set_option(p.win, "winfixwidth", true)

        -- Voltar pra janela do código
        if side == "left" then
          vim.cmd("wincmd l")
        else
          vim.cmd("wincmd h")
        end

        setup_highlights()
        local ns = vim.api.nvim_create_namespace("glitch_" .. side)

        p.timer = vim.loop.new_timer()
        local interval = side == "left" and 150 or 80
        p.timer:start(0, interval, vim.schedule_wrap(function()
          if not p.buf or not vim.api.nvim_buf_is_valid(p.buf) then
            if p.timer then p.timer:stop(); p.timer:close(); p.timer = nil end
            return
          end
          if not p.win or not vim.api.nvim_win_is_valid(p.win) then
            if p.timer then p.timer:stop(); p.timer:close(); p.timer = nil end
            return
          end

          local h = vim.api.nvim_win_get_height(p.win)

          vim.api.nvim_buf_set_option(p.buf, "modifiable", true)

          if side == "left" then
            local lines = gen_left_frame(h)
            vim.api.nvim_buf_set_lines(p.buf, 0, -1, false, lines)
            vim.api.nvim_buf_clear_namespace(p.buf, ns, 0, -1)
            for i = 0, #lines - 1 do
              vim.api.nvim_buf_add_highlight(p.buf, ns, hl_left[math.random(1, #hl_left)], i, 0, -1)
            end
          else
            local lines, brightness = gen_right_frame(h)
            vim.api.nvim_buf_set_lines(p.buf, 0, -1, false, lines)
            vim.api.nvim_buf_clear_namespace(p.buf, ns, 0, -1)
            for i = 0, #lines - 1 do
              -- Colorir linha toda baseado no brilho máximo
              local max_b = 0
              if brightness[i + 1] then
                for _, b in ipairs(brightness[i + 1]) do
                  if b > max_b then max_b = b end
                end
              end
              local hl = max_b == 3 and "MatrixHead" or max_b == 2 and "MatrixBright" or max_b == 1 and "MatrixDim" or "MatrixDark"
              vim.api.nvim_buf_add_highlight(p.buf, ns, hl, i, 0, -1)
            end
          end

          vim.api.nvim_buf_set_option(p.buf, "modifiable", false)
        end))
      end

      local function close_panel(side)
        local p = panels[side]
        if p.timer then p.timer:stop(); p.timer:close(); p.timer = nil end
        if p.win and vim.api.nvim_win_is_valid(p.win) then
          vim.api.nvim_win_close(p.win, true)
        end
        p.win = nil
        p.buf = nil
        if side == "right" then columns = {} end
      end

      local function toggle(side)
        local p = panels[side]
        if p.win and vim.api.nvim_win_is_valid(p.win) then
          close_panel(side)
        else
          open_panel(side)
        end
      end

      local function toggle_both()
        local left_open = panels.left.win and vim.api.nvim_win_is_valid(panels.left.win)
        local right_open = panels.right.win and vim.api.nvim_win_is_valid(panels.right.win)
        if left_open or right_open then
          close_panel("left")
          close_panel("right")
        else
          open_panel("left")
          open_panel("right")
        end
      end

      vim.keymap.set("n", "<leader>gl", function() toggle("left") end, { desc = "Toggle glitch esquerda" })
      vim.keymap.set("n", "<leader>gr", function() toggle("right") end, { desc = "Toggle glitch direita (matrix)" })
      vim.keymap.set("n", "<leader>gg", toggle_both, { desc = "Toggle glitch ambos lados" })
    end,
  },
}
