define('mod-validate', ['jquery', 'validate'], function(require, exports, module) {

	var $ = require('jquery');
	var FormValidator = require('validate');

	module.exports = {
		rules_page1: [{
			name: 'req',
			display: 'required',
			rules: 'required'
		}, {
			name: 'alphanumeric',
			rules: 'alpha_numeric'
		}, {
			name: 'password',
			rules: 'required'
		}, {
			name: 'password_confirm',
			display: 'password confirmation',
			rules: 'required|matches[password]'
		}, {
			name: 'email',
			rules: 'valid_email'
		}, {
			name: 'minlength',
			display: 'min length',
			rules: 'min_length[8]'
		}],
		createValidate: function(formName, errorHolder, rules) {
			var handler = function(errors, e) {
				console.log(rules, errors);
				if(errors.length > 0) {
					var errorString = '';
					for(var i = 0, errorLength = errors.length; i < errorLength; i++) {
						errorString += errors[i].message + '<br />';
					}
					$(errorHolder).html(errorString);
				}
				if(e && e.preventDefault) {
					e.preventDefault();
				} else if(e) {
					e.returnValue = false;
				}
			};
			return new FormValidator(formName, rules, handler);
		}
	};
});