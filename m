Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.37.111.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792635989;
	b=QESLTEjsdZO1Y45M74+UN1STOqDZcxfM44hjc+fnOgDaD/4mnYAgrVQ4xXIo1vd6Z+Aw
	 yRQOtJLbu5exb2lc3dDm4CQXo79OeTqSvIre+IDwz7J8qzgpFk4A7MG8fx8Yrcyxz7J8r
	 EWG6nu2z6RmHl8HHaAZpUao/Xbfj/snBbiIBw5hcEpO8oiKiDWIRQzMyX3jR2n/4rsFwQ
	 X876DUzskreM3YKS8UfyMdhUBWJ32+ipivxpyMKK6dmgguFXXgjxv0VEc9MkeIMA87ZQS
	 OB3/yPaD0YvNKmNFm19s3xrd6f2pQl8W0vqOS6/xK+I7+UWQeYfxQDYR5JxI9nZchDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792635989;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=k8a5ele9jpyV5i6x7wO44QUAf2fq8KQRoH/PJ+HE6Ws=;
	b=BchdnT/vHoBPGi5HiWe7gvXeZGB4BZt0/t6c33lLiBexR5dxYiwOyRGtmw77Oo1BX/Nl
	 uxXVUW9BFwSoCbO5vB7Ew9OHeU1uKOf59JxHR5zeLXG8YGO0lCQe/Xam+aLCF3zt9Ed0J
	 PDt2e8AcY5YVJ8GLc1vfiw7OlW2HhZ9uQs5d4dQiXJkT5MGK3SfdqG0T1Fu8Y8MhAyLRl
	 /LVgL9TQ7sSIUi+SsMMTw1F2/ON6Ox5awCSIwuttA9phMVjOhP99wFl1JdYvtqY6rxEWx
	 dTlZfAM2uQAGfRA4IYnYWdiOZnYIZtU4LOwtKGet5d4h6T8eQVS4h8QJMynMWq/URag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=HansenPartnership.com;
	spf=pass smtp.mailfrom=HansenPartnership.com;
	dkim=pass header.d=hansenpartnership.com header.i=@hansenpartnership.com header.a=rsa-sha256 header.s=20151216 header.b=tDrzP+V9;
	arc=none smtp.remote-ip=198.37.111.173
Received: from lamorak.hansenpartnership.com (lamorak.hansenpartnership.com [198.37.111.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFDB606A31A
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2026 02:26:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEFDB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.a=rsa-sha256 header.s=20151216 header.b=tDrzP+V9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1792635987;
	bh=78//8HCFUUumXUPXiVPWUiNeE+8nS5lMjsCOsE+Fhjc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=tDrzP+V9xtBd9P6ZnqHoH9aRJJ8T29pbIxkraaiZGYJbnm+RojSI+3wI6xUAmEmnP
	 alQCl5Stut86zsJ3sshcXbkmJGZplTodqGkTgy2xPAT5b4+79rhzZSskrU4AKEB8XI
	 BRJen8+w18AJlYCOGMy2B7NzRykmC6/x5lofsGEQ=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4300:d341::8309])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lamorak.hansenpartnership.com (Postfix) with ESMTPSA id 7A3031C022F;
	Wed, 21 Oct 2026 22:26:27 -0400 (EDT)
Message-ID: <8d85dc4f5383e5d5b5a97a3237a5be85d59f18c9.camel@HansenPartnership.com>
Subject: Re: [RFC] cells: a container as one kernel object
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Date: Wed, 21 Oct 2026 22:26:26 -0400
In-Reply-To: <20261021-cells-rfc-reply-james-9f14d24c9a32@toxicpanda.com>
References: <20261019-cells-rfc-6f4c85415f29@toxicpanda.com>
	 <e7e0c20f2a1f2810f4932a8d4d854f328358fe20.camel@HansenPartnership.com>
	 <20261021-cells-rfc-reply-james-9f14d24c9a32@toxicpanda.com>
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

