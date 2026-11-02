Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793622191;
	b=a6kE2KyW/vJQ3Ut/q/ob/bEQgscztpoZ65S7QTv3A9J+e3rAheNCkqY2LFVaVfDIS7sj
	 IaIuv+cJjnjnGhDdjpp5T4HkH9GMTKb3VlbYN2Fop52174CtNR1qq3x15L4LMG2D4Lz9O
	 TOwn+m+KkeYQsvE5Bqb06KmGf/2YZTZnQST9ef+/hzei65DLy9dzaEbDb9Tw7fvsVEmsc
	 UT49ZqYKKobR1TyMmVmNIULK2qC+HqoX9MOWbwDLlBnqwy5VL4+fdcVjU6QKXttyaia6M
	 TeMMWoSsgDzaOHjDktvU1+TaCBRKTyd65etxlfsp3Ijn7a7gnJ3sE5rMjR1+k5ktMmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793622191;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=FSbH5y4Cm4I/JWPzjG0ep3EU6xcli+WM9tIJTPykZw8=;
	b=AlWCc282QIicDbjXBcByfPFPBSI33aeu1rHjwiebGUWQmrxOCQpQOndQ2eilhTCwkKGD
	 Tzi8Lboreeq1ZULXAQBJ9hc8lrUl7iiJR8zjTQTlOd1gl3JRnrvgk8vmAUKkFfdGlXQig
	 PlB+k7Sk4n3E1FAiWqZcs/RsdC6wPmxSkkX2pQE73Y+6ESlxCe92K5rhXpnAYm93+YUZN
	 uKf6BPN5Bla6EwP+j4I/Vd6rruZ20s2956wZQiSD4JPIfok/o9HWhBw4JF8E4VBt22IMo
	 MKUbONoK5UhytJifBMwsa3YxKT9cB8munTRQCAw8WEkm/y9l4G6vky0DZTN9uu6RFPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n4uQsnnV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E6C60A2615;
	Mon,  2 Nov 2026 12:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n4uQsnnV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D6A1F00A16;
	Mon,  2 Nov 2026 12:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793622190;
	bh=FSbH5y4Cm4I/JWPzjG0ep3EU6xcli+WM9tIJTPykZw8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=n4uQsnnVQgSDJASB99KMovLTK9lo4N3dCu1Dt2kVFikNCV8haz+Wh+OQQuEr5oJmP
	 4sxN1P2StCXbpRYyH83bn4Pf2lFo3j1jElOalwOsKyl+me4aL+gbiX5XSjAY2U8gdj
	 leCZOD3RhiunJGblLISySxuuXmyrQvFOx+v5/+lbuynamBVISNrxOyo92tzBfDaRAR
	 gRjHJmQzOVrlXwWfrFHs2M3bAdxkWy8WXx0eAkq09B8x1lX5zezNgpX0QNGzqPLAuA
	 Ncp1MBdYwiNWEReEZXyq/tPolVsdyDADGB/Nnw4yEJ9UII3i+aUwYt2fciIqUwW/ph
	 CVhW2mxLB3XRw==
Date: Mon, 2 Nov 2026 13:23:04 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Wen Yang <wen.yang@linux.dev>
Cc: Kees Cook <kees@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v5 0/2] sysctl: add CTLTBL_ENTRY_XXX() macros for
 ctl_table initialization
Message-ID: <auh_b-jm5yW5ouh5@hobbes>
References: <cover.1774463505.git.wen.yang@linux.dev>
 <3626b4c0-319b-4944-b7ff-704ab146fd1e@linux.dev>
 <57fctybn2i7fapt7mo466rou7pu2qfudhkqfmd22y2yu72uilh@zpaewmnbjqbo>
 <6047c828-07a4-449e-aaa6-8fa182c11cba@linux.dev>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yzrxywgc5zbfh7m7"
Content-Disposition: inline
In-Reply-To: <6047c828-07a4-449e-aaa6-8fa182c11cba@linux.dev>


