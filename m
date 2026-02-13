Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69C013DBA0
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 13:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770990419; cv=none; b=EgJET+cLsqr9NcVXAeisCvXAJSj+IrmwKqN5Id4aV3bJ9qMD5wg70OvKEmN15P/BMBcaos0daa3wcpbjdztMkAjymyvVwcX5kKGCSax8jfu40JrYsrl9PQ5QK6Fpspldx+YRI2Ztr0GcPfwSbN5SH8EES+OYihSTl9S05jeSXjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770990419; c=relaxed/simple;
	bh=mmzyGEUH0JYoEe8t7iiZWCeYJFIdcgjvLzErI+TgCGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tFHxKgr8OtSaeCbUoZ0t9681eUTPoyC0JMX0gqnVXeGpM2IX36XyGPl+NgiaPBXsqjAU9Nw6y+kWOhaY9KVqmb1PbM17P14JIlFMcwy5zE78yLfMirTpBz8wDoAag267Cnk8QW81hWqGxQdydNuZVqkMkzDeV2z+xlrYi1dy4zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=GRfrUAPw; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="GRfrUAPw"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4fCD3p553fz9tTs;
	Fri, 13 Feb 2026 14:46:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1770990406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q/ICDU+sxXuDkWcN3oytdg+aJvCQiIUodmn3nYFC0cg=;
	b=GRfrUAPwKSnDhARKyqG0iiugNXuO+q81ncp3dmWmEZKQuM9Cd3C+9a8mqXZcl/00yNSE9o
	dDcBaSaMoQzAAv1WCW8EOdzOAbxreDaZxdlTdOVDDuIBBLkXwMZ5ll+nQiW1bK+DnKZVBQ
	Vra5nAMsVTlg/XHqb9PcoqqzH3glj42zWMVUa+WtxOD47HagC15yApmZPnXNMDOOLI+f8q
	Ra3J/bbpcFPw3HdGNHp+2oIe8XF2KQQpwVSwXKENHSEi0aZJLXxaeajWAq8zao4e3wIn4/
	m16AT0HJvBJp57zw9HOXRZmiwkxW1ZuLtbAYYcm905KA91xr7TunJk0f8BIKSg==
Date: Sat, 14 Feb 2026 00:46:34 +1100
From: Aleksa Sarai <cyphar@cyphar.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Askar Safin <safinaskar@gmail.com>, christian@brauner.io, 
	hpa@zytor.com, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	viro@zeniv.linux.org.uk, werner@almesberger.net
Subject: Re: [RFC] pivot_root(2) races
Message-ID: <2026-02-13-bronze-curly-digs-hopes-6qdLKp@cyphar.com>
References: <CAHk-=wikNJ82dh097VZbqNf_jAiwwZ_opzfvMr-8Ub3_1cx3jQ@mail.gmail.com>
 <20260212171717.2927887-1-safinaskar@gmail.com>
 <CAHk-=wgS5T7sCbjweEKTqbT94XxmcPzppz6Mi6b8nKve-TFarg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n5jmebs2xt262drf"
Content-Disposition: inline
In-Reply-To: <CAHk-=wgS5T7sCbjweEKTqbT94XxmcPzppz6Mi6b8nKve-TFarg@mail.gmail.com>


--n5jmebs2xt262drf
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC] pivot_root(2) races
MIME-Version: 1.0

On 2026-02-12, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Thu, 12 Feb 2026 at 09:17, Askar Safin <safinaskar@gmail.com> wrote:
> >
> > In my opinion this is a bug. We should make pivot_root change cwd and r=
oot
> > for processes in the same mount and user namespace only, not all proces=
ses
> > on the system. (And possibly also require "can ptrace" etc.)
>=20
> Yeah, I think adding a few more tests to that
>=20
>                 fs =3D p->fs;
>                 if (fs) {
>=20
> check in chroot_fs_refs() is called for.
>=20
> Maybe just make it a helper function that returns 'struct fs_struct'
> if replacing things is appropriate.  But yes, I think "can ptrace" is
> the thing to check.
>=20
> Of course, somebody who actually sets up containers and knows how
> those things use pivot_root() today should check the rules.

For containers, we don't actually care about chroot_fs_refs() for other
processes because we are the only process in the mount namespace when
setting it up.

In fact, I'd honestly prefer if chroot_fs_refs() would only apply to (at
most) the processes in the same mount namespace -- the fact this can
leak to outside of the container is an anti-feature from my perspective.
(But the new OPEN_TREE_NAMESPACE stuff means we might be able to avoid
pivot_root(2) entirely soon. Happy days!)

I think the init(rd) people will care more -- my impression this was
only really needed because of the initrd switch (to change the root of
kthreads to the new root)?

--=20
Aleksa Sarai
https://www.cyphar.com/

--n5jmebs2xt262drf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaY8rOhsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQKJf60rfpRG/jmgD/b0rBITETad/x4UAnU3yO
QVsfvzHQDMboP/CFJ7UOed0A/j1ZSLIU7i7oKzO5rLzG8z9ng96XSDA4CJScG2UK
WF0I
=XxKi
-----END PGP SIGNATURE-----

--n5jmebs2xt262drf--
