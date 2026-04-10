Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C75B3DB65D
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 16:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775838452; cv=none; b=DFlES3W7q7Hb5uL0Se/GhpV2AWRqFUVOdKUvn9NuBlEVh7k8mPS8ZQWKmAYGZ70kTOAdgNr2YbDl2bMc6smGrljjXDqUZsi6Po13QxPd9ifJJulgeSTkio/cgiTicxLCISkPU94x9tGWZ5xFZ3HEEdleTO0j2Gg7D/YZhp2w8eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775838452; c=relaxed/simple;
	bh=JjS2XpaH7zKVIRvCbBJRYv8X0wiXq1CMXbeTOfVGWu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wce6IhLr9z+A1D+6wSsUtFzsxpRuLWZD5rxVdaE3HBwHfhNkn1EbvfguRczscLoH4GY2K02RvjOkV7yHRpsmy/oR0bfx2XRNwsaNW5dxmm73meONRm9c79KfBdhZHqelhRXXXAU/jeWsVVkPCCxPar//SqS7Ax4Py1lrPvRfRxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PC9W1KiF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PC9W1KiF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6695BC19424;
	Fri, 10 Apr 2026 16:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775838451;
	bh=JjS2XpaH7zKVIRvCbBJRYv8X0wiXq1CMXbeTOfVGWu4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PC9W1KiFB6qrJc8OXoTi6/2XrIIicwvQ9a1fczpPSQF+vzUgIHApaM+brwIdFBg+6
	 LAXWwsHXM8eTGZc2E9qNJoKx0ric36xYiFjCMIEUBr8nE/to28GD2yAYya2JEI3G0R
	 XK2Ufq5Fzke7bVLi1xmudeZvRcU76GlkC26EoQrBOtzAkw9PVlFRaV1kUDdb4LodAs
	 hg9yT+ExYo6uY3SvfjX2QAmJbkxeR9npulczf6N9gVCtVx9AaXVizqGWn/1jfBU6z1
	 uaQBOCtrtwCOS244jB86EQIU5ufn8VYyu9BnK2ggCZqdjJmNKx3iNTaLUKNvG/6WOF
	 3aW5f7SZKQH3A==
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfauth.phl.internal (Postfix) with ESMTP id 79F48F4007A;
	Fri, 10 Apr 2026 12:27:30 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Fri, 10 Apr 2026 12:27:30 -0400
X-ME-Sender: <xms:8iTZaaPMum-iEOZqQxI4CCFtZ8CKsghtZn6Y-hPIzGft3fbRIxyIxg>
    <xme:8iTZaZ4R4KLxqATeyuoUrbTsNWK-y9unECL4cpx74v9behEsoA7_8jhAzBBj2hXHZ
    Ou6gwsys1VFjhpxEaq-6kFjP83eIGY6OUtkaWKfCiz2QW5rOrZEb0I>
X-ME-Received: <xmr:8iTZaRl6kMlpkX9Cjq0H-M3CFicA-cZ0BHmjUWqOXH2wIoJImbdoa9sIF9EKqbUUlsVqdoxm1eR-VRBPoRLckQSCwDkPWNZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvleeklecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnheple
    euheethfdttdfgjedvjeeuhefhkeetveeuueeukeegteeigeeghedvffehhffhnecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdduieejtdelkeegjeduqddujeejkeehheehvddqsghoqhhunheppehkvghrnh
    gvlhdrohhrghesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedujedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepthhorhhvrghlughssehlihhnuhigqdhfohhunh
    gurghtihhonhdrohhrghdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidr
    ohhrghdruhhkpdhrtghpthhtohepphgruhhlmhgtkheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepfhhrvgguvghrihgtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvggv
    rhgrjhdruhhprgguhhihrgihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohgvlh
    grghhnvghlfhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepjhhoshhhsehjohhshhht
    rhhiphhlvghtthdrohhrghdprhgtphhtthhopehurhgviihkihesghhmrghilhdrtghomh
    dprhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:8iTZaZI8xIr7BvNn_OUADHZh39zNEH_s1EnJCptgEsKEBiP52-j8lw>
    <xmx:8iTZaZSYhpDqxYeWX5qxfZn8f8XGRY8kHSsTZUUEpxNgot7L5bFBIw>
    <xmx:8iTZaeutGMAki2CVXCPYIt-NCQReZ45W_CToA7GC0VAPFDD8o9hSCA>
    <xmx:8iTZaU_LSNhH5E_nm6Qh3BXUjKX3rRNP6edE6NTEhZ5wcF6EeN5DAg>
    <xmx:8iTZaXZjIY_6HstG89FGI6IuIxQpjZAG0w546zs3hpKIcaf1CkNQjF-3>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Apr 2026 12:27:29 -0400 (EDT)
