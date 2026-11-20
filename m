Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795181101;
	b=Ib0I9P/DlNwiHIUQUwBVQyJZX2N+H/l90c7jChjggXEKv/BLNWOMDNbbmUSPj8ci7Ew+
	 m57JN0xCnwiwgLMDUNoD6nggW4CxQXHpj8WsHfNJo4wzjqrpOrMjs7E4lN7aw+fxl2RoA
	 e049+/InVrR5HYqe0V6eI2+MiOsL5c6OCFOaikDxyZLkIfrJdPuN1Cdzdzo1Hbx4TQVbl
	 NmHz5jM5mH53em5brJuhIkmOMZW+9HiyNZX8dxZUnJOrIJ6Fj+GnuNipYeavLbUiwi9ws
	 oNOPN/eSrGVOg404GV+JJUyhmqJWbK2+G9h9vrZE2NdOAJi9uopytBxAqPmsSMvodSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795181101;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=EJxOk2iAhlxJO8mQMHPBSXYYr7Hb6Bmk1S6vLMr+MZ8=;
	b=KIW11cSyc+tdRrbtOcH99r4DDU5y0GPWU7BsU7JrLEk+wZG5b8CujYIMXuw8dPgqm8EL
	 /vQSwi7Tpwilzc62IL6BgKvrlizQMNUsfWwda97vZc2Rq+Zi63nti0b+XA+VxkcA12OZt
	 prKiH6K145PZEfQcdSHxZ351Vg+Qtu8xMqGdcUlhGE5EIsvGgh0vVoDmG10kIgWXDKKiZ
	 dcMT4oq56D0MjnpDycdusyHFEePBZn+Velq6OstPZuOsYefM0G6fcpGyUIHtxA3qkvbD9
	 ME/yazOTR2shGKUKB48ovYxGMaSZ/D83HhfALTzaxDFJb+CFgpcySXWNPB9AZMfb71A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=dCkPrHYz;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF9D606A326
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 13:25:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DF9D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=dCkPrHYz
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so6744035e9.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 05:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1795181100; x=1795785900; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=EJxOk2iAhlxJO8mQMHPBSXYYr7Hb6Bmk1S6vLMr+MZ8=;
        b=dCkPrHYzS+fdPuPuKwS/olhuHCxYtIb0sFo9PQ+SKkZchMrhIdpW2EL9a0SvblZHZl
         6Dxb+/8GGtx377OqpkItP5QDaPJL24HSTEooQb1Oh8rqfcLAAQ4L3UeiVwGuYSAOpOcx
         ZhVg537cx17T2tuC72cgWskMTRuesNMFWD/i3wDku7j8MLPu9G7dWsmjzg9mx1/fiYjm
         +XjPTHGCtTemoqUoqxYrB+hO6G/npZZ0dVWw26L72Noru2ONn4q+r7RaGKuge2WLE+fU
         U9uS79+Q1vOGklxtomAQ2OmUTslQ64f/EWs8HLBPSvH7JWiVWjzaumj27CjfBYhRD6qp
         XWaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795181100; x=1795785900;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EJxOk2iAhlxJO8mQMHPBSXYYr7Hb6Bmk1S6vLMr+MZ8=;
        b=HGYUu5OaXA1dxbmeiviY01hG/UU6A/4gRviZINYABFoEoLry7jeuTvFfqYURsFjBPY
         zaYA/C8eOSJGPklWPbXqXYrt7xK3/SrPN0dgxROHE800N1qTJ1IcsNnOk2gj9noBUWfu
         K5QuPVsunCkpgjRQ7g5cu1ls/RWsOW7sbQKlRd4ibRPUPbA7TtNvy+Z+Cr39FZMJbnqY
         JNpSiN6F/7vtRat4JT53zJS/SPk8o6+zqGNvdi18/f9i2sVuoGAhfarRJqSH7iJmvy38
         FdJ2sjtaahei2sD7Kp4sOuc2UtUqmlAvJK71CuvPKrGH3q9QD01YFoiOkFt+flUurs/F
         BH6w==
