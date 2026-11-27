Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795785161;
	b=e91IKZWau61SEkmHhP03x3bO7eo/Y0pp1oWQPnGknJRC8q0eLggqtx43cZV1Q0ZXcR5E
	 mdkue5B3dRW4G1t85wHWQmRO+jgHOK0+EYn5MH5Mlsc2bSzuvdOncUNp7LdGrD+PqUHDr
	 v8KZM/RwbhG9cD83ajRGCoRU0oTNVgOqNUw7fFf/ptt/n28+HqJoEzofoTF+RNpz2xt5N
	 PALuz6r8JyqnMnFFLcM7OKP/xNRsGZZqSJ+DoJuBj7mzcg4ZQkeXsxx8kDOyTve0lCkJd
	 XQxbkaw9YxHiGRu8AqXmVF7xGFc1wj+2lc/ex71oJWHnslkSmISqINwlH04OtIj4Gaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795785161;
	h=Received:DKIM-Signature:Resent-From:Resent-Date:Resent-Message-ID:
	 Resent-To:Date:From:To:Cc:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=1n7aGqslJizq3A0w/V38NH8BqsVPS3xR6m9MYJQhWag=;
	b=5Oslm7W1vG8dpvut+lIoask+CPiUA9QwTii9BFLgOwo7U38f9BPpTs1YxD2c6lJGjY8L
	 DLE/WYUcj5M3WvTCvktWTVh+RyDGhYiXt1V9xeGnSF7+gv5TqrjLCxzkekA+/wb8tbXO+
	 AVDXstCAu2uVk0vUhDmTKuKhDIa9cJhG88EjBZm7+g/BNx7/BgrxoNtfdAgvPDxNLGoS9
	 BGZDFRTlkruu7mZpVZrUXzyeQ6inzObZIVG6oZ4KtZrOe00ats2rfivfbinfdJL5hf46P
	 +v9jpIA6FB87kEvQQlFrfYALTwNJhGN3KadLUETwhPOsCXP0oisg5LPL/n2TT4QUtrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YDWCAgt9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44256606A31C
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2026 13:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YDWCAgt9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F1B1F00897;
	Fri, 27 Nov 2026 13:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795785160;
	bh=1n7aGqslJizq3A0w/V38NH8BqsVPS3xR6m9MYJQhWag=;
	h=Resent-From:Resent-Date:Resent-To:Date:From:To:Cc:Cc:Subject:
	 References:In-Reply-To;
	b=YDWCAgt9H4tFTmIz8v3DBXCKYoLrjBOOPExACUFFNqgwyduWQ0eL38qyR0Wv/+9IM
	 eCQj58fNRzJHuxAYAixArsibbCseo6A6Edr1oLa7mig27kJuPaWbgKguLhRtpsW74F
	 oYGSm06Kahvp29SnG6AtwJTClbmpbb5r/uSBhEQ+MVTSMGwu8HoBOSTLZHH7t2BuRL
	 G1aMOyx8LHlyRWgCDv/TW+ziVXXN8RB8h8Cu3+2c3bDsJom8nB6lw+VBeu8XlqJP6f
	 DIZuMJp95mga38LloDpWitvyCSljCJg5TainjCvYRvHcIqWgySdoKQNHN50QvDHZ0x
	 zF+gjLS0fFCpQ==
Resent-From: Alejandro Colomar <alx+linux-man@kernel.org>
Resent-Date: Fri, 27 Nov 2026 14:12:38 +0100
Resent-Message-ID: <awmBxr3acQZFdju4@devuan>
Resent-To: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Date: Fri, 27 Nov 2026 14:08:04 +0100
From: Alejandro Colomar <alx+linux-man@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Niklas =?utf-8?Q?Hamb=C3=BCchen?= <mail@nh2.me>, 
	linux-man@vger.kernel.org, linux-api@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: man 2 unshare: UNSHARE_EMPTY_MNTNS
Message-ID: <awl-h1Kdc61JccWC@devuan>
References: <64fb02fd-0ffa-4311-bf21-a3211e9d599e@nh2.me>
 <av-DinDzrAeN_1mU@devuan>
 <20261127-rundlich-geldkassette-farbaufnahme-62856c08c80b@brauner>
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
	protocol="application/pgp-signature"; boundary="bshabd5tnbamc7jq"
Content-Disposition: inline
In-Reply-To: <20261127-rundlich-geldkassette-farbaufnahme-62856c08c80b@brauner>


--bshabd5tnbamc7jq
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-man@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Niklas =?utf-8?Q?Hamb=C3=BCchen?= <mail@nh2.me>, 
	linux-man@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: man 2 unshare: UNSHARE_EMPTY_MNTNS
