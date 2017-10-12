# healthcare-server
A rubyOnRails based web application with a small concept behind healthcare full proposal here [Proposal](https://github.com/rajagopal28/healthcare-server/blob/master/proposal.md)
The related mobile repository can be viewed ==> [Mobile](https://github.com/rajagopal28/Jakie)
## Problem at hand
Our major objective is to create an environment that helps us be independent and be healthy. Being independent makes us feel empowered all the time. People tend to forget things more often. But when it comes to health we got to be vigilant. Diabetic people need constant attention and care when it comes to health checks and medications. Level-2 Diabetes often required periodic insulin intake to keep glucose level balanced. They should also maintain a timely and proper diet that goes hand in hand with their medication schedules. We live in a busy world where we cannot be around all the time. With that being said we can deep dive into our proposed solution.

## The proposed solution
The proposed solution is to have a multi-platform environment that helps you take care of yourself. We intend to build a personal assistant based ecosystem that helps you keep track of your health by monitoring your body vitals viz., glucose, pressure, pulse and temperature, perform tasks like book appointments, view or remind you about your booked appointments, keep track of you medicine prescriptions, intake and personal medicine inventory management in a more nurturing and enjoyable way.


## Proposed architecture
![Architecture](https://file.ac/h-50abi7Tj0/image00.png)
This entire application has 3 essential components
- The centralized healthcare server which holds patient data such as vital information, medicine intake logs, appointments, prescriptions etc.
- The mobile app + wearable component - with this combo we can collect user information such as vitals, medicine intake activities, reminders on appointments and medicine intakes etc.
- The Alexa skill - which is essentially coupled with the data back-end to personally serve people in managing their vitals, appointments and medicine intake.


## Backend Schema
![Schema](https://file.ac/h-50abi7Tj0/image02.png)


## Major User cases
Centralized web applications with ability too
- view & create doctor appointments
- view & create vitals
- monitor and visualize vitals
- view & create medicines
- view & create prescriptions and medicines
- view & create doctor appointments, schedules and reschedules
- view & create notifications for doctors
- monitor and visualize medicine availability


## Technical Nuances
- As we had to kick start with an application in a short time we chose Ruby on rails + Postgres back-end to give us a quick and stable back-end powered by Heroku infrastructure.


## Key Learnings=
- How to create and publish an alexa skill by leveraging the voice activated technlogies in a smooth and effective way.
- React native is adaptive, flexible enough to let both native as well as hybrid code and features by binding them together with their coherant data flows and models.
- Ruby on rails is the quickest script based web application framework that can be developer friendly as well as feature friendly with their ability to scale and balance.

## References
- http://guides.rubyonrails.org/association_basics.html
- https://stackoverflow.com/questions/36946498/for-loop-with-select-helper
- https://www.tutorialspoint.com/ruby-on-rails/rails-scaffolding.htm
- https://www.digitalocean.com/community/tutorials/how-to-use-postgresql-with-your-ruby-on-rails-application-on-ubuntu-14-04
- http://mentalized.net/journal/2017/04/22/run-rails-migrations-on-heroku-deploy/
- https://www.chartkick.com/
- http://guides.rubyonrails.org/active_record_querying.html
- https://www.theodinproject.com/courses/ruby-on-rails/lessons/sessions-cookies-and-authentication
