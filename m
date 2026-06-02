Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CEE1F4180;
	Tue,  2 Jun 2026 00:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780361005; cv=none; b=Fdtri0DAGH4Sb5WGLpU06qN1M+fY4O8By34bHFugSXkkdxtebGBkameb5FJvU15J1V0aqbqLDzD/pD+jiPQsajAWWysslAM4AEvFBLXA2vr/F63lNCKZ8N5rLNLG8UE5WMLNV5ZGPFlc4ibNjIn9tdNuaBbl/v5kqXsv7XZHem0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780361005; c=relaxed/simple;
	bh=MG50YLQvQxNORvZuVFSBPMLKBdfywUTiNY7Fy69tyV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJzXnRS7ZvwiaSnUxu2ad1xWl4D0J+5miT0zVRtTC25nZfrTPafH2QD10WjhYbQMH1jqWGV1/mxrqmTb8Fejwvu+in/rh/tGlROJbtXsIVi+6CatYE2Xj9OWCDsaszoK9n0i9pNYGci5WFG5YwnmFuagwWbBSyDfqeZyhePf8Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=KasdYkQ/; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="KasdYkQ/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wJtIngZ1FRKANvUeb2PvORViMIM4aVCTFs+fJPSfFik=; b=KasdYkQ/Ll7ymQkucSGZ1ACIUw
	QwZPO1uYQHLL5yh1lUpZKFbk1j3ZedMkaeEvszDgoK/jpwQa9mkJnE2KHOAdVAsm2uxqPPXhVdFXX
	Fg2KtEIKJeLrhV0dP4kAlC3vlXb8UubGshz5dPsuSsWHnrVFmEPr1L2+307QGwCbIcY85WGWMHq6y
	DdxxFNOO+YJEjgsVmVSPQAbICnQSVlOvWOLY7RTXBgyDQeS7wPnyUusUY4P2xAYNJAStMXyBr8SXc
	fuCJLAwYinSXdtAk9L9hF3/18MpDPMgP900d5qO9sMexp6WVdUA3h0Sad6nkwQXQCgCGrByuLU1yR
	2KRLfWwA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wUDE0-000000055hw-1306;
	Tue, 02 Jun 2026 00:43:20 +0000
Date: Tue, 2 Jun 2026 01:43:20 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz, mjguzik@gmail.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+36e50496c8ac4bcde3f9@syzkaller.appspotmail.com
Subject: Re: [PATCH] fs/namei: fix UAF in pick_link() by unlazying before
 atime check
Message-ID: <20260602004320.GL2636677@ZenIV>
References: <20260602002607.110866-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602002607.110866-1-kartikey406@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Jun 02, 2026 at 05:56:07AM +0530, Deepanshu Kartikey wrote:
> In pick_link(), atime_needs_update() is called while the path walk
> may still be in RCU mode (LOOKUP_RCU set), meaning no reference is
> held on the inode. A concurrent iput() from another task can free
> the inode while atime_needs_update() reads inode->i_opflags (offset
> +2) inside current_time() -> is_mgtime(), causing a use-after-free.
> 
> KASAN reports:
>   BUG: KASAN: slab-use-after-free in is_mgtime include/linux/fs.h:2313
>   Read of size 2 at addr ffff8880407e4282 (offset +2 = i_opflags)
> 
> The race:
>   Task A (pick_link)             Task B (unlinkat)
>   ------------------             -----------------
>   atime_needs_update(inode)      iput(inode)
>     current_time(inode)            evict()
>       is_mgtime(inode)               destroy_inode()
>         inode->i_opflags  UAF          inode FREED
> 
> Fix: call try_to_unlazy() before atime_needs_update() so that
> a proper inode reference is held before any inode fields are read.
> If try_to_unlazy() detects the inode is already gone, it returns
> false and we exit safely with -ECHILD without touching freed memory.

NAK.  This is *not* fixing the real problem; it's papering over the
real breakage.  At a guess - in bpffs, if that's the same thing as
in https://lore.kernel.org/all/20260423043906.GN3518998@ZenIV/

Prompt freeing of inode is allowed *ONLY* if inode is never exposed
to lazy pathwalk.  It's OK for pipes, but this is not a pipe.
