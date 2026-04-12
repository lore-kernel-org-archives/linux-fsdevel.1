Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B000621257E
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Apr 2026 13:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775999760; cv=none; b=M685qbZySf46L8SsWJy+cz5Cx0SgakKUnMsAU5XvpTAlSjj0rnr6JvdZD9sE+hkn+xr8yD1zs7I9JM/YdFf3b0Y6ZzaxjbCJlEmTfPAEpygtOSLGJ4C7TAch3QCmK9IPn4EdpYpEk5ckyeAhhwTQ529smHKSM7Be6XuEnTlyeXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775999760; c=relaxed/simple;
	bh=tmZGN3DkNkJrxDZkEqenppuLHjwCsg2Wr81mtFU95sY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A85qMZSMa+ZXWScpfmgeBt+h66qirzumI9kRc6dDLziL0WBkIAo25S5FaRJeq6Ah0/v9xo1TMRLB42xlE04BnZMl/6RjTJXp/CXwoq6An/ia5C4YS4L2RWUitBiTAlEDioKY5kFHi52WcmrbO6xT/ZjyM9RRu8+IhMlEmFgKQ1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZcSN8bX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZcSN8bX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD512C19424;
	Sun, 12 Apr 2026 13:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775999760;
	bh=tmZGN3DkNkJrxDZkEqenppuLHjwCsg2Wr81mtFU95sY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=oZcSN8bXbzXnR3+3tW1ugrgKhe4rnccebqJjfEKeSdEMrUVU9ddDqTEXcgzbxsv4C
	 rEZrzEMMp/x8Ag6ENCqcpH52qyGFeJ4FWjStj9W2Yt2CL4UTDmWUUKzLhBoseKUEiW
	 XnWNtIJ64smT4otOivAS+zI4HwGMyfXDVrIkvNcVbRjNQ6I/aLpBPUOEfCwJK+u1Sf
	 oyd4pMejZVSxgo0OZmVOK+HSb+ZdN0qh+yHrZLeB0Vbvtf9xoAl+SWJrNY6ttW0ZnJ
	 lBKiOSK2hZG9vOJldSjzGbf22eoceEJ/NmPMfvDQnz28uu4oP/WjELbKRh6dIRz+yT
	 iBXwMCfyG3NDA==
Message-ID: <72698ebb266c70c36910d401d03f45ac0fc33fc0.camel@kernel.org>
Subject: Re: [RFC][PATCH] make sure that lock_for_kill() callers drop the
 locks in safe order
From: Jeff Layton <jlayton@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>, Linus Torvalds
	 <torvalds@linux-foundation.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Frederic Weisbecker	
 <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel
 Fernandes <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>,
 Boqun Feng <boqun@kernel.org>,  Uladzislau Rezki	 <urezki@gmail.com>,
 linux-fsdevel@vger.kernel.org, Christian Brauner	 <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>, Nikolay Borisov	 <nik.borisov@suse.com>, Max
 Kellermann <max.kellermann@ionos.com>, Eric Sandeen	 <sandeen@redhat.com>,
 Paulo Alcantara <pc@manguebit.org>
Date: Sun, 12 Apr 2026 09:15:56 -0400
In-Reply-To: <20260411213348.GB3836593@ZenIV>
References: <20260404080751.2526990-1-viro@zeniv.linux.org.uk>
	 <53b4795292d1df2fe1569fc724325ab52fcab322.camel@kernel.org>
	 <20260409190213.GQ3836593@ZenIV>
	 <41cfd0f95b7fde411c0d59463dce979be89cb8ef.camel@kernel.org>
	 <20260409215733.GS3836593@ZenIV> <20260410084839.GA1310153@ZenIV>
	 <CAHk-=wjRgHLvSnEY3P45hSQ0ycKxdz-xqnccAMPuGRrwsvWdig@mail.gmail.com>
	 <20260410185243.GU3836593@ZenIV>
	 <CAHk-=wiiJ4uO6C3U-B_SVuyjzQpNd3yMjWck8kJ7tZ4oPwhGWA@mail.gmail.com>
	 <20260410202404.GW3836593@ZenIV> <20260411213348.GB3836593@ZenIV>
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

