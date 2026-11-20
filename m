Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795204425;
	b=2uRfF3tGp+DlB4se0B5shfRZtnPO7RzqVxJLY5mt+ckm1wj7TBU25GPmWyyhQCUX9eoM
	 r7EymPFiDEhnRqf5FdQrMndD8+/429k7VK+W3irJ2tF9tdBhg7iJ/T+9ZVFP3Cr6pUhD4
	 YXF+Cq6daxBkbzMbsQAXqVWd24MUDRPpNr1GRpYCZFD9sAsjz3N2c36Ly5FzNsUSro+QE
	 gfOpudXbS/8T0oRW8ys9wJWxhO7bpNP3MA58jxg9xcF7f6BRc2xXoPKTbulTRLm0D/moq
	 kpPQTQOlC5n2XE0ur1y+nu5c7acGUQd7fH6CXeSQb5NkTWWJL4Nio32nZN+N599S8jA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795204425;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Y76CwwbIFFZSLzT6VqrJeNVAmGacmUJL5O9mQNR1EcY=;
	b=TWGDRrxQGR/FIJS1suvZrAn5aoljaD03Rx+5eYJiWMYMFQmvG0qXSyPrY0APxs7iBI80
	 sfNfNAIMhSJ24IPQUCHlyJDiSDC4WHUM4NxcKltGguiAVt7njfUo9W7zrTIH6VRWNdPb7
	 Ee/soqI1Czi75o0LOCTYa7tkhpLydK+Cut7Shv3yhU7aDoYx2o2+MfVwMUhF8lkCtcY6q
	 WJh+RkAemxV4Vcz4kqzB/+p/5SL7vijVikbBvj8Hf9GqrgZSzRkj600jCC4ilcaDYT1JB
	 OnI7qDNPe3C2WCb6V+Enl6Xp2swqwk3pUP2LY6eWXVeiRbyJvb9CGCCHoiTdejlvAlQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=amacapital.net;
	spf=pass smtp.mailfrom=amacapital.net;
	dkim=pass header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=OIzOhE5i;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.53
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7B3606A6E0
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 19:53:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB7B3606A6E0
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=OIzOhE5i
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5be3cff0f6cso887121e87.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 11:53:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795204423; cv=none;
        d=google.com; s=arc-20260327;
        b=Kqs7FXy/1dvmIaCiSHGDdYrEtVbE7RGomQ+ty1+hJYSoZ6WmK68LT2G+VDRRrHQfwH
         K5Bt3Io+q5styZQ5pn3prW8jzctVT6Yg4DoVH+wlVr58QpcpToMqKEPCX7IXQ4Xg0GWU
         neZmZC5UxchEcFgxoOOlnbKrgSTIgz4VD0t4wKEl9GwpBwDyYkc1bvjKv5iaYqcvJ+rG
         CE78DHQ9W0s0JSm8DllzMJ1F1DHCQt/ueHMw5lagtYg9Xa3PvtfuVeqDEkWdvNfRJUuD
         JXYujWlxecNkyG5A5ZoRnW2IATvujbUL1qQh60oB95VMC29cZE1Lf2pbcKrlYJl3mcTO
         vUbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y76CwwbIFFZSLzT6VqrJeNVAmGacmUJL5O9mQNR1EcY=;
        fh=VLgizflM8PLlcIX/I/e8xC1oUIqRW1qcmoa//lMcZP4=;
        b=npvqdV1IakCNcwpqKpJ78JIzBCCZW3aXxFbqvs5EBrDjH2Jc5Cew/jGCCtS6f7U8X5
         iu94KjAa4jeEQMcoE7xuOGFZG0xwaOac3+w+Esw2XJildvNkctKEsC+cxbtw8ePwAZBB
         0VsuGotiOYlPgcSK5GIxHYiCvyUiT9eD6dj/rBFOWOdVYA6OdxRsFH7JrWe0E/PaBztE
         DemaiZLKEG2+JELOsE43NylLrvz6BkdXiw0k9DrY4TIWe0pK6ti6Huwc/z2hYTAaGEJy
         RkuOQuJnbPYi3nedlk15cr8DrbmWiPZmfQeXnzW+OuHFN/xom7Ng87Vm6ZQH/ohKxDgx
         3U6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20260707.gappssmtp.com; s=20260707; t=1795204423; x=1795809223; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Y76CwwbIFFZSLzT6VqrJeNVAmGacmUJL5O9mQNR1EcY=;
        b=OIzOhE5iObSc8vEouH0agFHpvADyEkxMoLtQygTw3RAog7Wv+L7LAKHBfx6tywTWla
         XUmS9LeJ7PnxVQ8l/3h5q4xOUl+0sR1Yhl89cyUVCQFQ6WCNIJ01mU32NChKR7y23gEJ
         n6jCSfPaTpMmvNA7KdBLfnQPGXRT46ttzJgAvgufnJa4wXOuJ17zrS9bXry+tvzH4oPw
         y8KH2mJUm+Io56eSd80lF5wNq2JRo3v7s3MN3hIShmIFHlUZKroZclqXKbLIjGE9o4oI
         gDJi5i5Hy/If+d9CSXWm+OtWA52rz2oh8TdXKQlysnEYYdN/92oAHLZ0UJRgGJo4WwVZ
         xk2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795204423; x=1795809223;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y76CwwbIFFZSLzT6VqrJeNVAmGacmUJL5O9mQNR1EcY=;
        b=giLcflDI1hqykaxnBgnCAV+XMwmwtLhov9lT1f0y+buSNA9jcxZkNoIlMSZGEY9fYn
         ZmVwLx5MyaBfTmgruwla1uX6Nq4tG42ioUZr2BYRSLi1QRin6vSwf67SADKjqKq4qzcB
         FSWnGuo2vj1nLWvK+9raX+Zq6p4xbMpCDDZbleY4HRqnCsmYYuhkKM9/YRctjd76i8/x
         CXyJ1UdUIRzcc/5IDhM7OSzhxLowT2baDs+aaDX/884aP0IH0dsm57jVhVmfyjygu9uO
         66L3hM0U8OElThoeYzo9m8O73nTD6/JKRRCTyKUkcTzad+tdcuUOwfZt6YaLsMVH4IS2
         kW1A==
