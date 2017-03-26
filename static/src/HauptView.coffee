define ['student','lent','ajax'],(Student,Lent,ajax)->
  class HauptViewModell
    constructor: ()->
      @to_be_student = ko.observable new Student
      @add_student = ()=>
        ajax("api/student","POST",ko.toJS(@to_be_student())).done((data)->
          alert "Hinzugefügt"
          #clear und schließen
          @to_be_student(new Student)
        )
        console.log
