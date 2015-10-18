'use strict';

var gulp = require('gulp');
var babel = require('gulp-babel');

gulp.task('js', function() {

    return gulp.src([
            'client/www/js/**/*.js',
            '!client/www/js/vendor/*.js'
        ])
        .pipe(babel({
            plugins: ["object-assign"],
            blacklist: ['strict']
        }))
        .pipe(gulp.dest('server/www/js'));
});

gulp.task('default', ['js'], function() {

    return gulp.src([
            'client/www/**/*.*',
            '!client/www/**/*.js'
        ])
        .pipe(gulp.dest('server/www'));
});
