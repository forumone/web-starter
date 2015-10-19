{% if page.collection %}
---

### Further Reading

{% for doc in site.collections[page.collection].docs %}
- [{{doc.title}}]({{site.baseurl}}/{{doc.url}}){% endfor %}

{% endif %}
