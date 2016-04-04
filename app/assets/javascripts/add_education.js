$(function() {
	$( document ).ready(function() {
		if($('.present_option').val() == 'false')
			$('.present_option').parents('.form-group').next().show();
	});
	var edu_index = 0;
	$('#add-education-btn').click(function(){
		edu_index++;
		var con = $('.education-container');
		var template = $('#education-template').html();
	  var rendered = Mustache.render(template, {education_index: edu_index});
	  con.append(rendered);
	});
	var exp_index = 0;
	$('#add-experience-btn').click(function(){
		exp_index++;
		var con = $('.experience-container');
		var template = $('#experience-template').html();
	  var rendered = Mustache.render(template, {experience_index: exp_index});
	  con.append(rendered);
	});
	$('body').on('click', '.delete-education-btn', function(delete_edu){
		$(delete_edu.target).parents('.education').children('.delete_education').val(1);
		$(delete_edu.target).parents('.education').hide();
		edu_index--;
	});
	$('body').on('click', '.delete-experience-btn', function(delete_exp){
		$(delete_exp.target).parents('.experience').children('.delete_experience').val(1);
		$(delete_exp.target).parents('.experience').hide();
		exp_index--;
	});
	$('body').on('change', '.present_option', function(exp){
		if($(exp.target).val() == 'false')
			$(exp.target).parents('.form-group').next().show();
		if($(exp.target).val() == 'true')
			$(exp.target).parents('.form-group').next().hide();
	});
});