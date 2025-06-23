## Prerequisites

- **If you have not set up the Incident Management Application, follow the below steps. Else skip this page.**

## Set Up the Incident Management Application

1. Clone the Incident Management application:
   
   `git clone https://github.com/cap-js/incidents-app.git`

2. Open `package.json`, and remove the below devDependencies if exists.

   ```json
   "devDependencies": {
      ...
      "@cap-js/audit-logging": "^0.8.0",
      "@cap-js/change-tracking": "^1.0.6",
      "@cap-js/attachments": "^2",
   }
   ```

3. Install the required dependencies:

   1. Open the root folder of the project in the terminal and run the command `npm i`.
   2. Open **app/incidents** folder in the terminal and run the command `npm i`.