X-Forwarded-Encrypted: i=1; AL+hErGV2WeVQ9CxRijd4oOkqcppcs9sNadfnLNKbEcOKbQSw+fAfN0qQWufIYRlt02C9YxHjR5gte6LCmJsDyJL@vger.kernel.org
X-Gm-Message-State: APuU4Z+Hlf7rl1yD3BsBx3QO01cYO5eU/YeihKPlPfw2Dvk+DrFGJudv
	7dxQ5fm8qyg0XyWhZKLOTi5jwjfRAPG0EpFVXACBKJoLo7uAf4R41QhVHgbKD75tE0Dh
X-Gm-Gg: AYBFou3L1+9YxS87d+I0Q9QGYBYUCCjdYWlIHYtGoF4CMKPehmXGoMatyg7c6zUPOLQ
	RmZha2BVX/l+LQH+OmEH4KyYg9a+1qZntpLtjdSDWRwcbVc+gkS2GOxAFISMeh1HC8nXs1oc+6k
	JpBx/AcNiEIhKRxvRXRrq4xpp4RVc19aSFywD71l8dLuBp2ZWadVAPAm3gkVUTz09V3iCr3KbUl
	KegtxxJUJLc8enG5F69Hf17gWmpuKOAuUf/TrE+BsKHyny/uyHCj+4IrA7CcWBlHTL5Kyc6bWom
	XW5qPjGSdBmffCnZdsxw/pVFNKsQQAQ6Q0N2xJF5RacVTe72dIkt49Zp5t7PMz6jmzgZ5rEPrUI
	lnl8iQIlm1L2vleLFD6FTghtOXCjYVnuSNY4zszkV0tWIN+Moz35nyGOgtdi3hbSjm15CCxJeZU
	8sLWR/Psv1yDhYghDDU4XP4xcqA7j6+EK7/RYrD3DYOLZOWHB9Tk40OQi5tTZojzeuqCSB8snoA
	mL4mvd7anSUFNrOGAm23tqgjRbkLFVkAoY3nkPTyVpb8mb4OHUcSy0ruq3UF+gQFo9yPDRXl6ES
	St8aMIZU2dleG2TP2ADAAfBQkXjjtNpuHsDAHKeFxqk7mRAoURz4P/lYXFmXYALaOQ==
X-Received: by 2002:a05:600c:46d0:b0:4bb:7987:fbc4 with SMTP id 5b1f17b1804b1-4bb88817eb2mr65637465e9.19.1795181099572;
        Fri, 20 Nov 2026 05:24:59 -0800 (PST)
