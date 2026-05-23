return {
  {
    name = "hacker-panels",
    dir = vim.fn.stdpath("config") .. "/lua/glitch",
    config = function()
      local panels = {}
      local width = 30

      -- ═══════════════════════════════════════
      -- UTILS
      -- ═══════════════════════════════════════

      local function truncate(line, max)
        if #line > max then return line:sub(1, max) end
        while #line < max do line = line .. " " end
        return line
      end

      local function rand_hex(len)
        local s = ""
        for _ = 1, len do
          s = s .. string.format("%x", math.random(0, 15))
        end
        return s
      end

      local function rand_ip()
        return string.format("%d.%d.%d.%d", math.random(1,255), math.random(0,255), math.random(0,255), math.random(1,254))
      end

      local function rand_pick(t)
        return t[math.random(1, #t)]
      end

      -- ═══════════════════════════════════════
      -- FAKE HACKER TERMINAL
      -- ═══════════════════════════════════════

      local hacker_log = {}
      local hacker_tick = 0

      local status_msgs = {
        "SCANNING PORT %d...",
        "BRUTE FORCE %s:22",
        "SSH TUNNEL OPEN %s",
        "DECRYPT 0x%s...",
        "PACKET SNIFF %s:%d",
        "FIREWALL BYPASS %s",
        "INJECTING PAYLOAD...",
        "ROOT SHELL OBTAINED",
        "DUMPING /etc/shadow",
        "EXFIL DATA >> %s",
        "TRACE ROUTE %s",
        "ARP SPOOF %s",
        "DNS POISON %s",
        "MITM ACTIVE %s:%d",
        "KEYLOG STREAM ACTIVE",
        "BACKDOOR INSTALLED",
        "ENCRYPTING CHANNEL...",
        "C2 BEACON %s:%d",
        "PROXY CHAIN ACTIVE",
        "VPN TUNNEL %s",
      }

      local hex_prefixes = { "0x", "\\x", "0b", ">> ", "<< ", ":: " }

      local function gen_hacker_line()
        local r = math.random(1, 10)
        if r <= 4 then
          -- Status message
          local msg = rand_pick(status_msgs)
          local ip = rand_ip()
          local port = math.random(1024, 65535)
          local hex = rand_hex(8)
          -- Substituir placeholders manualmente pra evitar erros de tipo
          local formatted = msg:gsub("%%s", ip):gsub("%%d", tostring(port))
          return "[" .. os.date("%H:%M:%S") .. "] " .. formatted
        elseif r <= 6 then
          -- Hex dump
          return rand_pick(hex_prefixes) .. rand_hex(math.random(16, 24))
        elseif r <= 7 then
          -- Access result
          local results = {
            ">>> ACCESS GRANTED <<<",
            ">>> CONNECTION ESTABLISHED <<<",
            ">>> SHELL SPAWNED <<<",
            ">>> EXPLOIT SUCCESS <<<",
            "!!! ALERT: IDS TRIGGERED !!!",
            "!!! TRACE DETECTED !!!",
            "--- RECONNECTING ---",
            "--- ROTATING PROXY ---",
          }
          return rand_pick(results)
        elseif r <= 8 then
          -- Progress bar
          local pct = math.random(10, 100)
          local filled = math.floor(pct / 5)
          return "[" .. string.rep("█", filled) .. string.rep("░", 20 - filled) .. "] " .. pct .. "%"
        elseif r <= 9 then
          -- Port scan result
          return string.format("  %d/tcp  open  %s", math.random(1,65535),
            rand_pick({"ssh","http","https","ftp","mysql","smb","rdp","telnet","vnc","redis"}))
        else
          -- Separator
          return string.rep(rand_pick({"─","═","━","╌"}), width)
        end
      end

      local function gen_hacker_frame(h)
        hacker_tick = hacker_tick + 1
        -- Adicionar novas linhas a cada tick
        if hacker_tick % 2 == 0 then
          local new_lines = math.random(1, 3)
          for _ = 1, new_lines do
            table.insert(hacker_log, gen_hacker_line())
          end
        end
        -- Manter apenas as últimas h*2 linhas
        while #hacker_log > h * 2 do
          table.remove(hacker_log, 1)
        end
        -- Retornar as últimas h linhas
        local lines = {}
        local start = math.max(1, #hacker_log - h + 1)
        for i = start, #hacker_log do
          table.insert(lines, truncate(hacker_log[i], width))
        end
        while #lines < h do
          table.insert(lines, 1, truncate("", width))
        end
        return lines
      end

      -- ═══════════════════════════════════════
      -- EKG / HEARTBEAT
      -- ═══════════════════════════════════════

      local ekg_offset = 0
      -- Heartbeat pattern (altura por coluna)
      local beat_pattern = {
        0,0,0,0,0,0,1,0,0,0,
        0,0,0,3,0,-2,0,0,0,7,
        8,4,-3,-4,0,0,0,0,1,2,
        1,0,0,0,0,0,0,0,0,0
      }

      local function gen_ekg_frame(h)
        ekg_offset = ekg_offset + 1
        local mid = math.floor(h / 2)
        local lines = {}

        for r = 1, h do
          lines[r] = string.rep(" ", width)
        end

        -- Header
        local bpm = math.random(118, 142)
        lines[1] = truncate("  ♥ BPM: " .. bpm .. "  SYS: ONLINE", width)
        lines[2] = truncate(string.rep("─", width), width)

        -- Desenhar onda EKG
        for col = 1, width do
          local pattern_idx = ((col + ekg_offset - 1) % #beat_pattern) + 1
          local val = beat_pattern[pattern_idx]
          local row = mid - val
          row = math.max(3, math.min(h - 2, row))

          -- Desenhar o ponto e trail
          local row_str = lines[row]
          if row_str then
            local chars = {}
            for i = 1, #row_str do chars[i] = row_str:sub(i,i) end
            if col <= #chars then
              chars[col] = "█"
            end
            lines[row] = table.concat(chars)
          end

          -- Linha vertical fina conectando pontos
          if col > 1 then
            local prev_idx = ((col - 1 + ekg_offset - 1) % #beat_pattern) + 1
            local prev_val = beat_pattern[prev_idx]
            local prev_row = mid - prev_val
            prev_row = math.max(3, math.min(h - 2, prev_row))
            local r1 = math.min(row, prev_row)
            local r2 = math.max(row, prev_row)
            for r = r1 + 1, r2 - 1 do
              if r >= 3 and r <= h - 2 then
                local rstr = lines[r]
                local rchars = {}
                for i = 1, #rstr do rchars[i] = rstr:sub(i,i) end
                if col <= #rchars and rchars[col] == " " then
                  rchars[col] = "│"
                end
                lines[r] = table.concat(rchars)
              end
            end
          end
        end

        -- Baseline
        for col = 1, width do
          local row_str = lines[mid]
          local chars = {}
          for i = 1, #row_str do chars[i] = row_str:sub(i,i) end
          if col <= #chars and chars[col] == " " then
            chars[col] = "·"
          end
          lines[mid] = table.concat(chars)
        end

        -- Footer
        lines[h-1] = truncate(string.rep("─", width), width)
        lines[h] = truncate("  SIG:" .. rand_hex(6) .. " RT:" .. math.random(1,15) .. "ms", width)

        for i = 1, h do
          lines[i] = truncate(lines[i], width)
        end

        return lines
      end

      -- ═══════════════════════════════════════
      -- OSCILLOSCOPE
      -- ═══════════════════════════════════════

      local osc_phase = 0

      local function gen_osc_frame(h)
        osc_phase = osc_phase + 0.15
        local lines = {}
        local mid = math.floor(h / 2)

        for r = 1, h do
          lines[r] = string.rep(" ", width)
        end

        -- Header
        lines[1] = truncate("  ◈ SCOPE  48kHz  CH:1", width)
        lines[2] = truncate(string.rep("─", width), width)

        -- Múltiplas ondas sobrepostas
        local waves = {
          { freq = 1.0, amp = 0.6, phase_off = 0 },
          { freq = 2.3, amp = 0.3, phase_off = 1.5 },
          { freq = 0.4, amp = 0.8, phase_off = 0.7 },
        }

        -- Selecionar onda ativa (muda a cada ~3s)
        local active_wave = math.floor(osc_phase / 2) % 4
        local draw_area = h - 4
        local draw_mid = math.floor(draw_area / 2) + 3

        for col = 1, width do
          local total = 0
          for w_i, wave in ipairs(waves) do
            if active_wave == 0 or active_wave == w_i then
              local x = (col / width) * math.pi * 2 * wave.freq
              total = total + math.sin(x + osc_phase + wave.phase_off) * wave.amp
            end
          end

          -- Adicionar noise
          total = total + (math.random() - 0.5) * 0.15

          -- Normalizar para range de desenho
          local row = draw_mid - math.floor(total * (draw_area / 3))
          row = math.max(3, math.min(h - 2, row))

          local chars = {}
          for i = 1, #lines[row] do chars[i] = lines[row]:sub(i,i) end
          if col <= #chars then
            chars[col] = "█"
          end
          lines[row] = table.concat(chars)

          -- Ponto na baseline
          local mid_chars = {}
          for i = 1, #lines[draw_mid] do mid_chars[i] = lines[draw_mid]:sub(i,i) end
          if col <= #mid_chars and mid_chars[col] == " " then
            mid_chars[col] = "·"
          end
          lines[draw_mid] = table.concat(mid_chars)
        end

        -- Escala lateral
        for r = 3, h - 2 do
          local chars = {}
          for i = 1, #lines[r] do chars[i] = lines[r]:sub(i,i) end
          if #chars >= 1 and chars[1] == " " then
            if r == draw_mid then
              chars[1] = "0"
            elseif r == 3 then
              chars[1] = "+"
            elseif r == h - 2 then
              chars[1] = "-"
            end
          end
          lines[r] = table.concat(chars)
        end

        -- Footer
        lines[h-1] = truncate(string.rep("─", width), width)
        local freq_display = string.format("%.1fHz", waves[1].freq * 100 + math.sin(osc_phase * 0.3) * 20)
        local amp_display = string.format("%.2fV", 0.5 + math.sin(osc_phase * 0.1) * 0.3)
        lines[h] = truncate("  F:" .. freq_display .. " A:" .. amp_display, width)

        for i = 1, h do
          lines[i] = truncate(lines[i], width)
        end

        return lines
      end

      -- ═══════════════════════════════════════
      -- PANEL MANAGER
      -- ═══════════════════════════════════════

      local function setup_highlights()
        vim.api.nvim_set_hl(0, "HackerGreen", { fg = "#00ff41" })
        vim.api.nvim_set_hl(0, "HackerRed", { fg = "#ff0040" })
        vim.api.nvim_set_hl(0, "HackerYellow", { fg = "#ffb800" })
        vim.api.nvim_set_hl(0, "HackerDim", { fg = "#444444" })
        vim.api.nvim_set_hl(0, "HackerCyan", { fg = "#00d4ff" })
        vim.api.nvim_set_hl(0, "EKGGreen", { fg = "#00ff41" })
        vim.api.nvim_set_hl(0, "EKGRed", { fg = "#ff2020", bold = true })
        vim.api.nvim_set_hl(0, "EKGDim", { fg = "#224422" })
        vim.api.nvim_set_hl(0, "OscCyan", { fg = "#00d4ff" })
        vim.api.nvim_set_hl(0, "OscDim", { fg = "#1a3a4a" })
        vim.api.nvim_set_hl(0, "OscBright", { fg = "#80ffff", bold = true })
      end

      local function color_hacker(buf, ns, lines)
        for i = 0, #lines - 1 do
          local line = lines[i + 1]
          local hl = "HackerDim"
          if line:find("ACCESS GRANTED") or line:find("SHELL SPAWNED") or line:find("EXPLOIT SUCCESS") then
            hl = "HackerGreen"
          elseif line:find("!!!") or line:find("TRIGGERED") or line:find("DETECTED") then
            hl = "HackerRed"
          elseif line:find("SCANNING") or line:find("BRUTE") or line:find("DECRYPT") then
            hl = "HackerYellow"
          elseif line:find("0x") or line:find("\\x") then
            hl = "HackerCyan"
          elseif line:find("█") or line:find("░") then
            hl = "HackerGreen"
          elseif line:find("open") then
            hl = "HackerGreen"
          elseif line:find("%d%d:%d%d") then
            hl = "HackerDim"
          end
          vim.api.nvim_buf_add_highlight(buf, ns, hl, i, 0, -1)
        end
      end

      local function color_ekg(buf, ns, lines)
        for i = 0, #lines - 1 do
          local line = lines[i + 1]
          if line:find("█") or line:find("│") then
            hl = "EKGGreen"
          elseif line:find("♥") or line:find("BPM") then
            hl = "EKGRed"
          elseif line:find("─") or line:find("SIG") then
            hl = "EKGDim"
          else
            hl = "EKGDim"
          end
          vim.api.nvim_buf_add_highlight(buf, ns, hl, i, 0, -1)
        end
      end

      local function color_osc(buf, ns, lines)
        for i = 0, #lines - 1 do
          local line = lines[i + 1]
          if line:find("█") then
            hl = "OscBright"
          elseif line:find("SCOPE") or line:find("F:") then
            hl = "OscCyan"
          elseif line:find("─") then
            hl = "OscDim"
          else
            hl = "OscDim"
          end
          vim.api.nvim_buf_add_highlight(buf, ns, hl, i, 0, -1)
        end
      end

      local generators = {
        hacker = { frame = gen_hacker_frame, color = color_hacker, interval = 200 },
        ekg = { frame = gen_ekg_frame, color = color_ekg, interval = 100 },
        osc = { frame = gen_osc_frame, color = color_osc, interval = 60 },
      }

      local function open_panel(name, side)
        local key = name .. "_" .. side
        if panels[key] and panels[key].win and vim.api.nvim_win_is_valid(panels[key].win) then return end

        local gen = generators[name]
        if not gen then return end

        local buf = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
        vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
        vim.api.nvim_buf_set_option(buf, "swapfile", false)
        vim.api.nvim_buf_set_option(buf, "filetype", "hackerpanel")

        if side == "left" then
          vim.cmd("topleft vsplit")
        else
          vim.cmd("botright vsplit")
        end

        local win = vim.api.nvim_get_current_win()
        vim.api.nvim_win_set_buf(win, buf)
        vim.api.nvim_win_set_width(win, width)

        vim.api.nvim_win_set_option(win, "number", false)
        vim.api.nvim_win_set_option(win, "relativenumber", false)
        vim.api.nvim_win_set_option(win, "signcolumn", "no")
        vim.api.nvim_win_set_option(win, "foldcolumn", "0")
        vim.api.nvim_win_set_option(win, "cursorline", false)
        vim.api.nvim_win_set_option(win, "wrap", false)
        vim.api.nvim_win_set_option(win, "winfixwidth", true)

        if side == "left" then
          vim.cmd("wincmd l")
        else
          vim.cmd("wincmd h")
        end

        setup_highlights()
        local ns = vim.api.nvim_create_namespace("hacker_" .. key)

        local timer = vim.loop.new_timer()
        timer:start(0, gen.interval, vim.schedule_wrap(function()
          if not buf or not vim.api.nvim_buf_is_valid(buf) then
            timer:stop(); timer:close()
            return
          end
          if not win or not vim.api.nvim_win_is_valid(win) then
            timer:stop(); timer:close()
            return
          end

          local h = vim.api.nvim_win_get_height(win)
          local lines = gen.frame(h)

          vim.api.nvim_buf_set_option(buf, "modifiable", true)
          vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
          vim.api.nvim_buf_set_option(buf, "modifiable", false)

          vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
          gen.color(buf, ns, lines)
        end))

        panels[key] = { buf = buf, win = win, timer = timer }
      end

      local function close_panel(key)
        local p = panels[key]
        if not p then return end
        if p.timer then p.timer:stop(); p.timer:close() end
        if p.win and vim.api.nvim_win_is_valid(p.win) then
          vim.api.nvim_win_close(p.win, true)
        end
        panels[key] = nil
      end

      local function toggle(name, side)
        local key = name .. "_" .. side
        if panels[key] and panels[key].win and vim.api.nvim_win_is_valid(panels[key].win) then
          close_panel(key)
        else
          open_panel(name, side)
        end
      end

      -- Keymaps
      -- Hacker terminal
      vim.keymap.set("n", "<leader>hh", function() toggle("hacker", "right") end, { desc = "Toggle hacker terminal (right)" })
      vim.keymap.set("n", "<leader>hl", function() toggle("hacker", "left") end, { desc = "Toggle hacker terminal (left)" })

      -- EKG heartbeat
      vim.keymap.set("n", "<leader>he", function() toggle("ekg", "right") end, { desc = "Toggle EKG monitor (right)" })

      -- Oscilloscope
      vim.keymap.set("n", "<leader>ho", function() toggle("osc", "left") end, { desc = "Toggle oscilloscope (left)" })

      -- Combo: osc esquerda + hacker direita
      vim.keymap.set("n", "<leader>ha", function()
        toggle("osc", "left")
        toggle("hacker", "right")
      end, { desc = "Toggle hacker mode (osc+hacker)" })
    end,
  },
}
