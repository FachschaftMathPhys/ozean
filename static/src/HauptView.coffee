define ['student','lent','folder','ajax'],(Student,Lent,Folder,ajax)->
  class HauptViewModell
    constructor: ()->
      @searched_student_id= ko.observable -1
      @student_selected= ko.computed ()=>
        @searched_student_id()>=0
      @searched_student_id(-1)
      @searched_student_uniid= ko.observable -1
      @student_selected_has_uniid= ko.computed ()=>
        @searched_student_uniid()!=''
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
      ajax("api/lent?results_per_page=1000", "GET").done((data)=>
        @lent.push new Lent i for i in data.objects
      )
      @folders= ko.observableArray []
      @selected_folders= ko.observableArray []
      orderObject={order_by:[{"field": "obligation_to_report"},{"field": "name"}]}
      ajax("api/folder?results_per_page=1000&q="+JSON.stringify(orderObject),"GET").done((data)=>
        @folders.push new Folder i for i in data.objects)
      @rent =()=>
        console.log i for i in @selected_folders()
        return alert "Kein Student ausgewählt" if not @student_selected()
        return alert "Student hat keine uniid" if not @student_selected_has_uniid()
        kostenpflichtig= false
        kostenpflichtig |= i.obligation_to_report() for i in @selected_folders()
        ajax("api/student/#{@searched_student_id()}").done((student)=>
          return alert "Kostenpflichtiger Ordner bei Student ohne Berechtigung" if (not student.refund) and kostenpflichtig
          ajax("api/lent","POST",(studentid:@searched_student_id(),folderid:i.id())).done((data)=>
            @lent.push new Lent data) for i in @selected_folders()
          @selected_folders([]))
      @restore=(data)=>
        console.log data
        #delete lent object
        ajax("api/lent/#{data.id()}","DELETE").done((data2)=>
          #returned
          @lent.remove((obj)->data.id()==obj.id())
          ajax("api/returned","POST",(studentid:data.studentid(),folderid:data.folderid())).done((data3)=>
            #console.log data3
          ))
      @edit_table_student=(data)=>
        @searched_student_id data.studentid()
        @edit_student()
