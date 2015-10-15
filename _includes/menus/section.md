{% if page.collection %}
---

### Further Reading

{% for doc in site.collections[page.collection].docs %}
- [{{doc.title}}]({{doc.url}}){% endfor %}

{% endif %}
