Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792957599;
	b=SjLbdh0mJSwMQ510uLxHnSqdrLsz44Ik2hcucDswsqXAmI4LxvkeU1NmUfvn29PaMeEw
	 /lJfU14gbVynCcklF4ndubleM+1K127hp26gHll47ejm5B1ZZ+zW9WkwbA6Onh2Lf1zS6
	 KV/f46lL9iFXa5ssJlZxaWEVCupL+zcDLdW/YWRO82Uj/oB5vaG1mH/lDLrdIjBMHGliY
	 +qHnoJeZ0EyOwydc2f3n0pxXmooITDqBckis+BuE6/Q7Hd+OjUfVSB3WoDBoNaaCW/RZI
	 Fj5iKy0obLHx8eNTkZBGTRmmMF0AlMuMZdiHBelcnTLZ3WqsMqb964yfCpa6jCQBdwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792957599;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=SYt+aoQxRmnF4C9NvHGmpWUSn5WxPau3fcwUlHQntqk=;
	b=MRsDHApPzT9Gx0lcioYYDIn7hQCXGL7imF6GK4ys82TuaVAWYqytV7pGhp6B56aBkRQS
	 rMLfRwd2mElGo2S5n/yCgsk2BxElz226hkSi3Xn2SsJq/ad6Puf9T0E2NbK96CCUu4boY
	 kWf50puJP1PFqm+gNAakf/f0+m2ruwTHUwLLonFrD5KAVz9eSP6JFBpWk5nxgoAqEn1r5
	 DJJlwhwNsesTUiUf8JBHRmXZjS0pP2JxUfFHdXBVGTtJFNIbvHuIGpUXMS4+qd1toXOKU
	 lphockV4Bn4Cv6BLTyGuEHLfntUqZXoef/g3jl8x36eFCkfXI9J5i9Z4yscqBvzf3Cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=c5jsJHAa;
	arc=none smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EB5606A31B
	for <linux-fsdevel@vger.kernel.org>; Sun, 25 Oct 2026 19:46:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9EB5606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=c5jsJHAa
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8a594d313a3so113336b3a.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 Oct 2026 12:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792957598; x=1793562398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SYt+aoQxRmnF4C9NvHGmpWUSn5WxPau3fcwUlHQntqk=;
        b=c5jsJHAaIN38SlfdKU8ekiBT3V+WfCUq4oKbDZuJ0Gw8AtbbwtdvjJ3xmF6SX1Fh6F
         hpS6I+nsLmsZ18Xb4NA/KuHo8wtigum+sxrosjmRxkdkOwC7y/jWHzMqpXTc5lfLbFzi
         FTnSrSfXV3XkxOHpQbyrmKZmGyFq+Wy2nMwV3/vyNRPt46W/hgyv7JUxUOQVDfm7DCls
         yk2tfya3yRtcpV5ALPotWopwCX1sroTfVBcb0SUnOHoNwJ9k0HJraaAp/IH9bG5Vvrwm
         ZJqja46wdgBBOxZsEyj29kBxIMBtqUUe0PMX41Xf0rEGapuge9sQXS5TyV3tuslsc2FL
         Vynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792957598; x=1793562398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SYt+aoQxRmnF4C9NvHGmpWUSn5WxPau3fcwUlHQntqk=;
        b=JwyqMAYG+X/xRZlwsbU87GdcS2JfGSSd7jenq3ikmBbq1IabwpJrwqRDePMg67XH4m
         UrKBPbnytxDxEyphVTXV7xoskcPGld+EB1D+xCNy8PaaG31SIUQ4sRno0I1nx9J8VvNS
         ZFGQQ0TK3AlUFcZ/qThYiDxM3Anz4/kJnIEmA8W3tGYREn7rLUHdkfGBhvxC115lFVqN
         EaqQPpG/aqd6XfPofYI8+0+sFnE5O6jSpdSyBSptkgLzsgM7FtbsJJNRf/JO8hiQruyx
         PFCtvlvkUX+AarDc3S8VQ0LHwU128O5PY1jChPhIWT1+F8ch1qLjs0xbn2q6fXE+KbgP
         JnHg==
