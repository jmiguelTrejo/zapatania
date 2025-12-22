(function() {
    CKEDITOR.plugins
            .add(
                    'insertsnippet',
                    {
                        init : function(editor) {
                            var instance = this;

                            editor.addCommand('insertsnippet', {
                                canUndo : false,
                                exec : function(editor, callback) {
                                    instance._onSelectedContentChange(editor,
                                            callback);
                                }
                            });

                            if (editor.ui.addButton) {
                                editor.ui
                                        .addButton(
                                                'InsertSnippet',
                                                {
                                                    command : 'insertsnippet',
                                                    icon : '/o/custom-ckeditor-plugin/js/assets/escritura_cursiva.png',
                                                    label : 'Insert Snippet'
                                                });
                            }

                        },

                        _onSelectedContentChange : function(editor, callback) {
                            var instance = this;

                            var element = editor.getSelection().getStartElement();
                            if( element){
                                element.addClass('cursive');
                            }
                        },

                        _getData : function(selectedItem) {
                            var data = '';

                            try {
                                data = JSON.parse(selectedItem)
                            } catch (e) {
                                console.log('error', e);
                            }

                            return data;
                        },
                    });
})();