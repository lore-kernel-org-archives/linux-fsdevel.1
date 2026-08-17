Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375F03F7882;
	Mon, 17 Aug 2026 13:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786974231; cv=none; b=WtTFGJwu5cIyvpS5tLduEhtvOunXN6qhdZsWb6sPx5w0XraES9EEKlUnC1ev84DNmNC84OC7pPlSQbeQwGfm6agTgBD6Tu705+V3dKvv82gyPQ9WdgIkSbBnkeJvf0h+Pe/6b1epiTxAn0T0GmAJ122X9Gle7tvT7MzTHaWYfpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786974231; c=relaxed/simple;
	bh=8j64C5Yyragyhv7d/QskN0ZuZnf5SRudffh4XmLXgPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=klbr9CKyazt7NLvxd3hZ5K+Q7a8INx3tscsx5XEv3F6gXLt/X/48XiipH9RHM6ckKThqiBhZQdjEOppUiYMeN0zr5RLXwhEkeZgb0Jr8g4anLoYagvf5qOY3z4vT4PbFJOqpTjfgl0TYMHugg5SjIT+gB1tAt4XjT6ATnSNPuRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fv/2ZQO2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fv/2ZQO2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 568C61F000E9;
	Mon, 17 Aug 2026 13:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786974229;
	bh=8j64C5Yyragyhv7d/QskN0ZuZnf5SRudffh4XmLXgPA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fv/2ZQO2uXpJGu70iBIjlFrOEwNQBIvY+cN3aEc2JQJrKV+/ppXEhMMg6yjqAuhiS
	 yYOURAkApSFpXkHNaJPfPRucCDWpND2puzfYvkMli9JkAzB4cOWaQWQRJqYw1NUFJq
	 6XhLHmI8oqZpN/A5IvpDkvd0dr6Ly/iH+rA0wWWDuPINNd3OEzxRjxbo1rBpd5GoNn
	 wLz0lZzAXZS0K2JUJ8/hcxSBD9MrgYiooRSwQPMLJXYY+rDSfU+g5959fVycDBNGSw
	 AvQmUh+g1ljr5NiMmQYqxQqPm7CkBqOQdmH+moxMHAuZXb7gl0uEos1Xg4mOXA9uSh
	 x4hqihPivcngA==
Date: Mon, 17 Aug 2026 15:43:44 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Bradley Morgan <include@grrlz.net>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, jackmanb@google.com, 
	kees@kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com, shijianlin11@foxmail.com, 
	shuah@kernel.org, surenb@google.com, vbabka@kernel.org, ziy@nvidia.com
Subject: Re: [PATCH v2 3/4] sysctl: Disallow partial updates for erroneous
 sysctl vectors
Message-ID: <cwfpl5h47km6f35m5k7wa2pj3elciaax6i3nmetxcgws66qewq@fzygztolxed4>
References: <20260814-lklm-partial_ctlvec-v2-3-9df50d26e477@kernel.org>
 <3A4FCA2B-2F42-4E8F-A328-5C1BD658B2A8@grrlz.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xrhvwbqqqbh27ci5"
Content-Disposition: inline
In-Reply-To: <3A4FCA2B-2F42-4E8F-A328-5C1BD658B2A8@grrlz.net>


--xrhvwbqqqbh27ci5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 15, 2026 at 05:05:26PM +0100, Bradley Morgan wrote:
> commit_conv_vec() writes the elements one by one, so a reader can
> still see a mix of old and new values while the loop runs. Same as
> before this series, so no regression, but the changelog could say
> this doesn't make the write atomic either. Otherwise someone later
> will expect the vector to change all at once.

Seems reasonable: here is what I added to the commit message:


"
=2E.. This (The staging vector) does **not** make the write atomic as a rea=
der
can still see a partially updated vector.

=2E..
"

Best

Joel

>=20
> The copy is limited by table->maxlen and only vectors pay for it.
>=20
> Fine by me.
>=20
> Reviewed-by: Bradley Morgan <include@grrlz.net>
> Thanks!

--xrhvwbqqqbh27ci5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmqDEA8ACgkQupfNUreW
QU9zgQv/bnQ92wPIe9bSeDUP0FWKwpDTbtxn/2wHV3tzqIJArmIZzkr02Cy6qsxj
/De7twF6hou7L9+YQyf777GU45woG89gvPpGLs/uJ52Jlv/sqEObSzxXJNbeWWWs
Wozys0TZZsOAkBLwwvcBky4nw6EqSodJE+c1tFfAJFkr/8JeOk8kG0mPaWRP5KeK
+DlxLVpQTySKxVB1i/cZhNmeecG6FioVeMChDtLSKUvE96NSI/D1fngEd4I1aFTJ
8W4Ha6oeALfo2iZvSA0/cM8gMVW7M+dhY5RtIMzF8ejMNSOs2BGUXUh8rxP5cRbr
XXrDhO5SJbJsOnfj0HpAj/gQGJQMh+jmUSaCFp54251TyMaIpNH1WqxgZNmA68pA
s+qOTeRjPSVTHluyR2aArr24sKaO46j2NXGO2uS3qiNAslPE1nQHfAUX5pQQBAPV
dvsCclzMGntqE4wT8YWRI1wd37XdjtQVLHi55avd28i/lOSPjwfkmxpZBgmY9hTH
bD+zj0To
=AzpY
-----END PGP SIGNATURE-----

--xrhvwbqqqbh27ci5--
