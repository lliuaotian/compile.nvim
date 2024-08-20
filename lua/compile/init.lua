local M = {}

local opts = {
  -- default options
  -- split window width
  split_width = 40, 
  -- split default direction
  split_dir = 'right',
  -- 默认调用这个插件是在src路径下，所以cmakelists.txt就在上层目录
  default_build_path = '../',
  -- 默认运行程序的程序名为main，所以写cmakelists时要注意
  default_run_path = "../bin/",
  default_makefile_output_path = "../build/",
}
opts.default_build_cmd = 'cmake -S ' .. opts.default_build_path .. '-B ' .. opts.default_makefile_output_path
-- 运行make
opts.default_make_cmd = 'make -C ' .. opts.default_makefile_output_path
-- 默认执行程序
opts.default_run_program = opts.default_run_path .. "/main"

local toggle_terminal = function()
  local term_bufnr = nil
  local term_winid = nil

  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[bufnr].buftype == 'terminal' then
      term_bufnr = bufnr
      term_winid = vim.fn.bufwinid(bufnr)
      break
    end
  end

  if term_bufnr and term_winid ~= -1 then
    -- 如果已经有终端窗口，直接切换到终端窗口
    vim.api.nvim_set_current_win(term_winid)
  else
    -- 否则，创建一个新的垂直分割窗口并打开终端
    -- 判断split_dir参数，设置窗口方向
    if opts.split_dir == 'right' then
      vim.cmd(opts.split_width .. 'vsplit')
    elseif opts.split_dir == 'down' then
      vim.cmd(opts.split_width .. 'split')
    elseif opts.split_dir == 'left' then
      vim.cmd("set nosplitright")
      vim.cmd(opts.split_width .. 'vsplit')
      vim.cmd("set splitright")
    elseif opts.split_dir == 'up' then
      vim.cmd('set nosplitblow')
      vim.cmd(opts.split_width .. 'split')
      vim.cmd('set splitblow')
    end
    
    vim.cmd('terminal')
    term_bufnr = vim.api.nvim_get_current_buf()
  end
end

local toggle_nvim = function()
  -- 切换到nvim窗口
  vim.cmd('wincmd p')
  vim.cmd('stopinsert')
end

local send_to_terminal = function(cmd)
  vim.fn.chansend(vim.b.terminal_job_id, cmd .. '\n')
end

function M.setup(opts)
  opts = opts or {}
  -- TODO: implement setup function
end

function M.test()
  print("Hello Test")
end

local check_dir_exist = function(dir)
  if vim.fn.isdirectory(dir) == 0 then
    -- 如果路径不存在就创建它
    vim.fn.mkdir(dir, 'p')
  end
end

function M.compile()
  toggle_terminal()
  check_dir_exist(opts.default_makefile_output_path)
  send_to_terminal(opts.default_build_cmd)
  send_to_terminal(opts.default_build_cmd)
  toggle_nvim()
end

function M.run()
  toggle_terminal()
  check_dir_exist(opts.default_run_path)
  send_to_terminal(opts.default_run_program)
  toggle_nvim()
end

function M.compile_and_run()
  toggle_terminal()
  check_dir_exist(opts.default_makefile_output_path)
  check_dir_exist(opts.default_run_path)
  send_to_terminal(opts.default_build_cmd)
  send_to_terminal(opts.default_run_program)
  toggle_nvim()
end

return M

