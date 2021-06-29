#!/usr/bin/env ruby
# Usage: start project PROJECT_NAME
# Summary: Start up a project in tmux

# Provide `start` completions
if ARGV.first == '--complete'
  puts 'fenix'
  puts 'fenix-spec'
  puts 'sentry'
  puts 'dotfiles'
  puts 'website'
  puts 'amy'
  puts 'exercism'
  puts '* (personal/fun_project)'
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
      `tmux ls`.scan(/^(.+): \d/).flatten
    end
  end

  include Helpers
  extend Helpers

  Window = Struct.new(:tmux, :name) do
    def send_keys(keys)
      tmux._tmux('send-keys', '-t', "#{tmux.name}:#{index}", keys, 'C-m')
      self
    end

    def send_prefix
      tmux._tmux('send-prefix')
    end

    def set_up(options)
      cd(options[:dir])
      source_rc
      # FIXME: All the splits are happening in the primary window (#1) rather than in the intended window.
      # if options.has_key?(:vsp)
      #   vsp
      #   set_up_pane(options[:vsp])
      #   send_keys('tmux select-pane -L')
      # end
      # if options.has_key?(:sp)
      #   sp
      #   set_up_pane(options[:sp])
      #   send_keys('tmux select-pane -U')
      # end
    end

    def set_up_pane(options)
      if options.is_a?(Hash)
        set_up(options)
      else
        source_rc
      end
    end

    def cd(dir)
      send_keys("cd #{dir}")
    end

    def source_rc
      send_keys('[ -f rc ] && source rc')
    end

    def vsp
      send_keys('tmux split-window -h')
    end

    def sp
      send_keys('tmux split-window -v')
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
    project({ dir: "~/proj/#{name}" }.merge(opts), &block)
  end

  def self.personal_project(opts = {}, &block)
    name = opts.fetch(:name)
    project({ dir: "~/personal/#{name}" }.merge(opts), &block)
  end

  def self.project(opts = {})
    name = opts.fetch(:name)
    windows = opts.fetch(:windows, %w(server dev util))
    Tmux.start_or_attach(name) do |t|
      windows.each do |window|
        t.window(window).
          send_keys("cd #{opts.fetch(:dir)}").
          send_keys('[ -f rc ] && source rc')
      end
      yield(t) if block_given?
    end
  end

  def self.windows(name:, windows:)
    Tmux.start_or_attach(name) do |t|
      windows.each do |options|
        window = t.window(options[:name]).
          set_up(options)
      end
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
  Tmux.windows(
    name: 'fenix',
    windows: [
      { name: 'server', dir: '~/proj/fenix', vsp: { dir: 'proj/venom', sp: true }, sp: true },
      { name: 'fx', dir: '~/proj/fenix', sp: true },
      { name: 'vnm', dir: '~/proj/venom' }
    ]
  )
when 'sentry'
  Tmux.work_project(name: ARGV.first)
when 'awana'
  sw = '~/personal/awana/streamwood'
  rb = '~/personal/awana/rabbot'
  Tmux.windows(
    name: 'awana',
    windows: [
      { name: 'server', dir: sw },
      { name: 'streamwood', dir: sw },
      { name: 'streamwood2', dir: sw },
      { name: 'rabbot', dir: rb }
    ]
  )
when 'dotfiles'
  Tmux.project(
    name: 'dotfiles',
    dir: '~/dotfiles',
    windows: %w(trial work)
  )
when 'amy'
  Tmux.personal_project(name: ARGV.first)
when 'website'
  Tmux.personal_project(name: 'website', dir: '~/personal/nathanfeaver.com')
when 'exercism'
  Tmux.project(name: 'exercism', dir: '~/exercism')
else
  # start tmux in a specific directory (relative to the cwd): `start personal/fun_project`)
  # Name of the tmux session is the final directory name
  # After the first time, you can start using the name (`start fun_project`)
  if Dir.exist?(File.expand_path(ARGV.first))
    path = File.expand_path(ARGV.first)
    name = path.split('/').last
    name = name.split(' ').first.downcase
    Tmux.project(
      name: name,
      dir: path
    )
  elsif ARGV.first.match(/^[\w\-_]+$/) && Tmux.has_session?(ARGV.first)
    Tmux.attach(ARGV.first)
  else
    puts "ERROR: Unknown project, directory, or session - '#{ARGV.first}'"
    exit 1
  end
end
