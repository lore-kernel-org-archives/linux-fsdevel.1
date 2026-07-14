Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E928148094D
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2026 15:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784042455; cv=none; b=RGbowkvn2W0iJzvpRc6Tm9J/P4AfIeRzseXX014/H0FnzuX3OW4OCTBxbGjPDzB4k05Fe4jVcgx6AmoRzjCmJEi/96H1HFB3fDQvyThDpbUEZsWI8vJsxEBXe9p6o19A+ijGxasPZsrpMR0+PmX9urqoLCgBehZQ38tcb7ud2v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784042455; c=relaxed/simple;
	bh=CGjtePubZwEoF3DUS7db0YE/3+7Mdilxlp9xAv5VU0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V5e5bHiSyV0daNfG4DhCMBg6G/3+jPjo6t0vt+cqKQ3O+muMkq01XtH6n/RxZyCWoya0Ya2wMeUENTiSpKfrDJ4tl5tHji03xpWD8JtlXje6d/HPuOE2w7B0D7GcQuterB95PTyG4ExhBWw8XSJ1hHIK2sj/2jNuFKd6JCG0wXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YEFDhpr4; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEFDhpr4"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4938d5f86f3so7709515e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2026 08:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784042452; x=1784647252; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+mQKsYh8DndYflXKAy2QOObtbfFjMIfC7B0OVrUjvj0=;
        b=YEFDhpr4X39+bYTS//W1Wdl8npZbZHp0OfJrizBQkIE/R4YL8yevU5WdaqZgxg0jsd
         3ah3BqEBOnPc1RmyK6MauxODVoltt7t7dK3Kv9TamEKGtYZnT9wje33jduTnkfJIywT9
         nYcN8PlVSXUh0mRloQzbKH561fKWuELlZXHm69AzM3lSwOSv5GKbQ1KSrxfsa7Y4za9x
         YDE1e9jPnY6/o3XBiI/dbUQ7SjfhIy8Ez/bpoZe3LvC1IHP4lhfO7u5evp3WHX+30pl8
         KTJQzW8FYnFzDQEEzIJBc3g9hteEcV5Nrd6vcqSYxf7ciONXSTfBxjfQNWGaXP7ILMD4
         aH7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784042452; x=1784647252;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+mQKsYh8DndYflXKAy2QOObtbfFjMIfC7B0OVrUjvj0=;
        b=eiPYcmDhIjknHf+GX6kMN8qYXuXuVHnuJtzTrMvrsXFd+qYOwf9vUrv6cJGyfaHd3N
         qsqmb4rHMdrl1wunw6eXoeEtspl1WFEuIGx563LncPMpcXhEa42FQF89IvJmXylHGwXZ
         ZD9hsUIgNCgQOkw8NRtcR9j8T5A7sEkP3//ug9XknPL3Yj2xgsAf7VNRwnoXZ+yRJG0S
         Me2Xd3ncSxwsKRgf3nNEDZAG38l6+BcYBi27VlX0AVoX7DI3zfm2E9Ch4rmYvagTrAMY
         FM8IzVIqjI7qbgWZTuD0DKMMgx+YqhDVguKPrLp2hezLyT0vK9YjufFmZkAA0qQnPcNo
         QEDw==
X-Forwarded-Encrypted: i=1; AHgh+RrAQD0GILKzFR2iQhEK4R0w8pFTbg7nIX2O33QBLqWSV2kobRMP4DCKVQ4MCeKV76p7SBn4Ccbv4qXDodVF@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2BQoq6MloaH7vhYD4ZQ/Xs86UE98g3KGROTcA5XOUw0Xvd2yk
	+zgGOWe50t97wAoNaBQwcsIi5bRtTMkRufrDiIoCwOpHDY4b5fDxteZ7
