define ['student','lent','folder','ajax'],(Student,Lent,Folder,ajax)->
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
      @folders= ko.observableArray []
      @selected_folders= ko.observableArray []
      ajax("api/folder","GET").done((data)=>
        @folders.push new Folder i for i in data.objects)
      @rent =()=>
        ajax("api/lent","POST",(studentid:@searched_student_id(),folderid:i)).done((data)=>
          @lent.push new Lent data) for i in @selected_folders()
        @selected_folders([])
      @restore=(data)=>
        console.log data
        #delete lent object
        ajax("api/lent/#{data.id()}","DELETE").done((data2)=>
          #returned
          ajax("api/returned","POST",(studentid:data.studentid(),folderid:data.folderid())).done((data3)=>
            console.log data3
            @lent.remove((obj)->data.id()==obj.id())
            ))
      @edit_table_student=(data)=>
        @searched_student_id data.studentid()
        @edit_student()
