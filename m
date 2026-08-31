Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554B5361DB1;
	Mon, 31 Aug 2026 07:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788163190; cv=none; b=Bazd3ovCYG8DyTpO1k7R5GRa3/65WJXM5rhQw2s36knUk1G/SN67Pr2CwnTdwY8fc5ih+tSqHaFyjJlnMFkw7fb3s8Bi/IWLFN8eZfpZpKUHtJhMv/qbrDv8RhUGQsXpKcuSRQGNZBXA44DTKFskQMinZuOMfnHSu8VXCDlsyqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788163190; c=relaxed/simple;
	bh=M+ca4BbEDUhnXsj6pHU94ccRAgyMx7xJH05aCW3YEF4=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=uSVob3QVUQQAEzs/+dH/iw5Gk3SVMIQNfUK/BuvxGC9NaehKjmqHQmb+dSJh+Hy33J7G0SjNoED/mifLc5lkRKFB8o0VIejMqB9Q60GqeXiMXnoif2RxbuZlQte7+LLr4dqrl0kJXnOwyyrRxl2bHFKgXtSW1hv5sTPgoWtH640=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYAdygqq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYAdygqq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9017C1F00A3D;
	Mon, 31 Aug 2026 07:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788163188;
	bh=jYreoZcujyLJ/iMujgGPHYwEbZ3dcD0hmxyQImw9gVI=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=PYAdygqqE35pRqFDer53JiQg59D8pIDqRnH2rROKHcp1XYBetyy4tYYK57mmYED1E
	 Ex+Tyx1v+NR3hTMxAf4UdIQoFWpMW6bdsqW0iw5FPMDF/XnTdCNI5679WmC8g1CgYt
	 ZhX2wivYRUwFttzavn+tsYYctnOUzC9It5txC/H3dOBFA18Lkr1RMN+hEzgHKWc5bI
	 wCaRdGvVgCUyGnwidH6NJaPtJqcQ0rkNvCWKInJXLEBradGAyWF5jpeUkCl1vnP0tV
	 zcVxtuk0RfMWSJEAiCHiYlyS/SFdo7O9ugGqhrorDZW9vHq4u/IcrqKdzCGCb5eCGX
	 0wTMVbM0Zs8iA==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] fs: refuse to drop a dentry reference
 d_make_persistent() never took
From: Christian Brauner <brauner@kernel.org>
To: Narek Jilavyan <njilav@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260818125549.2315538-1-njilav@gmail.com>
References: <20260818125549.2315538-1-njilav@gmail.com>
Date: Mon, 31 Aug 2026 09:59:44 +0200
Message-Id: <20260831-fototermin-aufrichten-nahmen-bbced956ac99@brauner>
X-Mailer: b4 0.17-dev-362b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1977; i=brauner@kernel.org;
 h=from:subject:message-id; bh=M+ca4BbEDUhnXsj6pHU94ccRAgyMx7xJH05aCW3YEF4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRNNSn+edS06lj4ku55jw51PZm9MHx6ZOPDSz8CFXtvz
 ebkWylT0VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjAR/VSG/6GzNx7p28VkKsJw
 VeCYbvbUZ9aHH0/6tlewvzreVvj07DqGv6LF6196lM2vXOsUJyt/IiL77JZJyXYMPOvCL28MkhQ
 6yQUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> DCACHE_PERSISTENT records that d_make_persistent() took a reference on
> the dentry with dget_dlock(). d_make_discardable() announces that
> precondition but does not act on it:
> 
> 	spin_lock(&dentry->d_lock);
> 	WARN_ON(!(dentry->d_flags & DCACHE_PERSISTENT));
> 	dentry->d_flags &= ~DCACHE_PERSISTENT;
> 	dentry->d_lockref.count--;
> 	finish_dput(dentry);
> 
> so a caller that never made the dentry persistent still has a reference
> taken from it.  finish_dput() runs dentry_kill(), so the result is not a
> stale flag but a d_lockref underflow that can free a dentry another
> holder still references.
> 
> The same file already enforces the invariant rather than announcing it,
> in select_collect_umount():
> 
> 	if (dentry->d_flags & DCACHE_PERSISTENT) {
> 		dentry->d_flags &= ~DCACHE_PERSISTENT;
> 		dentry->d_lockref.count--;
> 	}
> 
> All seven in-tree callers are correctly paired (fs/libfs.c, fs/devpts,
> fs/autofs, fs/tracefs).  Both d_make_persistent() and
> d_make_discardable() are EXPORT_SYMBOL, so the contract is module-facing
> and currently unenforced.
> 
> Make the check act.  On a mismatch the failure mode becomes a leaked
> pinned dentry with a warning naming the caller, instead of a freed live
> one.  The early return unlocks explicitly, since finish_dput() - which
> normally releases d_lock - is no longer reached on that path.
> 
> Demonstrated with a late_initcall calling d_make_discardable() on a
> d_alloc_name() dentry, which by construction lacks DCACHE_PERSISTENT.
> Same kernel, only fs/dcache.c differs:
> 
> 	unpatched:  count before=2 after=1	(reference dropped)
> 	patched:    count before=2 after=2	(refcount untouched)
> 
> Both kernels emit the warning; only the patched one declines to act on
> it.
> 
> Fixes: bacdf1d70bbe ("primitives for maintaining persisitency")
> Signed-off-by: Narek Jilavyan <njilav@gmail.com>

I struggle to the see the point in this change.

-- 

