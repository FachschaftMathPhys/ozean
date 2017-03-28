require ['HauptView'],(HauptViewModell)->
  $(document).ready(()->
    ko.applyBindings(new HauptViewModell(),$('#HauptView')[0]))
