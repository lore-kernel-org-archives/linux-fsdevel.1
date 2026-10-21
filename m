Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792590218;
	b=JujKEAdHHRtWuSVkn0hS/87R9H2mfr7f9Jdx4MARYsaNYG7fxd2Nxb7lfhcPF42LG1Rz
	 YZxe0PuTvH2fsiu2HaEqnq/FVS5l54iiKgA6OYGSCTWuNRPswx1rhknLaH19ijQcmDNbi
	 AASfQVpqxFIyrp04M1uTFxrRGTSbKuold9zkIra+Aypx6T1qRxwGlJI9ZoeWomLvzXhxq
	 ZJ9ErzL1HxdLOhUUDPHjfKNBv5Ntf8oCQx52MCSyRi9gYoHWvQFGJUkuHsHaN2ozs3o/y
	 le1xElG3klgJXL6BzeGb3pcP0f6cXNqWYF/KXAynNoCWzwpDNj91wkRJLsEm/CkRW4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792590218;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=s75NxHOILOz5FSrJREO6t3JPP1FAct3v6+ZsY/6p+xQ=;
	b=vilHsgXv/d1XYwrECg5bqNFi0Zw/5rAkPmnJ31J+s8L+5UwpKW0JK6Yw+1YKZDW3KgRF
	 cI8TC4kAxnJglusUwPFD5qHFc1PZ+fgnPXSl/PQ+HYalyB7eIBDe96iOcky4FyH4R4IGy
	 q83tXSsMJcv9GgA3AblUPzTge/LhTF7gOH6czpfQLchkRf10fPocRQMfGkipth7Os6YdG
	 F8k9CwrzcdgKyhrDv55u5L8WY3/k1OjgEnyZuH1epSA2KcUZnf+XGP7zNQK0ZsUyX6lON
	 +hGYhHtceNC2ton81+SVqDEIMRIE7+V9Db5E/A9RYy6FNaPl4r36NP4tz43+ce+4v0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b="LC/8NoUx";
	arc=none smtp.remote-ip=209.85.160.169
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA96606A31E
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 13:43:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEA96606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=LC/8NoUx
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5350d9ea106so9149121cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 06:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792590216; x=1793195016; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=s75NxHOILOz5FSrJREO6t3JPP1FAct3v6+ZsY/6p+xQ=;
        b=LC/8NoUxXuiE25rp/4NlOUX1awB/dMNyyG+VedsztHNa1VGJntUn8y+i+AvA4PN8aC
         iy0EydFUV69eoe2Idtq0ukxL6L7au6e2C9s+nam6BsYJmssjYoDseY1RlC2xmcOPt422
         /lohP0jqvUaSbkQp3ZMAa68kFycpK61ftcFiU+zolYydPiBB2pnT98uVawSqiWMN7/i5
         NZIr31stidmi5UlwCKKql86O5HHijZ2fYYEXmKBYifN/cu/J7waoPNvV0EPqv8C6TcvH
         Ck5hYImzyyCXrtDeYLWIzZIyOSFBziWD22O+zMqJGV4ZDoSeg6Gl8V55uJKCXn5SHHB7
         Fb5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792590216; x=1793195016;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s75NxHOILOz5FSrJREO6t3JPP1FAct3v6+ZsY/6p+xQ=;
        b=rzBbwnGSJqt3T43V9lmaqFFGtxXUMIEENNPr8L7P6rAAw9yhItb+Y02/rA8WrckRB0
         6mJzIiRUi4gxmnMMPKmQvUnbBe3HPnfnOaZLWN7ul38WKHLMAbcRJ90XPxaPKNRHsil1
         rq1SFj5FkU9YMnwTlblzxnSunFqzOEcMDxQ4jLODH6W/XDUWxbu7DrCNBLU2uiLLS3XU
         iK9RvB+XoqqViG2FsRL0NSGHYxcHEzRTGLTuszSm/HWPThKeozWBdWDpTMxQ+mmnB42H
         mmoxx5UWCcZhoEjGhld6E1j8Hwl5VGoPB4ifBW2Sc6ZwzC2694w9Jrb4/Z5ND2Y/jdrX
         D+0g==
