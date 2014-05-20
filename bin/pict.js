// @see http://code.ohloh.net/file?fid=kXVN5HCJK4Nv7fjwDTtngR5gaug&cid=RhmXKV7xKoA&s=&fp=386616&mp&projSelected=true#L0

var page = require('webpage').create()
, system = require('system')
, frame_width     = 800
, frame_height    = 800
, frame_interval  = 160               // 25fps if time_factor = 2
, max_frames      = 50                // 10 minutes @ 25fps
, file_format = 'png'
, page_url
, frame_dir
, debug = false
;

if (system.args.length < 3 || system.args.length > 4) {
  console.log('Usage: phantomjs pict.js URL dirname [debug]');
  phantom.exit(1);
} else {
  page_url        = system.args[1];
  frame_dir       = system.args[2];
  if (system.args[3]) {
    debug   = system.args[3];
    console.log('start');
  }
  // iPhone
  var userAgent = 'Mozilla/5.0 (iPhone; CPU iPhone OS 5_1_1 like Mac OS X) AppleWebKit/534.46 (KHTML, like Gecko) Version/5.1 Mobile/9B206 Safari/7534.48.3';
  var userAgent = 'PhantomJS';

  page.customHeaders = {
    'Connection' : 'keep-alive',
    'Accept-Charset' : 'Shift_JIS,utf-8;q=0.7,*;q=0.3',
    'Accept-Language' : 'ja,en-US;q=0.8,en;q=0.6',
    'Cache-Control' : 'no-cache',
    'User-Agent' : userAgent
  };

  page.viewportSize = { width: frame_width, height: frame_height };
  // TODO marqueeタグの位置をピンポイントでキャプチャ
  // http://shokai.org/blog/archives/7101
  page.clipRect = { top: 0, left: 0, width: frame_width, height: frame_height };

  page.onConsoleMessage = function (msg) {
    if (debug) {
      console.log('>> ' + msg);
    }
  };

  if (debug) {
    console.log('page.open');
    console.log(page_url);
  }
  page.open(page_url, function() {
    var frame_number = 0;
    setInterval(function() {
      filename = "frame_" + '0000'.substr(('' + frame_number).length) + frame_number + '.' + file_format;
      if (debug) {
        console.log(filename);
      }
      page.render(frame_dir + '/' + filename, { format: file_format });
      // アプリケーションでファイルパスを受け取る
      console.log(frame_dir + '/' + filename)
      frame_number++;
      if(frame_number > max_frames) {
        if (debug) {
          console.log("Timing out after " + max_frames + " frames");
        }
        phantom.exit();
      }
    }, frame_interval);
  });
}
