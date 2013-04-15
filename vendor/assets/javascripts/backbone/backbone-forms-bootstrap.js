/** 
 * Include this template file after backbone-forms.amd.js to override the default templates
 * 
 * 'data-*' attributes control where elements are placed
 */
;(function(Form) {

  
  /**
   * Bootstrap templates for Backbone Forms
   */
  Form.template = _.template('\
    <form data-fieldsets></form>\
  ');


  Form.Fieldset.template = _.template('\
    <fieldset data-fields>\
      <% if (legend) { %>\
        <legend><%= legend %></legend>\
      <% } %>\
    </fieldset>\
  ');


  Form.Field.template = _.template('\
    <div class="control-group field-<%= key %>">\
      <label class="control-label" for="<%= editorId %>"><%= title %></label>\
      <div class="controls">\
        <span data-editor></span>\
      </div>\
    </div>\
  ');


  Form.NestedField.template = _.template('\
    <div class="field-<%= key %>">\
      <div title="<%= title %>" class="input-xlarge">\
        <span data-editor></span>\
        <div class="help-inline" data-error></div>\
      </div>\
      <div class="help-block"><%= help %></div>\
    </div>\
  ');


})(Backbone.Form);