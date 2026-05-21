Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499F436CDE0
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 16:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779381526; cv=none; b=dTvIMjT85goq6Fa25mD3NT3iAL31am6pi1gGpbSHShyMI35czdhMA4vl1l24sbiZcd/FL9lmK7JIf0yFfvbMZU7KeVowsQ8aZPDWvC08VovyY5LhpT+l1zOhQ2gjbVRAvcF8CzmQ9xuQ3DGst1FjzSynLkgwRgmyE5wdL4yTLTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779381526; c=relaxed/simple;
	bh=bgtYpgKoiVXgd4JB9rg3zMNlV2RJIC7SPS8IAZNuQrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DSN/2CC58LdE6listdPw/Tp50HyG+LREW/HTW27DxS8swfd2RTSXLIDWGdGP6YzPlg1BL0zo8WUp0gleHPJcc85XrnXM8YpdoWvVIxPOwfqCLTJ/emv8AyK6nwi6EzPXNkFczpiE8Zp5Ep5hheKAvEiLWXxKYKkohPbfGQdeB+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=oUnyAxDv; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="oUnyAxDv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8IJ/g91Gxs6l9ew5rNqWPFLFFpmrgzusabDjNoppXsk=; b=oUnyAxDvJmuQh8xNPDq1xSrWYe
	qrafm5AAmqVKJRhNLXZjOiCQGPag7lmceZWO9UH0XHRQBA0pP040s1ndljk260j1560cOZXFg9UaG
	GuSZtGww/y/yfemJQrNhrwg4Qa0zrQA11fS2zqmIR7+eEgPasX1tS4GF8NTUNrS2V+Rr6NXpEAPSB
	cu5ju0Vj+NTEAB8EbSlOA+Ycb+GeMq2LQAfx8m3cZHo/O1vXMPrlxOIlHAS9HTXtrBWzhbBVH1E/G
	TjJTZS4T23ZTlfKYMzh8mGpNk1t0wvekC+qmyChws2HlTsaSWpswPC8jzEd1Uo3x+mbjv0Lx7FwYS
	bLuxljvQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wQ6Px-0041C9-0P;
	Thu, 21 May 2026 16:38:41 +0000
Date: Thu, 21 May 2026 09:38:36 -0700
From: Breno Leitao <leitao@debian.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Andreas Hindborg <a.hindborg@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH 01/14] configfs_lookup(): don't leave ->s_dentry
 dangling on failure
Message-ID: <ag806q5ymiSXvIPU@gmail.com>
References: <20260519070633.2025485-1-viro@zeniv.linux.org.uk>
 <20260519070633.2025485-2-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519070633.2025485-2-viro@zeniv.linux.org.uk>
X-Debian-User: leitao

On Tue, May 19, 2026 at 08:06:20AM +0100, Al Viro wrote:
> Normally ->s_dentry is cleared when dentry it's pointing to becomes
> negative (on eviction, realistically).  However, that only happens
> if dentry gets to be positive in the first place; in case of inode
> allocation failure dentry never becomes positive, so ->d_iput()
> is not called at all.
> 
> We do part of what normally would've been done by configfs_d_iput()
> (dropping the reference to configfs_dirent) manually, but we do
> not clear ->s_dentry there.  Sloppy as it is, it does not matter in
> case of configfs_create_{dir,link}() - there configfs_dirent does
> not survive dropping the sole reference to it.
> 
> However, for configfs_lookup() it *does* survive, with a dangling
> pointer to soon to be freed dentry sitting it its ->s_dentry.
> 
> Subsequent getdents(2) in that directory will end up dereferencing
> that pointer in order to pick the inode number.  Use after free...
> 
> This is the minimal fix; the right approach is to set the linkage
> between dentry and configfs_dirent only after we know that we have
> an inode, but that takes more surgery and the bug had been there
> since 2006, so...
> 
> Fixes: 3d0f89bb1694 ("configfs: Add permission and ownership to configfs objects") # 2.6.16-rc3
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Reviewed-by: Breno Leitao <leitao@debian.org>
