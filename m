Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F003932ED40;
	Mon, 17 Aug 2026 12:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786969028; cv=none; b=bhnzNrzfXeJmPlCHIhE69fysQeMGej9NqzxTZelFsFkTLuXUonfx/has2o3kSgaUFIfxT3ylfRuQpzrEgrrr5+k4voJ7dAKtrZsz3gFEICPxj0j6cAjIf1Op5+FFuwsyZkO3zldhXXgC+7+AiZfzh2dRsusCEld4cpuNIl8fkcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786969028; c=relaxed/simple;
	bh=K2RYr8Z3PJ+pOgINCGueHRskj65sPs3Ye7uqcmryPmo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LXTedYa586zyOnoKTb5V3X5ex2f1WEHDoGRgcHJidDB/jeOHLENrCrF5zZdz4b8kXLMldYwpFAXShx0uG5HehSx9DhnFLUpxH++2Fgb/r0CbcmRhr7gewB22CplR6yv+cajVDWrPZipNVX5wSNzL7gojI84MPdaSUobEz51DAIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kj6bRZD3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kj6bRZD3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DEDA1F000E9;
	Mon, 17 Aug 2026 12:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786969026;
	bh=1eO1OynMgCCSzEgAhCusmYL7KEnT46FPP7YuCwl3dk8=;
	h=Date:From:To:Cc:Subject;
	b=kj6bRZD33qGKI7iNlG56BVm8eJqX2fVIeP4c2c+Uv8ozYGGD+UyXL/WoeAWVc39tt
	 jT4VudbJMxYWt1kjB0D7rIJ57zJrm2sesDYE4Pbdo66kqzoQm33zL1mMOL5jiTGsvA
	 B0qWnh6gC2nJADq9ecUraFHEqA1CiBwtfnLSbXZ2sa3FrTcp/0p4vyfaYjhFrlxc5J
	 eL+KxLmaCWx0USrmVHfQfFaX5xfANRCJm0lt6TN64wg+9CnNNclay8y2AmmfLRB7Js
	 P5xtZxpdrVuK+DXOwpC5ayv8A7rnSQrKfwNF1YZeoM85rNldajeG88pH8/qBnr3FnX
	 WcKPJAC4hd/Mw==
Date: Mon, 17 Aug 2026 14:17:00 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <kees@kernel.org>, Alexey Gladkov <legion@kernel.org>, 
	Bradley Morgan <include@grrlz.net>, Oleg Nesterov <oleg@redhat.com>, 
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, Randy Dunlap <rdunlap@infradead.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] sysctl changes for v7.03-rc1
Message-ID: <zeiezeji5xxupnhdapw5pcsitpou7ysgzavigp3jnp5i2vhuik@zxklkd53i6gz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gkawtdox6l4a23fx"
Content-Disposition: inline


