Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC212F8E81
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 May 2026 20:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778186345; cv=none; b=d7Qh8X52WbZ6JHMdgl4qoX1Fsz9un4GHiQWKZu816cAnfD+ncd6ZHFg/EAi5AqoH9hvMNAvbA3CkO4HzzV+bUaGUF+3i2UDvED/EeFRtJx0oCDxbsYI9g09C7G0r7dnz6Wmb5fFgMeCmuh4PoJhj4aj6tZkeMXpgfTaiF0A1wp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778186345; c=relaxed/simple;
	bh=Rvb9avwJjKVoJ3eHyjP1HI/ML2ogSioC+t9JryLQcRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uaxkzPppRPVJz08pTxG+hVc93xXNmukUcwPPlNfb1v8tj5zQKP/nr6KyB8MjYklgONMJOmy1NEnXSRe3eIq8UoXQwUjHse/ZR4rXuqiYg9xLBWJ/+22xdn38/vnpmmZcJ+eFZrmUXw8NQrkdUl7zVXR3FYdFJjGGBwXUrhJaxJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=snaOoi0I; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="snaOoi0I"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QGPFKcEGFjhIJrwg+tfMputPFsUXl5hVKDkUHxa67U0=; b=snaOoi0IJIbcF2THp+wOOl8J0P
	i0XLidMUWZMwzikC24fXVnp0eqpoDcnAuifHJk6FIa6M/VkMC8G6GfOUVauyS2JluCJT3s0YvzxKc
	DwDkBxu8BBBlzA/eNUSTxudFGEpr221ayCoN4lLs37PCNTq963m7eyxTXjfwUOZfCRe10Ln0AUd10
	Ivko50VWPPgRfKdhBzUetPiFWztwO8CqEXTvHfs5BK6XIhuaYCPzwfbezXIAWtR7puw+UtXaAhLk0
	5SiKB19hv02RlMWiWtqCWQF+xy8Mrg5WyzzzcXH3iNmoztQp92ciOw56nQpW/CnM0avuczZESLkLu
	doc7KWlQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wL5VE-00000006xER-1Y0F;
	Thu, 07 May 2026 20:39:24 +0000
Date: Thu, 7 May 2026 21:39:24 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>
Subject: Re: [RFC PATCH 09/25] shrink_dentry_list(): start with removing from
 shrink list
Message-ID: <20260507203924.GM3518998@ZenIV>
References: <20260505055412.1261144-1-viro@zeniv.linux.org.uk>
 <20260505055412.1261144-10-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505055412.1261144-10-viro@zeniv.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, May 05, 2026 at 06:53:56AM +0100, Al Viro wrote:

> diff --git a/fs/dcache.c b/fs/dcache.c
> index 34d57ed9d791..ee11171a75e6 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -1228,19 +1228,19 @@ void shrink_dentry_list(struct list_head *list)

> +		if (unlikely(dentry->d_flags & DCACHE_DENTRY_KILLED)) {
> +			dentry_free(dentry);
> +			spin_unlock(&dentry->d_lock);

In the opposite order, obviously.  It *is* safe in such form, but only
because NORCU dentries placed on shrink lists can't be evicted by
shrink_dentry_tree() (they won't be found by select_collect2()) or
by dput() (once on a shrink list, they have refcount zero and they
never get it incremented afterwards).  So this "if killed by another
thread, with the empty husk left on the shrink list to be disposed of"
can only happen for !NORCU ones, with actual freeing not happening
until we are done with spin_unlock().

But even though that braino does not result in a UAF, we obviously should
just unlock first.  Or, possibly, make dentry_free() called locked and
have it unlock the sucker as the first step...  That would mean
-       if (dentry->d_flags & DCACHE_SHRINK_LIST)
-               can_free = false;
-       spin_unlock(&dentry->d_lock);
-       if (likely(can_free))
+       if (unlikely(dentry->d_flags & DCACHE_SHRINK_LIST))
+               spin_unlock(&dentry->d_lock);
+       else
                dentry_free(dentry);
in dentry_kill(), and to hell with 'can_free' variable in there.
Not sure...

Anyway, for now I'm just fixing that braino; we can always revisit
the calling conventions for dentry_free() later.