Date: Fri, 10 Apr 2026 09:27:28 -0700
From: Boqun Feng <boqun@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	Eric Sandeen <sandeen@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>
Subject: Re: [RFC][PATCH] make sure that lock_for_kill() callers drop the
 locks in safe order
Message-ID: <adkk8FiLHnVx1Bup@tardis.local>
References: <20260122202025.GG3183987@ZenIV>
 <20260404080751.2526990-1-viro@zeniv.linux.org.uk>
 <53b4795292d1df2fe1569fc724325ab52fcab322.camel@kernel.org>
 <20260409190213.GQ3836593@ZenIV>
 <41cfd0f95b7fde411c0d59463dce979be89cb8ef.camel@kernel.org>
 <20260409215733.GS3836593@ZenIV>
 <20260410084839.GA1310153@ZenIV>
 <CAHk-=wjRgHLvSnEY3P45hSQ0ycKxdz-xqnccAMPuGRrwsvWdig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjRgHLvSnEY3P45hSQ0ycKxdz-xqnccAMPuGRrwsvWdig@mail.gmail.com>

On Fri, Apr 10, 2026 at 08:25:27AM -0700, Linus Torvalds wrote:
> [ Adding RCU maintainers to the participants: see
> 
>   https://lore.kernel.org/all/20260410084839.GA1310153@ZenIV/
> 
>  and the fairly long thread associated with it  for context ]
> 
> On Fri, 10 Apr 2026 at 01:44, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > [this may or may not be the source of UAFs caught by Jeff and by Helge]
> 
> Hmm.
> 
> I think this patch may indeed fix the problem, and I don't mind how it looks.
> 
> But while I think the patch looks fine, I am still quite unhappy about
> it if it matters - because we have very much documented that spinlocks
> in themselves are also RCU read locks:
> 
>         Note that anything that disables bottom halves, preemption,
>         or interrupts also enters an RCU read-side critical section.
>         Acquiring a spinlock also enters an RCU read-side critical
>         sections, even for spinlocks that do not disable preemption,
>         as is the case in kernels built with CONFIG_PREEMPT_RT=y.
>         Sleeplocks do *not* enter RCU read-side critical sections.
> 
> so *if* this makes a difference, I think it's actually implying that
> there's something wrong with our "rcu_read_unlock()" implementation,
> and that it doesn't nest properly.
> 
> Because our documentation also makes it very clear that this should
> all work as-is, and your patch should be a complete no-op. Just a few
> lines later in that core RCU doc, we have
> 
>         Note that RCU read-side critical sections may be nested and/or
>         overlapping.
> 
> so the order of the spin_unlock() and the rcu_read_unlock() *should*
> be entirely immaterial, and the order of unlocking simply shouldn't
> matter.
> 

I agree. So there could be a lock/RCU bug here ;-)

> So it may indeed be that relying on the ordering of RCU read unlock
> matters for the case of explicit unlocks and the implicit unlocks by a
> spinlock, but that's not great.
> 
> Does the rcu_read_unlock() code perhaps only check the RCU count, not
> the atomicity count? That would explain it, and looking at
> __rcu_read_unlock() in kernel/rcu/tree_plugin.h that may indeed be the
> case (rcu_preempt_read_exit() seems to only check
> rcu_read_lock_nesting).
> 

Notice in rcu_read_unlock_special(), atomicity/preemption count is
checked in two ways:

a) if it's called with preemption count being 0, then good a quiescent
  state will be reported to unblock the RCU grace period.

b) if it's called with preemption disabled, there are two cases:

  1. use_softirq is true and either we are in an hard irq or we need an
     expedited GP, RCU softirq will raised, but in it, rcu_core() will
     guard the rcu_preempt_deferred_qs() with preempt count checking.
  2. otherwise, RCU will just rely on __schedule() to call
     rcu_note_context_switch() to report a QS, hence the preempt count
     is also respected.

@Jeff, just want to confirm, this UAF can be reproduced without
PREEMPT_RT=y, right?

Regards,
Boqun

> This is most likely dependent on kernel config options, and it may all
> be unavoidable becasue RCU might not even have a way to tell that it's
> still in a critical region without preemption counts etc.
> 
> But if it's unavoidable, we need to update the docs about this gotcha,
> and we need to have some tooling scan our existing code for this
> documentation change.
> 
> RCU people - what do you think?
> 
>           Linus
