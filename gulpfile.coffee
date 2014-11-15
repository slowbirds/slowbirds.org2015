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

pub_dir = 'app'

gulp.task 'compile-js', () ->
  compileFileName = 'application.min.js'
  gulp.src ['source/coffee/**/*.coffee']
    .pipe plumber(errorHandler: notify.onError '<%= error.message %>')
    .pipe coffee()
    .pipe gulp.dest(pub_dir+'/public/scripts_test')
    .pipe uglify()
    .pipe concat(compileFileName)
    .pipe gulp.dest(pub_dir+'/public/scripts')

gulp.task 'compile-css', () ->
  compileFileName = 'application.min.css'
  gulp.src ['source/sass/**/*.scss','dev/vendors/**/*.css']
    .pipe plumber(errorHandler: notify.onError '<%= error.message %>')
    .pipe sass()
    .pipe concat(compileFileName)
    .pipe minify()
    .pipe gulp.dest(pub_dir+'/public/styles')

gulp.task 'compile-html', () ->
  compileFileName = 'index.erb'
  gulp.src 'source/jade/**/*.jade'
    .pipe plumber(errorHandler: notify.onError '<%= error.message %>')
    .pipe jade()
    .pipe concat(compileFileName)
    .pipe gulp.dest(pub_dir+'/views')

gulp.task 'compile-image', () ->
  gulp.src ['source/resources/**/*']
    .pipe imagemin()
    .pipe gulp.dest(pub_dir+'/public/resources')

gulp.task 'move-vendors', () ->
  gulp.src ['dev/vendors/**/*']
    .pipe gulp.dest(pub_dir+'/public/vendors')

gulp.task 'webserver', () ->
  gulp.src pub_dir
    .pipe server(livereload:true)

gulp.task 'compile', [
  'compile-js',
  'compile-css',
  'compile-html',
  'move-vendors',
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

gulp.task 'default', [
  'compile',
  'watch',
  'webserver'
]