--yzrxywgc5zbfh7m7
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH v5 0/2] sysctl: add CTLTBL_ENTRY_XXX() macros for
 ctl_table initialization
MIME-Version: 1.0

On Sun, Oct 25, 2026 at 12:43:37AM +0800, Wen Yang wrote:
>=20
>=20
> On 6/17/26 23:25, Joel Granados wrote:
> > Hey Wen
> >=20
> > Sorry for not getting back to you sooner.
> >=20
> > IMO, this is approach is the way to go to bring back the control of the
> > sysctl variables into the sysctl subsys files. Would like to get another
> > set of eyes on it before committing to it though.
> >=20
> > I think it has not gotten too much attention because it does not touch
> > any other subsystem. Would you consider adding one subsys to the series?
> > Something like implementing it for the users in arch/ or fs/ or
> > drivers/.
> >=20
> > Also, this might be a signal to park this temporarily and let it simmer
> > until more ppl are annoyed at making changes to the sysctl API.
> >=20
> > Best
> >=20
>=20
> Hi Joel,
>=20
> Apologies for the long delay, and thank you for your helpful feedback.
>=20
> I've been tied up with other commitments, but can now return to this
>=20
> work and prepare v3 based on your suggestions.
>=20
>=20
>=20
> Given the time that has passed, I'd appreciate any updated advice or
>=20
> related developments I should take into account.

There is now more clarity that the use of MACROS like we had discussed
for this series is probably not the way to go. In [1] it is clear that
the overuse of macros will probably be rejected once it gets upstream.
So for now I would let this implementation go.

Best

[1] https://lore.kernel.org/all/CAHk-=3DwjUmLrJd4KM4xvJHUN4P0r8oSu5LyvG4Jip=
nhxizBrE9Q@mail.gmail.com
>=20
>=20
>=20
> Thanks again for your time and patience.
>=20
>=20
> --=20
>=20
> Best regards,                                                            =
Wen
>=20
> > On Sat, Jun 13, 2026 at 11:56:50PM +0800, Wen Yang wrote:
> > > Hi Kees, H jioel,
> > >=20
> > > Gentle ping on this series. Please let me know if there are any
> > > concerns or if further changes are needed.
> > >=20
> > > The series is available at:
> > > https://lore.kernel.org/all/x5stdwwsfp2h22zyexn5ycbxnkyc4ioxscninxsa6=
q7lf6djqr@jkuppwwqubkp/
> > >=20
> > > Thanks for your time,
> > > Wen
> > >=20
> > >=20
> > > On 3/26/26 02:39, wen.yang@linux.dev wrote:
> > > > From: Wen Yang <wen.yang@linux.dev>
> > > >=20
> > > > Historically, changes to how struct ctl_table entries are initializ=
ed
> > > > (e.g. removing the child field, const-qualifying ctl_table) required
> > > > touching hundreds of files across all subsystems.  Such series requ=
ire
> > > > the attention of many maintainers, sometimes need to be pulled into
> > > > mainline in a special way, and create lots of unnecessary churn.  W=
ith
> > > > CTLTBL_ENTRY_XXX(), future structural changes to struct ctl_table n=
eed
> > > > only update the macro definitions.
> > > >=20
> > > > Conversion of existing call sites will proceed incrementally from
> > > > kernel/sysctl.c outward, rather than as a treewide sweep.
> > > >=20
> > > > This series:
> > > >    1. Introduces the CTLTBL_ENTRY_XXX() macros in include/linux/sys=
ctl.h,
> > > >       using _Generic() for automatic proc_handler selection, auto
> > > >       address-of, auto maxlen via sizeof(), and compile-time valida=
tion.
> > > >       Supported types: int, unsigned int, long, unsigned long, bool=
, u8.
> > > >    2. Converts kernel/sysctl-test.c as a demonstration, adding a
> > > >       parameterized KUnit test covering all macro variants (V, VM, =
VMR,
> > > >       VN, VNM, VNMH) across int, u8, bool, and char[] types.
> > > >=20
> > > > Based on discussion and suggestions from:
> > > > [1] https://sysctl-dev-rtd.readthedocs.io/en/latest/notes/ctltable_=
entry_macro.html
> > > > [2] https://lore.kernel.org/all/psot4oeauxi3yyj2w4ajm3tfgtcsvao4rhv=
5sgd5s6ymmjgojk@p3vrj3qluban/
> > > >=20
> > > > ---
> > > > Changes in v5:
> > > >     - Extend __CTL_AUTO_HANDLER to support bool and u8
> > > >     - Replace individual test functions with a single parameterized=
 KUnit
