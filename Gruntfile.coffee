module.exports = (grunt) ->
  # load all grunt tasks
  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks)

  config =
    aws: grunt.file.readJSON 'deploy.json'
    charis: grunt.file.readJSON 'charis.json'
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
        path: 'https://magazine.hicharis.net/articles.html'
        app: 'Google Chrome'

    shell:
      jekyll:
        command: 'jekyll build'

    connect:
      server:
        options:
          port: 8080
          base: '_site'

    sass:
      dist:
        options:
          style: 'compressed'
          loadPath: 'assets/css/_scss'
          sourcemap: 'none'
        files:
          '_site/assets/css/style.css': 'assets/css/style.scss'

    http:
      sync:
        options:
          url: '<%= charis.endpoint %>'
          method: 'PUT'
          headers:
            Authorization: (()->
              md5 = require('md5')
              charis = grunt.file.readJSON 'charis.json'

              ts = Date.now()
              token = new Buffer([
                charis.clientId,
                md5(charis.clientSecret + ts),
                ts
              ].join(':')).toString('base64')

              return 'Basic ' + token
            )()

    watch:
      livereload:
        files: [
          '_config.yml'
          '*.html'
          '_layouts/**'
          '_articles/**'
          '_includes/**'
        ]
        tasks: [
          'shell:jekyll'
          'sass:dist'
        ]
        options:
          livereload: true
      sass:
        files: [
          'assets/css/**'
        ]
        tasks: [
          'sass:dist'
        ]
        options:
          livereload: true


  grunt.initConfig config
  grunt.registerTask 'default', [
    'shell', 'connect', 'sass', 'open:dev', 'watch'
  ]
  grunt.registerTask 'deploy', [
    'shell', 'sass', 'aws_s3', 'open:magazine'
  ]
  grunt.registerTask 'sync', [
    'http:sync'
  ]
