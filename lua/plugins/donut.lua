-- Donut 3D ASCII art girando — implementação pura em Lua, sem plugin externo
local win, buf, timer
local A, B = 0, 0

local function render(W, H)
  local output, zbuf = {}, {}
  for i = 1, W * H do output[i] = " "; zbuf[i] = 0 end

  local chars = ".,-~:;=!*#$@"
  local sinA, cosA = math.sin(A), math.cos(A)
  local sinB, cosB = math.sin(B), math.cos(B)
  local pi2 = math.pi * 2

  for j = 0, pi2, 0.05 do
    local sinJ, cosJ = math.sin(j), math.cos(j)
    for i = 0, pi2, 0.02 do
      local sinI, cosI = math.sin(i), math.cos(i)
      local h = cosJ + 2
      local D = 1 / (sinI * h * sinA - sinJ * cosA + 5)
      local t = sinI * h * cosA + sinJ * sinA

      local xp = math.floor(W / 2 + W * 0.42 * D * (cosI * h * cosB - t * sinB))
      local yp = math.floor(H / 2 + H * 0.55 * D * (cosI * h * sinB + t * cosB))

      if xp >= 1 and xp <= W and yp >= 1 and yp <= H then
        local idx = xp + W * (yp - 1)
        local L = math.floor(
          8 * ((sinJ * sinA - sinI * cosJ * cosA) * cosB
            - sinI * cosJ * sinA
            - sinJ * cosA
            - cosI * cosJ * sinB)
        )
        if D > zbuf[idx] then
          zbuf[idx] = D
          local ci = math.max(1, math.min(#chars, L + 1))
          output[idx] = chars:sub(ci, ci)
        end
      end
    end
  end

  local lines = {}
  for row = 1, H do
    local line = ""
    for col = 1, W do line = line .. output[col + W * (row - 1)] end
    table.insert(lines, line)
  end
  return lines
end

local function close()
  if timer then timer:stop(); timer:close(); timer = nil end
  if win and vim.api.nvim_win_is_valid(win) then
    vim.api.nvim_win_close(win, true)
  end
  win = nil; buf = nil; A = 0; B = 0
end

local function open()
  if win and vim.api.nvim_win_is_valid(win) then return end
  local W, H = 72, 28
  local ui = vim.api.nvim_list_uis()[1]

  buf = vim.api.nvim_create_buf(false, true)
  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].buftype   = "nofile"
  vim.bo[buf].swapfile  = false

  win = vim.api.nvim_open_win(buf, true, {   -- true = foca a janela
    relative   = "editor",
    width      = W,
    height     = H,
    col        = math.floor((ui.width  - W) / 2),
    row        = math.floor((ui.height - H) / 2),
    style      = "minimal",
    border     = "rounded",
    title      = "  DONUT  ",
    title_pos  = "center",
    zindex     = 100,
  })

  vim.wo[win].winblend   = 0
  vim.wo[win].winhighlight = "Normal:Normal,FloatBorder:DiagnosticInfo"
  vim.wo[win].number     = false
  vim.wo[win].cursorline = false

  -- fechar com q ou Esc dentro da janela do donut
  for _, key in ipairs({ "q", "<Esc>" }) do
    vim.keymap.set("n", key, close, { buffer = buf, silent = true })
  end

  timer = (vim.uv or vim.loop).new_timer()
  timer:start(0, 40, vim.schedule_wrap(function()
    if not buf or not vim.api.nvim_buf_is_valid(buf) then
      timer:stop(); timer:close(); timer = nil; return
    end
    if not win or not vim.api.nvim_win_is_valid(win) then
      timer:stop(); timer:close(); timer = nil; return
    end
    A = A + 0.07
    B = B + 0.03
    local lines = render(W, H)
    vim.bo[buf].modifiable = true
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.bo[buf].modifiable = false
  end))
end

vim.keymap.set("n", "<leader>eo", function()
  if win and vim.api.nvim_win_is_valid(win) then close() else open() end
end, { desc = "Toggle Donut 3D" })

return {}
