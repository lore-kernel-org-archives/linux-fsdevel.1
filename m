Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B990F49E5CD;
	Thu, 24 Sep 2026 15:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790262511; cv=none; b=eVOLkGl1qjz4STM44dpp7xOMIgNUlssoprFqrY3u6BuWog7VGztnhIxn4bzddaBrgghrb8Dk9It3SSG3s1OkHkL1pYCIgZGthHPWsvf1JDLk0ItbwK6Am9Lh4iq7QrEsFnghhEY4k1M7QFAaicoKIiuv7sp8AcjtJlUKUgl/x/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790262511; c=relaxed/simple;
	bh=13b2c0czPchSP1BbHgUKgSUynjX5KXsZu3QTKbD/MLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=arPP6lkhhym5hJYy1AzPgTOU7hjlGV2lvMGwKy/wuwvWHKJFlzCC4sVRNuo/VhhNMZT2E2OstNE4WHRuRq7IaaIJkUBdhgb94dgLcSmMIbe8mni9CwizvFSPSGwgNpu/xUPzf76BBulTF321VR+7eXJBSedAF0OlcR9VuQ/UDI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDz0P8h6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDz0P8h6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D29311F000FF;
	Thu, 24 Sep 2026 15:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790262502;
	bh=b6k+QgVrfAgeSbyU3DPd7xLInrXUU16GatbLwOPP0gI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CDz0P8h6zNdH+ABkgdDcOpfkD9rq8DYMTT+vHfTa/KG2rn/vCFx0uLGJuxynpaH0M
	 DK/dFfq1byoE2cqFxs9/oMuSQ2+RJ3Iflc3TPIAnbxOnnWI9tD4JGidvUHpMFG8qBz
	 ULN77lIQtmbYJPgoeCQMhdT7unTXPtDJIyX9VqDM2PlAIhIYB8pM/ehodLwKCQzPe5
	 d1YYDzGCJevtXRCLZ5nkOiuggHuaSn6EJnkP7rxZ5M+i7+B5SrDQQXV/yo70MpfbdA
	 tUaHb1HMc9wyreHh6kvpmBr+OO39bhKEupPfGXdd+6w3S93+2Zp1HHDrpf6pTKCvEE
	 AxUHdRODELEpw==
Date: Thu, 24 Sep 2026 17:08:16 +0200
From: Alexey Gladkov <legion@kernel.org>
To: Joel Granados <joel.granados@kernel.org>
Cc: Ondrej =?utf-8?B?TW9zbsOhxI1law==?= <omosnacek@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
	Serge Hallyn <serge@hallyn.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] sysctl: add unsigned int limit constants
Message-ID: <arU84H_lA0V3lwgV@example.org>
References: <cover.1789987960.git.legion@kernel.org>
 <92b31e85fbb91af953aee911a44787142cddee3f.1789987960.git.legion@kernel.org>
 <hc3jlqepedad5jbxz5rpskjktvbjcohorybc6kbtd7wtpajqi2@zftmndyhlw7a>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="udzds+e0skOy/lsr"
Content-Disposition: inline
In-Reply-To: <hc3jlqepedad5jbxz5rpskjktvbjcohorybc6kbtd7wtpajqi2@zftmndyhlw7a>

--udzds+e0skOy/lsr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 03:29:35PM +0200, Joel Granados wrote:
> On Mon, Sep 21, 2026 at 12:54:49PM +0200, Alexey Gladkov wrote:
> > Some sysctl handlers use unsigned int storage for their limit arguments.
> > In particular, proc_dou8vec_minmax() expects extra1 and extra2 to point
> > to unsigned int values even though the controlled data is an u8.
>=20
> This one reads like a fix as opposed to part of your series. Is it
> strictly needed for what you are proposing here?

Yeah, it turned out a bit wonky. Sorry.

What I was trying to say is that we don't have shared constants for
`unsigned int`. It doesn't matter right now since the size is the same,
but if we check the type at compile time, then it becomes important.

