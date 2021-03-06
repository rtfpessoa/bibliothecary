require 'ox'
require 'json'

module Bibliothecary
  module Parsers
    class Nuget
      include Bibliothecary::Analyser

      def self.mapping
        {
          /Project\.json$/ => {
            kind: 'manifest',
            parser: :parse_project_json
          },
          /Project\.lock\.json$/ => {
            kind: 'lockfile',
            parser: :parse_project_lock_json
          },
          /packages\.config$/ => {
            kind: 'manifest',
            parser: :parse_packages_config
          },
          /^[A-Za-z0-9_-]+\.nuspec$/ => {
            kind: 'manifest',
            parser: :parse_nuspec
          },
          /paket\.lock$/ => {
            kind: 'lockfile',
            parser: :parse_paket_lock
          }
        }
      end

      def self.parse_project_json(file_contents)
        manifest = JSON.parse file_contents
        manifest.fetch('dependencies',[]).map do |name, requirement|
          {
            name: name,
            requirement: requirement,
            type: 'runtime'
          }
        end
      end

      def self.parse_project_lock_json(file_contents)
        manifest = JSON.parse file_contents
        manifest.fetch('libraries',[]).map do |name, _requirement|
          dep = name.split('/')
          {
            name: dep[0],
            requirement: dep[1],
            type: 'runtime'
          }
        end
      end

      def self.parse_packages_config(file_contents)
        manifest = Ox.parse file_contents
        manifest.packages.locate('package').map do |dependency|
          {
            name: dependency.id,
            version: dependency.version,
            type: 'runtime'
          }
        end
      end

      def self.parse_nuspec(file_contents)
        manifest = Ox.parse file_contents
        manifest.package.metadata.dependencies.locate('dependency').map do |dependency|
          {
            name: dependency.id,
            version: dependency.attributes[:version] || '*',
            type: 'runtime'
          }
        end
      end

      def self.parse_paket_lock(file_contents)
        lines = file_contents.split("\n")
        package_version_re = /\s+(?<name>\S+)\s\((?<version>\d+\.\d+[\.\d+[\.\d+]*]*)\)/
        packages = lines.select { |line| package_version_re.match(line) }.map { |line| package_version_re.match(line) }.map do |match|
          {
            name: match[:name].strip,
            version: match[:version],
            type: 'runtime'
          }
        end
        # we only have to enforce uniqueness by name because paket ensures that there is only the single version globally in the project
        packages.uniq {|package| package[:name] }
      end
    end
  end
end