X-Forwarded-Encrypted: i=1; AKwUvBwrl6gY96VHYykDem9KjNhRb4sZ5BVxA1HN5x1V3C9EM4iybBT/Cc1huP686iuEs2henjGYlydNok85SG2h@vger.kernel.org
X-Gm-Message-State: AFq9FYLB8BMQDQXjdDj9m55toO/lvOBR8BHGe81cVu4D0d+ixjDclJWZ
	/hslHi/rGc3z3dxgmq1XrYsrbfbvOdnEP5Mudw0pr2dGNgVYZ2K2mlAm3SWJcg==
X-Gm-Gg: AYBFou2EPXS3xIunQNrPPzWTIxhXxxx2qE+FJwSK7Db/+7dy/rIyxp+rcZ6CDXIbcUk
	SQ7OFfC5pqQKfQrotksOc1HtgQmzUXVRv036cyRQoinNpwdMpCdolv9ZJ1KFiujYd6cAZUU8VXx
	A1NYsLRTOf6lRjdcLvlxeufd2BuhCMEVOOfou3NRxEb6s6b+IQFjNt/h/js0gWzdizEG9LKBnsO
	v6XuuLAihzVx70AyyYAmHe5sydnuKTblObXanqMtMTWSzJwSTjm7lDTE44LqFLdhtJ8Twjk0Rb0
	t8BTMMap/63ofSFJl28881limhiIM0DDQv/8p5sybPwnYrofQUBRMS/zHUQVN9ItdXs1Kt2kI1V
	QnKFw/vPUPxVZaju2rZx/O+57HjTf5rOgpH7Pjd+Mwab4+6LVxGcX56gt2CYZBm0GS5wF8rpUQx
	cYtKpSqUaeXpsp+/hPkIOL2SSIG9TpaLmfcDynxIJF8ikmY0udWjQDweST6IeEYcncgVtAArfSc
	rQmh38H8zMIZzHrJVpzRnKQxKtYeZwWect1PxSf5ZrwuvHNBnL+NmWUykxqmL3HvQFLGoNqQVBr
	EbcZmfxsywm8kEVh
X-Received: by 2002:a05:6a00:12db:b0:88b:7278:ebf4 with SMTP id d2e1a72fcca58-8a366994c62mr4272304b3a.18.1792957598012;
        Sun, 25 Oct 2026 12:46:38 -0700 (PDT)
Received: from nineveh.sos.local ([131.191.24.68])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a36ada2676sm693980b3a.15.2026.10.25.12.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 12:46:37 -0700 (PDT)
From: Jeremy Bingham <jbingham@gmail.com>
To: josef@toxicpanda.com
Cc: brauner@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] cells: a container as one kernel object
Date: Sun, 25 Oct 2026 12:46:33 -0700
Message-ID: <20261025194633.1983075-1-jbingham@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261019-cells-rfc-6f4c85415f29@toxicpanda.com>
References: <20261019-cells-rfc-6f4c85415f29@toxicpanda.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Hello,
> 
> This is the thing Christian and I and a few others have been going back
> and forth on, a container as one kernel object instead of a pile of
> namespaces that userspace holds together. I have a barebones
> implementation of it. It's 62 patches on top of the 13 patch cred series
> [1], and I don't think anybody wants that in their inbox for what is at
> this point a design discussion, so the code is in a branch, and what's
> in this email is the pitch, the things I would like opinions on, and the
> design document from the branch in full at the bottom so you can quote
> it and yell at specific lines.
> 
>   https://github.com/josefbacik/linux/commits/cells/
>   git fetch https://github.com/josefbacik/linux.git cells
> 
> That's 6cbfd1952c30 as I write this, based on vfs.all. "Cell" is a
> placeholder name, I don't love it, suggestions welcome.

