define ['student','lent','ajax'],(Student,Lent,ajax)->
  class HauptViewModell
    constructor: ()->
      @searched_student_id= ko.observable -1
      @student_selected= ko.computed ()=>
        @searched_student_id()>=0
      @searched_student_id(-1)
      @to_be_student = ko.observable new Student
      @editing_student= ko.observable false
      @adding_student= ko.observable false
      @start_add=()=>
        @adding_student true
      @stop_add=()=>
        @adding_student false
      @stop_edit=()=>
        @editing_student false
      @edited_student= ko.observable new Student
      @edit_student=()=>
        return alert "Kein Student ausgewählt" if not @student_selected()
        ajax("api/student/#{@searched_student_id()}","GET").done( (data2)=>
          @edited_student new Student data2
          @editing_student true
          )
      @save_student_changes=()=>
        ajax("api/student/#{@searched_student_id()}","PUT",ko.toJS(@edited_student())).done( (data2)=>
            @editing_student false
          )
      @add_student = ()=>
        ajax("api/student","POST",ko.toJS(@to_be_student())).done((data)=>
          #clear und schließen
          @to_be_student(new Student)
          @adding_student false
        )
      @lent=ko.observableArray []
      ajax("api/lent", "GET").done((data)=>
        @lent.push new Lent i for i in data.objects
      )