X-Forwarded-Encrypted: i=1; AKwUvBwU63lOkznSGw63+u25tsADDiTU9k/RrfDue45V4F8MbKnkZhJZkG5ZwO5OkT+1Z0fcT2flgmhTgG82mquB@vger.kernel.org
X-Gm-Message-State: AFq9FYI7uVEukrH17Ajuc/hvXUeOKwAGs15HTCadVV4AaFbgka+YHGxb
	eHkJ/QGtMYHmlOmXOIrFPIz2xn/+UFwCHH1yLEfjS3bsKv7Ylx29wXpbCcD1r6Ct0hQ=
X-Gm-Gg: AYBFou3XO0zRrY5NoVzHA84yZH8T8sNDfY2t+/nTK3qGzzkZ0M89y/TQAoLV4z2pgbI
	uEzfxXW7fLQlUcvb57PwTHzhujuLfRfPiGUjwptS6gTA72umGuwfw9/1buqg1OXltzAsqq86UVp
	kDvGD/q+IpJqWwy88aio8Tt3fdQwdlrrH2lbua5dxal2ZfBljlCrNsEtayMGC8BLVDAR9YFxNmM
	m+MspyVdC0/sI8m7VrIEntVkywX/LPp7r92+edc8T0eLd3mftfZ0H0NPlUUrD1VbRUdqBsSeRmi
	cDZ3n8n+ENC7QHUrYqNa2vX+9bS73kuwI45nM/pQj8KiTUm6PUZETdBma6ylcAdcmn/tEStxV7G
	MSPHizIUYAM+M2jTeNMSp1OHIyrTf/9yElkvxpJuSsv4xOcCTAsr7J85f48jMIq0B/Dw0yu2uvX
	kwz1ty6ZqCd17+VW7DYXF5QHk0yJKFRCLjH17ZXI/9rXbgi6sVmXqLrLwQzPLiWEIOatgnzKDQD
	Ls9UKba6DUyRa2Hkc0XpsB6M9vLmCcsLlZ9Xf0rG+gCHAHwpJjZiJhNUVv9CCa1NjAGh4VKG/6I
	l0de54itSqnUhprYnA==
X-Received: by 2002:a05:622a:4815:b0:535:70c4:aca9 with SMTP id d75a77b69052e-5369b891aaemr30121641cf.62.1792590216585;
        Wed, 21 Oct 2026 06:43:36 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.240])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-536ab4af6eesm217861cf.1.2026.10.21.06.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 06:43:36 -0700 (PDT)
Date: Wed, 21 Oct 2026 13:43:23 +0000
From: Josef Bacik <josef@toxicpanda.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] cells: a container as one kernel object
Message-ID: <20261021-cells-rfc-reply-james-9f14d24c9a32@toxicpanda.com>
In-Reply-To: <e7e0c20f2a1f2810f4932a8d4d854f328358fe20.camel@HansenPartnership.com>
References: <20261019-cells-rfc-6f4c85415f29@toxicpanda.com>
 <e7e0c20f2a1f2810f4932a8d4d854f328358fe20.camel@HansenPartnership.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Tue, 2026-10-20 at 22:35 -0400, James Bottomley wrote:
> On Mon, 2026-10-19 at 16:50 +0000, Josef Bacik wrote:
> > A cell is a container as one object. A task is born in a cell and
> > never leaves it, and nothing can enter one, so there is no setns()
> > and no unshare().
>
> I can't agree with this.  If we're trying to fix existing bugs with a
> new paradigm, it must apply to all of the common use cases and entering
> an existing container is common: I use it for my build containers and
> arch emulation containers, sidecars use it, debugging requires it and
> it's part of the kubernetes acceptance testing, etc.

This one is on me, I worded it badly. There are two things we call
entering a container, and I only want to get rid of one of them.

The first is an existing task moving in, which is setns(). That's what
is gone. The second is starting a new task inside of a container that is
already running, which is what docker exec and kubectl exec are for,
they just happen to be built on the first one today. That one is there,
it works and it has tests. Whoever holds the cellfd can spawn into the
cell at any point while it's running, not just to get it going, and
hands the new task whatever fds it should have, so a pty for a shell.
Your build containers would keep the cellfd around and spawn the next
command into it.

