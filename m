Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442A438CFEF;
	Mon, 13 Apr 2026 22:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776117644; cv=none; b=r5vwbYkxK6Nx6CrgDZ6m82fN10+qXrvV+dqe7Bhs4dO5vbfpZVoRn0JA0bwRIYfmpxEMqasmlRFMOaTRic71nWLgPEp2I1Zx4Q2sUVMGoYxHv0BeANGniLnpILhuKtGhW+ahNwi3UY5lFZFIXseA8Dmuoqu4NoSuCQ92BEECW2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776117644; c=relaxed/simple;
	bh=+d5elElghJKOKPQGOlV3P5BiT4TgXBpZ6fBtl1v9+j8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l25Kc6j+YnOoLFwCKqKwhAt6URNau45GY1aX1tdCc69bqu8asa526bZ3Tswa1x8aYXdzkKQjhKOHQ00sTczLvhKCTgoSNYiwmYSo9j6Wm09YKW4jCXsn+TE7yAft9F5PO4ysPWgUS9Nfxb/L76NjxCS9nra/954+ACjD1YSOa7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=cU+nR2wC; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="cU+nR2wC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+xx0sRYVrbduhk04sImp2beyOtNvxalHH0K6TOAA1wM=; b=cU+nR2wCNa2YPDhpQ4ebJZCnDo
	lc/HIYTSOJANTOp0Gg1lsCMEwt4VZBGoK7N0QTMuRgpiq6frV5zIQiGZiFAXOessgStGzqwb8CFgn
	rqjVeGx44Hgv2aRqb+fVh5OdsOJr3Yzn3Po2a6pb9daAEdcz2LT81+9wPrllq1ceC7aBL0iIxt1mJ
	3rTa3+13m/8JeD36zYO/ONvUJthqywlwEmcpiGq/E74Ws0oAw6nocgMwTEH5xnC5ZsEzX7QZhcyeY
	h17BFNzB0sAIblMHylm4EJpWErzxFeSRSFUMcIZNa4UqIOH11M3l9j4rzqOY1Dj3k2K9OGM7XrrVs
	jMEq/vag==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wCPOT-0000000ElPE-3NBZ;
	Mon, 13 Apr 2026 22:04:34 +0000
Date: Mon, 13 Apr 2026 23:04:33 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] fuse update for 6.19
Message-ID: <20260413220433.GD3836593@ZenIV>
References: <CAHk-=wht097GMgEuH870PU4dMfBCinZ5_qvxpqK2Q9PP=QRdTA@mail.gmail.com>
 <20251206014242.GO1712166@ZenIV>
 <CAHk-=wg8KJbcPuoRBFmD9c42awaeb4anXsC4evEOj0_QVKg0QQ@mail.gmail.com>
 <20251206022826.GP1712166@ZenIV>
 <CAHk-=wgBU3MQniRBmbKi2yj0fRrWQjViViNvNJ6sqjEB-3r4XA@mail.gmail.com>
 <20251206035403.GR1712166@ZenIV>
 <20251206042242.GS1712166@ZenIV>
 <CAJfpegtsDZW7v=YDhs+gPq25G+QOh-5mjiaXT04DDW=iU+R75A@mail.gmail.com>
 <20260412061644.GA2485189@ZenIV>
 <20260413002940.GA2846532@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413002940.GA2846532@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Apr 13, 2026 at 01:29:41AM +0100, Al Viro wrote:

> As for the primitive itself...
> 
> /**
>  * __move_to_shrink_list - try to place a dentry into a shrink list
>  * @dentry:	dentry to try putting into shrink list
>  * @list:	the list to put @dentry into.
>  * Returns:	true @dentry had been placed into @list, false otherwise
>  *
>  * If @dentry is idle and not already include into a shrink list, move
>  * it into @list and return %true; otherwise do nothing and return %false.
>  *
>  * Caller must be holding @dentry->d_lock.  There must have been no calls of
>  * dentry_free(@dentry) prior to the beginning of the RCU read-side critical
>  * area in which __move_to_shrink_list(@dentry, @list) is called.
>  *
>  * @list should be thread-private and eventually emptied by passing it to
>  * shrink_dentry_list().
>  */
> bool __move_to_shrink_list(struct dentry *dentry, struct list_head *list)

Speaking of safety, it's probably worth adding
struct shrink_list {
	struct list_head __set;
};
and converting the lists used for that to that type.  That would affect

1) function arguments that are borrowed pointers to instances:
	* shrink_dentry_list() argument
	* __move_to_shrink_list() second argument
	* d_shrink_add() second argument
	* __umount_mnt() second argument
	* maybe_free_mountpoint() second argument
	* dput_to_list() second argument
	* d_lru_shrink_move() second argument
	* dentry_list_isolate() third argument/freeable (disguised closure,
          callback + argument passed via list_lru_shrink_walk())
	* dentry_list_isolate_shrink() third argument/freeable (ditto)

2) one global instance:
	* ex_mountpoints; implicitly acquired in the beginning of exclusive
