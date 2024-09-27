# frozen_string_literal: true

module Pokeedex
  ##
  # InstallPlaywright class is responsible for checking the dependencies and installing Playwright
  class InstallPlaywright
    NODE_VERSION_REQUIRED = 18

    ##
    # Run the installation process
    def self.run!
      new.run
    end

    ##
    # Check the dependencies and install Playwright
    def run
      check_dependencies!

      install_playwright unless playwright_installed?
    end

    private

    def check_node_installed
      node_version = `node --version`
      return [false, nil] unless $?.success?

      version = node_version.match(/^v(\d+)\.(\d+)\.(\d+)/)
      return [true, version] if version

      [false, nil]
    end

    def check_node_version(version)
      major = version[1].to_i
      minor = version[2].to_i
      major > NODE_VERSION_REQUIRED || (major == NODE_VERSION_REQUIRED && minor >= 0)
    end

    def check_dependencies!
      node_installed, node_version = check_node_installed

      unless node_installed
        warn 'Hi! Sorry =( Pokeedex needs Node.js 18 version or lastest to work. Please install them before running the program.'

        exit 1
      end

      return if check_node_version(node_version)

      warn "Please use Node.js 18 version or lastest. Your current version is #{node_version}."

      exit 1
    end

    def playwright_installed?
      system('npm list -g playwright > /dev/null 2>&1')
    end

    def install_playwright
      puts 'Installing Playwright...'

      system('npm install -g playwright')
      system('npx playwright install')
    end
  end
end