The reason I care about the difference is that a task that moves in
brings the host with it: its mm, its fd table, its cwd, the binary it is
running. That is CVE-2016-9962 (the container ptraces what runc exec
brings in and gets at its fds), CVE-2019-5736 (the container overwrites
the host's runc through /proc/self/exe) and CVE-2024-21626 (a leaked fd
and a cwd on the host, again by way of runc exec). The runtimes have
gotten very good at scrubbing themselves on the way in, but it is
scrubbing. A task that is born in the cell starts with no mm and no
files, so there is nothing to scrub. It also means the cell of a task
never changes, which is what lets kill be complete and "dead" mean gone
without any races to think about. And it answers "who may enter" without
a uid or a capability, it's whoever holds the fd.

That said your list does poke at real holes in what I have, so to be
straight about those:

- Spawning from the outside fails with EBUSY once the cell has enabled
  controllers on its own cgroup, which systemd does right away. That's
  question 7 in my mail, and it has to be fixed or the above is a hollow
  answer for anything that runs systemd.

- If you aren't the one holding the cellfd you have no way to get one.
  The holder can pass it over a unix socket, so a runtime can offer
  that, but there is no "root walks up and nsenters by pid". I could see
  a privileged lookup by id later, I would rather not start with it.

- The program you spawn has to be in the cell's tree, which is no good
  for debugging an image without a shell in it. Letting the exec take an
  fd would cover a static busybox or gdbserver from the host, and adding
  a mount to a running cell from the outside would cover a whole tools
  image. Neither is written.

- Port forwarding wants a socket in the network namespace. If the
  runtime makes the network namespace and shares it with the cell it
  still owns it and can still enter it. If the cell owns it then nobody
  can once it is sealed, and that wants a helper spawned into the cell
  or something like a socketat().

For debugging in general you don't need to be inside. The host sees the
tasks of a cell by pid, and a capability on the host still lets you
ptrace them, so it is a good deal nicer than a VM. If we ever close that
off (question 3) it would have to come back as a right on the cellfd.

For sidecars and pods I think the answer is several cells and not one.
The runtime makes the network namespace and puts it in the "net" slot of
each cell, which works today, I added a test for it. Every container
gets its own tree, ids and cgroup, they talk over localhost as they do
now, and volumes can be shared. A sidecar or a debug container that
shows up later is a new cell filled from the same fds, nothing has to
enter anything. What you don't get is a shared pid or ipc namespace
between them, and unix sockets between them carry bytes but not fds or
credentials.

> I think my only problem is with seal. I get that it's a very useful
> security operation, but it's not a common container concept, so I think
> it should be optional.

Also my wording I think. Seal isn't hardening that you opt into, it's
"I'm done building this", the same thing as FSCONFIG_CMD_CREATE. Nothing
can run in a cell before it, so it doesn't take anything away from a
running container. It's the point where the kernel checks that the
pieces fit together and refuses the whole thing if they don't.

If the objection is that you can't change a cell afterwards, that's fair
for what is written today. The plan is that what needs to change later,
adding a mount or a device or changing a limit, is done to the cell from
the outside by whoever holds the cellfd, rather than by leaving it half
open.

> As I said, I think requiring sealing is wrong because it excludes too
> much of what we do today, so I think it should be optional (and
> definitely encouraged as a useful security feature).  Although I get
> this depends on whether the cell thing is going to be a single kernel
> object for a container (in which case it must hold existing types of
> container) or whether it's specifically a new type of container.  Even
> if you're going for the latter, you need to explain what happens to
> non-cell containers that don't fit in this new paradigm.

It's the latter, a new type of container. Nothing happens to the others,
namespaces stay exactly as they are and a runtime can use either. I
don't think wrapping the existing pieces in one struct buys us anything,
the bugs I'm after come from the semantics of the pieces, so the same
semantics under a new name would have the same bugs. The price is that
some things won't run in a cell unmodified, anything that sandboxes
itself with namespaces for one, and I would rather pay that than carry
it all over. What I do want is for the common workflows to have an
answer, exec and pods and debugging included, so please keep throwing
the ones you care about at it. Thanks,

Josef