On Wed, 2026-10-21 at 13:43 +0000, Josef Bacik wrote:
> On Tue, 2026-10-20 at 22:35 -0400, James Bottomley wrote:
> > On Mon, 2026-10-19 at 16:50 +0000, Josef Bacik wrote:
> > > A cell is a container as one object. A task is born in a cell and
> > > never leaves it, and nothing can enter one, so there is no
> > > setns() and no unshare().
> >=20
> > I can't agree with this.=C2=A0 If we're trying to fix existing bugs wit=
h
> > a new paradigm, it must apply to all of the common use cases and
> > entering an existing container is common: I use it for my build
> > containers and arch emulation containers, sidecars use it,
> > debugging requires it and it's part of the kubernetes acceptance
> > testing, etc.
>=20
> This one is on me, I worded it badly. There are two things we call
> entering a container, and I only want to get rid of one of them.
>=20
> The first is an existing task moving in, which is setns(). That's
> what is gone. The second is starting a new task inside of a container
> that is already running, which is what docker exec and kubectl exec
> are for, they just happen to be built on the first one today. That
> one is there, it works and it has tests. Whoever holds the cellfd can
> spawn into the cell at any point while it's running, not just to get
> it going, and hands the new task whatever fds it should have, so a
> pty for a shell. Your build containers would keep the cellfd around
> and spawn the next command into it.

OK, so I can be happy with that.  All my use cases today use nsenter to
get into the container meaning they fork a shell (or something else)
inside it.  nsenter is today built on setns but it could easily be
converted to the new paradigm since it's building the fork and then
moving it.

> The reason I care about the difference is that a task that moves in
> brings the host with it: its mm, its fd table, its cwd, the binary it
> is running. That is CVE-2016-9962 (the container ptraces what runc
> exec brings in and gets at its fds), CVE-2019-5736 (the container
> overwrites the host's runc through /proc/self/exe) and CVE-2024-21626
> (a leaked fd and a cwd on the host, again by way of runc exec). The
> runtimes have gotten very good at scrubbing themselves on the way in,
> but it is scrubbing. A task that is born in the cell starts with no
> mm and no files, so there is nothing to scrub. It also means the cell
> of a task never changes, which is what lets kill be complete and
> "dead" mean gone without any races to think about. And it answers
> "who may enter" without a uid or a capability, it's whoever holds the
> fd.

So an existing process cannot fork into a cell unless it also does exec
to clear at least the mm?  That's a bit more of a restriction than I
was envisaging.  Say more about the fd table because exec doesn't clear
that and we use it forking shells into containers to get the current
ttys to go across the container boundary.

> That said your list does poke at real holes in what I have, so to be
> straight about those:
>=20
> - Spawning from the outside fails with EBUSY once the cell has
> enabled controllers on its own cgroup, which systemd does right away.
> That's question 7 in my mail, and it has to be fixed or the above is
> a hollow answer for anything that runs systemd.

This is an artifact of being unable to build the task outside the
container and spawn it into the new cgroups, right?  Yes, that needs
fixing.  I think sealing is useful, but it can't happen by accident
like this.

> - If you aren't the one holding the cellfd you have no way to get
> one.  The holder can pass it over a unix socket, so a runtime can
> offer that, but there is no "root walks up and nsenters by pid". I
> could see a privileged lookup by id later, I would rather not start
> with it.

So namespaces has a way to cope with this that I use a lot which is you
can park a namespace on a mount (I use this to keep empty containers
around) using nsfs.  Since the semantics of fd you're using is very
similar to struct mnt, you could use a similar scheme.  That way
anything that can open the mount can recover the fd (of course, you
need privilege to create the mount, but anyone who has access can use
it).

>=20
> - The program you spawn has to be in the cell's tree, which is no
> good for debugging an image without a shell in it. Letting the exec
> take an fd would cover a static busybox or gdbserver from the host,
> and adding a mount to a running cell from the outside would cover a
> whole tools image. Neither is written.

That's not going to work for architecture emulation containers, where
you want the image to be pure, so the qemu-user binary has to reside
outside.  Fortunately I don't think you can alter the OF behaviour of
binfmt_misc (which was designed for this use case) which does an
AT_EXECFD.

>=20
> - Port forwarding wants a socket in the network namespace. If the
> =C2=A0 runtime makes the network namespace and shares it with the cell it
> =C2=A0 still owns it and can still enter it. If the cell owns it then
> nobody can once it is sealed, and that wants a helper spawned into
> the cell or something like a socketat().
>=20
> For debugging in general you don't need to be inside. The host sees
> the tasks of a cell by pid, and a capability on the host still lets
> you ptrace them, so it is a good deal nicer than a VM. If we ever
> close that off (question 3) it would have to come back as a right on
> the cellfd.

It's not usual in a cloud to give access to the host (or guest OS if
the container is in a VM).  Debugging is usually done from a sidecar or
by entry into the container.

