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

// Render reaction pills from data attributes
// Format: "👍:2:Alice, Bob|🔥:1:Carol"
function renderReactions() {
  document.querySelectorAll('.reaction-pills').forEach(function(el) {
    var raw = el.dataset.reactions;
    if (!raw || el.dataset.rendered) return;
    el.dataset.rendered = '1';
    var msgid = el.dataset.msgid;
    var chid = el.dataset.chid;
    var csrf = el.dataset.csrf;
    raw.split('|').forEach(function(part) {
      var s = part.split(':');
      if (s.length < 3) return;
      var emoji = s[0], count = s[1], names = s.slice(2).join(':');
      var form = document.createElement('form');
      form.method = 'POST';
      form.action = '/messages/' + msgid + '/unreact/' + encodeURIComponent(emoji);
      form.style.display = 'inline';
      var csrfInput = document.createElement('input');
      csrfInput.type = 'hidden'; csrfInput.name = '_csrf'; csrfInput.value = csrf;
      var chInput = document.createElement('input');
      chInput.type = 'hidden'; chInput.name = 'channel_id'; chInput.value = chid;
      var emojiInput = document.createElement('input');
      emojiInput.type = 'hidden'; emojiInput.name = 'emoji'; emojiInput.value = emoji;
      var btn = document.createElement('button');
      btn.type = 'submit';
      btn.className = 'inline-flex items-center gap-1 px-2 py-0.5 rounded-full border border-[#ffffff15] bg-[#ffffff05] text-xs hover:bg-[#ffffff10] hover:border-[#ffffff25] transition cursor-pointer';
      btn.title = names;
      btn.textContent = emoji + ' ' + count;
      form.appendChild(csrfInput);
      form.appendChild(chInput);
      form.appendChild(emojiInput);
      form.appendChild(btn);
      el.appendChild(form);
    });
  });
}

// Auto-scroll chat to bottom
function initChat() {
  var chat = document.getElementById('chat-messages');
  if (chat) chat.scrollTop = chat.scrollHeight;

  // Confirm deletes
  document.querySelectorAll('[data-confirm]').forEach(function(el) {
    el.addEventListener('submit', function(e) {
      if (!confirm(el.dataset.confirm)) e.preventDefault();
    });
  });

  renderReactions();
}

document.addEventListener('DOMContentLoaded', initChat);
// Re-render after htmx swaps (polling)
document.addEventListener('htmx:afterSwap', renderReactions);
