<form class="layui-form kg-form" method="POST" action="{{ url({'for':'admin.category.update','id':category.id}) }}">

    <fieldset class="layui-elem-field layui-field-title">
        <legend>编辑分类</legend>
    </fieldset>

    <div class="layui-form-item">
        <label class="layui-form-label">名称</label>
        <div class="layui-input-block">
            <input class="layui-input" type="text" name="name" value="{{ category.name }}" lay-verify="required">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">排序</label>
        <div class="layui-input-block">
            <input class="layui-input" type="text" name="priority" value="{{ category.priority }}" lay-verify="number">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">发布</label>
        <div class="layui-input-block">
            <input type="radio" name="published" value="1" title="是" {% if category.published == 1 %}checked{% endif %}>
            <input type="radio" name="published" value="0" title="否" {% if category.published == 0 %}checked{% endif %}>
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label"></label>
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit="true" lay-filter="go">提交</button>
            <button type="button" class="kg-back layui-btn layui-btn-primary">返回</button>
        </div>
    </div>

</form>