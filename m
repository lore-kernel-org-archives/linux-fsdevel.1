Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FF6374745;
	Thu,  1 Oct 2026 11:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790854734; cv=none; b=oM1VvDGKZDX8HK7Gf18ioWw1CYNgXBp0s1Nfxb4VVW4hIcgC+TrW996lxtJooktaYd9P2+BZgTYtbypBNI7KqDedsrfhxAWYtg+RkCieAhek8rhnZF51dDZ+lvwbEVrGYS89kMK89qESY1UR3KHoGcog3t+S/4GUEpW2ONcPwS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790854734; c=relaxed/simple;
	bh=GLdcpdS4qKCMGASoeVk32ozp0hTf0ZbsqpFQN6qAHFY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=prAU+IinGOvxK0uxBgeVbw0WiccJ/VfYUzhyTdI3EbDOsKmcg+jiulMW2x7awMgUKxlgZB9suPTAsgZXzjncmpjSuvqrxixTse1r33Iev0E9hUTV5ctht8w0Siglcak8XC3DdzdO450MpLyCZqow8TvMh8uNkM4EqW2F56W/TPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=owdv9Yk7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="owdv9Yk7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 926CB1F000FF;
	Thu,  1 Oct 2026 11:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790854732;
	bh=/wSo/8Bk5oj9ucRYiv19MbJjLBK29LPujmY3DmPBK1o=;
	h=Date:From:To:Cc:Subject;
	b=owdv9Yk7UUY+T+JsEbXhRSU/HZx0VskDXO8w8jlrnulFjdUB5vg442Y2fLkOSOxP+
	 4MXlViz4Hpm6+KMOuhB4hRGm/zZ3xMBewyxPQHEah/6sgUXlLU3S9y7suc33tGVWuT
	 PCUMTevqugbGZgP2U776r28FI+lx6R85jk1gJFVwMuKEKYMwK/vGNRjfb5qt85h4OD
	 h3AtL/tlpw1Ty8piOuVHcXoYjDG+Cx00mYY6T8AE5FpdZU0alKSJJgKn+Je6FnOw8J
	 cuXsPWJBh3yDBwcOG+hYN7L6SChnMWome9FZPQBGnfOU09x0DtyI6flLOa0guINwsE
	 56HGaaoXWJp2g==
Date: Thu, 1 Oct 2026 13:38:46 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Bradley Morgan <brads@mainlining.org>, Kees Cook <kees@kernel.org>, 
	Zhan Xusheng <zhanxusheng@xiaomi.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] sysctl fixes for v7.3-rc6
Message-ID: <zcnee7kd4z7ncgccbh4cpmwoj4pbdvrscjl4chey7c4oczzgwg@fy3tb5yzdkii>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ogqfjisgzn5wve4m"
Content-Disposition: inline


--ogqfjisgzn5wve4m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus:

Missed this in the tag: tested with sysctl selftests on x86_64 as well
as linux-next (for a week).

Best

The following changes since commit 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e:

  Linux 7.3-rc5 (2026-09-27 13:55:01 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git tags/sysctl-7.03-fixes-rc6

for you to fetch changes up to fdd6553e1e53b0421d89c7469c8a36d2eadb1115:

  time/jiffies: Saturate in mult_hz() instead of wrapping (2026-09-29 10:00:40 +0200)

----------------------------------------------------------------
Summary

* Fix sysctl jiffies conversions errors introduced in 2dc164a48e6f ("sysctl:
  Create converter functions with two new macros")

  - Ensure that mult_hz does *not* wrap
  - Ensure we pass just the magnitude for the negative branch in
    proc_int_k2u_conv_kop

----------------------------------------------------------------
Zhan Xusheng (2):
      sysctl: Negate before converting in the int read path
      time/jiffies: Saturate in mult_hz() instead of wrapping

 kernel/sysctl.c       | 2 +-
 kernel/time/jiffies.c | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)


--ogqfjisgzn5wve4m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmq+RkAACgkQupfNUreW
QU+q+Av/RW55OSWuZVnuqjVwKb9r70wvsIuyTwvOZG50IopF5KQNs66i5whX6Fge
hq2//HmkeLxv0zuLNIX0nmmXOIqkTlQGTBManb+z7bfXuJ6MgLVU1S7ZvnVkLXys
VQ8Wp3f3sIb09fM3/M9rtNozjkIb21W6YgKQLVogSC9ysQa2uoZVRAZ/vCdXy64l
6awBOFjVOOGallw8sEcHZRhaSgFytWDhiPjnGtvemFEdjPIuPYBUuUNjgQglhYYc
h5PBZ5z7MOyKPVYoZD9PbYa2+hmF+GefcBGSK06WigjosBq8gZYGokSwMGDASA5W
wSezqux+2mFBZhbzbkuvtDd0eRnTw7QHkCcdHj533oniKeX3iqv93V5cubEYvvNi
Reu8VQAJb+7g+XGWKEKJeHc/f8omWLXO0qArkUs6yLOxO9BeHMATzLfDOkK2ilPj
DK0mw0ydnIzPPRiwusAYxN6DJr+do2LZaumqZqKtIUhY7MBqOokBUWXz8axtUust
YY0cS3ZO
=JOIO
-----END PGP SIGNATURE-----

--ogqfjisgzn5wve4m--