Received: from [10.0.0.233] (tmo-084-188.customers.d1-online.com. [80.187.84.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67fe75sm6280903f8f.24.2026.11.20.05.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 05:24:59 -0800 (PST)
Message-ID: <1f12636403bb7af3759cd933b2612d8a5d7317a2.camel@amutable.com>
Subject: Re: [RFC PATCH v2 00/13] Namespace for namespace roots
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Josef Bacik
 <josef@toxicpanda.com>,  Christian Brauner	 <brauner@kernel.org>, Alexander
 Viro <viro@zeniv.linux.org.uk>, David Howells	 <dhowells@redhat.com>, Jan
 Kara <jack@suse.cz>, Serge Hallyn <sergeh@kernel.org>,  Kees Cook
 <kees@kernel.org>, Paul Moore <paul@paul-moore.com>,
 linux-fsdevel@vger.kernel.org, 	linux-api@vger.kernel.org,
 linux-security-module@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Fri, 20 Nov 2026 14:24:57 +0100
In-Reply-To: <awBHZO2VwWyJzvBN@kernel.org>
References: <20261117231352.3816603-1-jarkko@kernel.org>
	 <CALCETrVUkbpoFjwSAejyA4b_9qEauAP_36i=O8Op1ifp8aUkqA@mail.gmail.com>
	 <av3akYFOYaeQZauZ@kernel.org> <av3bkDnwmjunTleX@kernel.org>
	 <CALCETrXPLeUgxyhjP4XuWS46FKB0TUHF5PcMkdMf+qeEXbyXRA@mail.gmail.com>
	 <9463a969d35a7d5ec5a56aeb67644b94.josef@toxicpanda.com>
	 <CALCETrXt-Do28BHDpbrA98kEy-tQuorxD8c2XsW24Tt8Vspdtg@mail.gmail.com>
	 <CALCETrUbe8rBoxrC+Q66AMsrJ8Fow7xt5KJKRAmobtXBvHWdqg@mail.gmail.com>
	 <c301fff20a4920fcd3baa31dda2e31ad99c93436.camel@amutable.com>
	 <awBHZO2VwWyJzvBN@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Fri, 2026-11-20 at 15:13 +0200, Jarkko Sakkinen wrote:
> On Fri, Nov 20, 2026 at 01:32:57PM +0100, Alexander Mikhalitsyn
> wrote:
> > On Thu, 2026-11-19 at 15:27 -0800, Andy Lutomirski wrote:
> > > On Thu, Nov 19, 2026 at 2:50=E2=80=AFPM Andy Lutomirski
> > > <luto@amacapital.net>
> > > wrote:
> > > >=20
> > > > On Thu, Nov 19, 2026 at 9:30=E2=80=AFAM Josef Bacik
> > > > <josef@toxicpanda.com>
> > > > wrote:
> > > > >=20
> > > > > On Wed, Nov 18, 2026 at 9:46 AM Andy Lutomirski
> > > > > <luto@amacapital.net> wrote:
> > > > > > cells: The dance where I create an anonymous mountns, mount
> > > > > > stuff into
> > > > > > it, and then attach it to the cell is cute.=C2=A0 But I think
> > > > > > the
> > > > > > userns
> > > > > > interaction is wrong: you are making me assemble all the
> > > > > > mounts
> > > > > > in
> > > > > > *my* userns and then clone the entire tree into a fresh,
> > > > > > non-
> > > > > > anonymous
> > > > > > mountns bound to the current userns.=C2=A0 And that clone
> > > > > > operation
> > > > > > is not
> > > > > > free and serves no actual practical purpose.
> > > > >=20
> > > > > The copy buys us nothing, agreed.=C2=A0 That's just what the moun=
t
> > > > > API
> > > > > gives
> > > > > me to work with today, it's not something cells wants.=C2=A0 If I
> > > > > could make
> > > > > an empty mount namespace and fill it by fd I'd use that, the
> > > > > "root" slot
> > > > > takes a mount namespace fd already.=C2=A0 Extending the API for
> > > > > that
> > > > > makes
> > > > > sense to me on its own.
> > > > >=20
> > > > > The mount namespace staying with the builder's userns is on
> > > > > purpose
> > > > > though, that's what keeps the cell from mounting anything no
> > > > > matter what
> > > > > capabilities it was given.=C2=A0 The builder sets the tree up and
> > > > > hands it
> > > > > over, so the cell only ever has what it was given, and the
> > > > > mount
> > > > > code
> > > > > isn't something it can attack from the inside.
> > > >=20
> > > > I don't get it.
> > > >=20
> > > > Using the builder's user namespace means that the contained
> > > > processes
> > > > can't be ns_capable on mntns->userns.=C2=A0 But this solves very fe=
w
> > > > problems unless you also deny the contained processes the
> > > > ability
> > > > to
> > > > unshare userns and make a new mountns, and if you can do that,
> > > > surely
> > > > you can also deny the ability to modify the mount namespace.
> > > >=20
> > > > As just one example, a mount namespace could have a little flag
> > > > to
> > > > say
> > > > that it's *in* one userns but its owner is a different userns.
> > > >=20
> > > > >=20
> > > > > > cells: I find it *incredibly annoying* that one generally
> > > > > > cannot put
> > > > > > new mounts into an existing container using most existing
> > > > > > container
> > > > > > managers.=C2=A0 I hit this on a surprisingly regular basis.=C2=
=A0 You
> > > > > > seem to be
> > > > > > baking this into the whole cells design.=C2=A0 Why?
> > > > >=20
> > > > > By design.=C2=A0 Allowing changes to a running container is what
> > > > > causes the
> > > > > problems.=C2=A0 If you need another mount, tear it down and build
> > > > > it
> > > > > again.
> > > >=20
> > > > What problems?
> >=20
> > Dear friends,
> >=20
> > Dear Andy,
> >=20
> > >=20
> > > I'll add:
> > >=20
> > > On a non-container Linux system, you can hot-add a removable
> > > drive.
> > > On a Linux-hosted VM, you can hot-add all kinds of devices, with
> > > or
> > > without the help of the hypervisor.=C2=A0 (The hypervisor can hot-add
> > > a
> > > device, and the guest can mount network devices or newly added
> > > USB
> > > devices on a port that was already assigned, etc.)
> > >=20
> > > For some reason, on Docker and its sort-of-clones, approximately
> > > the
> > > best you can do is rbind in a directory and then mount things
> > > into
> > > that directory from outside.=C2=A0 This is sad.
> >=20
> > +1
> >=20
> > I guess the root reason here is what you've mentioned - for VMs we
> > have
> > a clear separation of the host-side (hypervisor can hot-plug a
> > device
> > to be visible on a PCI bus, for example) and some agent on the
> > guest
> > side can react on this change and do something depending on how
> > VM's
> > owner has configured it.
> >=20
> > For containers, we usually don't have an agent (at least in LXC,
> > OpenVZ
> > and Docker too). So it is a container manager's work to figure out
> > how
> > to hotplug a new filesystem for example and where to place the
> > mount.
> > And this was always a reason for some crazy security issues, when
> > some
> > privileged process on the host was entering a container's
> > namespaces
> > (partially) and then suddenly become trace-able or bring some host
> > FDs
> > (and these FDs could be a way to escape via (struct file*)->f_cred
> > permission delegation model).
> >=20
> > Another reason is that in VM you hotplug a device, while in
> > container
> > you can only hotplug a mounted filesystem. And for devices we don't
> > care under which major/minor they land and so on - again, because
> > we
> > have systemd for example and it can figure this out. For filesystem
> > we
> > need to know where to place in in a mount namespace tree from the
> > beginning (we still don't allow mounting a block-device based
> > filesystems inside user namespaces).
> >=20
> > I really like your point and that would be great if we can solve
> > this
> > somehow in a new design.

Dear Jarkko,

>=20
> This is for v4 (latest).
>=20
> MOVE_MOUNT_T_MNTNS takes any nsfs CLONE_NEWNS fd, and populates
> CLONE_EMPTY_MNTNS directly and attaches live submounts without
> setns()
> and FSCONFIG_SET_ROOTNS mounts FS_USERNS_MOUNT filesystems
> unprivileged
> without entering userns.
>=20
> The gaps would be open_tree(OPEN_TREE_CLONE) gating (it's now against
> host), uid_map/gid_map prepopulation and a flag to deny mount table
> changes inside rootns() container while keeping external hot-mounts
> enabled.
>=20
> Those are totally addressable issues.

Yeah, detached mounts API solves a security issue here, but it does not
fully enable the use-case Andy describes (if I understood it
correctly). My interpretation here is that to fully cover it we need
some well-isolated communication channel between container and
container manager (vsock for containers? :-D). And some well-defined
agreement of how PID 1 inside the container can get an information
about a hotplugg-ed stuff. [ But it could be that I completely
misunderstood and Andy meant something much more simple here. ]

Kind regards,
Alex

>=20
> Br, Jarkko
> =C2=A0
