Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3003947B5;
	Tue,  7 Apr 2026 07:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775546939; cv=none; b=RfL8ggLvDWgw6NaLVzrCFpm5IAsmle6F5N/3JF3yeOv4ExpDJoP27A1d8/LBjBZ5aEhQ3ldIk0SUGl3xR/mAduUcVl5Vyfb9OdSxIf3d6zJgItoD1pJVr9Pl8oATNIYG+YUIyPtsHtuNYRZ5j/F+MvOSOpek0BSWDUQOCNXjJtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775546939; c=relaxed/simple;
	bh=/jv/C01Vtyakr2bK5siV/tuQgn2hwB/xvnPsS9Zb8ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2gPCtud96B3zQV7sNkw7zksUqws+z/v04NoCAJ0yMStD74lSQgWjRFmty8EbFXzQjsNmE3j08n7q1vQkDniVAkKa+BSG55fuZrwKwxHhEXDPxABwvPZzJh8EyeEz+zIPADDvIDzo1hprkdb1Yrtt94xlmkkuZwZgmc64i0qPBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvAqihuG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvAqihuG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09929C2BC9E;
	Tue,  7 Apr 2026 07:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775546939;
	bh=/jv/C01Vtyakr2bK5siV/tuQgn2hwB/xvnPsS9Zb8ok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jvAqihuGBfnbimm7xAZaduLse6GUOq0qz1Ghv/5wAF3jOlKPPUApk+dQgXx5JP+mX
	 1YbeaOKCSsUZUyknUOHZc9RF8yGIdOv3F4qYjFQf9gMosKeJoJDmkkpf7W12mSvHBy
	 8yPBfMLX8gNyGSI1z/R1xVimB4sIbTDnv5dV8Q09y7mlD18NIvfnmHa+zyhlfVgsum
	 ScflhdfI80cQmVG+7NvhRoPipXernlJ3ab2Np1aYXBZHE3MyBwMWTCvsTnYR+0HGaR
	 JY0ODh4OAoLZdqfQHZB6FQVmk6qi8FfCkweW2nEPzJppXsdYc3Eh2q+Z2EapGwv0pC
	 DBfstneVc3Gkg==
Date: Tue, 7 Apr 2026 09:28:52 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Kees Cook <kees@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v5 0/2] sysctl: add CTLTBL_ENTRY_XXX() macros for
 ctl_table initialization
Message-ID: <x5stdwwsfp2h22zyexn5ycbxnkyc4ioxscninxsa6q7lf6djqr@jkuppwwqubkp>
References: <cover.1774463505.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aa47zolqu2fdk72e"
Content-Disposition: inline
In-Reply-To: <cover.1774463505.git.wen.yang@linux.dev>


--aa47zolqu2fdk72e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Kees

I have been trying to avoid having to do a treewide change everytime
that the sysctl ctl_table struct are changed, it creates unnecessary
churn and requires a "review" when there is really no need for it.

This series tries to move the definitions of the struct elements into a
macro within sysctl. I was wondering if you see any red flags that
should be address before this moves forward.

Best

