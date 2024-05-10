const ZYY_SERVER_PREFIX = "http://127.0.0.1:8080";

const ZYY_CONFIG = {
  LOGIN_URL: ZYY_SERVER_PREFIX + "/auth/login",
  LOGIN_METHOD: "POST",
  
  SIGNUP_URL: ZYY_SERVER_PREFIX + "/auth/register",
  SIGNUP_METHOD: "POST"
}


/* MARK: - Authentication */

/* Register */
let signup_form = document.getElementById("signup");
if (signup_form !== null) {
  signup_form.addEventListener("submit", function(e) {
    e.preventDefault(); /* to prevent form submission */
    
    let first_name = document.getElementById("first-name").value;
    let last_name = document.getElementById("last-name").value;
    let birthday = document.getElementById("birthday").value;
    let username = document.getElementById("username").value;
    let password = document.getElementById("password").value;
    let confirm_password = document.getElementById("confirm-password").value;
    let website = document.getElementById("website").value;
    
    let xhr = new XMLHttpRequest();
    xhr.open(ZYY_CONFIG.SIGNUP_METHOD, ZYY_CONFIG.SIGNUP_URL);
    xhr.setRequestHeader("Content-Type", "application/json");
    xhr.send(
      JSON.stringify({
        "first_name" : first_name,
        "last_name" : last_name,
        "birthday" : birthday + "T00:00:00+0000",
        "email" : username,
        "password" : password,
        "confirm_password" : confirm_password,
        "link" : website
      })
    );
    xhr.onreadystatechange=function() {
      if (this.readyState == 4) {
        if (this.status == 201) {
          alert("Your registration is complete and successful.");
          window.location.href = "/login.html";
        } else if (this.status == 400) {
          alert(
            "Registration failed. " +
            "Possible reasons: registration limit reached or invalid request."
          );
        }
      }
    }
  });
}
