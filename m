Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792501742;
	b=O1ziV7V7OYkyn9IKFTiCANzIboEkRR2KHa5BX1dZ/wXDE0WvU36qaS0oxbe6Uo1eQrX0
	 hSSrjGcvKRb59Cdxudxa/mWY7J3Hw+PBhKBNaLVCz4YKxWyGb62EuVujjl8TJrbjRSk0I
	 X/bz4vTLlfMhSLr7ZPjSXQgVECUqr9quvH5BeKSXg5fm5S54CKStMaXUuAlFSZxTpJ4Yu
	 W2weklNdUXock9NzSOrDqQge7v6BmvcZaE/ngenAdsMYQeTmbHaJ0NF4/uYndNOaIxluz
	 nF/eez5WuT2NO3QkQTs0+U8S77lvn0/GKVHxPCP8iWQGHB0LEzSrKjW6ZiFFHcXWXeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792501742;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition;
	bh=MXZA+Lmi8mgt9fAKly3weduActwWnCMoJQiWHQCJQ80=;
	b=Ifxv/j69waPB390yeHqsa05/SR3MIWWI2iZWrJB6UQ1ek9uDFgDnwH/6WXEXy00ax5NP
	 PV+yyTHwPAg8L8iIA6l8/7s8KjsaUKj4jOduka4lJUt1mDeCeXguljCi4VRxL0or1RpkE
	 mY7byAgqcGXEacU8RI87n0UxQhInuba86ZnfUoI8vlA/cl8Q/Ogs1/LoNOsai2ME3n/Ev
	 YAL+rA1hNX3zpqcI2ScbmUhF/Dzxn0V1TWzG+KsTwG/WswjbF8oSrJ5aKnbYPXASO1OIZ
	 Nk7Jo4F0AVpNlv+vL150Yb5UixkpNloHIfyuxBprQxakT14W1xuO2/dJkoPOvkbW5dA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZoZIxgJZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F38A606A327;
	Tue, 20 Oct 2026 13:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZoZIxgJZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CB091F000C9;
	Tue, 20 Oct 2026 13:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792501741;
	bh=MXZA+Lmi8mgt9fAKly3weduActwWnCMoJQiWHQCJQ80=;
	h=Date:From:To:Cc:Subject;
	b=ZoZIxgJZ1nXM1AeTfT1AwpHlQYyOFN64RifBrxD+cc06hk10IIKjkx+Z0XzBBhkay
	 GPWDJi28TE4DcuHNPWIZDnfwXSej81otMWFQaiTVMcZasN08S70AdtW97sQXDzzVpn
	 FcHwCUc4aUWreY8wsCy78/+xQY3ZiL2wq2mjushKnLHfcSFUjo/5Au0LGkSgAMibLM
	 MhUKHGt6+grWIoT+3hvtiQtsWxGbiVU2rEsXfjXiGvWIb0vfbq2JQRcwKPxJHwtzLk
	 mRuvkbahRYmMwRtlcKWw7P3UCOLXVzHrOo+byTsiuAEsMRIWGg6wP/drXniYsk2kaM
	 29fgdom85SSnA==
Date: Tue, 20 Oct 2026 15:08:55 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Bradley Morgan <brads@mainlining.org>, 
	Ethan Nelson-Moore <enelsonmoore@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Yibo Tan <lhfff@tju.edu.cn>, 
	Zhan Xusheng <zhanxusheng@xiaomi.com>, Kees Cook <kees@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] sysctl changes for v7.4-rc1
Message-ID: <atdn5xA9AZHAWNsM@hobbes>
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
	protocol="application/pgp-signature"; boundary="7di5a6a4566sitx3"
Content-Disposition: inline


--7di5a6a4566sitx3
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: [GIT PULL] sysctl changes for v7.4-rc1
MIME-Version: 1.0

