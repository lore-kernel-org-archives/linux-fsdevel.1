Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60CC3C10BB;
	Wed, 16 Sep 2026 12:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789561569; cv=none; b=sDOCPlsQPYjWaJWoaigDurSdE58HMyfg+FH9mJh25vAbd+GFhFRDhDESTSvHUzoeQrwPmGxb/HayukJglR5VhT/pC8gG1EFbZa5zDTyQIG7Nbs5qFI7hwVXhZmdMvZvqCPHytWgNcHH8hSQYIUWhZDzEbt5GcWs427ZJZz0ewl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789561569; c=relaxed/simple;
	bh=vqKzd4dFbs4KkWmzBQWA30bj92AdJcXvaN1CNUW+S94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X+7LJBvFBk3II9xybt6fw8be2tV0GLRGeBvv7TiXVDzV9kqDbkPJK8dvGkRzctdQ+osLo4Bm39lS8LKLo+If1Vxm1Vorne4SMK6++b0zReNl9x1ErNDoF+tkCXEIojNZy72xeM2yaCRPO38jlEss65gqlJ11iSeTDT2G6eszeC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GfyQ5/X9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GfyQ5/X9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C66221F000FF;
	Wed, 16 Sep 2026 12:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789561567;
	bh=2+uaFqrDymEEOiN3IjYKAAj/z0Ac6x8hPL7hYAiwI1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GfyQ5/X9+Uilp6CpniQxYB1cRpGh7aONVysAq5AFzMSj0kLcEHWWL0JmgmLqwOhQr
	 fq2bRXAtPHa/bPev4EK9oQ3ShRLXFpE+FUKrtbGt7MQ+O6MWejQhC53S0HnIXj0c//
	 HB0kArS03ryQUu44vIFWYYlT7ORidgy6lHmdSeyemOLOe/nsnFI29rjrlA0ucVkgAw
	 hnmBRZbJqd4q1Vti07FMi+Ekb6pC4ZbukVvC5pbYPvqNRRUpJeVHUULlJKljQk0c7e
	 /M/Aoue9tPtoofTWYVdGD/BGdFVsJK8JwxTSfJa8EKGPjMZEiwyRNenIPM10oRrIJl
	 Qxbikl/Gzpf8w==
Date: Wed, 16 Sep 2026 14:26:01 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Alexey Gladkov <legion@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	"Eric W . Biederman" <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH v1 17/30] sysctl: net: use sysctl_field in SCTP
 sysctls
Message-ID: <2ywlit7st4wqghx2lav6qc5bbcxbaln445fghjnwj5n7dg2w4v@ajhrrgm5ck4r>
References: <CAHk-=wjUmLrJd4KM4xvJHUN4P0r8oSu5LyvG4JipnhxizBrE9Q@mail.gmail.com>
 <cover.1788018958.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vudzi3v3ggrs4vyi"
Content-Disposition: inline
In-Reply-To: <cover.1788018958.git.legion@kernel.org>


