Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.37.111.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792550159;
	b=VBScfQcv6xSpKoMjC8pPg0EPgcMQYHj0jP0UFf8ank0bcPUdIXlG/lRIaAn8k9Q6aIPf
	 GmbgVC2pRJDGqAyA6RlMEriYdXCQ00H+wwKICOsBJAqLTo0x2a6Y5H3rN3UGO6ovdshcB
	 tHsuyke9R8anqkm2p+Yzx1qD5OL24tYq/Z2XysFhCIxR0bzkOGGKeDCl83AzAELrqwTSy
	 NJmVFYUdxRhxUK26geOPwt0Y0/uYKe1j9sE6EGiAxFPuH3j+H/wRHpFdON8jZ1q/suiFs
	 81qwc5vqAGDHSjHfNdqtvaun8b+NjlmuoNi4ZdyGpT7yt/FBOaTUMoP/uNbrRdvvfAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792550159;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=dJzEOPRfMpeA41K0nE1yxnW5uL0HMEUfStUAme9/D8o=;
	b=3SorWNTsyPHJ9cPaDAYjF98Yt3b9HnKPoUQdnXzTjE0BKTb1Iehdrx1qpzH3xaygfrkY
	 xwDXogyHhjN0f2Mwdk0ICopMqvlSxfZUaA/Zs50gKSmdKz7MAk6h2my4pQyp0VyfMEvcM
	 1Q7LVi/qcgBGpXd5gxDkA+PASm8pvwzsmX3e29Q00PQ4rGYcbYJLBuSQbNTGtqufHeR7N
	 T4veKHgGIt1cda6yd3l1TZpJVbzc65PSN0U6ProF8HC5ESggpoptOQ7RDyf4mh115IGdF
	 JNXUFJUqhfKiSrmcY0kryHz1Em1pPgPfQbnyaRoBxTni+bRg/Ep4TahwZCXEFm/HxSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=HansenPartnership.com;
	spf=pass smtp.mailfrom=HansenPartnership.com;
	dkim=pass header.d=hansenpartnership.com header.i=@hansenpartnership.com header.a=rsa-sha256 header.s=20151216 header.b=Y9WOaXzF;
	arc=none smtp.remote-ip=198.37.111.173
Received: from lamorak.hansenpartnership.com (lamorak.hansenpartnership.com [198.37.111.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510D7606A319
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 02:35:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 510D7606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.a=rsa-sha256 header.s=20151216 header.b=Y9WOaXzF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1792550157;
	bh=IBoe6R7JABxjOi74zxPULPbHHCnAJBghQ7dSgsrGgls=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=Y9WOaXzFrB9GB9d9HE5TkYA4QDjfOuAh497giK8PK40t+V/bB3OePlvRV07RXX/ky
	 Hw8aBVv18rz22nITS4E6dveFlC6GQ3K9icDtRcpoExEaA8/1A1RCzryyOthQYqQOTS
	 4tg5v5yZCos6x7cdexzLPnqEA6esekT0GKAKP+aE=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4300:d341::8309])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lamorak.hansenpartnership.com (Postfix) with ESMTPSA id 1B8911C0370;
	Tue, 20 Oct 2026 22:35:57 -0400 (EDT)
Message-ID: <e7e0c20f2a1f2810f4932a8d4d854f328358fe20.camel@HansenPartnership.com>
Subject: Re: [RFC] cells: a container as one kernel object
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Josef Bacik <josef@toxicpanda.com>, Christian Brauner
 <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Date: Tue, 20 Oct 2026 22:35:56 -0400