> >=20
> > Provide shared unsigned int constants so typed sysctl descriptors can
> > pass correctly typed min and max pointers without casting the existing
> > int constants.
> >=20
> > Signed-off-by: Alexey Gladkov <legion@kernel.org>
> > ---
> >  include/linux/sysctl.h | 7 +++++++
> >  kernel/sysctl.c        | 3 +++
> >  2 files changed, 10 insertions(+)
> >=20
> > diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
> > index e5d7226ab6f5..7139a4c72736 100644
> > --- a/include/linux/sysctl.h
> > +++ b/include/linux/sysctl.h
> > @@ -59,6 +59,12 @@ extern const int sysctl_vals[];
> >  #define SYSCTL_LONG_ONE		((void *)&sysctl_long_vals[1])
> >  #define SYSCTL_LONG_MAX		((void *)&sysctl_long_vals[2])
> > =20
> > +#define SYSCTL_UINT_ZERO	((unsigned int *)&sysctl_uint_vals[0])
> > +#define SYSCTL_UINT_ONE		((unsigned int *)&sysctl_uint_vals[1])
> > +#define SYSCTL_UINT_TWO		((unsigned int *)&sysctl_uint_vals[2])
> > +#define SYSCTL_UINT_THREE	((unsigned int *)&sysctl_uint_vals[3])
> > +#define SYSCTL_UINT_FOUR	((unsigned int *)&sysctl_uint_vals[4])
>=20
> I would really like to avoid that. Its one of the things that should
> probably go away in the future [1], [2], [3], [4]
>=20
> [1] https://lore.kernel.org/all/875xyczpzm.fsf@email.froward.int.ebiederm=
=2Eorg/
> [2] https://lore.kernel.org/all/tencent_C5E6023F97E7CC2A046AAEA09BC9ACF43=
907@qq.com/
> [3] https://lore.kernel.org/all/cover.1739115369.git.wen.yang@linux.dev/
> [4] https://lore.kernel.org/all/qnrzl4tjlgw5rzlvxavr3pt7fhkslnm4dd62q7uqz=
b3mfoa2jg@fuayx77rfcs6/

I don't mind removing them and using constants in the relevant source
files. I added these constants because they are used in the net subsystem.

As example:

https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/net/mptcp/ctrl.c#n294
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/ipc/ipc_sysctl.c#n110

>=20
> > +
> >  /*
> >   *
> >   * "dir" originates from read_iter (dir =3D 0) or write_iter (dir =3D =
1)
> > @@ -73,6 +79,7 @@ extern const int sysctl_vals[];
> >  #define SYSCTL_KERN_TO_USER(dir) (!dir)
> > =20
> >  extern const unsigned long sysctl_long_vals[];
> > +extern const unsigned int sysctl_uint_vals[];
> > =20
> >  typedef int proc_handler(const struct ctl_table *ctl, int dir, void *b=
uf,
> >  			 size_t *lenp, loff_t *ppos);
> > diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> > index f7b75985d542..54edaa2fd5d5 100644
> > --- a/kernel/sysctl.c
> > +++ b/kernel/sysctl.c
> > @@ -29,6 +29,9 @@ EXPORT_SYMBOL(sysctl_vals);
> >  const unsigned long sysctl_long_vals[] =3D { 0, 1, LONG_MAX };
> >  EXPORT_SYMBOL_GPL(sysctl_long_vals);
> > =20
> > +const unsigned int sysctl_uint_vals[] =3D { 0, 1, 2, 3, 4 };
> > +EXPORT_SYMBOL_GPL(sysctl_uint_vals);
> > +
> >  #if defined(CONFIG_SYSCTL)
> > =20
> >  /* Constants used for minimum and maximum */
> > --=20
> > 2.55.0
> >=20



--=20
Rgrds, legion


--udzds+e0skOy/lsr
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEfyo9BymBSaB5PJpOpFq6VEz/1DQFAmq1POAACgkQpFq6VEz/
1DShOA/+PWmFF3vI+9dk+i9PsGSlpiWHec37hYeC/GR3vF5OuyZ9bUpU0AWtmqUy
LRvZ7kPLzwSIx8aEx8wo7L0oL595wvb1dLZRJNBcc3Xh83FMLUHTF1FcJQzSMAwp
x72wSX8yxLrMRpFtlBeBLcf1E0PAsZx6NSHT6GIQz31JfBxeXQ0c68T7XpRPC3X6
do69q8KkqF9s1XRICWXf3ouPwEC22F9xSjvqk3D4dveI3PnYCmT13D6DjGKya/3o
Ajyp0L2ZXksrIX1zZcjjXMdxqLyHKt7i8Vh63xm2va9/C7g0oG1yaDr5MsR2F/uE
JIPP1aBC/hZe5x3r1nW4/VXkltMvHqtFoSpzVVJkamhP6eiOecH9eKmmKQFZWXAq
6q0aJUUYpyxfyKAZlR45vTd8x5ccl78Hkp2vZmdKuxBPLCECFdfI84yCaf52AakR
wHmDyQIwqr79y47ZsNLc3WODUmU2g7SOLJBxWy+o9mn36qtTNVQeCXr8Nra7toSm
uPOqXsO3wy1T75Avmy8V0p35Wd5xb3clVPh5njDsALU1m5VHs9cPLMjS1NJiFu6C
49LQ+dDmNkpd3O8rDCpHu0dMNNb0rCAJ5X7Z+VjfN5KAj576yO6nDryxl1TYs0ay
3A3mLOyU9LIa3EC7TelkTgs9TDnwVfa4dREddx1Iqf/X5ysGsgI=
=Ql97
-----END PGP SIGNATURE-----

--udzds+e0skOy/lsr--
