Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBDA39EF0B
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 18:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775845611; cv=none; b=u34wg4174zI5G/hB0uhhJygOjq3XHUiequLK0pzU9wtU6pQ/O48HZUA+yJFA9P5iUz3KquIdL0GazW4BSnuFp9pubkeS6Qm1dDr3qn9QSmL3WZaFjk+D02q7DLlhesGjzxQBjn3H2JNciQo6/QFKNzRmKsRZAzrf4WXW7MQ075U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775845611; c=relaxed/simple;
	bh=AKpKlrQkaO/5xjksveQqks9iDh0sQqNF7bqCug9KXac=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XHa9K9K24nVAMlxMN8dVD9etzpwipf0iVaOvfEiVv6239GGX3jIl+lRnBY5A4eY2u9nVJ1z4kLV1AhK9pHW/Y062K23X0Pd4mRJZNhjnKJX7Gg2qPYPfFNLpe6FA5BA4lrXXl1JEKNLy9s01+8n+vAI2727FNLwmYEIuTO0kGFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cr5z7fTk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cr5z7fTk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBBFDC19421;
	Fri, 10 Apr 2026 18:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775845611;
	bh=AKpKlrQkaO/5xjksveQqks9iDh0sQqNF7bqCug9KXac=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Cr5z7fTk9G4ZoTPOxQFYPgizBcVg5MKxt4EUF1FEY0VrPtM3egKkBPNZK0pPJoD2X
	 FfRPXxIc77DtkHsXe2OPq6/rB3bMBk9iPjIf/yRIco+TqE/j70/4x3P3m/iyHT+euS
	 khx7UMquSvTly61mEbRx3MVSKDi/kSAg7sn05vseN4KiNbwTLuv2BCHcvpOZVmDN9Z
	 cA2veBVyaLr62gRzaBA3CTEUQKswbpjLJfT3qpubI18vyx/x2JLjmDlSl6f3Z2RH0u
	 fhY1N9ZLoXSZ13M8NNxVgZPXQgYBHFbV8B0r5I2cAsjCX1XdsYrdqHu2q6NV46LdzT
	 eEO4lyEAb9Mng==
Message-ID: <7abf5ad83150dc51ac57e5b0c703ce9d2187dc94.camel@kernel.org>
Subject: Re: [RFC][PATCH] make sure that lock_for_kill() callers drop the
 locks in safe order
From: Jeff Layton <jlayton@kernel.org>
To: paulmck@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Frederic Weisbecker
 <frederic@kernel.org>,  Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel
 Fernandes <joelagnelf@nvidia.com>, Josh Triplett	 <josh@joshtriplett.org>,
 Boqun Feng <boqun@kernel.org>, Uladzislau Rezki	 <urezki@gmail.com>,
 linux-fsdevel@vger.kernel.org, Christian Brauner	 <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>, Nikolay Borisov	 <nik.borisov@suse.com>, Max
 Kellermann <max.kellermann@ionos.com>, Eric Sandeen	 <sandeen@redhat.com>,
 Paulo Alcantara <pc@manguebit.org>
Date: Fri, 10 Apr 2026 14:26:47 -0400
In-Reply-To: <99127a4f-30bc-477f-9a84-83fa771589cc@paulmck-laptop>
References: <20260122202025.GG3183987@ZenIV>
	 <20260404080751.2526990-1-viro@zeniv.linux.org.uk>
	 <53b4795292d1df2fe1569fc724325ab52fcab322.camel@kernel.org>
	 <20260409190213.GQ3836593@ZenIV>
	 <41cfd0f95b7fde411c0d59463dce979be89cb8ef.camel@kernel.org>
	 <20260409215733.GS3836593@ZenIV> <20260410084839.GA1310153@ZenIV>
	 <CAHk-=wjRgHLvSnEY3P45hSQ0ycKxdz-xqnccAMPuGRrwsvWdig@mail.gmail.com>
	 <99127a4f-30bc-477f-9a84-83fa771589cc@paulmck-laptop>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-04-10 at 10:32 -0700, Paul E. McKenney wrote:
