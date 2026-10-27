Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793103013;
	b=U0y251W+MEPQ7+Yv+tbFjUqwkyb6ZaeCbksmnYLhKeVfQMaOGPllr6QEO7jdniBxQ412
	 wLFxsz8kj3DNOCHB/x10tuvC3fhIgvnVTmNxLTj0dWJIPAjdcgUZKtc0lOAFeCyzJdJGv
	 X336NS+STd/3GTSjtoFlmrgfeBfcBv+mvO/7d2XK3kogsN7r0pZvDa+IiH80NM+yUOW8P
	 nunHrL9GkUB6SEjtX0ALKRjPepaYETBjUcFIEtqFJT+/umRV+1qWvzuibYypUNwpT2ZwT
	 KX2HTl5/PY2BT955mS3edQS18ls68Pu0iKJ238ScOaXzjkCc+sh8Vk1UEog2/WJczwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793103013;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=IEWfHWQd96c0j/DRJsEIoAaaCiqiDtlc45DfqG2xmlY=;
	b=z4ed7h/xi1MUU6QJ1ip/gBF+9GVfnIlK4VGpDGpbErvmyqTmOwd8Jdb1BM4F/2WAJhYX
	 sCDm5AxoPbCmFtvkAPVxl75lvjMw5lma23qtxTvHlNUk0CMBGWen3BWndChkj4B2baRrw
	 z/irFDttaPmHblSFRCXv/Hkd1pekGRHd3ix71RnLxmn9sPBSjcxRP4kuxLuvy+6uTy3/i
	 x8rpna1XPU2DTkYY//ZjRcnr2Cw9nb4QMvuR7+fMU5MnBvMs+Zk4yDqG+P2BTqjpJlAF2
	 ent9c94piWj2PRsppH4toce49Z2yhV9sI1vhRRjOet/ySF5GGSvgxwT7sd1l4Cbi5VA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FSYPp18y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94973606A333;
	Tue, 27 Oct 2026 12:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FSYPp18y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E35271F01828;
	Tue, 27 Oct 2026 12:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793103013;
	bh=IEWfHWQd96c0j/DRJsEIoAaaCiqiDtlc45DfqG2xmlY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FSYPp18yJrW0sUXkFUFP46foxc3InMmpObk3ZAG6yv4wNYT/nRR1uYFRiVe4xp0mx
	 Bn0mwH6a9SGVlYU0amh0Nf8PCaJNSdgGeepgQwHwVmDf4AW8uAK9J7I9AaqvZ8RL3K
	 4k1KX7mEdElWObdYrSDWeEu6gCWbUa2vw5ZnqgaBcp29aGwJdGGpzJWRU1gy1gsTMO
	 Vhfgsdsz1yl8zv4MAaBHshXG8BQ+ZztW8r7TuI78ApftYxLEFzXQTE6TjQHZ03PBrn
	 IsWT5LB+8zgzO9RhIxx9fk/L83gMjNwZ0wrbxxwOhN8WSBJBTamc/7ibAF2iAcQHOX
	 ZuxD7Je+LuWCQ==
Date: Tue, 27 Oct 2026 13:10:00 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Bradley Morgan <brads@mainlining.org>, 
	Ethan Nelson-Moore <enelsonmoore@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Yibo Tan <lhfff@tju.edu.cn>, 
	Zhan Xusheng <zhanxusheng@xiaomi.com>, Kees Cook <kees@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] sysctl changes for v7.4-rc1
Message-ID: <auBcFQyaV727f4fm@hobbes>
References: <atdn5xA9AZHAWNsM@hobbes>
 <CAHk-=wgjwxSCDQ7VhH5NgHSK2RG+9tDb=infbWbgQbWWHjVbow@mail.gmail.com>
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
	protocol="application/pgp-signature"; boundary="gmiqxqu2mtlmixbm"
Content-Disposition: inline
In-Reply-To: <CAHk-=wgjwxSCDQ7VhH5NgHSK2RG+9tDb=infbWbgQbWWHjVbow@mail.gmail.com>


--gmiqxqu2mtlmixbm
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [GIT PULL] sysctl changes for v7.4-rc1
MIME-Version: 1.0

