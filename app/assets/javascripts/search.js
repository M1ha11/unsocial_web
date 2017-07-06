$(document).on('turbolinks:load', function(){
  var result = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.whitespace,
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    remote: {
      url: '/search?query=%QUERY',
      wildcard: '%QUERY'
    }
  });
  $('#search_field').typeahead(null, {
    source: result,
    templates: {
      empty: [
        '<div class="empty-message">',
          'unable to find any',
        '</div>'
    ].join('\n'),
      suggestion: function(result) {
        if (result.object_type == 'Album') {
          return '<p><strong>' + result.object_type + '</strong> – ' + result.title + '</p>';
        } else if (result.object_type == 'User') {
          return '<p><strong>' + result.object_type + '</strong> – ' + result.full_name + '</p>';
        } else {
          return '<p><strong>' + result.object_type + '</strong> – ' + result.description + '</p>';
        }
    }
  }
  });
})