In-Reply-To: <20261019-cells-rfc-6f4c85415f29@toxicpanda.com>
References: <20261019-cells-rfc-6f4c85415f29@toxicpanda.com>
Autocrypt: addr=James.Bottomley@HansenPartnership.com;
 keydata=mQENBE58FlABCADPM714lRLxGmba4JFjkocqpj1/6/Cx+IXezcS22azZetzCXDpm2MfNE
 lecY3qkFjfnoffQiw5rrOO0/oRSATOh8+2fmJ6el7naRbDuh+i8lVESfdlkoqX57H5R8h/UTIp6gn
 1mpNlxjQv6QSZbl551zQ1nmkSVRbA5TbEp4br5GZeJ58esmYDCBwxuFTsSsdzbOBNthLcudWpJZHU
 RfMc0ew24By1nldL9F37AktNcCipKpC2U0NtGlJjYPNSVXrCd1izxKmO7te7BLP+7B4DNj1VRnaf8
 X9+VIApCi/l4Kdx+ZR3aLTqSuNsIMmXUJ3T8JRl+ag7kby/KBp+0OpotABEBAAG0N0phbWVzIEJvd
 HRvbWxleSA8SmFtZXMuQm90dG9tbGV5QEhhbnNlblBhcnRuZXJzaGlwLmNvbT6JAVgEEwEIAEICGw
 MGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAhkBFiEE1WBuc8i0YnG+rZrfgUrkfCFIVNYFAml2ZBI
 FCS3GUMIACgkQgUrkfCFIVNZKjQf/deRzlXZClKxTC/Ee2yEPqqS7mm/INUA49KdQQ5oIhSxkUBy0
 9J4qjMIo5F8ZFkFTqikBqeL35LKu7O7rn8WETfX8Bxvos3HUsl3jHo34DES4MUFIpoQPgtiLRGwLb
 K0cVCAArR2u2qj4ABmTRrs1I1kvdjEw6gatOuXtEe/j5O2fvfzTq9GBr0Q3n2IAsFXi4hLlx6VPE8
 tyWUZ8BWJKtih3JAeUiXFvASL3McV0rV9RnU0VbjEQEhSE7PMYhWpnDC9AyBb0lXJllQRvC3NSkUB
 8KVQgNNxRPss0WE/nBoZ4dFA42jTyzTz8lNylxZoAWV7WJb3QxVg4oCodRVrxxrQhSmFtZXMgQm90
 dG9tbGV5IDxqZWpiQGtlcm5lbC5vcmc+iQFVBBMBCAA/AhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeA
 QIXgBYhBNVgbnPItGJxvq2a34FK5HwhSFTWBQJgS5mYBQkbNYS9AAoJEIFK5HwhSFTWBpwIAL5Bk3
 5FB34U6iHmDzzgdCbxLTs43T/YQyJpcGIvopBvnI/fDY8oSG6Df64/O6B+1R+A8TDp6ZG5ysUWnCC
 6GuIaEHemBYkitMPglR6+sGCMQY7O0mlsPvdssvKK1KI9Bno4VU6ogaF2qVzefSqg1Djmf/DcsxWP
 rI/jdJ8FB5AYR2rjIdDFc+zRdAJuavo1/anyY2wgpFh/3R8IOYAEfWV9nGgYkf9+tA4EIn1sxE0I3
 L5oW2N3mbyRrkzuBwO8ztMCwqEPk7moWzhokcZqMXiAIahaZdkashJC+s2X2RZSGCy+g+pvY5NN4B
 BVG5XwLgVBqbHMTcxE0fbmPqz+q6O0LEphbWVzIEJvdHRvbWxleSA8amVqYkBoYW5zZW5wYXJ0bmV
 yc2hpcC5jb20+iQFXBBMBCABBFiEE1WBuc8i0YnG+rZrfgUrkfCFIVNYFAmODZ5ACGwMFCRs1hL0F
 CwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQgUrkfCFIVNZu0Af/TzvL2/NdgAcw9uN3x60H8
 jc4QUq14VpxcFEFEMpcj1morkX/G93V+56HBBaXZj+yK8PhxIA/SIz+sU7C/0YvKuvzakP8ZX/7WJ
 e32SOUtjfr/VTaqjIBzNj6OxLvZpmNbBw7s6DwhhNpHOWqJ/1ml+PtDRDV71IB58yVqQjp1xlNKVl
 ZppcJ5908EJzsFnRIVjiQiDSKoppqB2BCibBbrWcln7CiWMyOC/cco6SIn6twH+f7+aivJ3xGcOE2
 a9gBKF5rNi9TBoX9oyPmshv/TDmnohsVrH7AYXlGYfZTk15SWEiROh1QX8/uD9wl/gcIv5EDUpT/F
 L2jzOsA5663bw==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, 2026-10-19 at 16:50 +0000, Josef Bacik wrote:
