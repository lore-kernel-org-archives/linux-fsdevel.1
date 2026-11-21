Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795224074;
	b=TCz7CVAnOcHZ/cMO+deffhJXKknFD5RWLqzNCgB+u+adeplklIzWKouO40Z+M+RjKyjH
	 GkmSuxaJX4BSswnObN74XC7qUMKjuWP3LrQ1t27X8M5R1GB1HpshI9V0Lou9cKKiBkvPv
	 Hime3DP8s0nRXdqLNwYxWz2rTwtRt3AWEPmYX9TDillwKcC1fUazHuKAUt+CyMvpINRq/
	 tYHSBEJjewcTD0igqiNJd+Zy3Go4XzY5xtSLTJcF0Bj5nwgnDsb4ALJIjhCp/wEModf1r
	 iohauQsTIOB7aH88vvcunyP05D1Sfxd8DSDvpp4+OjQEncPwWE5JKNbc41uJJVGt2vQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795224074;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=wTNzI/VAp0bMLJS1RLjl54bNgqDF612eF3HnhqkWqT8=;
	b=PQz3f+hWTkrSuSkiPOWxr0R0wm2a1PZVxKz2SUpbbyc8lF4+0BYBpEjhJY8P4L+YYee9
	 zaLAcwvGG104jGQtAHs/hd7NRHcyB0PXU6J4WIJJ+ALRLcwkKZWDv8SrKuXZySUlYdILK
	 e26Z/WiQUqcjZGWGleRXRVuqmiMbMhpq1MHw/ynXkcn8mu4eOLPfTzYI6aw67LhwEAnDv
	 cxQ+Dxk8QiRZNtpZxEqw2twXZthumjWsYj6Aq33KKjirVzxKnRHH79XPzTW92fxsdtEb7
	 c+z0JYwJKPZzPUpUPPE1ZRRHp33cmEyojIOq1gK18/GITc2hbzDMciFqENcT5Le5hFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="l6/7aUbk";
	arc=none smtp.remote-ip=95.215.58.21
Received: from mta1.migadu.com (out-21.mta1.migadu.com [95.215.58.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42178606A6A3
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Nov 2026 01:21:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42178606A6A3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=l6/7aUbk
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=3KZnzfGWlw6YrVlMNRYr5zPamqEAkGD9Dw9g6hM3Tq8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795224067; v=1; x=1795828867;
 b=l6/7aUbkVyYWpU1ucndzkT7jxbYN4Dh90AI61SJYiky8/GOo7/syBGBcxq7q4Nalpwlieq4H
 RMWcp6AFCmXEExCqobm2UAQiV5+T2rHMixiYRxoQ/d48hc6qs0HBzsP+sJiay7kjjeInXBmVkff
 zeKv5ot8JwscThMqzN8hmGj4=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d846639e71118490;
	Sat, 21 Nov 2026 01:21:07 +0000
X-Mizu-Trace-ID: d846639e71118490
X-Migadu-Flow: FLOW_OUT
Date: Fri, 20 Nov 2026 17:21:02 -0800
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>, "T.J. Mercier" <tjmercier@google.com>, 
	driver-core@lists.linux.dev, Jori Koolstra <jkoolstra@xs4all.nl>, Ian Kent <raven@themaw.net>, 
	Meta kernel team <kernel-team@meta.com>, stable@vger.kernel.org
Subject: Re: [PATCH] kernfs: clear i_nlink before deactivating removed nodes
Message-ID: <awDxzdzSNy6xDkKI@linux.dev>
References: <20261120-work-kernfs-delete_self-v1-1-514a35d04431@kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120-work-kernfs-delete_self-v1-1-514a35d04431@kernel.org>

On Fri, Nov 20, 2026 at 09:59:59PM +0100, Christian Brauner wrote:
> __kernfs_remove() deactivates the whole subtree first and only clears
> i_nlink on a node's inodes later, once it unlinks the node from its
> parent. In between kernfs_dop_revalidate() already fails for the node,
> so a lookup that runs into one of its cached dentries kills the dentry
> while i_nlink is still 1. For a file of a cgroup that is being removed:
> 
>   rmdir("cg")                          stat("cg/cgroup.events")
>   css_clear_dir()
>     __kernfs_remove(cgroup.events)
>       deactivate the node
>                                        kernfs_dop_revalidate() == 0
>                                        d_invalidate()
>                                        dput()
>                                          dentry_unlink_inode()
>                                            i_nlink == 1, no IN_DELETE_SELF
>       kernfs_unlink_sibling()
>       kernfs_clear_inode_nlink()
>         i_nlink == 0, but the inode has no dentry left
> 
> The inotify watch keeps the inode alive, so nothing ever sends
> IN_DELETE_SELF for it and the watch only goes away once the watcher
> closes the inotify fd.
> 
> The window covers everything between the two loops in
> __kernfs_remove(). kernfs_drain() drops kernfs_rwsem and waits for the
> active references and open files of the node, and the clear itself
> waits for kernfs_iattr_rwsem behind every concurrent permission check
> and stat(). In a VM with a few threads stat()ing a cgroup and one of
> its files while the cgroup is removed, IN_DELETE_SELF for the watched
> file got lost in 16 to 33 out of 150 rmdirs, and it didn't show up even
> after dropping the dcache.
> 
> So clear i_nlink in the loop that marks the subtree as being removed,
> before a node turns inactive. kernfs_rwsem is held for writing there, so
> no new inode can show up for these nodes while the loop runs, and once
> a node is inactive kernfs_get_inode_locked() refuses to attach one. Two
> overlapping removals may clear the same inode twice, which is fine.
> 
> Fixes: eea5d2bb34ba ("kernfs: Send IN_DELETE_SELF and IN_IGNORED")
> Cc: stable@vger.kernel.org # v7.1+
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
