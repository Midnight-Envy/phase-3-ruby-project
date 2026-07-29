module Colors
  RESET = "\e[0m".freeze
  BOLD = "\e[1m".freeze

  RED = "\e[31m".freeze
  GREEN = "\e[32m".freeze
  YELLOW = "\e[33m".freeze
  BLUE = "\e[34m".freeze
  MAGENTA = "\e[35m".freeze
  CYAN = "\e[36m".freeze

  BRIGHT_GREEN = "\e[92m".freeze
  BRIGHT_YELLOW = "\e[93m".freeze
  BRIGHT_MAGENTA = "\e[95m".freeze
  BRIGHT_CYAN = "\e[96m".freeze

  module_function

  def red(text)
    colorize(text, RED)
  end

  def green(text)
    colorize(text, GREEN)
  end

  def yellow(text)
    colorize(text, YELLOW)
  end

  def blue(text)
    colorize(text, BLUE)
  end

  def magenta(text)
    colorize(text, MAGENTA)
  end

  def cyan(text)
    colorize(text, CYAN)
  end

  def bright_green(text)
    colorize(text, BRIGHT_GREEN)
  end

  def bright_yellow(text)
    colorize(text, BRIGHT_YELLOW)
  end

  def bright_magenta(text)
    colorize(text, BRIGHT_MAGENTA)
  end

  def bright_cyan(text)
    colorize(text, BRIGHT_CYAN)
  end

  def bold(text)
    colorize(text, BOLD)
  end

  def heading(text)
    bold(text)
  end

  def success(text)
    bright_green(text)
  end

  def warning(text)
    bright_yellow(text)
  end

  def error(text)
    red(text)
  end

  def xp(text)
    bright_magenta(text)
  end

  def difficulty(value)
    case value
    when "Easy"
      green(value)
    when "Medium"
      yellow(value)
    when "Hard"
      red(value)
    else
      value
    end
  end

  def status(completed)
    completed ? bright_green("Completed") : yellow("Active")
  end

  def colorize(text, color)
    "#{color}#{text}#{RESET}"
  end
end
