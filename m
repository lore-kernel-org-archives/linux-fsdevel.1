Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EB43E1218;
	Fri, 31 Jul 2026 10:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785492103; cv=none; b=KDWstv/+e70y3Rpy0BIHk2t3DMKsHxcP249ya1QyxmqtvKBtOSUcZBDbD+9WMzB7Dz7vKUhwlLBAIpltoq4FdE+v5DPQq6kc5CJ8pIIsgD4Ruh9p/vOxZvlq2DNZy+RJmotJrxUXd/Sema0x4YaRBSFVvXcOrzmYRQFu6BAlRbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785492103; c=relaxed/simple;
	bh=j4Z5bZHK3AbKBGCmrPLk461iR8rA3+wWds80fCNxa6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/nJ7GLzbJneJDVCjhB3hALVA1I1rx90cgCXUHy0LBFfkx7MmXTBcH//2T6FUKdIRlJOtd7ZgZLdz1UUphCtSUOaZNKUcE/mXybxKxTXT9KZksnj6jFZj53/mv+AxLoapk+BSQ4i7A6KL2upLBBzxu5d3LBF/THvZflq9sttYZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T65Sjd3i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T65Sjd3i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2C571F000E9;
	Fri, 31 Jul 2026 10:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785492085;
	bh=PMBV15EvOK4h+01G0hNhepU1Ykhn7pxch6U/bjY64ew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=T65Sjd3i4ytuRtCW0OnzJI4cdNhxzFdscId9Lrbzydi4ZXTNfcBjg9xxtC75P6ZRK
	 qrlh2vttXIjrXZKWgUnXs6HnXtHlW7ptP+yxO9+nLqzL2NZRZR4MVPGAsV4oTLs6Rv
	 TGc7hSPLEN2bow4gjhAUR9QvIoYrj2XxrYuIyESkN498JEFHOPULsdBnEZaEJUZNzw
	 AvvcUZOnKVDejZb/DETGS3/MWBgbgKtdxiyqMgQFaUSEwl207CZEz2JccahaO4p9/2
	 JHTkMkT6Qe/XQ/5xhLtqwuokPdVsMQ87nTYABgtJvUnjOObJonqWEGz2CKftGRKbfJ
	 SImzni+Q4Ygyg==
Date: Fri, 31 Jul 2026 12:01:21 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: NeilBrown <neil@brown.name>, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] fs/namei.c: fix coding style in atomic_open() and
 lookup_open()
Message-ID: <20260731-hemdkragen-hubraum-matetee-0722a319cf25@brauner>
References: <20260731-work-lookup-fixes-v1-0-2412b85cf65c@kernel.org>
 <20260731-work-lookup-fixes-v1-3-2412b85cf65c@kernel.org>
 <1573100765.693247.1785489604226@kpc.webmail.kpnmail.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1573100765.693247.1785489604226@kpc.webmail.kpnmail.nl>

On Fri, Jul 31, 2026 at 11:20:04AM +0200, Jori Koolstra wrote:
> 
> > Op 31-07-2026 10:36 CEST schreef Christian Brauner <brauner@kernel.org>:
> > 
> >  
> > Commit 4886c80eef20 ("vfs: call audit_inode_child() in lookup_open() on
> > failure") indented a continuation line with spaces, left three
> > declarations without a following blank line and used a trailing */ on the
> > last line of a block comment.  Clean all of that up, no functional change.
> > 
> > Fixes: 4886c80eef20 ("vfs: call audit_inode_child() in lookup_open() on failure")
> > Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> > 
> 
> I know checkpatch complains about this, but since namei.c has a bit of its own
> style, I didn't pay too much attention to that. Do we adhere strictly to
> checkpatch style in VFS? Anyhow, I'll add new lines after declarations in the

We don't care about checkpatch per se but we do leave newlines after
declarations. I think that's just pretty standard all around afaict.
