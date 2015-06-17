{% from "memcached/map.jinja" import defaults with context -%}

# Macro:
#
# get_config_item(item_name)
# item_name = parameter in the config to get
#
{%- macro get_config_item(item_name) -%}
{%- set default = defaults['config'].get(item_name, None) -%}
{%- set value = salt['pillar.get']('memcached:%s' % (item_name), default) -%}
{%- if value is string or value is number -%}
{{ value }}
{%- elif value is iterable -%}
{%- if not value -%}
None
{%- else -%}
{{ value | join(', ') }}
{%- endif -%}
{%- elif value is none -%}
None
{%- elif value -%}
True
{%- elif not value -%}
False
{%- endif -%}
{%- endmacro -%}