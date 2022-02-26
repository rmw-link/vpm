export get = (url)=>
  #console.log url
  r = await fetch(
    url
    headers: new Headers {
      Authorization: 'token '+process.env.GITHUB_TOKEN
    }
  )
  await r.json()

