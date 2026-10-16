Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D761B45D19D;
	Fri, 16 Oct 2026 20:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792182804; cv=none; b=O6Mbj6GXmw5Ra4lTFJdX1iJKD1q80V8UjW29aZSVjqX1jVYDR6bqIz6zRb1qdP8s4EbMXIBW1eqmOtmA5NDZ1hxlZ6Vbtv7HtdjHiy2dvFyj8SCg0iv8J+3qeCQylD4SoSDVUuESExmPKizFnByUBsaaTB+62Yr6yy0B2rB4GY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792182804; c=relaxed/simple;
	bh=GveWHQNcrE98xEYU3F09/299Dr14gvqgxK5L7yOizSU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=aaFtaL5zlauUIGVJ8DH1oJzM7aoFqhM9hsWe7MhupXw9QY3yRDo2kNTxWW/rgOhDRldB+acG/9QAa2SiP53CTL79YdzO9mqOoTyTFHOcJzuEXZ3VJi6xhFh3+NeDW8tKO/6XyDDQC9kFNlDp3EW0ZVqZyUhMlOdL0VOXVjKkX+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJ4uty9n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJ4uty9n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D28B1F000C4;
	Fri, 16 Oct 2026 20:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792182801;
	bh=3IAGNDbohml9XO7frvXtK7J5LHe8HfB+XCAuz93WmUo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KJ4uty9ncartxB5lLWU4nKtyYsF80W67RRHHJFwkQ3gJ/KHqxcb+YZHMScg1rDght
	 JM8Jkq09SMzS1CUmlwed4eOgANgcdzx/h27RMucovRDMmwO/UwwyuUvOxVTVAKnqWr
	 mWHkfoKJ07lOyLhQWbOA6IfcCD21/9KnH/RPBM0Pt9o0vRvG2JA6o5DNW7XyPCuZgx
	 QRl9I4z0C4HBHfY4ngE7Eaf3SXOqc+PEhr9uBLnAcq7P4+OGo3RZl4Ze+fPWaYSbkK
	 6GvbxJR1oFCipkM0SbNYW1+XClYYAygvhyhHWLUriRA0xkrw5VMYQAnxnOS6d1FA4q
	 NQUvGNgCbQPkw==
Date: Fri, 16 Oct 2026 10:33:20 -1000
Message-ID: <06b62af1faefaddcb9d5d09cbaf7a2ad@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christian Brauner <christian@brauner.io>,
	Meta kernel team <kernel-team@meta.com>, linux-fsdevel@vger.kernel.org,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kernfs: allocate inodes and dentry outside kernfs_rwsem
In-Reply-To: <20261016164345.31618-1-shakeel.butt@linux.dev>
References: <20261016164345.31618-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Hello, Shakeel.

On Fri, Oct 16, 2026 at 09:43:45AM -0700, Shakeel Butt wrote:
> Allocate the inode with the lock dropped.  kernfs_iget() first looks for
> an existing inode.  If there is none, it pins the node, drops the lock,
> allocates, takes the lock again, and adds the inode only if the node is
> still active.  So __kernfs_remove() still finds every inode it must
> clear i_nlink on, as commit dc1a0cc95737 ("kernfs: don't lose
> IN_DELETE_SELF when decoding a file handle") needs.

Would it be simpler to allocate the inode before taking kernfs_rwsem and
free it if it ends up unused, as 8b64f32fee95 ("kernfs: allocate the new
name outside kernfs_rwsem") and 5ad03af18434 ("kernfs: allocate the open
node outside the open file mutex") do? Then the lock doesn't have to be
dropped, and there's no need for the pin and the active recheck. The
unused cases (negative lookups, inactive nodes, nodes which already have
an inode) are exceptions, and an inode alloc and free isn't expensive.

The helper would then just run under kernfs_rwsem. Maybe
kernfs_get_inode_locked() would be a better name for it?

kernfs_fill_super() can preallocate the same way, which gets rid of the
last inode allocation under kernfs_rwsem. cgroup_may_write() allocates
the inode under cgroup_mutex and could allocate before grabbing the
mutex too.

> kernfs_get_parent_dentry() also held the lock across d_obtain_alias(),
> which allocates a dentry.  Hold it only around kernfs_iget(), as
> __kernfs_fh_to_dentry() already does.

This also adds the active test to ->get_parent. A parent which is being
removed and has no inode now gets -ESTALE instead of a new inode with
i_nlink 1, which closes the window dc1a0cc95737 ("kernfs: don't lose
IN_DELETE_SELF when decoding a file handle") left open. Can you mention
it in the description?

Thanks.

-- 
tejun
