Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE600270545;
	Mon, 17 Aug 2026 13:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786974861; cv=none; b=brJq+AXTHUbD4KeKbaSDft0EeH8iE4sz5sTlzhBxD9PjDeg32/VEjlZTcNAgE88yw0SrqDDEZkCfccAzlmLu8sPVyJ6IxNwihZug9CzgB9mbluqTaxEcGe9T/AMctlBJdMVxQUZtoIeXxuZKJCVY37/DJg1e+nMlyOoZcLegIwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786974861; c=relaxed/simple;
	bh=FVL9nbCJQZbVEyCg+fbUYuegcFTEntbf4W0jnv14ZwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uyQrC1DRufCIYQhtyjeLT6Dj7RcsFmC910chgI2aVaga8ndt54E6hQrPUS/Vi90z7IDRyEDTgIpIWsbdJabgVQBKw0UkI9RuPUFHJr5L95sR3jrs/DpwkvHsJv3fZLPupoZySOpVCONvWdDhRuiHgHvVvQK3NQsqX+7SWSR3JpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mzkcPzS2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzkcPzS2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB8C1F000E9;
	Mon, 17 Aug 2026 13:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786974858;
	bh=FVL9nbCJQZbVEyCg+fbUYuegcFTEntbf4W0jnv14ZwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mzkcPzS26UAieTbjjhDND9RbJJJohN9fS6apOERJiglp4bVTAKUcPVLWjoPXCiNki
	 JLBNklhzbQYeNIP/pTrx+MTd3fURHD8a+kQjwehQn39hVP3YpKYMT4Dgng+9cX2wDj
	 ewBHI2xVbqlIuasqa4JrW917AG4ARpUUfzfTZGob0TUy3mb781Kc9yPrElJRlqyOZF
	 xhafTecT0KNjqpPO0WeacuCTq2zvdjy5ZxT9iW/FYzOfW+PJGD2cexjYQ/rMA88xY5
	 CspoVrsJrMr0y/5uNx2fzwSYEspmauqLPXz/3xwm03Fzb6+gkpAgxtWa3l5twRYZVH
	 8yQOGv2enqBhA==
Date: Mon, 17 Aug 2026 15:54:12 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Bradley Morgan <include@grrlz.net>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, jackmanb@google.com, 
	kees@kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com, shijianlin11@foxmail.com, 
	shuah@kernel.org, surenb@google.com, vbabka@kernel.org, ziy@nvidia.com
Subject: Re: [PATCH v2 4/4] sysctl: Add 0013 to test partially updated vectors
Message-ID: <iahrpgl333k2cniihxiv4qbkgtalxmhn47gyzrq2xd7jshxbtd@cniqn2gdnqfw>
References: <20260814-lklm-partial_ctlvec-v2-4-9df50d26e477@kernel.org>
 <1EF80864-F479-44F2-8CD7-28383515F483@grrlz.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yhe6sdbk6tigebhg"
Content-Disposition: inline
In-Reply-To: <1EF80864-F479-44F2-8CD7-28383515F483@grrlz.net>


--yhe6sdbk6tigebhg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 15, 2026 at 05:05:59PM +0100, Bradley Morgan wrote:
> The test covers the parse error, the out of range value and the
> first value failing. That's the right coverage.
>=20
> The shellcheck disable should say why. The test functions are only
> called through the dispatch string, so shellcheck thinks they are
> unreachable.
I expect to remove this in the new sysctl selftests.

>=20
> run_int_array_no_partial_update() uses spaces for its comment lines
> while the code uses tabs.
good catch=20

>=20
> reset_vals() has no case for int_0003, so sysctl_test_0013 calls it
> for nothing. Drop the call or add a case for int_0003.
The TARGET is reset to "". right?

I'm reluctant to do more work on the sysctl.sh file as everything will
probably be replaced.

Thx

Best
>=20
> Nits aside, the test does what it should:
>=20
> Reviewed-by: Bradley Morgan <include@grrlz.net>
> Thanks!

--yhe6sdbk6tigebhg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmqDEoQACgkQupfNUreW
QU9kAwv9G9oMHDJ+90hHFBoMUPnpGpgP+V/sRCaP8YhJBX+tnl+p82nNXfffddrL
WmT9wH0JuPPRHSN3ZedgAe/+gWUez2DAUDK7ShH6QlTRzvitfW3Bi4g7A+KcgbAL
nykswCVYLvRPVIRBGdJMniG/25lwhBR+KrsZY2nx3YDw0BNTavSTCPrVId1FVJ8C
eOJw5QWyR5dIQR1gamOHqx+kF+p6Py3iS64LXB+2RrGLR6eRY1ge4HsG29/0q6I9
N89xYCLv4YAQroZOWzQyzTbbtdSXcYx4+If2bh8GUy/+qifSVQIQ5TBtrUpWuOaW
dVNDas3p8WRcAR5/89DxGdBxlMFPahyt+Xs3xxuXOtreEn5nHPf3naLBAq8TD8Wk
76kNx7YyZfPzi7wIGWhwtxMz/0/9muPVNNlQEHRKRJJknkjOyJxzWrmdL1ygovtC
f0ssEfZ4ZEn98LWDUaH5bwls8TPbTps+qrqv0+zdvJnwPhzXg6ken77xYQ22+wva
N2yP77lJ
=t+L1
-----END PGP SIGNATURE-----

--yhe6sdbk6tigebhg--
