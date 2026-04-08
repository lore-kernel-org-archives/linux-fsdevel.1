Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A8B382295;
	Wed,  8 Apr 2026 23:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775691028; cv=none; b=LlRdAH6GuoxXJrjv7CYclZX2stRSnaOpBA/OSuTIQ4wFpZ9WwVstagiy5w2BNlc8MFEyN2pONnztvZ8bZiQRXQacfdKKzuHOSYubLdoBauiHeGr2F600FbP/1L5rD4TRY783kfQsg50GtqnMKPe1913A19N0Hvnstljp8H9zTNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775691028; c=relaxed/simple;
	bh=FjZF21yw/noE9LjmW6QenibkAUBtb3FYpWXqDF5kKk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iAqfVbBHvuOCyupkSh9KFdkHr4vKYDXF5ZjC2Maxky+qNGAk51MDLgDgS+p8uMcATOsegxVLcbhGRTXS1MqjDSyVS+PPyFGisjn2+sJLnRvyCAJaOGqEFrSu1i46DZ8PANlB3sn7EKl+kuDoQlKCCfqiM7MLaFFWudAQP3iOz4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=PIZBBRYc; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="PIZBBRYc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=j/S0audlNNQxFy9R9gIGO6AtnjAfawbig5OkYeWqxBo=; b=PIZBBRYceG2kCRoTalQTOvDSaE
	wqhgKkFW8UHtNzenc5MaX02aOr1PUXsJdl3jrEuN6uQbboDDosb6O31yQyl2paCSLadu9rl4jgnaH
	eMq4gGkOP4iUHuCwIe+G4Ka78D1i5GecKxlJqfg+nDhyO4m/eMuMB6bfCBl6gAEzPVZ/1aEy3QvF6
	OwPEbNgXfY9w1yklLJrmkKiQy7rg5CC82a6+ctuJhGfyBumIazcacG2NIEZiPbi3oyOB1WuAF+Byq
	//v6iskTTfcp5Se0u9dRl2jF6EtpK7yUBjRVi8bc66Jo+FCaR3MY0BYuPe3jxkgEIix8GL+su/UOz
	SxGqCqQA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wAcPS-000000016qI-0V3k;
	Wed, 08 Apr 2026 23:34:10 +0000
Date: Thu, 9 Apr 2026 00:34:10 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jianzhou Zhao <luckd0g@163.com>
Cc: linux-kernel@vger.kernel.org, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org
Subject: Re: KCSAN: data-race in __d_drop / retain_dentry
Message-ID: <20260408233410.GN3836593@ZenIV>
References: <49420d2.6c84.19cdbeb5e21.Coremail.luckd0g@163.com>
 <20260408231240.GM3836593@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408231240.GM3836593@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Apr 09, 2026 at 12:12:40AM +0100, Al Viro wrote:
> On Wed, Mar 11, 2026 at 04:02:41PM +0800, Jianzhou Zhao wrote:
> 
> > Execution Flow & Code Context
> > When a dentry receives its final decrement during a path operation (e.g., inside `dput`), its lifecycle might traverse `__dentry_kill()` leading to `__d_drop()`. Here, VFS manually eradicates the dentry from the hash list by assigning `NULL` to the internal double-linked list pointer tracker `pprev`:
> > ```c
> > // fs/dcache.c
> > void __d_drop(struct dentry *dentry)
> > {
> > 	if (!d_unhashed(dentry)) {
> > 		___d_drop(dentry);
> > 		...
> > 		dentry->d_hash.pprev = NULL; // <-- Plain concurrent write
> > 		write_seqcount_invalidate(&dentry->d_seq);
> > 	}
> > }
> > ```
> > 
> > Simultaneously, another thread undergoing an optimistic lockless `dput`
> 
> Without having held the reference it's dropping?

Note that if the sequence is
A:	fast_dput(): count 1->0
B:	grab reference, count 0->1
B:	drop, reference, count 1->0, grab ->d_lock and proceedi to __dentry_kill()
B:	in __dentry_kill() set count negative
B:	in __dentry_kill() clear ->d_hash.pprev
A:	call retain_dentry()
which is legitimate, not noticing d_unhashed() in retain_dentry() is fine -
fast_dput() will proceed to
	spin_lock(&dentry->d_lock);
	if (dentry->d_lockref.count || retain_dentry(dentry, true)) {
notice that ->d_lockref.count is negative and bugger off to
		spin_unlock(&dentry->d_lock);
		return true;
with rcu_read_lock() still held, same as it would if retain_dentry()
had returned true.

See the comments in fast_dput(), specifically
	/*
	 * Did somebody else grab a reference to it in the meantime, and
	 * we're no longer the last user after all? Alternatively, somebody
	 * else could have killed it and marked it dead. Either way, we
	 * don't need to do anything else.
	 */
