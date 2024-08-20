local M = {}

local function check_executables(cmd)
  return vim.fn.executable(cmd)
end

function M.check()
  local health = require("vim.health")
  local report = {}
  local error = health.error
  local ok = health.ok
  local info = health.info

  health.start("Compile Health Check")
  if not check_executables("cmake") then
      error("CMake not found. Please install CMake to build C/C++ projects.")
  else
      ok("CMake is installed and available.")
  end

  if not check_executables("make") then
      error("Make not found. Please install Make to build C/C++ projects.")
  else
      ok("Make is installed and available.")
  end
end


return M
