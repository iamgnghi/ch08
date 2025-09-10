<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Subscription successful</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/main.css" type="text/css"/>
</head>
<body class="ui-body">
<main class="card">
    <h1 class="title success">Thanks for joining!</h1>
    <p class="subtitle">Here’s what you submitted:</p>

    <div class="kv">
        <div class="row"><span class="k">Email</span><span class="v">${user.email}</span></div>
        <div class="row"><span class="k">First Name</span><span class="v">${user.firstName}</span></div>
        <div class="row"><span class="k">Last Name</span><span class="v">${user.lastName}</span></div>
        <div class="row"><span class="k">Date of Birth</span><span class="v">${user.dob}</span></div>
    </div>

    <p class="note">This address was added on ${requestScope.currentDate}.</p>

    <p class="mini">
        Support: ${initParam.custServEmail}<br/>
        First item: ${sessionScope.users[0].email} &nbsp;|&nbsp;
        Second item: ${sessionScope.users[1].email}
    </p>

    <form action="" method="get" class="center">
        <input type="hidden" name="action" value="join"/>
        <button type="submit" class="btn">Enter another address</button>
    </form>
</main>
</body>
</html>