On Thu, Mar 26, 2026 at 02:39:14AM +0800, wen.yang@linux.dev wrote:
> From: Wen Yang <wen.yang@linux.dev>
>=20
> Historically, changes to how struct ctl_table entries are initialized
> (e.g. removing the child field, const-qualifying ctl_table) required
> touching hundreds of files across all subsystems.  Such series require
> the attention of many maintainers, sometimes need to be pulled into
> mainline in a special way, and create lots of unnecessary churn.  With
> CTLTBL_ENTRY_XXX(), future structural changes to struct ctl_table need
> only update the macro definitions.
>=20
> Conversion of existing call sites will proceed incrementally from
> kernel/sysctl.c outward, rather than as a treewide sweep.
>=20
> This series:
>  1. Introduces the CTLTBL_ENTRY_XXX() macros in include/linux/sysctl.h,
>     using _Generic() for automatic proc_handler selection, auto
>     address-of, auto maxlen via sizeof(), and compile-time validation.
>     Supported types: int, unsigned int, long, unsigned long, bool, u8.
>  2. Converts kernel/sysctl-test.c as a demonstration, adding a
>     parameterized KUnit test covering all macro variants (V, VM, VMR,
>     VN, VNM, VNMH) across int, u8, bool, and char[] types.
>=20
> Based on discussion and suggestions from:
> [1] https://sysctl-dev-rtd.readthedocs.io/en/latest/notes/ctltable_entry_=
macro.html
> [2] https://lore.kernel.org/all/psot4oeauxi3yyj2w4ajm3tfgtcsvao4rhv5sgd5s=
6ymmjgojk@p3vrj3qluban/
>=20
> ---
> Changes in v5:
>   - Extend __CTL_AUTO_HANDLER to support bool and u8
>   - Replace individual test functions with a single parameterized KUnit
>     test (KUNIT_CASE_PARAM) covering all variants and types
>   - Use struct ctl_table as the expected-value container in the param
>     struct, eliminating custom expected_* fields
>=20
> Changes in v4:
>   - Fix Wpointer-type-mismatch warnings detected by lkp:
>     https://lore.kernel.org/oe-kbuild-all/202603050724.SZxrEyyu-lkp@intel=
=2Ecom/
>=20
> Changes in v3:
>   - Replace the unique macro with "capital letter approach"
>   - Reduce the name further
>   https://lore.kernel.org/all/rn4rsazh7kxf5byq65vw2phyqgzvwm3scczu3l5h2r4=
aqit2r6@znlpb24z2zuo/
>=20
> Changes in v2:
>   - Add lvalue check, handler type check, etc.
>   https://lore.kernel.org/all/xptwb3uwbzposd4xf7khj52ifv4tchcjdgllhv7aabi=
6d7wgef@2msurl564v53/
>=20
>=20
> Wen Yang (2):
>   sysctl: introduce CTLTBL_ENTRY_XXX() helper macros
>   sysctl: convert kernel/sysctl-test.c to use CTLTBL_ENTRY_XXX()
>=20
>  include/linux/sysctl.h | 307 +++++++++++++++++++++++++++++++++++++++++
>  kernel/sysctl-test.c   | 237 ++++++++++++++++++-------------
>  kernel/sysctl.c        |   2 +
>  3 files changed, 447 insertions(+), 99 deletions(-)
>=20
> --=20
> 2.25.1
>=20

--=20

Joel Granados

--aa47zolqu2fdk72e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmnUsi0ACgkQupfNUreW
QU+5/QwAj842I5ZtLWf65FEk5vyOCsakqB6XjTibHyjI1T++L8c258tvuj8uIIIQ
hoy8LMbmOHWHrXmjI85VaTSxG8NtUAHyWhgNI+SdDF38CK8xc6dbwqA9bCP9AgRw
5cYL8jh4fntBEnn1KHjhnK0eD/7Ftv4YBkAT6b3ff1JwhQgB0x7Ee97iIOZ4p/pK
jS43kXwcywege71Tlq6MIoM3w3Pd+xwpmFaUjU+R7TGSRmOApU8NeUy3fL92/l+a
ZAvJ8acyUB9XQB0vuPC99L4CZ14GgjDYuddvkFVKC3pl3ngzocHSQlwg/WVYr0sB
ByizRNeCNtQ2uoOG2kQU1tLNVgmlsRH+Fte8TcmmnnhKnjWjLzo2ZBSIA24GuaqM
VDlMRizafnm+zUgQSEerA7UkUMLAUr/fxgRh9TDz+B3IXpfdnuqgUAdsA6ejchb0
VfW9XiIjLJ/Y3PzRW/saAal1uifJkJYJxZ+rWiQm3SYaL2oagUhni28HSEayP5VJ
1Kc99Plx
=kRIi
-----END PGP SIGNATURE-----

--aa47zolqu2fdk72e--
