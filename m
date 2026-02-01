Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7832D3090D9;
	Sun,  1 Feb 2026 08:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769934333; cv=none; b=sanC3oFJnC1gWpU7XcjgWd2nC8shCFkugSi1uwVAUm8cf5DWAjBKcKdI4et0p8vZQWo34u0KmjQuRgoBzrCU2D/13prJa/UuCg3577nef5XZyp+wIv7C6yPBepCGogxGR6XtYCPqVL7WLo9YsZ2yVxmT3owKiFKGH+QL897mvhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769934333; c=relaxed/simple;
	bh=g0mRk5nsjkho3n2BdwDLmaO+JPaCiTP5TbzgLHtwyDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PmZvKjzRcMcxCmBqEyjLMg8aZFXRwciLPlSYwTahjK43aUf3FArGYDdscP/v6d9126V2C6ziS3zxn71mr9YAsOJD4EqV/+Iqkc2+70ZyNHxvtjXBdGi1ZFBNyOmWpn/yIe7h8qRfqATmFQPjGrsLNiypGPBgYEE91To7ei3crj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=KuscuzvX; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="KuscuzvX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yca2NFM/Fl/mLMY/zEhRTePYR8K8CiX81BDAtww5PGI=; b=KuscuzvXjJN7lS4e0ZyX/5xSUL
	cXy2fdx/dRcK8xExYuAaBEdFp4DYfqJSuS+vNfBfb7Ojh7f7K1Ed7QDQVE5rfMB6wmnBbSusYEdgQ
	HqsEV1LhlkwQX+g8AAHB1P05gsdCgr1iqwfjbHiaPuy2rUMJIXbnbiYDO/vhN269ug2OiMaOm9QbR
	6IF4KMC/pWbujdkF5f14dERoqlJh6cpwQMlz22OnrUYGjmCjweTJ59RlEJng8Miep0cgd+lSNqism
	ErA+jC6JbGC9Xtwb46q4o5txhztiAYlulmzpk3L13UUju2yNE8gyCSnTZgrbb0br11lpOi0h+OVCW
	AYsQ8AGw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vmSnk-00000003eYC-2LUx;
	Sun, 01 Feb 2026 08:27:24 +0000
Date: Sun, 1 Feb 2026 08:27:24 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Shardul Bankar <shardulsb08@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, janak@mpiricsoftware.com,
	slava@dubeyko.com, Shardul Bankar <shardul.b@mpiricsoftware.com>,
	syzbot+99f6ed51479b86ac4c41@syzkaller.appspotmail.com
Subject: Re: [PATCH] fs/super: fix s_fs_info leak when setup_bdev_super()
 fails
Message-ID: <20260201082724.GC3183987@ZenIV>
References: <20260201073226.3445853-1-shardul.b@mpiricsoftware.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260201073226.3445853-1-shardul.b@mpiricsoftware.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Feb 01, 2026 at 01:02:26PM +0530, Shardul Bankar wrote:

> In get_tree_bdev_flags(), sget_dev() calls sget_fc(), which transfers
> ownership of fc->s_fs_info to the new superblock (s->s_fs_info) and
> clears fc->s_fs_info. If setup_bdev_super() then fails, the superblock
> is torn down via deactivate_locked_super(). However,
> generic_shutdown_super() only calls the filesystem's ->put_super()
> when sb->s_root is non-NULL. Since setup_bdev_super() fails before
> fill_super() runs, sb->s_root is never set, so ->put_super() is never
> called and the allocated s_fs_info is leaked.
> 
> Return ownership of s_fs_info to fc when setup_bdev_super() fails so
> put_fs_context() can free it via the filesystem's ->free() callback.
> Clear s->s_fs_info to avoid a stale reference. Do this only when
> setup_bdev_super() fails; when fill_super() fails, it already frees
> s_fs_info in its own error path.

First of all, _what_ ->put_super()?  Forget ->s_root, ->s_op is
not going to be set there, so there's nowhere to get ->put_super()
from.  Relevant thing here is ->kill_sb().

Freeing ->s_fs_info is better done there anyway - makes for simpler
handling of foo_fill_super() failure exits, exactly because you don't
need to free the damn thing there - just let your ->kill_sb() deal with
it.

The thing is, there are ->kill_sb() instances that do just that and
I'm not at all sure they won't be broken by this patch.

Note that right now it's either "deactivate_locked_super() done, ->free()
is told to bugger off" or "->free() is called, deactivate_locked_super()
and ->kill_sb() isn't"; you are introducing a new situation here.