The following changes since commit df2908090cda368b01ff43709f51890076c56157:

  Linux 7.3-rc2 (2026-09-06 15:07:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git/ tags/sysctl-7.04-rc1

for you to fetch changes up to 7b08e5851884e4ad207a6401b1dcffdb03d43c28:

  selftests: sysctl: Check the sign of a negative jiffies read (2026-09-25 14:00:00 +0200)

----------------------------------------------------------------
Summary

* Disallow partial vector updates

  Stage sysctl vector writes before updating. Removes the chance of leaving a
  sysctl vector partially updated due to erroneous input. This is not an atomic
  write; a concurrent reader can still see a partially updated vector.

* Remove redundant sysctl config guards

  Remove locations where (CONFIG_SYSCTL && CONFIG_PROC_FS) was checked. They
  are superfluous as CONFIG_SYSCTL now depends directly on CONFIG_PROC_FS.

* Rewrite selftests using KTAP helpers

  Each test now reports its own KTAP result and runs in a subshell. Test suite
  continues after failure.

* Misc

  Fix a use-after-free in the selftests test_sysctl module. Quiet an unused
  variable warning in fs/proc/proc_sysctl.c:init_header(). Add tests for
  partial vector updates and the int jiffies converters.

* Testing

  This series was run through the sysctl selftests and kunit in x86_64. It
  landed in linux-next between rc2 and rc3, giving the latest changes
  considerable of testing

----------------------------------------------------------------
Ethan Nelson-Moore (1):
      sysctl: quiet unused variable warning in fs/proc/proc_sysctl.c:init_header()

Joel Granados (5):
      sysctl: Split data conversion and file position handling
      sysctl: Reject uint arrays before calling the general proc_vec
      sysctl: Disallow partial updates for erroneous sysctl vectors
      sysctl: Add 0013 to test partially updated vectors
      sysctl: Rewrite selftests on top of KTAP helpers

Oleg Nesterov (3):
      sysctl: collapse redundant CONFIG_SYSCTL nesting in kernel/sysctl.c
      sysctl: consolidate CONFIG_SYSCTL into a single block in kernel/sysctl.c
      sysctl: remove redundant CONFIG_PROC_FS checks

Yibo Tan (1):
      sysctl: unregister tables before freeing bitmap

Zhan Xusheng (2):
      sysctl: Add jiffies converter entries to the test module
      selftests: sysctl: Check the sign of a negative jiffies read

 drivers/parport/procfs.c                 |    6 +-
 fs/dcache.c                              |    2 +-
 fs/file_table.c                          |    2 +-
 fs/proc/proc_sysctl.c                    |    2 +-
 kernel/sysctl.c                          |  459 ++++++----
 lib/test_sysctl.c                        |   33 +-
 tools/testing/selftests/sysctl/sysctl.sh | 1476 ++++++++++++------------------
 7 files changed, 881 insertions(+), 1099 deletions(-)

--7di5a6a4566sitx3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmrXZ+cACgkQupfNUreW
QU+GpAwAh0j8oNd6CI6bKJ7w937ctcgWTqQz2iSuDojBP2HsqDLsHXB0UuVgRRSL
4b9/78g8fMKAv63XyjhwrNzpk595QSXZJwgnYPbxAO4x7Z1cUXG0q0qTioiZ8jem
Ta45ly8Hl+of45MWv+RTW98qAf3h2dV5vemAiiHSaLu81Q1sSgZ0j03LLcbMwe6N
vkCA/WLJ89TUB4/sztQ0M7e4R/pzjjlIyvOZDO0Kcui3pa1U0vcygT+gSCt+MtAx
cMkSDf/yqUdKsaSGfpyqh8M+TddiGFq65F8DahEvCt/R8SpmSjQOWKce7AIvTt2t
wYxlIBEuHV08nXJcYYvJQaS9X+UC61zIOJpDl7ioD75DPaa6CjBh9SN6yEr7D4dP
NaHAtk12d3yKNM7yZNNTAcAYVq+nTMPO5cHocXAA9eyDD+j3NHJG9RPy7F1enOy6
9Xn0fRTCqJso14DzJeAxNFlTHenLSEi7/HkgrsqhtNA054lGpH1poSfZgJPv3cwl
0342Xap/
=Dhch
-----END PGP SIGNATURE-----

--7di5a6a4566sitx3--
