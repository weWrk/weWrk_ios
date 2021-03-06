<p align="center">
	<a href="https://github.com/weWrk/weWrk_ios/blob/master"><img src="/wrkbook_logos_green_Avenir_logo.png" alt="weWrk" width="300" height="300"/></a><br /><br />
</p>


# Group Project - weWrk

weWrk is a work related social networking platform for construction workers and companies, using the [Firebase](https://firebase.google.com) API and infrastructure.

Time spent: 1.3 months spent in total

## User Stories

The following **required** functionality is must be completed:

- [x] User can sign in/sign up to weWrk, using their gmail, facebook, or email accounts and sign out.
- [ ] On signup, user is asked for information related to their work history, who they know, interests.
- [x] App remembers signed in users and settings across app restarts.
- [x] User can see their timeline page, job applications, and profile page.
- [x] People, jobs, companies, can be searched, and viewed. 
  - [ ] User can apply for a job.
  - [ ] User can see job location using map api.
  - [ ] Users can rate jobs they have completed.
- [ ] User can manage their profile page and edit things such as their profile picture, contact info, experience.

The following **additional** features are implemented:
- [ ] User can be notified of any messages or events happening in the app.
- [x] User can create a network of contacts whom they know, and follow them.
- [x] User can have message conversations between companies or other users.
- [ ] Profile page has layer animations on user pull down and scroll.
- [ ] User can see job detail recommendations.

The following is the Database schema:

users model:
- displayName: String
- email: String
- id: String
- profileURL: String

jobPost model:
- category: String
- company: String
- function: String
- jobDescription: String
- location: String
- photoURL: String
- timestamp: String
- title: String

messages:
- MediaType: String
- date: String
- senderId: String
- senderName: String
- text: String
- toId: String
 
userSiteImagePost:
- imageURL: String
- sitePostKey: String

userProfilePost:
- Description: String
- Like: Int
- images
  - url1: String
  - url2: String
- postBy: String
- postUserID: String
- site: String


## Video Walkthrough 

Here's a walkthrough (tentative) of implemented user stories:

<img src='https://github.com/weWrk/weWrk_ios/blob/fix-feedVC-Jose/weWrk%20Video%20Walkthrough_1.gif?raw=true' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Wireframes
<img src='http://i.imgur.com/kbfiY5r.jpg' title='Wireframes'/>

## License

Copyright 2017 weWrk

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
