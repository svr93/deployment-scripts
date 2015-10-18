'use strict';

var gulp = require('gulp');

gulp.task('default', function() {

    return gulp.src('client/www/**/*.*')
        .pipe(gulp.dest('server/www'));
});
