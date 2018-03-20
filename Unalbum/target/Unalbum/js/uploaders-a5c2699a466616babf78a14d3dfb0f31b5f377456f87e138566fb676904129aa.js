!function(t){"use strict";"function"==typeof define&&define.amd?define(["jquery","jquery.ui.widget"],t):t(window.jQuery)}(function(t){"use strict";t.support.xhrFileUpload=!(!window.XMLHttpRequestUpload||!window.FileReader),t.support.xhrFormDataFileUpload=!!window.FormData,t.propHooks.elements={get:function(e){return t.nodeName(e,"form")?t.grep(e.elements,function(e){return!t.nodeName(e,"input")||"file"!==e.type}):null}},t.widget("blueimp.fileupload",{options:{dropZone:t(document),pasteZone:t(document),fileInput:void 0,replaceFileInput:!0,paramName:void 0,singleFileUploads:!0,limitMultiFileUploads:void 0,sequentialUploads:!1,limitConcurrentUploads:void 0,forceIframeTransport:!1,redirect:void 0,redirectParamName:void 0,postMessage:void 0,multipart:!0,maxChunkSize:void 0,uploadedBytes:void 0,recalculateProgress:!0,progressInterval:100,bitrateInterval:500,formData:function(t){return t.serializeArray()},add:function(t,e){e.submit()},processData:!1,contentType:!1,cache:!1},_refreshOptionsList:["fileInput","dropZone","pasteZone","multipart","forceIframeTransport"],_BitrateTimer:function(){this.timestamp=+new Date,this.loaded=0,this.bitrate=0,this.getBitrate=function(t,e,n){var i=t-this.timestamp;return(!this.bitrate||!n||i>n)&&(this.bitrate=(e-this.loaded)*(1e3/i)*8,this.loaded=e,this.timestamp=t),this.bitrate}},_isXHRUpload:function(e){return!e.forceIframeTransport&&(!e.multipart&&t.support.xhrFileUpload||t.support.xhrFormDataFileUpload)},_getFormData:function(e){var n;return"function"==typeof e.formData?e.formData(e.form):t.isArray(e.formData)?e.formData:e.formData?(n=[],t.each(e.formData,function(t,e){n.push({name:t,value:e})}),n):[]},_getTotal:function(e){var n=0;return t.each(e,function(t,e){n+=e.size||1}),n},_onProgress:function(t,e){if(t.lengthComputable){var n,i,o=+new Date;if(e._time&&e.progressInterval&&o-e._time<e.progressInterval&&t.loaded!==t.total)return;e._time=o,n=e.total||this._getTotal(e.files),i=parseInt(t.loaded/t.total*(e.chunkSize||n),10)+(e.uploadedBytes||0),this._loaded+=i-(e.loaded||e.uploadedBytes||0),e.lengthComputable=!0,e.loaded=i,e.total=n,e.bitrate=e._bitrateTimer.getBitrate(o,i,e.bitrateInterval),this._trigger("progress",t,e),this._trigger("progressall",t,{lengthComputable:!0,loaded:this._loaded,total:this._total,bitrate:this._bitrateTimer.getBitrate(o,this._loaded,e.bitrateInterval)})}},_initProgressListener:function(e){var n=this,i=e.xhr?e.xhr():t.ajaxSettings.xhr();i.upload&&(t(i.upload).bind("progress",function(t){var i=t.originalEvent;t.lengthComputable=i.lengthComputable,t.loaded=i.loaded,t.total=i.total,n._onProgress(t,e)}),e.xhr=function(){return i})},_initXHRData:function(e){var n,i=e.files[0],o=e.multipart||!t.support.xhrFileUpload,r=e.paramName[0];e.headers=e.headers||{},e.contentRange&&(e.headers["Content-Range"]=e.contentRange),o?t.support.xhrFormDataFileUpload&&(e.postMessage?(n=this._getFormData(e),e.blob?n.push({name:r,value:e.blob}):t.each(e.files,function(t,i){n.push({name:e.paramName[t]||r,value:i})})):(e.formData instanceof FormData?n=e.formData:(n=new FormData,t.each(this._getFormData(e),function(t,e){n.append(e.name,e.value)})),e.blob?(e.headers["Content-Disposition"]='attachment; filename="'+encodeURI(i.name)+'"',n.append(r,e.blob,i.name)):t.each(e.files,function(t,i){(window.Blob&&i instanceof Blob||window.File&&i instanceof File)&&n.append(e.paramName[t]||r,i,i.name)})),e.data=n):(e.headers["Content-Disposition"]='attachment; filename="'+encodeURI(i.name)+'"',e.contentType=i.type,e.data=e.blob||i),e.blob=null},_initIframeSettings:function(e){e.dataType="iframe "+(e.dataType||""),e.formData=this._getFormData(e),e.redirect&&t("<a></a>").prop("href",e.url).prop("host")!==location.host&&e.formData.push({name:e.redirectParamName||"redirect",value:e.redirect})},_initDataSettings:function(t){this._isXHRUpload(t)?(this._chunkedUpload(t,!0)||(t.data||this._initXHRData(t),this._initProgressListener(t)),t.postMessage&&(t.dataType="postmessage "+(t.dataType||""))):this._initIframeSettings(t,"iframe")},_getParamName:function(e){var n=t(e.fileInput),i=e.paramName;return i?t.isArray(i)||(i=[i]):(i=[],n.each(function(){for(var e=t(this),n=e.prop("name")||"files[]",o=(e.prop("files")||[1]).length;o;)i.push(n),o-=1}),i.length||(i=[n.prop("name")||"files[]"])),i},_initFormSettings:function(e){e.form&&e.form.length||(e.form=t(e.fileInput.prop("form")),e.form.length||(e.form=t(this.options.fileInput.prop("form")))),e.paramName=this._getParamName(e),e.url||(e.url=e.form.prop("action")||location.href),e.type=(e.type||e.form.prop("method")||"").toUpperCase(),"POST"!==e.type&&"PUT"!==e.type&&"PATCH"!==e.type&&(e.type="POST"),e.formAcceptCharset||(e.formAcceptCharset=e.form.attr("accept-charset"))},_getAJAXSettings:function(e){var n=t.extend({},this.options,e);return this._initFormSettings(n),this._initDataSettings(n),n},_enhancePromise:function(t){return t.success=t.done,t.error=t.fail,t.complete=t.always,t},_getXHRPromise:function(e,n,i){var o=t.Deferred(),r=o.promise();return n=n||this.options.context||r,e===!0?o.resolveWith(n,i):e===!1&&o.rejectWith(n,i),r.abort=o.promise,this._enhancePromise(r)},_getUploadedBytes:function(t){var e=t.getResponseHeader("Range"),n=e&&e.split("-"),i=n&&n.length>1&&parseInt(n[1],10);return i&&i+1},_chunkedUpload:function(e,n){var i,o,r=this,a=e.files[0],s=a.size,u=e.uploadedBytes=e.uploadedBytes||0,l=e.maxChunkSize||s,c=a.slice||a.webkitSlice||a.mozSlice,d=t.Deferred(),h=d.promise();return this._isXHRUpload(e)&&c&&(u||s>l)&&!e.data?n?!0:u>=s?(a.error="Uploaded bytes exceed file size",this._getXHRPromise(!1,e.context,[null,"error",a.error])):(o=function(n){var h=t.extend({},e);h.blob=c.call(a,u,u+l,a.type),h.chunkSize=h.blob.size,h.contentRange="bytes "+u+"-"+(u+h.chunkSize-1)+"/"+s,r._initXHRData(h),r._initProgressListener(h),i=(r._trigger("chunksend",null,h)!==!1&&t.ajax(h)||r._getXHRPromise(!1,h.context)).done(function(n,i,a){u=r._getUploadedBytes(a)||u+h.chunkSize,(!h.loaded||h.loaded<h.total)&&r._onProgress(t.Event("progress",{lengthComputable:!0,loaded:u-h.uploadedBytes,total:u-h.uploadedBytes}),h),e.uploadedBytes=h.uploadedBytes=u,h.result=n,h.textStatus=i,h.jqXHR=a,r._trigger("chunkdone",null,h),r._trigger("chunkalways",null,h),s>u?o():d.resolveWith(h.context,[n,i,a])}).fail(function(t,e,n){h.jqXHR=t,h.textStatus=e,h.errorThrown=n,r._trigger("chunkfail",null,h),r._trigger("chunkalways",null,h),d.rejectWith(h.context,[t,e,n])})},this._enhancePromise(h),h.abort=function(){return i.abort()},o(),h):!1},_beforeSend:function(t,e){0===this._active&&(this._trigger("start"),this._bitrateTimer=new this._BitrateTimer),this._active+=1,this._loaded+=e.uploadedBytes||0,this._total+=this._getTotal(e.files)},_onDone:function(e,n,i,o){if(!this._isXHRUpload(o)||!o.loaded||o.loaded<o.total){var r=this._getTotal(o.files)||1;this._onProgress(t.Event("progress",{lengthComputable:!0,loaded:r,total:r}),o)}o.result=e,o.textStatus=n,o.jqXHR=i,this._trigger("done",null,o)},_onFail:function(t,e,n,i){i.jqXHR=t,i.textStatus=e,i.errorThrown=n,this._trigger("fail",null,i),i.recalculateProgress&&(this._loaded-=i.loaded||i.uploadedBytes||0,this._total-=i.total||this._getTotal(i.files))},_onAlways:function(t,e,n,i){this._active-=1,this._trigger("always",null,i),0===this._active&&(this._trigger("stop"),this._loaded=this._total=0,this._bitrateTimer=null)},_onSend:function(e,n){var i,o,r,a,s=this,u=s._getAJAXSettings(n),l=function(){return s._sending+=1,u._bitrateTimer=new s._BitrateTimer,i=i||((o||s._trigger("send",e,u)===!1)&&s._getXHRPromise(!1,u.context,o)||s._chunkedUpload(u)||t.ajax(u)).done(function(t,e,n){s._onDone(t,e,n,u)}).fail(function(t,e,n){s._onFail(t,e,n,u)}).always(function(t,e,n){if(s._sending-=1,s._onAlways(t,e,n,u),u.limitConcurrentUploads&&u.limitConcurrentUploads>s._sending)for(var i,o=s._slots.shift();o;){if(i=o.state?"pending"===o.state():!o.isRejected()){o.resolve();break}o=s._slots.shift()}})};return this._beforeSend(e,u),this.options.sequentialUploads||this.options.limitConcurrentUploads&&this.options.limitConcurrentUploads<=this._sending?(this.options.limitConcurrentUploads>1?(r=t.Deferred(),this._slots.push(r),a=r.pipe(l)):a=this._sequence=this._sequence.pipe(l,l),a.abort=function(){return o=[void 0,"abort","abort"],i?i.abort():(r&&r.rejectWith(u.context,o),l())},this._enhancePromise(a)):l()},_onAdd:function(e,n){var i,o,r,a,s=this,u=!0,l=t.extend({},this.options,n),c=l.limitMultiFileUploads,d=this._getParamName(l);if((l.singleFileUploads||c)&&this._isXHRUpload(l))if(!l.singleFileUploads&&c)for(r=[],i=[],a=0;a<n.files.length;a+=c)r.push(n.files.slice(a,a+c)),o=d.slice(a,a+c),o.length||(o=d),i.push(o);else i=d;else r=[n.files],i=[d];return n.originalFiles=n.files,t.each(r||n.files,function(o,a){var l=t.extend({},n);return l.files=r?a:[a],l.paramName=i[o],l.submit=function(){return l.jqXHR=this.jqXHR=s._trigger("submit",e,this)!==!1&&s._onSend(e,this),this.jqXHR},u=s._trigger("add",e,l)}),u},_replaceFileInput:function(e){var n=e.clone(!0);t("<form></form>").append(n)[0].reset(),e.after(n).detach(),t.cleanData(e.unbind("remove")),this.options.fileInput=this.options.fileInput.map(function(t,i){return i===e[0]?n[0]:i}),e[0]===this.element[0]&&(this.element=n)},_handleFileTreeEntry:function(e,n){var i,o=this,r=t.Deferred(),a=function(t){t&&!t.entry&&(t.entry=e),r.resolve([t])};return n=n||"",e.isFile?e._file?(e._file.relativePath=n,r.resolve(e._file)):e.file(function(t){t.relativePath=n,r.resolve(t)},a):e.isDirectory?(i=e.createReader(),i.readEntries(function(t){o._handleFileTreeEntries(t,n+e.name+"/").done(function(t){r.resolve(t)}).fail(a)},a)):r.resolve([]),r.promise()},_handleFileTreeEntries:function(e,n){var i=this;return t.when.apply(t,t.map(e,function(t){return i._handleFileTreeEntry(t,n)})).pipe(function(){return Array.prototype.concat.apply([],arguments)})},_getDroppedFiles:function(e){e=e||{};var n=e.items;return n&&n.length&&(n[0].webkitGetAsEntry||n[0].getAsEntry)?this._handleFileTreeEntries(t.map(n,function(t){var e;return t.webkitGetAsEntry?(e=t.webkitGetAsEntry(),e&&(e._file=t.getAsFile()),e):t.getAsEntry()})):t.Deferred().resolve(t.makeArray(e.files)).promise()},_getSingleFileInputFiles:function(e){e=t(e);var n,i,o=e.prop("webkitEntries")||e.prop("entries");if(o&&o.length)return this._handleFileTreeEntries(o);if(n=t.makeArray(e.prop("files")),n.length)void 0===n[0].name&&n[0].fileName&&t.each(n,function(t,e){e.name=e.fileName,e.size=e.fileSize});else{if(i=e.prop("value"),!i)return t.Deferred().resolve([]).promise();n=[{name:i.replace(/^.*\\/,"")}]}return t.Deferred().resolve(n).promise()},_getFileInputFiles:function(e){return e instanceof t&&1!==e.length?t.when.apply(t,t.map(e,this._getSingleFileInputFiles)).pipe(function(){return Array.prototype.concat.apply([],arguments)}):this._getSingleFileInputFiles(e)},_onChange:function(e){var n=this,i={fileInput:t(e.target),form:t(e.target.form)};this._getFileInputFiles(i.fileInput).always(function(t){i.files=t,n.options.replaceFileInput&&n._replaceFileInput(i.fileInput),n._trigger("change",e,i)!==!1&&n._onAdd(e,i)})},_onPaste:function(e){var n=e.originalEvent.clipboardData,i=n&&n.items||[],o={files:[]};return t.each(i,function(t,e){var n=e.getAsFile&&e.getAsFile();n&&o.files.push(n)}),this._trigger("paste",e,o)===!1||this._onAdd(e,o)===!1?!1:void 0},_onDrop:function(t){var e=this,n=t.dataTransfer=t.originalEvent.dataTransfer,i={};n&&n.files&&n.files.length&&t.preventDefault(),this._getDroppedFiles(n).always(function(n){i.files=n,e._trigger("drop",t,i)!==!1&&e._onAdd(t,i)})},_onDragOver:function(e){var n=e.dataTransfer=e.originalEvent.dataTransfer;return this._trigger("dragover",e)===!1?!1:void(n&&-1!==t.inArray("Files",n.types)&&(n.dropEffect="copy",e.preventDefault()))},_initEventHandlers:function(){this._isXHRUpload(this.options)&&(this._on(this.options.dropZone,{dragover:this._onDragOver,drop:this._onDrop}),this._on(this.options.pasteZone,{paste:this._onPaste})),this._on(this.options.fileInput,{change:this._onChange})},_destroyEventHandlers:function(){this._off(this.options.dropZone,"dragover drop"),this._off(this.options.pasteZone,"paste"),this._off(this.options.fileInput,"change")},_setOption:function(e,n){var i=-1!==t.inArray(e,this._refreshOptionsList);i&&this._destroyEventHandlers(),this._super(e,n),i&&(this._initSpecialOptions(),this._initEventHandlers())},_initSpecialOptions:function(){var e=this.options;void 0===e.fileInput?e.fileInput=this.element.is('input[type="file"]')?this.element:this.element.find('input[type="file"]'):e.fileInput instanceof t||(e.fileInput=t(e.fileInput)),e.dropZone instanceof t||(e.dropZone=t(e.dropZone)),e.pasteZone instanceof t||(e.pasteZone=t(e.pasteZone))},_create:function(){var e=this.options;t.extend(e,t(this.element[0].cloneNode(!1)).data()),this._initSpecialOptions(),this._slots=[],this._sequence=this._getXHRPromise(!0),this._sending=this._active=this._loaded=this._total=0,this._initEventHandlers()},_destroy:function(){this._destroyEventHandlers()},add:function(e){var n=this;e&&!this.options.disabled&&(e.fileInput&&!e.files?this._getFileInputFiles(e.fileInput).always(function(t){e.files=t,n._onAdd(null,e)}):(e.files=t.makeArray(e.files),this._onAdd(null,e)))},send:function(e){if(e&&!this.options.disabled){if(e.fileInput&&!e.files){var n,i,o=this,r=t.Deferred(),a=r.promise();return a.abort=function(){return i=!0,n?n.abort():(r.reject(null,"abort","abort"),a)},this._getFileInputFiles(e.fileInput).always(function(t){i||(e.files=t,n=o._onSend(null,e).then(function(t,e,n){r.resolve(t,e,n)},function(t,e,n){r.reject(t,e,n)}))}),this._enhancePromise(a)}if(e.files=t.makeArray(e.files),e.files.length)return this._onSend(null,e)}return this._getXHRPromise(!1,e&&e.context)}})}),function(t){"use strict";"function"==typeof define&&define.amd?define(["jquery"],t):t(window.jQuery)}(function(t){"use strict";var e=0;t.ajaxTransport("iframe",function(n){if(n.async){var i,o,r;return{send:function(a,s){i=t('<form style="display:none;"></form>'),i.attr("accept-charset",n.formAcceptCharset),r=/\?/.test(n.url)?"&":"?","DELETE"===n.type?(n.url=n.url+r+"_method=DELETE",n.type="POST"):"PUT"===n.type?(n.url=n.url+r+"_method=PUT",n.type="POST"):"PATCH"===n.type&&(n.url=n.url+r+"_method=PATCH",n.type="POST"),o=t('<iframe src="javascript:false;" name="iframe-transport-'+(e+=1)+'"></iframe>').bind("load",function(){var e,r=t.isArray(n.paramName)?n.paramName:[n.paramName];o.unbind("load").bind("load",function(){var e;try{if(e=o.contents(),!e.length||!e[0].firstChild)throw new Error}catch(n){e=void 0}s(200,"success",{iframe:e}),t('<iframe src="javascript:false;"></iframe>').appendTo(i),i.remove()}),i.prop("target",o.prop("name")).prop("action",n.url).prop("method",n.type),n.formData&&t.each(n.formData,function(e,n){t('<input type="hidden"/>').prop("name",n.name).val(n.value).appendTo(i)}),n.fileInput&&n.fileInput.length&&"POST"===n.type&&(e=n.fileInput.clone(),n.fileInput.after(function(t){return e[t]}),n.paramName&&n.fileInput.each(function(e){t(this).prop("name",r[e]||n.paramName)}),i.append(n.fileInput).prop("enctype","multipart/form-data").prop("encoding","multipart/form-data")),i.submit(),e&&e.length&&n.fileInput.each(function(n,i){var o=t(e[n]);t(i).prop("name",o.prop("name")),o.replaceWith(i)})}),i.append(o).appendTo(document.body)},abort:function(){o&&o.unbind("load").prop("src","javascript".concat(":false;")),i&&i.remove()}}}}),t.ajaxSetup({converters:{"iframe text":function(e){return e&&t(e[0].body).text()},"iframe json":function(e){return e&&t.parseJSON(t(e[0].body).text())},"iframe html":function(e){return e&&t(e[0].body).html()},"iframe script":function(e){return e&&t.globalEval(t(e[0].body).text())}}})}),function(t){"use strict";t.fn.serializeJSON=function(e){var n,i,o,r,a,s,u;return s=t.serializeJSON,u=s.setupOpts(e),i=this.serializeArray(),s.readCheckboxUncheckedValues(i,this,u),n={},t.each(i,function(t,e){o=s.splitInputNameIntoKeysArray(e.name,u),r=o.pop(),"skip"!==r&&(a=s.parseValue(e.value,r,u),u.parseWithFunction&&"_"===r&&(a=u.parseWithFunction(a,e.name)),s.deepSet(n,o,a,u))}),n},t.serializeJSON={defaultOptions:{checkboxUncheckedValue:void 0,parseNumbers:!1,parseBooleans:!1,parseNulls:!1,parseAll:!1,parseWithFunction:null,customTypes:{},defaultTypes:{string:function(t){return String(t)},number:function(t){return Number(t)},"boolean":function(t){var e=["false","null","undefined","","0"];return-1===e.indexOf(t)},"null":function(t){var e=["false","null","undefined","","0"];return-1===e.indexOf(t)?t:null},array:function(t){return JSON.parse(t)},object:function(t){return JSON.parse(t)},auto:function(e){return t.serializeJSON.parseValue(e,null,{parseNumbers:!0,parseBooleans:!0,parseNulls:!0})}},useIntKeysAsArrayIndex:!1},setupOpts:function(e){var n,i,o,r,a,s;s=t.serializeJSON,null==e&&(e={}),o=s.defaultOptions||{},i=["checkboxUncheckedValue","parseNumbers","parseBooleans","parseNulls","parseAll","parseWithFunction","customTypes","defaultTypes","useIntKeysAsArrayIndex"];for(n in e)if(-1===i.indexOf(n))throw new Error("serializeJSON ERROR: invalid option '"+n+"'. Please use one of "+i.join(", "));return r=function(t){return e[t]!==!1&&""!==e[t]&&(e[t]||o[t])},a=r("parseAll"),{checkboxUncheckedValue:r("checkboxUncheckedValue"),parseNumbers:a||r("parseNumbers"),parseBooleans:a||r("parseBooleans"),parseNulls:a||r("parseNulls"),parseWithFunction:r("parseWithFunction"),typeFunctions:t.extend({},r("defaultTypes"),r("customTypes")),useIntKeysAsArrayIndex:r("useIntKeysAsArrayIndex")}},parseValue:function(e,n,i){var o,r;return r=t.serializeJSON,o=i.typeFunctions&&i.typeFunctions[n],o?o(e):i.parseNumbers&&r.isNumeric(e)?Number(e):!i.parseBooleans||"true"!==e&&"false"!==e?i.parseNulls&&"null"==e?null:e:"true"===e},isObject:function(t){return t===Object(t)},isUndefined:function(t){return void 0===t},isValidArrayIndex:function(t){return/^[0-9]+$/.test(String(t))},isNumeric:function(t){return t-parseFloat(t)>=0},optionKeys:function(t){if(Object.keys)return Object.keys(t);var e,n=[];for(e in t)n.push(e);return n},splitInputNameIntoKeysArray:function(e,n){var i,o,r,a,s;return s=t.serializeJSON,a=s.extractTypeFromInputName(e,n),o=a[0],r=a[1],i=o.split("["),i=t.map(i,function(t){return t.replace(/\]/g,"")}),""===i[0]&&i.shift(),i.push(r),i},extractTypeFromInputName:function(e,n){var i,o,r;if(i=e.match(/(.*):([^:]+)$/)){if(r=t.serializeJSON,o=r.optionKeys(n?n.typeFunctions:r.defaultOptions.defaultTypes),o.push("skip"),-1!==o.indexOf(i[2]))return[i[1],i[2]];throw new Error("serializeJSON ERROR: Invalid type "+i[2]+" found in input name '"+e+"', please use one of "+o.join(", "))}return[e,"_"]},deepSet:function(e,n,i,o){var r,a,s,u,l,c;if(null==o&&(o={}),c=t.serializeJSON,c.isUndefined(e))throw new Error("ArgumentError: param 'o' expected to be an object or array, found undefined");if(!n||0===n.length)throw new Error("ArgumentError: param 'keys' expected to be an array with least one element");r=n[0],1===n.length?""===r?e.push(i):e[r]=i:(a=n[1],""===r&&(u=e.length-1,l=e[u],r=c.isObject(l)&&(c.isUndefined(l[a])||n.length>2)?u:u+1),""===a?(c.isUndefined(e[r])||!t.isArray(e[r]))&&(e[r]=[]):o.useIntKeysAsArrayIndex&&c.isValidArrayIndex(a)?(c.isUndefined(e[r])||!t.isArray(e[r]))&&(e[r]=[]):(c.isUndefined(e[r])||!c.isObject(e[r]))&&(e[r]={}),s=n.slice(1),c.deepSet(e[r],s,i,o))},readCheckboxUncheckedValues:function(e,n,i){var o,r,a,s,u;null==i&&(i={}),u=t.serializeJSON,o="input[type=checkbox][name]:not(:checked):not([disabled])",r=n.find(o).add(n.filter(o)),r.each(function(n,o){a=t(o),s=a.attr("data-unchecked-value"),s?e.push({name:o.name,value:s}):u.isUndefined(i.checkboxUncheckedValue)||e.push({name:o.name,value:i.checkboxUncheckedValue})})}}}(window.jQuery||window.Zepto||window.$),function(t,e,n){"use strict";var i=function(t,e,n){this.data=t.serializeArray(),this.file=e,this.$uploader=n,this.setContentTypeHeader(),this.renameFileWithTimestamp()};i.prototype.setContentTypeHeader=function(){this.data.push({name:"content-type",value:this.file.type||""})},i.prototype.renameFileWithTimestamp=function(){var t;t=e.grep(this.data,function(t){return"key"===t.name?t:void 0})[0],t.value=t.value.replace("{timestamp}",(new Date).getTime())};var o=function(t,e){this._response=t,this._file=e,this.extractResponse()};o.prototype.extractResponse=function(){this.url=e(this._response).find("Location").text(),this.filepath=e("<a />").attr("href",this.url)[0].pathname,this.filename=this._file.name,this.filesize=this._file.size,this.lastModifiedDate=this._file.lastModifiedDate,this.filetype=this._file.type};var r=function(t){var e=new a(t);this.file=t,this.file.isImage=e.hasFiletypeOfImage(),this.file.width=null,this.file.height=null,this.file.src=null};r.prototype.load=function(e){var n,i,o;o=this.file,t.FileReader&&o.isImage?(n=new FileReader,i=new Image,n.readAsDataURL(o),n.onload=function(t){i.src=t.target.result,i.onload=function(){o.width=i.width,o.height=i.height,o.src=i.src,e(o)}}):e(o)};var a=function(t){this.file=t};a.prototype.hasWidthGreaterThan=function(t){return _.isNumber(this.file.width)&&this.file.width>=t?!0:!1},a.prototype.hasHeightGreaterThan=function(t){return _.isNumber(this.file.height)&&this.file.height>=t?!0:!1},a.prototype.hasDimensionsGreaterThan=function(t){return _.isNumber(this.file.height)&&_.isNumber(this.file.width)&&this.file.width*this.file.height>=t?!0:!1},a.prototype.hasFiletypeOfJPEG=function(){return/(\/jpe?g)/i.test(this.file.type)?!0:!1},a.prototype.hasFiletypeOfImage=function(){return/(image\/)/i.test(this.file.type)?!0:!1},a.prototype.hasFilesizeLessThan=function(t){return _.isNumber(this.file.size)&&this.file.size<=t?!0:!1},t.GeneralUploader={Form:i,File:r,S3Response:o,Validator:a}}(window,jQuery),function(t,e,n){var i=e.fn.generalUploader,o=function(){};e.fn.generalUploader=function(n){var i,r;return r={onAddingFile:o,beforeValidation:o,afterValidation:o,validateFile:function(t){return!0},afterUploading:o,onError:o,onProgress:o,setSrcAsBackgroundImage:!1,pseudoFileField:".js-general-uploader-pseudo-file-field",fileField:".js-general-uploader-s3-file-field",progressTarget:".js-general-uploader-progress-target",newUploadTarget:".js-general-uploader-new-upload-target",formTemplate:".js-general-uploader-form-template",form:".js-general-uploader-form",submitButton:".js-general-uploader-form-submit"},i=e.extend({},r,n),this.fileupload({$uploader:this,autoUpload:!0,add:function(t,e){var n;i.onAddingFile(),n=new GeneralUploader.File(e.files[0]),n.load(function(t){e.files[0]=t,e.submit()})},formData:function(t){return new GeneralUploader.Form(t,this.files[0]).data},submit:function(t,n){var o;return i.beforeValidation(),o=n.files[0],i.validateFile(o)?(e(i.progressTarget).width("0%"),o.isImage&&o.src&&(i.setSrcAsBackgroundImage?e(i.newUploadTarget).css("background-image","url("+n.files[0].src+")"):e(i.newUploadTarget).attr("src",n.files[0].src)),e(i.submitButton).addClass("disabled"),i.afterValidation(o),!0):!1},fail:function(n,o){t.Flash.emitErrorEvent({message:"There was an error uploading the file to the server. Try again."}),e(i.submitButton).removeClass("disabled"),i.onError(n,o)},done:function(t,n){var o,r,a,s;o=new GeneralUploader.S3Response(n.result,n.files[0]),a=e(i.formTemplate),a.length&&(s=a.html(),r=_.template(s)({file:o}),e(i.form).html(r)),e(i.submitButton).removeClass("disabled"),i.afterUploading(o)},progress:function(t,n){var o;n&&n.total&&(o=parseInt(n.loaded/n.total*100,10),e(i.progressTarget).width(o+"%"),i.onProgress(o))}}),e(i.pseudoFileField).on("click",function(t){t.preventDefault(),e(i.fileField).trigger("click")}),this},e.fn.generalUploader.noConflict=function(){return e.fn.generalUploader=i,this}}(window,jQuery),function(t,e,n){var i;e(function(){i=e(".js-edit-profile-image-s3-form"),i.length&&i.generalUploader({validateFile:function(e){var n=new GeneralUploader.Validator(e);return n.hasFiletypeOfImage()?n.hasFilesizeLessThan(1e6)?!0:(t.Flash.emitErrorEvent({message:"Profile image must be less than 1MB. Try reducing the size of image."}),!1):(t.Flash.emitErrorEvent({message:"Profile image must be of type image. Try converting the image to JPEG."}),!1)},afterValidation:function(){var t=e(".js-edit-profile-image-trigger-text"),n=t.text();t.data("text",n).text("Uploading...")},afterUploading:function(t){e(".js-edit-profile-image-form").trigger("submit")}})})}(window,jQuery),function(t,e,n){var i,o;e(function(){o=e(".js-edit-announcement-image-s3-form"),o.length&&o.generalUploader({validateFile:function(e){var n=new GeneralUploader.Validator(e);return n.hasFiletypeOfImage()?n.hasFilesizeLessThan(1e6)?!0:(t.Flash.emitErrorEvent({message:"Announcement image must be less than 1MB. Try reducing the size of image."}),!1):(t.Flash.emitErrorEvent({message:"Announcement image must be of type image. Try converting the image to JPEG."}),!1)},afterValidation:function(){var t=e(".js-edit-announcement-image-trigger-text");i=t.text(),t.data("text",i).text("Uploading...")},afterUploading:function(t){var n=e(".js-edit-announcement-image-trigger-text");n.text(i)}})})}(window,jQuery),function(t,e,n){var i,o;e(function(){o=e(".js-edit-teammate-image-s3-form"),o.length&&o.generalUploader({setSrcAsBackgroundImage:!0,validateFile:function(e){var n=new GeneralUploader.Validator(e);return n.hasFiletypeOfImage()?n.hasFilesizeLessThan(1e8)?!0:(t.Flash.emitErrorEvent({message:"Teammate baby picture must be less than 100MB. Try reducing the size of image."}),!1):(t.Flash.emitErrorEvent({message:"Teammate baby picture must be of type image. Try converting the image to JPEG."}),!1)},afterValidation:function(){var t=e(".js-add-teammate-trigger-text");i=t.text(),t.data("text",i).text("Uploading...")},afterUploading:function(t){var n=e(".js-add-teammate-trigger-text");n.text("Replace baby picture")}})})}(window,jQuery),function(t,e,n){var i,o;e(function(){o=e(".js-edit-moment-image-s3-form"),o.length&&o.generalUploader({setSrcAsBackgroundImage:!0,validateFile:function(e){var n=new GeneralUploader.Validator(e);return n.hasFiletypeOfImage()?n.hasFilesizeLessThan(1e8)?!0:(t.Flash.emitErrorEvent({message:"Moment image must be less than 100MB. Try reducing the size of image."}),!1):(t.Flash.emitErrorEvent({message:"Moment image must be of type image. Try converting the image to JPEG."}),!1)},afterValidation:function(){var t=e(".js-add-moment-trigger-text");i=t.text(),t.data("text",i).text("Uploading...")},afterUploading:function(t){var n=e(".js-add-moment-trigger-text");n.text("Replace image")}})})}(window,jQuery),function(t,e,n){var i;e(function(){i=e(".js-add-screenshot-s3-form"),i.length&&i.generalUploader({setSrcAsBackgroundImage:!0,validateFile:function(e){var n=new GeneralUploader.Validator(e);return n.hasFiletypeOfImage()?n.hasFilesizeLessThan(1e7)?!0:(t.Flash.emitErrorEvent({message:"Screenshot must be less than 5MB. Try reducing the size of image."}),!1):(t.Flash.emitErrorEvent({message:"Screenshot must be of type image. Try converting the image to JPEG."}),!1)},afterValidation:function(){var t=e(".js-add-screenshot-trigger-text");t.remove()},afterUploading:function(t){e(".js-general-uploader-form-submit").trigger("click")}})})}(window,jQuery),function(t,e,n){var i=c={},o={},r={};i.init=function(){this.$uploader=e(".js-admin-upload-s3-form"),this.$trigger=e(".js-admin-upload-trigger-text"),this.$exampleInput=e(".js-admin-uploader-example-input")},o.init=function(){this.triggerText=c.$trigger.text()},r.init=function(){c.$uploader.generalUploader({onProgress:r.updateProgressText,afterUploading:function(t){r.resetUploadText(),r.showFileURL(t.filepath)}})},r.shouldInit=function(){return!!c.$uploader.length},r.updateProgressText=function(t){c.$trigger.text(t+"%...")},r.showFileURL=function(e){var n=function(e){var n=e.replace("/images.unsplash.com/","");return t.publicKeys.CDN.download+n};c.$exampleInput.clone().val(n(e)).insertBefore(c.$exampleInput)},r.resetUploadText=function(){c.$trigger.text(o.triggerText)},e(function(){i.init(),o.init(),r.shouldInit()&&r.init()})}(window,jQuery);