return {
  'Bryley/neoai.nvim',
  dependencies = { 'MunifTanjim/nui.nvim' },
  cmd = { 'NeoAI' },
  config = function()
    require('neoai').setup {

      strip_function = nil,
      openai_params = {
        model = 'gpt-4o', -- GPT-4.1 name via API
        temperature = 0.5,
        max_tokens = 300,
      },
      prompts = {
        shortcut = {
          prompt = 'What neovin keybind can i use for: ',
          input = true,
        },
      },
    }
  end,
}