On Sat, 2026-04-11 at 22:33 +0100, Al Viro wrote:
> On Fri, Apr 10, 2026 at 09:24:04PM +0100, Al Viro wrote:
> > On Fri, Apr 10, 2026 at 12:30:13PM -0700, Linus Torvalds wrote:
> >=20
> > > The reason it exists is because lock_for_kill() can drop d_lock(), bu=
t
> > > that's in the unlikely case that we cn't just immediately get the
> > > inode lock.
> > >=20
> > > So honestly, I think that rcu_read_lock() should be inside
> > > lock_for_kill(), rather than in the caller as a "just in case things
> > > go down".
> >=20
> > Yup, in the cascade of followups I've mentioned...
>=20
> FWIW, see #work.dcache-cleanups (on top of #work.dcache-busy-wait).  That=
's
> obviously next cycle fodder, and it needs review and testing (at the mome=
nt
> I've only build-tested that).
>=20
> Branch is in git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #=
work.dcache-cleanups
> individual patches in followups.
>=20
> I think the eviction machinery got easier to read, if nothing else, and
> rcu_read_lock() scopes are saner now.  OTOH, if we *do* have RCU bugs wrt
> overlapping scopes, we'll probably see a lot of UAF on that - rcu_read_lo=
ck()
> scopes got aggressively minimized...
>=20
> I've split the rcu_read_lock() massage into a series of small steps after
> getting confused while trying to do them at once; not sure if it needs
> to be carved up so much, but...
>=20
> Shortlog:
> Al Viro (11):
>       shrink_dentry_list(): start with removing from shrink list
>       fold lock_for_kill() into shrink_kill()
>       fold lock_for_kill() and __dentry_kill() into common helper
>       reducing rcu_read_lock() scopes in dput and friends, step 1
>       reducing rcu_read_lock() scopes in dput and friends, step 2
>       reducing rcu_read_lock() scopes in dput and friends, step 3
>       reducing rcu_read_lock() scopes in dput and friends, step 4
>       reducing rcu_read_lock() scopes in dput and friends, step 5
>       reducing rcu_read_lock() scopes in dput and friends, step 6
>       adjust calling conventions of lock_for_kill(), fold __dentry_kill()=
 into dentry_kill()
>       document dentry_kill()
>=20
> Diffstat:
>  fs/dcache.c | 214 ++++++++++++++++++++++++++++++++++++------------------=
------
>  1 file changed, 129 insertions(+), 85 deletions(-)
> 63 lines of comments added - outside of comments it's -20LoC...

FWIW, I ran fstests + the earlier reproducer on a v6.19-ish kernel
without any of your fixes, and with "slub_debug=3DP,dentry" on the kernel
command line. It also had the patch below. I got no warnings back:

--------------------------8<--------------------------

diff --git a/fs/Kconfig b/fs/Kconfig
index 0bfdaecaa877..f3a228cd14e8 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -9,6 +9,15 @@ menu "File systems"
 config DCACHE_WORD_ACCESS
        bool
=20
+config DCACHE_SHRINK_RACE_DEBUG
+	bool "Debug: inject delay in __dentry_kill to widen race window"
+	depends on DEBUG_KERNEL
+	default n
+	help
+	  Inject a probabilistic delay in __dentry_kill() between releasing
+	  d_lock and re-acquiring it, to make dcache shrink races reproducible
+	  in test environments. Only enable for testing.
+
 config VALIDATE_FS_PARSER
 	bool "Validate filesystem parameter description"
 	help
diff --git a/fs/dcache.c b/fs/dcache.c
index 66dd1bb830d1..b1625f7e30e1 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -32,6 +32,8 @@
 #include <linux/bit_spinlock.h>
 #include <linux/rculist_bl.h>
 #include <linux/list_lru.h>
+#include <linux/delay.h>
+#include <linux/random.h>
 #include "internal.h"
 #include "mount.h"
=20
@@ -675,6 +677,16 @@ static struct dentry *__dentry_kill(struct dentry *den=
try)
 		dentry->d_op->d_release(dentry);
=20
 	cond_resched();
+#ifdef CONFIG_DCACHE_SHRINK_RACE_DEBUG
+	/*
+	 * Probabilistic delay to widen the race window in __dentry_kill()
+	 * between dropping d_lock and re-acquiring it.  30% chance of 5ms
+	 * delay for proc dentries.
+	 */
+	if (dentry->d_sb->s_magic =3D=3D 0x9fa0 /* PROC_SUPER_MAGIC */ &&
+	    get_random_u32_below(100) < 30)
+		mdelay(5);
+#endif
 	/* now that it's negative, ->d_parent is stable */
 	if (!IS_ROOT(dentry)) {
 		parent =3D dentry->d_parent;
@@ -2722,6 +2734,9 @@ static wait_queue_head_t *__d_lookup_unhash(struct de=
ntry *dentry)
=20
 	lockdep_assert_held(&dentry->d_lock);
=20
+	if (WARN_ON(!(dentry->d_flags & DCACHE_PAR_LOOKUP)))
+		return NULL;
+
 	b =3D in_lookup_hash(dentry->d_parent, dentry->d_name.hash);
 	hlist_bl_lock(b);
 	dentry->d_flags &=3D ~DCACHE_PAR_LOOKUP;


