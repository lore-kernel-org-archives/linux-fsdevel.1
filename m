Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA680500AAA;
	Mon, 19 Oct 2026 14:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792419739; cv=none; b=H4KqAZXj1DEEy2G++34eDLGISRkV/y9HjWUym3a/Ug4gOfO/vyU7HKlL8TG27xSZq30SvxaHWqCEB8n2oUmD/hZPu/klL+gi/LlGvKTlgSaki74CM7DMxwPYXzFTEMXOHUmf4/o7g6YZJ7ZIw8j3qJy5DwSlDRDaMdkuqbIFGz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792419739; c=relaxed/simple;
	bh=ZwAvw198f678gkAxZvg7kz0aZlumlowXYixpsNVn3zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N4UtFFxDF0kTRlh9+ce85BQULna3IDwaQau9RNQ3DErdlcH1pOW32zcTu5UUQxrCqCsJXM022QKjghoFl4hxYd5eyQ6lEApfg7RJaHx7KRfUuxYTA/P3K94MyrlclH292mXGcmNKBgRruY3NY7I9yHR7/3P8l10B30zjhb+Co8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=SUjEi2mY; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="SUjEi2mY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+y2BUKjwRoLgSpl4GuPppoIoV3Q38+BAmoFEcx3/mfw=; b=SUjEi2mYzAAcQW4n5bBtplmUVR
	6dMF7b1wrvvY3UKO3PeGWEwk99Mx33gy7gXsIz4wpRbFEIUzvMHcNLq3/MUT2mTUgfwf33dbYPG6/
	e08k+ydYQJiM41gs3QCv71o27AyC1Ss9YPrWbgAqjRa1XW/8xOnfBcRMYOxrfSNeaylhtzjIteMQs
	1517AHGfuBNVoYOejzhcFBrpOmvxLW/F44GeJcYlfo5xQh2dCJmE3MGEYSMzXKMbaClqMRtLCSY8x
	dDJI+9NgjIzqGfT+j7kHPN6uh0GzEwmbeCGyprVFaJHp0E9ONrJa3IbSWVjB4wBby+valiLqFfDVe
	wDOKQo4w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xIoFh-0000000CiSW-0T8b;
	Mon, 19 Oct 2026 14:22:13 +0000
Date: Mon, 19 Oct 2026 15:22:13 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+975ace299d6ba2eb1cea@syzkaller.appspotmail.com
Subject: Re: [PATCH] d_path: fall back to init_fs when called after exit_fs()
Message-ID: <20261019142213.GK989762@ZenIV>
References: <20261019132419.62905-1-ngocthang2710.1999@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019132419.62905-1-ngocthang2710.1999@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Oct 19, 2026 at 08:24:19PM +0700, Nguyen Ngoc Thang wrote:
> d_path() dereferences current->fs unconditionally. do_exit() runs
> exit_fs() before exit_task_work(), so a deferred __fput() sees
> current->fs == NULL. If that fput ends up in d_path(), it crashes:
> 
>   ima_file_free() -> ima_update_xattr() -> ima_calc_file_hash()
>     -> dentry_open() -> smack_file_open() -> smack_log()
>     -> common_lsm_audit() -> audit_log_d_path() -> d_path()
>     -> read_seqbegin(&current->fs->seq)
> 
> Any LSM or audit path that formats a path on open can hit this. Fall
> back to init_fs, whose root is always valid, when the task has no fs.
> 
> Reported-by: syzbot+975ace299d6ba2eb1cea@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=975ace299d6ba2eb1cea
> Fixes: 4a9d4b024a31 ("switch fput to task_work_add")
> Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
> ---
> Reproduced in QEMU (x86_64, KASAN, Smack+IMA+audit) with the syzbot C
> reproducer: without the patch the first exiting child hits a null-ptr-deref
> in d_path(); with it the reproducer runs to completion with no KASAN/Oops.
> 
> Alternatives considered: fixing only the IMA->Smack audit path (too narrow,
> any open-time LSM/audit hook can hit this), or reordering exit_fs() and
> exit_task_work() (too invasive). Happy to rework if you prefer another approach.

How about "don't use d_path() in places where current root is not well-defined"?

The reason why it tries to access current->fs is that it tries to produce
a pathname in caller's namespace, relative to whatever the caller happens to
be chrooted into.

Using that on final fput is insane - it might happen in context of completely
unexpected process.  So instead of papering over a symptom in d_path() itself,
the right approach would be to ask what do we expect from the data produced
by that call; "garbage string" is less obvious than an oops, but it's still
misleading.
