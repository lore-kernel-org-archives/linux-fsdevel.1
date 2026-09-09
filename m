Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C669E48E0E4
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2026 13:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788961699; cv=none; b=ZGtPQKSs5zF9oKe73P+yaqlVw3IP5ipTb83tf7RydEcp94vUk/DogoQ5M2nAqmlGtgPQ1o9zxlAHr212kXbyScgbEFBv/aB7W/pl5glASJG1XfgLCgpeRk5HUOrCKn1b0GBO9viErI7mz3XcC4lvztD6Y4rT3t0UF4M7HChlaLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788961699; c=relaxed/simple;
	bh=O3fj9azTAnBB/fvoRvzF9CqoberRDRUZX+OIGmBK2g4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZKSLySd8pqQAVldT2rp3Lv7HPcGivbyJeN4A8hOJjI08Xol0xheSSJTpw6G9sD2UT3jJMRw7DBKJTaJIufi0zeCMXcZoyWmivJwP8Y/Dey1Dl9wCD4ayU0Yt2CLunxgw1iD0Oik1LPRcHDs65kBu6CesexEa0ieOwAo8kepY3OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWYE1q8k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWYE1q8k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D84F61F00A3D;
	Wed,  9 Sep 2026 13:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788961697;
	bh=MZMLdpKXfbo7Wa7tzQPxmDzBlt18VKWdis0afbqMN/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hWYE1q8kVz434XOJyd7MaXOIDgPySovCeesWohJA1/5Jt9/kE+lNqmobjW692wrmI
	 fVEh3vXz2Gxd40Xun2OxX1V5GkJGMXCfM3iP1eWFBgviEYqAPhF1O8IZkBtlOlE6cz
	 ZvoOltYrYJnybEOsp0rnlYQ1HuwCTR460q3sGuaVEXMzr6jiZoAJM3Z2lJKNU5eXgU
	 QNqLgEkXwe3gJ/f0UpBGkIZyDF0e4fHXvShcmXvVgbTInbwptl5826wfyBQFaGHoE5
	 aFNqfDor4qFNcbgrF+lwpYaQVkC/xoSaa7esJ5D//qWIsMt56118jC8e3KgFEWjGKE
	 AjF0uJlqEqskA==
Date: Wed, 9 Sep 2026 15:48:12 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Kees Cook <kees@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] sysctl: Make proc_dointvec_ms_jiffies_minmax()
 enforce minmax again.
Message-ID: <wezubefub7hrslldqgx3m574ekvepdzw5eods4m5n3kgt275os@twezgep5rrm4>
References: <20260905233819.1064529-1-kuniyu@google.com>
 <20260905233819.1064529-2-kuniyu@google.com>
 <7yotzsvlkroxfl3zkestrul7f5rh7vmlhuacm33reod7uw2mun@jrs7c2hud6oo>
 <CAAVpQUBbQYmNXGN3yMyjGJL-EffOPp0cv0jJ8zQDJqgfEHjw3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vlpa3s6j52uavssu"
Content-Disposition: inline
In-Reply-To: <CAAVpQUBbQYmNXGN3yMyjGJL-EffOPp0cv0jJ8zQDJqgfEHjw3w@mail.gmail.com>


