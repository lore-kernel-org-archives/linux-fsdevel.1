Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792611810;
	b=kiyTMzD/w8m60QkdvJkiULoMvZkKsspeon12DMV0Y+w2lkVxjMcpDw/EYTwhqNxQTTGw
	 0InOqc4V53fijNSX297qqq9LP5GMnAR1o+uFZi7SAsozCju9pZTQlks0N63+NEUFwNbQz
	 zQtyLvpAeKsJBdT7LUzTqHBNNouPlkXSXUaNkHTtHv2StWIP7gQjBWtfhi72QgBlar2oh
	 huRiCdA+bed+6yA8GvT0nqdmYJ/ul64+yL+3AX5qkpbh7/RIyHQsFabNjydoM8GBVEA2x
	 y0/6Tiz5PseumjxiN8cK3TZSp9iBt6StbEGS+bAyNOSJ8oVIKay35aDAu1kE0T6HDpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792611810;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=mMe0Dl9Q+AdEP6uHnBNDqcH3cfgauISukvDVuYVjfYY=;
	b=2n1Ktl5TXnGos0f+lelOntIG01PNKQ2VX4hGh0znPw2SDNOtw/3rtbWiFVlkn3eCpfnF
	 wLiI8ID5cwkL0rLzy4KNt9/9jqDFfDmw7f+7NQSJxz6xqd3BMnvEXJ62Rk2MqUgZtBi4S
	 1FbEypwN//uDXyK8ffbJe3Cs7DxwkQyZLHZAW6rx3YeEhv15z8g4ee8tyEzRDx6Nr0qiA
	 aYyKTEuV/wgbf1YQGOAP8cvIoLx6+9fbX7PRvBcShfcCwOUDuc2wgar9kxfiM+Vrrio3P
	 pXPhu3JZjnOZi5avgsLjHzh3iw/Nf2Xs61ePjSDA8/3r0gt4m9FxHa6blCwBg+qrVPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b="Cxd/yWPS";
	arc=none smtp.remote-ip=74.125.224.42
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E905606A319
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 19:43:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E905606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=Cxd/yWPS
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-679e86015e2so260987d50.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 12:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20251104.gappssmtp.com; s=20251104; t=1792611809; x=1793216609; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mMe0Dl9Q+AdEP6uHnBNDqcH3cfgauISukvDVuYVjfYY=;
        b=Cxd/yWPSYDzTS9f9NahLI8hV0KEc7fcj8ng6ty+kNeYzKJNA6KUgdBgwldRLymNuCM
         XJPr+WDr/BOQA/6aNRM3Ikmjx31HsHEM18RbQ3KyuiUdMW9200gY+kg7tyLD1Exi7ayn
         qzVWMiBStHI7nEEH+t2h3FEqbtoPI33+EAS27aZxzRjJrb6mAWqQyBNiIlItA/diQRd2
         j24Bx80Pd9qnCqW6NylJbufYJxBcjKxe87xDEGIA9uRjvPHMdPPl7EwGfKsaSGmm9Zqh
         +VfO2FDE21JFdIeCjLg0xbr0RksCtllx9MMFUB2jqYY/jneQZGJpV2K9znmKn6riW/Vy
         Ox3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792611809; x=1793216609;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mMe0Dl9Q+AdEP6uHnBNDqcH3cfgauISukvDVuYVjfYY=;
        b=aR1KvSkP7F5arZs5y6mlr+IibNzS/VsvNmY5Wxh3PvT1Ohc7FS5DscDKEj8NiOkK0u
         mtVlqp/Px9YdRyZUFBlly3DoqMPhltnYWrRxls04fCmsC3+M99xkpt740htJVszUBtfP
         mylxQpN+W7HANBn4WjXGP4h7GYEGThufrhhVaJ5ixoILwNQTAT3Sdk3ebU8hKLwMl0k4
         Ofcg1ZqLxcznQahcKEU9j+PkdQuFU1UPCEd0eRTJ6FSyl5jPwimf5MyPUdylVZlgLy6V
         6hCYP03AHrzyHQP96DwL52btNNAJc+S2PZFjQwWUsiSVokaJNgPJ20WZie/DbB6OtR73
         WG8A==
