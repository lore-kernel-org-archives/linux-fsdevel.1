Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DEDC15C;
	Fri, 19 Jun 2026 08:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781858361; cv=none; b=q1Pi+Halnj2y+GN3lsKFlyRzTuwtUekqu6LqoOfjQzoZVCwjMmfmvvgtBwl7QijdzkDCX2dr6c3Crp7nhC0riZvyyc0FnNzpLxzZvRpA3w601D1s5Cpyx2WgOHSiJ85S+aAkazA9+DixRjJrgZvWGypBiMTyz0IbsOY4WejubHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781858361; c=relaxed/simple;
	bh=x7EI/UjImHdKsxqG2QFjriktvArYx80axvTbYkeOf14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NG4Ke0m2Rjf0oubRCXx7pZO37lHCiTUGIlFk43/yyHynX6bQ8M0uaBTBH9/2NaV1oKHna02L7qvSVsFD5KXUkhS5pqR5ulLKvRwuhcYkUG3ljqDZLxWJc6MrI4PdvoIvfRgKs/51aszqb+4cePUf1AflpxIhXGNZjRSAWgpBJHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wq9bwReo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5WrtpIoY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wq9bwReo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5WrtpIoY"
Date: Fri, 19 Jun 2026 10:39:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1781858358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=csQOwIMuYLw2yk07kDopWPdmh4vWyepkw1T9/O6N31k=;
	b=wq9bwReoaOUaJ1H72nAv8oiJa0kXz2qill5zFX+dBLUvZaSZP4n0lkLM/F8q3Xhzv4eenb
	kboUBZiUk8BoUwWX6ez3DfVn+CDXvFD2QNkzAl+Of5+gk5hVuLjXwruGG/Y5NWfocQoLlM
	wkj2t9pvXn6FmeZKTo8a4owuUwYAfO6uft6vPaemCmqtybQPQDyGGrllLTx7tzcNyHCVZ0
	EEyoZzSKoXOjyq4hR2D20C6laWrjz9ekGmKH0/1xiySmaeOWo8Lubx9tCOt6cvm6UeSqVj
	kOb0VqMdkQdc2KyRzbAhRxKmhOyHoOpYrADS3vAZ9yRrkpi4PEjH8md6EZB0nw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1781858358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=csQOwIMuYLw2yk07kDopWPdmh4vWyepkw1T9/O6N31k=;
	b=5WrtpIoYvU6JBCkGaT/QcRc0SgQ+UPGvgU9J+unxwm5raoQfXUBIVgDF/YTSaOh6Fkst4b
	DBFNg0zre5PZ2QBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jann Horn <jannh@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
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
Subject: Re: rt_spin_unlock order of operations [was: Re: [syzbot] [fs?]
 KASAN: slab-use-after-free Read in shrink_dcache_tree]
Message-ID: <20260619083916.UMjUHmaq@linutronix.de>
References: <6a32d492.9a9be2da.cfe8.0001.GAE@google.com>
 <CAG48ez3-wQDwoQrOaKz3WTOU=n_cku0jcnxaC+wxBqdMHmiYMw@mail.gmail.com>
 <20260618205953.GZ2636677@ZenIV>
 <20260618210332.GA2636677@ZenIV>
 <87wlvvcwqt.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87wlvvcwqt.ffs@fw13>

On 2026-06-19 00:24:58 [+0200], Thomas Gleixner wrote:
> Right. That's clearly a bug in rt_spin_unlock(). I think I wrote it that
> way for symmetry vs. lock(), which is obviously wrong.

and yet we had it since day one like that.

> Fix below.
>=20
> Thanks,
>=20
>         tglx
> ---
> Subject: locking/rt: Fix the incorrect RCU protection in rt_spin_unlock()
> From: Thomas Gleixner <tglx@kernel.org>
> Date: Thu, 18 Jun 2026 23:32:43 +0200
>=20
> rt_spin_unlock() releases the RCU protection before unlocking the
> lock. That opens the door for the following UAF scenario:
=E2=80=A6

would you mind folding the following? I don't see why the rwlocks should
be treated any different.

diff --git a/kernel/locking/spinlock_rt.c b/kernel/locking/spinlock_rt.c
index db1e11b45de67..4fb77daafd758 100644
--- a/kernel/locking/spinlock_rt.c
+++ b/kernel/locking/spinlock_rt.c
@@ -262,17 +262,21 @@ void __sched rt_read_unlock(rwlock_t *rwlock) __relea=
ses(RCU)
 {
 	rwlock_release(&rwlock->dep_map, _RET_IP_);
 	migrate_enable();
-	rcu_read_unlock();
 	rwbase_read_unlock(&rwlock->rwbase, TASK_RTLOCK_WAIT);
+
+	/* This must be last to prevent, see rt_spin_unlock() */
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL(rt_read_unlock);
=20
 void __sched rt_write_unlock(rwlock_t *rwlock) __releases(RCU)
 {
 	rwlock_release(&rwlock->dep_map, _RET_IP_);
-	rcu_read_unlock();
 	migrate_enable();
 	rwbase_write_unlock(&rwlock->rwbase);
+
+	/* This must be last to prevent, see rt_spin_unlock() */
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL(rt_write_unlock);
=20
