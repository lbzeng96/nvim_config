return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"theHamsta/nvim-dap-virtual-text",
	},

	keys = {
		{
			"<leader>da",
			function()
				require("dap").continue({ before = get_args })
			end,
			desc = "Run with Args",
		},
		{
			"<leader>db",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "Toggle Breakpoint",
		},
		{
			"<leader>dB",
			function()
				require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end,
			desc = "Breakpoint Condition",
		},
		{
			"<leader>dc",
			function()
				require("dap").continue()
			end,
			desc = "Continue",
		},
		{
			"<leader>dC",
			function()
				require("dap").run_to_cursor()
			end,
			desc = "Run to Cursor",
		},
		{
			"<leader>dg",
			function()
				require("dap").goto_()
			end,
			desc = "Go to line (no execute)",
		},
		{
			"<leader>di",
			function()
				require("dap").step_into()
			end,
			desc = "Step Into",
		},
		{
			"<leader>dj",
			function()
				require("dap").down()
			end,
			desc = "Down",
		},
		{
			"<leader>dk",
			function()
				require("dap").up()
			end,
			desc = "Up",
		},
		{
			"<leader>dl",
			function()
				require("dap").run_last()
			end,
			desc = "Run Last",
		},
		{
			"<leader>do",
			function()
				require("dap").step_out()
			end,
			desc = "Step Out",
		},
		{
			"<leader>dO",
			function()
				require("dap").step_over()
			end,
			desc = "Step Over",
		},
		{
			"<leader>dp",
			function()
				require("dap").pause()
			end,
			desc = "Pause",
		},
		{
			"<leader>dr",
			function()
				require("dap").repl.toggle()
			end,
			desc = "Toggle REPL",
		},
		{
			"<leader>ds",
			function()
				require("dap").session()
			end,
			desc = "Session",
		},
		{
			"<leader>dt",
			function()
				require("dap").terminate()
			end,
			desc = "Terminate",
		},
		{
			"<leader>dw",
			function()
				require("dap.ui.widgets").hover()
			end,
			desc = "Widgets",
		},
		{
			"<leader>du",
			function()
				require("dapui").toggle({})
			end,
			desc = "Dap UI",
		},
		{
			"<leader>de",
			function()
				require("dapui").eval()
			end,
			desc = "Eval",
			mode = { "n", "v" },
		},
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		local daptext = require("nvim-dap-virtual-text")
		daptext.setup()
		dapui.setup()

		if vim.fn.has("win32") == 1 then
			EXECUTABLE = "OpenDebugAD7.exe"
		else
			EXECUTABLE = "OpenDebugAD7"
		end

		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end

		local dap_breakpoint_color = {
			breakpoint = {
				ctermbg = 0,
				fg = "#993939",
				bg = "#31353f",
			},
			logpoing = {
				ctermbg = 0,
				fg = "#61afef",
				bg = "#31353f",
			},
			stopped = {
				ctermbg = 0,
				fg = "#98c379",
				bg = "#31353f",
			},
		}

		vim.api.nvim_set_hl(0, "DapBreakpoint", dap_breakpoint_color.breakpoint)
		vim.api.nvim_set_hl(0, "DapLogPoint", dap_breakpoint_color.logpoing)
		vim.api.nvim_set_hl(0, "DapStopped", dap_breakpoint_color.stopped)

		local dap_breakpoint = {
			error = {
				text = "🔴",
				texthl = "DapBreakpoint",
				linehl = "DapBreakpoint",
				numhl = "DapBreakpoint",
			},
			condition = {
				text = "🇨",
				texthl = "DapBreakpoint",
				linehl = "DapBreakpoint",
				numhl = "DapBreakpoint",
			},
			rejected = {
				text = "❗",
				texthl = "DapBreakpint",
				linehl = "DapBreakpoint",
				numhl = "DapBreakpoint",
			},
			logpoint = {
				text = "",
				texthl = "DapLogPoint",
				linehl = "DapLogPoint",
				numhl = "DapLogPoint",
			},
			stopped = {
				text = "",
				texthl = "DapStopped",
				linehl = "DapStopped",
				numhl = "DapStopped",
			},
		}

		vim.fn.sign_define("DapBreakpoint", dap_breakpoint.error)
		vim.fn.sign_define("DapBreakpointCondition", dap_breakpoint.condition)
		vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)
		vim.fn.sign_define("DapLogPoint", dap_breakpoint.logpoint)
		vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)

		-- python
		dap.adapters.python = function(cb, config)
			if config.request == "attach" then
				---@diagnostic disable-next-line: undefined-field
				local port = (config.connect or config).port
				---@diagnostic disable-next-line: undefined-field
				local host = (config.connect or config).host or "127.0.0.1"
				cb({
					type = "server",
					port = assert(port, "`connect.port` is required for a python `attach` configuration"),
					host = host,
					options = {
						source_filetype = "python",
					},
				})
			else
				cb({
					type = "executable",
					-- linux
					-- command = "/home/lbz/miniconda3/envs/debugpy/bin/python",

					-- windows
					command = "D:/anaconda3/envs/debugpy/python.exe",

					args = { "-m", "debugpy.adapter" },
					options = {
						source_filetype = "python",
					},
				})
			end
		end

		dap.configurations.python = {
			{
				-- the first three options are required by nvim-dap
				type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
				request = "launch",
				name = "launch file",

				-- options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/debug-configuration-settings for supported options

				program = "${file}", -- this configuration will launch the current file if used.
				pythonpath = function()
					-- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
					-- the code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
					-- you could adapt this - to for example use the `virtual_env` environment variable.
					-- linux
					--return "/home/lbz/miniconda3/envs/debugpy/bin/python"
					-- windows
					return "D:/anaconda3/envs/debugpy/python.exe"
				end,
			},
		}

		-- c/c++
		dap.adapters.cppdbg = {
			id = "cppdbg",
			type = "executable",
			command = vim.fn.stdpath("data") .. "/mason/packages/cpptools/extension/debugAdapters/bin/" .. EXECUTABLE,
			options = {
				detached = false,
			},
		}

		dap.configurations.cpp = {
			{
				name = "Launch file",
				type = "cppdbg",
				request = "launch",
				program = function()
					return vim.fn.input("path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopAtEntry = true,
			},
			-- {
			-- 	name = 'attach to gdbserver :1234',
			-- 	type = 'cppdbg',
			-- 	request = 'launch',
			-- 	mimode = 'gdb',
			-- 	midebuggerserveraddress = 'localhost:1234',
			-- 	midebuggerpath = '/usr/bin/gdb',
			-- 	cwd = '${workspacefolder}',
			-- 	program = function()
			-- 	  return vim.fn.input('path to executable: ', vim.fn.getcwd() .. '/', 'file')
			-- 	end,
			-- },
		}

		dap.configurations.c = dap.configurations.cpp
		dap.configurations.rust = dap.configurations.cpp
	end,
}
