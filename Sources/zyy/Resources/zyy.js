const ZYY_SERVER_PREFIX = "http://127.0.0.1:8080";

const ZYY_CONFIG = {
  TOKEN: "zyy-token",
  
  LOGIN_URL: ZYY_SERVER_PREFIX + "/api/auth/login",
  LOGIN_METHOD: "POST",
  
  SIGNUP_URL: ZYY_SERVER_PREFIX + "/api/auth/register",
  SIGNUP_METHOD: "POST",
  
  DASHBOARD_ME_URL: ZYY_SERVER_PREFIX + "/api/dash/me",
  DASHBOARD_ME_METHOD: "GET"
}


/* MARK: - Utility */

function redirect_to_login(p1) {
  alert(p1);
  window.location.href = "/login.html";
}

function redirect_to_index() {
  window.location.href = "/";
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
          redirect_to_login("Your registration is complete and successful.");
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

/* Login */
let login_form = document.getElementById("login");
if (login_form !== null) {
  login_form.addEventListener("submit", function(e) {
    e.preventDefault(); /* to prevent form submission */
  
    let username = document.getElementById("username").value;
    let password = document.getElementById("password").value;
    let auth = btoa(`${username}:${password}`);
    
    let xhr = new XMLHttpRequest();
    xhr.open(ZYY_CONFIG.LOGIN_METHOD, ZYY_CONFIG.LOGIN_URL);
    xhr.setRequestHeader("Authorization", `Basic ${auth}`);
    xhr.send();
    xhr.onreadystatechange=function() {
      if (this.readyState == 4) {
        if (this.status == 200) {
          let uj = JSON.parse(xhr.responseText);
          window.localStorage.setItem(ZYY_CONFIG.TOKEN, uj.value);
          redirect_to_index();
        } else if (this.status == 401) {
          alert("Email address/password do not match.");
        }
      }
    }
  });
}

/* MARK: - Dashboard */

/* me */
function dashboard_me() {
  let token = window.localStorage.getItem(ZYY_CONFIG.TOKEN);
  if (token == null) {
    redirect_to_login(
      "Please log in to your account to access" +
      " the full range of features and services."
    );
  }
  
  let xhr = new XMLHttpRequest();
  xhr.open(ZYY_CONFIG.DASHBOARD_ME_METHOD, ZYY_CONFIG.DASHBOARD_ME_URL);
  xhr.setRequestHeader("Authorization", "Bearer " + token);
  xhr.send();
  xhr.onreadystatechange=function() {
    if (this.readyState == 4) {
      if (this.status == 200) {
        let mj = JSON.parse(xhr.responseText);
        let me = `<a href="${mj.link}">${mj.first_name} ${mj.last_name}</a>`
        
        document.getElementById("dashboard-me").innerHTML = me;
      } else if (this.status == 401) {
        redirect_to_login(
          "Please log in to your account to access" +
          " the full range of features and services."
        );
      }
    }
  }
}
