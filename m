Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DBB43CEE1;
	Mon, 17 Aug 2026 13:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786973676; cv=none; b=oGjdmYMe1H1oasCTB+dh1YuoiYhJ3iDs4jcmVRJzfvbdg/ok+doDuDPYivUf5t3L345v3/zhg8yG+lcqBaMHOvY4pkj7cVYvjREZsnoO6zFli/lGbBjIVA7rLw5RLmms9du+3OjL5EdORSHIPNH2rSMjNpxHCCrBcxLc/oMsyUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786973676; c=relaxed/simple;
	bh=DE35HLqrw5s+Pl32CN1y+ua/nFvB3tTtjnBp0nLCQVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PV4yKEC0FVwW/o4xGGwHrybQzgbpkuxL787KrPpQE6ruR3l5vgzTn0KzjHSPBALfGOB8sKm32qTNypXjeE7Yl6CfoWqLsmM4tnJ+mVncb7Jv/hweWiPXkNF2R0lI79bSVI0cU1UPMHB0KyAKqNMh8x6u8BKghisFTn8bgrsFy4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ms6QQQSo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ms6QQQSo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E15F1F000E9;
	Mon, 17 Aug 2026 13:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786973665;
	bh=DE35HLqrw5s+Pl32CN1y+ua/nFvB3tTtjnBp0nLCQVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ms6QQQSoAYyFPE3lw6LWam82FOjo0LPAYlpaec+fO7bEgTQATQOom5O+c/5yb1gVH
	 rSmnTvoS56YF4WWy9rcxi7tuZ7UAFYK/P6Kp+ktbOqFtG9x3QJoyvkNNtJguLajzIE
	 XoSj0B22hOJwphJawL1XFF5OFatscng57XByMfnYHrUlaYOexvh1AhkIpiYSUUgcEu
	 htRH4Jj64nNLOMuZ7tAbHDspuYP0Q9yGeJUXo2Ia0jssiPOjCKn81BMi+ckukT2gMp
	 A3uf88fgSdZ7OqDncIlHD1i82mll1jyT7fNzxQamSDTLigk8S67dmvclcph7XSPqGq
	 OqwX0l+azdOWA==
Date: Mon, 17 Aug 2026 15:34:19 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Bradley Morgan <include@grrlz.net>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, jackmanb@google.com, 
	kees@kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com, shijianlin11@foxmail.com, 
	shuah@kernel.org, surenb@google.com, vbabka@kernel.org, ziy@nvidia.com
Subject: Re: [PATCH v2 1/4] sysctl: Split data conversion and file position
 handling
Message-ID: <7xr5rzlyafbbqrenxoijnuux4mt4unu3vkffcvyjaufm64bfgm@itqpdduljg56>
References: <20260814-lklm-partial_ctlvec-v2-1-9df50d26e477@kernel.org>
 <D5FE866D-5393-4E51-8302-E6236B0D059A@grrlz.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xhbipm257r2x7xs7"
Content-Disposition: inline
In-Reply-To: <D5FE866D-5393-4E51-8302-E6236B0D059A@grrlz.net>


--xhbipm257r2x7xs7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 15, 2026 at 05:04:32PM +0100, Bradley Morgan wrote:
> >Rename function to prov_vec (from do_proc_vec).
>=20
> s/prov_vec/proc_vec/, the diff renames it to proc_vec.
>=20
> Also the SIZE_MAX comment in proc_vec() only talks about the no
> parsed element case, but after 3/4 a kmemdup failure leaves
> left_nbyte unset too (it goes to out before buf_left_final gets
> written). So the sentinel covers -ENOMEM as well, a line saying so
> would help.
>=20
> The split itself is fine, so with the typo fixed:

This comment is more about why it is OK to use SIZE_MAX. The case where
kmemdup fails falls into the "no elements parsed".

Thx for the review.

>=20
> Reviewed-by: Bradley Morgan <include@grrlz.net>
> Thanks!

--xhbipm257r2x7xs7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmqDDdsACgkQupfNUreW
QU9DGwwAicS0Z0OGIyVckHI7brK9mvqaOD7w4chOv8WkeTLatBjaqFGWXkHQj0gG
M9VE1JaFkXvFbNf7PBvVN0+vFEZXhocsk9lapp35m/mVNCVIz5XW446pPHAKy03F
mkQQNNGFG8Ppv+X2l7nwwIqsOONNnAcrHp3stEeHHeICw85IPrOInrKL+o/nFP7J
J+Z9r6/JDm+u1PY0CYH9xOQjQZAlU9y5QiQrLoYCp6DYfWRVf5baQTIlhhWNxafU
Oe0Qwu70jWAvAkHLCbG7XOF5IoF/y9k4b99/P9AWXcYaMagw1VhGS3375O1zPv0O
m81C8Ef+y2IhRxMwoyphEr0aqKx/N5GQNjhkQQjGIj4MQh6KOxZYywmQ1+ONYXeR
jfxeJtN5pk2ROnUlQ6HQb/g9PmvLjOkAgKoevZNZ/TD/WOScgHj/LyPCxY/SB4K3
q9KQp6NeYVmSVI/mgOOI98EhUDIabAfsMqOnK0mAxwOm5PrVRWFwLRjd64kVfqXi
5bSZC63m
=ZNXh
-----END PGP SIGNATURE-----

--xhbipm257r2x7xs7--