> For sidecars and pods I think the answer is several cells and not
> one. The runtime makes the network namespace and puts it in the "net"
> slot of each cell, which works today, I added a test for it. Every
> container gets its own tree, ids and cgroup, they talk over localhost
> as they do now, and volumes can be shared. A sidecar or a debug
> container that shows up later is a new cell filled from the same fds,
> nothing has to enter anything. What you don't get is a shared pid or
> ipc namespace between them, and unix sockets between them carry bytes
> but not fds or credentials.

IPC namespace sharing is still usual for DB containers.  I don't quite
get why if you can share the network namespace, you can't use the same
technique for sharing the ipc one?

> > I think my only problem is with seal. I get that it's a very useful
> > security operation, but it's not a common container concept, so I
> > think it should be optional.
>=20
> Also my wording I think. Seal isn't hardening that you opt into, it's
> "I'm done building this", the same thing as FSCONFIG_CMD_CREATE.
> Nothing can run in a cell before it, so it doesn't take anything away
> from a running container. It's the point where the kernel checks that
> the pieces fit together and refuses the whole thing if they don't.

OK, so I was thinking of seal as barring entry, which you say above it
doesn't so it's basically just namespace configuration sealing, which
is pretty much the same as we'd have today if you take away the ability
to move into a new namespace.

> If the objection is that you can't change a cell afterwards, that's
> fair for what is written today. The plan is that what needs to change
> later, adding a mount or a device or changing a limit, is done to the
> cell from the outside by whoever holds the cellfd, rather than by
> leaving it half open.

Sure, I get that this is effectively configfd again (like fs config but
more generic).

> > As I said, I think requiring sealing is wrong because it excludes
> > too much of what we do today, so I think it should be optional (and
> > definitely encouraged as a useful security feature).=C2=A0 Although I
> > get this depends on whether the cell thing is going to be a single
> > kernel object for a container (in which case it must hold existing
> > types of container) or whether it's specifically a new type of
> > container.=C2=A0Even if you're going for the latter, you need to explai=
n
> > what happens to non-cell containers that don't fit in this new
> > paradigm.
>=20
> It's the latter, a new type of container. Nothing happens to the
> others, namespaces stay exactly as they are and a runtime can use
> either. I don't think wrapping the existing pieces in one struct buys
> us anything, the bugs I'm after come from the semantics of the
> pieces, so the same semantics under a new name would have the same
> bugs. The price is that some things won't run in a cell unmodified,
> anything that sandboxes itself with namespaces for one, and I would
> rather pay that than carry it all over. What I do want is for the
> common workflows to have an answer, exec and pods and debugging
> included, so please keep throwing the ones you care about at it.

Well, OK, but the foregoing made me think it could encompass most of
our container uses (provided the entry criteria are clarified).

Regards,

James
