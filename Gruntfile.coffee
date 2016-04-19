module.exports = (grunt) ->
  # load all grunt tasks
  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks)

  config =
    aws: grunt.file.readJSON 'deploy.json'
    aws_s3:
      options:
        accessKeyId: '<%= aws.accessKeyId %>'
        secretAccessKey: '<%= aws.secretAccessKey %>'
        region: '<%= aws.region %>'
        uploadConcurrency: 5
        downloadConcurrency: 5
      magazine:
        options:
          bucket: 'magazine.hicharis.net'
        files: [
          expand: true
          cwd: '_site'
          src: '**'
          dest: '/'
        ]

    open:
      dev:
        path: 'http://127.0.0.1:8080/articles.html'
        app: 'Google Chrome'
      magazine:
        path: 'http://magazine.hicharis.net/articles.html'
        app: 'Google Chrome'

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
  grunt.registerTask 'default', ['shell', 'connect', 'open:dev', 'watch']
  grunt.registerTask 'deploy', ['shell', 'aws_s3', 'open:magazine']