> > > >       test (KUNIT_CASE_PARAM) covering all variants and types
> > > >     - Use struct ctl_table as the expected-value container in the p=
aram
> > > >       struct, eliminating custom expected_* fields
> > > >=20
> > > > Changes in v4:
> > > >     - Fix Wpointer-type-mismatch warnings detected by lkp:
> > > >       https://lore.kernel.org/oe-kbuild-all/202603050724.SZxrEyyu-l=
kp@intel.com/
> > > >=20
> > > > Changes in v3:
> > > >     - Replace the unique macro with "capital letter approach"
> > > >     - Reduce the name further
> > > >     https://lore.kernel.org/all/rn4rsazh7kxf5byq65vw2phyqgzvwm3sccz=
u3l5h2r4aqit2r6@znlpb24z2zuo/
> > > >=20
> > > > Changes in v2:
> > > >     - Add lvalue check, handler type check, etc.
> > > >     https://lore.kernel.org/all/xptwb3uwbzposd4xf7khj52ifv4tchcjdgl=
lhv7aabi6d7wgef@2msurl564v53/
> > > >=20
> > > >=20
> > > > Wen Yang (2):
> > > >     sysctl: introduce CTLTBL_ENTRY_XXX() helper macros
> > > >     sysctl: convert kernel/sysctl-test.c to use CTLTBL_ENTRY_XXX()
> > > >=20
> > > >    include/linux/sysctl.h | 307 +++++++++++++++++++++++++++++++++++=
++++++
> > > >    kernel/sysctl-test.c   | 237 ++++++++++++++++++-------------
> > > >    kernel/sysctl.c        |   2 +
> > > >    3 files changed, 447 insertions(+), 99 deletions(-)
> > > >=20
> >=20

--yzrxywgc5zbfh7m7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmrogKEACgkQupfNUreW
QU/r2Qv/aA/JLZIYrI7cC21zrH3GDKZXWm+eKZDjD9rPwp4CbShOmdaNTtkC634z
vFw+Nq8Od26eOb9sgIvr/Q746PjufCkTNaowrYOUHr0pxpFUNfEpPG+G/GO2vaNd
vgkMeWP+Uumm5XKQR0Ixel6IH928fzq8RqGMpxeZRsqLnzTTD0aJRlu9TJvfOaIE
9Rp5OkpMkVIJGcKWU5ZyQ1cdGbAO5H96zfno7lzm+Yl8FyYld06GnGAiQVrPDj1g
0KpRkOGVEn8gW8aBA08MwGu8qODoGOAdN2mf13GQDWdXKHTLfMlVeFsB/hdtYc98
vY0M5diLtnIuxyZqEkRZ4xNBPxbeXrCgwXDD6etBsVsBYPELWKeGaTAEj8QZw08W
Nraxnp51zEKfACRto5JA+//eKZ65J5ZM2v2J5WP/p7RYGIRfsrwV8ABbxTRtJPDz
UJ16UhVvF0mz+wKX0apVRcUeVB2ZROvcuCaTob0fZvT5GRbBFo4DWh8pYTWXVdxh
WiXYQfBl
=LVqN
-----END PGP SIGNATURE-----

--yzrxywgc5zbfh7m7--
