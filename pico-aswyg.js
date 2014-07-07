/*global Aswyg */

var editor = new Aswyg(document.body, {

    fetchPageList: function() {
        return Aswyg.$.get("@index");
    },

    fetchPage: function(page) {
        window.location = "/"  + page.slug + "/@edit";
    },

    saveDraft: function(content) {
        return Aswyg.$.ajax({
            url: editor.getDraftUrl(),
            type: "PUT",
            data: content
        });
    },

    publish: function(content) {
        return Aswyg.$.ajax({
            url: editor.getPublicUrl(),
            type: "PUT",
            data: content
        });
    },

    createNew: function(page) {
        window.location = "/"  + page.slug + "/@edit";
    },

    logout: function() {
        window.location = "/@logout";
    },

    delete: function() {
        return Aswyg.$.ajax({
            url: editor.getPublicUrl(),
            type: "DELETE",
        }).then(function() {
            window.location = "/@edit";
        });
    }

});


editor.setContent(window.PICO_INITIAL);
