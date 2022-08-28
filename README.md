CSP Hack
========

Exploration of how to make [Content Security Policy](https://content-security-policy.com) work with Seaside.

The current approach works with a combination of:

- A filter that generates a nonce for every request, stores it in the request context and generates a CSP HTTP header.
- A custom document that makes sure a nonce is added to every `<script>` element that does not already have it.

A custom script generator does not work since it can only add a nonce to `<script>` elements in the`<body>` but not `<script>` elements in `<head>`.  `<script>` elements in `<head>` need a nonce since the combination of `'self' 'nonce-'` does not work with Firefox only the combination of `'strict-dynamic' 'nonce-'` .


