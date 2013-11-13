define forumone::solr::file ($template = undef, $directory = undef) {
  if !$template {
    $template = 'forumone/solr'
  }

  $file_array = split($name, '[.]')
  $file_array_pieces = delete_at($file_array, (size($file_array) - 1))
  $file_name = join($file_array_pieces, ".")
  $file_template = "${template}/${file_name}.erb"
  $file_destination = "${directory}/${name}"
  
  file { $file_destination:
    ensure  => present,
    owner   => "root",
    group   => "root",
    mode    => "755",
    content => template($file_template),
    require => File[$directory],
    notify => Service["solr"]
  }
}