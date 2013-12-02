var Template = {
    render: function (template, values) {
        var compiledTemplate = Hogan.compile(template);
        return compiledTemplate.render(values);
//        return Mustache.render(template, values);
    }
}