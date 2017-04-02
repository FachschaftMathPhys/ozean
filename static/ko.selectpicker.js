ko.bindingHandlers.selectPicker = {
  init: function(element, valueAccessor, allBindingsAccessor) {
    if ($(element).is('select')) {
           $(element).addClass('selectpicker').selectpicker();
       }
  },
  update: function(element, valueAccessor, allBindingsAccessor) {
  if ($(element).is('select')) {
           if (ko.utils.unwrapObservable(valueAccessor()).length > 0) {
               // call the default Knockout options binding
               ko.bindingHandlers.options.update(element, valueAccessor, allBindingsAccessor);
           }

           var isDisabled = ko.utils.unwrapObservable(allBindingsAccessor().disable);
           if (isDisabled) {
               // the dropdown is disabled and we need to reset it to its first option
               $(element).selectpicker('val', $(element).children('option:last').val());
           }
           $(element).prop('disabled', isDisabled);

           var value = ko.utils.unwrapObservable(allBindingsAccessor().selectedOptions || allBindingsAccessor().value);
           if ($(element).prop('multiple') && $.isArray(value)) {
               ko.bindingHandlers.selectedOptions.update(element, allBindingsAccessor().selectedOptions);
           } else {
               // call the default Knockout value binding
               ko.bindingHandlers.value.update(element, allBindingsAccessor().value);
           }
           //console.log(value);
           $(element).selectpicker('refresh');
       }
  }
};
