# compile.nvim

Quickly compile or run your current project in nvim

## 📦 Installation

1. Install via your favorite package manager.

```lua
-- lazy.nvim
{
   "lliuaotian/compile.nvim",
},
```

2. Setup the plugin in your `init.lua`. This step is not needed with lazy.nvim if `opts` is set as above.

```lua
require("compile").setup()
```

## 🚀 Usage

.
├── bin
├── build
├── CMakeLists.txt
└── src
    └── main.cc

This program assumes that your project structure is the same as mine. You should specify in your CMakeLists file that the output of the `cmake` command should be placed in the `build` directory. The `compile.nvim` plugin will then automatically run `make` in that directory. Therefore, it is essential that you write your CMakeLists file correctly and ensure that you invoke this plugin while editing files in the `src` folder.

### Functions Provided by the Plugin

- **`run`**: This function only runs the compiled executable.
- **`compile`**: This function only compiles the files in your project.
- **`compile_and_run`**: This function both compiles the files and then runs the compiled executable.

### Keymap Configuration Example

You can bind the provided functions to your desired key mappings, like the following example:

```lua
luaCopy codekeymap.set("n", "<leader>cb", function ()
    compile.compile()
end, { desc = "Build Current Project" })

-- Note that the `run` function does not compile the program, so set the keybinding to "start" to indicate starting the program.
keymap.set("n", "<leader>cs", function ()
    compile.run()
end, { desc = "Only Run Current Project" })

-- Set this one to "run" because it compiles the program before running it.
keymap.set("n", "<leader>cr", function ()
    compile.compile_and_run()
end, { desc = "Compile and Run Current Project" })
```

## 🔧 Configuration

You can pass your config table into the `setup()` function or `opts` if you use lazy.nvim.

### Options

- name (optional, type: string): the name that example.nvim greets with

Example:

```lua
require("compile").setup({
   name = "Max",
})
```
