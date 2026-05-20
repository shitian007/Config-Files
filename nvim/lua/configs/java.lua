local M = {}

local function add_runtime(runtimes, name, path, default)
  if path ~= nil and path ~= "" and vim.fn.isdirectory(path) == 1 then
    table.insert(runtimes, {
      name = name,
      path = path,
      default = default or false,
    })
  end
end

function M.setup()
  local runtimes = {}
  local nvim_java_jdk = vim.fn.glob(vim.fn.stdpath("data") .. "/nvim-java/packages/openjdk/25/jdk-*/Contents/Home")

  add_runtime(runtimes, "JavaSE-25", nvim_java_jdk, nvim_java_jdk ~= "")
  add_runtime(runtimes, "JavaSE-17", "/Library/Java/JavaVirtualMachines/jdk-17.jdk/Contents/Home", nvim_java_jdk == "")
  add_runtime(runtimes, "JavaSE-11", "/Library/Java/JavaVirtualMachines/temurin-11.jdk/Contents/Home", false)

  require("java").setup({
    spring_boot_tools = {
      enable = false,
    },
  })

  vim.lsp.config("jdtls", {
    settings = {
      java = {
        configuration = {
          runtimes = runtimes,
        },
        format = {
          settings = {
            url = vim.fn.stdpath("config") .. "/formatters/eclipse-java-formatter.xml",
            profile = "Custom4Spaces",
          },
        },
      },
    },
  })

  vim.lsp.enable("jdtls")
end

return M
