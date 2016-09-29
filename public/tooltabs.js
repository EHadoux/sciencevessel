var data = {tab: 'overview'}
new Vue({
  el: '#overviewtoggle',
  data: data,
  methods: {
    toggle: function(event) {this.tab = 'overview'}
  }
})

new Vue({
  el: '#balancespantoggle',
  data: data,
  methods: {
    toggle: function(event) {this.tab = 'balancespan'}
  }
})

new Vue({
  el: '#sc2-p-idtoggle',
  data: data,
  methods: {
    toggle: function(event) {this.tab = 'sc2-p-id'}
  }
})

new Vue({
  el: '#overview',
  data: data
})

new Vue({
  el: '#balancespan',
  data: data
})

new Vue({
  el: '#sc2-p-id',
  data: data
})