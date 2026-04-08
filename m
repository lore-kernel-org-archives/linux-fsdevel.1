Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48B135DA6F;
	Wed,  8 Apr 2026 23:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775689739; cv=none; b=eltR8jKAl3G8Lls7XDtL/35ny8tT/t3OdiBtrBb6HLHjDWN09hrN9Mc0vaneqSroUdAcwOrKJ81jrhVQfwKKDSV8CzTVxy244axvCGtrmYQtS8iWbUHUMiwhCmAJZPUbQSeFlRBrZfpCvY26StDmxY5rsyAjfSUaPoV94WVDemg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775689739; c=relaxed/simple;
	bh=4rN+0jbiHyKnDBBPmrhJLoMVPdIb2YFu8+QBJ+UAzac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V6r1cfxrm5dC5AbeMxRun9MrR9rRw2x8Vlk/pZ7IgwVP5how4e2gS1yUX1kJWR0jFhysT+9DVGxCKM4iPCFsCrkbXlwrh4bF+5LJHjMPZPo0hVp+9LdwLIqG4AlwIxDEtSuxN7Z6eeGBZNDTMEVtBzGtCXqQpdzatoMQLCpOJz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ciwQdBsk; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ciwQdBsk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jz7UUvDTIqTmGzKcp3CLsN040aVRpwQfcEDqrR95Wno=; b=ciwQdBskXzzWsJbKMotdk8ibpB
	RCZlJivaUileoYxjF/R3SgdWrzxZufWX94OgfUpUwb+RS4bbmPS2aChi1UdTexiSTuUV6pH313fr0
	n2xsenBB2EAS3WQI7vpc8LncQex80p2bFgeWOcfV3vEcs0TZZGqmZCln0dDMEqf44mUyh0JcTvTYy
	W4DIvoUz98LwguoE6/MfBNZfKSOGGsCW89HUGVPdSv4O/KXon0sBfjbGWpsuhp5sjAuR+swyVaOpN
	AsTeqgdNVaxBqsC3b6B0nBYvGIQIIAzKNvPUPkhDPBrE+mlg4+TwIq+Qg4mG9ErYAZ46hZyVBTE9N
	kNnIyA2g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wAc4e-000000012IQ-3Vj5;
	Wed, 08 Apr 2026 23:12:41 +0000
Date: Thu, 9 Apr 2026 00:12:40 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jianzhou Zhao <luckd0g@163.com>
Cc: linux-kernel@vger.kernel.org, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org
Subject: Re: KCSAN: data-race in __d_drop / retain_dentry
Message-ID: <20260408231240.GM3836593@ZenIV>
References: <49420d2.6c84.19cdbeb5e21.Coremail.luckd0g@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49420d2.6c84.19cdbeb5e21.Coremail.luckd0g@163.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Mar 11, 2026 at 04:02:41PM +0800, Jianzhou Zhao wrote:

> Execution Flow & Code Context
> When a dentry receives its final decrement during a path operation (e.g., inside `dput`), its lifecycle might traverse `__dentry_kill()` leading to `__d_drop()`. Here, VFS manually eradicates the dentry from the hash list by assigning `NULL` to the internal double-linked list pointer tracker `pprev`:
> ```c
> // fs/dcache.c
> void __d_drop(struct dentry *dentry)
> {
> 	if (!d_unhashed(dentry)) {
> 		___d_drop(dentry);
> 		...
> 		dentry->d_hash.pprev = NULL; // <-- Plain concurrent write
> 		write_seqcount_invalidate(&dentry->d_seq);
> 	}
> }
> ```
> 
> Simultaneously, another thread undergoing an optimistic lockless `dput`

Without having held the reference it's dropping?