X-Gm-Gg: AfdE7cmb4WWLCdsPQlSKA+aZEeXvxloZpca1ZxAX8/oa5fu1hD9D1fJaMQGnY0owkuW
	ob7X5niPK6kxE6f7Dpvn8tXTuj3xLfKNWsQ97UwDo6rPtAT6NRXgPwtIapDA3L8DQ73ffJ0LtwK
	4R1hx0CpsT7wJKItaxZXU2ZwT+EYi1z2hQMduOX3xWCKKmJ8Q7YM2r14VD0G7uLosJxpkWckUzM
	UqGrDBCmflNqkqOrBkOq+52WgK3ZQ8F9/Tg2V04uCCJUm/tyGD/j8wccrwUHuHLryM/S45JlOJQ
	fjXgU5u3R7edIkG08FweSj4eeEIWc7lHXmbFelApamEJE4ymVv6Kewt4IUC7hGFQKnAafmDjHuo
	pXCdsrdhB0+uIu3yRL9AUCpsatcO8+DkUuoJ2gV4QX4GK9sZDoblO3w5vadTLybSBr2DOWakFMU
	vLVnnoQ6+YZvMsjzpRcJXA0WC+EZZX6ktuJhxSk87h4ZAXcDjQVHmFVrmNosNv
X-Received: by 2002:a05:600c:6749:b0:493:edde:54c8 with SMTP id 5b1f17b1804b1-493f8885b92mr149259215e9.8.1784042451835;
        Tue, 14 Jul 2026 08:20:51 -0700 (PDT)
