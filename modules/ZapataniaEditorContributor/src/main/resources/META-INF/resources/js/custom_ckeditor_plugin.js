(function() {
    CKEDITOR.plugins
            .add(
                    'cursivebutton',
                    {
                        init : function(editor) {
                            
                            console.log('CKEditor version:', CKEDITOR.version);
                            var instance = this;

                            editor.addCommand('cursivebutton', {
                                canUndo : true,
                                exec : function(editor, callback) {
                                    instance._onSelectedContentChange(editor,
                                            callback);
                                }
                            });
                            console.log('intento', editor);

                            if (editor.ui.addButton) {
                                editor.ui
                                        .addButton(
                                                'CursiveButton',
                                                {
                                                    command : 'cursivebutton',
                                                    icon : '/o/custom-ckeditor-plugin/js/assets/escritura_cursiva.png',
                                                    label : 'Cursiva'
                                                });
                            }
                            

                        },

                        _onSelectedContentChange : function(editor, callback) {

                            var selection = editor.getSelection();

                            if (selection.getType() === CKEDITOR.SELECTION_TEXT) {
                                var ranges = selection.getRanges();

                                for (var i = 0; i < ranges.length; i++) {
                                    var range = ranges[i];
                                    
                                    // Get all elements within the range
                                    var bookmarks = selection.createBookmarks();
                                    var walker = new CKEDITOR.dom.walker(range);
                                    var element;

                                    // Iterate through elements in the selection
                                    while ((element = walker.next())) {
                                        // Check if the element is an actual DOM element (not just text or comment node)
                                        if (element.type === CKEDITOR.NODE_ELEMENT) {
                                            if( element.hasClass('cursive') ){
                                                // Remove the class using CKEDITOR.dom.element.removeClass()
                                                element.removeClass('cursive');
                                            }else{
                                                // Add the class using CKEDITOR.dom.element.addClass()
                                                element.addClass('cursive');
                                            }
                                        }
                                    }
                                    selection.selectBookmarks(bookmarks);
                                }
                            }

                            var element = editor.getSelection().getStartElement();
                            if( element){
                                if( element.hasClass('cursive') ){
                                    // Remove the class using CKEDITOR.dom.element.removeClass()
                                    element.removeClass('cursive');
                                }else{
                                    // Add the class using CKEDITOR.dom.element.addClass()
                                    element.addClass('cursive');
                                }
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