> Hello,
>=20
> This is the thing Christian and I and a few others have been going
> back and forth on, a container as one kernel object instead of a pile
> of namespaces that userspace holds together. I have a barebones
> implementation of it. It's 62 patches on top of the 13 patch cred
> series [1], and I don't think anybody wants that in their inbox for
> what is at this point a design discussion, so the code is in a
> branch, and what's in this email is the pitch, the things I would
> like opinions on, and the design document from the branch in full at
> the bottom so you can quote it and yell at specific lines.
>=20
> =C2=A0 https://github.com/josefbacik/linux/commits/cells/
> =C2=A0 git fetch https://github.com/josefbacik/linux.git=C2=A0cells
>=20
> That's 6cbfd1952c30 as I write this, based on vfs.all. "Cell" is a
> placeholder name, I don't love it, suggestions welcome.
>=20
> The pitch
> ---------
>=20
> A container isn't a thing in the kernel. It's eight kinds of
> namespace, a cgroup, a seccomp filter and a pile of conventions that
> the runtime holds together. The kernel can't name it, can't kill it
> in one go, and can't tell you what's in it. Privilege inside of it
> hangs off of uids and user namespaces, and a task can be half way
> between two sets of namespaces at any given moment, which is where a
> depressing number of our bugs come from.
>=20
> A cell is a container as one object. A task is born in a cell and
> never leaves it, and nothing can enter one, so there is no setns()
> and no unshare().

I can't agree with this.  If we're trying to fix existing bugs with a
new paradigm, it must apply to all of the common use cases and entering
an existing container is common: I use it for my build containers and
arch emulation containers, sidecars use it, debugging requires it and
it's part of the kubernetes acceptance testing, etc.

A process leaving a container is uncommon, so I'm reasonably happy with
that restriction.

>  You build it from the outside by filling named slots from file
> descriptors you already hold, you seal it, and then you spawn tasks
> into it. Holding the cellfd is the authority to do all of that, there
> is no uid or capability check on it, and making one takes no
> privilege. The cell lives exactly as long as somebody holds the
> cellfd, when the last one goes the cell is killed.

I think my only problem is with seal. I get that it's a very useful
security operation, but it's not a common container concept, so I think
it should be optional.

> Spawning is the other half. clone3(CLONE_EMBRYO) gives you a pidfd on
> a task that exists but has never run anything, you set it up with
> task_configure() the way you would set up a mount with fsconfig(),
> and then you start it and it execs. It starts with no mm and no
> files, so what it has is what you gave it. I think this is useful
> without cells at all and would like to send it on its own eventually.
>=20
> A few rules fall out of wanting the boundary to actually mean
> something. The kernel allocates the kuids for a cell out of a
> reserved window, the builder never names one, and those ids can never
> be stored on a filesystem the cell doesn't own. A uid means nothing
> across cells, not an equal one and not 0. Files impart no privilege,
> every task has no_new_privs, and set-id bits get dropped on anything
> a cell creates, chmods or opens for writing. Unix sockets carry bytes
> between cells and nothing else, no SCM_RIGHTS and no peer
> credentials. The mount tree is built from scratch, nothing in it
> hides anything, and nothing propagates into it.
>=20
> What I would like opinions on
> -----------------------------
>=20
> 1. The shape. One object, born in it and never leaves, nothing
> enters, built from the outside out of fds, authority is the fd. If
> you think this is the wrong shape then the rest doesn't matter, so
> start here.

As I said, I think requiring sealing is wrong because it excludes too
much of what we do today, so I think it should be optional (and
definitely encouraged as a useful security feature).  Although I get
this depends on whether the cell thing is going to be a single kernel
object for a container (in which case it must hold existing types of
container) or whether it's specifically a new type of container.  Even
if you're going for the latter, you need to explain what happens to
non-cell containers that don't fit in this new paradigm.

Regards,

James

