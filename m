Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C9C40D596;
	Sat, 20 Jun 2026 06:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781937858; cv=none; b=YFwUQSVCUFwpHyvcEekavARxIETWO55VGAlwndz7tZGd0zhjmS6WTdG1+Ofk1oH0motXRxP/TTQsZAf8ZZrqqygirJlR+mwxDVPolx0ofrr3aIC3Xcapc6wbU6VdwCQope9reirnu1RwksjkHl+jkKi8mDXDHtQukrBZBJmePVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781937858; c=relaxed/simple;
	bh=wQTYhhE8a9s7ndr0zQR9Epk9kAMxY7p/Caj9gijm3Ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mLslL/VOj3mgQXQ9Vh/HJbgbaQ5ebGqG55lPz2qt88w4Vz+iMXAwv7PkGe8Cn29LzcLjVyf48buFSTQ32QdM3FTKglXtoEfMksRUb0dVKdWHeO8rRfyTJJFD4w2WxzenKGf9VoV2tFc3tsKV+4pSZr03xaD+BcIhM0x3jc5fAhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=q8kXmyRl; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="q8kXmyRl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uB+WfniLsQwQod3pn/9E/Z+ouIvQUvMJYyoKsrz4oWI=; b=q8kXmyRlb8fem7Z99KUvzunE5e
	UMXqLJBFGfHTH5CASTagPxu6QNoJ95JqjgNxQkUr56ouInfgZxPRraMeKFA6wsMyinvUgdQJp1o7w
	uimYNsmYncQ2kaQEl9i7qBUJxhfa07VtNI8MisDBrGZSSHaI8YbvyEzhczK69HETTj2+8z9bFfyIu
	ybKV5RLCTTjF6/vH4Czbl50246tSeXNizuYNuOIC/msWQcz02s2goPZO7FgRXdTcjFCshS3DRP0by
	vkG4eo2rmPTL/e1lTiLsCZdEPlBe2ELEBTcvsXFrSQBp7nulnck8fsnB2aigb+fCk6zFFDkxhLwFR
	r3hz7rmQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1wapQy-00000000yds-14Ov;
	Sat, 20 Jun 2026 06:44:04 +0000
Date: Sat, 20 Jun 2026 07:44:04 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Jann Horn <jannh@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	syzbot <syzbot+000c800a02097aaa10ed@syzkaller.appspotmail.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	kernel list <linux-kernel@vger.kernel.org>,
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH V2] locking/rt: Fix the incorrect RCU protection in
 rt_spin_unlock()
Message-ID: <20260620064404.GE2636677@ZenIV>
References: <6a32d492.9a9be2da.cfe8.0001.GAE@google.com>
 <CAG48ez3-wQDwoQrOaKz3WTOU=n_cku0jcnxaC+wxBqdMHmiYMw@mail.gmail.com>
 <20260618205953.GZ2636677@ZenIV>
 <20260618210332.GA2636677@ZenIV>
 <87wlvvcwqt.ffs@fw13>
 <20260619083916.UMjUHmaq@linutronix.de>
 <87mrwqd7eu.ffs@fw13>
 <87jyrud75z.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jyrud75z.ffs@fw13>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Jun 19, 2026 at 02:52:08PM +0200, Thomas Gleixner wrote:
> rt_spin_unlock() releases the RCU protection before unlocking the
> lock. That opens the door for the following UAF scenario:
> 
>  T1					T2
>  spin_lock(&p->lock);		rcu_read_lock();
>  invalidate(p);			p = rcu_dereference(ptr);
>  rcu_assign_pointer(ptr, NULL);	if (!p) return;
>  spin_unlock(&p->lock);		spin_lock(&p->lock)
>  				   lock(&lock->lock);
> 				   rcu_read_lock();
>  kfree_rcu(p);			rcu_read_unlock();
> 				....
> 				spin_unlock(&p->lock)
> 				  rcu_read_unlock(); // Ends grace period
>  rcu_do_batch()
>    kfree(p);
> 			    UAF ->	  rt_mutex_cmpxchg_release(&lock->lock...)
> 
> Regular spinlocks keep preemption disabled accross the unlock operation,
> which provides full RCU protection, but the RT substitution fails to
> resemble that. Same applies for the rwlock substitution.
> 
> Move the rcu_read_unlock() invocation past the unlock operations to match
> the non-RT semantics. This makes it asymmetric vs. rt_xxx_lock(), but
> that's harmless as the caller needs to hold RCU read lock across the lock
> operation. The migrate_enable() call stays before the unlock operation
> because there is no per CPU operation in the unlock path which would
> require migration to be kept disabled.
> 
> Fixes: 0f383b6dc96e ("locking/spinlock: Provide RT variant")
> Reported-by: syzbot+000c800a02097aaa10ed@syzkaller.appspotmail.com
> Decoded-by: Jann Horn <jannh@google.com>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: stable@vger.kernel.org

Looks sane.

ACKed-by: Al Viro <viro@zeniv.linux.org.uk>

If RT folks see no subtle problems with that, it ought to go into mainline ASAP.
