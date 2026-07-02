Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113EC2DFA2F;
	Thu,  2 Jul 2026 11:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782992128; cv=none; b=gjJmR/84NhqIsk2H+nqb/qe/W66pmElFXHenHYqHsMWDd4x93sl0aHO/jckkOu400Xx8LfAGKbiKqWksgukC+ict32RXBhZRCc4yqQh9FIALACEeFXl3aIcUQTh/RnsKxnxHNVe78GcfVH0AMrls4wmTQwieMzel6cgf8YCUjDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782992128; c=relaxed/simple;
	bh=BjcbYXCdqTJh939WrQc12HPWeFxIa/Kkv7EJRbyw4io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qemALQUsnujNe5SdlpI6J3Qc7O4bgBZ2U7Ii7lgX/EPK5F57PRxGVYoBTSkWgKdAhwg+mE3IBAy1rYk1wSEXsfdJfc3rX96iZXti7m9sxc2GQxudtPIyjHMPv9yepbbdOojnRyybMSRa7hmlenvMZWipAoOpPmm8zL+gtrXVhyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZ9sQXtl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZ9sQXtl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 796751F000E9;
	Thu,  2 Jul 2026 11:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782992126;
	bh=1pwM7n/u2kSrUcdJ3ZFWmOq97lL6l2O1hk/UECX/G3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JZ9sQXtl0aUwgKc+Fyi2RMXNroekDcgK/ccnd6JmVRI0ZoTIk/uZd2LDbl8KC8nKR
	 1X6Er47uoqiCfDq5hPRaYHEQ2Ch4XoMcyvAVaaoiryX0BgTcIEeO/oDc1YsOngTyPB
	 O0peHKxUNOu3bKJR/nFdGrRVvTRoqgTjqqdEdDrvlgk1EETnuojhg6TEXJjeu0qYnG
	 HNvN1NhWR9SmfgncJ00giCdh8aaFnTRD9ybG40aOIthYTTWP6Yk25Wk4lZPIji5FXW
	 EqKImlv5U5TTA536o1IIbDWjkntd3IdJ/Waj7yvTVtC9GqZDKNr+7BPi8NgJbonxjs
	 +CBQXDtKQKHeA==
Date: Thu, 2 Jul 2026 12:35:21 +0100
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
Message-ID: <5272cc4b-262a-4efb-9b99-50ea61695c93@sirena.org.uk>
References: <20260701-work-coding-assistants-v1-1-a20a94d1d606@kernel.org>
 <70c1d2eb-a1ae-441c-91d4-1c5113b131aa@sirena.org.uk>
 <20260702-ehebruch-dromedar-anbiedern-1116154f96dc@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZVvYCLokbOAFQKm9"
Content-Disposition: inline
In-Reply-To: <20260702-ehebruch-dromedar-anbiedern-1116154f96dc@brauner>
X-Cookie: Reactor error - core dumped!


--ZVvYCLokbOAFQKm9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 02, 2026 at 09:10:16AM +0200, Christian Brauner wrote:
> On 2026-07-01 17:08 +0100, Mark Brown wrote:
> > On Wed, Jul 01, 2026 at 05:54:48PM +0200, Christian Brauner wrote:

> > > And it reamins unclear to me what exactly we do get out of this detailed
> > > information: Do we want to run statistical analysis on what agent and
> > > model is used the most and publish that on LWN at some point?

> > IIRC it was literally this, have people mention which tools they used so
> > we can use that to inform our assessment of the patches.  I'm not sure

> Forgive my candor but I think that is just useless for us. It's
> certainly useful for AI company statistics. If we want to provide that
> service I would recommend we start charging. ;)

Yeah, that was more an observation of fact than a comment on value.
Certainly now we're able to see what things look like in practice.

--ZVvYCLokbOAFQKm9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpGTPgACgkQJNaLcl1U
h9BE+gf+JMNLfzqoTw7wcTvxlFAC5AO9SVbqT1cv2BzgFdmmhKjGTONSe+maIxvZ
YdEqzg7mrtYPvAoMFtKIP4loTDmrs318k90OI4MZJ7YI1kqNbubn0HYBapp9fBt/
EqWzjxnu8RjHDcQlh5352PhoDHXd4k/zTPNJD8A45WuFZ85+LB7e/h+7b87/YiqG
wyWU55zkUhBQ8cs81+boDRefZiv3OZbG7nu++gU8J8NnrobQ1MpPo/mGtKGsoDEm
L47pSlCPDj1+YeJg7J83U2M8Wfc3qvYbnN1ZH/nPFdZ49cYsKJXoXK1JCmel4KOL
g1suEVOs5xFlxCE7BzSItiSZz6Xe9A==
=qEt3
-----END PGP SIGNATURE-----

--ZVvYCLokbOAFQKm9--
