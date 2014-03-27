database
========

2014 DB class Homeworks and project
----

Homework 2
---
1. User interface
    - Login page
        - User should login with account & password
        - Provide a link to register page
        - Use sessions to implement login
    - Register page
        - Identities includes admin and user
        - Account & password must be set up correctly
            - account should be unique, and empty string or whitespace are not allowed
            - password cannot be empty string
            - password should be encrypted with hashing
            - After successful registration, redirect to login page. Otherwise, stay in registration page.
    - After logged in, user will be redirected to different page according to their identity

2. Identity
    - There are 2 identities in this system: user, admin
    - For user, refer to part 3
    - For admin, refer to part 4

3. User page
    - Show information of all flights
        - Flight information should include id, flight number, departure, destination, departure date, arrival date
    - Logout
        - After logged out, redirect to login page

4. Admin page
    - Show information of all flights (same as user)
        - Flight information include id, flight number, departure, destination, departure date, arrival date
    - Logout(same as user)
        - After logged out, redirect to login page
    - Flight management
        - Create new flight information
            - New flight information should include following data: flight number, departure, destination, departure date, arrival date. Empty string or whitespace are not allowed.
            - Id should be auto-generated by system
        - Update flight information
            - Admin can edit flight number, departure, destination, departure date, arrival date of a flight
            - Empty string or whitespace are not allowed.
            - Id cannot be updated
        - Delete flight information
        
Homework 3
---
1.  Brief introduction
    - This is the extension of hw2.
    - Add "ticket price" to the flight information table.
    - Two extra demands for the admin.
    - New: comparison sheet!
        - User may add their preferred flights to the comparison sheet.
    - Please remove the capability of users to register as the admin.
    - The design of the table and the implementation of foreign key are parts of the project.

2. Comparison sheet
    - Each user maintains their own comparison sheet.
    - table display
        - The displayed columns are the same as the columns of flights.
    - Sheets management
        - Create: refer to part 3
        - Delete: remove any flight from the sheet.
        - Sort: sort columns by certain attribute.
            - Columns include "departure date", "arrival date", and "price"
            - If the values of selected attribute are the same, sort them by flight no. (in alphabetical order)
            - Sort the flight information in ascending/descending order.

3. Flight sheet
    - Check all flights information.
        - Columns include "flight no", "departure"," destination", "departure date", "arrival date", and "price".
        - Sorting and searching the flight information are required.
    - Sort: sort columns by certain attribute.
        - If the values of selected attribute are the same, sort them by flight no. (in alphabetical order)
        - Sort the flight information in ascending/descending order.
    - Search: list the satisfied flights with selected attribute and sort them orderly.
        - Columns includes “flight no”, “departure”, and “destination”.
        - Sort the flight information in ascending/descending order according to “departure date”, “arrival date”, or “price”.
    - Add flights into the comparison sheet.

4. User page
    - Look up the comparison sheet. (Refer to part 2)
    - Look up the flight information table. (Refer to part 3)

5.  Admin authority
    - Look up the comparison sheet. (Refer to part 2)
    - Look up the flight information table. (Refer to part 3)
    - (new) admin authority
        - Look up the user list.
        - The displayed columns include “account” and “identity”.
        - Add new users.
            - The identity may be admin or user.
            - The format of password and account refers to hw2.
        - Delete the user.
            - User’s comparison sheet should be deleted as he is removed from user list.
            - The user is forced to logout as he does any further actions.
        - Edit the user.
            - Admin can only modify the authority of the users.
            - The modified authority will come into effect after user logout.
    - (new) airport management
        - The list of airport location.
            - List the location of airports.
        - Add new airport.
            - Provided information includes “name”, “longitude”, and ”latitude”.
            - The format of “longitude” and “latitude” are (41.40338, 2.17403) .
        - Edit the airport data.
            - Update the value of “name”, “longitude”, and “latitude”.
        - Delete the airport.
            - When admin delete some location of the airport, any flight information including the deleted place should be removed accordingly.
            - Correspondingly, if the flight was added to someone’s comparison sheet, it should be removed, too.
    - (modified) flight management
        - The value of “departure” and “destination” must be valid when creating new flights.
        - Otherwise, the update fails.
