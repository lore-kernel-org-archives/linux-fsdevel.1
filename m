Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F74F3C061D
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Mar 2026 14:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774015450; cv=none; b=Lo+hsvjL8WUxQWMnx3Dx/P/5PzvqWswFCftRLWOndwUCmFa++RWL4iUQ0OU1XRWrmY248Jw00kI3axb7MpVmk4Fq17Z2kGVlsqUGFGfF7HQlqGw04NuyN7Uu0Ncxy7zOOcKBi90QSD4UMLGDsS23cE5021mnAI8awUX8vu+gK+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774015450; c=relaxed/simple;
	bh=IFMQYaz/e/doHjYbFFKSJXvfTE1Rd/EacysSxkwsUWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TVQLm1IvGfI/k1N03dutpeqEdadxpIML+3OAqjp5bqwV8hNeF2YSB4CLJaP5LBZOo4TUZ9SSvp0dP7Fo0l5NAiPewEAZN1BlzPovSj1hhJojs4qB2QmtVWupr4gakt3JqSRzj+EOI935SuTkHLEFf92vzNQAn7eQ5zi/il+2tbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UxbeFOO1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UxbeFOO1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49129C4CEF7;
	Fri, 20 Mar 2026 14:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774015449;
	bh=IFMQYaz/e/doHjYbFFKSJXvfTE1Rd/EacysSxkwsUWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UxbeFOO1Yg4r915R1X7njEVhOeFXm72hPqWUtVVukf/mYnx6qlrPQwLPGo3BcK+CJ
	 Qdw71NJ98KmrE4y4zobwac7sDRUXoP7krmtYfdUn1Rs65qrhHVVzZdD4yYdRuY0jQt
	 Iw/ZFxfWa+r5+n2g5eObo1naRbmxosPQ2YEg4/5xLtdxn6W7GOz8Wmu1T88u67W0Jw
	 +A/LJ2yWOxWo2uKh+qhZ/f1q1i7UB6YPp7APQknLDc2C1q5sVMZ5MTTphikY2I8eKE
	 lXqHo2RB+LlaRt8FetbuDQGHpS0dTnVk3/tfpG0yRFIHdT7Dy55hCxXKU9FuDfQlZR
	 Ogx4ujH7sfE5A==
Date: Fri, 20 Mar 2026 14:04:05 +0000
From: Mark Brown <broonie@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [PATCH 3/7] mount: add FSMOUNT_NAMESPACE
Message-ID: <3a44923a-59ce-4f4b-a311-940bb361cb29@sirena.org.uk>
References: <20260122-work-fsmount-namespace-v1-0-5ef0a886e646@kernel.org>
 <20260122-work-fsmount-namespace-v1-3-5ef0a886e646@kernel.org>
 <ad810bc9-5755-416b-a810-5c1019b85b76@sirena.org.uk>
 <20260211-eurem-rinnen-3569a208531b@brauner>
 <b884608d-a719-4551-b8a3-e469a4e3570b@sirena.org.uk>
 <20260320-herkommen-jodhaltig-3d873a2e77dc@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pUGq9Z0YAvoLu0kp"
Content-Disposition: inline
In-Reply-To: <20260320-herkommen-jodhaltig-3d873a2e77dc@brauner>
X-Cookie: Who's on first?


--pUGq9Z0YAvoLu0kp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 20, 2026 at 02:40:59PM +0100, Christian Brauner wrote:
> On Wed, Mar 18, 2026 at 08:16:58PM +0000, Mark Brown wrote:

> > The patch is now back in -next and I'm seeing this issue again on 32 bit
> > arm:

> > and arm64 too:

> > with bisection pointing to the same commit.

> This isn't a bug in the kernel. This is LTP testing the value the new
> flag took to test for invalid flags. My advise would be to always use
> the uppermost bit or something...

*sigh* not again :/  Thanks for checking.

--pUGq9Z0YAvoLu0kp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmm9U9QACgkQJNaLcl1U
h9BTaAf/RtteMbzwquLfcy6jVwyusNzBgMX2mbT7JCLfkfUy6q2Tnrq7wZW86dlM
uh1etxjuxU/IVqt/Ku27XEwlks37GcqTl+JrUXYNCBft27DePujC/q/vbrShPUJx
ukVsBif0nUNaXoxAmJPWGc7KlqLYBjx9LFIVIyMyrsvYCfzB3H8aZ4jghpWz47bX
pngSWtrl8jjA6sww0l4Wa4lHPkLYz0MfO4hjgJK+R9wTfu76ewVpYhTs5sUgc10z
On0ZHRf361KE8fPf8d9GkXplI9eNQKodj9mJ/VimXuSC0xhkFmL67At1Dgz72t6l
PtBZSKKdySEzYaDE2MsFMPH43FGGow==
=5uwc
-----END PGP SIGNATURE-----

--pUGq9Z0YAvoLu0kp--
