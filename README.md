# Support Act

## Project Description

Musicians rarely get the support they need - and that's especially the case during COVID-19 isolation. Their royalties from streaming services are also _very_ minimal. So, Support Act exists to encourage people to occasionally buy albums (whether that be digital or physical copies) because that helps more money end up in the artists' pockets.

I have no plans for this to be a for-profit venture - perhaps there'll be space for sponsorship for hosting costs, but that's only if it becomes quite popular. I suspect this is quite a niche thing - but I guess we'll find out!

## Processes

Ideally, it's best to work in feature branches, as I plan to make the `master` branch deploy automatically via a CI pipeline. Feel free to request me to review PRs if that's how you like to work.

If there are questions, you're welcome to ping me via Twitter DMs, though it's possibly neater to have conversations via GitHub issues in this repo instead? Either's fine by me.

## Development Environment

You will need **Ruby 2.7.1**, **NodeJS v10+** (and Yarn), and **PostgreSQL v10+** installed already. From there, it should hopefully be a matter of running the following commands to get the app prepared locally:

```
gem install bundler
bundle install
./bin/rails db:create db:migrate
```

Create a `.env` file in the project directory (and contact me for the contents). Then, to get the webserver running at [http://localhost:3000](http://localhost:3000):

```
./bin/rails server
```

## Design Brief

I have put pretty much no effort into making the site look like anything. There's no copy, and the list of albums is super minimal. But here's a quick summary of what I'm hoping for:

### Home Page

A description of what this service is and why it exists, mentioning that it integrates with Spotify and Last.FM. Links to log in and/or sign up.

### Authentication Pages

* Log in with existing details
* Sign up with new details
* Request password reset email

### Account Dashboard

This is where the core stuff happens. If you've not connected a service yet, you can choose between Last.FM or Spotify, and then once they're linked, they'll be populated with the recent popular albums for the person.

We'll also want some general account management links here - the ability to change email address and password, and to delete your account.

I'm currently expecting the list of albums to be the focus - especially the name, artist, and image, alongside a link to mark the album as owned/purchased. It'd be nice if in the future we can provide links direct to purchasing locations - whether that be Apple Music, particular retailers, or even Amazon (as much as I dislike them, maybe we should err towards getting people to buy albums). I'd also like to maybe have 'Artist-Preferred' links - e.g. to Bandcamp (where royalties are quite good), or artist-managed online stores.

Perhaps the albums should be separated into owned and not-owned, so the focus becomes a little more clear? Though a single list is nice… _all_ of this is up for discussion!

### Monthly Emails

Similar to the dashboard, but more focused - a summary of the latest albums, with the purchase/mark-as-owned links.

If you've got the local Rails server running, you can view the current email for this at [http://localhost:3000/rails/mailers/suggestions_mailer/suggest](http://localhost:3000/rails/mailers/suggestions_mailer/suggest) (it uses the first account in the database for the template data).

## Limitations

In case anyone's looking at the Ruby code with interest: right now, this is definitely spike-focused code - I've not been worried about complexity, and only using Rubocop for auto-fixed layout and linting. There are not yet any tests, but that (and a CI setup to auto-deploy the master branch) are definitely on my to-do list.