Message-ID: <awl-h1Kdc61JccWC@devuan>
References: <64fb02fd-0ffa-4311-bf21-a3211e9d599e@nh2.me>
 <av-DinDzrAeN_1mU@devuan>
 <20261127-rundlich-geldkassette-farbaufnahme-62856c08c80b@brauner>
MIME-Version: 1.0
In-Reply-To: <20261127-rundlich-geldkassette-farbaufnahme-62856c08c80b@brauner>

[CC +=3D linux-api@]

Hi Christian,

> Date: 2026-11-27 13:51:03+0100
> From: Christian Brauner <brauner@kernel.org>
>
> On Fri, Nov 20, 2026 at 12:22:52AM +0100, Alejandro Colomar wrote:
> > That same commit also adds CLONE_EMPTY_MNTNS (according to the commit
> > message, for clone3(2)).  Could you explain why there are two separate
> > flags?
>=20
> unshare() only takes 32 bits. All of them are taken by legacy CLONE_*
> flags. New clone3() flags live above bit 31 so CLONE_EMPTY_MNTNS (1ULL
> << 37) can't be passed to unshare(). UNSHARE_EMPTY_MNTNS reuses the
> CLONE_PARENT_SETTID bit which has no meaning for unshare(). Both imply
> CLONE_NEWNS.

Hmmm, thanks!

$ git grep -hP -f <(grepc_c -tm CLONE_EMPTY_MNTNS) include/
#define CLONE_EMPTY_MNTNS       (1ULL << 37) /* Create an empty mount names=
pace. */
$ git grep -hP -f <(grepc_c -tm UNSHARE_EMPTY_MNTNS) include/
#define UNSHARE_EMPTY_MNTNS 0x00100000 /* Unshare an empty mount namespace.=
 */
$ git grep -hP -f <(grepc_c -tm CLONE_PARENT_SETTID) include/
#define CLONE_PARENT_SETTID     0x00100000      /* set the TID in the paren=
t */

Would it make sense to create new UNSHARE_* flags for all the existing
CLONE_* flags that make sense in unshare(2)?  That would avoid some
possible confusion.

That is:

$ man 2 unshare | grep -o '^.....CLONE_\w*' | sed s/CLONE/UNSHARE/;
     UNSHARE_FILES
     UNSHARE_FS
     UNSHARE_NEWCGROUP
     UNSHARE_NEWIPC
     UNSHARE_NEWNET
     UNSHARE_NEWNS
     UNSHARE_NEWPID
     UNSHARE_NEWTIME
     UNSHARE_NEWUSER
     UNSHARE_NEWUTS
     UNSHARE_SYSVSEM


Have a lovely day!
Alex


--=20
<https://www.alejandro-colomar.es>

--bshabd5tnbamc7jq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmsJgK4ACgkQ64mZXMKQ
wqk8ihAAl9OzcXygX9Lg1yhuFEo0Y1Ky0RCoadSTrpjteYRSQncD2eJxH8e33BD/
WPjsSIUKuXez0gQPW9hKAkK5hX+CH9zuLbzqLkvPB3HJyLFMZbERusbNk5x8wBjw
e0qqP42NnWJzBNfP/mC8tzXXMYm23QbvCn4AedTniHpVIz048/gXX/f5aGxZD9Mr
Z/xwUK+8l1f/lGlGXS3YClV8/MfYk+WqjUn0c7lngGbUP/5OBZOj9/cpc36P0aJ6
f6Dkz0kG+VcMsweJ59BUSCjNe0q5w7hGurVekkn2o9woTtUH7WL2WWKmyJX4C1uD
gUkN6FnnKGCgaG7Y1coCaYyYWeG3LXBWkCxJ/nHTGIy2QB/l0+Iw1fWposgRU7pv
0HJHXUeV5SfQ4RctNHmhXR+xsAqh5D9MUrsRFFFWslwdMooF28QiJIKe1ZzBylaI
VViePknbtiO8VxKpi1DqoGiuywIuYCAUMjjU7QxeUek/udMXAIc92PiBX/4aw59n
4PrmIenTxN8oU8aC9kUnnQJdJ9ALw+yGsPUuA90OiXk/Pj7cs9v0sbM9Bw+VusdR
CXUKRwv75U0kO2yQLlyjBdrAOqOXVgDFkEhxVniXbrioBjEHGfb/X2AyY8zcLBq3
zZ2v44kqIrqIVEaDpH4EQaQIckqiHtGFV1mXh/y0ZwWuwrHAI3I=
=HQXy
-----END PGP SIGNATURE-----

--bshabd5tnbamc7jq--
