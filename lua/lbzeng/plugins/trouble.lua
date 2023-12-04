return {
  "folke/trouble.nvim",
  depencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local keymap = vim.keymap
    keymap.set("n", "<leader>xx", function()
      require("trouble").toggle()
    end)
    keymap.set("n", "<leader>xw", function()
      require("trouble").toggle("workspace_diagnostics")
    end)
    keymap.set("n", "<leader>xd", function()
      require("trouble").toggle("document_diagnostics")
    end)
    keymap.set("n", "<leader>xl", function()
      require("trouble").toggle("loclist")
    end)
    keymap.set("n", "<leader>xq", function()
      require("trouble").toggle("quickfix")
    end)
    keymap.set("n", "gR", function()
      require("trouble").lsp_references()
    end)
  end,
}
