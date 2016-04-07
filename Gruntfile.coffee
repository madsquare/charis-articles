module.exports = (grunt) ->
  # load all grunt tasks
  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks)

  config =
    shell:
      jekyll:
        command: 'jekyll build'

    connect:
      server:
        options:
          port: 8080
          base: '_site'

    watch:
      livereload:
        files: [
          '_config.yml'
          'articles.html'
          'assets/css/**'
          '_layouts/**'
          '_articles/**'
          '_includes/**'
        ]
        tasks: [
          'shell:jekyll'
        ]
        options:
          livereload: true

  grunt.initConfig config
  grunt.registerTask 'default', ['shell', 'connect', 'watch']