X-Forwarded-Encrypted: i=1; AKwUvByhxyfiGtAl5M9IDtuh3ztr7LlOmrVVDtawJ7/UjOwU6mH0/136k/ONxnD8hPejYSAf7RcFaf0dYJ9cLyyl@vger.kernel.org
X-Gm-Message-State: AFq9FYJXyoTtjB+yCSRhHrU2K+mW+sbE3LnPr11uLUfSiuAZFuTzSa1+
	2GDwB/ntxt8fqUFzaMl0z8v8ZdyTvEinT0O+QuTrknNlxr3pFZrEj6ElusY9xBQTjV9x
X-Gm-Gg: AYBFou1U0w/Lcv+gYdlwUSarl0vWmakVk2WDwlH0Pq3P89806VN+jzvTScQZEF05rXK
	yOjIwiUzD0VjKB8XDlbfaZY+SprhQbMaygG3hTbXNOtEoAHG4zl/v8JcDGkCSXBA+SD1pjl1OAz
	SOiWEVi00zWG6DuY7tKf4K9LmSkRzgD62+jvHIzJgU06XjyMu8TlLLVoK2Fj/FXsg0OCmkhGCGL
	TBuX/SIBlsUOqDJjqhsn20IwW6m/DpfH2pRNWJIw+090gcHS9NQRvdsLQGWKvy5vn/O/MJJlg/X
	avtww+dYSdYVYDw8Ho8Pwln8O6eJULqW+fGlNHDgZUXU9NcyeLT7iDZEC/cf6qo1sfAGYZr1++V
	92O3kK4YMCdhdOzB83SZlbxQN8cokQ2VQzjKSNr7bVCdH4pl51PtoFCpbUbgMSxW5+Exa08XTTE
	xFo/KQECGzpB3KZBMhOGn2XMPBTLW9Rz6GeIC8Bff+hRK9PZkDhkV172/mzf2MW18wqcD82Pr5i
	MaxWE1SKJBidPSJKc0YPbMvf42MKvwiBsJsmtK6qJRKLNkuF+moUjJYEilYLx9wck9A8ql5aFaO
	3zmHbQxgHnaytZQ0PbQ6wrwiY/y9bp9/qqAhGXGFumFPjQ==
X-Received: by 2002:a05:690e:b43:b0:676:8874:e902 with SMTP id 956f58d0204a3-67a21d2c39fmr206401d50.9.1792611808754;
        Wed, 21 Oct 2026 12:43:28 -0700 (PDT)
Received: from toolbx (104-53-165-62.lightspeed.stlsmo.sbcglobal.net. [104.53.165.62])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a0e496732sm1511608d50.5.2026.10.21.12.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 12:43:28 -0700 (PDT)
Date: Wed, 21 Oct 2026 14:43:23 -0500
From: Andrew Halaney <andrew@amutable.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] cells: a container as one kernel object
Message-ID: <atkRF4FX8DBHPqJf@toolbx>
References: <20261019-cells-rfc-6f4c85415f29@toxicpanda.com>
 <e7e0c20f2a1f2810f4932a8d4d854f328358fe20.camel@HansenPartnership.com>
 <20261021-cells-rfc-reply-james-9f14d24c9a32@toxicpanda.com>
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
Content-Disposition: inline
In-Reply-To: <20261021-cells-rfc-reply-james-9f14d24c9a32@toxicpanda.com>

