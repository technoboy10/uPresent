# uPresent grammar
# written in nearley
# see test.up for an example of what this parses

@{% var slideCount = 0; %}

main -> lphrase _ presentation _ {% function(d) {
       		return "<!DOCTYPE html><html><head>" +
			"<title>" + d[0] + "</title>" +
			'<link rel="stylesheet" href="style.css" type="text/css">' +
			'<script src="scripts.js" type="text/javascript"></script>' +
			"</head><body onload='load()'>" +
			d[2] +
			"</body></html>";
	} %}

presentation -> slide {% id %} |
		presentation slide {% function(d) {
			return d[0] + d[1];
		} %}

slide -> slidemarker "\n" content _ {%
	function(d) {
		var slideNumber = slideCount++;	

		return "<div class='slide' id='slide" +
			
			slideNumber +

			"'>"
			+ d[2]
			+ "</div>"
	} %}

slidemarker -> "-" {% function() { return null } %}
		| slidemarker "-" {% function() { return null } %}

content -> line | 
	   content line {% function(d) { return d[0] + d[1] } %}

line -> _ marker "\n" {% function(d) { return d[1] + "<br/>" } %} |
	_ lphrase "\n" {% function(d) { return d[1] + "<br/>" } %}

italics -> "_" lphrase "_" {% function(d) { return "<i>" + d[1] + "</i>" } %}
bold -> "**" lphrase "**" {% function(d) { return "<b>" + d[1] + "</b>" } %}
image -> "![" lphrase "](" path ")" {% function(d) { return '<img alt="' + d[1] + '" src="' + d[3] + '" />' } %}

lphrase -> linecharacter {% id %}
		| lphrase linecharacter {% function(d) { return d[0]+d[1] } %}
		| lphrase [#] {% function(d) { return d[0]+d[1] } %}
		| lphrase italics {% function(d) { return d[0]+d[1] } %}
		| lphrase bold {% function(d) { return d[0]+d[1] } %}
		| lphrase image {% function(d) { return d[0]+d[1] } %}
		| lphrase [\-] {% function(d) { return d[0]+d[1] } %}

linecharacter -> [A-Za-z0-9 !@$%^&()+=.,<>/?'";:\|\]\[\{\}]
marker -> "~~" lphrase {% function(d) {
		return "<span class='indent'>&nbsp; &nbsp; </span> &#8227; " + d[1];
	} %}
	
	| "~" lphrase {% function(d) {
	       return "&bull; " + d[1];
	} %}

	| "#" lphrase {% function(d) {
		return "<h1>" +
			d[1] +
			"</h1>";
		} %}

pathchar -> [A-Za-z0-9:\/!@#$%^&*()_+=\-\'] {% id %}
path ->   pathchar {% id %}
	| path pathchar {% function(d) { return d[0]+d[1] } %}

_ -> null {% function(){ return null } %}
	| [\s] _ {% function() { return null } %}
