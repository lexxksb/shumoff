module.exports = function(grunt) {

	//var dirs = grunt.file.readJSON('directories.json');

	grunt.initConfig({
		pkg: grunt.file.readJSON('package.json'),

		less: {
			development: {
				options: {
					paths: ["css"]
				},
				files: {
					"css/result.css": ["less/source.less", "less/queries.less", "less/ie.less"]
				}
			}
		},

		sprite:{
			all: {
				src: 'img/sprites/*.png',
				dest: 'img/spritesheet.png',
				destCss: 'css/sprites.css'
			}
		},

		cssmin: {
			combine: {
				files: {
					'css/production.min.css': [
						'css/bootstrap.css',
						'css/result.css',
						'css/sprites.css',
                        'css/colorbox.css'
					]
				}
			}
		},

		uglify: {
			js: {
				src: [
					'js/vendor/jquery-1.11.1.min.js',
					'js/vendor/modernizr-2.6.2-respond-1.1.0.min.js',
                    'js/vendor/jquery.colorbox.js',
                    'js/vendor/bootstrap.min.js',
					'js/main.js'
				],
				dest: 'js/production.min.js'
			}
		},

		watch: {
			css: {
				files: ['less/*.less', 'css/colorbox.css'],
				tasks: ['less', 'cssmin']
			},
			js: {
				files: ['js/main.js'],
				tasks: ['uglify']
			},
			sprite: {
				files: ['img/sprites/*.png'],
				tasks: ['sprite:all', 'cssmin']
			}
		}

	});

	grunt.loadNpmTasks('grunt-contrib-cssmin');
	grunt.loadNpmTasks('grunt-contrib-uglify');
	grunt.loadNpmTasks('grunt-contrib-less');
	grunt.loadNpmTasks('grunt-spritesmith');
	grunt.loadNpmTasks('grunt-contrib-watch');

	grunt.registerTask('default', ['less', 'sprite', 'cssmin', 'uglify']);

};