scope of namespace_sem.  Contents moved into auto namespace_unlock():list
a bit before dropping namespace_sem or downgrading it to shared with.
No accesses to emptied object between the move and unlock/downgrade (the
only thing done in that range is checking if notify_list is empty in order
to decide whether to unlock or to downgrade to shared).  All accesses are
done by holders of namespace_sem (exclusive).  Verifying is...  interesting.

3) instances in auto variables - all start empty, all are emptied by
shrink_dentry_list() at the end of scope or nearby:
	* d_prune_aliases():dispose
	* prune_dcache_sb():dispose
	* shrink_dcache_sb():dispose
	* fuse_dentry_tree_work():dispose
	* mntput_no_expire_slowpath():list
	* namespace_unlock():list

On top of that, there's struct collect_data::dispose; the only instance
of struct collect_data is in shrink_dcache_tree(), passed (via a poor man's
closure) to select_collect()/select_umount()/select_collect2().
Emptying the instance is... interesting.  Normally that happens at the
end of scope; however, in case of select_collect2() stopping at the
dying dentry we ask to be notified when the victim stops twitching,
evict whatever we'd collected prior to that point, emptying the shrink list,
then wait for completion.  Inverting the order would lead to pointless
waiting, so shrink_dentry_list() here (and only here, AFAICS) really
shouldn't be reordered to the end of scope.

Operations:
	extraction of the first element (in shrink_dentry_list()).
	(implicitly) removal of element in d_shrink_del().
	element insertion in d_shrink_add().
	list fed to list_lru_isolate_move() as the third argument,
with element insertion done there.
	entire contents spliced to another set (in namespace_unlock()).
	emptiness checks (in shrink_dcache_tree(), some of those redundant,
also in select_collect(), select_collect2() and shrink_dentry_list()).

All of that does look like a good cause for an explicit type.  And
it looks like cleanup.h infrastructure might be of some use for
those, to make it easier to verify that we don't forget to empty
the suckers at the end...

PS: analysis of ex_mountpoints accesses:
	Users: unpin_mountpoint(), umount_mnt(), mnt_change_mountpoint(),
namespace_unlock().  Call trees:
	unpin_mountpoint()
	    __detach_mounts(), in scope of namespace_excl
	    attach_recursive_mnt()
	        graft_tree()
	            do_loopback(), in scope of LOCK_MOUNT
	            do_add_mount()
	                do_new_mount_fc(), in scope of LOCK_MOUNT
	                finish_automount(), in scope of LOCK_MOUNT_EXACT
	        do_move_mount(), in scope of LOCK_MOUNT_MAYBE_BENEATH
	    __unlock_mount()
	        unlock_mount()
	            termination of scope of LOCK_MOUNT{,_EXACT,_EXACT_COPY}
	        lock_mount_exact()
	            failure exit past grabbing namespace_sem exclusive
	umount_mnt()
	    umount_tree()
	        do_umount(), in scope of namespace_excl
	        __detach_mounts(), in scope of namespace_excl
	        copy_tree()
		    propagate_mnt()
			attach_recursive_mnt(), see above
	            __do_loopback()
	                do_loopback(), in scope of LOCK_MOUNT
	                get_detached_copy(), in scope of namespace_excl
	                create_new_namespace(), in scope of LOCK_MOUNT_EXACT_COPY
	            copy_mnt_ns(), in scope of namespace_excl
	        dissolve_on_fput(), in scope of namespace_excl
	        attach_recursive_mnt(), see above
	    __detach_mounts(), in scope of namespace_excl
	    attach_recursive_mnt(), see above
	    path_pivot_root(), in scope of LOCK_MOUNT
	mnt_change_mountpoint()
	    attach_recursive_mnt(), see above
	    reparent()
		propagate_umount()
		    umount_tree(), see above
	namespace_unlock()
	    termination of namespace_excl scope, some of those written
	    weirdly for various reasons.
Entering a LOCK_MOUNT... scope opens a namespace_excl one; leaving -
closes it.
	Overall, moderately unpleasant to verify manually; verifying on
compiler level...  Ouch.  Sure, we could invent an empty type for that
with namespace_excl scope declaring an instance of that type and then
pass it as a token around, but call chains are deep enough to make that
rather clumsy.  Some of that might be helped by the fact that instances
of struct pinned_mountpoint could be treated as bearing such token -
that reduces the call tree quite a bit (e.g. unpin_mountpoint() part
falls out, so does attach_recursive_mnt(), but e.g. mnt_change_mountpoint()
part still includes a bunch of chains like
	mnt_change_mountpoint() called by
	reparent(), which is called by
	propagate_umount(), which is called by
	umount_tree(), which is called by
	copy_tree(), which is called by
	propagate_mnt(), which is called by
	attach_recursive_mnt(), which does
have pinned_mountpoint.  Nothing deeper in that call chain has any use
of pinned_mountpoint in question, so we'd need to propagate the token
through all of that.  Unpleasant...  In any case, that's not going to
happen until the oddball namespace_excl scopes are untangled.
