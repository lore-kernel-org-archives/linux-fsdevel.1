Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320368;
	b=BmW/qJdLOpajh7qMw+qZUXwly0t4SvLrEciYRPnZjO6glYcgXUB4izSSWHucXjE0MCVt
	 mKC0VB8yS7Gawl8oVf7JTvMijvOFK3jeMN/VbYqASoq/6EqG+AahCPxPURxq7NR3gIOSl
	 P5QgPg8ggyTDDeG5ctuKdj0dV2c2ASNVdZCXrkvote6B33aoNF6CALK3j/WTPAL1nUrPn
	 UxyxN0eYvFy5Y/p6cX9ZdEEQjhgTCUjLfBwlCizhQObQkbvhNsYavqgMqBpa3Ozi8znN7
	 A3lc/2jEv6GFfy5MVsemWdmkFwQC14ZqT0cD9FsSNFG9JGJJ/gNmr4Ri4bH5wFa8B/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320368;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=rTBUIEs6ouEm6gFVWs5zgJQtIAZwsuHyVb8X2AjSH94=;
	b=NQQLrgYEYBH1X2KIEdBUsM0Zj0pzqQPgkezDf7WN3FWepMkn45YZqjZG0w2kF2xIAWSi
	 jNvscW+8rfzTFCqUoB4rN8jkJjKIP/sM0WKEtU6SZIMPgGbVIiI8s5vbvGiviWtxJV1F1
	 9KqWWeJNxnAiOYyLXuws7OBKAiYxj94jYilUVOuXkoeer1cIFcA4gOkXbGVEUTb5FErYm
	 oBzvkB1GhzkRUMAEoEDfOsbD4ANIBTzNI+zZIGehoo+Uj2qLdkaTf6pSmbIs3O3sDIvKW
	 GLMOpGMOEKQoNsJgPcaVKc/G7vXCLndS17rza+AOoTJIQw4Ne00bjI3e7AtJYJjCOcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WMe6IWuz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1CF606A321;
	Tue, 10 Nov 2026 14:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WMe6IWuz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F29C71F0089F;
	Tue, 10 Nov 2026 14:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794320367;
	bh=rTBUIEs6ouEm6gFVWs5zgJQtIAZwsuHyVb8X2AjSH94=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WMe6IWuz6RSl2oWDeCvTmq2AwMHnOUtZE3+45ZoasIZO5gRYR47j6+YK/Q+r2Qc71
	 Oynj7cycBSCuBdt8KkwX56cq+rCF8kX9Zzb5xI3P9bsXLaWOV4P8f3pHjQOtbS4Tg0
	 CGkKuCYIGAlPSmPbmEagI8zZZw1sBZh4bHwnptq2ZznUUFMBvdahE8aTUrqlIwhf/F
	 Ht3foWksmT8HKlJuImlG5f2peLz8nkfL2laxeybA+NE5dgHPVlHiGQ/NnbabozguCw
	 TT8uIeer0qrWFhEuotb+keRYw3Lv47vT4jSxpdsAUBOUXXhsDZENanCsrb8jGTDHRj
	 zMPaXkLyFY0oA==
Date: Tue, 10 Nov 2026 15:19:22 +0100
From: Christian Brauner <brauner@kernel.org>
To: =?utf-8?B?TcOpdmVu?= Car <meven29@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>, 
	=?utf-8?B?TcOpdmVu?= Car <meven@kde.org>
Subject: Re: [RFC PATCH v2 3/3] io_uring: set times inline when the
 filesystem cannot sleep
Message-ID: <20261110-winkt-kennung-geadelt-75390f787646@brauner>
References: <20261104110604.126717-1-meven29@gmail.com>
 <20261104110604.126717-4-meven29@gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261104110604.126717-4-meven29@gmail.com>

On Wed, Nov 04, 2026 at 12:06:04PM +0100, Méven Car wrote:
> From: Méven Car <meven@kde.org>
> 
> IORING_OP_UTIMENSAT always went to io-wq. On tmpfs the setattr only
> changes the inode in memory, so the handoff to a worker cost more than
> the work: 2000 files took 7 ms with utimensat(2) and 20 ms through the
> ring.
> 
> Try the request inline first. The lookup uses LOOKUP_CACHED, and the
> freeze protection and the inode lock are only tried, the former with
> the new mnt_want_write_trylock(). A filesystem whose ->setattr() never
> sleeps for a change of times alone says so with
> FS_SETATTR_TIMES_NOWAIT, which tmpfs sets. Any other filesystem, an
> uncached path, a contended lock or a delegation returns -EAGAIN, and
> io_uring sends the request to io-wq as before.
> 
> Signed-off-by: Méven Car <meven@kde.org>
> ---
>  fs/internal.h      |  5 ++++-
>  fs/namespace.c     | 20 ++++++++++++++++++++

We do not add a bunch of generic APIs in a io_uring patch.

What exactly is the the idea here? for tmpfs io-wq handoff costs three
times the setattr.

So it tries the request inline with LOOKUP_CACHED, inode_trylock(), a
new mnt_want_write_trylock(), no delegation breaking, and bails with
EAGAIN unless the filesystem type sets a new FS_SETATTR_TIMES_NOWAIT
fs_flags bit. Bah.. and then only tmpfs. ext4, xfs and btrfs can't
because ->setattr() starts a transaction.

The inline path still runs the whole notify_change()
security_inode_setattr(), fsnotify_change(), and
security_inode_post_setattr(). That's all blocking material.

Every request on a filesystem without the bit does a cached lookup with
d_weak_revalidate() and audit_inode() side effects, fails in __vfs_utimes(),
and then io-wq looks the path up again. Eew.

Not acceptable in this form and for sure not with all this new
machinery.
