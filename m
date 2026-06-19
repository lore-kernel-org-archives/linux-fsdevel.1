Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764C5284693;
	Fri, 19 Jun 2026 12:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781873213; cv=none; b=IQ5F1XjxgKAHjxGCTFfmG/fHxfx5ZNdU3L/P3qG488lQ8GExfPNKa6F7wzy6T86Rlcfbr5Y1CjQZ4zybeI+p3ngj7TWlYsQBVpCrAohVrEXADA8zeWaqUseQyhDahFgFz9KW0A083SWn/V+JxjALip71TQpY8dy7f6hKHCFN+bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781873213; c=relaxed/simple;
	bh=ZdXAwpBtqN7os8r2hIuw0l9/KJaU/sE3pSEydsgDzGQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HxKz2VB4M9yWRN0AbLOqaJFcjizW0qM4ew1CrcsDWb1x7rdwL0Pdoh+PCHTTkvRXwNwLjQymCrqlSpjwlY3cpNohymIBa47Jbfzu/PfkzU9SSv7SDFoWajxd1IwRYN0KVWZ2iQZ5RgwMi7P4YbCOeKL8El+vU40JCy5qPoDrHWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHi7h/uK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHi7h/uK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 841F11F000E9;
	Fri, 19 Jun 2026 12:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781873212;
	bh=OvJ2fMvuTrnYzU+an61M0mr+dkXOs1vZJgrnfKVFoMU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=dHi7h/uK11Ms4ARbhx4kIA+SgprRrFIAf9dMufNflSpNZeXAO1RYXc6TxilmPvtTM
	 dNWVmvT7ki9G2pkOKfh/qTXSnKhW8EJsjSvppWAm7RvT34luxfzL/7bVzlpBf5Dkuy
	 fERqoBVnvWC0WW30PKXwQHLPrbgmAZdVTW9aUujwt4FH+4kYCg7aOP+wR5sNnbJLxs
	 RBtNq5MybFzhOPdhSnyMazAu2ffi92TogQwhaWukBfn34OcKSevN5jYrEe73QYUlXh
	 zWy0cJR5HBQCqot6b6x+Z3Gei6rgWNVltVz+kzG+efhHXQXzaAGXevOI8wdH3cwZyS
	 gUvfCdLWFbJcQ==
From: Thomas Gleixner <tglx@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jann Horn <jannh@google.com>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will
 Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>, Waiman Long
 <longman@redhat.com>, Clark Williams <clrkwllms@kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>, syzbot
 <syzbot+000c800a02097aaa10ed@syzkaller.appspotmail.com>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel
 <linux-fsdevel@vger.kernel.org>, kernel list
 <linux-kernel@vger.kernel.org>, syzkaller-bugs
 <syzkaller-bugs@googlegroups.com>, Jeff Layton <jlayton@kernel.org>
Subject: Re: rt_spin_unlock order of operations [was: Re: [syzbot] [fs?]
 KASAN: slab-use-after-free Read in shrink_dcache_tree]
In-Reply-To: <20260619083916.UMjUHmaq@linutronix.de>
References: <6a32d492.9a9be2da.cfe8.0001.GAE@google.com>
 <CAG48ez3-wQDwoQrOaKz3WTOU=n_cku0jcnxaC+wxBqdMHmiYMw@mail.gmail.com>
 <20260618205953.GZ2636677@ZenIV> <20260618210332.GA2636677@ZenIV>
 <87wlvvcwqt.ffs@fw13> <20260619083916.UMjUHmaq@linutronix.de>
Date: Fri, 19 Jun 2026 14:46:49 +0200
Message-ID: <87mrwqd7eu.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Jun 19 2026 at 10:39, Sebastian Andrzej Siewior wrote:
> On 2026-06-19 00:24:58 [+0200], Thomas Gleixner wrote:
>
> would you mind folding the following? I don't see why the rwlocks should
> be treated any different.

Duh. I wanted to look at it but my brain only works partially in this
heat ...

> diff --git a/kernel/locking/spinlock_rt.c b/kernel/locking/spinlock_rt.c
> index db1e11b45de67..4fb77daafd758 100644
> --- a/kernel/locking/spinlock_rt.c
> +++ b/kernel/locking/spinlock_rt.c
> @@ -262,17 +262,21 @@ void __sched rt_read_unlock(rwlock_t *rwlock) __releases(RCU)
>  {
>  	rwlock_release(&rwlock->dep_map, _RET_IP_);
>  	migrate_enable();
> -	rcu_read_unlock();
>  	rwbase_read_unlock(&rwlock->rwbase, TASK_RTLOCK_WAIT);
> +
> +	/* This must be last to prevent, see rt_spin_unlock() */
> +	rcu_read_unlock();
>  }
>  EXPORT_SYMBOL(rt_read_unlock);
>  
>  void __sched rt_write_unlock(rwlock_t *rwlock) __releases(RCU)
>  {
>  	rwlock_release(&rwlock->dep_map, _RET_IP_);
> -	rcu_read_unlock();
>  	migrate_enable();
>  	rwbase_write_unlock(&rwlock->rwbase);
> +
> +	/* This must be last to prevent, see rt_spin_unlock() */
> +	rcu_read_unlock();
>  }
>  EXPORT_SYMBOL(rt_write_unlock);
>  
