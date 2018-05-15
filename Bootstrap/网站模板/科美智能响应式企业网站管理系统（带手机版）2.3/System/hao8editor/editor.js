KindEditor.ready(function(K) {
	var editor1 = K.create('textarea[name="a_content"]', {
		cssPath : 'hao8editor/plugins/code/prettify.css',
		uploadJson : 'hao8editor/asp/upload_json.asp',
		fileManagerJson : 'hao8editor/asp/file_manager_json.asp',
		allowFileManager : false,
		afterCreate : function() {
			var self = this;
			K.ctrl(document, 13, function() {
				self.sync();
				K('form[name=example]')[0].submit();
			});
			K.ctrl(self.edit.doc, 13, function() {
				self.sync();
				K('form[name=example]')[0].submit();
			});
		}
	});
	prettyPrint();
});
window.onerror=function(){return true;}