> On Fri, Apr 10, 2026 at 08:25:27AM -0700, Linus Torvalds wrote:
> > [ Adding RCU maintainers to the participants: see
> >=20
> >   https://lore.kernel.org/all/20260410084839.GA1310153@ZenIV/
> >=20
> >  and the fairly long thread associated with it  for context ]
> >=20
> > On Fri, 10 Apr 2026 at 01:44, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >=20
> > > [this may or may not be the source of UAFs caught by Jeff and by Helg=
e]
> >=20
> > Hmm.
> >=20
> > I think this patch may indeed fix the problem, and I don't mind how it =
looks.
> >=20
> > But while I think the patch looks fine, I am still quite unhappy about
> > it if it matters - because we have very much documented that spinlocks
> > in themselves are also RCU read locks:
> >=20
> >         Note that anything that disables bottom halves, preemption,
> >         or interrupts also enters an RCU read-side critical section.
> >         Acquiring a spinlock also enters an RCU read-side critical
> >         sections, even for spinlocks that do not disable preemption,
> >         as is the case in kernels built with CONFIG_PREEMPT_RT=3Dy.
> >         Sleeplocks do *not* enter RCU read-side critical sections.
> >=20
> > so *if* this makes a difference, I think it's actually implying that
> > there's something wrong with our "rcu_read_unlock()" implementation,
> > and that it doesn't nest properly.
> >=20
> > Because our documentation also makes it very clear that this should
> > all work as-is, and your patch should be a complete no-op. Just a few
> > lines later in that core RCU doc, we have
> >=20
> >         Note that RCU read-side critical sections may be nested and/or
> >         overlapping.
> >=20
> > so the order of the spin_unlock() and the rcu_read_unlock() *should*
> > be entirely immaterial, and the order of unlocking simply shouldn't
> > matter.
> >=20
> > So it may indeed be that relying on the ordering of RCU read unlock
> > matters for the case of explicit unlocks and the implicit unlocks by a
> > spinlock, but that's not great.
> >=20
> > Does the rcu_read_unlock() code perhaps only check the RCU count, not
> > the atomicity count? That would explain it, and looking at
> > __rcu_read_unlock() in kernel/rcu/tree_plugin.h that may indeed be the
> > case (rcu_preempt_read_exit() seems to only check
> > rcu_read_lock_nesting).
> >=20
> > This is most likely dependent on kernel config options, and it may all
> > be unavoidable becasue RCU might not even have a way to tell that it's
> > still in a critical region without preemption counts etc.
> >=20
> > But if it's unavoidable, we need to update the docs about this gotcha,
> > and we need to have some tooling scan our existing code for this
> > documentation change.
> >=20
> > RCU people - what do you think?
>=20
> Adding to Boqun's email:
>=20
> The https://lore.kernel.org/all/20260410084839.GA1310153@ZenIV URL
> has preemption disabled (right, Jeff?)
>=20

Not as familiar with this part of the kernel, but I think that's
correct:

# zgrep PREEMPT /proc/config.gz=20
CONFIG_PREEMPT_NONE_BUILD=3Dy
CONFIG_ARCH_HAS_PREEMPT_LAZY=3Dy
CONFIG_PREEMPT_NONE=3Dy
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
# CONFIG_PREEMPT_LAZY is not set
# CONFIG_PREEMPT_RT is not set
# CONFIG_PREEMPT_DYNAMIC is not set
CONFIG_HAVE_PREEMPT_DYNAMIC=3Dy
CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=3Dy
CONFIG_PREEMPT_NOTIFIERS=3Dy
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set


> , in which case rcu_read_lock()
> is just preempt_disable() and rcu_read_unlock() is just preempt_enable().
> All the spinlocks also disable and enable preemption, so if you have
> something like this:
>=20
> 	rcu_read_lock();
> 	do_something();
> 	spin_lock(...);
> 	do_something_else();
> 	rcu_read_unlock();
> 	do_yet_another_thing();
> 	spin_unlock(...);
>=20
> Then there should not be any calls to schedule() between the initial
> rcu_read_lock() and the final spin_unlock().  But this is just
> preempt_disable() doing its job, not much to do with RCU.
>=20
> And repeating Boqun's email:
>=20
> Now if this is a preemptible kernel, things are more involved.
> However, in this case we know that the kernel has been built with
> CONFIG_PREEMPT_COUNT=3Dy.  So rcu_read_unlock_special() can sample
> preempt_count() and set preempt_bh_were_disabled is then true if either
> preemption or softirq are disabled.  Then irqs_were_disabled is set if
> interrupts were disabled on entry.  If either are set, the inner pair of
> "if" statements set up to defer the end of the read-side critical section=
.
> If this is important, which it might be, I will go through this in more
> detail later.
>=20
> Otherwise, the call to rcu_preempt_deferred_qs_irqrestore() at the end
> of rcu_read_unlock_special() immediately ends the RCU read-side critical
> section.
>=20
> And more adding to Boqun's email:
>=20
> Now, CONFIG_PREEMPT_RT=3Dy is a special case, because "spinlocks"
> are preemptible.  So __rt_spin_lock() and __rt_spin_trylock() both do
> rcu_read_lock() and rt_spin_unlock() does rcu_read_unlock().  So that
> should be covered via RCU nesting along with the rcu_read_unlock_special(=
)
> checks for disabled interrupts, softirq, and preemption.
>=20
> And rcutorture tests random overlapping of RCU readers with all those
> disabled regions.  But it might still be missing something.  And I
> will add spinlocks to the mix in addition to the preemption disabling.
>=20
> In the meantime, is there something more specific that I should be
> looking at?
>=20
> 						Thanx, Paul

--=20
Jeff Layton <jlayton@kernel.org>
