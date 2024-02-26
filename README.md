# BarrelSnap: Manage Your Barrels & Discover Craft Wines
**The project were written by:**
- [Yehonatan Friedman](https://github.com/YehonatanFr)
- [Hagay Knorovich](https://github.com/hagayknoro)
- [Daniel Scheniderman](https://github.com/dunisan)
- [Moshe Ofer](https://github.com/mosheofer1)

## Table of Contents

- [BarrelSnap: Manage Your Barrels \& Discover Craft Wines](#barrelsnap-manage-your-barrels--discover-craft-wines)
  - [Table of Contents](#table-of-contents)
  - [About](#about)
  - [Features](#features)
  - [Why BarrelSnap?](#why-barrelsnap)
  - [Getting Started](#getting-started)
  - [For Wineries](#for-wineries)
    - [Barrel Management](#barrel-management)
    - [Business Dashboard](#business-dashboard)
    - [Direct-to-Consumer Sales](#direct-to-consumer-sales)
  - [For Consumers](#for-consumers)
    - [Wine Discovery](#wine-discovery)
    - [Ordering \& Delivery](#ordering--delivery)
    - [Connect with Wineries](#connect-with-wineries)
  - [UML Diagrams](#uml-diagrams)
    - [Activity Diagram](#activity-diagram)
  - [Screenshots](#screenshots)
  - [Contributing](#contributing)
  - [Tools Used](#tools-used)
  - [Future Work](#future-work)
---


## About
BarrelSnap is a revolutionary mobile application designed to empower wineries and connect them directly with wine lovers who crave unique vintages. We offer a one-stop solution for wineries to seamlessly manage their barrels, from tracking inventory and monitoring aging to scheduling tasks and connecting with potential buyers. For consumers, BarrelSnap opens doors to a curated selection of exceptional wines crafted by passionate winemakers who utilize our barrel management tools.

## Features

- **Effortless Barrel Management:** Wineries can track every stage of their barrel journey, from grape variety and vintage year to aging conditions and scheduled tasks. Get real-time alerts for key activities like topping and racking, ensuring optimal barrel care.
- **Streamlined Workflow:** Simplify your operations with intuitive inventory management, task scheduling, and reporting. Ditch spreadsheets and embrace digital efficiency.
- **Direct-to-Consumer Sales:** Reach a wider audience of passionate wine lovers through our built-in marketplace. Showcase your wines, tell your story, and build relationships directly with potential buyers.
- **Enhanced Communication:** Interact directly with potential buyers in real-time, answer questions, and build loyalty through personalized interactions.
- **Unparalleled Wine Selection:** Consumers discover a curated collection of unique wines from passionate winemakers who utilize our barrel management tools. Support independent producers and explore hidden gems you won't find anywhere else.
- **Personalized Wine Discovery:** Leverage advanced search and filtering tools to find the perfect wine for any occasion, whether you're a seasoned connoisseur or just starting your wine journey.
- **Convenient Ordering & Delivery:** Seamlessly place orders directly from the app, choose your preferred delivery or pickup option, and enjoy exclusive offers directly from wineries.

## Why BarrelSnap?

**For Wineries:**

- **Save time and resources:** Automate barrel management tasks and gain valuable insights into your inventory.
- **Reach new customers:** Connect directly with passionate wine lovers seeking unique and authentic wines.
- **Build brand loyalty:** Engage directly with consumers, answer questions, and build lasting relationships.
- **Streamline operations:** Simplify your workflow and gain control over your inventory management.

**For Consumers:**

- **Discover exceptional wines:** Explore a curated selection of unique wines crafted by passionate winemakers.
- **Support independent producers:** Find hidden gems and champion small-batch wineries.
- **Find your perfect bottle:** Use advanced search and filtering tools to match your taste and occasion.
- **Connect with the makers:** Learn about the stories and philosophies behind the wines you love.
- **Convenient ordering:** Enjoy seamless ordering and delivery options directly from the app.

## Getting Started

1. Clone this repository to your local machine.
2. Install Flutter and Dart SDK.
3. Set up a Firebase project and configure authentication and Firestore database.
4. Update Firebase configuration in the project.
5. Run the app on your preferred emulator or physical device.

## For Wineries

### Barrel Management

- Track inventory, monitor aging conditions, and schedule tasks all in one place.
- Receive timely alerts for key activities like topping and racking.
- Generate reports to gain insights into your barrel data.

### Business Dashboard

- Manage your wine inventory, track sales, and update your profile information.
- Add new wines, update listings, and remove items as needed.
- View and manage incoming orders from clients.

### Direct-to-Consumer Sales

- Showcase your wines and tell your story to a wider audience.
- Interact with potential buyers in real-time and answer their questions.
- Process orders efficiently and communicate updates directly with clients.

## For Consumers

### Wine Discovery

- Explore an extensive wine catalog featuring diverse regions, varietals, and price ranges.
- Use search and filter tools to find wines based on your preferences.
- Discover new favorites by reading tasting notes, ratings, and reviews.

### Ordering & Delivery

- Place orders directly from the app and choose your preferred delivery or pickup option.
- Enjoy seamless ordering and delivery options directly from the app.
- Track your orders and receive notifications on delivery status.

### Connect with Wineries

- Follow your favorite wineries and stay updated on their latest releases and events.
- Engage with winemakers, ask questions, and participate in virtual tastings and events.
- Receive personalized recommendations based on your preferences and purchase history.

# UML Diagrams
We created some UML Diagrams for better understanding.

## Activity Diagram 
The Activity Diagram illustrates the flow of user interactions within the BarrelSnap application. 
It begins with the user launching the app and determining whether they are a registered user. 
Based on this, they either log in or register. After authentication, users select their role, leading them to specific pages tailored to either clients (consumers) or managers (winery owners). 
Clients can explore and purchase wines, while managers can manage their wineries and add products. Finally, the user's interaction with the app concludes.


| Activity Diagram                                                                                           | Start Machime Diagram                                                                                        | Sequence Diagram                                                                                          |
|-----------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------| -----------------------------------------------------------------------------------------------------|
| <img width="333" height="643" alt="Screenshot 2024-02-18 at 22 39 58" src= "https://github.com/YehonatanFr/BarrelSnap01/assets/118724971/74826869-1a5f-404f-b1e8-eb0d02b2f4ff">| <img width="400" height="600" alt="Screenshot 2" src="https://github.com/YehonatanFr/BarrelSnap01/assets/118724971/bcaea5b6-434b-4896-816b-78c772427311"> | <img width="570" height="640" alt="Screenshot 2024-02-18 at 22 39 58" src= "https://github.com/YehonatanFr/BarrelSnap01/assets/118724971/837c7740-82d8-4cf2-ad22-1b4d550dd2f5"> |


# Screenshots
| Our Logo                                                                                             |
|-----------------------------------------------------------------------------------------------------|
| <img width="700" height="500" alt="Screenshot 2024-02-18 at 22 39 58" src= "https://github.com/YehonatanFr/BarrelSnap01/assets/118724971/c3a3dbae-388d-4bf4-8685-949cc3c95574"> |
## Login & register creenshots

| Run The app                                                                                             |
|-----------------------------------------------------------------------------------------------------|
|  <img width="250" alt="Screenshot 1" src="https://github.com/YehonatanFr/BarrelSnap01/assets/118724971/ece2486d-6b56-4670-87d7-4195fdb82ea7">  | 


| Login Page                                                                                           | Forgot Password page                                                                                       | Choose Rule page                                                                                           |
|-----------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------| -----------------------------------------------------------------------------------------------------|
| <img width="250" alt="Screenshot 2" src="https://github.com/YehonatanFr/BarrelSnap01/assets/118724971/cfd18cde-803a-4897-9453-3c453dcdc398">  | <img width="250" alt="Screenshot 2" src="https://github.com/YehonatanFr/BarrelSnap01/assets/118724971/3da458ff-7161-41d1-98e8-cc7b3e4508d3"> | <img width="250" alt="Screenshot 2024-02-18 at 22 39 58" src= "https://github.com/YehonatanFr/BarrelSnap01/assets/118724971/76029dd5-ed38-450f-9246-c4c868c16269"> |



| Client Register page                                                                                           | Business Register page                                                                                       | 
|-----------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------| 
|  <img width="250" alt="Screenshot 2024-02-18 at 22 39 58" src= "https://github.com/YehonatanFr/BarrelSnap01/assets/118724971/20a2d8a1-196c-48cb-a319-538757ccaf19"> | <img width="250" alt="Screenshot 2024-02-18 at 22 39 58" src= "https://github.com/YehonatanFr/BarrelSnap01/assets/118724971/c0270729-455f-4137-846a-9e3abfce7410">  |


| In each user scroll option page                                                                                           | About page in each user                                                                                       | 
|-----------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------| 
|  <img width="250" alt="Screenshot 2024-02-18 at 22 39 58" src= "https://github.com/YehonatanFr/BarrelSnap01/assets/118724971/83d745a2-feab-48df-aeae-25417f4e5daf"> | <img width="250" alt="Screenshot 2024-02-18 at 22 39 58" src= "https://github.com/YehonatanFr/BarrelSnap01/assets/118724971/ef316aa5-65d8-4239-8412-2e75cf18a2bb">  | 



## Business screenshots

| Home page Business                                                                                           | Shop page Business                                                                                         | Order page business                                                                                           | Profile page business                                                                                           |
|-----------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------| -----------------------------------------------------------------------------------------------------| -----------------------------------------------------------------------------------------------------| 
| <img width="350" alt="Screenshot 2024-02-18 at 22 37 57" src="https://github.com/YehonatanFr/BarrelSnap01/assets/118724971/07b56161-c399-49d1-bc77-5255960b6e6c"> | <img width="350" alt="Screenshot 2024-02-18 at 21 18 32" src="https://github.com/YehonatanFr/BarrelSnap01/assets/118724971/3a4e4870-c962-4dd2-9003-d55a396f44b2)">| <img width="350" alt="Screenshot 2024-02-18 at 22 37 38" src="https://github.com/YehonatanFr/BarrelSnap01/assets/118724971/9ba00d9b-91b8-4fe2-83b1-b5d0a001a623"> | <img width="350" alt="Screenshot 2024-02-18 at 22 37 38" src="https://github.com/YehonatanFr/BarrelSnap01/assets/118724971/e1658935-fb00-464f-9edf-00a105db054d"> |


| Add Wine option                                                                                           | Update quantity option                                                                                         |
|-----------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------| 
| <img width="250" alt="Screenshot 2024-02-18 at 21 21 17" src="https://github.com/YehonatanFr/BarrelSnap01/assets/118724971/767d4f1d-8273-4b52-b858-43b9f7ed263a"> |  <img width="250" alt="Screenshot 2024-02-18 at 21 18 32" src="https://github.com/YehonatanFr/BarrelSnap01/assets/118724971/a47b5606-6a20-4f29-810c-81c15894fd6d"> | 




## Client screenshots

| Home page Client                                                                                          | Shop page Client                                                                                         | Cart page client                                                                        | profile page client                                                                                         |
|-----------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------| -----------------------------------------------------------------------------------------------------| -----------------------------------------------------------------------------------------------------|
| <img width="350" alt="Screenshot 2024-02-18 at 22 39 58" src= "https://github.com/YehonatanFr/BarrelSnap01/assets/118724971/80569906-8013-4707-9265-11db1746bd73"> | <img width="350" alt="Screenshot 2024-02-18 at 22 39 58" src= "https://github.com/YehonatanFr/BarrelSnap01/assets/118724971/8a0e0e16-1204-4c57-80f3-5079e0c00d83"> | <img width="350" alt="Screenshot 2024-02-18 at 22 39 58" src="https://github.com/YehonatanFr/BarrelSnap01/assets/118724971/b0ca1518-538f-4bef-8deb-b11217537ed7"> | <img width="350" alt="Screenshot 2024-02-18 at 22 39 58" src="https://github.com/YehonatanFr/BarrelSnap01/assets/118724971/1d92e6e0-79ce-4e07-ad84-3bfc0de251c1"> |


| Add to cart option                                                                                         | See wines collection of some business                                                                                         | My Last orders option                                                                                           |
|-----------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------| -----------------------------------------------------------------------------------------------------|
| <img width="250" alt="Screenshot 1" src="https://github.com/YehonatanFr/BarrelSnap01/assets/118724971/d9bb27e6-9171-4e66-9138-a0e9b89abc46"> | <img width="250" alt="Screenshot 2" src="https://github.com/YehonatanFr/BarrelSnap01/assets/118724971/7c48b53d-4273-4fef-a86d-a4d70183edba">| <img width="250" alt="Screenshot 3" src="https://github.com/YehonatanFr/BarrelSnap01/assets/118724971/179e9c37-a696-4aff-b386-5a2245b18c98"> |




## Contributing

We welcome contributions from the community to help improve BarrelSnap. If you have any ideas, suggestions, or bug fixes, please feel free to submit a pull request or open an issue on our GitHub repository.

## Tools Used

- **Flutter:** Framework for building cross-platform mobile applications.
- **Firebase Firestore:** Cloud-based NoSQL database for storing app data in real-time.
- **Firebase Authentication:** Provides backend services for user authentication and authorization.


## Future Work

- **UI Improvement and Optimization**
- **New Features/Functionalities**

