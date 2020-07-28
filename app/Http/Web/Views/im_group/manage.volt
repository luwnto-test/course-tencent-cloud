{% extends 'templates/layer.volt' %}

{% block content %}

    <div class="im-user-list clearfix">
        <div class="layui-row layui-col-space20">
            {% for item in pager.items %}
                <div class="layui-col-md2">
                    <div class="user-card">
                        {% if item.vip == 1 %}
                            <span class="vip">会员</span>
                        {% endif %}
                        <div class="avatar">
                            <a href="javascript:" title="{{ item.about }}"><img src="{{ item.avatar }}" alt="{{ item.name }}"></a>
                        </div>
                        <div class="name layui-elip" title="{{ item.name }}">{{ item.name }}</div>
                        <div class="action">
                            <a href="javascript:" class="layui-badge-rim apply-friend" data-id="{{ item.id }}" data-name="{{ item.name }}" data-avatar="{{ item.avatar }}">加为好友</a>
                        </div>
                    </div>
                </div>
            {% endfor %}
        </div>
    </div>

    {{ partial('partials/pager') }}

{% endblock %}

{% block include_js %}

    {{ js_include('web/js/my.im.js') }}

{% endblock %}