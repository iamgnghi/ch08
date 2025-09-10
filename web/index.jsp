<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Subscribe to our newsletter</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/main.css" type="text/css"/>
</head>
<body class="ui-body">
<main class="card">

    <!-- Tiêu đề và phụ đề với style mới -->
    <h1 class="form-title">Join our email list</h1>
    <p class="form-subtitle">Enter your details to receive weekly updates.</p>

    <form class="form" action="emailList" method="post" id="joinForm" novalidate>
        <input type="hidden" name="action" value="add"/>

        <div class="field">
            <label for="email">Email <span class="req">*</span></label>
            <input
                    id="email"
                    name="email"
                    type="email"
                    required
                    autocomplete="email"
                    placeholder="name@example.com"
                    value="${user.email}"/>
        </div>

        <div class="field">
            <label for="firstName">First Name <span class="req">*</span></label>
            <input
                    id="firstName"
                    name="firstName"
                    type="text"
                    required
                    minlength="1"
                    placeholder="John"
                    value="${user.firstName}"/>
        </div>

        <div class="field">
            <label for="lastName">Last Name <span class="req">*</span></label>
            <input
                    id="lastName"
                    name="lastName"
                    type="text"
                    required
                    minlength="1"
                    placeholder="Doe"
                    value="${user.lastName}"/>
        </div>

        <div class="field">
            <label for="dob">Date of Birth <span class="req">*</span></label>
            <input
                    id="dob"
                    name="dob"
                    type="date"
                    required
                    value="${user.dob}"/>
            <small class="hint">Choose a past date (no future dates).</small>
        </div>

        <button class="btn" type="submit">Subscribe</button>
    </form>
</main>

<script>
    // Set DOB constraints WITHOUT template literals to avoid JSP EL conflict
    (function () {
        var dob = document.getElementById('dob');
        var today = new Date();
        function pad(n){ return String(n).padStart(2, '0'); }
        var todayStr = today.getFullYear() + '-' + pad(today.getMonth() + 1) + '-' + pad(today.getDate());
        dob.max = todayStr;
        dob.min = '1900-01-01';
    })();
</script>
</body>
</html>
