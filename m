Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7877D381AEA
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Mar 2026 23:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773963374; cv=none; b=T+pEXpFF0QJUBP2vh+UX1K/0yYTX6E+4ZUeHs63LfdEqbhJmHLtx3gdG3vVN7/9bGwMceHZOo/fSq/3DPC9VCQhEJjyZtTi8zRc8VyDoQTmMioGURw3uyCBoJH+l9sydDY2LQd/vY8dr4pq9cbybCI1j6zj0O2M9RTG37HN1Qgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773963374; c=relaxed/simple;
	bh=0NDoZNj4TuiSY6bR9A1V28+vV7pl0fJP03HfXy4cGBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jLigdfB6QmBMnyZayBRTIJy9p1lsF5LDUKCw2RwGxHFxa2sd882XEZ7ihKkDdJ8q2dBc4/muaJony7LJPOSL/qVxYg3i2GUXTrSeLJY8xOKC947IiD5DLZO9cr1UDZriNmjZSGZM81CmujYrzEl1Yijr/RjKnVAw8nHwniC55eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VPp5BCZf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPp5BCZf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BBEDC19424;
	Thu, 19 Mar 2026 23:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773963374;
	bh=0NDoZNj4TuiSY6bR9A1V28+vV7pl0fJP03HfXy4cGBQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VPp5BCZfwnQ/6/xj7PHqIEGrTnyEJj/W6Ez5yfFseWON9ihbTsHOKEVn5gw5yNEPt
	 esf+PkHTDcYSkAMFFvTLqBHK58EoUS+LFNcY9wkU8VK8uG+Xb0CVys7bQl7nP88AqB
	 OZA9kj9BWM+WRLGc3DivkRxwYmFs3Nn0/pF4gPOqFDj+9DJCsfXhYgiHaNfWbRf0SM
	 Gmybv43oiaAmbzJpl93B1S7xjZcnqFLlfDJLCp3JIVunY/gy9dcU0Rai+nKL20FhQ+
	 vPvXL0cv0kCD1H9IknoEJl6v6YqjBjjmLiHm1WiJYJJGKM7JCZXuk4E6FaJj9TcbCx
	 j20zrxUrUg+iw==
Date: Thu, 19 Mar 2026 23:36:10 +0000
From: Mark Brown <broonie@kernel.org>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Bernd Schubert <bernd@bsbernd.com>,
	Aishwarya.TCV@arm.com
Subject: Re: [PATCH v2 1/6] fuse: create fuse_dev on /dev/fuse open instead
 of mount
Message-ID: <3c9f8396-41f4-4c88-b883-34bede72b427@sirena.org.uk>
References: <20260312194019.3077902-1-mszeredi@redhat.com>
 <20260312194019.3077902-2-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mBkcFhqUgCJTm+Zi"
Content-Disposition: inline
In-Reply-To: <20260312194019.3077902-2-mszeredi@redhat.com>
X-Cookie: We've upped our standards, so up yours!


--mBkcFhqUgCJTm+Zi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 08:39:59PM +0100, Miklos Szeredi wrote:
> Allocate struct fuse_dev when opening the device.  This means that unlike
> before, ->private_data is always set to a valid pointer.
>=20
> The use of USE_DEV_SYNC_INIT magic pointer for the private_data is now
> replaced with a simple bool sync_init member.

Since Monday we've been seeing problems with the read_all_dev LTP
testcase running -next on a range of arm64 platforms, these bisect to
this commit.  The test reports:

11468 01:06:07.273320  tst_test.c:2021: TINFO: LTP version: 20250930
11469 01:06:07.284741  tst_test.c:2024: TINFO: Tested kernel: 7.0.0-rc4-nex=
t-20260316 #1 SMP PREEMPT Mon Mar 16 20:19:24 UTC 2026 aarch64
11470 01:06:07.285022  tst_kconfig.c:88: TINFO: Parsing kernel config '/pro=
c/config.gz'
11471 01:06:07.296067  tst_test.c:1842: TINFO: Overall timeout per run is 0=
h 02m 10s
11472 01:06:07.296580  read_all.c:601: TINFO: Worker timeout set to 10% of =
runtime: 1000ms
11473 01:06:07.296818  Test timeouted, sending SIGKILL!
11474 01:06:07.307439  tst_test.c:1905: TINFO: Killed the leftover descenda=
nt processes
11475 01:06:07.318985  tst_test.c:1914: TINFO: If you are running on slow m=
achine, try exporting LTP_TIMEOUT_MUL > 1
11476 01:06:07.319263  tst_test.c:1916: TBROK: Test killed! (timeout?)
11477 01:06:07.319486 =20
11478 01:06:07.319690  Summary:
11479 01:06:07.319887  passed   0
11480 01:06:07.320076  failed   0
11481 01:06:07.320262  broken   1

