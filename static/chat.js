// Toolbar functions
function wrapText(b, a) {
  var i = document.getElementById('msg-input');
  var s = i.selectionStart, e = i.selectionEnd, t = i.value;
  i.value = t.slice(0, s) + b + t.slice(s, e) + a + t.slice(e);
  i.focus();
  i.setSelectionRange(s + b.length, e + b.length);
  autoSize(i);
}

function insertLine(prefix) {
  var i = document.getElementById('msg-input'), s = i.selectionStart, t = i.value;
  var nl = s > 0 && t[s - 1] !== '\n' ? '\n' : '';
  i.value = t.slice(0, s) + nl + prefix + t.slice(s);
  var pos = s + nl.length + prefix.length;
  i.focus();
  i.setSelectionRange(pos, pos);
  autoSize(i);
}

function insertBlock(fence) {
  var i = document.getElementById('msg-input'), s = i.selectionStart, e = i.selectionEnd, t = i.value;
  var sel = t.slice(s, e) || 'code';
  var nl = s > 0 && t[s - 1] !== '\n' ? '\n' : '';
  i.value = t.slice(0, s) + nl + fence + '\n' + sel + '\n' + fence + t.slice(e);
  var pos = s + nl.length + fence.length + 1;
  i.focus();
  i.setSelectionRange(pos, pos + sel.length);
  autoSize(i);
}

function autoSize(el) {
  el.style.height = 'auto';
  el.style.height = Math.min(el.scrollHeight, 150) + 'px';
}

// Auto-scroll chat to bottom
document.addEventListener('DOMContentLoaded', function() {
  var chat = document.getElementById('chat-messages');
  if (chat) chat.scrollTop = chat.scrollHeight;

  // Confirm deletes
  document.querySelectorAll('[data-confirm]').forEach(function(el) {
    el.addEventListener('submit', function(e) {
      if (!confirm(el.dataset.confirm)) e.preventDefault();
    });
  });
});
