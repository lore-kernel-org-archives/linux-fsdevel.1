Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795291513;
	b=IdvuqWPczHrfZRnol3veE6sMcqdEXAecIwt7MDPXJ5G1ctab2/25Qjj2TX+IY0SpBIMU
	 oaGabahUpBqAxYFEwh/L8ote2WzgADxlZBPI2mHG54bnwIggs1/UYevXgxMs9pp79bhts
	 bk10ekfyovg5C5K2HcCgzVUsKWInnrTiZOpmmnmHDBZOo6pip8GXZMf4YxGxi72Wl5CgV
	 Ufpb7US05dwbQTyL1cbzDsi+A81+FtYwPdKa933mJUtXWoSswjm8X753UxBs2XD06RMcu
	 1nSc6YVasoBbzzH8/pyQbV7z5QNl0lKqdxd0MeLjW7SzYsmwR+71B7KgNM+d8omzyPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795291513;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition;
	bh=ngoeo79HLgeRgaUkRCnmHPzpUZv9Mu4Jctl1kpeEgPQ=;
	b=WwUPp2PIi5HtmbLzJ5w3/W+VhDyDGygiUGP0YU2C9icAw3/VaW3AHgrWtNsJN0N4Wp24
	 8e2ZfqV3iPdLl9EVo0eq3nhxtyrgMthcA87POioGmYIihTh6SERVi3++E0u5o3vKMHZsg
	 T92NgE1XV/YdqcBcJgR4PFOioTsQ1QYis0pAUsG+hEno25MEzAIf8Eg6mHbetq+4cGEMw
	 8rDqIWWio0lCIctkjuWHL+Za4sNrZWdGJq12CtkVjfKSPsneOQjn8c/2kaHccf+7eA2En
	 dkMWh+mlXHz/QIn+V0bpd0bU7dSOLMeI7VyiAsBJZSv1dS4CHcAJM5KBLScc/o5RGag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bofK24jx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9D8606A320;
	Sat, 21 Nov 2026 20:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bofK24jx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D531F000C0;
	Sat, 21 Nov 2026 20:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795291512;
	bh=ngoeo79HLgeRgaUkRCnmHPzpUZv9Mu4Jctl1kpeEgPQ=;
	h=Date:From:To:Cc:Subject;
	b=bofK24jx7J2HBfSGFWp8eSBfRa7QqaAQBN+xZ5bWQ0gzoh24m6HpOWk3UUxIqmYUH
	 UZ5zUSvf7fpS1Mnq42SZKImM3JCpX7SpC/5ezkyl7sbBQYuqQ0SmTfplbkDQbxrgzp
	 hC747IVAoZ5nomLJb41D8d+I9yTLZxj3utaGmwmSxAY9EzP3SQ2mrozbpDdlqwuwfe
	 H+33ciWB3yysgAr1VrjAMXQ3aRbYHhsEytGPfRKjC1SGG7TOZbBykrO9WHnin5JG31
	 bph9miq1e85x7FtoMoTimI+gZ+/RYDlyJOZ5DbBteFeJmkYfiiZA+KLkC8h0JIbfpQ
	 L2W5teP4lCXog==
Date: Sat, 21 Nov 2026 21:05:06 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Avi Weiss <thnkslprpt@gmail.com>, Kees Cook <kees@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] sysctl fixes for v7.4-rc4
Message-ID: <awH4Fh-XofdwwRqZ@hobbes>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="j6xpltppt5iq44hh"
Content-Disposition: inline


--j6xpltppt5iq44hh
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [GIT PULL] sysctl fixes for v7.4-rc4
MIME-Version: 1.0

Linus:

Tested locally (with sysctl selftests), briefly in linux-next and 0-day.

Best

The following changes since commit aebb7274476403040d582c61478df8f4a7bf9cd3:

  Linux 7.4-rc3 (2026-11-15 14:30:11 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git/ tags/sysctl-7.04-fixes-rc4

for you to fetch changes up to 9fcdf40e0d7c58478d88d3e1ca69fec8badda0fd:

  sysctl: Do jiffy / ms conversion in ulong space (2026-11-18 14:49:05 +0100)

----------------------------------------------------------------
Summary

* Fix sysctl jiffy / milliseconds conversion

  - Writing a previously read value "X" shall keep the same "X" value.
  - Remove truncation that was causing incorrect saturation of valid timeouts

----------------------------------------------------------------
Joel Granados (1):
      sysctl: Do jiffy / ms conversion in ulong space

 kernel/time/jiffies.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)



--j6xpltppt5iq44hh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmsB+XIACgkQupfNUreW
QU8cMgv/aHccRvArEAf0Z/RyYkbrdX+4b/A7AjLVU37qz1Gb74a32NWlDxQUGGXZ
1VBrVjrIiEySUd+abeElT8en5XaiMeZHg4EGJVnw8JHtidjf2HAIWj1RWDCxt8N1
h+KaxR3DdWzPotMCqDZ93FLL70dllTchGrkZsBYDqbgCX6ULL8sPhVdG7PvPkKfO
uU5OH17Az/ziCjZpuWLPFHiJeeztcDtuYcoiNezTwByRYNhwrzd6p0qVLwUuG2RS
xs0gq8Ae89ugsz4vM3zMHp4bRJLIFyhM+a94R6XOP9Aw/LU/JFV1oVVNi3HPMjWE
SKtQVHlEgAlGcSnPD9U5ru7CKpJM+lnSGHER2oruSoyxvIjmo6Nq1hwaq5Yw0GMt
0Ig43Z6nvPOakC7cGgXZyBZEyu0VinKWz0w6PyyJ49c/FPrOyUza/B1v5Lpt4oEM
rirHciFJ51xsqSweVNDeQjGRSf4Pn6EfSpbwbWQ7HbpJJEpOvggZlSb5opsAyMQ5
CznkEjKg
=pdAU
-----END PGP SIGNATURE-----

--j6xpltppt5iq44hh--
