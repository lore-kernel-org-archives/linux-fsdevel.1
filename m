Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1EB46EC60;
	Tue, 18 Aug 2026 12:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787057226; cv=none; b=MTHyNaPAkjGidj+iNNQq8GUkx/+py6X9qx6I3xMqephJ4+/rYruuhtbpxFP1a/pdqT/R2C/zkU0vBV32k12tAc/07sAyKvuT3fNRwlrNXiNGU1QoK1PZeSByKhNLgz9wTQBbb4zrEKJAIw3JmbV2JXvruaXTdX5sfuGr+C0RyG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787057226; c=relaxed/simple;
	bh=iFtjPd1BVmXAbioi3JU56OCVjaF4nzNNaOm0GcnCP7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/Y4DjLdj6CNQ0lPudBqkEyVZIrqDy9u3ruFOPo3t47MSrVSwDPrfz5ZLAyv8Ql8CKYPDBcMHuwCsNOkcC41OY03OMQFAGkXupMS1Z7uegpH3dIL2zu0BF/3jaaNOmNWK77u34Ama/T5r6HBB3hHAMoYMqggGBfdeUF4qlOwczQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lOdVgCsd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lOdVgCsd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D40951F000E9;
	Tue, 18 Aug 2026 12:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787057224;
	bh=iFtjPd1BVmXAbioi3JU56OCVjaF4nzNNaOm0GcnCP7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lOdVgCsd+iB0AFj6Ivg0q9ZtPJ8aP3+6a8hfErCZiUukHR0gibiRmW+VOaim5wuYc
	 ZrF8AbL+O5sZ4bB4s9C59+22+KiJlWkQz83mH9R1NswhWnDgCke1RSZ84Gd03CQ+fc
	 DPAGkRuqc0I5+U6pzLgFTL8VkFf/9QZSQGNG0UwzgrPDJfM9fm0KoSXI1zrrDfpYQQ
	 SEvHYJeKicw+tZiiN2hSkSqAewsghXoKIbhAftK4pRYrOlI5XywkQubaJC/rGqQubL
	 /CZpXzfUE7MBBL1eNNByOtRNOaQKqsnPStmYELMB11y+fU7O+0wI+KAop+n9ZaXKQx
	 yf4REBnfSVKyg==
Date: Tue, 18 Aug 2026 14:46:58 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Bradley Morgan <include@grrlz.net>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, jackmanb@google.com, 
	kees@kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com, shijianlin11@foxmail.com, 
	shuah@kernel.org, surenb@google.com, vbabka@kernel.org, ziy@nvidia.com
Subject: Re: [PATCH v2 0/4] sysctl: Disallow partial updates of
 miss-formatted sysctl vectors
Message-ID: <4hbx4orb23mruq4dsjolglzgsjue5g25bbmnbeu5w37x7em4rm@o4hp6nu54ye6>
References: <20260814-lklm-partial_ctlvec-v2-0-9df50d26e477@kernel.org>
 <5F021629-DD85-4941-8263-3C4F51E9D6BD@grrlz.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l4ylzp3pd5pjeqyl"
Content-Disposition: inline
In-Reply-To: <5F021629-DD85-4941-8263-3C4F51E9D6BD@grrlz.net>


--l4ylzp3pd5pjeqyl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 15, 2026 at 05:09:30PM +0100, Bradley Morgan wrote:
>=20
> Copy it, only write back once every value converted. That's the
> right way to do this. Went through the whole series against the
> tree, notes in the patch replies.
Your feedback was useful, but it was riddled with a *lot* of hand
waving. Please be succinct and to the point. The previous paragraph is
not needed.

>=20
> Some nits on the series:
> - "miss-formatted" in the subject. mis-formatted, or just malformed.
Note that this comment is missing the why. It is good to know why you
want the change

> - akpm's scalars nit still applies.
> - Sashiko saw something on this one (akpm linked it).
In my opinion this is just noise. If you see that I have missed a
comment, call me out on it. If you have additional information, answer
to reviewers mail.=20

>=20
> Otherwise fine by me, the split is clean.
>=20
>=20
> Reviewed-by: Bradley Morgan <include@grrlz.net>
> also
>=20
> Tested-by: Bradley Morgan <include@grrlz.net> for the test
How did you test? And what where your results?

Best

--l4ylzp3pd5pjeqyl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmqEVDkACgkQupfNUreW
QU+sdQwAiiR0nJg+0a4UBdZxBcSQ1BO7cn+hJgcmdVyUFr+plSJKAcYIJW4gWdJX
2V2MSMvW2RSvPkucsQZJogIPsw7Uf/vSCwtyiy2sOCBPIGxd4KaMJRKunzrZGbSp
BNqLfvKzm8VUWBCA9x0b28LIVuZLp28mDR8tv/+W+4Ah2GcaeDDRccCtZL3TjYV0
ScfIr710yqRMkCUPil0qkEdU5LApmXvIEHz0N+HxksOGddsW4SPBmtmQ91ZNa7+v
X9ldCz7evpB9n22vjGkMI3QXI8IeRB7lbWWDtvQZXeWypFPvyhgBXbmAi4HZqAjj
dNcPj4rPVAR7saqHOm5uFbR5lMYolL3xApT9pZx31h7bDNrkKxn9CUosZ8yJ1L6b
MOxxPxY2DAFU1T377mMnzF4cVrPAaCgAEP4lvzax4ictwZpMJ1n30HMghgmeb2R6
IK2TdWDgavFQLBtUKOCPY0SawLS4ekWMsA0CeqDZoEoWPHtNgaz/jPLw5V8YHu+W
zhJT4INO
=x0ir
-----END PGP SIGNATURE-----

--l4ylzp3pd5pjeqyl--