Coincidentally, I've been thinking a lot about some issues adjacent to
this, albeit not exactly the same. What I was thinking about what would
be required to get something more akin to z/Arch LPARs on amd64 or
arm64 machines vs. your standard Linux container, which then morphed
into wondering about what might be possible in the space between
standard containers and a fullblown VM under a hypervisor. There are the
microVM options out there, which look useful, but still weren't *quite*
what I was thinking about.

Obviously we can't get a direct analog of a z/Arch LPAR on non-z/Machine
computers, but this "cell" idea might fill the kind of role I was
envisioning. I'll be grabbing that tree and taking a look. I'll be
leaving some comments below.

In regards to the name for these objects, how about "stylite"[1]. A
stylite was one of those monks who would spend decades sitting on top of
pillars, isolated from the world. The only ways to communicate with them
were to get a ladder and climb close enough to talk, or send things up
and down in a bucket tied to a rope. I think that describes what we're
discussing here pretty well.

[1] https://en.wikipedia.org/wiki/Stylite

> The pitch
> ---------
> 
> A container isn't a thing in the kernel. It's eight kinds of namespace,
> a cgroup, a seccomp filter and a pile of conventions that the runtime
> holds together. The kernel can't name it, can't kill it in one go, and
> can't tell you what's in it. Privilege inside of it hangs off of uids
> and user namespaces, and a task can be half way between two sets of
> namespaces at any given moment, which is where a depressing number of
> our bugs come from.
> 
> A cell is a container as one object. A task is born in a cell and never
> leaves it, and nothing can enter one, so there is no setns() and no
> unshare(). You build it from the outside by filling named slots from
> file descriptors you already hold, you seal it, and then you spawn tasks
> into it. Holding the cellfd is the authority to do all of that, there is
> no uid or capability check on it, and making one takes no privilege. The
> cell lives exactly as long as somebody holds the cellfd, when the last
> one goes the cell is killed.

I find the idea of a single object container very appealing. There are
a couple of things that I thought of that might make this easier to work
with, although they might be more appropriate for userspace tools:

* Channels analogous to golang channels one uses to communicate with
  goroutines. Obviously, these ultimately end up being filehandles, but
  providing a ready interface with read, write, and read/write
  channels to interact with the cell might be clearer to users than
  "grab some filehandles and toss them at the cell".
* Provide a convenient way to attach a network interface. I would think
  that like standard containers, many cells would have services that
  communicate over the network running inside.

> Spawning is the other half. clone3(CLONE_EMBRYO) gives you a pidfd on a
> task that exists but has never run anything, you set it up with
> task_configure() the way you would set up a mount with fsconfig(), and
> then you start it and it execs. It starts with no mm and no files, so
> what it has is what you gave it. I think this is useful without cells at
> all and would like to send it on its own eventually.
> 
> A few rules fall out of wanting the boundary to actually mean something.
> The kernel allocates the kuids for a cell out of a reserved window, the
> builder never names one, and those ids can never be stored on a
> filesystem the cell doesn't own. A uid means nothing across cells, not
> an equal one and not 0. Files impart no privilege, every task has
> no_new_privs, and set-id bits get dropped on anything a cell creates,
> chmods or opens for writing. Unix sockets carry bytes between cells and
> nothing else, no SCM_RIGHTS and no peer credentials. The mount tree is
> built from scratch, nothing in it hides anything, and nothing propagates
> into it.
> 
> What I would like opinions on
> -----------------------------
> 
> 1. The shape. One object, born in it and never leaves, nothing enters,
>    built from the outside out of fds, authority is the fd. If you think
>    this is the wrong shape then the rest doesn't matter, so start here.

The basic idea for the shape is sound, I think.

