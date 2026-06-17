Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A20548A2C4;
	Wed, 17 Jun 2026 15:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781709910; cv=none; b=Ol3H6DMQBIzipLr7i+VF7uZ16G6md9GeqLMug82uAXJCgdOGTcjUa0Vf6KiI726wvqMprhINH64TMsjORqvOfL09KVYRbMJC3JTxgsQB0AyblLnpnSbddAtmA05YUJyoSa3ctljnyhXL1f02OoOQFaCdhtd8U1xt8tF8DUMaVb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781709910; c=relaxed/simple;
	bh=RJFjxPk7I35PG8LfQaqktHWLww4hlfU+HZ5u9tL4K6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ekcmBl3Kyd/sIrJDtXmrlSPnufODb4I3QSXEIhfe98z06b3ylCmcPUFl3Mk5KvaZ1rpfGYl9sVwANQxvCm9e8PzIuZPf8oZReoxBkNWHEctx+dcQ/Kn9ofXq1AhIumMZdegD8ZjairBHaJ5XPAmOg4esU1YCl2HkZMf9J4fkE7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oamYieFj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oamYieFj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B181F00A3A;
	Wed, 17 Jun 2026 15:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781709906;
	bh=nhoYS2ZfzGPqTLbpoet3XG0hWvTI1xCb3oBan4vyhY8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oamYieFj/kNzXvHuZt7qgH4SLNyfQfo5Re2zherszfcy8DwdFRGtO+/7LeHIIPfxd
	 /8jS5JOwEET2tVPRJJv5CRxRiUvoqIn5INTNjYSxHPoQCJEDX+22ntH+0tYNMoXdSA
	 eUd00ShDNfudLZBfwCKVfxCVvjJZYt15EQA7Xtpaz07l6Id0g6cH7kAu67tVXoqWTH
	 U8JylWoiPRf4nz9k7PtfLam35a3YPMlDbvzuvZ0S1QA0dYaChyKTKlJIlXh6NXAzt9
	 sNMF+mR9JMAqYIZN4Ckkl51ef7dX0vILWJfAYpN2td5dtqXKcFG5wJTiY+lTHfFmI1
	 HvicvvBYAh0/g==
Date: Wed, 17 Jun 2026 17:25:01 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Wen Yang <wen.yang@linux.dev>
Cc: Kees Cook <kees@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v5 0/2] sysctl: add CTLTBL_ENTRY_XXX() macros for
 ctl_table initialization
Message-ID: <57fctybn2i7fapt7mo466rou7pu2qfudhkqfmd22y2yu72uilh@zpaewmnbjqbo>
References: <cover.1774463505.git.wen.yang@linux.dev>
 <3626b4c0-319b-4944-b7ff-704ab146fd1e@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lfvlmlziax3fdm5i"
Content-Disposition: inline
In-Reply-To: <3626b4c0-319b-4944-b7ff-704ab146fd1e@linux.dev>


--lfvlmlziax3fdm5i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Wen

Sorry for not getting back to you sooner.

IMO, this is approach is the way to go to bring back the control of the
sysctl variables into the sysctl subsys files. Would like to get another
set of eyes on it before committing to it though.

I think it has not gotten too much attention because it does not touch
any other subsystem. Would you consider adding one subsys to the series?
Something like implementing it for the users in arch/ or fs/ or
drivers/.

Also, this might be a signal to park this temporarily and let it simmer
until more ppl are annoyed at making changes to the sysctl API.

Best

