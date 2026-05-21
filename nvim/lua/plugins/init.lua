return {
  {
    "stevearc/conform.nvim",
    event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    'mrcjkb/rustaceanvim',
    version = '^6',
    ft = "rust",
        config = function ()
          -- local mason_registry = require('mason-registry')
          -- local codelldb = mason_registry.get_package("codelldb")
          -- local extension_path = codelldb:get_install_path() .. "/extension/"
          local extension_path = vim.fn.expand "$MASON/packages/codelldb"
          local codelldb_path = extension_path .. "adapter/codelldb"
          local liblldb_path = extension_path .. "lldb/lib/liblldb.so"
          local cfg = require('rustaceanvim.config')

          vim.g.rustaceanvim = {
            dap = {
              adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
            },
          }
        end
  },

  {
    'mfussenegger/nvim-dap',
    config = function()
			local dap, dapui = require("dap"), require("dapui")
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
      dap.adapters.codelldb = {
        type = 'server',
        port = '${port}',
        executable = {
          -- The 'mason-nvim-dap' plugin will make sure this is on your path
          command = 'codelldb',
          args = { '--port', '${port}' },
        },
      }
      -- This defines the "Cargo Run" launch profile for Rust projects
      dap.configurations.cpp = {
        {
          name = 'Launch',
          type = 'codelldb',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
        },
      }

      dap.configurations.rust = {
        {
          name = 'Launch (Cargo Run)',
          type = 'codelldb', -- Use the adapter we just defined
          request = 'launch',
          program = function()
            -- Prompt for the executable path, with a smart default
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
          -- This command runs before launching the debugger
          preLaunchTask = {
            task = 'cargo build',
            type = 'shell',
          },
        },
      }
		end,
  },

  {
    'rcarriga/nvim-dap-ui', 
    dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
    config = function()
			require("dapui").setup()
		end,
  },

  {
    'nvimtools/none-ls.nvim',
    ft = {"python"},
    dependencies = {
      "nvim-lua/plenary.nvim"
    }
  },

  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("fzf-lua").setup({})
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = function(_, opts)
      opts.renderer = opts.renderer or {}
      opts.renderer.full_name = true
      return opts
    end,
  },

  {
    "nvim-java/nvim-java",
    ft = "java",
    config = function()
      require("configs.java").setup()
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "markdown",
        "markdown_inline",
        "cpp",
        "java",
        "javascript",
        "typescript",
        "tsx",
        "json",
        "jsonc",
        "html",
        "css",
      },
    },
  },

  {
    "windwp/nvim-ts-autotag",
    ft = {
      "html",
      "javascriptreact",
      "typescriptreact",
      "tsx",
    },
    opts = {},
  },

  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      opts.mapping["<Tab>"] = nil
      return opts
    end,
  },

}
