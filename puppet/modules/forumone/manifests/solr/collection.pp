define forumone::solr::collection ($order = 10, $files = undef) {
  if $::forumone::solr_install == true {
    file { "${::forumone::solr::path}/${name}": ensure => 'directory', }

    file { "${::forumone::solr::path}/${name}/conf": ensure => 'directory', }

    concat::fragment { "solr_collection_${name}":
      target  => "${::forumone::solr::path}/solr.xml",
      content => "<core name='${name}' instanceDir='${name}' />",
      notify  => Service['solr']
    }

    if $files == undef {
      if $::forumone::solr::major_version == "4" {
        $solr_file = [
          "elevate.xml",
          "protwords.txt",
          "mapping-ISOLatin1Accent.txt",
          "schema_extra_fields.xml",
          "schema_extra_types.xml",
          "schema.xml",
          "solrconfig_extra.xml",
          "solrconfig.xml",
          "solrcore.properties"]
      } elsif $::forumone::solr::major_version == "3" {
        $solr_files = [
          "elevate.xml",
          "protwords.txt",
          "mapping-ISOLatin1Accent.txt",
          "schema_extra_fields.xml",
          "schema_extra_types.xml",
          "schema.xml",
          "solrconfig_extra.xml",
          "solrconfig.xml",
          "solrcore.properties",
          "stopwords.txt",
          "synonyms.txt"]
      }
    } else {
      $solr_files = $files
    }

    forumone::solr::file { $solr_files:
      template  => "forumone/solr/conf/${::forumone::solr::conf}",
      directory => "${::forumone::solr::path}/${name}/conf"
    }
  }
}