--vudzi3v3ggrs4vyi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 29, 2026 at 06:14:43PM +0200, Alexey Gladkov wrote:
> On Wed, Aug 26, 2026 at 01:29:00PM -0700, Linus Torvalds wrote:
> > I detest this series.
> >=20
> > Maybe it makes technical sense, but as long as it makes no human
> > visual sense, I'm NAK'ing it as being garbage.
>=20
> You are right that my approach added too many macros and made the tables
> harder to read. Sorry.
>=20
> > On Wed, 26 Aug 2026 at 12:43, Alexey Gladkov <legion@kernel.org> wrote:
> > >
> >  [..]
> >=20
> > The whole series is full of complete illegible noise like this:
> >=20
> > > +static const struct sysctl_field sctp_net_table[] =3D {
> > > +       SYSCTL_FIELD_CUSTOM("rto_min", 0644, sizeof(unsigned int),
> > > +                        sctp_rto_min_data, proc_sctp_do_rto_min),
> > > +       SYSCTL_FIELD_CUSTOM("rto_max", 0644, sizeof(unsigned int),
> > > +                        sctp_rto_max_data, proc_sctp_do_rto_max),
> > > +       SYSCTL_FIELD_INT_MINMAX("pf_retrans", 0644, sctp_pf_retrans_d=
ata,
> > > +                            SYSCTL_ZERO, sctp_ps_retrans_data),
> > > +       SYSCTL_FIELD_INT_MINMAX("ps_retrans", 0644, sctp_ps_retrans_d=
ata,
> > > +                            sctp_pf_retrans_data, sctp_ps_retrans_ma=
x_data),
> > > +       SYSCTL_FIELD_STATIC_UINT_MINMAX("rto_initial", 0644,
> > > +                                    sctp_rto_initial_data,
> > > +                                    SYSCTL_UINT_ONE, &timer_max),
> > [...]
> >=20
> > where apparently the indentation has been decided by a rodent on crack
> > who was given an Ouija board and instructed to ask his dead ancestors
> > what indentation to use.
> >=20
> > So no.
> >=20
> > That kind of complete random code is simply not acceptable.
> >=20
> > I don't know what the correct answer is, but it is *not* this series.
> > It needs to be consistent and visually parseable by humans *without*
> > asking your dead ancestors for help.
> >=20
> > And it's not just the indentation. That SYSCTL_FIELD_CUSTOM() thing
> > needs to be usable and able to do some minimal type checking - not
> > just passed a random sizeof() in a random argumentt. I'd suggest
> > passing the actual type, and then checking that the type *matches* the
> > data pointer it is passed too.
> >=20
> > The old code may be ugly too, and have various other warts, but at
> > least it had somewhat legible and understandable initializers:
> >=20
> >         {
> >                 .procname       =3D "prsctp_enable",
> >                 .data           =3D &init_net.sctp.prsctp_enable,
> >                 .maxlen         =3D sizeof(int),
> >                 .mode           =3D 0644,
> >                 .proc_handler   =3D proc_dointvec,
> >         },
> >=20
> > is at least something that can be read by a human and those things had
> > consistent whitespace rather than some quantum randomness.
> >=20
> > And this is also just complete line noise that only makes the code wors=
e:
> >=20
> >     +#define SCTP_DATA(type, field)                                    =
     \
> >     +static type *sctp_ ## field ## _data(const struct sysctl_context *=
ctx) \
> >     +{                                                                 =
     \
> >     +       return &ctx->ns.net_ns->sctp.field;                        =
     \
> >     +}
> >     +
> >     +#define SCTP_CUSTOM_DATA(field)
> >              \
> >     +static void *sctp_ ## field ## _data(const struct sysctl_context *=
ctx) \
> >     +{                                                                 =
     \
> >     +       return &ctx->ns.net_ns->sctp.field;                        =
     \
> >     +}
> >     +
> >     +SCTP_CUSTOM_DATA(rto_min)
> >     +SCTP_CUSTOM_DATA(rto_max)
> >     +SCTP_DATA(int, pf_retrans)
> >     +SCTP_DATA(int, ps_retrans)
> >     +SCTP_DATA(unsigned int, rto_initial)
> >     [...]
> >=20
> > If we're doing these kinds of changes, the end result has to look
> > *BETTER* than the thing it replaces, not worse.
> >=20
> > Yes, a few of the patches did look better. But the majority of them
> > only looked worse. Some of it should be easy to fix: use consistent
> > whitespace, and use sane argument ordering.
> >=20
> > But honestly, the old setup didn't *rely* on argument ordering, and
> > used named initializers to make things more legible and robust.
> >=20
> > So I suspect that should be what you should aim for in the new setup
> > too, and that probably means "completely different approach".
> >=20
> >                Linus
> >=20
>=20
> I tried an alternative based on offsets. The following four patches add t=
he
> infrastructure and convert IPC, SCTP, and MPLS as examples.

The last 4 patches landed intertwined with the initial 30+ that you sent. W=
ill
you send a V2 with just the latest 4?

Best

--vudzi3v3ggrs4vyi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmqqitkACgkQupfNUreW
QU+6wQv6AqxGWYVfHZbEd1DZWpU7WYk31ueivIhgI7eDpIOgZyLtSrIYuDrwXdmH
AgP7clqPAX5Xvguwr554gR/XHUxIg3NIw8g5yt7ImHjzq9/nHZmBCV87PwBuCxUw
QilDL7UyaDi4TIPrg87Lmb6womYmbbsSXNZOkcXoIVtR+a7sQ1X1j5ofmPhRHoio
JL+q1YFJ8A7RLcNFwgmaweVRKJ4mlEjTGkCA9J4YVw7R/1hegpX+MOh9yDkmnPBx
pMsGa73x6+agxf4q6CjLLCElnXUfVOtiA2RembMk64mTHEJpZe9pPEMXL+uTBbQw
GPd2baoT8jNYOGgzO5limXYqkNLRW99TYjVpfTxknHdEEUMN2ghr0LKpBxin4zef
Rv/0qY5CW31lI897hrrGzzmMR7FYIihBQd6747BVFQmkrfjWCFlAO47L2OKWpfAZ
9EeTQPYAARwCsnJfvEBbAJiofRG7vVxc1L/H1wGX6LZ59xr/Yj43hPyFc6GTbK73
zFwYnihR
=HG5X
-----END PGP SIGNATURE-----

--vudzi3v3ggrs4vyi--
