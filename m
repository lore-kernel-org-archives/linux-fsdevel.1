Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0DB14D719
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2026 20:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773865023; cv=none; b=Cd27pphCvfC3eoIOu2bWyJglRiSD5C0/BaSHH2zBcUbiP1jFLX3YtD/Q4Xoq/p8SnFODe/qZah2steOzSTAKS4OvJKDjX0WZIu6t67UlMOtKLS/tvGruP53q4i51XIwwLAkQSwirLr7wuGdRpgi9lxyyAqOXBXr2Pact0V2zXos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773865023; c=relaxed/simple;
	bh=1/ui9cmZzJ8BKHMFNyCejoULoUXQ4EFDB4Roxnd8gNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUpq9KpTVQl3yedpqw9rN/4B2sPnln8mOndU906ammxSy8AwxcvYMuc86pvr+9Ytq3s9rLxmoIwpzSTAUdLgVwpVjwbMMKjhOslHmGSz7UNQcOw5weL+QxIVWhzzY66xU3frmkWymg+Wolc/dnC4v9YUd5cWpVqe/zME3Uy7dEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qVEeU4nc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qVEeU4nc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC683C19421;
	Wed, 18 Mar 2026 20:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773865023;
	bh=1/ui9cmZzJ8BKHMFNyCejoULoUXQ4EFDB4Roxnd8gNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qVEeU4ncRvRG6HC2IWxCqTueW0q3kKdm3K29CpQpfn8kXs67+YY9lMdNcxrWjtW4F
	 ifFquVZ9IuzHDlDirL3W0AgWMQQuzLqk1TgPaqX04lhFp5IFlTYpWPhpPzspNqVj2/
	 K4N1yKLPtwsWf0O3E+HY7ucqmLg0BTaJTFKNrFUjXSzEVDq8rWqHJMga9Mt2wLP/J2
	 AUGsG5mnxOx7Y+OR2epa6hDndKREvRvcZqlUx9IgELWTb/4lTNmM+j1Rg4tjtUJGKu
	 uCLL1+qGcAAts045OX0jnixIOCb4gqXSarHOu1RUe9xEXTIg4HxIwDmhmLn9DgKgjE
	 X8Najp8MovjdQ==
Date: Wed, 18 Mar 2026 20:16:58 +0000
From: Mark Brown <broonie@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [PATCH 3/7] mount: add FSMOUNT_NAMESPACE
Message-ID: <b884608d-a719-4551-b8a3-e469a4e3570b@sirena.org.uk>
References: <20260122-work-fsmount-namespace-v1-0-5ef0a886e646@kernel.org>
 <20260122-work-fsmount-namespace-v1-3-5ef0a886e646@kernel.org>
 <ad810bc9-5755-416b-a810-5c1019b85b76@sirena.org.uk>
 <20260211-eurem-rinnen-3569a208531b@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZJ9xKgCJ7cPdC61k"
Content-Disposition: inline
In-Reply-To: <20260211-eurem-rinnen-3569a208531b@brauner>
X-Cookie: Bo Derek ruined my life!


--ZJ9xKgCJ7cPdC61k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 11, 2026 at 01:13:17PM +0100, Christian Brauner wrote:
> On Wed, Feb 11, 2026 at 11:47:39AM +0000, Mark Brown wrote:

> > On Thu, Jan 22, 2026 at 11:48:48AM +0100, Christian Brauner wrote:
> > > Add FSMOUNT_NAMESPACE flag to fsmount() that creates a new mount
> > > namespace with the newly created filesystem attached to a copy of the
> > > real rootfs. This returns a namespace file descriptor instead of an
> > > O_PATH mount fd, similar to how OPEN_TREE_NAMESPACE works for open_tree().

> > I'm seeing a regression in the LTP fsmount02 test in yesterday's -next
> > on arm64 which bisect to this patch, the test reports some unexpected
> > successes with logs like this:

> Thanks. This is postponed until next cycle.

The patch is now back in -next and I'm seeing this issue again on 32 bit
arm:

  https://lava.sirena.org.uk/scheduler/job/2577791#L5864

and arm64 too:

  https://lava.sirena.org.uk/scheduler/job/2577791#L5864

with bisection pointing to the same commit.

--ZJ9xKgCJ7cPdC61k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmm7CDoACgkQJNaLcl1U
h9Cxfwf/TW8W9bDoGCUgHKOF1sT6v+rF/HIAj5ZvvZEwMr8oJ5HQ3NTopeSFkhoH
2bLQkSK6Wap1ElRc8qNB1DUi2ElcC5F30oTZycoA6SPvo8wJEvqX2rkEd1iFmk5G
He9AfuBV85Mfay0aazqJ3GBgaEpaPGNoDyJ0UkOlDd78pHO0RIuSbeXrSpqbOZxU
cDU/DEWWaA5itUxhQ008MNGhz23JzG6b/zYfpZrl4KymHW2GGvFNDjxQ1CZcvWFn
tzi4rBWyEOa2mQExee8wwpqaMPotZJUuhg6Q78hSoUPm8sabPKTskjuZlIRh7NGq
32nriGcc4gM54HnjowK1LQ9hWtpQLA==
=j7Gz
-----END PGP SIGNATURE-----

--ZJ9xKgCJ7cPdC61k--
