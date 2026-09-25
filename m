Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2188463B9B;
	Fri, 25 Sep 2026 11:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790336736; cv=none; b=ZT1QMOcKyruG38MvI4c86rMeaQ31B9fAyyCNBBCvcme6GDsdXtTbQ04uYuXo9fAeyxn06fTkuunFCOInRnN5A7OM4Wk7kIhXjoWs2nKsNxaQ+fh1OSZnzx9HIUCctFJBLhJS7QrjFxwxA2BwZBNUpV7EgtK5sgrOIkviret2Df4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790336736; c=relaxed/simple;
	bh=sOXEg71BUGKyDJrHdPBHLKpc3WpqngZcbILuz1oxTkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ddEATHnHF2Gu1rMNDzckCPEiw+ys8MG/HEr6tgDh9RuOdLxJ3xCi9KqBbMflm/nBbQBa7qLtvVNXPPOV7OsVlXTno1pA99BMf5INUqSN9Fx1367BNK3WNYphsNg0VtAmK8wV7y1XChXEvR08sP+PBVCP+awX/WbnXGf6Yclch/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmdRJn6Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmdRJn6Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42CEB1F0089E;
	Fri, 25 Sep 2026 11:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790336732;
	bh=ggwwsl+iq/VaBSGM1TzbVcxHERHXm/WV/VPmnlEAa9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jmdRJn6ZjVjXSdXvjm9E7H5DhjbwVi6p/pL8myI0oHyuu2DgZWaAZIkOrEV0yKFZK
	 36XhQCTsTWuXpch0BIVNx9qdsZgi7OYoLt7Q4/BVTvqjPzEDFbWM1I6tO/lw7HlkGe
	 UKN2M6EdpWxP0CFIJd/fWcLv7dk+NQ69ABEjBtNQWCPP36RlIpt21ySOXbyTeton+2
	 +Rgnxx5NNiBYSP6f24xvdytsg99BqA459GulAUeQVROuLMXpOv05ie5B42xLkPAH/F
	 /1sdTYR76F3FW2GTYpZS1AevCJ+u0rTABXjkd/5gAzdLb65uV0QlISJ8p6e4msQTkR
	 Kb0iTBFH7C4eQ==
Date: Fri, 25 Sep 2026 13:45:27 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Bradley Morgan <brads@mainlining.org>
Cc: Zhan Xusheng <zhanxusheng1024@gmail.com>, 
	Zhan Xusheng <zhanxusheng@xiaomi.com>, Kees Cook <kees@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests: sysctl: Check the sign of a negative
 jiffies read
Message-ID: <4wuqtjbpekdnpf6gn7pjc32bed2ln44unp2dd2zatiju4zeq5e@efqhttn3pfyc>
References: <20260923144940.3712965-1-zhanxusheng@xiaomi.com>
 <20260923144940.3712965-3-zhanxusheng@xiaomi.com>
 <6DBE514E-E307-4E8E-999B-1B5592CE9AC5@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nu4apolu3sbk76tk"
Content-Disposition: inline
In-Reply-To: <6DBE514E-E307-4E8E-999B-1B5592CE9AC5@mainlining.org>


--nu4apolu3sbk76tk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 04:53:54PM +0100, Bradley Morgan wrote:
> On 23 September 2026 15:49:37 BST, Zhan Xusheng <zhanxusheng1024@gmail.co=
m>
> wrote:
> >proc_int_k2u_conv_kop() returns the sign through *negp and the magnitude
> >through *u_ptr.  For a negative value it used to convert the
> >sign-extended int and negate afterwards, so the magnitude came back as a
> >wrapped 64-bit number.  Nothing noticed, because no test wrote a
> >negative value to a jiffies sysctl.
> >
> >Write one to each of the three int converters and require the value to
> >read back unchanged.  Each value is chosen to convert exactly at every
> >CONFIG_HZ, so the test does not depend on it:
> >
> >	converter		write	jiffies stored	reads back
> >	jiffies			-1	-HZ		-1
> >	ms_jiffies		-1000	-HZ		-1000
> >	userhz_jiffies		-100	-HZ		-100
> >
> >On a kernel without the fix, at CONFIG_HZ=3D250:
> >
> >  # int_jiffies: got '-18372957097414713411', want '-1'
> >  # int_ms_jiffies: got '-18446744069414585320', want '-1000'
> >  # int_userhz_jiffies: got '-18446742229035144346', want '-100'
> >  not ok 1 test_int_jiffies_negative
> >
> >(paths shortened; the runner prints them under
> >/proc/sys/debug/test_sysctl)
> >
> >Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
> >---
> > tools/testing/selftests/sysctl/sysctl.sh | 23 +++++++++++++++++++++++
> > 1 file changed, 23 insertions(+)
> >
> >diff --git a/tools/testing/selftests/sysctl/sysctl.sh b/tools/testing/se=
lftests/sysctl/sysctl.sh
> >index ceb5cfa0cfd4..ad1ee0fccd7c 100755
> >--- a/tools/testing/selftests/sysctl/sysctl.sh
> >+++ b/tools/testing/selftests/sysctl/sysctl.sh
> >@@ -328,6 +328,29 @@ test_int_plain()
> > 	assert_int_range "$t" "$baseline" || RET=3D$KSFT_FAIL
> > }
> >=20
> >+# The jiffies converters report the sign separately from the magnitude,=
 so a
> >+# negative value must survive the round trip through the converter.  Ea=
ch
> >+# value below is chosen to convert exactly at every CONFIG_HZ.
>=20
> I have a feeling this could be decreased, but I don't care.

If you don't care, don't comment.
>=20
> Reviewed-by: Bradley Morgan <brads@mainlining.org>
>=20
>=20
> Tested on PowerPC:=20
>=20
> Tested-by: Bradley Morgan <brads@mainlining.org> # POWER10

Please don't suffix anything after the tag as b4 picks it up.

Best

--nu4apolu3sbk76tk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmq2XtYACgkQupfNUreW
QU+lPwv6AuNOKqmNNLHxDYSsKVPMgOFn5QqC5HOXon5Jx+J78PWJDHtUen3O2bK+
tamEGQbwRTvl5wLq5D1QC9AoHGs4AL4xX7PK7kFc5MCkysGe4b4fZlhKZ8sPqIsI
/rZvV5+gKof/1+1rHPrNmC6jHyWGMYzjO0FIa3lr/IrcO7hUQrzxwYlQ7lymUkpi
Y02PPY9cbh3oGstcDQSJTr9XcwX0DWLcJepyqh8R4tOq7KHJqBwet7bVIqjizi84
KvA0BUytLPJIA8um2qMCMJ5WqTxMwo/6rfr/Cnx7nF97ggWCP8YlH9dz2QDIzRXi
l9oQ4nUjgmp43LysKxXVA6pbWNny/M6B3m1SR7CVkgPqWPH7n+tyGH9mclujqnp3
Fy9gqEn9Sapxb2hHXzbPL0o2J1XpLPph1a2v2NFj8rMyHwRo5/o5h5DgJM/syoY7
SMhUiThzpjKlwJJJrBDilWqodAFNj2QTxng89EdGr31OUqxASWwZo+CWGGwkFC1q
JcyX5d6W
=jVUN
-----END PGP SIGNATURE-----

--nu4apolu3sbk76tk--