--vlpa3s6j52uavssu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 08, 2026 at 11:38:52AM -0700, Kuniyuki Iwashima wrote:
> On Tue, Sep 8, 2026 at 4:06=E2=80=AFAM Joel Granados <joel.granados@kerne=
l.org> wrote:
> >
> > On Sat, Sep 05, 2026 at 11:36:30PM +0000, Kuniyuki Iwashima wrote:
> > > When the cited commit converted the SYSCTL_INT_CONV_CUSTOM macro to
> > > functions, it accidentally changed do_proc_int_conv_ms_jiffies_minmax=
()
> > > to pass false for k_ptr_range_check.
> > >
> > > Since then, net.ipv[46].neigh.${dev}.interval_probe_time_ms no
> > > longer enforces the lower bound.
> > >
> > >   # sysctl net.ipv4.neigh.bond0.interval_probe_time_ms=3D0
> > >   net.ipv4.neigh.bond0.interval_probe_time_ms =3D 0
> > >
> > > Let's restore the minmax check.
> > >
> > > With this:
> > >
> > >   # sysctl net.ipv4.neigh.bond0.interval_probe_time_ms=3D0
> > >   sysctl: setting key "net.ipv4.neigh.bond0.interval_probe_time_ms": =
Invalid argument
> > >
> > > Fixes: d174174c6776 ("sysctl: replace SYSCTL_INT_CONV_CUSTOM macro wi=
th functions")
> > > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > > ---
> > >  kernel/time/jiffies.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/time/jiffies.c b/kernel/time/jiffies.c
> > > index 213ae1d6a014..70926b73905a 100644
> > > --- a/kernel/time/jiffies.c
> > > +++ b/kernel/time/jiffies.c
> > > @@ -181,7 +181,7 @@ static int do_proc_int_conv_ms_jiffies_minmax(boo=
l *negp, ulong *u_ptr,
> > >                                             int *k_ptr, int dir,
> > >                                             const struct ctl_table *t=
bl)
> > >  {
> > > -     return proc_int_conv(negp, u_ptr, k_ptr, dir, tbl, false,
> > > +     return proc_int_conv(negp, u_ptr, k_ptr, dir, tbl, true,
> > >                            sysctl_u2k_int_conv_ms, sysctl_k2u_int_con=
v_ms);
> >
> > oops!!!! Very good catch.
> >
> > I can see that this needs to be fixed, but your commit message needs
> > work. Please re-write like this:
> >
> >
> >  Add the range check to do_proc_int_conv_ms_jiffies_minmax that commit
> >  d174174c6776 ("sysctl: replace SYSCTL_INT_CONV_CUSTOM macro with
> >  functions") incorrectly removed.
> >
> >  Fixes: d174174c6776 ("sysctl: replace SYSCTL_INT_CONV_CUSTOM macro wit=
h functions")
> >  Signed....
> >
> > Why is that info about net is relevant here? I would remove it.
>=20
> Because it's the only relevant user.

I can see that, but the range check was removed because of a oversight
in d174174c6776, not because of anything happening in the caller. I
would just drop that info from the commit message.

>=20
> $ grep -rnI proc_dointvec_ms_jiffies_minmax
> include/linux/jiffies.h:649:int proc_dointvec_ms_jiffies_minmax(const
> struct ctl_table *table, int dir,
> net/core/neighbour.c:3679: ret =3D proc_dointvec_ms_jiffies_minmax(&tmp,
> write, buffer, lenp, ppos);
> kernel/time/jiffies.c:311:int proc_dointvec_ms_jiffies_minmax(const
> struct ctl_table *table, int dir,
>=20
> >
> > >  }
> > >
> > > --
> > > 2.55.0.1003.g10538fe699-goog
> > >

Please let me know if you will send a V2. Else I'll just push them at
the beginning of next week.

Best

--vlpa3s6j52uavssu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmqhY5sACgkQupfNUreW
QU8Hjgv/THmgbGy1nuSvm31r4oY5wMae8QgCoX1k0treIweTDtsucXHVMFpRR688
xEPy4JUzUCsmj1OlkrVCTDXFsETVUaoq2KZujW/1TNBjCGB7pF9tsY22qDvKDg99
oTUxT5XWxax2/SEUkvVFzpgziLLnK+/C2oiYz3f4wQmeiC7WAssFibGS1mKemDoc
yjkNDLmLYeOxiMRX85HWZmlzrY2kK5/OKVMjW5F4wDvvoBLBvu9PL44XRNxO3iL9
WcIa6YII2i3whzMPwEz/u+LWnr5thRESyTvjGSwYxjvkZL45LZj9Guh03FYr0ECk
pC61jBinUrTc7xKSNpQjpBk989nPmWHOUqVSKPZRz5cW2NuSrVsR534v0mtVvOHi
k7AbwPmeAhjJA7UxXVNDtCIskGR5eo5kBZ5rl0eCXyqUuEq6JDxXO/jfjhDNuEUM
R78RpIiFYCIMu7rfhrjUUsiqqSuZ59cab2DifXDRLwmbDCCDH0EfiE5+jkXTfxJ8
E6xaoNWx
=xPJy
-----END PGP SIGNATURE-----

--vlpa3s6j52uavssu--