On Sat, Jun 13, 2026 at 11:56:50PM +0800, Wen Yang wrote:
> Hi Kees, H jioel,
>=20
> Gentle ping on this series. Please let me know if there are any
> concerns or if further changes are needed.
>=20
> The series is available at:
> https://lore.kernel.org/all/x5stdwwsfp2h22zyexn5ycbxnkyc4ioxscninxsa6q7lf=
6djqr@jkuppwwqubkp/
>=20
> Thanks for your time,
> Wen
>=20
>=20
> On 3/26/26 02:39, wen.yang@linux.dev wrote:
> > From: Wen Yang <wen.yang@linux.dev>
> >=20
> > Historically, changes to how struct ctl_table entries are initialized
> > (e.g. removing the child field, const-qualifying ctl_table) required
> > touching hundreds of files across all subsystems.  Such series require
> > the attention of many maintainers, sometimes need to be pulled into
> > mainline in a special way, and create lots of unnecessary churn.  With
> > CTLTBL_ENTRY_XXX(), future structural changes to struct ctl_table need
> > only update the macro definitions.
> >=20
> > Conversion of existing call sites will proceed incrementally from
> > kernel/sysctl.c outward, rather than as a treewide sweep.
> >=20
> > This series:
> >   1. Introduces the CTLTBL_ENTRY_XXX() macros in include/linux/sysctl.h,
> >      using _Generic() for automatic proc_handler selection, auto
> >      address-of, auto maxlen via sizeof(), and compile-time validation.
> >      Supported types: int, unsigned int, long, unsigned long, bool, u8.
> >   2. Converts kernel/sysctl-test.c as a demonstration, adding a
> >      parameterized KUnit test covering all macro variants (V, VM, VMR,
> >      VN, VNM, VNMH) across int, u8, bool, and char[] types.
> >=20
> > Based on discussion and suggestions from:
> > [1] https://sysctl-dev-rtd.readthedocs.io/en/latest/notes/ctltable_entr=
y_macro.html
> > [2] https://lore.kernel.org/all/psot4oeauxi3yyj2w4ajm3tfgtcsvao4rhv5sgd=
5s6ymmjgojk@p3vrj3qluban/
> >=20
> > ---
> > Changes in v5:
> >    - Extend __CTL_AUTO_HANDLER to support bool and u8
> >    - Replace individual test functions with a single parameterized KUnit
> >      test (KUNIT_CASE_PARAM) covering all variants and types
> >    - Use struct ctl_table as the expected-value container in the param
> >      struct, eliminating custom expected_* fields
> >=20
> > Changes in v4:
> >    - Fix Wpointer-type-mismatch warnings detected by lkp:
> >      https://lore.kernel.org/oe-kbuild-all/202603050724.SZxrEyyu-lkp@in=
tel.com/
> >=20
> > Changes in v3:
> >    - Replace the unique macro with "capital letter approach"
> >    - Reduce the name further
> >    https://lore.kernel.org/all/rn4rsazh7kxf5byq65vw2phyqgzvwm3scczu3l5h=
2r4aqit2r6@znlpb24z2zuo/
> >=20
> > Changes in v2:
> >    - Add lvalue check, handler type check, etc.
> >    https://lore.kernel.org/all/xptwb3uwbzposd4xf7khj52ifv4tchcjdgllhv7a=
abi6d7wgef@2msurl564v53/
> >=20
> >=20
> > Wen Yang (2):
> >    sysctl: introduce CTLTBL_ENTRY_XXX() helper macros
> >    sysctl: convert kernel/sysctl-test.c to use CTLTBL_ENTRY_XXX()
> >=20
> >   include/linux/sysctl.h | 307 +++++++++++++++++++++++++++++++++++++++++
> >   kernel/sysctl-test.c   | 237 ++++++++++++++++++-------------
> >   kernel/sysctl.c        |   2 +
> >   3 files changed, 447 insertions(+), 99 deletions(-)
> >=20

--=20

Joel Granados

--lfvlmlziax3fdm5i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmoyvEwACgkQupfNUreW
QU+4fwv+Ld+1XJPiF/j44uCWGeKYjh/aPBpEmkuPWPuoP1Kd+5A0caVL5RZAUh2a
QkmYyErmSEpOVW8ETtXq9RX2Jfp6cnovncQVv6OVPi/KVqpIuodPWP6L2Tixr2kw
rcnU4rDUR/KWK5LOZ56CMBo8tlA7NL7lKdYtPHqjAPs5exrqE+AzBATs28Th+jPs
j5i/yEk3fYC9JpwLqc3b+H5l4Hhh7n3hr0KJwH0OPKlY0la2uUyXt3J+t9bhPSq8
ayPIaHuxX4kxMaOJdvlX45iGLda0apybjRnM5E3u3LayWUQJ6j5dM7dKMolwfMlE
bZ8Xhf3O3JedQ4/GCRnE2Jp/I8yefZphRfOU85xx0KC/o8nMcZYrYPsMfs1xte5d
yVCHh8BVwV6o+pzPTdf6wU8dnnPHm4ZfUeCWcLZ1nCcaeXlcFVLLoJZgwPySTY7L
E4uuhfUTpMsnQbAwdtBHxYKvuO1FmTZ9w4lCOXicRwK8X8b8Pk218jDskYBb0IFS
02Z38c5j
=99EU
-----END PGP SIGNATURE-----

--lfvlmlziax3fdm5i--