On Wed, Oct 21, 2026 at 01:43:23PM +0000, Josef Bacik wrote:
> On Tue, 2026-10-20 at 22:35 -0400, James Bottomley wrote:
> > On Mon, 2026-10-19 at 16:50 +0000, Josef Bacik wrote:
> > > A cell is a container as one object. A task is born in a cell and
> > > never leaves it, and nothing can enter one, so there is no setns()
> > > and no unshare().
> >
> > I can't agree with this.  If we're trying to fix existing bugs with a
> > new paradigm, it must apply to all of the common use cases and entering
> > an existing container is common: I use it for my build containers and
> > arch emulation containers, sidecars use it, debugging requires it and
> > it's part of the kubernetes acceptance testing, etc.
> 
> This one is on me, I worded it badly. There are two things we call
> entering a container, and I only want to get rid of one of them.
> 
> The first is an existing task moving in, which is setns(). That's what
> is gone. The second is starting a new task inside of a container that is
> already running, which is what docker exec and kubectl exec are for,
> they just happen to be built on the first one today. That one is there,
> it works and it has tests. Whoever holds the cellfd can spawn into the
> cell at any point while it's running, not just to get it going, and
> hands the new task whatever fds it should have, so a pty for a shell.
> Your build containers would keep the cellfd around and spawn the next
> command into it.
> 
> The reason I care about the difference is that a task that moves in
> brings the host with it: its mm, its fd table, its cwd, the binary it is
> running. That is CVE-2016-9962 (the container ptraces what runc exec
> brings in and gets at its fds), CVE-2019-5736 (the container overwrites
> the host's runc through /proc/self/exe) and CVE-2024-21626 (a leaked fd
> and a cwd on the host, again by way of runc exec). The runtimes have
> gotten very good at scrubbing themselves on the way in, but it is
> scrubbing. A task that is born in the cell starts with no mm and no
> files, so there is nothing to scrub. It also means the cell of a task
> never changes, which is what lets kill be complete and "dead" mean gone
> without any races to think about. And it answers "who may enter" without
> a uid or a capability, it's whoever holds the fd.
> 
> That said your list does poke at real holes in what I have, so to be
> straight about those:
> 
> - Spawning from the outside fails with EBUSY once the cell has enabled
>   controllers on its own cgroup, which systemd does right away. That's
>   question 7 in my mail, and it has to be fixed or the above is a hollow
>   answer for anything that runs systemd.
> 
> - If you aren't the one holding the cellfd you have no way to get one.
>   The holder can pass it over a unix socket, so a runtime can offer
>   that, but there is no "root walks up and nsenters by pid". I could see
>   a privileged lookup by id later, I would rather not start with it.
> 
> - The program you spawn has to be in the cell's tree, which is no good
>   for debugging an image without a shell in it. Letting the exec take an
>   fd would cover a static busybox or gdbserver from the host, and adding
>   a mount to a running cell from the outside would cover a whole tools
>   image. Neither is written.
> 
> - Port forwarding wants a socket in the network namespace. If the
>   runtime makes the network namespace and shares it with the cell it
>   still owns it and can still enter it. If the cell owns it then nobody
>   can once it is sealed, and that wants a helper spawned into the cell
>   or something like a socketat().
> 
> For debugging in general you don't need to be inside. The host sees the
> tasks of a cell by pid, and a capability on the host still lets you
> ptrace them, so it is a good deal nicer than a VM. If we ever close that
> off (question 3) it would have to come back as a right on the cellfd.
> 
> For sidecars and pods I think the answer is several cells and not one.
> The runtime makes the network namespace and puts it in the "net" slot of
> each cell, which works today, I added a test for it. Every container
> gets its own tree, ids and cgroup, they talk over localhost as they do
> now, and volumes can be shared. A sidecar or a debug container that
> shows up later is a new cell filled from the same fds, nothing has to
> enter anything. What you don't get is a shared pid or ipc namespace
> between them, and unix sockets between them carry bytes but not fds or
> credentials.

I'm not sure how big of a deal it really is, but I've used k8s's
shareProcessNamespace[0] in the past to do crummy things from a sidecar
against the main container... e.g. signalling it or poking at its files via
/proc/<pid>/root. Folks do that sort of thing often enough it seems.

As I read this, we're ruling out implementing support for that via:

  1. A slot to share one pidns between the cells of a pod. That's
     further complicated by the same cell rule about signals / ptrace
     iiuc.

  2. One cell for the pod that creates each container's namespaces
     itself, since CLONE_NEW* is EPERM in a cell. Spawning every
     container into one cell from the outside works, but then they all
     share the same root and cgroup.

But back to the bigger point, maybe that sort of thing is something
cells intentionally don't allow, since it opens a can of worms? Just
does present problems in adoption I guess for k8s world, but so does
idmap mounts in a lot of contexts (/me looks at various filesystems),
etc. Might be worth kind of explicitly calling out if the stance is
really strong on that front. Sort of thinking out loud here, I like
the ideas and am trying to brainstorm usecases that might need thinking
thru better.

[0]: https://kubernetes.io/docs/tasks/configure-pod-container/share-process-namespace/

Thanks,
Andrew
