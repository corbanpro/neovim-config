local function choose_random_kms()
  local kmss = {
    'swirl',
    'ripple',
    'rotate',
    'matrix',
    'random', --[['slide']]
    'game_of_life',
    'make_it_rain',
    'scramble',
  }
  local kms = kmss[math.random(1, #kmss)]
  vim.cmd('CellularAutomaton ' .. kms)
end
--[[
vim.cmd('CellularAutomaton ' .. 'swirl')
vim.cmd('CellularAutomaton ' .. 'ripple')
vim.cmd('CellularAutomaton ' .. 'rotate')
vim.cmd('CellularAutomaton ' .. 'matrix')
vim.cmd('CellularAutomaton ' .. 'random')

vim.cmd('CellularAutomaton ' .. 'game_of_life')
vim.cmd('CellularAutomaton ' .. 'make_it_rain')
vim.cmd('CellularAutomaton ' .. 'scramble')
vim.cmd('CellularAutomaton ' .. 'slide')
--]]

vim.keymap.set('n', '<leader>kms', choose_random_kms, { desc = '[K][M][S]' })

return {
  {

    'eandrju/cellular-automaton.nvim',
    config = function()
      local ce = require 'cellular-automaton'
      local blank_char = { char = ' ', hl_group = '' }

      -- slide
      local slide = {
        fps = 50,
        name = 'slide',
      }

      slide.update = function(grid)
        for row_index = 1, #grid do
          local prev = grid[row_index][#grid[row_index]]
          for col_index = 1, #grid[row_index] do
            grid[row_index][col_index], prev = prev, grid[row_index][col_index]
          end
        end
        return true
      end

      ce.register_animation(slide)

      -- swirl
      local swirl = {
        fps = 50,
        name = 'swirl',
      }

      swirl.init = function(grid)
        vim.print(#grid / 2)
        local row_index = math.ceil(#grid / 2)
        if #grid % 2 == 1 then
          for col_index = 1, #grid[1] do
            if col_index >= row_index and col_index <= #grid[1] - row_index then
              grid[row_index][col_index] = { char = ' ', hl_group = '' }
            end
          end
        end
      end

      swirl.update = function(grid)
        local width = #grid[1]
        local height = #grid

        for offset = 1, #grid / 2 do
          local prev = grid[offset][offset]

          for col_index = offset + 1, width - offset + 1 do
            local row_index = offset
            grid[row_index][col_index], prev = prev, grid[row_index][col_index]
          end

          prev = grid[offset][width - offset + 1]

          for row_index = offset + 1, height - offset + 1 do
            local col_index = width - offset + 1
            grid[row_index][col_index], prev = prev, grid[row_index][col_index]
          end

          prev = grid[height - offset + 1][width - offset + 1]

          for col_index = width - offset, offset, -1 do
            local row_index = height - offset + 1
            grid[row_index][col_index], prev = prev, grid[row_index][col_index]
          end

          prev = grid[height - offset + 1][offset]

          for row_index = height - offset, offset, -1 do
            local col_index = offset
            grid[row_index][col_index], prev = prev, grid[row_index][col_index]
          end
        end
        return true
      end

      ce.register_animation(swirl)

      -- rotate
      local rotate = {
        fps = 40,
        name = 'rotate',
      }
      local chars = {}
      local width = 0
      local height = 0
      local center_y = 0
      local center_x = 0

      rotate.init = function(grid)
        width = #grid[1]
        height = #grid
        center_y = math.floor(height / 2)
        center_x = math.floor(width / 2)
        for row_index = 1, #grid do
          for col_index = 1, #grid[row_index] do
            local char = grid[row_index][col_index]
            char.coords = { row_index, col_index }
            table.insert(chars, char)
          end
        end
      end

      rotate.update = function(grid)
        for row_index = 1, #grid do
          for col_index = 1, #grid[row_index] do
            grid[row_index][col_index] = blank_char
          end
        end

        for index, char in ipairs(chars) do
          local x, y = unpack(char.coords)
          local angle = math.atan2(y - center_y, x - center_x)
          local distance = math.sqrt((x - center_x) ^ 2 + (y - center_y) ^ 2)
          local new_angle = angle + (0.7 / distance) + 0.05
          local new_x = center_x + distance * math.cos(new_angle)
          local new_y = center_y + distance * math.sin(new_angle)
          char.coords = { new_x, new_y }
          chars[index] = char
          new_x = math.floor(new_x)
          new_y = (math.floor(new_y) + center_y) / 2
          if new_x > 1 and new_x < width and new_y > 1 and new_y < height then
            grid[new_y] = grid[new_y] or {}
            grid[new_y][new_x] = char
          end
        end

        return true
      end

      ce.register_animation(rotate)

      -- ripple
      local ripple = {
        fps = 20,
        name = 'ripple',
      }
      local max_col = 0
      local wavelength = 16
      local offset = wavelength / 2
      local peaklength = 5

      ripple.init = function()
        max_col = 5
      end

      ripple.update = function(grid)
        offset = (offset + 1) % wavelength
        max_col = max_col + 1

        for col_index = 1, #grid[1] do
          if (col_index - offset) % wavelength == peaklength and col_index < max_col then
            for row_index = 2, #grid do
              grid[row_index - 1][col_index] = grid[row_index][col_index]
              grid[row_index][col_index] = blank_char
            end
          end
          if (col_index - offset) % wavelength == 0 and col_index < max_col then
            for row_index = #grid, 2, -1 do
              grid[row_index][col_index] = grid[row_index - 1][col_index]
              grid[row_index - 1][col_index] = blank_char
            end
          end

          if (col_index - offset) % wavelength == wavelength / 2 + peaklength and col_index < max_col then
            for row_index = #grid, 2, -1 do
              grid[row_index][col_index] = grid[row_index - 1][col_index]
              grid[row_index - 1][col_index] = blank_char
            end
          end

          if (col_index - offset) % wavelength == wavelength / 2 and col_index < max_col then
            for row_index = 2, #grid do
              grid[row_index - 1][col_index] = grid[row_index][col_index]
              grid[row_index][col_index] = blank_char
            end
          end
        end

        return true
      end

      ce.register_animation(ripple)

      -- random
      local random = {
        fps = 20,
        name = 'random',
      }

      -- random.init = function() end

      local hl_groups = {
        '@boolean',
        '@comment',
        '@function',
        '@keyword',
        '@number',
        '@operator',
        '@property',
        '@punctuation.bracket',
        '@string',
        '@variable',
      }

      random.update = function(grid)
        for col_index = 1, #grid[1] do
          for row_index = 1, #grid do
            if math.random() < 0.1 then
              grid[row_index][col_index] = { char = string.char(math.random(32, 126)), hl_group = hl_groups[math.random(1, #hl_groups)] }
            end
            if math.random() > 0.8 then
              grid[row_index][col_index] = blank_char
            end
          end
        end
        return true
      end

      ce.register_animation(random)
      -- matrix
      local matrix = {
        fps = 20,
        name = 'matrix',
      }

      local speeds = {}
      matrix.init = function(grid)
        for col_index = 1, #grid[1] do
          speeds[col_index] = math.random(1, 5)
          for row_index = 1, #grid do
            grid[row_index][col_index] = { char = grid[row_index][col_index].char, hl_group = '@string' }
          end
        end
      end

      matrix.update = function(grid)
        for col_index = 1, #grid[1] do
          for _ = 1, speeds[col_index] do
            local prev = grid[#grid][col_index]
            for row_index = 1, #grid do
              grid[row_index][col_index], prev = prev, grid[row_index][col_index]
            end
          end
        end
        return true
      end

      ce.register_animation(matrix)
    end,
  },
}
