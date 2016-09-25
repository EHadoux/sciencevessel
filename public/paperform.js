var data = {shown: false}
var btnv = new Vue({
  el: '#paperformtoggle',
  data: data,
  methods: {
    toggle: function(event) {this.shown = !this.shown}
  }
})

var paperformv = new Vue({
  el: '#paperform',
  data: data
})