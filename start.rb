#!/usr/bin/env ruby
# Usage: start project {measure|redpen|proctor|deployment|listcommando|tinderizer|luke|stdlib|balance|blog|goggles|playbooks|captain|etclb|coredo}
# Summary: Start up a project in tmux

# Provide dh completions
if ARGV.first == '--complete'
  puts 'fenix'
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
      @index ||= tmux.windows.index(self) + 1
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

  def self.go_project(opts = {}, &block)
    name = opts.fetch(:name)
    project({ :dir => "~/dev/go/src/github.com/darkhelmet/#{name}" }.merge(opts), &block)
  end

  def self.project(opts = {})
    name = opts.fetch(:name)
    windows = opts.fetch(:windows) { %w(server dev util) }
    Tmux.start_or_attach(name) do |t|
      windows.each do |window|
        t.window(window).
          send_keys("cd #{opts.fetch(:dir)}").
          send_keys('[ -f rc ] && . rc')
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
# when 'cogs'
#   Tmux.work_project(:name => 'cogs-client')
# when 'measure'
#   Tmux.work_project(
#     :name => 'measure',
#     :dir => '~/work/yardstick',
#     :windows => %w(server dev util services)
#   )
# when 'redpen'
#   Tmux.work_project(:name => 'redpen')
# when 'proctor'
#   Tmux.work_project(:name => 'proctor', :dir => '~/work/proctor2')
# when 'deployment'
#   Tmux.work_project(:name => 'deployment')
# when 'listcommando'
#   Tmux.project(:name => 'listcommando', :dir => '~/dev/github/darkhelmet/listcommando')
# when 'tinderizer'
#   Tmux.go_project(:name => 'ForrestFire') do |t|
#     t.window('lib').
#       send_keys('cd ~/dev/go/src/github.com/darkhelmet/tinderizer')
#   end
# when 'luke'
#   Tmux.go_project(:name => 'luke')
# when 'stdlib'
#   Tmux.project(:name => 'stdlib', :dir => '~/dev/github/darkhelmet/go-thestdlib/manuscript', :windows => %w(book code))
# when 'balance'
#   Tmux.go_project(:name => 'balance', :windows => %w(code bash))
# when 'blog'
#   Tmux.project(:name => 'blog', :dir => '~/dev/go/src/github.com/darkhelmet/dashvee', :windows => %w(code bash))
# when 'goggles'
#   Tmux.go_project(:name => 'goggles', :windows => %w(code bash tests))
# when 'playbooks'
#   Tmux.project(:name => 'playbooks', :dir => '~/dev/github/darkhelmet/playbooks', :windows => %w(code bash))
# when 'jarvis'
#   Tmux.project(:name => 'jarvis', :dir => '~/dev/github/darkhelmet/jarvis', :windows => %w(server code ngrok postgres))
# when 'bhag'
#   Tmux.project(:name => 'bhag', :dir => '~/work/bhag', :windows => %w(server code bash))
# when 'aig'
#   Tmux.project(:name => 'aig', :dir => '~/work/aig', :windows => %w(server code ngrok bash))
# when 'captain'
#   Tmux.project(:name => 'captain', :dir => '~/work/captain', :windows => %w(server code bash))
# when 'etclb'
#   Tmux.project(:name => 'etclb', :dir => '~/dev/go/src/github.com/yardstick/etclb', :windows => %w(server code bash))
# when 'coredo'
#   Tmux.project(:name => 'coredo', :dir => '~/dev/github/darkhelmet/coredo', :windows => %w(wat code bash))
# when 'yardbot'
#   Tmux.work_project(:name => 'yardbot')
else
  exec('start', 'help', 'project')
end

