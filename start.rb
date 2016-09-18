#!/usr/bin/env ruby
# Usage: start project PROJECT_NAME
# Summary: Start up a project in tmux

# Provide `start` completions
if ARGV.first == '--complete'
  puts 'fenix'
  puts 'dotfiles'
  puts 'yegrb'
  puts 'amy'
  puts 'cube'
  puts 'hamex'
  puts 'exercism'
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

    def _sessions
      `tmux ls`.scan(/^\w+/)
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
    if has_session?(name)
      attach(name)
    else
      start(name, &block)
    end
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

  def self.has_session?(name)
    _sessions.include?(name)
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
when 'dotfiles'
  Tmux.project({
    name: 'dotfiles',
    dir: '~/dotfiles',
    windows: %w(trial work)
  })
when 'yegrb'
  Tmux.personal_project(name: 'yegrb')
when 'amy'
  Tmux.personal_project(name: 'amy', windows: %w(console dev util))
when 'cube'
  Tmux.personal_project(name: 'cube', windows: %w(console dev util))
when 'hamex'
  Tmux.personal_project(name: 'hamex', windows: %w(console dev util))
when 'exercism'
  Tmux.project(name: 'exercism', dir: '~/exercism', windows: %w(console dev util))
else
  if Dir.exist?(File.expand_path(ARGV.first))
    path = File.expand_path(ARGV.first)
    name = path.split('/').last
    name = name.split(' ').first.downcase
    Tmux.project({
      name: name,
      dir: path,
      windows: %w(test dev util)
    })
  elsif ARGV.first.match(/^\w+$/) && Tmux.has_session?(ARGV.first)
    Tmux.attach(ARGV.first)
  else
    exit 1
  end
end