Received: from f (cst-prg-85-255.cust.vodafone.cz. [46.135.85.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49508727f7dsm82869515e9.4.2026.07.14.08.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 08:20:51 -0700 (PDT)
Date: Tue, 14 Jul 2026 17:20:40 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Jing Wu <realwujing@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Qiliang Yuan <yuanql9@chinatelecom.cn>
Subject: Re: [PATCH] fs/inode: replace goto-again rescan with cursor in
 evict_inodes()
Message-ID: <u3n6oy7jdvog5hy4siidlzhdn2ho3b4juq67n3jftw7nukapsv@y64nbnkoo7me>
References: <20260714-feat-fs-evict-inodes-cursor-v1-1-64818f31020e@gmail.com>
 <zsvxjqazva2kom7lfdgp7ebzyq46eqzvivwbqkz4llazfqt4dr@a6ecq3b6fuz3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <zsvxjqazva2kom7lfdgp7ebzyq46eqzvivwbqkz4llazfqt4dr@a6ecq3b6fuz3>

On Tue, Jul 14, 2026 at 04:57:46PM +0200, Jan Kara wrote:
> On Tue 14-07-26 09:14:54, Jing Wu wrote:
> > evict_inodes() traverses sb->s_inodes to reclaim all zero-refcount
> > inodes at unmount time.  When the traversal yields to the scheduler
> > via cond_resched(), the current code jumps back to a "goto again"
> > label and restarts the list_for_each_entry loop from the head.
> > Inodes already marked I_FREEING are skipped cheaply, but the
> > repeated scans make the total work O(n * r) where r is the number
> > of reschedule events -- proportional to O(n^2) in the worst case on
> > systems with many inodes and memory pressure.
> > 
> > Replace the goto-again pattern with a sentinel cursor node embedded
> > in sb->s_inodes.  list_move() advances the cursor past each visited
> > inode in O(1).  Dropping and reacquiring s_inode_list_lock around
> > cond_resched() leaves the cursor in place, so the loop resumes from
> > exactly the current position rather than the list head, giving O(n)
> > total traversal.
> > 
> > Co-developed-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
> > Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
> > Signed-off-by: Jing Wu <realwujing@gmail.com>
> 
> Do you observe some real problems with the code in evict_inodes()? If yes,
> they should be mentioned in the changelog. Because we should in fact skip
> very little inodes on s_inodes list (most of them should be readily
> evictable) and thus your worry about quadratic behavior shouldn't apply.
> 
> Also your solution with the cursor has the problem that now everybody
> scanning s_inodes list has to be aware of the special cursor node. So your
> patch breaks these other places scanning s_inodes list and if you were to
> fix them, things would get ugly and complex quickly...
> 

I think the fact that inode list scan is open-coded everywhere is a
problem in its own right and needs to be abstracted away, regardless of
what happens with the above idea.

The sb list lock is already highly contented and *any* attempt at fixing
it will require all places doing the walk to get patched.

Apart from that the hand-rolled scan encourages holding the lock of the
duration, which is pretty terrible in its own right.

The restart from scratch thing is a known problem type and inserting a
marker to get around it is the idiomatic solution, albeit just like you
I do suspect in the case of evict_inodes() this is not a serious
concern.

iow, the thing to do is provide some iterator API. but in the spirit of
reducing continuous hold time it very much will want a solution to the
restart problem (for example with a marker), in turn addressing the
evict_inodes() worry.

I was looking at this few years back $elsewhere. I think a sensible
approach would slurp some inodes into an array and process them
unlocked, rinse & repeat.

Grabbing a bunch of inodes into an array could be also to reduce
contention during memory reclaim for example.

> 								Honza
> 
> > ---
> > evict_inodes() is called at unmount time to reclaim all zero-refcount
> > inodes on a superblock.  Its current implementation uses a "goto again"
> > pattern: after dropping s_inode_list_lock for cond_resched() and
> > dispose_list(), it restarts list_for_each_entry from the list head.
> > 
> > In the common case (clean unmount, all files closed) the goto loop
> > terminates quickly because dispose_list() removes evicted inodes before
> > the restart.  However, when many inodes have a positive refcount and
> > cannot be evicted -- as happens with a force-unmount while file
> > descriptors are still open -- the restarts scan O(n) skippable inodes
> > each time, making total work O(n * r) proportional to O(n^2) in the
> > worst case.
> > 
> > This series replaces the goto-again pattern with a sentinel cursor node
> > embedded in sb->s_inodes, allowing the traversal to resume from its
> > current position after each lock drop.
> > ---
> >  fs/inode.c | 24 +++++++++++++++++++++---
> >  1 file changed, 21 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/inode.c b/fs/inode.c
> > index acf206beb2e03..19197368c6a67 100644
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -880,15 +880,31 @@ static void dispose_list(struct list_head *head)
> >   * called by superblock shutdown after having SB_ACTIVE flag removed,
> >   * so any inode reaching zero refcount during or after that call will
> >   * be immediately evicted.
> > + *
> > + * Use a cursor node embedded in sb->s_inodes to resume traversal after
> > + * dropping s_inode_list_lock for cond_resched() + dispose_list().  This
> > + * avoids restarting the scan from the list head on each reschedule, giving
> > + * O(n) total traversal instead of O(n * r) where r is the reschedule count.
> >   */
> >  void evict_inodes(struct super_block *sb)
> >  {
> >  	struct inode *inode;
> >  	LIST_HEAD(dispose);
> > +	/*
> > +	 * Embed a cursor node directly in sb->s_inodes.  list_move() advances
> > +	 * it past each visited inode in O(1), so the loop resumes from exactly
> > +	 * the current position after lock drop rather than from the list head.
> > +	 */
> > +	struct list_head cursor;
> >  
> > -again:
> >  	spin_lock(&sb->s_inode_list_lock);
> > -	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
> > +	list_add(&cursor, &sb->s_inodes);
> > +
> > +	while (cursor.next != &sb->s_inodes) {
> > +		inode = list_entry(cursor.next, struct inode, i_sb_list);
> > +		/* Leave the cursor immediately after the current inode. */
> > +		list_move(&cursor, &inode->i_sb_list);
> > +
> >  		if (icount_read_once(inode))
> >  			continue;
> >  
> > @@ -916,9 +932,11 @@ void evict_inodes(struct super_block *sb)
> >  			spin_unlock(&sb->s_inode_list_lock);
> >  			cond_resched();
> >  			dispose_list(&dispose);
> > -			goto again;
> > +			spin_lock(&sb->s_inode_list_lock);
> >  		}
> >  	}
> > +
> > +	list_del(&cursor);
> >  	spin_unlock(&sb->s_inode_list_lock);
> >  
> >  	dispose_list(&dispose);
> > 
> > ---
> > base-commit: 502d801f0ab03e4f32f9a33d203154ce84887921
> > change-id: 20260713-feat-fs-evict-inodes-cursor-c23c9bd3c11f
> > 
> > Best regards,
> > -- 
> > Jing Wu <realwujing@gmail.com>
> > 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
