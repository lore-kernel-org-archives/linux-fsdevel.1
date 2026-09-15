Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE54F450403;
	Tue, 15 Sep 2026 07:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789457993; cv=none; b=ARv+iJdRZdnhDOPK/H5mpO+c2bAqufgatrE0YKNiVdH+FEt6c5ukRYT4FBAzzUbNS3GiklDAI9xi686fJovxk2PIDYDkeWyUKZB4+KQGodTdgZrQvS3sVxNqMdUi9AT0pTtLfp1PDc2VlZQsygOcCrzbM+gvbW8eFisiuLSOw6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789457993; c=relaxed/simple;
	bh=eIQIutOgahkxxdhnkUAtJlK1okbSL9RkmsvZqDtfryM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=h/iLCCH7W34Ksp9ysj22TowZamsFSGhzSK822TpomavsobjG9kJL1/DFnU+hjDIqtfeHhgSmUie4Vi74waw0NEmFwcIlBtypaZ0/Q+44puYdmVs83LD88iPP3t59RGp8mb2arP1b+UomeR7AMxHYmthMgYnHxW+Y2EH0o73tT4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVEBaiWY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVEBaiWY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F231F00893;
	Tue, 15 Sep 2026 07:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789457991;
	bh=JvcAoUbZMOn8OJPm6ppoTjLkSdU40HNDRClzHWhVvQ8=;
	h=Date:From:To:Cc:Subject;
	b=mVEBaiWYcpHci3mCb+10JCxqdCQYTZ1ytSehPv0cVHUKK3SBMZlDha646NwKI22cN
	 VDyFgrUX1qAMNpAGzSRRYnEJQhr+sPMuAN8yhSpAVQodmVIiaH0+j3KNwzJnknGX0W
	 /wWvqdkP6Olwi6MQB+N4jyXZn8stNkeVXX0e4pauF2myNBwIpioqugQHtEa9715ueI
	 SlG2zQbjAZl0wR5wzjY3A6QfiWwN6L6BBmRmV5hInCXOksAHGrz5FphytOGFvb82v4
	 mbIbseXseh9SftYVKS1AuXxCPUk2sY+qU/32zS/Esf+ctnSwvpZpWzro7i6z3rxrw5
	 nMQNyhEmb0cTg==
Date: Tue, 15 Sep 2026 09:39:45 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Kees Cook <kees@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] sysctl fixes for v7.3-rc4
Message-ID: <5cdnt4kemxnc453x2ri3z76enwfsoijyeleu5uewkwpib26wde@l63ympmpioco>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gcmyt4vcj3amfxx2"
Content-Disposition: inline


--gcmyt4vcj3amfxx2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit fd73f4a6659897191fa0d40695fe370925dd3780:

  Linux 7.3-rc3 (2026-09-13 14:38:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git tags/sysctl-7.03-fixes-rc4

for you to fetch changes up to afdf35cfae0d039a4a6c907fa5d8391f1ef0a0aa:

  sysctl: Fix type truncation in sysctl_msec_to_jiffies (2026-09-15 09:20:58 +0200)

----------------------------------------------------------------
Summary

* Re-add the range check for millisecond to jiffy conversion in sysctl

  They where removed in d174174c6776 ("sysctl: replace SYSCTL_INT_CONV_CUSTOM
  macro with functions") and b96b5c6708ea ("sysctl: Replace
  do_proc_do{int,ulong,uint}vec with do_proc_vec")

* Fix type truncation in sysctl_msec_to_jiffies

  Previously truncated millisecond values now get converted into
  MAX_JIFFY_OFFSET

* Testing

  Ran through x86_64 selftest. One week in linux-next

----------------------------------------------------------------
Joel Granados (1):
      sysctl: Fix type truncation in sysctl_msec_to_jiffies

Kuniyuki Iwashima (2):
      sysctl: Check range in  proc_dointvec_ms_jiffies_minmax
      sysctl: Check range in do_proc_ulong_conv_ms_jiffies

 kernel/time/jiffies.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)


--gcmyt4vcj3amfxx2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmqo9kAACgkQupfNUreW
QU8mhQv+JrS6+2U4FqtwCMsnZmEBWyuG93E8zee65AOzZprMsyPBqjOTkM9R4GQb
BVbFcQ6ZCiGbOABxWsajA5zt4iAApLpLC4GKsGZSa0BXU71cD648yLpSA7+ibkKL
//x2TybMJ+HY69zigPncou6yqe/iafukyxZ+zmZWzgC3KMOez6a+/b4YSq0LDr1S
LWpCZXYAXVXbNThneZxKB3ihZ27AYIiOvFNKQ678s1V7wQr71vky+FnSUunvoSDw
c26WhMBulPPIo3SBlqi5DvtvyyYvsSpP5o+VDsTgetHUoqEP7KJLM3ZzmTOn2oKt
gxQnChWOt/9+lACUcGm0sB9rQQVswdYsX5jf3P8T1dyIw07vOzXCzls2irS4Trwb
HWXKTA1480MydZCA+NkC/GlZ7N2ufvSXAGtIUgpyns2Vt0cKfwfn1vdmZqOJ4cuu
dHzqnuwnG9wVXd8Y5sIo2CmDtY1xBTFWK6OplrlEeHDsTScsLpO23TASe2VBvhcN
ARrAIDUM
=Q/eQ
-----END PGP SIGNATURE-----

--gcmyt4vcj3amfxx2--
