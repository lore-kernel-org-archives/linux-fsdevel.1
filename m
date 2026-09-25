Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3F840B6FC;
	Fri, 25 Sep 2026 11:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790337558; cv=none; b=TWa6K1+Y9+trYYkHYGcwA30yTGsLjplM/S8/kpRP+SmEniB/ZMf89+kyxZNtVIVxnNn3Vzwt2kp8EdV2O5noPvAWZ+QuLRNgUyOct4uuMP4CVqrtdYDgktOpmSFN7dtY3AQizoKffX2cUaS4a8rpSZySDDKgZ9wApT2yUNcf618=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790337558; c=relaxed/simple;
	bh=XBBBR2vWRhFx122M5CmClCTyCtRg/I3gUEnHvIXle6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MVqFP1q9QcwdawxBS3YNl91/stJi81uiTBDEM3VGcahaVbqEkxeBG6DZ+LdwEKVyGBUNnwG/zY2BPhRXRqIWcBk5j8AAg+O4EJ/UzljfA0Fbn6k1dNlYtgNf2X1Iz1h93oDpiXDqKz9JHIAhQxEoNr6g9sSPW+PoU7WwEQLqRdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTvJEhc4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTvJEhc4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 399DE1F000FF;
	Fri, 25 Sep 2026 11:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790337552;
	bh=YLj1hQEK1xN6pU1LpgPVLfGPRC66sTixW4Mz7llF9j4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FTvJEhc4Z58bMDDeVu5diAU7apBQZFOMMzTK7XxVbpRzVsMTR9fExZCZVVC1vb4/q
	 WMcEI7XZ56B16NMUExG03SZxHY8vyeKmdOVCcSImS8pOuKK5wGxzkinAx4KWaeuQx6
	 x6LOjStsDxqlwvyTItG1zVpXB6FjqQsW70PcBN+bmpZBMVEFSR40z9mndtNYd1gX98
	 aVxNCecDqL9GZH78LcX0qzasaW/h19Rl+RgXeuC5miKV7wOpMp8Wknpz4dR2Vo7xgi
	 /iPS/RLZLloOjNbl7PEtMO+9ljNdWwEXXU7OCy0KQSj8Q0EtI2UexsklPRaOW5lql6
	 XmDAicmPm+tqw==
Date: Fri, 25 Sep 2026 13:59:07 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Yibo Tan <lhfff@tju.edu.cn>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Eric Sandeen <sandeen@sandeen.net>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1] test_sysctl: unregister tables before freeing bitmap
Message-ID: <h5ysapnb2nz3wlbmv6droshjjfamxi72bdae5gy4vlnoppa6c7@u5o3zc7x4b5j>
References: <20260919185110.2243068-1-lhfff@tju.edu.cn>
 <azzmtohujpmkhyjdvehtq2oxtxfhyn2rwitrxtheglrh5lpata@maoxao2seo4m>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bz33coaojvvdfngn"
Content-Disposition: inline
In-Reply-To: <azzmtohujpmkhyjdvehtq2oxtxfhyn2rwitrxtheglrh5lpata@maoxao2seo4m>


--bz33coaojvvdfngn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 11:03:31AM +0200, Joel Granados wrote:
> On Sun, Sep 20, 2026 at 02:51:10AM +0800, Yibo Tan wrote:
> > The table registered for bitmap_0001 retains a pointer to
> > test_data.bitmap_0001. unregister_sysctl_table() prevents new handlers
> > from starting and waits for active handlers to finish.
> >=20
> > test_sysctl_exit() currently frees the bitmap before unregistering the
> > table. A concurrent read during module removal can therefore enter
> > proc_do_large_bitmap() while the bitmap is freed. KASAN reports a
> > slab-use-after-free in _find_next_bit().
> >=20
> > Unregister all tables before freeing the bitmap so the unregister rundo=
wn
> > provides the required lifetime boundary.
> >=20
> > The unmodified module reproduced the use-after-free in three KASAN runs.
> > With this change, three runs each completed 100 load, read and unload r=
ace
> > rounds without a kernel diagnostic.
> >=20
> > Fixes: 2ea622b887e7 ("tools/testing/selftests/sysctl/sysctl.sh: add pro=
c_do_large_bitmap() test case")
> > Assisted-by: Codex:GPT-5
>=20
> I'll change this to Assisted-by: LLM like it says in Documentation/proces=
s/coding-assistants.rst

I'll also update the commit message header to sysctl: from test_sysctl:
>=20
> > Signed-off-by: Yibo Tan <lhfff@tju.edu.cn>
> > ---
> >  lib/test_sysctl.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/lib/test_sysctl.c b/lib/test_sysctl.c
> > index 909cfcf76dbfc..dd795979558a2 100644
> > --- a/lib/test_sysctl.c
> > +++ b/lib/test_sysctl.c
> > @@ -321,11 +321,11 @@ module_init(test_sysctl_init);
> > =20
> >  static void __exit test_sysctl_exit(void)
> >  {
> > -	kfree(test_data.bitmap_0001);
> >  	for (int i =3D 0; i < TEST_H_SIZE; i++) {
> >  		if (ctl_headers[i])
> >  			unregister_sysctl_table(ctl_headers[i]);
> >  	}
> > +	kfree(test_data.bitmap_0001);
> >  }
> > =20
> >  module_exit(test_sysctl_exit);
> >=20
> > base-commit: 40288c9206c17eb66a603262e06a58d300d0f279
>=20
> I'll leave the Fixes tag but will add this to sysctl-next as opposed to
> pushing it through as a fix for 7.3. Lets avoid making noise just for
> the testing module.
>=20
> Thx for the fix
>=20
> Best
>=20



--bz33coaojvvdfngn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmq2YgoACgkQupfNUreW
QU/rKAv+KgoVvvSu6mvAHiFK14PUiwkTirgWvZCCPz0D5cCwW7AsqRjJooIJ0Eg3
wzGyZo7crFljpRPxXtXL1HymSVCsqS3phq7UX4+91XE7vV1AVfpIdDJxIuhvzc6t
E7VLFKOSrnifFpOaG21E6cITxagGT7fsfZ0BIgLhX3uJW6pEtWeTPCNRBSS9mOzv
GHAPujyF0WOmoVDxEqeRcNt4Ln26JpObaJyV+uPsUJ7nvatjga2rzw9uJVyU5Faa
t+Tb1AoVSThn6W5Bs5PFPuSOnmo+193dXScGdnOga9fX+YFYjELBp9oFNShIbgh5
a6+27CdMD9Op6aUNlL8HkJ5uysBhKgckg/FqU4FxiFwwAUcTwaZOMJ5zC5JUHwld
3VDpSsVk1wyuMSkRpUuyYSJZrih8b9J/fQxH78x5+AY6RX7quDqwVAWCdLIR3Xcn
Kv/POfrtmUCN2XKEFPgJDgS/diuWohijhGM6YNElzV6TQD1/jJChuVo19Ae/L2E1
GOkhRyzO
=0WxY
-----END PGP SIGNATURE-----

--bz33coaojvvdfngn--
