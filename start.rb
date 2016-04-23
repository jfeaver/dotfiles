#!/usr/bin/env ruby
# Usage: start project PROJECT_NAME
# Summary: Start up a project in tmux

# Provide `start` completions
if ARGV.first == '--complete'
  puts 'fenix'
  puts 'canuck'
  exit
end

Tmux = Struct.new(:name, :windows) do
  module Helpers
    def _tmux(*args)
      system('tmux', *args)
    end

    def _tmux!(*args)
      exec('tmux', *args)
    end
  end

  include Helpers
  extend Helpers

  Window = Struct.new(:tmux, :name) do
    def send_keys(keys)
      tmux._tmux('send-keys', '-t', "#{tmux.name}:#{index}", keys, 'C-m')
      self
    end

  private

    def index
      @index ||= tmux.windows.index(self)
    end
  end

  def self.start(name)
    yield(new(name, []))
    _tmux('select-window', '-t', "#{name}:1")
    attach(name)
  end

  def self.start_or_attach(name, &block)
    start(name, &block)
  rescue
    attach(name)
  end

  def self.work_project(opts = {}, &block)
    name = opts.fetch(:name)
    project({ :dir => "~/proj/#{name}" }.merge(opts), &block)
  end

  def self.personal_project(opts = {}, &block)
    name = opts.fetch(:name)
    project({ :dir => "~/personal/#{name}" }.merge(opts), &block)
  end

  def self.project(opts = {})
    name = opts.fetch(:name)
    windows = opts.fetch(:windows) { %w(server dev util) }
    Tmux.start_or_attach(name) do |t|
      windows.each do |window|
        t.window(window).
          send_keys("cd #{opts.fetch(:dir)}").
          send_keys('[ -f rc ] && source rc')
      end
      yield(t) if block_given?
    end
  end

  def self.attach(name)
    _tmux!('attach', '-t', name)
  end

  def start(first_window_name)
    _tmux('new-session', '-s', name, '-n', first_window_name, '-d') or raise "session #{name} already exists"
  end

  def window(window_name)
    if windows.empty?
      # Not running yet, actually start it
      start(window_name)
    else
      _tmux('new-window', '-n', window_name, '-t', name)
    end
    w = Window.new(self, window_name)
    windows << w
    w
  end
end

case ARGV.first
when 'fenix'
  Tmux.work_project(:name => 'fenix')
when 'canuck'
  Tmux.personal_project(name: 'canuck')
else
  exit 1
end