The test does a read of every file under /dev, the actual binary is
read_all and the command is:

   read_all -d /dev -p -q -r 3

so the connection with a change to a change in behaviour when opening
/dev/fuse seems plausible though I didn't investigate further than that
and checking that the bisect looks smooth.

bisect log:

git bisect start
# status: waiting for both good and bad commits
# bad: [8e42d2514a7e8eb8d740d0ba82339dd6c0b6463f] Add linux-next specific f=
iles for 20260318
git bisect bad 8e42d2514a7e8eb8d740d0ba82339dd6c0b6463f
# status: waiting for good commit(s), bad commit known
# good: [2430154a93764c58b8ee9b6f7e5b3563ff452baa] Merge branch 'for-linux-=
next-fixes' of https://gitlab.freedesktop.org/drm/misc/kernel.git
git bisect good 2430154a93764c58b8ee9b6f7e5b3563ff452baa
# bad: [1ec9b3fbfc367f64a29f3335ae9879202993b7bc] Merge branch 'nand/next' =
of https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git
git bisect bad 1ec9b3fbfc367f64a29f3335ae9879202993b7bc
# bad: [91392dfbff751ca86443a6f3ce7c46143fecdecd] Merge branch 'fs-next' of=
 linux-next
git bisect bad 91392dfbff751ca86443a6f3ce7c46143fecdecd
# good: [41512607505955aaf57cc6899aa548ae75ab81e6] Merge branch 'for-next' =
of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git
git bisect good 41512607505955aaf57cc6899aa548ae75ab81e6
# bad: [515b2513dabbdec4536c8c1b8de56271efe800f6] Merge branch 'for-next' o=
f https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
git bisect bad 515b2513dabbdec4536c8c1b8de56271efe800f6
# bad: [2115fbae3f0b9ad858373ed31ee9af0b25a63d6d] Merge branch 'jfs-next' o=
f https://github.com/kleikamp/linux-shaggy.git
git bisect bad 2115fbae3f0b9ad858373ed31ee9af0b25a63d6d
# good: [41019679bc4f7ed6b072a83ba264908bc88752dd] Merge branch 'for-next-n=
ext-v7.0-20260316' into for-next-20260316
git bisect good 41019679bc4f7ed6b072a83ba264908bc88752dd
# good: [a0597d24fd296252e40643e95ca22c752f246158] Merge branch 'for_next' =
of https://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git
git bisect good a0597d24fd296252e40643e95ca22c752f246158
# bad: [6dcceeb728567a61fbad781c13828b638b32bc16] fuse: support FSCONFIG_SE=
T_FD for "fd" option
git bisect bad 6dcceeb728567a61fbad781c13828b638b32bc16
# good: [25307ca50b815c14a21f82fc5b10e8a621af32ad] fuse: simplify logic in =
fuse_notify_store() and fuse_retrieve()
git bisect good 25307ca50b815c14a21f82fc5b10e8a621af32ad
# bad: [3379620923d3e59b6767605a0f11d13b37d72a0c] fuse: create fuse_dev on =
/dev/fuse open instead of mount
git bisect bad 3379620923d3e59b6767605a0f11d13b37d72a0c
# good: [8d306cbffc2ee0f3251c81d574aa3451ef21cd5a] fuse: use offset_in_page=
() for page offset calculations
git bisect good 8d306cbffc2ee0f3251c81d574aa3451ef21cd5a
# good: [5a6baf204610589f8a5b5a1cd69d1fe661d9d3cd] fuse: fix uninit-value i=
n fuse_dentry_revalidate()
git bisect good 5a6baf204610589f8a5b5a1cd69d1fe661d9d3cd
# first bad commit: [3379620923d3e59b6767605a0f11d13b37d72a0c] fuse: create=
 fuse_dev on /dev/fuse open instead of mount

--mBkcFhqUgCJTm+Zi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmm8iGkACgkQJNaLcl1U
h9Dspgf9Eg6XCHFzXiGH8KFU4NqHM1LGgaQeOC5uy5SUf5w5b6tUrDbfS8TpSLa2
hz7YJENsDTnTJCJqvf1+f9RFqKM6hhRstueYAneiWgeedchwakJzfsbPQNyXNjd0
swBvYNd6k2vCjO5ZfA68HlggKgdymXpy67BMdlqKOlGc77A3ERRJweWeuDndmkD2
omdi4XejGxem2X8Jv7Q3eexv04oR376ej6Spm9U7usf7q8+olncNLlHRsnSeu0ir
2RL+ytcFb9JiAkHXjUXVxcvVSD4F1O4BTv2FVD5FTDlCRa5cVlVTWxh3EAU0r13z
mSyuuQPBNSAm4plMbkCsIr70p0HbWQ==
=Nu+n
-----END PGP SIGNATURE-----

--mBkcFhqUgCJTm+Zi--