X-Forwarded-Encrypted: i=1; AL+hErHLxUko228F5mPKOnV1gJvARcFKd9/dtvy+NASh6Gn2vSgyM0EIQGvKWiK8X1Pn8zBJi1XrcaCbpLKJcsV6@vger.kernel.org
X-Gm-Message-State: APuU4Z+MQhoLtD0Xd6aGsffvJmbvDbtnGBc1RsXYXaMlt7xAvEhILJUF
	Bs1LaJ8bSDVifrb/FxihaSJWXT1WkrmrRPzLlfKvkARzLXkvVTGdlDd1d8VgIydDcHN37m6bgPM
	UBJggkdu2kzJqDW18fOb15YVvvcneKBKuIuEDbu33
X-Gm-Gg: AZFdTZet23MrXr0R8o62KiO+35eUQuvSW4yDbVmtJyqmI+9M7V2qNLr2Qltqsy1bNqS
	3L6pl1q8GX3HTcNFHBSteMk1fO41InauZLYXgJE6GPBlqJqt9v/AtMWnbh57ng6XW4/8PEDJcyy
	mA/ims7/+sACDLACkO1Fe2VdLaxUpq6zfnVJ85dCwI1uPYIyoCv4U1mbYMrRTwvQCKDzQcNCssi
	QeeAxqgyxxKv0cx5vdYO4mGrys9ld/wRnd4BG3JrGW2Vq03GqSYNeTj8PVOycxd0N9zZBL0qthD
	FW8rLutJ6Ff6qxQvbr0j77vlqv5troCP5H6cmA8KZwy+ZtySm8GzUcWZU9gHJF0Ujuy5PtW2d5B
	k09GS5WQxwBRSHxfKYbxdyM2VsAUeYXQ8Xw==
X-Received: by 2002:a05:6512:1046:b0:5c1:acec:260e with SMTP id
 2adb3069b0e04-5c1bc8432bamr1303866e87.55.1795204422738; Fri, 20 Nov 2026
 11:53:42 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <av3bkDnwmjunTleX@kernel.org> <CALCETrXPLeUgxyhjP4XuWS46FKB0TUHF5PcMkdMf+qeEXbyXRA@mail.gmail.com>
 <9463a969d35a7d5ec5a56aeb67644b94.josef@toxicpanda.com> <CALCETrXt-Do28BHDpbrA98kEy-tQuorxD8c2XsW24Tt8Vspdtg@mail.gmail.com>
 <CALCETrUbe8rBoxrC+Q66AMsrJ8Fow7xt5KJKRAmobtXBvHWdqg@mail.gmail.com>
 <c301fff20a4920fcd3baa31dda2e31ad99c93436.camel@amutable.com>
 <awBHZO2VwWyJzvBN@kernel.org> <1f12636403bb7af3759cd933b2612d8a5d7317a2.camel@amutable.com>
 <awBRyKgOQlaEqpWX@kernel.org> <awCg5VYXKJvex9vy@kernel.org> <awCkANwNDox_99SR@kernel.org>
