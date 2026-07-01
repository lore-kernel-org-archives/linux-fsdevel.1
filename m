Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B923451CF;
	Wed,  1 Jul 2026 16:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782922092; cv=none; b=ceWiExLMZrUlurLrvBkPhF3WGdu8rohnTnLMy0AeXyZcBdwsv8w+0aeenRhjZuhtcM8oWI1mnkrOhAMxVARXKyT8yYDhCEACGJc/k+ZldXKTmdrLqii1aD60KpfHyP4mOAqCMuN/USqmdXuvHep1KTcoHp4xIhsHKloQPcaA7T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782922092; c=relaxed/simple;
	bh=GaSKOyBYLfYB+eAJxyypOqkk/xNzs722ACszt6J6UiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avZp1Nqc0gRopsqzNDQqIzSlOOrLsMYQbCVZOLYXhFHeexeV3Y7BAVngBRsoRm04+PdWRnHjR7YPklqlJuJk1BlAvZEsTR3hTvzWDYaEk6+7aIAyxSNMtWPu8zozyN6LSOissWyGxXNewzuydiMGcZuCIZGUmL3pNF7u3Do8i0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CuRDbTH9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CuRDbTH9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 673CF1F000E9;
	Wed,  1 Jul 2026 16:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782922091;
	bh=eYrWAKdwPbHbPLrL4wv1uPaPNKaEI0vQMV79ju55zNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CuRDbTH9jovQOUgb2bwRfbjuPL0WK3XYe9IOg4yc3lffTOI8OU4MSA1fHolHPjiBF
	 l3rZfwP3Ei9CdwdO3g2E1KYCHuKQKM7UOvU0POQClLtNfhFlKTQVnCDMYieRhH4Ner
	 wB7xKJeUwMAtDzlh5nNaoZ98AtGvqi3RgdDHE3hizqAtnE7elDigkQvJsLD/NX1+Ms
	 SvLgGLtIYGSRbX+bdlYoAnGdiThHMn30/7vcFngVjlwOvDZTPe4W/LFKPS9s0ThN88
	 EdNWlOpa3kYwkjiAu9xGesnDxVrH709yWz/yAyPqxVwWZQntCHuOq2v/fG78nEtxRi
	 47yugC+M4FhxA==
Date: Wed, 1 Jul 2026 17:08:06 +0100
From: Mark Brown <broonie@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
	David Hildenbrand <david@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC] coding-assistants: simplify attribution
Message-ID: <70c1d2eb-a1ae-441c-91d4-1c5113b131aa@sirena.org.uk>
References: <20260701-work-coding-assistants-v1-1-a20a94d1d606@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LoF85GzbnidZ//Vu"
Content-Disposition: inline
In-Reply-To: <20260701-work-coding-assistants-v1-1-a20a94d1d606@kernel.org>
X-Cookie: Do unto others before they undo you.


--LoF85GzbnidZ//Vu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 01, 2026 at 05:54:48PM +0200, Christian Brauner wrote:

> And it reamins unclear to me what exactly we do get out of this detailed
> information: Do we want to run statistical analysis on what agent and
> model is used the most and publish that on LWN at some point?

IIRC it was literally this, have people mention which tools they used so
we can use that to inform our assessment of the patches.  I'm not sure
the differences we're actually seeing are tool based rather than
operator skill though.

--LoF85GzbnidZ//Vu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpFO2YACgkQJNaLcl1U
h9AqhAf/QMn6VvVhqzbxSsM4WdYRZ8E7RIGxyrLwcQd4khr7b4SqovCteJPEGlu8
qLH0WiQW8QF6+X6nBXDYu2qJ0ZpSY2dq1nh/HWAsI9Pt0mK7QEwd1TmqroiV2C9r
d5iIKcvNex/ZVwRN5ZWF6O1wp5jVX56HxkuJCq4ROcdZtUzXsU0mFUiVcYYKv2Oq
zbr/smkLE5LErwP7+fvsU+RF2p2765jZdYgL9wm+SMg+9sEkFNcieeTPn+XwgkoS
xfb1MfTX/IO+Ht58Ns73GFHbyMhJ5GSeVIiGLBhUCiWRnnFTDfoWZtskHWZDWi3L
IuhwMTwuZGlBQITvHzo7MW1uBEgX2A==
=yWSO
-----END PGP SIGNATURE-----

--LoF85GzbnidZ//Vu--
