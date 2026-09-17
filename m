Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224472135B8;
	Thu, 17 Sep 2026 10:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789639706; cv=none; b=spHlYAxVGrzabK1OFpvuUMyGGArJLUr4iTH/PPYV0rdDQ6phxyGTgnd5+WH2byJqM0FDzDAMKsvo3a8rfo5nDGchPM99o5YD/e1O2DJ4Ti2LrHP2/G4w0RlBxSLpfzktVNq2udVHATbZk6cT19ts9sTE4twTiMZYvSILwsHnydc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789639706; c=relaxed/simple;
	bh=OvoD0jfo0JSg6ilUPHm45pyrK53+/ioAkKf0HloE5Es=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=BMWaNGSbqB5FEwSjYSW5D506mN2p1ecJNRI02zQVPjodqDO/9oVFFIZ+++qJhRr8ESYgyrzftKchEw0jrtAleoWX+d0gtLrm+oHeupP1rrlv3U0h1utCeM+cXzY+R1U8yUwiE7KNuSz9lNj3tG/fLgOWtxuVN57InecD4gUQH5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z58226+8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z58226+8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2929D1F00898;
	Thu, 17 Sep 2026 10:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789639698;
	bh=he+U2PvQT8h0aaCK77sEX6BMLC5kT22NcW/rzWEPQS0=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=Z58226+8DY9+G9AqreqD5Bxnak+yg+tU8PPt95GmmygaXSLtMie0UcADM2xHu4fHA
	 AGzJazt0qeQHkE6O9GOfhuhT1OT9JVaPvsUYWmjZuYrnVlBewQpP43NwfjV/ZPZBXX
	 8udvPgNzh/4D1vtbuPeuSNDplcwfb/EW4cEKRQUPdWXaYpAiLczPhe/xyUCYsX2HdJ
	 7ijGgupe+mKNGArUMKhBXMdg/RZUYeCb3xfbiG7tRyIjdh6EXA2HPe49CKpPcZDX6c
	 //2GH1Z15ocuQ4wlGSRkyoZZrrOX6XwR7/S/e1pVJiVllIm6qLH6GgKyBe6aY2x8aP
	 N+wRcfBpberIA==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 0/4] kernfs: don't hold kernfs_rwsem across
 dir_emit()
From: Christian Brauner <brauner@kernel.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Tejun Heo <tj@kernel.org>, Christian Brauner <christian@brauner.io>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Meta kernel team <kernel-team@meta.com>, linux-fsdevel@vger.kernel.org, 
 driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260911182815.1992483-1-shakeel.butt@linux.dev>
References: <20260911182815.1992483-1-shakeel.butt@linux.dev>
Date: Thu, 17 Sep 2026 12:08:12 +0200
Message-Id: <20260917-wehten-achtfach-getarnt-c85a4812337d@brauner>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=2808; i=brauner@kernel.org;
 h=from:subject:message-id; bh=OvoD0jfo0JSg6ilUPHm45pyrK53+/ioAkKf0HloE5Es=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt3sM7yfS587wjt7d1q186ZTLP59zt3WGTxCIq/J4+N
 v33896fzI5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJZF5lZHik3Dyb/Q7LzNc/
 0gt7Y9dbnXnz2KTCiz1Y4oT5yfvbnr9i+MPPJbHTnDs942BE00KHM3M+nON+MPvl27WXWZNbP67
 uncQFAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> kernfs_fop_readdir() takes kernfs_rwsem for reading and holds it for the
> whole listing, dir_emit() included.  dir_emit() copies into a userspace
> buffer, so it can fault, and under memory pressure that fault goes to
> reclaim.
> 
> We are hitting this case on the Meta fleet very regularly.  Many times it
> is below[1], a monitoring daemon.  It walks the cgroup tree and faults on
> its own getdents(2) buffer with the lock held for reading.
> 
> 	below: page allocation stall for 120 secs: order:0,
> 	mode:0x140dca(GFP_HIGHUSER_MOVABLE|__GFP_ZERO|__GFP_COMP)
> 	nodemask=(null),cpuset=hostcritical.slice,mems_allowed=0
> 	Call Trace:
> 	 <TASK>
> 	 dump_stack_lvl+0x5d/0x80
> 	 __alloc_frozen_pages_noprof+0x5f4d/0x6300
> 	 ? memcg_list_lru_alloc+0x73/0x320
> 	 ? ima_file_check+0xd0/0x7d0
> 	 vma_alloc_folio_noprof+0x145/0x560
> 	 handle_mm_fault+0x17c9/0x2720
> 	 ? find_vma+0x27/0x30
> 	 do_user_addr_fault+0x39f/0x6e0
> 	 exc_page_fault+0x8f/0x110
> 	 asm_exc_page_fault+0x22/0x30
> 	RIP: 0010:filldir64+0xd7/0x1a0
> 	[Code:/RSP:/RAX:..R15: register block elided]
> 	 kernfs_fop_readdir+0x2de/0x420
> 	 iterate_dir+0x8c/0x1f0
> 	 __se_sys_getdents64+0x61/0xe0
> 	 ? copy_page_from_iter+0x860/0x860
> 	 do_syscall_64+0x6a/0x250
> 	 entry_SYSCALL_64_after_hwframe+0x4b/0x53
> 	 </TASK>
> 
> kernfs_rwsem is the lock every create, remove and rename in the hierarchy
> needs, and sysfs and cgroupfs have one per machine.  More importantly, the
> userspace OOM killers such as systemd-oomd also traverse the cgroupfs
> hierarchy and can get stuck behind below, which is stuck in reclaim.  They
> are supposed to relieve memory pressure on the system, but can get stuck
> themselves.
> 
> The fix is to not hold the lock across dir_emit().  Copy the name while the
> lock is held, drop the lock, emit, and take it again.
> 
> That opens a window.  With the lock dropped, the entry the listing stopped
> on can be removed or renamed before the listing picks up again, and readdir
> only remembers its place as a name hash.  Two entries in one directory can
> share a hash, so the hash alone does not say where the listing stopped.
> 
> Patch 1 makes the fallback search land after the missing entry rather than
> on either side of it.  Patch 2 keeps the name of the entry the listing is
> on and resumes on the full key.  Patch 3 is the fix.  Patch 4 adds tests.
> 
> Patch 1 is worth having on its own.  Without the rest, the same search can
> land on the entry before the missing one and report it a second time,
> between two getdents(2) calls.
> 
> The series applies to the vfs-7.4.kernfs branch of the vfs tree.

Looks fine to me although it spaghettifies the code quite a bit.
I'll pull it but wait for Tejun to give it a nod.

-- 

