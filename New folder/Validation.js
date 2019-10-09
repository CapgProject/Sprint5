 $(function() {
         $("#username_error_message").hide();
         $("#password_error_message").hide();
        
         var error_username = false;
         var error_password = false;
        
         $("#form_username").focusout(function(){
            check_username();
         });
         $("#form_password").focusout(function() {
            check_password();
         });
         
         function check_username() {
            var pattern = /^[A-Z][A-Za-z 0-9_-]*$/;
            var username = $("#form_username").val();
            if (pattern.test(username) && username !== '') {
               $("#username_error_message").hide();
               $("#form_username").css("border-bottom","2px solid #34F458");
            } else {
               $("#username_error_message").html("Should contain only Characters");
               $("#username_error_message").show();
               $("#form_username").css("border-bottom","2px solid #F90A0A");
               error_username = true;
            }
         
           
         function check_password() {
            var password_length = $("#form_password").val().length;
            if (password_length < 8) {
               $("#password_error_message").html("Atleast 8 Characters");
               $("#password_error_message").show();
               $("#form_password").css("border-bottom","2px solid #F90A0A");
               error_password = true;
            } else {
               $("#password_error_message").hide();
               $("#form_password").css("border-bottom","2px solid #34F458");
            }
         }
      
        
         $("#registration_form").submit(function() {
            error_username = false;
            error_password = false;
            check_username();
            check_password();
            check_retype_password();
            if (error_username === false && error_password === false ) {
               alert("Updated Successfull");
               return true;
            } else {
               alert("Please Fill the form Correctly");
               return false;
            }
         });
         });