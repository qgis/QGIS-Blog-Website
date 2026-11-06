-- Project-local Neovim tooling for QGIS-Blog-Website.
--
-- Auto-loaded by Neovim when the user has `vim.o.exrc = true` set and this
-- directory has been trusted (`:trust`, see `:help exrc`).
--
-- Provides a <leader>p "Project" menu for blog authoring tasks: new posts,
-- author metadata, headliner/body images, and local pre-commit checks.

local ROOT = vim.fn.getcwd()
local POSTS_DIR = ROOT .. '/content/posts'
local AUTHORS_DIR = ROOT .. '/content/authors'

local function notify(msg, level)
  vim.notify('[blog] ' .. msg, level or vim.log.levels.INFO)
end

local function slugify(text)
  text = text:lower():gsub('[^a-z0-9]+', '-')
  return (text:gsub('^%-+', ''):gsub('%-+$', ''))
end

local function split_csv(input)
  local out = {}
  for item in (input or ''):gmatch('[^,]+') do
    local trimmed = item:match('^%s*(.-)%s*$')
    if trimmed ~= '' then
      table.insert(out, trimmed)
    end
  end
  return out
end

local function to_array_literal(items)
  local quoted = {}
  for _, v in ipairs(items) do
    table.insert(quoted, '"' .. v:gsub('"', '\\"') .. '"')
  end
  return '[' .. table.concat(quoted, ', ') .. ']'
end

local function read_lines(path)
  local f = io.open(path, 'r')
  if not f then
    return nil
  end
  local lines = {}
  for line in f:lines() do
    table.insert(lines, line)
  end
  f:close()
  return lines
end

local function write_lines(path, lines)
  local f = io.open(path, 'w')
  if not f then
    return false
  end
  f:write(table.concat(lines, '\n') .. '\n')
  f:close()
  return true
end

-- Returns the 1-based (start, stop) line indices of the `---` delimiters.
local function frontmatter_range(lines)
  if not lines or lines[1] ~= '---' then
    return nil
  end
  for i = 2, #lines do
    if lines[i] == '---' then
      return 1, i
    end
  end
  return nil
end

local function get_frontmatter_field(path, key)
  local lines = read_lines(path)
  local start, stop = frontmatter_range(lines)
  if not start then
    return nil
  end
  local pattern = '^' .. key .. ':%s*(.*)$'
  for i = start + 1, stop - 1 do
    local value = lines[i]:match(pattern)
    if value then
      return value
    end
  end
  return nil
end

local function set_frontmatter_field(path, key, raw_value)
  local lines = read_lines(path)
  local start, stop = frontmatter_range(lines)
  if not start then
    return false, 'no front matter block in ' .. path
  end
  local pattern = '^' .. key .. ':%s*'
  local found = false
  for i = start + 1, stop - 1 do
    if lines[i]:match(pattern) then
      lines[i] = key .. ': ' .. raw_value
      found = true
      break
    end
  end
  if not found then
    table.insert(lines, stop, key .. ': ' .. raw_value)
  end
  return write_lines(path, lines), nil
end

local function list_authors()
  if vim.fn.isdirectory(AUTHORS_DIR) == 0 then
    return {}
  end
  local names = vim.fn.readdir(AUTHORS_DIR)
  local out = {}
  for _, name in ipairs(names) do
    if vim.fn.isdirectory(AUTHORS_DIR .. '/' .. name) == 1 then
      table.insert(out, name)
    end
  end
  table.sort(out)
  return out
end

local function warn_unknown_authors(slugs)
  local known = list_authors()
  for _, slug in ipairs(slugs) do
    if not vim.tbl_contains(known, slug) then
      notify('warning: author "' .. slug .. '" has no profile in content/authors/', vim.log.levels.WARN)
    end
  end
end