On Fri, Oct 23, 2026 at 09:44:01AM -1000, Linus Torvalds wrote:
> On Tue, 20 Oct 2026 at 03:09, Joel Granados <joel.granados@kernel.org> wr=
ote:
> >
> > * Disallow partial vector updates
> >
> >   Stage sysctl vector writes before updating. Removes the chance of lea=
ving a
> >   sysctl vector partially updated due to erroneous input. This is not a=
n atomic
> >   write; a concurrent reader can still see a partially updated vector.
>=20
> I've pulled this, but this feels like it could easily break any number
> of random scripts.
>=20
> We used to just update until we hit an error, and I would not be AT
> ALL surprised if there are scripts around that echo some
> not-entirely-cleaned-up string to /proc/sys.

Writing fewer elements than the vector or junk after a complete vector
behave exactly as before. What changes is only a write that already
returned EINVAL.

>=20
> Put another way: I do not understand why that commit claims that the
> vector data should be unchanged just because the Nth element wasn't a
> number.

Not because the Nth elem is a number, but because the write fails.

Two comments:
1. The vector must remain unchanged on error for internal custom proc
   handlers (like vm.lowmem_reserve_ratio & kernel.sem) to avoid missing
   post-processing of a partially updated vector.

2. The user space that will be affected are the ones that ignore the
   EINVAL return value of the writable numeric sysctl vectors [1] (14: give
   or take) and depend on a subset of it being updated.

In retrospect I see that I missed clarifying the impact of the change. I
made a note of it for next time.

>=20
> What was the impetus for this change? Was there an actual problem it
> fixes, or was it just a random decision to possibly break user space?

This all came about from Jianlin Shi's fix for vm.lowmem_reserve_ratio
[2]. An erroneous return from proc_dointvec_minmax meant that
setup_per_zone_lowmem_reserve was not executed even when the some of
sysctl_lowmem_reserve_ratio vector was changed. Andrew's take was that
the handler should parse into a temporary, and that this is really a
flaw in proc_dointvec_minmax(). So not just a random decision.

I see 2 options:
1. Leave this in and I'll address anything that bubbles up in the
   7.4-rcX cycle. With the option of removing it if the impact to user
   space is to big.

2. We remove it before rc1. And make sure that all custom proc handlers
   stage their vectors on write.

Let me know what you prefer or if you have another option.

Best

Joel

[1] kernel.{printk,acct,sem},
    vm.lowmem_reserve_ratio,
    net.ipv4.{tcp_rmem,tcp_wmem,tcp_mem,udp_mem},
    net.sctp.{sctp_mem,sctp_rmem,sctp_wmem},
    net.tipc.{tipc_rmem,sk_filter}
    net.ipv4.vs.sync_threshold=20

[2] https://lore.kernel.org/all/tencent_FFD4F4D728AAE8A8AE0AF277A59854A29A0=
6@qq.com


--gmiqxqu2mtlmixbm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmrglIoACgkQupfNUreW
QU983wv/Q/KXMjVcpbAuAsD5oG7qNhgamnEI0zspYtW2OFOc7QaUbpNPXFiPSIoO
s+Z+d790pvlu1kUcJJqr8C68dtkQ6TQ4z0EF7EONj9Vd5JRnfD1QKmJMo4TUZRaL
bZ8izP1TAGmKgFBshIhVBisXwHf54zLZafh98Dy7vrVYY8UrFST2pHhBZ+PPZIw7
mfSbmVE/xgj0hh7G/m1x2z/YaMaWS5nC8oZGeFKExjlsYYzQQdFq25oW5fwg8+MF
0f+3KIM7Rhd9lqt/FC4zwKL/ffu1KZcS15jNa9CWuXLx7RD1as0sOutk4DLJGyb3
vj/wpaSunk/wbN6CQtjL1HFOx5iK96OfVxxXKDzKrp90kPEh/1D4Gmh/fAqHsgqz
eijVrg9WzDfEwgUkckuVuWOLetweSBeViJsucC7qlRQHcHjQSp78bMgZoupB9VWN
5I688vynZIRIrz6eZ+HBU7vsWwHdP336nc/j+YM8m96QUp931b+8DlUnHnD1OB1a
M/r9uNLh
=+Ps+
-----END PGP SIGNATURE-----

--gmiqxqu2mtlmixbm--
