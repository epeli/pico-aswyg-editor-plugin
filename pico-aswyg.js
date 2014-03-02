/*global Aswyg */

var editor = new Aswyg(document.body, {

    fetchPageList: function() {
        return Aswyg.$.get("@index");
    },

    fetchPage: function(page) {
        history.pushState(page, "", "/"  + page.slug + "/@edit");
        return Aswyg.$.get("/" + page.slug + "/@json");
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
        history.pushState(page, "", "/"  + page.slug + "/@edit");
        return Aswyg.$.get("/" + page.slug + "/@json");
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


window.onpopstate = function() {
    // TODO: setContent
    console.log("pop state", arguments);
};

editor.setContent(window.PICO_INITIAL);
