Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA554C6C
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 19:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776886902; cv=none; b=p9u3CQPAmzBRtF9ffwCMCyNb8rRDkaEzXxAa2w+fljHQb6hA4Qx7w1RM3uw6zsJDNsEUM6vQGtCGyXdts+R8D3lo4s3+yLNuUMnLsRpSFPH+kUSppr1p/dWppBZGvFXo9Llk4SY95ma/CKmHoMJfezpmMULHroKTCdM/XG6hRaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776886902; c=relaxed/simple;
	bh=0bUVDZjBSy1jt+cpHOnoQFety2wC1OyrSugPpRXxcWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/lwDrw4scovtJNucmVD0Sre9K4fpK4zq5XvPxCS8V5lJChCwgNiYkxwJtJ1Ro714C7YPe9GMzm+O/CgF5+egoK+3+DoYtOOvWmQ470IdglE8VnJKzLa5Ai+XwsSGP1l+FIzYYnMTHfjOfnmc0XfQ3/Y1/bukWMjYz60Dan6BQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTCp+BZt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTCp+BZt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9FE4C19425;
	Wed, 22 Apr 2026 19:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776886902;
	bh=0bUVDZjBSy1jt+cpHOnoQFety2wC1OyrSugPpRXxcWo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fTCp+BZtAXaWerSG1TLHoQjW4rx986RrkjIWzXXJDkgY6mV007ReWpRQj7hqsSpjF
	 xvde2LE0n0mz8+WWwfvj/QnM3pazYyfU4HHkfOIpfFcdqztH5lbzkrtqBw0uzeG21D
	 J60w84KX834pQ7r3xPUkqBj/aNAOwW73cXYVrLd+sL5Tnh7Y0GqaTX4BguFZYEUBWw
	 Kcm3hLp0LepkPdi+SWD2uORQfVUAXLjynxgyOnzN7DskwQ7Rme7punSbThFmPgUPd1
	 WgIvjN5w43FJjfQH/hZDhb+sjmRJjgCWILW07mzyFzK9DnwmRnDm5ENk3VtVKr3JYe
	 LFvgFU5WsIqlQ==
Date: Wed, 22 Apr 2026 20:41:37 +0100
From: Mark Brown <broonie@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, torvalds@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, Bernd Schubert <bernd@bsbernd.com>,
	Aishwarya.TCV@arm.com
Subject: Re: [PATCH v2 1/6] fuse: create fuse_dev on /dev/fuse open instead
 of mount
Message-ID: <13f8c804-b614-4158-a30d-f2bc6aa5b851@sirena.org.uk>
References: <20260312194019.3077902-1-mszeredi@redhat.com>
 <20260312194019.3077902-2-mszeredi@redhat.com>
 <3c9f8396-41f4-4c88-b883-34bede72b427@sirena.org.uk>
 <e3ad44f0-0a3e-4ef5-ab6e-c346814c0104@sirena.org.uk>
 <CAJnrk1Y1JzKJ=RCLBt592EZ+0=hPzaLWuHve_umxtUMOSH76dQ@mail.gmail.com>
 <CAOssrKfVKvJeriSm7zeRd8xd6mMgRqc3YkpY6rehBtGSy=JVbA@mail.gmail.com>
 <CAJnrk1aC7za1COhMOKe6abhjCPhV-OsNN5v_-dY=qs8ROsG6tA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vTm3Yo2+IyY0U27a"
Content-Disposition: inline
In-Reply-To: <CAJnrk1aC7za1COhMOKe6abhjCPhV-OsNN5v_-dY=qs8ROsG6tA@mail.gmail.com>
X-Cookie: I'm definitely not in Omaha!


--vTm3Yo2+IyY0U27a
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026 at 09:54:10AM -0700, Joanne Koong wrote:
> On Wed, Apr 22, 2026 at 2:04=E2=80=AFAM Miklos Szeredi <mszeredi@redhat.c=
om> wrote:

> From e434521edf44596239a07838a1a8b37c5f0464cb Mon Sep 17 00:00:00 2001
> From: Joanne Koong <joannelkoong@gmail.com>
> Date: Wed, 22 Apr 2026 09:31:23 -0700
> Subject: [PATCH] fuse: don't block in fuse_get_dev() for non-sync_init ca=
se
>=20
> Commit a8dd5f1b73bc ("fuse: create fuse_dev on /dev/fuse open instead of
> mount") changed behavior so that fuse_get_dev() now unconditionally
> blocks waiting for a connection, even in the case where sync_init was
> not set. Previously, non-sync_init opens returned -EPERM immediately.

Just a heads up that the patch is corrupted - it's word wrapped and has
tabs converted to spaces at least.  It does the job though:

Tested-by: Mark Brown <broonie@kernel.org>

--vTm3Yo2+IyY0U27a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnpJHAACgkQJNaLcl1U
h9B5qQf/VroE5yxxzbuTPJdaUWzR0MWPJ5tXzHdAlG2IpLswxZX763+rgp57daQG
/0yk29dncE9E/f8Q4D7cxSozzH9S2TAkxTYCrPaQFq6aiQI5xWTBAd43hum77mUx
1pJgbkaTe5bkhZIJcwha5tgpqPdZF3KjBR/5ySVqGTCcxL4tVcvjaVtrhxaHZnY+
bRNA45NLQNByAkUKdsekst+8kfqlAajNR0vfmMuCdIAuY0x4CcBH4WSJPzX//6Uy
U6LLJAMC8vwrHwBuUrdI4zUiaPJiIQXZGLABjaUz8dAk6ecx+ycaGnCkbvDk5atE
7GxpfKIlWFMC0wXv6i4bLTGtit6VlQ==
=MLiR
-----END PGP SIGNATURE-----

--vTm3Yo2+IyY0U27a--
