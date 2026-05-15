return {
  {
    "cocopon/iceberg.vim",
    lazy = false,
    priority = 1000,

   -- config = function()
   --   vim.cmd.colorscheme("iceberge")
   -- end,
  },

  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,

    config = function()
        vim.cmd.colorscheme("nightfox")
    end,
  },
}