> 2. The id window. Blocks of 65536 kuids come out of the upper half of
>    the id space, and "nobody else holds an id of this block" is what
>    replaces the privilege check for mapping a range, so it has to be
>    enforced. With CONFIG_CELLS on the host can't chown a file to an id
>    of 2^31 or above anymore, because the check has to go by value. This
>    is the one I expect to get yelled at for, and I'm open to better
>    ideas.

Unfortunately, I think this could easily become a problem. Maybe instead
of slicing up the id space with its upper half, you allocate a separate
id space?

> 3. Capabilities. A capability held in an ancestor user namespace still
>    applies to what a cell owns, so root on the host can still signal and
>    ptrace by pid. In the checks that let one task act on another I
>    closed the branch that goes by a uid, euid 0 included, and left the
>    capability branch alone. I would like the boundary to be hard in both
>    directions, you hold the cellfd or you have nothing, but that is a
>    much bigger conversation. How far do we want to go?
> 
> 4. MNT_LOCKED (Christian, this one is for you). The seal refuses a tree
>    with a locked mount in it, since a locked mount hides what it covers.
>    But for a builder that works in a user namespace of its own, the
>    kernel locks the tree itself onto the empty root of a namespace made
>    with FSMOUNT_NAMESPACE or OPEN_TREE_NAMESPACE, so an unprivileged
>    builder could never seal anything. I exempted exactly that mount, on
>    the grounds that there is nothing under it to hide. Is that right, or
>    should it not be locked there to begin with?
> 
> 5. seccomp. An embryo inherits the filters of whoever made it and they
>    apply to everything the new program does, but they are not consulted
>    for what TASK_CMD_START does on the way there, because the exec isn't
>    a system call of the embryo. So a filter that denies execve() and
>    execveat() to keep a task from running another program has to learn
>    about task_configure() as well, same as it once had to learn about
>    execveat(). This is only about tasks of the host, a task of a cell
>    can't spawn at all. Documented for now. Good enough, or do we run the
>    filters at the start?
> 
> 6. Lifetime. A cell dies with its last cellfd, there is no opt out and
>    no way to look one up by id. An earlier version had this as a flag,
>    and without it you ended up with a running cell that nobody held, so
>    nothing could spawn into it or wait for it, and killing it meant
>    going around it by pid or cgroup. You can pass the fd to a
>    supervisor. I would rather add the foot gun later if somebody really
>    needs it.
> 
> 7. The budget. Spawning from the outside fails with EBUSY once the cell
>    enables controllers on its own cgroup, which systemd does right away.
>    It needs a leaf below the budget for spawns to land in. Does the
>    kernel make that leaf, or is it a convention for the builder? Also a
>    cell with a block of ids can't mkdir in cgroupfs until cgroupfs can
>    be idmapped.
> 
> 8. procfs, sysfs, devtmpfs and cgroupfs. There are no per-cell instances
>    yet, the builder assembles those with what exists today and can get
>    it wrong the same way a runtime can today. Where I want to go is each
>    of the four taking the cell as a mount parameter and showing only
>    what the cell holds. That's a lot of work and I wanted this out
>    first, but I would like to know if anybody hates the direction.

I think that per-cell procfs/sysfs/etc. mounts is ultimately the way to
go. More revealing procfs/sysfs/etc. mounts would be acceptable in the
initial stages, but it ought to be dealt with before it's "done".

> 9. The API. Five system calls, cell_create(), cell_configure(),
>    cell_info(), cell_open() and task_configure(), no ioctls, with string
>    keys in the style of fsconfig(). The right to spawn is a slot as
>    well, reserved and always empty for now, which is why cells don't
>    nest. We do want unprivileged things to be able to build smaller
>    cells out of what they hold eventually, but it touches ids, cgroups
>    and mounts all at once and I left it out.
> 

I'm very interested in this concept, given that I've already been
thinking about ideas like this, so I'll pull these branches and
experiment with them as time permits. I'll be following this with
interest, and if I come up with anything worthwhile I'll report back.

-j
