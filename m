Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F803FF8B9;
	Wed,  1 Apr 2026 12:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775046232; cv=none; b=oVA8d7Cm/S+p3PHOA9NcNoUAxgFANeHZhcmoXqmfYZ21E8lw/RUYHfpEgXs6R5QAMBjInyDTCDH+WHL9Ztn9gC3dPo+N5p3SAt3Y+nK0KI0b0yqn1iL79j3WjrAzpCzwDyfmobw/txw+OPBoDM4AtUxJkd291Lle/G8NBRPRBMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775046232; c=relaxed/simple;
	bh=rap1+Fp1vHrytRzUwS7MVon0xi6lWDLiEMtasnVbg5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UA0SCX7WMX9/OcGr7gX2R2ren3uNx34eTU80I2H0CJxE3y9ogNEQK70PP8e8I2UOzba7f7ABc0Q0Hb5sBWGUh17jewYoXeAYZh1qtF1GC50otfD6YJiz8Aab002oxlwwDePjFzgvRrJSCISOTPXLGHPOF1q2HYTxWTFBr5xoLVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=ycNPqAc8; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="ycNPqAc8"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4fm40D40Psz9tQr;
	Wed,  1 Apr 2026 14:23:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1775046220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rap1+Fp1vHrytRzUwS7MVon0xi6lWDLiEMtasnVbg5Q=;
	b=ycNPqAc8cq9GNQgoY59JAhUG74R2ki0lrIQiGo7alPzzI6fL1cf/5eIt+PpSRqbTx93L/F
	Srzvlp4QdEZ7c3RCuLUaU3hXJCwy1p3C8xUec/DLU6XSnAXzVm4brz2Yyd3/VwiWLPP2ji
	mwUwvzUGA7cn5Xog9tNre6qmKJo/LMhsCbxoVWsTjyy5PsY8N2UfSRjH07L2eSNkaXv79c
	HeGCd2uhS8CSNyuYuihRPQW7tL+YjnZiXk0F7d9Znlp1wWNipYxEpOxbPab8I8Qd70VJx/
	j3pds0Hvv6qKOFQUVoOk+PRGdHIEO8IVLGztWZJe6NaalJDfMcGFVwy0p0gytw==
Date: Wed, 1 Apr 2026 23:23:20 +1100
From: Aleksa Sarai <cyphar@cyphar.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>, 
	Chuck Lever <chuck.lever@oracle.com>, Alexander Aring <alex.aring@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Shuah Khan <shuah@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Ethan Tidmore <ethantidmore06@gmail.com>, 
	NeilBrown <neil@brown.name>, Oleg Nesterov <oleg@redhat.com>, 
	Penglei Jiang <superman.xpt@gmail.com>, Kees Cook <kees@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Mateusz Guzik <mjguzik@gmail.com>, Wei Yang <richard.weiyang@gmail.com>, 
	Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/3] vfs: add support for empty path to openat2(2)
Message-ID: <2026-04-01-distant-broke-bonnet-catacomb-cnRW5o@cyphar.com>
References: <20260326182033.1809567-1-jkoolstra@xs4all.nl>
 <20260326182033.1809567-2-jkoolstra@xs4all.nl>
 <ecc86514cde4732995d9f50b9f5071fbb1f675e4.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5n4jplbx6v3pkjxd"
Content-Disposition: inline
In-Reply-To: <ecc86514cde4732995d9f50b9f5071fbb1f675e4.camel@kernel.org>


--5n4jplbx6v3pkjxd
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH v2 1/3] vfs: add support for empty path to openat2(2)
MIME-Version: 1.0

On 2026-03-30, Jeff Layton <jlayton@kernel.org> wrote:
> Looks sane to me. Can this be merged apart from the rest of the series?
> It doesn't seem like the transitive stuff is dependent on this.

No it isn't. I mentioned this in another mail but my thinking from a
long time ago was that we should harden these re-open paths if we want
to fully support O_EMPTYPATH -- but we already allow all of this stuff
today so we might as well merge this thing and make everyone's lives
easier. The transitive stuff also needs a lot more work IMHO, and I
suspect the full version is going to be a hard sell.

My only comment is that I would like this to be usable in open() as it
is one of the very few cases of an O_* flag that is actually backwards
compatible with all of the brokenness of open() and the systemd folks
would probably want to use it (they can't use openat2() yet).

--=20
Aleksa Sarai
https://www.cyphar.com/

--5n4jplbx6v3pkjxd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCac0OOBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQKJf60rfpRG9MRgEAhU8+/YTg3bvjJ8I3rhs1
1B3Mlqsv55J2Xz+YLiTBK2cBAISWOxEw/3eEBgwaQvGRf2X1UE0v3dUGFWf/5YJh
8pUN
=Gxt5
-----END PGP SIGNATURE-----

--5n4jplbx6v3pkjxd--
