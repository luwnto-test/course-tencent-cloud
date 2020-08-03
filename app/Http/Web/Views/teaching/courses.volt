{% extends 'templates/main.volt' %}

{% block content %}

    {{ partial('partials/macro_course') }}

    <div class="layout-main">
        <div class="my-sidebar">{{ partial('teaching/menu') }}</div>
        <div class="my-content">
            <div class="wrap">
                <div class="my-nav">
                    <span class="title">我的课程</span>
                </div>
                {% if pager.total_pages > 0 %}
                    <table class="layui-table" lay-size="lg">
                        <colgroup>
                            <col>
                            <col>
                            <col>
                            <col>
                            <col>
                        </colgroup>
                        <thead>
                        <tr>
                            <th>名称</th>
                            <th>课时</th>
                            <th>学员</th>
                            <th>收藏</th>
                            <th>评分</th>
                        </tr>
                        </thead>
                        <tbody>
                        {% for item in pager.items %}
                            {% set course_url = url({'for':'web.course.show','id':item.id}) %}
                            <tr>
                                <td><a href="{{ course_url }}">{{ item.title }}</a> {{ model_info(item.model) }}</td>
                                <td><span class="layui-badge-rim">{{ item.lesson_count }}</span></td>
                                <td><span class="layui-badge-rim">{{ item.user_count }}</span></td>
                                <td><span class="layui-badge-rim">{{ item.favorite_count }}</span></td>
                                <td><span class="layui-badge-rim">{{ item.rating }}</span></td>
                            </tr>
                        {% endfor %}
                        </tbody>
                    </table>
                    {{ partial('partials/pager') }}
                {% endif %}
            </div>
        </div>
    </div>

{% endblock %}