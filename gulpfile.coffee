gulp   = require 'gulp'
jade   = require 'gulp-jade'
coffee = require 'gulp-coffee'
uglify = require 'gulp-uglify'
sass   = require 'gulp-ruby-sass'
minify = require 'gulp-minify-css'
concat = require 'gulp-concat'
watch  = require 'gulp-watch'
server = require 'gulp-webserver'
livereload = require 'gulp-livereload'
plumber = require 'gulp-plumber'
notify  = require 'gulp-notify'
imagemin= require 'gulp-imagemin'
open    = require 'gulp-open'
del     = require 'del'

pub_dir = 'app/public'
view_dir = 'app/views'

gulp.task 'compile-js', () ->
  compileFileName = 'application.min.js'
  gulp.src ['source/coffee/**/*.coffee']
    .pipe plumber(errorHandler: notify.onError '<%= error.message %>')
    .pipe coffee()
    .pipe gulp.dest('source/.tmp')
    .pipe uglify()
    .pipe concat(compileFileName)
    .pipe gulp.dest(pub_dir+'/scripts')

gulp.task 'compile-css', () ->
  compileFileName = 'application.min.css'
  gulp.src ['source/sass/**/*.scss','dev/vendors/**/*.css']
    .pipe plumber(errorHandler: notify.onError '<%= error.message %>')
    .pipe sass()
    .pipe gulp.dest('source/.tmp/')
    .pipe concat(compileFileName)
    .pipe minify()
    .pipe gulp.dest(pub_dir+'/styles')

gulp.task 'compile-html', () ->
  compileFileName = 'index.erb'
  gulp.src 'source/jade/**/*.jade'
    .pipe plumber(errorHandler: notify.onError '<%= error.message %>')
    .pipe jade()
    .pipe concat(compileFileName)
    .pipe gulp.dest(view_dir)

gulp.task 'compile-image', () ->
  gulp.src ['source/resources/**/*']
    .pipe imagemin()
    .pipe gulp.dest(pub_dir+'/resources')

gulp.task 'move-vendors', () ->
  gulp.src ['dev/vendors/**/*']
    .pipe gulp.dest(pub_dir+'/vendors')

gulp.task 'move-pjs', () ->
  gulp.src ['source/pjs/**/*']
    .pipe gulp.dest(pub_dir+'/pjs')

gulp.task 'webserver', () ->
  gulp.src pub_dir
    .pipe server(livereload:true)

gulp.task 'open', () ->
  option = {
    url: 'localhost:9393',
    app: 'google-chrome'
  }
  gulp.src('./')
    .pipe open(option)

gulp.task 'clean' , (cb) ->
  del ['app/public', 'app/views'], cb

gulp.task 'compile', [
  'compile-js',
  'compile-css',
  'compile-html',
  'move-vendors',
  'move-pjs',
  'compile-image'
]
gulp.task 'watch', () ->
  gulp.watch 'source/sass/**/*.scss', ->
    gulp.start 'compile-css'
  gulp.watch 'source/coffee/**/*.coffee', ->
    gulp.start 'compile-js'
  gulp.watch 'source/jade/**/*.jade', ->
    gulp.start 'compile-html'
  gulp.watch 'source/resources/**/*', ->
    gulp.start 'compile-image'
  gulp.watch 'source/pjs/**/*', ->
    gulp.start 'move-pjs'

gulp.task 'default', [
  'compile',
  'watch',
  'webserver'
]