In-Reply-To: <awCkANwNDox_99SR@kernel.org>
From: Andy Lutomirski <luto@amacapital.net>
Date: Fri, 20 Nov 2026 11:53:30 -0800
X-Gm-Features: Aa3M54pKxDm6eU_2Sjm44hIEowicdxL9W6xw2PHKnbweFLV6y91fuj5aPjITmFQ
Message-ID: <CALCETrUnQjrWmSzL-FOqFF+_enxVsEM0On7orydXLCO-L2f23w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/13] Namespace for namespace roots
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Alexander Mikhalitsyn <alex@amutable.com>, Josef Bacik <josef@toxicpanda.com>, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>, Serge Hallyn <sergeh@kernel.org>, 
	Kees Cook <kees@kernel.org>, Paul Moore <paul@paul-moore.com>, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 11:48=E2=80=AFAM Jarkko Sakkinen <jarkko@kernel.org=
> wrote:
>
> On Fri, Nov 20, 2026 at 09:35:06PM +0200, Jarkko Sakkinen wrote:
> > On Fri, Nov 20, 2026 at 03:57:32PM +0200, Jarkko Sakkinen wrote:
> > > On Fri, Nov 20, 2026 at 02:24:57PM +0100, Alexander Mikhalitsyn wrote=
:
> > > > Yeah, detached mounts API solves a security issue here, but it does=
 not
> > > > fully enable the use-case Andy describes (if I understood it
> > > > correctly). My interpretation here is that to fully cover it we nee=
d
> > > > some well-isolated communication channel between container and
> > > > container manager (vsock for containers? :-D). And some well-define=
d
> > > > agreement of how PID 1 inside the container can get an information
> > > > about a hotplugg-ed stuff. [ But it could be that I completely
> > > > misunderstood and Andy meant something much more simple here. ]
> >
> > The sequence for hotplug (Andy's use case) breaks down like this and is
> > doable:
> >
> > 1. Host creates rootns(ROOTNS_SEAL_MNTNS).
> > 2. Host sets uid/gid maps with NS_USERNS_SET_IDMAP.
> > 3. Host populates "/" with MOVE_MOUNT_T_MNTNS, optionally combined with
> >    MOVE_MOUNT_CLONE for bind mounts.
> > 4. Host spawns PID 1 with clone3(CLONE_INTO_ROOTNS) (optionally passing
> >    an AF_UNIX socketpair fd for communication).
> > 5. PID 1 watches /proc/self/ns/mnt via fanotify(FAN_REPORT_MNT |
> >    FAN_MARK_MNTNS, FAN_MNT_ATTACH) or polls /proc/self/mountinfo.
> > 6. On hotplug, host mounts the filesystem via fsopen()/fsmount() (plus
> >    optional MOUNT_ATTR_IDMAP).
> > 7. Host creates the mountpoint with openat2(RESOLVE_IN_ROOT) + mkdirat(=
)
> >    and attaches the mount with MOVE_MOUNT_T_MNTNS.
> > 8. PID 1 receives FAN_MNT_ATTACH and queries the new mount via
> >    statmount().
> >
> > ROOTNS_SEAL_MNTS, NS_USERNS_SET_IDMAP and MOVE_MOUNT_CLONE new features
> > that are yet to be submitted but they were not tedious to ramp up.
> >
> > I'll include them to v5 of the patch set. Thanks for underlining this
> > part because that led to having those.
> >
> > Architecture scales to this even if my choices to address these details
> > would need some adjustment.
> >
> > The clear two-phase (build/live) progress with rootns sort of just give=
s
> > room to address stuff like this, and I have hard time to believe that i=
t
> > would get much better than this.
>
> A completely new feature is NS_USERNS_SET_IDMAP:
>
>     nsfs: Support NS_USERNS_SET_IDMAP ioctl
>
>     Configuring UID, GID, and project ID mappings or disabling setgroups(=
2)
>     for a user namespace currently requires writing to /proc/<pid>/uid_ma=
p,
>     gid_map, projid_map, and setgroups, forcing container managers to spa=
wn a
>     live process before populating a filesystem owned by that user namesp=
ace.
>
>     Add the extensible NS_USERNS_SET_IDMAP ioctl on CLONE_NEWUSER nsfs fi=
le
>     descriptors to atomically configure setgroups policy and UID, GID, an=
d
>     project ID mappings before any process enters the namespace. Enforce =
the
>     same single-write and capability invariants against both current_cred=
()
>     and filp->f_cred under userns_state_mutex.
>
>     Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>

I'm highly in favor of this.  But maybe not as an ioctl.

If you have an nsfd for a userns and that nsfd is the "control" fd
(however anyone decides this is formulated), why does f_cred matter?
It should be possible to create a userns without privilege and
SCM_RIGHTS the fd to a privileged uidmapd.  (I fixed the rather
screwed up workflow for this in newuidmap/newgidmap a few weeks ago --
this is remarkably easy to screw up.  It'll make it to a distro near
you some day.  It's supposed to *work* even without CAP_SYS_ADMIN in
the picture, and it did not.)

--Andy



--=20
Andy Lutomirski
AMA Capital Management, LLC