-- Resolves the post that the current buffer belongs to, if any.
local function current_post()
  local path = vim.api.nvim_buf_get_name(0)
  local prefix = POSTS_DIR .. '/'
  if path:sub(1, #prefix) ~= prefix then
    return nil
  end
  local slug = path:sub(#prefix + 1):match('^([^/]+)/')
  if not slug then
    return nil
  end
  return {
    slug = slug,
    dir = POSTS_DIR .. '/' .. slug,
    index = POSTS_DIR .. '/' .. slug .. '/index.md',
  }
end

local function require_current_post()
  local post = current_post()
  if not post then
    notify("open a post's index.md first (content/posts/<slug>/index.md)", vim.log.levels.ERROR)
  end
  return post
end

local function run_in_terminal(cmd)
  vim.cmd('vnew')
  vim.cmd('terminal cd ' .. vim.fn.shellescape(ROOT) .. ' && ' .. cmd)
  vim.cmd('startinsert')
end

local M = {}

function M.new_post()
  vim.ui.input({ prompt = 'Post title: ' }, function(title)
    if not title or title == '' then
      return
    end
    vim.ui.input({ prompt = 'Slug: ', default = slugify(title) }, function(slug)
      if not slug or slug == '' then
        return
      end
      slug = slugify(slug)
      local dir = POSTS_DIR .. '/' .. slug
      if vim.fn.isdirectory(dir) == 1 then
        notify('content/posts/' .. slug .. ' already exists', vim.log.levels.ERROR)
        return
      end

      local known = list_authors()
      vim.ui.input({
        prompt = 'Authors, comma-separated (available: ' .. table.concat(known, ', ') .. '): ',
      }, function(authors_input)
        local author_slugs = split_csv(authors_input)
        warn_unknown_authors(author_slugs)

        vim.ui.input({ prompt = 'Categories, comma-separated (optional): ' }, function(categories_input)
          local categories = split_csv(categories_input)

          vim.fn.mkdir(dir, 'p')
          local lines = {
            '---',
            'title: "' .. title:gsub('"', '\\"') .. '"',
            'date: "' .. os.date('!%Y-%m-%dT%H:%M:%S+00:00') .. '"',
            'draft: true',
            'authors: ' .. to_array_literal(author_slugs),
            'categories: ' .. to_array_literal(categories),
            'featured_image: ""',
            '---',
            '',
          }
          write_lines(dir .. '/index.md', lines)
          vim.cmd.edit(dir .. '/index.md')
          notify('created content/posts/' .. slug .. '/index.md (draft)')
        end)
      end)
    end)
  end)
end

function M.set_authors()
  local post = require_current_post()
  if not post then
    return
  end
  local current = get_frontmatter_field(post.index, 'authors') or ''
  local prefill = current:gsub('[%[%]"]', '')
  local known = list_authors()

  vim.ui.input({
    prompt = 'Authors, comma-separated (available: ' .. table.concat(known, ', ') .. '): ',
    default = prefill,
  }, function(input)
    if not input then
      return
    end
    local slugs = split_csv(input)
    warn_unknown_authors(slugs)
    local ok, err = set_frontmatter_field(post.index, 'authors', to_array_literal(slugs))
    if ok then
      notify('authors set to ' .. table.concat(slugs, ', '))
    else
      notify(tostring(err), vim.log.levels.ERROR)
    end
  end)
end

function M.new_author()
  vim.ui.input({ prompt = 'Display name: ' }, function(name)
    if not name or name == '' then
      return
    end
    vim.ui.input({ prompt = 'Author slug: ', default = slugify(name) }, function(slug)
      if not slug or slug == '' then
        return
      end
      slug = slugify(slug)
      local dir = AUTHORS_DIR .. '/' .. slug
      if vim.fn.isdirectory(dir) == 1 then
        notify('content/authors/' .. slug .. ' already exists', vim.log.levels.ERROR)
        return
      end
      vim.ui.input({ prompt = 'Short bio (optional): ' }, function(bio)
        vim.fn.mkdir(dir, 'p')
        local lines = {
          '---',
          'title: "' .. slug .. '"',
          'display_name: "' .. name:gsub('"', '\\"') .. '"',
          'bio: "' .. (bio or ''):gsub('"', '\\"') .. '"',
          '---',
          '',
        }
        write_lines(dir .. '/_index.md', lines)
        vim.cmd.edit(dir .. '/_index.md')
        notify('created content/authors/' .. slug)
      end)
    end)
  end)
end

function M.insert_image()
  local post = require_current_post()
  if not post then
    return
  end
  vim.ui.input({ prompt = 'Image file to insert: ', completion = 'file' }, function(src)
    if not src or src == '' then
      return
    end
    src = vim.fn.expand(src)
    if vim.fn.filereadable(src) == 0 then
      notify('file not found: ' .. src, vim.log.levels.ERROR)
      return
    end

    local stem = vim.fn.fnamemodify(src, ':t:r')
    local ext = vim.fn.fnamemodify(src, ':e'):lower()
    local base = slugify(stem)
    local name = base .. '.' .. ext
    local dest = post.dir .. '/' .. name
    local n = 2
    while vim.fn.filereadable(dest) == 1 do
      name = base .. '-' .. n .. '.' .. ext
      dest = post.dir .. '/' .. name
      n = n + 1
    end

    vim.fn.system({ 'cp', '--', src, dest })
    if vim.v.shell_error ~= 0 then
      notify('copy failed for ' .. src, vim.log.levels.ERROR)
      return
    end

    vim.ui.input({ prompt = 'Alt text: ', default = (stem:gsub('[-_]', ' ')) }, function(alt)
      local row = vim.api.nvim_win_get_cursor(0)[1]
      vim.api.nvim_buf_set_lines(0, row, row, false, { '', '![' .. (alt or '') .. '](' .. name .. ')' })
      notify('inserted ' .. name .. ' — run <leader>pr to optimise it before committing')
    end)
  end)
end

function M.set_headliner()
  local post = require_current_post()
  if not post then
    return
  end
  local exts = { png = true, jpg = true, jpeg = true, webp = true, gif = true }
  local images = {}
  for _, name in ipairs(vim.fn.readdir(post.dir)) do
    local ext = name:match('%.([%w]+)$')
    if ext and exts[ext:lower()] then
      table.insert(images, name)
    end
  end
  if #images == 0 then
    notify('no images in content/posts/' .. post.slug .. ' yet — insert one first (<leader>pi)', vim.log.levels.WARN)
    return
  end
  table.sort(images)
  vim.ui.select(images, { prompt = 'Headliner image for ' .. post.slug .. ':' }, function(choice)
    if not choice then
      return
    end
    local ok, err = set_frontmatter_field(post.index, 'featured_image', '"' .. choice .. '"')
    if ok then
      notify('featured_image set to ' .. choice)
    else
      notify(tostring(err), vim.log.levels.ERROR)
    end
  end)
end

function M.optimize_images()
  local post = require_current_post()
  if not post then
    return
  end
  run_in_terminal('python3 scripts/resize_image.py ' .. vim.fn.shellescape(post.dir))
end

function M.precommit()
  run_in_terminal('make precommit')
end

function M.build()
  run_in_terminal('make hugo-dev-build')
end

function M.serve()
  run_in_terminal('hugo server --config config.toml,config/config.dev.toml')
end

local function map(lhs, rhs, desc)
  vim.keymap.set('n', lhs, rhs, { desc = desc, silent = true })
end

map('<leader>pn', M.new_post, 'Blog: new post')
map('<leader>pa', M.set_authors, 'Blog: set post authors')
map('<leader>pA', M.new_author, 'Blog: new author profile')
map('<leader>ph', M.set_headliner, 'Blog: set headliner image')
map('<leader>pi', M.insert_image, 'Blog: insert image')
map('<leader>pr', M.optimize_images, 'Blog: optimise post images')
map('<leader>pc', M.precommit, 'Blog: run precommit checks')
map('<leader>pb', M.build, 'Blog: build site')
map('<leader>ps', M.serve, 'Blog: start dev server')

local wk_ok, wk = pcall(require, 'which-key')
if wk_ok then
  if wk.add then
    wk.add({ { '<leader>p', group = 'QGIS Blog' } })
  elseif wk.register then
    wk.register({ p = { name = 'QGIS Blog' } }, { prefix = '<leader>' })
  end
end
