Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CA43446CA;
	Wed,  8 Apr 2026 19:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775676159; cv=none; b=StXjnyU/WXgA2YS6KTDhd+xGiQpdgnJPSy1zgZ+QTwoBFtBS/TH6GxfU4JEHqDUV93+YEZ82Ux62Wxqop1rDPzM4rIXFAUoPHx+CNU+HuJwwuCVtEca7ZTc341skgPzS9NDMYUHLt7ALev3kmpPxtt7pBMa9RCZ9mHTT2K6+3Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775676159; c=relaxed/simple;
	bh=yuLeBnryhDddh13mig2HurHDOIlJTGaePZc/aPlL3xY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bscMrxtbCWOZ45RGVhHBGCT4z02KCWrNGvOzhWPXy1ZWsUUNRfwrYj9JQuW/YC3fQqNkD2uoGSJLzL4gsTdi0Zfcidmzrmw83GYWeu6ZKJRQ+Sr7B3+jU2G/8cGnyj5S9W0lVSjZQ+UWtBfITnNIqMFUiNoPnJvU0gcl6zwi83g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=EUyzWY7O; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="EUyzWY7O"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=tgyy/giDhZ3dG3k1KECvaIqz9UFJzvbwSaa+17Vx+to=; b=EUyzWY7OqT3PoGTznQLgdgSrnB
	z52qBDj37CeUk9hNYDgo9sFlbqA3jlFoO1f5pHeCtfZrXFQUIoFMWdqrTiSYgw5r+WDE4j2MODvb3
	4vjuqNPoQBV4H+mKyMEUl8FHEnVc19R7gCmkO8us1HDET+imBe5S3/gCRd3jQ3H7dIAuhqZU7POtp
	XSfmj3g4eTzx0joaGMbHHOGWmlqN1lIHtRBpyElQ6/e8riq4aZJ5CWm4hppjbLYK1i83oCywyMz0I
	VkddE3AjZRMMVT8ept5T5IVzjdQTzU6yppT1znn23rtBV9O+A8X8kl57U5arREbnqoHcCahTb/XdU
	0v/wtIYQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wAYXc-00000000V3i-0ZQ4;
	Wed, 08 Apr 2026 19:26:20 +0000
Date: Wed, 8 Apr 2026 20:26:20 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	clm@meta.com, gustavold@meta.com
Subject: Re: [PATCH] dcache: warn when a dentry is freed with a non-empty
 ->d_lru
Message-ID: <20260408192620.GI3836593@ZenIV>
References: <20260406-dcache-warn-v1-1-c665efbc005f@kernel.org>
 <20260408064251.GE3836593@ZenIV>
 <f44d1047296ede580c69bdad8e527ac8294746ec.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f44d1047296ede580c69bdad8e527ac8294746ec.camel@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Apr 08, 2026 at 02:28:20PM -0400, Jeff Layton wrote:

> ...it turns out that Gustavo had been chasing this independently to me,
> and had Claude do a bit more analysis. I included it below, but here's
> a link that may be more readable. Any thoughts?

Other than rather uncharitable ones about the usefulness of the Turing Test,
you mean?

> **In production** (narrow race window): The livelock occasionally
> resolves through specific timing that allows a parent dentry to be
> freed and its slab page reused.

Livelock is real and known, all right, but do explain what does "resolves
through specific timing that allows a parent dentry to be freed" mean.
Especially since the reference to parent is *not* dropped until after
having child detached from the tree and DCACHE_DENTRY_KILLED on it,
with ->d_lock on child held over that.  So select_collect2() seeing
the victim still locked and attached to the tree has to happen before
the grace period for parent has a chance to begin.  And rcu_read_lock()
grabbed there prevents that grace period from completing until we
do the matching rcu_read_unlock() in shrink_dcache_parent().

> In `select_collect()` (the `d_walk` callback used by
> `shrink_dcache_parent`), two types of dentries are incorrectly counted
						     really?
> as "found":

> 1. **Dead dentries** (`d_lockref.count < 0`): Another CPU called
> `lockref_mark_dead()` in `__dentry_kill()` but hasn't yet called
> `dentry_unlist()` to remove the dentry from the parent's children list.
> With the debug delay, the dentry stays dead-but-visible for 5ms.

Yes.  And?  That's the livelock, all right, and it needs fixing,
but how does busy-wait here lead to UAF on anything?

> 2. **`DCACHE_SHRINK_LIST` dentries**: Already isolated by another
> shrinker path (e.g., the global LRU shrinker from `drop_caches`) to its
> own dispose list. These are being processed by that other path but
> slowly (5ms per proc dentry with the debug delay).
> 
> When `select_collect` counts these as `found++`,
> `shrink_dcache_parent()` sees `data.found > 0` and loops again. But
> these dentries can never be collected onto `data.dispose` (dead ones
> have count < 0, shrink-list ones already have `DCACHE_SHRINK_LIST`
> set), so the loop never makes progress → **infinite loop**.

They have no business going into data.dispose; for fuck sake, dentries
on somebody else's shrink list are explicitly fed to shrink_kill().

> **Why this is correct:**

It is not.

> - **Dead dentries (`count < 0`)**: These are being killed by another
> CPU's `__dentry_kill()`. That CPU will call `dentry_unlist()` to remove
> them from the parent's children list. `shrink_dcache_parent()` doesn't
> need to wait for them — they'll disappear from the tree on their own.

... and since they keep their parents busy, we should not leave until
they are gone.  For real fun, consider calls from shrink_dcache_for_umount() -
and yes, it *is* possible for another thread's shrink list to contain
dentries from filesystem being shut down.  Legitimately so.

> - **`DCACHE_SHRINK_LIST` dentries**: These are already on another
> shrinker's dispose list and will be processed by that path. Counting
> them as "found" forces `shrink_dcache_parent()` to wait for the other
> shrinker to finish, which can take arbitrarily long (especially with
> filesystem callbacks or the debug delay).

Ditto.

> - **The `select_collect2` path** (used when `data.found > 0` but
> `data.dispose` is empty) handles `DCACHE_SHRINK_LIST` dentries
> separately by setting `data->victim` and processing them directly. With
> this fix, `select_collect2` is only reached when there are genuinely
> unprocessable dentries (count > 0, not dead, not on shrink list), not
> when there are merely in-flight kills or concurrent shrinkers.

Bollocks, due to above.

> ### Relationship to the production UAF crash
> 
> The livelock is the **precursor** to the use-after-free crash seen in
> production (P2260313060):

... and it still offers zero explanation of the path from livelock to
UAF.  It may or may not be real, but there's nothing in all that verbiage
even suggesting what it might be.  And proposed analysis is flat-out
wrong.

As for the livelock, see viro/vfs.git #work.dcache-busy-wait (in -next
as of today).
