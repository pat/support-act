# Support Act

Musicians rarely get the support they need - and that's especially the case during COVID-19 isolation. Their royalties from streaming services are also _very_ minimal. So, Support Act exists to encourage people to occasionally buy albums (whether that be digital or physical copies) because that helps more money end up in the artists' pockets.

I have no plans for this to be a for-profit venture - perhaps there'll be space for sponsorship for hosting costs, but that's only if it becomes quite popular. I suspect this is quite a niche thing - but I guess we'll find out!

## Code of Conduct

This project uses v2 of the [Contributor Covenant](https://www.contributor-covenant.org) as its [Code of Conduct](CODE_OF_CONDUCT.md), and requires all collaborators to abide by it. If you wish to make a report related to this, please email hello at supportact dot app.

## Contributing

If you're interested in contributing to this project, I'd love to hear from you - it's best to create an issue on GitHub to discuss what you'd like to change/add, just to make sure it's something I'm open to adding.

If you do get stuck into writing/changing code, please keep your changes to a feature branch.

Please note that this codebase very much started as a spike to see what was possible. I'm not entirely sold on the structure of it all, but it's a side project, it has a test suite covering the main paths, and it works. I didn't want to let perfection get in the way of shipping something.

## Development Environment

You will need **Ruby 3.0.1**, **NodeJS v12+** (and Yarn), and **PostgreSQL v10+** installed already. From there, it should hopefully be a matter of running the following commands to get the app prepared locally:

```
gem install bundler
bundle install
./bin/bootstrap
```

Create a `.env` file in the project directory, and populate it with something like the following:

```
LAST_FM_API_KEY=last-fm-api-key
LAST_FM_API_SECRET=last-fm-api-secret
SENDER=supportact@test.local
SPOTIFY_CLIENT_ID=spotify-client-id
SPOTIFY_CLIENT_SECRET=spotify-client-secret
```

If you want parsing to work locally, then you'll need real credentials for Last.fm and/or Spotify. This will mean you'll need to create a developer application on their sites. If you're someone I know pretty well and don't want to go through that hassle, get in touch with me and I might be able to share my test credentials.

Then, to get the webserver running at [http://localhost:3000](http://localhost:3000):

```
./bin/rails server
```

Once you've got the local server running, you can also preview the email template that gets sent out monthly at [http://localhost:3000/rails/mailers/suggestions_mailer/suggest](http://localhost:3000/rails/mailers/suggestions_mailer/suggest).

## Licence

Copyright (c) 2020, Support Act is developed and maintained by [Pat Allan](https://freelancing-gods.com), and is released under the open MIT Licence.
