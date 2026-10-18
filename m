Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EF93FDBF8;
	Sun, 18 Oct 2026 04:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792297007; cv=none; b=KUMLQmMRRqY7qtdzQvX4a60aY0l7jKFvB8PiwHzyY7zUajOC1UKpxJuWjHJAZmevwIV9ho1pBrkQSBsnrXZXwxpGP8EP2ZptbibbvZfVwTlJHd6eIj014uxkoFs0sd2Jr0JggQFy2MZ9QzUiZLW1trAWmCUb1xTFYOr8ip3W9po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792297007; c=relaxed/simple;
	bh=UQrrULb4ZpLyFIWf975SWMctYziXR3GjZMah1W8mkJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RxijljZwq3Iy3VAO02PENkJT+f+tg2mDKFieb7JBWVlEkOYnsbqDMKodn0M+cA9mqJE4w4mpNPx/twf597nQUJwvNyAHcyBweBtUfqA2J/mfHnjeK4Udi6GmY9tiOy2i92U4eOxzJ/+olZ+EekXiCXnQBZxozr+bPzkbrA6dnVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=EbKpnwXV; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="EbKpnwXV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mN5PXOWMKTPRcum/zB4DCtaXkUpnBcjWfIvmWRFUA20=; b=EbKpnwXVlPCcY5Rxprf1reX8hQ
	0UadyXvnYyP6d2oHIjLtPd/Ylc+3gMvBoW/roD9VE1eyHmTNK+lr0L0YdAtlzwEgcXvrIWnvJjpU8
	lZwtSEqi1dTdP15j5wGWdE8RxUfW3qsWff0CP0bPKrhQRLKmynEQq0b4PjMSTmX9yUSA0N0sao1Pb
	rcLzzoED2CLu3RGkVpoFtEt4YJ4mIxpsEZlAPkyHCbOp/osETv7DgNhLVqwfewwh0cWdqDVB3vahr
	tjSsaUGzADjVC11ibGM2EypoE5qHF6T+N29rjyivaee+Qm1MxhIC3oGG5dazT3+Tiv0F/mIc5C6/t
	jT7PRNKA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xIIJy-00000004PvR-1llt;
	Sun, 18 Oct 2026 04:16:30 +0000
Date: Sun, 18 Oct 2026 05:16:30 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
	NeilBrown <neil@brown.name>, Alexander Larsson <alexl@redhat.com>,
	Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
	lkmm@lists.linux.dev
Subject: Re: [PATCH 4/9] fs: unmount without a grace period when nothing else
 holds the mounts
Message-ID: <20261018041630.GE3535232@ZenIV>
References: <20261012-work-mount-gp_on_demand-proposal-v1-0-43f60221a7d0@kernel.org>
 <20261012-work-mount-gp_on_demand-proposal-v1-4-43f60221a7d0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012-work-mount-gp_on_demand-proposal-v1-4-43f60221a7d0@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Oct 12, 2026 at 05:39:17PM +0200, Christian Brauner wrote:

>  fs/namespace.c | 92 +++++++++++++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 79 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 8c6673bd8c03..435e5f6db880 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -1489,10 +1489,12 @@ static void mntput_no_expire(struct mount *mnt)
>  		 * Since we don't do lock_mount_hash() here,
>  		 * ->mnt_ns can change under us.  However, if it's
>  		 * non-NULL, then there's a reference that won't
> -		 * be dropped until after an RCU delay done after
> -		 * turning ->mnt_ns NULL.  So if we observe it
> -		 * non-NULL under rcu_read_lock(), the reference
> -		 * we are dropping is not the final one.
> +		 * be dropped until after turning ->mnt_ns NULL and
> +		 * either an RCU delay or a look under mount_lock
> +		 * that found it to be the only one left, which it
> +		 * isn't while ours is counted (mntput_unheld()).

Umm....   something like "either an RCU delay or having mntput_unheld()
observe the refcount to be 1 in a mount_lock exclusive scope.  The latter
can't happen until the mnt_dec_count() below", perhaps?  Probably still
too convoluted...

I'm not trying to nitpick - the place _is_ subtle and we are pretty
much guaranteed to look at it quite a few times down the road...

So basically you are relying upon the following:
1) RCU references to mounts are only used inside RCU read-side
critical scopes that have
	* mount_lock sampled prior to having observed the mount
in a live state
	* __legitimize_mnt() with the sampled value of mount_lock
done to obtain a counting reference
2) there's an RCU delay between having been observed live and freeing.
3) ->mnt_parent of a something that had been live in an RCU scope will
point to something that had been live in the same RCU scope.
4) ->root.mnt and ->pwd.mnt observed under ->seq are live.
5) anything observed in mount hash under mount_lock is live.

Might work...  FWIW, I wonder (again) if we should replace the check for
mnt->mnt.mnt_flags & MNT_DOOMED in the slow path of mntput_no_expire()
with WARN_ON() - it really should never happen.
