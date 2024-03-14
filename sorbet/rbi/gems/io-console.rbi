# This file is autogenerated. Do not edit it by hand. Regenerate it with:
#   srb rbi gems

# typed: strict
#
# If you would like to make changes to this file, great! Please create the gem's shim here:
#
#   https://github.com/sorbet/sorbet-typed/new/master?filename=lib/io-console/all/io-console.rbi
#
# io-console-0.7.1

class IO
  def beep; end
  def check_winsize_changed; end
  def clear_screen; end
  def console_mode; end
  def console_mode=(arg0); end
  def cooked!; end
  def cooked; end
  def cursor; end
  def cursor=(arg0); end
  def cursor_down(arg0); end
  def cursor_left(arg0); end
  def cursor_right(arg0); end
  def cursor_up(arg0); end
  def echo=(arg0); end
  def echo?; end
  def erase_line(arg0); end
  def erase_screen(arg0); end
  def getch(*arg0); end
  def getpass(*arg0); end
  def goto(arg0, arg1); end
  def goto_column(arg0); end
  def iflush; end
  def ioflush; end
  def noecho; end
  def oflush; end
  def pressed?; end
  def raw!(*arg0); end
  def raw(*arg0); end
  def scroll_backward(arg0); end
  def scroll_forward(arg0); end
  def self.new(*arg0); end
  def winsize; end
  def winsize=(arg0); end
end
module InvalidName_IO__generic_readable_52
  def getch(*arg0); end
  def getpass(*arg0); end
end
class IO::ConsoleMode
  def echo=(arg0); end
  def initialize_copy(arg0); end
  def raw!(*arg0); end
  def raw(*arg0); end
end
