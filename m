Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85C233CEB4;
	Wed, 18 Feb 2026 10:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771408804; cv=none; b=RtcjZrKwU/ujumWH0mB0ODQFxjcFdCACLrRx7Ckf25MuwKqYy4vfzKqlrSi3vEJGVUtpEZobLbBTZ2L2BnoQ9C2GeI2tGRSBj+9IcTXxC+H9mspS6DUNqlQO1SRF4zbemks5eMtWyT0NIoxldyA/TyBmsayYKEFeKxHz58mOtSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771408804; c=relaxed/simple;
	bh=uX2lW6MbnfWchiey8c/EMDAtA9/Gv/JQOMvUJGK42Tg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cpQ/yTtLK2ajNnV4QVsJNFpxgxxo0mlflFY/VVulxNYG7FaiHU1/KnWzZwJUHbnnN5Xd7BA9K8tAYKo+SBYxoL9BJv7MM9ZzMVEvJTIlx+0bTqd/UUmOugT8sWCbtOX7ZT+jxP095HRJjLetRFcOGyC/rFqLL8uV51BRvx1z7sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBTV49xX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBTV49xX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4CCEC19421;
	Wed, 18 Feb 2026 10:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771408804;
	bh=uX2lW6MbnfWchiey8c/EMDAtA9/Gv/JQOMvUJGK42Tg=;
	h=Date:From:To:Cc:Subject:From;
	b=LBTV49xXFzZWOwCF/vpgZnYKY8ER6WEVq75NBMPQ52LOoOppSLs5kypMxPAfpnciJ
	 C9HHlYiRef9xlSPJ00l7xEqGNu01CU9TEB68fY0ykBIXAEQOLgVBD93mOwcnLa30dt
	 7q6hsTHIRi1tshkXqJXAzc0xYlmVdMV0IPRHcRO02r4QVN5c8PurneEv9/JHohtwOC
	 5LQqqF74WSFyB4+4crI0bNxV4E9agBIsVw8nYiwdgVLUNMt0Gv7tQaRg+CWTn3zTRd
	 cGN+AG8SDm1NJ5KHR+13eJdBL5AKVQXNcZIN4ZnSi14q4Ar5mJ0ykbKCoR3wGVcf1K
	 LzXnXH3VmQk/g==
Date: Wed, 18 Feb 2026 10:59:13 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <kees@kernel.org>, Petr Mladek <pmladek@suse.com>, 
	Jan Kara <jack@suse.cz>, Muchun Song <muchun.song@linux.dev>, 
	Paolo Abeni <pabeni@redhat.com>, Suren Baghdasaryan <surenb@google.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] sysctl changes for v7.00-rc1
Message-ID: <glab5jvehmpi6poog4lmsnai2ikkysnx2xrjqfizruuf63wvwn@7bsrznabpzka>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yoafj7qps4zppdv7"
Content-Disposition: inline


--yoafj7qps4zppdv7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:

  Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git tags/sysc=
tl-7.00-rc1

for you to fetch changes up to d174174c6776a340f5c25aab1ac47a2dd950f380:

  sysctl: replace SYSCTL_INT_CONV_CUSTOM macro with functions (2026-01-06 1=
1:27:10 +0100)

----------------------------------------------------------------
Summary

* Removed macros from proc handler converters

  Replace the proc converter macros with "regular" functions. Though it is =
more
  verbose than the macro version, it helps when debugging and better aligns=
 with
  coding-style.rst.

* General cleanup

  Remove superfluous ctl_table forward declarations. Const qualify the
  memory_allocation_profiling_sysctl and loadpin_sysctl_table arrays. Add
  missing kernel doc to proc_dointvec_conv.

* Testing

  This series was run through sysctl selftests/kunit test suite in
  x86_64. And went into linux-next after rc4, giving it a good 3 weeks of
  testing

----------------------------------------------------------------
Joel Granados (11):
      sysctl: Add missing kernel-doc for proc_dointvec_conv
      alloc_tag: move memory_allocation_profiling_sysctls into .rodata
      loadpin: Implement custom proc_handler for enforce
      sysctl: Remove unused ctl_table forward declarations
      sysctl: Return -ENOSYS from proc_douintvec_conv when CONFIG_PROC_SYSC=
TL=3Dn
      sysctl: clarify proc_douintvec_minmax doc
      sysctl: Add CONFIG_PROC_SYSCTL guards for converter macros
      sysctl: Replace UINT converter macros with functions
      sysctl: Add kernel doc to proc_douintvec_conv
      sysctl: Replace unidirectional INT converter macros with functions
      sysctl: replace SYSCTL_INT_CONV_CUSTOM macro with functions

 fs/pipe.c                  |  22 +++-
 include/linux/fs.h         |   1 -
 include/linux/hugetlb.h    |   2 -
 include/linux/printk.h     |   1 -
 include/linux/sysctl.h     | 120 +++----------------
 include/net/ax25.h         |   2 -
 kernel/printk/internal.h   |   2 +-
 kernel/printk/sysctl.c     |   1 -
 kernel/sysctl.c            | 290 +++++++++++++++++++++++++++++++++++++++++=
----
 kernel/time/jiffies.c      | 134 +++++++++++++++++----
 lib/alloc_tag.c            |   5 +-
 security/loadpin/loadpin.c |  37 +++---
 12 files changed, 437 insertions(+), 180 deletions(-)

--=20

Joel Granados

--yoafj7qps4zppdv7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmmVjWIACgkQupfNUreW
QU9P5wwAlRKA7oS2PSYReoTLNBAWKbV+gnuN0jsQ5nkSeTiiDQFNvhGexsebB/RU
+72U3UTiv3OM6fY6rgVxqv4gtUmHYmSQOjvqcrqN6NFYyUN5Ri/xEXaulSweWjr/
6kdgPn5LzKxpMLXdScmN8doQDP31dRbugFGnNx1dak3ezeIrSKavta6PWx6XSkkq
wKrfVYYr1CR6yA20ePlhfoWskrvTpgTTND0rW6tZKssDiL73z1yyqLbb88YuRrON
JEsKUY37xP/RcNuCsve0xVIC5IQriPJi9HUEsV+OzgA6dY2nWAaWrQ5WQGdMdsyZ
Pk0S9+gzyK1eC7G25dqNHYlT+M4XHziWaInfrD1MyN8G1JW9URHqPdLxC4dpZwxW
GxRTRS69pz4t1CsOoZjMoP+7mcrCkrE41lxnK6VvWG7IDHZf4AhPF6uFrKL0Dy09
L58jzimb6CM9zo4AZTIGzfddC98RcH8oYMhANyhVq1zR/mCdEvjxzCQZQ34+xIB0
bZwbQvqb
=OASi
-----END PGP SIGNATURE-----

--yoafj7qps4zppdv7--
