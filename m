Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2CF19E968
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 12:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784724369; cv=none; b=lHyydZp6hLi/U50VlrlZcU5qSIvJpQDxG/nM+wiFik6J97MFNhcJMBgmSZIW4AeexzH4nQZrnvqLQhu/se6HOhwbhG8C4KdJJz/N9gHdyP6PB39AMa0zuBqsS04ocmzwFjMEtd9ui4Ws7J+T2mT+TlB211W+OkpXhhUrZL2vMvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784724369; c=relaxed/simple;
	bh=M7B7j5yuAA4mhkZAJTtRIJiDRUNIxOv728IpR0UE0U4=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=hwk4D58JpdznLsrIW2DAKrCkmRxdPhpo2bw3tWhWkOLC92/u+IPKCGtyzPSXuDfV33nXK/0wtlcoQhylSta71XzRjPKGdxa8w12W2PKLLBUZql3uAvQAwnVr4cxl8suCce1a+hOn38KiRvUd8ZLc6EzclD4zQZtzX+34/HxgbaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ixwEMtNV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ixwEMtNV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A49B81F00A3F;
	Wed, 22 Jul 2026 12:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784724366;
	bh=BSaGIVxLkHewLfe6L3ODPg+JjgKJt1jR2WpN5weT3S4=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=ixwEMtNVZAUW3h/oT+e8QveNw5iwjUEmmlY+fA4dETc1CJ/xi/j8EWsD0Bkn3kdUU
	 BQK9jLLerl6OtQ9Z1/4ODmVEQFSwp9L3W7zEcsmIoou/WJI3ZYPWxOSxaOKuEz6tPH
	 BFTwRFdHZRCyuhfySdAzRtCkXcU8PA1TszS2FtayWAk5lSm/9pqbnvp6QLqz0fVLxy
	 YEgVzoasGSXThyvuXF6y6Wn/qsSnJX9xJQFMD6+MsHAQCR0L6vuGbYzRcghWABsd/J
	 MjnE9Q2XF/NNTQpDtcTsqR5QWk1C7r3cby2OLXQTCUxVEK6OHZhat4wEZd8fBS+OZu
	 91EfEHJEF4RIw==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/4] VFS: enhance d_splice_alias() to handle in-lookup
 dentries
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org
In-Reply-To: <20260701233128.3356519-3-neilb@ownmail.net>
References: <20260701233128.3356519-1-neilb@ownmail.net>
 <20260701233128.3356519-3-neilb@ownmail.net>
Date: Wed, 22 Jul 2026 14:45:57 +0200
Message-Id: <20260722-erlauben-suchhunde-zwanzig-1b3d0c3a4cbc@brauner>
X-Mailer: b4 0.16-dev-9dec3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2775; i=brauner@kernel.org;
 h=from:subject:message-id; bh=M7B7j5yuAA4mhkZAJTtRIJiDRUNIxOv728IpR0UE0U4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQl7O6K3+z7ajpbnb/cLrHZj3zkAiau/uilzrzF0XxF8
 tqOe+1TO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbyWJThD38cp0Zf1scZttsL
 dVebXTRWOMEyOeCn1R1/romm/5LUzjAyTP+49/Jvky0PVvL0Cafs8f/Gyspc2HRt6/JA157fKbf
 PcAIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> We currently have three interfaces for attaching existing inodes to
> normal filesystems(*).
> - d_add() requires an unhashed or in-lookup dentry and doesn't handle
>   splicing in case a directory already has dentry
> - d_instantiate() requires a hashed dentry, and also doesn't handle
>   splicing.
> - d_splice_alias() requires unhashed or in-lookup and does handle
>   splicing, and can return an alternate dentry.
> 
> So there is no interface that supports both hashed and in-lookup, which
> is what ->atomic_open needs to deal with.
> 
> Some filesystems check for in-lookup in their atomic_open and if found,
> perform a ->lookup and can subsequently use d_instantiate() if the
> dentry is still negative.  Others d_drop() the dentry so they can use
> d_splice_alias().
> 
> This last will cause a problem for proposed changes to locking which
> require the dentry to remain hashed while an operation proceeds on it.
> 
> There is also no interface which splices a directory (which might
> already have a dentry) to a hashed dentry.  Filesystems which need to do
> this d_drop() first.
> 
> Some filesystemss (NFS) skip ->lookup processing for
>   LOOKUP_CREATE|LOOKUP_EXCL
> which includes mknod, link, symlink etc.  So these inode operations
> might get an unhashed or a hashed-negative dentry.  There is no
> interface for instantiating these so again they need to unhash
> first (nfs_link)
> 
> So with this patch d_splice_alias() can handle hashed, unhashed, or
> in-lookup dentries.  This makes it suitable for ->lookup, ->atomic_open,
> and ->mkdir as well as others.
> 
> As a side effect d_add() will also now handle hashed dentries, but
> I have plans to remove d_add() as there is no benefit having it as
> well as the others.
> 
> Once updated to handle nr_dentry_negative as is required for
> hashed dentrties, __d_add() contains code that is identical to
> __d_instantiate(), so the former is changed to call the later, and both
> d_add() and d_instantiate() now call __d_add().

d_instantiate() still calls __d_instantiate() directly. Stale sentence
from an earlier version?

> * There is also d_make_persistent() for filesystems which are
>   dcache-based and don't support mkdir, create etc, and
>   d_instantiate_new() for newly created inodes that are still locked.
> 
> Signed-off-by: NeilBrown <neil@brown.name>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

There was some discussion about this last year and Al objected to
widening d_splice_alias()/d_add() rather than adding *_hashed()
variants. That never reached a conclusion. I would mention that in the
commit message and why you ended up going with this variant rather than
the *_hashed() solution.

-- 