--gkawtdox6l4a23fx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 8cdeaa50eae8dad34885515f62559ee83e7e8dda:

  Linux 7.2-rc2 (2026-07-05 14:44:06 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git/ tags/sysctl-7.03-rc1

for you to fetch changes up to 8d75c338f0bcecaa6c9af67f86c176b67b6acf3e:

  sysctl: remove CONFIG_PROC_SYSCTL, it just mirrors CONFIG_SYSCTL (2026-08-05 15:28:23 +0200)

----------------------------------------------------------------
Summary

* Documentation

  Fix kernel-doc warnings by adjusting in file documentation.

* Consolidate do_proc_* function into do_proc_vec.

  Consolidate three slightly different implementations of applying a converter
  on all elements of a vector. Fixes to this function now propagate to the three
  types.

* Miscellaneous

  Replaced CONFIG_PROC_SYSCTL with CONFIG_SYSCTL (they were the same) and
  restrict cad_pid modifications to global root (GLOBAL_ROOT_UID)

* Testing

  This series was run through sysctl selftests/kunit test suite in x86_64. And
  went into linux-next around rc2, giving it a bit more than a month of testing.

----------------------------------------------------------------
Joel Granados (6):
      sysctl: Move default converter assignment out of do_proc_dointvec
      sysctl: Add negp parameter to douintvec converter functions
      sysctl: Replace do_proc_do{int,ulong,uint}vec with do_proc_vec
      sysctl: Group proc_handler declarations and document
      sysctl: Rename proc_doulongvec_minmax_conv to proc_doulongvec_conv
      sysctl: Update API function documentation

Oleg Nesterov (2):
      sysctl: move the "cad_pid" entry from pid_table[] to kern_reboot_table[]
      sysctl: remove CONFIG_PROC_SYSCTL, it just mirrors CONFIG_SYSCTL

Randy Dunlap (2):
      sysctl: add Returns: kernel-doc for all functions
      sysctl: repair some kernel-doc comments

 arch/m68k/configs/amcore_defconfig                 |   2 +-
 arch/m68k/configs/stmark2_defconfig                |   2 +-
 arch/s390/Kconfig                                  |   4 +-
 arch/x86/kernel/cpu/bus_lock.c                     |   2 +-
 fs/pipe.c                                          |   2 +-
 fs/proc/Kconfig                                    |   3 +-
 fs/proc/Makefile                                   |   2 +-
 fs/proc/internal.h                                 |   2 +-
 include/linux/sysctl.h                             | 131 +++--
 include/linux/utsname.h                            |   2 +-
 init/Kconfig                                       |   3 -
 kernel/delayacct.c                                 |   2 +-
 kernel/pid.c                                       |  31 --
 kernel/reboot.c                                    |  29 ++
 kernel/sched/core.c                                |   8 +-
 kernel/sched/topology.c                            |   4 +-
 kernel/sysctl.c                                    | 528 +++++++++++----------
 kernel/time/jiffies.c                              |  31 +-
 kernel/utsname_sysctl.c                            |   4 +-
 lib/Kconfig.debug                                  |   2 +-
 lib/test_sysctl.c                                  |   2 +-
 net/mpls/Kconfig                                   |   2 +-
 tools/testing/selftests/net/config                 |   2 +-
 tools/testing/selftests/net/packetdrill/config     |   2 +-
 .../testing/selftests/wireguard/qemu/kernel.config |   2 +-
 25 files changed, 451 insertions(+), 353 deletions(-)

--gkawtdox6l4a23fx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmqC+6EACgkQupfNUreW
QU8qDgv/VNzRaxbcsoQR/5OeSAT4yiv8tk6/0snXpcb/UcnlBUBBsjG1iCU4gHDc
8Qhsmq5E1K9U4hDJjkF9kOBpIlT6wl5NE3eIwK/LGwiovTMjZBAo5Jk+Hlon+ix9
TB4UofZTmgRoYsI95pf4Q7h3OcaSM2HkkJZ7QLpDZ5FS+i0rBxfs4Pni/b0P13U9
kZ+SooFMg46uc2Bl/J6OdIPoLn3o+rFR3Wn815iSPc2Jg/7MCl5DCxzXLPsCmG0P
LeTXUUW+wBaxYSbpiRbGGg3phuoCjvbeOmZxheOr1gGvetx2BMyJ4rY7P6u3jjIT
4KbWhvFr187cQrcoLqcEmh2QcJFx9EgBKvZ6nPWIL9Tw73k2AnD8ZzJR4GSxo+KJ
tnBSQqauxs9jyz3kkJzKS0jdYjq6MJl3ZmwIz4gzJmL8l2NRxLiUiANyVVYD+Ba+
mFblYjHMtyVMX5y+p3gbAHsBH/YsMffbDEW/RoE52BYwbepjaMmYHlogBS/LFY92
i0Q8Yv7e
=mF+N
-----END PGP SIGNATURE-----

--gkawtdox6l4a23fx--
