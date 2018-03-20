!function(e){"use strict";"function"==typeof define&&define.amd?define(["jquery","jquery.ui.widget"],e):e(window.jQuery)}(function(e){"use strict";e.support.xhrFileUpload=!(!window.XMLHttpRequestUpload||!window.FileReader),e.support.xhrFormDataFileUpload=!!window.FormData,e.propHooks.elements={get:function(t){return e.nodeName(t,"form")?e.grep(t.elements,function(t){return!e.nodeName(t,"input")||"file"!==t.type}):null}},e.widget("blueimp.fileupload",{options:{dropZone:e(document),pasteZone:e(document),fileInput:void 0,replaceFileInput:!0,paramName:void 0,singleFileUploads:!0,limitMultiFileUploads:void 0,sequentialUploads:!1,limitConcurrentUploads:void 0,forceIframeTransport:!1,redirect:void 0,redirectParamName:void 0,postMessage:void 0,multipart:!0,maxChunkSize:void 0,uploadedBytes:void 0,recalculateProgress:!0,progressInterval:100,bitrateInterval:500,formData:function(e){return e.serializeArray()},add:function(e,t){t.submit()},processData:!1,contentType:!1,cache:!1},_refreshOptionsList:["fileInput","dropZone","pasteZone","multipart","forceIframeTransport"],_BitrateTimer:function(){this.timestamp=+new Date,this.loaded=0,this.bitrate=0,this.getBitrate=function(e,t,i){var n=e-this.timestamp;return(!this.bitrate||!i||n>i)&&(this.bitrate=(t-this.loaded)*(1e3/n)*8,this.loaded=t,this.timestamp=e),this.bitrate}},_isXHRUpload:function(t){return!t.forceIframeTransport&&(!t.multipart&&e.support.xhrFileUpload||e.support.xhrFormDataFileUpload)},_getFormData:function(t){var i;return"function"==typeof t.formData?t.formData(t.form):e.isArray(t.formData)?t.formData:t.formData?(i=[],e.each(t.formData,function(e,t){i.push({name:e,value:t})}),i):[]},_getTotal:function(t){var i=0;return e.each(t,function(e,t){i+=t.size||1}),i},_onProgress:function(e,t){if(e.lengthComputable){var i,n,r=+new Date;if(t._time&&t.progressInterval&&r-t._time<t.progressInterval&&e.loaded!==e.total)return;t._time=r,i=t.total||this._getTotal(t.files),n=parseInt(e.loaded/e.total*(t.chunkSize||i),10)+(t.uploadedBytes||0),this._loaded+=n-(t.loaded||t.uploadedBytes||0),t.lengthComputable=!0,t.loaded=n,t.total=i,t.bitrate=t._bitrateTimer.getBitrate(r,n,t.bitrateInterval),this._trigger("progress",e,t),this._trigger("progressall",e,{lengthComputable:!0,loaded:this._loaded,total:this._total,bitrate:this._bitrateTimer.getBitrate(r,this._loaded,t.bitrateInterval)})}},_initProgressListener:function(t){var i=this,n=t.xhr?t.xhr():e.ajaxSettings.xhr();n.upload&&(e(n.upload).bind("progress",function(e){var n=e.originalEvent;e.lengthComputable=n.lengthComputable,e.loaded=n.loaded,e.total=n.total,i._onProgress(e,t)}),t.xhr=function(){return n})},_initXHRData:function(t){var i,n=t.files[0],r=t.multipart||!e.support.xhrFileUpload,a=t.paramName[0];t.headers=t.headers||{},t.contentRange&&(t.headers["Content-Range"]=t.contentRange),r?e.support.xhrFormDataFileUpload&&(t.postMessage?(i=this._getFormData(t),t.blob?i.push({name:a,value:t.blob}):e.each(t.files,function(e,n){i.push({name:t.paramName[e]||a,value:n})})):(t.formData instanceof FormData?i=t.formData:(i=new FormData,e.each(this._getFormData(t),function(e,t){i.append(t.name,t.value)})),t.blob?(t.headers["Content-Disposition"]='attachment; filename="'+encodeURI(n.name)+'"',i.append(a,t.blob,n.name)):e.each(t.files,function(e,n){(window.Blob&&n instanceof Blob||window.File&&n instanceof File)&&i.append(t.paramName[e]||a,n,n.name)})),t.data=i):(t.headers["Content-Disposition"]='attachment; filename="'+encodeURI(n.name)+'"',t.contentType=n.type,t.data=t.blob||n),t.blob=null},_initIframeSettings:function(t){t.dataType="iframe "+(t.dataType||""),t.formData=this._getFormData(t),t.redirect&&e("<a></a>").prop("href",t.url).prop("host")!==location.host&&t.formData.push({name:t.redirectParamName||"redirect",value:t.redirect})},_initDataSettings:function(e){this._isXHRUpload(e)?(this._chunkedUpload(e,!0)||(e.data||this._initXHRData(e),this._initProgressListener(e)),e.postMessage&&(e.dataType="postmessage "+(e.dataType||""))):this._initIframeSettings(e,"iframe")},_getParamName:function(t){var i=e(t.fileInput),n=t.paramName;return n?e.isArray(n)||(n=[n]):(n=[],i.each(function(){for(var t=e(this),i=t.prop("name")||"files[]",r=(t.prop("files")||[1]).length;r;)n.push(i),r-=1}),n.length||(n=[i.prop("name")||"files[]"])),n},_initFormSettings:function(t){t.form&&t.form.length||(t.form=e(t.fileInput.prop("form")),t.form.length||(t.form=e(this.options.fileInput.prop("form")))),t.paramName=this._getParamName(t),t.url||(t.url=t.form.prop("action")||location.href),t.type=(t.type||t.form.prop("method")||"").toUpperCase(),"POST"!==t.type&&"PUT"!==t.type&&"PATCH"!==t.type&&(t.type="POST"),t.formAcceptCharset||(t.formAcceptCharset=t.form.attr("accept-charset"))},_getAJAXSettings:function(t){var i=e.extend({},this.options,t);return this._initFormSettings(i),this._initDataSettings(i),i},_enhancePromise:function(e){return e.success=e.done,e.error=e.fail,e.complete=e.always,e},_getXHRPromise:function(t,i,n){var r=e.Deferred(),a=r.promise();return i=i||this.options.context||a,t===!0?r.resolveWith(i,n):t===!1&&r.rejectWith(i,n),a.abort=r.promise,this._enhancePromise(a)},_getUploadedBytes:function(e){var t=e.getResponseHeader("Range"),i=t&&t.split("-"),n=i&&i.length>1&&parseInt(i[1],10);return n&&n+1},_chunkedUpload:function(t,i){var n,r,a=this,o=t.files[0],s=o.size,l=t.uploadedBytes=t.uploadedBytes||0,u=t.maxChunkSize||s,p=o.slice||o.webkitSlice||o.mozSlice,d=e.Deferred(),f=d.promise();return this._isXHRUpload(t)&&p&&(l||s>u)&&!t.data?i?!0:l>=s?(o.error="Uploaded bytes exceed file size",this._getXHRPromise(!1,t.context,[null,"error",o.error])):(r=function(i){var f=e.extend({},t);f.blob=p.call(o,l,l+u,o.type),f.chunkSize=f.blob.size,f.contentRange="bytes "+l+"-"+(l+f.chunkSize-1)+"/"+s,a._initXHRData(f),a._initProgressListener(f),n=(a._trigger("chunksend",null,f)!==!1&&e.ajax(f)||a._getXHRPromise(!1,f.context)).done(function(i,n,o){l=a._getUploadedBytes(o)||l+f.chunkSize,(!f.loaded||f.loaded<f.total)&&a._onProgress(e.Event("progress",{lengthComputable:!0,loaded:l-f.uploadedBytes,total:l-f.uploadedBytes}),f),t.uploadedBytes=f.uploadedBytes=l,f.result=i,f.textStatus=n,f.jqXHR=o,a._trigger("chunkdone",null,f),a._trigger("chunkalways",null,f),s>l?r():d.resolveWith(f.context,[i,n,o])}).fail(function(e,t,i){f.jqXHR=e,f.textStatus=t,f.errorThrown=i,a._trigger("chunkfail",null,f),a._trigger("chunkalways",null,f),d.rejectWith(f.context,[e,t,i])})},this._enhancePromise(f),f.abort=function(){return n.abort()},r(),f):!1},_beforeSend:function(e,t){0===this._active&&(this._trigger("start"),this._bitrateTimer=new this._BitrateTimer),this._active+=1,this._loaded+=t.uploadedBytes||0,this._total+=this._getTotal(t.files)},_onDone:function(t,i,n,r){if(!this._isXHRUpload(r)||!r.loaded||r.loaded<r.total){var a=this._getTotal(r.files)||1;this._onProgress(e.Event("progress",{lengthComputable:!0,loaded:a,total:a}),r)}r.result=t,r.textStatus=i,r.jqXHR=n,this._trigger("done",null,r)},_onFail:function(e,t,i,n){n.jqXHR=e,n.textStatus=t,n.errorThrown=i,this._trigger("fail",null,n),n.recalculateProgress&&(this._loaded-=n.loaded||n.uploadedBytes||0,this._total-=n.total||this._getTotal(n.files))},_onAlways:function(e,t,i,n){this._active-=1,this._trigger("always",null,n),0===this._active&&(this._trigger("stop"),this._loaded=this._total=0,this._bitrateTimer=null)},_onSend:function(t,i){var n,r,a,o,s=this,l=s._getAJAXSettings(i),u=function(){return s._sending+=1,l._bitrateTimer=new s._BitrateTimer,n=n||((r||s._trigger("send",t,l)===!1)&&s._getXHRPromise(!1,l.context,r)||s._chunkedUpload(l)||e.ajax(l)).done(function(e,t,i){s._onDone(e,t,i,l)}).fail(function(e,t,i){s._onFail(e,t,i,l)}).always(function(e,t,i){if(s._sending-=1,s._onAlways(e,t,i,l),l.limitConcurrentUploads&&l.limitConcurrentUploads>s._sending)for(var n,r=s._slots.shift();r;){if(n=r.state?"pending"===r.state():!r.isRejected()){r.resolve();break}r=s._slots.shift()}})};return this._beforeSend(t,l),this.options.sequentialUploads||this.options.limitConcurrentUploads&&this.options.limitConcurrentUploads<=this._sending?(this.options.limitConcurrentUploads>1?(a=e.Deferred(),this._slots.push(a),o=a.pipe(u)):o=this._sequence=this._sequence.pipe(u,u),o.abort=function(){return r=[void 0,"abort","abort"],n?n.abort():(a&&a.rejectWith(l.context,r),u())},this._enhancePromise(o)):u()},_onAdd:function(t,i){var n,r,a,o,s=this,l=!0,u=e.extend({},this.options,i),p=u.limitMultiFileUploads,d=this._getParamName(u);if((u.singleFileUploads||p)&&this._isXHRUpload(u))if(!u.singleFileUploads&&p)for(a=[],n=[],o=0;o<i.files.length;o+=p)a.push(i.files.slice(o,o+p)),r=d.slice(o,o+p),r.length||(r=d),n.push(r);else n=d;else a=[i.files],n=[d];return i.originalFiles=i.files,e.each(a||i.files,function(r,o){var u=e.extend({},i);return u.files=a?o:[o],u.paramName=n[r],u.submit=function(){return u.jqXHR=this.jqXHR=s._trigger("submit",t,this)!==!1&&s._onSend(t,this),this.jqXHR},l=s._trigger("add",t,u)}),l},_replaceFileInput:function(t){var i=t.clone(!0);e("<form></form>").append(i)[0].reset(),t.after(i).detach(),e.cleanData(t.unbind("remove")),this.options.fileInput=this.options.fileInput.map(function(e,n){return n===t[0]?i[0]:n}),t[0]===this.element[0]&&(this.element=i)},_handleFileTreeEntry:function(t,i){var n,r=this,a=e.Deferred(),o=function(e){e&&!e.entry&&(e.entry=t),a.resolve([e])};return i=i||"",t.isFile?t._file?(t._file.relativePath=i,a.resolve(t._file)):t.file(function(e){e.relativePath=i,a.resolve(e)},o):t.isDirectory?(n=t.createReader(),n.readEntries(function(e){r._handleFileTreeEntries(e,i+t.name+"/").done(function(e){a.resolve(e)}).fail(o)},o)):a.resolve([]),a.promise()},_handleFileTreeEntries:function(t,i){var n=this;return e.when.apply(e,e.map(t,function(e){return n._handleFileTreeEntry(e,i)})).pipe(function(){return Array.prototype.concat.apply([],arguments)})},_getDroppedFiles:function(t){t=t||{};var i=t.items;return i&&i.length&&(i[0].webkitGetAsEntry||i[0].getAsEntry)?this._handleFileTreeEntries(e.map(i,function(e){var t;return e.webkitGetAsEntry?(t=e.webkitGetAsEntry(),t&&(t._file=e.getAsFile()),t):e.getAsEntry()})):e.Deferred().resolve(e.makeArray(t.files)).promise()},_getSingleFileInputFiles:function(t){t=e(t);var i,n,r=t.prop("webkitEntries")||t.prop("entries");if(r&&r.length)return this._handleFileTreeEntries(r);if(i=e.makeArray(t.prop("files")),i.length)void 0===i[0].name&&i[0].fileName&&e.each(i,function(e,t){t.name=t.fileName,t.size=t.fileSize});else{if(n=t.prop("value"),!n)return e.Deferred().resolve([]).promise();i=[{name:n.replace(/^.*\\/,"")}]}return e.Deferred().resolve(i).promise()},_getFileInputFiles:function(t){return t instanceof e&&1!==t.length?e.when.apply(e,e.map(t,this._getSingleFileInputFiles)).pipe(function(){return Array.prototype.concat.apply([],arguments)}):this._getSingleFileInputFiles(t)},_onChange:function(t){var i=this,n={fileInput:e(t.target),form:e(t.target.form)};this._getFileInputFiles(n.fileInput).always(function(e){n.files=e,i.options.replaceFileInput&&i._replaceFileInput(n.fileInput),i._trigger("change",t,n)!==!1&&i._onAdd(t,n)})},_onPaste:function(t){var i=t.originalEvent.clipboardData,n=i&&i.items||[],r={files:[]};return e.each(n,function(e,t){var i=t.getAsFile&&t.getAsFile();i&&r.files.push(i)}),this._trigger("paste",t,r)===!1||this._onAdd(t,r)===!1?!1:void 0},_onDrop:function(e){var t=this,i=e.dataTransfer=e.originalEvent.dataTransfer,n={};i&&i.files&&i.files.length&&e.preventDefault(),this._getDroppedFiles(i).always(function(i){n.files=i,t._trigger("drop",e,n)!==!1&&t._onAdd(e,n)})},_onDragOver:function(t){var i=t.dataTransfer=t.originalEvent.dataTransfer;return this._trigger("dragover",t)===!1?!1:void(i&&-1!==e.inArray("Files",i.types)&&(i.dropEffect="copy",t.preventDefault()))},_initEventHandlers:function(){this._isXHRUpload(this.options)&&(this._on(this.options.dropZone,{dragover:this._onDragOver,drop:this._onDrop}),this._on(this.options.pasteZone,{paste:this._onPaste})),this._on(this.options.fileInput,{change:this._onChange})},_destroyEventHandlers:function(){this._off(this.options.dropZone,"dragover drop"),this._off(this.options.pasteZone,"paste"),this._off(this.options.fileInput,"change")},_setOption:function(t,i){var n=-1!==e.inArray(t,this._refreshOptionsList);n&&this._destroyEventHandlers(),this._super(t,i),n&&(this._initSpecialOptions(),this._initEventHandlers())},_initSpecialOptions:function(){var t=this.options;void 0===t.fileInput?t.fileInput=this.element.is('input[type="file"]')?this.element:this.element.find('input[type="file"]'):t.fileInput instanceof e||(t.fileInput=e(t.fileInput)),t.dropZone instanceof e||(t.dropZone=e(t.dropZone)),t.pasteZone instanceof e||(t.pasteZone=e(t.pasteZone))},_create:function(){var t=this.options;e.extend(t,e(this.element[0].cloneNode(!1)).data()),this._initSpecialOptions(),this._slots=[],this._sequence=this._getXHRPromise(!0),this._sending=this._active=this._loaded=this._total=0,this._initEventHandlers()},_destroy:function(){this._destroyEventHandlers()},add:function(t){var i=this;t&&!this.options.disabled&&(t.fileInput&&!t.files?this._getFileInputFiles(t.fileInput).always(function(e){t.files=e,i._onAdd(null,t)}):(t.files=e.makeArray(t.files),this._onAdd(null,t)))},send:function(t){if(t&&!this.options.disabled){if(t.fileInput&&!t.files){var i,n,r=this,a=e.Deferred(),o=a.promise();return o.abort=function(){return n=!0,i?i.abort():(a.reject(null,"abort","abort"),o)},this._getFileInputFiles(t.fileInput).always(function(e){n||(t.files=e,i=r._onSend(null,t).then(function(e,t,i){a.resolve(e,t,i)},function(e,t,i){a.reject(e,t,i)}))}),this._enhancePromise(o)}if(t.files=e.makeArray(t.files),t.files.length)return this._onSend(null,t)}return this._getXHRPromise(!1,t&&t.context)}})}),function(e){"use strict";"function"==typeof define&&define.amd?define(["jquery"],e):e(window.jQuery)}(function(e){"use strict";var t=0;e.ajaxTransport("iframe",function(i){if(i.async){var n,r,a;return{send:function(o,s){n=e('<form style="display:none;"></form>'),n.attr("accept-charset",i.formAcceptCharset),a=/\?/.test(i.url)?"&":"?","DELETE"===i.type?(i.url=i.url+a+"_method=DELETE",i.type="POST"):"PUT"===i.type?(i.url=i.url+a+"_method=PUT",i.type="POST"):"PATCH"===i.type&&(i.url=i.url+a+"_method=PATCH",i.type="POST"),r=e('<iframe src="javascript:false;" name="iframe-transport-'+(t+=1)+'"></iframe>').bind("load",function(){var t,a=e.isArray(i.paramName)?i.paramName:[i.paramName];r.unbind("load").bind("load",function(){var t;try{if(t=r.contents(),!t.length||!t[0].firstChild)throw new Error}catch(i){t=void 0}s(200,"success",{iframe:t}),e('<iframe src="javascript:false;"></iframe>').appendTo(n),n.remove()}),n.prop("target",r.prop("name")).prop("action",i.url).prop("method",i.type),i.formData&&e.each(i.formData,function(t,i){e('<input type="hidden"/>').prop("name",i.name).val(i.value).appendTo(n)}),i.fileInput&&i.fileInput.length&&"POST"===i.type&&(t=i.fileInput.clone(),i.fileInput.after(function(e){return t[e]}),i.paramName&&i.fileInput.each(function(t){e(this).prop("name",a[t]||i.paramName)}),n.append(i.fileInput).prop("enctype","multipart/form-data").prop("encoding","multipart/form-data")),n.submit(),t&&t.length&&i.fileInput.each(function(i,n){var r=e(t[i]);e(n).prop("name",r.prop("name")),r.replaceWith(n)})}),n.append(r).appendTo(document.body)},abort:function(){r&&r.unbind("load").prop("src","javascript".concat(":false;")),n&&n.remove()}}}}),e.ajaxSetup({converters:{"iframe text":function(t){return t&&e(t[0].body).text()},"iframe json":function(t){return t&&e.parseJSON(e(t[0].body).text())},"iframe html":function(t){return t&&e(t[0].body).html()},"iframe script":function(t){return t&&e.globalEval(e(t[0].body).text())}}})}),function(e){"use strict";e.fn.serializeJSON=function(t){var i,n,r,a,o,s,l;return s=e.serializeJSON,l=s.setupOpts(t),n=this.serializeArray(),s.readCheckboxUncheckedValues(n,this,l),i={},e.each(n,function(e,t){r=s.splitInputNameIntoKeysArray(t.name,l),a=r.pop(),"skip"!==a&&(o=s.parseValue(t.value,a,l),l.parseWithFunction&&"_"===a&&(o=l.parseWithFunction(o,t.name)),s.deepSet(i,r,o,l))}),i},e.serializeJSON={defaultOptions:{checkboxUncheckedValue:void 0,parseNumbers:!1,parseBooleans:!1,parseNulls:!1,parseAll:!1,parseWithFunction:null,customTypes:{},defaultTypes:{string:function(e){return String(e)},number:function(e){return Number(e)},"boolean":function(e){var t=["false","null","undefined","","0"];return-1===t.indexOf(e)},"null":function(e){var t=["false","null","undefined","","0"];return-1===t.indexOf(e)?e:null},array:function(e){return JSON.parse(e)},object:function(e){return JSON.parse(e)},auto:function(t){return e.serializeJSON.parseValue(t,null,{parseNumbers:!0,parseBooleans:!0,parseNulls:!0})}},useIntKeysAsArrayIndex:!1},setupOpts:function(t){var i,n,r,a,o,s;s=e.serializeJSON,null==t&&(t={}),r=s.defaultOptions||{},n=["checkboxUncheckedValue","parseNumbers","parseBooleans","parseNulls","parseAll","parseWithFunction","customTypes","defaultTypes","useIntKeysAsArrayIndex"];for(i in t)if(-1===n.indexOf(i))throw new Error("serializeJSON ERROR: invalid option '"+i+"'. Please use one of "+n.join(", "));return a=function(e){return t[e]!==!1&&""!==t[e]&&(t[e]||r[e])},o=a("parseAll"),{checkboxUncheckedValue:a("checkboxUncheckedValue"),parseNumbers:o||a("parseNumbers"),parseBooleans:o||a("parseBooleans"),parseNulls:o||a("parseNulls"),parseWithFunction:a("parseWithFunction"),typeFunctions:e.extend({},a("defaultTypes"),a("customTypes")),useIntKeysAsArrayIndex:a("useIntKeysAsArrayIndex")}},parseValue:function(t,i,n){var r,a;return a=e.serializeJSON,r=n.typeFunctions&&n.typeFunctions[i],r?r(t):n.parseNumbers&&a.isNumeric(t)?Number(t):!n.parseBooleans||"true"!==t&&"false"!==t?n.parseNulls&&"null"==t?null:t:"true"===t},isObject:function(e){return e===Object(e)},isUndefined:function(e){return void 0===e},isValidArrayIndex:function(e){return/^[0-9]+$/.test(String(e))},isNumeric:function(e){return e-parseFloat(e)>=0},optionKeys:function(e){if(Object.keys)return Object.keys(e);var t,i=[];for(t in e)i.push(t);return i},splitInputNameIntoKeysArray:function(t,i){var n,r,a,o,s;return s=e.serializeJSON,o=s.extractTypeFromInputName(t,i),r=o[0],a=o[1],n=r.split("["),n=e.map(n,function(e){return e.replace(/\]/g,"")}),""===n[0]&&n.shift(),n.push(a),n},extractTypeFromInputName:function(t,i){var n,r,a;if(n=t.match(/(.*):([^:]+)$/)){if(a=e.serializeJSON,r=a.optionKeys(i?i.typeFunctions:a.defaultOptions.defaultTypes),r.push("skip"),-1!==r.indexOf(n[2]))return[n[1],n[2]];throw new Error("serializeJSON ERROR: Invalid type "+n[2]+" found in input name '"+t+"', please use one of "+r.join(", "))}return[t,"_"]},deepSet:function(t,i,n,r){var a,o,s,l,u,p;if(null==r&&(r={}),p=e.serializeJSON,p.isUndefined(t))throw new Error("ArgumentError: param 'o' expected to be an object or array, found undefined");if(!i||0===i.length)throw new Error("ArgumentError: param 'keys' expected to be an array with least one element");a=i[0],1===i.length?""===a?t.push(n):t[a]=n:(o=i[1],""===a&&(l=t.length-1,u=t[l],a=p.isObject(u)&&(p.isUndefined(u[o])||i.length>2)?l:l+1),""===o?(p.isUndefined(t[a])||!e.isArray(t[a]))&&(t[a]=[]):r.useIntKeysAsArrayIndex&&p.isValidArrayIndex(o)?(p.isUndefined(t[a])||!e.isArray(t[a]))&&(t[a]=[]):(p.isUndefined(t[a])||!p.isObject(t[a]))&&(t[a]={}),s=i.slice(1),p.deepSet(t[a],s,n,r))},readCheckboxUncheckedValues:function(t,i,n){var r,a,o,s,l;null==n&&(n={}),l=e.serializeJSON,r="input[type=checkbox][name]:not(:checked):not([disabled])",a=i.find(r).add(i.filter(r)),a.each(function(i,r){o=e(r),s=o.attr("data-unchecked-value"),s?t.push({name:r.name,value:s}):l.isUndefined(n.checkboxUncheckedValue)||t.push({name:r.name,value:n.checkboxUncheckedValue})})}}}(window.jQuery||window.Zepto||window.$),function(e,t,i){"use strict";var n=function(e,t,i){this.data=e.serializeArray(),this.file=t,this.$uploader=i,this.setContentTypeHeader(),this.renameFileWithTimestampAndFiletype()};n.prototype.setContentTypeHeader=function(){this.data.push({name:"content-type",value:this.file.type||""})},n.prototype.renameFileWithTimestampAndFiletype=function(){var e;e=t.grep(this.data,function(e){return"key"===e.name?e:void 0})[0],e.value=e.value.replace("{timestamp}",(new Date).getTime()).replace("{filetype}",this.file.type||"")};var r=function(e,t){this._response=e,this._file=t,this.extractResponse()};r.prototype.extractResponse=function(){this.url=t(this._response).find("Location").text(),this.filepath=t("<a />").attr("href",this.url)[0].pathname,this.filename=this._file.name,this.filesize=this._file.size,this.lastModifiedDate=this._file.lastModifiedDate,this.filetype=this._file.type};var a=function(e){var t=new o(e);this.file=e,this.file.isImage=t.hasFiletypeOfImage(),this.file.width=null,this.file.height=null,this.file.src=null};a.prototype.load=function(t){var i,n,r;r=this.file,e.FileReader&&r.isImage?(i=new FileReader,n=new Image,i.readAsDataURL(r),i.onload=function(e){n.src=e.target.result,n.onload=function(){r.width=n.width,r.height=n.height,r.src=n.src,t(r)}}):t(r)};var o=function(e){this.file=e};o.prototype.hasWidthGreaterThan=function(e){return _.isNumber(this.file.width)&&this.file.width>=e?!0:!1},o.prototype.hasHeightGreaterThan=function(e){return _.isNumber(this.file.height)&&this.file.height>=e?!0:!1},o.prototype.hasDimensionsGreaterThan=function(e){return _.isNumber(this.file.height)&&_.isNumber(this.file.width)&&this.file.width*this.file.height>=e?!0:!1},o.prototype.hasFiletypeOfJPEG=function(){return/(\/jpe?g)/i.test(this.file.type)?!0:!1},o.prototype.hasFiletypeOfImage=function(){return/(image\/)/i.test(this.file.type)?!0:!1},o.prototype.hasFiletypeOfVideo=function(){return/(video\/)/i.test(this.file.type)?!0:!1},o.prototype.hasFilesizeLessThan=function(e){return _.isNumber(this.file.size)&&this.file.size<=e?!0:!1},e.GeneralUploader={Form:n,File:a,S3Response:r,Validator:o}}(window,jQuery),function(e,t,i){var n=t.fn.generalUploader,r=function(){};t.fn.generalUploader=function(i){var n,a;return a={onAddingFile:r,beforeValidation:r,afterValidation:r,validateFile:function(e){return!0},afterUploading:r,onError:r,onProgress:r,setSrcAsBackgroundImage:!1,pseudoFileField:".js-general-uploader-pseudo-file-field",fileField:".js-general-uploader-s3-file-field",progressTarget:".js-general-uploader-progress-target",newUploadTarget:".js-general-uploader-new-upload-target",formTemplate:".js-general-uploader-form-template",form:".js-general-uploader-form",submitButton:".js-general-uploader-form-submit"},n=t.extend({},a,i),this.fileupload({$uploader:this,autoUpload:!0,add:function(e,t){var i;n.onAddingFile(),i=new GeneralUploader.File(t.files[0]),i.load(function(e){t.files[0]=e,t.submit()})},formData:function(e){return new GeneralUploader.Form(e,this.files[0]).data},submit:function(e,i){var r;return n.beforeValidation(),r=i.files[0],n.validateFile(r)?(t(n.progressTarget).width("0%"),r.isImage&&r.src&&(n.setSrcAsBackgroundImage?t(n.newUploadTarget).css("background-image","url("+i.files[0].src+")"):t(n.newUploadTarget).attr("src",i.files[0].src)),t(n.submitButton).addClass("disabled"),n.afterValidation(r),!0):!1},fail:function(i,r){e.Flash.emitErrorEvent({message:"There was an error uploading the file to the server. Try again."}),t(n.submitButton).removeClass("disabled"),n.onError(i,r)},done:function(e,i){var r,a,o,s;r=new GeneralUploader.S3Response(i.result,i.files[0]),o=t(n.formTemplate),o.length&&(s=o.html(),a=_.template(s)({file:r}),t(n.form).html(a)),t(n.submitButton).removeClass("disabled"),n.afterUploading(r)},progress:function(e,i){var r;i&&i.total&&(r=parseInt(i.loaded/i.total*100,10),t(n.progressTarget).width(r+"%"),n.onProgress(r))}}),t(n.pseudoFileField).on("click",function(e){e.preventDefault(),t(n.fileField).trigger("click")}),this},t.fn.generalUploader.noConflict=function(){return t.fn.generalUploader=n,this}}(window,jQuery),function(e,t,i){var n;t(function(){n=t(".js-edit-profile-image-s3-form"),n.length&&n.generalUploader({validateFile:function(t){var i=new GeneralUploader.Validator(t);return i.hasFiletypeOfImage()?i.hasFilesizeLessThan(1e6)?!0:(e.Flash.emitErrorEvent({message:"Profile image must be less than 1MB. Try reducing the size of image."}),!1):(e.Flash.emitErrorEvent({message:"Profile image must be of type image. Try converting the image to JPEG."}),!1)},afterValidation:function(){var e=t(".js-edit-profile-image-trigger-text"),i=e.text();e.data("text",i).text("Uploading...")},afterUploading:function(e){t(".js-edit-profile-image-form").trigger("submit")}})})}(window,jQuery),function(e,t,i){var n,r;t(function(){r=t(".js-edit-announcement-image-s3-form"),r.length&&r.generalUploader({validateFile:function(t){var i=new GeneralUploader.Validator(t);return i.hasFiletypeOfImage()?i.hasFilesizeLessThan(1e6)?!0:(e.Flash.emitErrorEvent({message:"Announcement image must be less than 1MB. Try reducing the size of image."}),!1):(e.Flash.emitErrorEvent({message:"Announcement image must be of type image. Try converting the image to JPEG."}),!1)},afterValidation:function(){var e=t(".js-edit-announcement-image-trigger-text");n=e.text(),e.data("text",n).text("Uploading...")},afterUploading:function(e){var i=t(".js-edit-announcement-image-trigger-text");i.text(n)}})})}(window,jQuery),function(e,t,i){var n,r;t(function(){r=t(".js-edit-teammate-image-s3-form"),r.length&&r.generalUploader({setSrcAsBackgroundImage:!0,validateFile:function(t){var i=new GeneralUploader.Validator(t);return i.hasFiletypeOfImage()?i.hasFilesizeLessThan(1e8)?!0:(e.Flash.emitErrorEvent({message:"Teammate baby picture must be less than 100MB. Try reducing the size of image."}),!1):(e.Flash.emitErrorEvent({message:"Teammate baby picture must be of type image. Try converting the image to JPEG."}),!1)},afterValidation:function(){var e=t(".js-add-teammate-trigger-text");n=e.text(),e.data("text",n).text("Uploading...")},afterUploading:function(e){var i=t(".js-add-teammate-trigger-text");i.text("Replace baby picture")}})})}(window,jQuery),function(e,t,i){var n,r;t(function(){r=t(".js-edit-moment-image-s3-form"),r.length&&r.generalUploader({setSrcAsBackgroundImage:!0,validateFile:function(t){var i=new GeneralUploader.Validator(t);return i.hasFiletypeOfImage()?i.hasFilesizeLessThan(1e8)?!0:(e.Flash.emitErrorEvent({message:"Moment image must be less than 100MB. Try reducing the size of image."}),!1):(e.Flash.emitErrorEvent({message:"Moment image must be of type image. Try converting the image to JPEG."}),!1)},afterValidation:function(){var e=t(".js-add-moment-trigger-text");n=e.text(),e.data("text",n).text("Uploading...")},afterUploading:function(e){var i=t(".js-add-moment-trigger-text");i.text("Replace image")}})})}(window,jQuery),function(e,t,i){var n;t(function(){n=t(".js-add-screenshot-s3-form"),n.length&&n.generalUploader({setSrcAsBackgroundImage:!0,validateFile:function(t){var i=new GeneralUploader.Validator(t);return i.hasFiletypeOfImage()||i.hasFiletypeOfVideo()?i.hasFilesizeLessThan(75e6)?!0:(e.Flash.emitErrorEvent({message:"Attachment must be less than 50MB. Try reducing the size of that attachment."}),!1):(e.Flash.emitErrorEvent({message:"Attachment must be of type image or video."}),!1)},afterValidation:function(){var e=t(".js-add-screenshot-trigger-text");e.remove()},afterUploading:function(e){t(".js-general-uploader-form-submit").trigger("click")}})})}(window,jQuery),function(e,t,i){var n=c={},r={},a={};n.init=function(){this.$uploader=t(".js-admin-upload-s3-form"),this.$trigger=t(".js-admin-upload-trigger-text"),this.$exampleInput=t(".js-admin-uploader-example-input")},r.init=function(){this.triggerText=c.$trigger.text()},a.init=function(){c.$uploader.generalUploader({onProgress:a.updateProgressText,afterUploading:function(e){a.resetUploadText(),a.showFileURL(e.filepath)}})},a.shouldInit=function(){return!!c.$uploader.length},a.updateProgressText=function(e){c.$trigger.text(e+"%...")},a.showFileURL=function(t){var i=function(t){var i=t.replace("/images.unsplash.com/","");return e.publicKeys.CDN.download+i};c.$exampleInput.clone().val(i(t)).insertBefore(c.$exampleInput)},a.resetUploadText=function(){c.$trigger.text(r.triggerText)},t(function(){n.init(),r.init(),a.shouldInit()&&a.init()})}(window,jQuery);