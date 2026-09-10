Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE7A3BBFB6;
	Thu, 10 Sep 2026 08:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789029500; cv=none; b=qtfLGrTmJx7cKxcGds3Y8FRz+QJuoa7QdTNVGS1MA3CTFnChH2lmumN83VElUx1SySviOGlzSPyAo8mi0qT9PfpE0xzHmXTmk0PTgRehobNiJwCAh0tEIWDEJFyARYG2AXu3XVd/o3mBM2Tpl2oamCs46Yc+DIk5hsCELk4bJWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789029500; c=relaxed/simple;
	bh=lygJJpzlqT4Z6yEuMq05SHLQSen4aDw7f2iMBLW1mEg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=s/tdPGk6XVx7SYwrawoHqqAyThaX8nKmiO3t+uWrp+X0AalNrTpbzM9ThQ6VcFqIWCX6ozM8pcpOM+27DX6ZwRJWHBqOmEdzodx8J1CMUBSgz2OtTrUVxpUR3KSipRHnz9msnoLNdLC8lTkD28UFZAfMSRmSEdqGG8mZCzeo8ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E16Px04i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E16Px04i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE891F000FF;
	Thu, 10 Sep 2026 08:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789029498;
	bh=od70uk8YuyRZg30iWu9bkVRGGja46Xc2qik6vdakHAk=;
	h=Date:From:To:Cc:Subject;
	b=E16Px04ihprLQqfUXL6AlzyQsqvV6u7064gr/DMD/QnTQBDiGTDgV1uebFKSmglvI
	 c8MmT9p5GSt8kxCDoxuf3xDp8btnaKq+jcpC6vT0or42K5KWAAx6CJ8fFgJdsfGibS
	 mHe6hUgoI5r3AJ9qkHfietB2Rx0IlTC0IiXJtCASJ76Uz7PgrhvnrCONxFbxP35Pmk
	 TGpti17kZNbflWAwnPc3ThCko0F3WDs/Yrs66zcia2Xc6nWAduJHrgSP59wxLBXFFO
	 N0t/Aa7QZk+2HnCMrSXQoQxGFdAEOPujF0uhCV5VCMMl55Kj1/iOA4I9QMjxNOQTDu
	 PI1sE/eVLCIaA==
Date: Thu, 10 Sep 2026 10:38:12 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <kees@kernel.org>, Bradley Morgan <include@grrlz.net>, 
	Karl Mehltretter <kmehltretter@gmail.com>, Oleg Nesterov <oleg@redhat.com>, 
	Randy Dunlap <rdunlap@infradead.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] sysctl fixes for v7.3-rc3
Message-ID: <ioe66sxd6x7ku7sghm4tdq5i2fhh2jfanhsb7wvsqjc5gjq6vq@3r5v7mcphc6s>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n3oqgsadzwn4tyqn"
Content-Disposition: inline


--n3oqgsadzwn4tyqn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus

This fell through the cracks during the latest merge window. There are
no more CONFIG_PROC_SYSCTL after this fix.

The following changes since commit df2908090cda368b01ff43709f51890076c56157:

  Linux 7.3-rc2 (2026-09-06 15:07:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git tags/sysctl-7.03-fixes-rc3

for you to fetch changes up to 353a95f1cd8da8a5436a3f070be07d2f484486cd:

  syscall_user_dispatch: Use CONFIG_SYSCTL for sysctl guard (2026-09-07 14:00:56 +0200)

----------------------------------------------------------------
Summary

* Replace CONFIG_PROC_SYSCTL with CONFIG_SYSCTL

  CONFIG_SYSCTL is the config string that controls sysctl subsys.

* Testing

  Ran through x86_64 selftest. Skipped linux-next for this trivial fix.

----------------------------------------------------------------
Karl Mehltretter (1):
      syscall_user_dispatch: Use CONFIG_SYSCTL for sysctl guard

 Documentation/admin-guide/sysctl/kernel.rst | 2 +-
 kernel/entry/syscall_user_dispatch.c        | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)


--n3oqgsadzwn4tyqn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmqibHQACgkQupfNUreW
QU9g1Av/exzpU3gsFHq+L4zPgOFq7Fs9gkTfUXPa36QAEDIM0EQyvd8wRViHHeBu
R3B6nMyd3r+n8wH/FiUfeSH2K6T4OBg1rSCgLSRg4TMYEoFe4CuVgfVV1HR1SSJu
NyYFRbrGJGur7sjytlMFPjBjJk1hsIf//kIWyfpBLbtXCV2iw26tInySQ39/NGRH
+Nd7kc5McOBbw8z5Gf09M7hD/PHs+DreaI1pUbUFg2FYzgHeQ3sv20Gqn7pyA4qi
gfj1KppJcAKccj93WfyditE4gmggJkpqeWJCf//HSysTCEKJOD4+AXRcDIL2BZCB
rkIfBFi6grHbcwQ+ouOHAq/8Otn+fCCiTtVMEb3T9YgfAXzWkm0fUVFSUjNj+00s
xbHtOAah/uSBptwdg5y/xpBKzpuTK3AURktG4kdCK2CwlTCH+KuzxF2zg0i3MDR0
xpa35jALtJqhu4s8Xd1B4QoW50r5hcoMOGESyaTioL3vv6hXwFBnspHCLVr6zc8u
gVtwj28l
=c4TW
-----END PGP SIGNATURE-----

--n3oqgsadzwn4tyqn--
