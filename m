Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0FD3A1A2F;
	Mon, 11 May 2026 12:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778504307; cv=none; b=uOf5MLKuOn6I8aLGIdsB487k/fOU4JusuZGftvOWDGOgCe+7UIwo/t+06P2jwqyShxyLMZk858Z81+kryIY3bNCPgZCpZ8rt15MXEUm50bgZBWUY0nCyotrvsnsGp+AnEwFsmP4+VfeoZlZREG+2RlyKjH5SNbNoCqed467llTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778504307; c=relaxed/simple;
	bh=fwFb95290ulg+CMJzz9K2hBFFbB1I9j1/bUNxZTyhe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EfrIiD/WbwxadzhEDuwAiRRz/fISZ0BUaVuAB1xAZjDnS7It+dsPWJJZLdqapKJJider6foQbEjUw6XYu+DPOUCLpCfJOvkwLyBkNLnOT0uN97Gku30keNozAmEmyEnqQejxgma3nKkVKseFIRT3VgncDff42efqri9oS5WjEMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jy3jMpLd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jy3jMpLd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52CB7C2BCB0;
	Mon, 11 May 2026 12:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778504307;
	bh=fwFb95290ulg+CMJzz9K2hBFFbB1I9j1/bUNxZTyhe0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jy3jMpLdLEyk3DtaXdtbko+F15N3hzEoFxnDRATaqFo+pI0DKBCGZ8TFgAcu7X8mK
	 RV8G0Wr+rJi/NH1S+wCgjMYc6rLmKzWyNtY4SyDi4kpX2I2svY0RBDVzw4n8SfkPMH
	 YkjS+ozPZ10DYA8Qou9o+p3Sg3/sZ99K+gmq8iQ4gov5nEHbXN+RqpjpsgcwYetDBq
	 ZYNeWvmLaMkjYGFd6EWzTf0h1WFjLccnAoITr9OIBNacm1IimSRHbG6zChvrvOI/w7
	 UohCxSuuM7zwiXY+9IrqQFxijV5p4PpPN9pNrZigYdfy23De8rzqvmqXp61iZHIqE+
	 vvSow2H6ZmnMg==
Date: Mon, 11 May 2026 14:58:22 +0200
From: Christian Brauner <brauner@kernel.org>
To: Vineet Agarwal <agarwal.vineet2006@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jori Koolstra <jkoolstra@xs4all.nl>, 
	jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot <syzbot@syzkaller.appspotmail.com>
Subject: Re: [PATCH] fs/namespace: fix NULL pointer dereference in
 do_lock_mount()
Message-ID: <20260511-kommt-genug-c36a3c144bf4@brauner>
References: <20260505095156.178351-1-agarwal.vineet2006@gmail.com>
 <afn88B9Z5TM-0d0T@lt-jori.localdomain>
 <CA+rjy8fM+8ahj7dcBWjnACU8xBWBqW4ssQFpi68dqRc-F-V3Xg@mail.gmail.com>
 <20260506021230.GJ3518998@ZenIV>
 <20260506022152.GK3518998@ZenIV>
 <CA+rjy8fdpT7arFGcA3Z9ev41AtDxoLfhu3wYBv5VL=7bqUFUYw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+rjy8fdpT7arFGcA3Z9ev41AtDxoLfhu3wYBv5VL=7bqUFUYw@mail.gmail.com>

On Wed, May 06, 2026 at 10:07:29AM +0530, Vineet Agarwal wrote:
> Hi,
> 
> Thanks for the follow-up.
> 
> I don’t have a stable reproducer yet; the issue is triggered by syzkaller
> under fuzzing on a local build (7.1.0-rc1 with KASAN enabled).
> 
> However, I was able to capture consistent KASAN reports. The issue is not
> limited to a NULL dereference — I am also observing slab-use-after-free
> in do_lock_mount().
> 
> >From the reports, the accessed object belongs to mnt_cache, and is freed
> via mntput_no_expire_slowpath() from a concurrent umount path, while
> do_lock_mount() is still using the mount returned by where_to_mount().
> 
> The stack traces consistently follow this pattern:
> 
> do_lock_mount()
> → where_to_mount()
> → do_move_mount()
> → __do_sys_move_mount()
> 
> with the freeing happening via:
> 
> mntput_no_expire_slowpath()
> → path_umount()
> → __x64_sys_umount()
> 
> This seems consistent with a race between move_mount and umount, where
> the mount object returned by where_to_mount() is no longer valid after
> dropping mount_locked_reader.
> 
> I agree that my earlier explanation focusing on dentry state was not
> accurate. The issue appears to be related to mount lifetime rather than
> dentry revalidation.
> 
> Below is one of the stack traces:
> 
> ==================================================================
> BUG: KASAN: slab-use-after-free in topmost_overmount fs/mount.h:239 [inline]
> BUG: KASAN: slab-use-after-free in where_to_mount fs/namespace.c:2695
> [inline]
> BUG: KASAN: slab-use-after-free in where_to_mount fs/namespace.c:2688
> [inline]
> BUG: KASAN: slab-use-after-free in do_lock_mount.part.0+0xa1b/0xbf0
> fs/namespace.c:2756
> 
> Call Trace:
>  <TASK>
>  topmost_overmount fs/mount.h:239 [inline]
>  where_to_mount fs/namespace.c:2695 [inline]
>  where_to_mount fs/namespace.c:2688 [inline]
>  do_lock_mount.part.0+0xa1b/0xbf0 fs/namespace.c:2756
>  do_lock_mount fs/namespace.c:2751 [inline]
>  do_move_mount.isra.0+0x1ac/0xce0 fs/namespace.c:3645
>  vfs_move_mount fs/namespace.c:4561 [inline]
>  __do_sys_move_mount+0x62e/0x770 fs/namespace.c:4629
>  do_syscall_64+0xe0/0x5a0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>  </TASK>
> 
> Allocated by task:
>  alloc_vfsmnt fs/namespace.c:287
>  vfs_create_mount fs/namespace.c:1171
>  fc_mount fs/namespace.c:1191
>  do_new_mount fs/namespace.c:3840
>  path_mount fs/namespace.c:4160
>  __x64_sys_mount fs/namespace.c:4366
> 
> Freed by task:

Nothing in here makes sense imho and the details you provide are fuzzy
at best and I see a bunch of patches that got rejected already. The
stacktraces here look rather sketchy and I'm not sure 

This doesn't free anything. This just schedules task work and KASAN
would always show the actual release/free paths. So this looks forged or
tampered with.

Provide all the details. Unless it is of the same quality and clarify as
syzbot I'm inclined to call this hallucinated or based on some old
kernel.
