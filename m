Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BA43E3DA7;
	Tue, 31 Mar 2026 15:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774969848; cv=none; b=dUwjLruvfwiQWr80fFfAvi1PkO+F6W0J7vRmIydB4PK84ApNI4e0WrG169Zv4Hh+P6Gm5e5O7EtD8kbg99g2W6RQzuPFN/7x0MM4sQggotHETdGbhkSib/SY+eZ538ZUYlpWEtJx68XGwZIx5aGWMKH6yFTtEdCQkvvDJrKu6r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774969848; c=relaxed/simple;
	bh=E41XlfhVFOeVRcSNGVLW5pCNWoAqqMLGKUlas2wiqg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qoU6Ch5BfYZeMJbT5u2ikrixMXyaTudV3sVmWPNNodlyxRX2RWBpl6+1xP/Hqh4/K0EzOIGXIHrMM35N8PwiD3NTcpKFuO3lRNJs4dqHi+6wau4YOUB1swRjlGc1a98FjYtsDnBbdGLgge2GrvGuVDrqpFMnIyLlxg7O44Zle2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=fail (0-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=oRvu81Lu reason="key not found in DNS"; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="oRvu81Lu"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4flWlB2mLrz9v7Y;
	Tue, 31 Mar 2026 17:10:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1774969830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E41XlfhVFOeVRcSNGVLW5pCNWoAqqMLGKUlas2wiqg8=;
	b=oRvu81LuMS3XfrHmJKnwx3YKiDLc9OBsU5ONI3o+3hTYZdHsn8wvt/IZgGjlmcsvg0loQA
	H1tHkyR327Q96RQADXDkLAiByWQsu4DBzH1+ca+IvVP2IerwpqucDU3Jy5fLr9Yd+i3Zhc
	pNAMqknxKEMGWhdiylbIpq9//eL2Vdcji5P82IlDoB820+fARq0VVsRhTCJgu5Sb63L8qU
	ZR3nh1h4wsox2sLNrbxi0xhWlUzjTrQyALmNueD/FDpBnOYWObVt3BoJRte/DGn7o9mnGO
	Kb2dAdjbHgzPpxHL9dGuwaDw9Jh+iXbIkrga1z/wbdvbcno5BBAs1bX4aRpEPA==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
Date: Wed, 1 Apr 2026 02:10:16 +1100
From: Aleksa Sarai <cyphar@cyphar.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Aleksa Sarai <aleksa@amutable.com>, Shuah Khan <shuah@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/3] selftests: openat2: migrate to kselftests harness
Message-ID: <2026-03-31-somber-private-crew-movie-exaY9q@cyphar.com>
References: <20260401-openat2-selftests-kunit-v1-0-5819ac6cadf5@amutable.com>
 <20260331-irrgarten-decken-b589936aed85@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="olcskqu5kr2f4yyg"
Content-Disposition: inline
In-Reply-To: <20260331-irrgarten-decken-b589936aed85@brauner>
X-Rspamd-Queue-Id: 4flWlB2mLrz9v7Y


--olcskqu5kr2f4yyg
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/3] selftests: openat2: migrate to kselftests harness
MIME-Version: 1.0

On 2026-03-31, Christian Brauner <brauner@kernel.org> wrote:
> On Wed, Apr 01, 2026 at 12:43:30AM +1100, Aleksa Sarai wrote:
> > These tests were written in the early days of selftests' TAP support,
> > the more modern kselftest harness is much easier to follow and maintain.
> > The actual contents of the tests are unchanged by this change.
> >=20
> > Signed-off-by: Aleksa Sarai <aleksa@amutable.com>
> > ---
>=20
> Looks all good to me. Do you want to maybe migrate the tests to the
> filesystems/ subfolder as well?

Good point, I'll move it over in v2.

--=20
Aleksa Sarai
https://www.cyphar.com/

--olcskqu5kr2f4yyg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCacvj2BsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQKJf60rfpRG8dQQEAmdUQr8b2gfRzRkPbHjAh
42g+nEzUl1RDNN0OFzh8SEYA/3cFgt22a/WmxvJFXv2lS0/6zWvHCiEx6jWukZ4P
WWYB
=KP7I
-----END PGP SIGNATURE-----

--olcskqu5kr2f4yyg--
