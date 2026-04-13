Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DB6223DEA
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 15:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776094347; cv=pass; b=qNSkp94hNBrxZpQuf0RLofoiY5LFefKuwuLC/sjiwOxdOhm6Gy65uDsQIHCXJv/ZAwqZgkSwrGYZ25UJ385Ju3A3afd15Jmf7rziEGMJZSwzbaKqEyOE0Zr9pD1Zp46ZJEo6OxghfAlnWurdaBGpEUjs2u+tJDcb6v6lxmgJMjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776094347; c=relaxed/simple;
	bh=S3cktOSrEspHqsBshovzjsQ5pdFnwpCjvTaL+Wnyt8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f1LFzh0OX/+1A4iUCcFP+P2CG+v/m5T/YbiDHfoLyPIbUXJFGD0kJEPlLVR7+iSjWlHuhM2kfEsqbJ/5LGIgEvCipxc8jYtdikoovwnO9MHUCvO8ubQPM0KEPKV8R2hrGqo9RJTjOlTJzyhHdSeW25uXKNVvLcu4u9eNsQrbVYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=dBaUKYtb; arc=pass smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="dBaUKYtb"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-68a3b605bdcso2299731eaf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 08:32:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776094345; cv=none;
        d=google.com; s=arc-20240605;
        b=Ben6c+9zb7sBNkVLN4UQzEMpbPI0xE0UP05NF7WZlOT3U+26O6UU9H4tvU9iYYKq5o
         05bgWbML/Vx92XTSceY19dWL98DPPUiyZ6GUGXZOi71o6ZqOjAePBdBlJi7Zx3ut4CCR
         gl6atPrm1d7097B2vwCv19ufTs+ofLBkvUYE+FLl3itYY4hnWP9vYiLwNj3aNO46aWWt
         HDdU4h1E1rHbhvtuOkOTbNlpX6uhRdEK1wWq5TFhKhadqyTr8sdDs5emx5T6vDEtCKUs
         aih12FWGNGZ6ICnfsYPqd2csEKjVot9seXVZPRLhxf+r89TErEsw7V4IMZWaJ+FJYUEA
         Ua+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7twjTlDo6dFR+2KR2TO6opjbbOKmFo5ubLXfSShFjik=;
        fh=RKQwgGbH758mjHkkXMPGcyzUVEHNRI+slJkrXbFN8g4=;
        b=U7Z67g+e4t/8ls5ahgDS3D8QfzyusuStOGNQ3AhQkDt8cSIqIcDe+/Z4T6HDYzAwQq
         SvTlcAh87dVk38C45n4Fw0MqiWvbd+sKdM743g98Y8RdmKm/talMgX2vuwtaAmhs6si6
         8hgmf2vma/6q71UIa4z+wFtmQ2OGDY6jqI4iU2+7fV7D50DWkHpPkPUeCI9u/WR/q9QT
         5VoG5N9loq6yJi6r54qgs+ama2ndKDK2V/2aozwhMjUCJcuJkDk/RauAaMjx+mrbiT1V
         dJWC12/T7zkNhOzZAGhMmuxy5374b5KuqT1Iv64p8axtoBdX3e1XcnCd/RaJerzVGVcX
         qGjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1776094345; x=1776699145; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7twjTlDo6dFR+2KR2TO6opjbbOKmFo5ubLXfSShFjik=;
        b=dBaUKYtb0bqcJ4BtcHsLt37pgVVUxWlx7/hPSbLqOtF53OoSrCfoSpMRo1BleyaDeg
         4UA+OPUcCxJvEb1aJ3apW48suWsDoVPXhDGUqcl0kI091WFVA8yp3EO6YWxsYYV7kDj4
         6I55+2e/7w1Gv9M0Mez0MGkSE8zHj4TeKCGGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776094345; x=1776699145;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7twjTlDo6dFR+2KR2TO6opjbbOKmFo5ubLXfSShFjik=;
        b=iGTldHPhpHo2ZcjRtM/u8mZv468MhFk9BRavX0vQWd1T8HGgSuoF6nt71YJ+DxallJ
         t4WDXvZMLbDVqIjcXfvjA/F48n6edyHCgoKlgiE7ZPspRgGIeDTk+Cznw1g8r0KGddlD
         TTmU817xV2bcqMy35lmecN3ilLvRERbw7IyijVVSA9S+DD3f8Ne455Wr15XLWnToESQA
         u/vZqfzTvvMbzSIdcxqTtCxOjrI8pWg4i0QQZbeqVdUKIiCPnAaw/Ph3EDzJjXQa9rKv
         BKqY8W7vongNv+9mX0v9QUzgBz066xnGdIlsuO0n5jkGNTOEeSWUXci22ZWOH9NzC1V3
         1yvQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Cq3hBPevmo9RzkUmOUJsPyQqbhSVNTDQ8VDrILDoSXNSASmcoQ292+m1a6blY6qx+ldZKr0JMb/9WDEMG@vger.kernel.org
X-Gm-Message-State: AOJu0YxqUMb/SXAKcuO6h/6H+pxLdpgy2S9dEoANTU71W7D8nGwE5ciE
	/locrjcI0356JoI3z1nDJCZJgknXxIIz7bCwr3L6AWg1x0xyZTyHH53eRS/UGEi+tfzgY3XKul4
	0Gotf4YnB6LBTqa+tzFsIP/48ew2cLvLa1O8n+S5P3A==
X-Gm-Gg: AeBDievVMYRowtouvtCsi+htGRlyVvIH12OxacNWtzf4+MvsNtz2NTSSJiDdxy4H9V5
	cRDD5zbDFapNuVR4Gl4ouzIOOAqAioTzerIQAuYB2/iwknSU4KtL6++aA09rI7RCK5C9qCbGV6p
	znkrCd9DZI7VvGoU8Xx8ZK78hGAh/kM2BYEnf+OydrF/LyB2gjIP02jzCWvEGJV3mL8E+M6MI+b
	6+GbgX2hoFwYEiEiB191sixJBatmfsW5ENcmXFbXHhkKmbfItdcOXL1FdCZMSwUwjNhNrb/874W
	i70XPZ5+qymz5RLfBrpS4VNUCDGnegJBTnWv
X-Received: by 2002:a4a:e905:0:b0:685:3561:8923 with SMTP id
 006d021491bc7-68be7ee230emr7236445eaf.38.1776094344904; Mon, 13 Apr 2026
 08:32:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpegunwB28WKqxNWCQyd5zrMfSif_YmBFp+_m-ZsDap9+G7Q@mail.gmail.com>
 <CAHk-=wht097GMgEuH870PU4dMfBCinZ5_qvxpqK2Q9PP=QRdTA@mail.gmail.com>
 <20251206014242.GO1712166@ZenIV> <CAHk-=wg8KJbcPuoRBFmD9c42awaeb4anXsC4evEOj0_QVKg0QQ@mail.gmail.com>
 <20251206022826.GP1712166@ZenIV> <CAHk-=wgBU3MQniRBmbKi2yj0fRrWQjViViNvNJ6sqjEB-3r4XA@mail.gmail.com>
 <20251206035403.GR1712166@ZenIV> <20251206042242.GS1712166@ZenIV>
 <CAJfpegtsDZW7v=YDhs+gPq25G+QOh-5mjiaXT04DDW=iU+R75A@mail.gmail.com>
 <20260412061644.GA2485189@ZenIV> <20260413002940.GA2846532@ZenIV>
In-Reply-To: <20260413002940.GA2846532@ZenIV>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 13 Apr 2026 17:32:12 +0200
X-Gm-Features: AQROBzCuYko6u-2x7WwTLYsuKHFansoP9zv5oAo46-H-HsClTK1ougAZWrVwltw
Message-ID: <CAJfpegsisBgr0QgBJdDzZFdG00+Jw+ATYJ1W3ac_mWr7RNrwKQ@mail.gmail.com>
Subject: Re: [GIT PULL] fuse update for 6.19
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 13 Apr 2026 at 02:25, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Sun, Apr 12, 2026 at 07:16:45AM +0100, Al Viro wrote:
>
> >       Looking at that thing again, I really hate how subtle it is ;-/
> > Consider the lockless case in your ->d_release() and try to write down
> > the reasons why it's safe.  Among the other things, kfree_rcu() is there
> > to protect RCU callers of ->d_revalidate(); fair enough, but it quietly
> > doubles as delaying that freeing past the scope of dentry_hash[].lock in
> > which you'd done RB_CLEAR_NODE(&fd->node) that had pushed ->d_release()
> > to lockless path.  Another side of that fun is the proof that if
> > fuse_dentry_tree_work() sees a dentry, it won't get freed under us.
> > Locked case of ->d_release() is easy; proving that the lockless one
> > is OK without explict barriers is more interesting.  Basically, all
> > insertions are ordered wrt ->d_release() (on ->d_lock), so if the value
> > we are observing in RB_EMPTY_NODE() has come from those we will hit the
> > locked case.  If the value we observe has come from RB_CLEAR_NODE() in
> > earlier fuse_dentry_tree_work() (these are ordered on dentry_hash[].lock,
> > wrt each other and insertions), there mustn't have been any subsequent
> > insertions, or ->d_release() would've observed the effect of those.
> > If the value has come from the _same_ fuse_dentry_tree_work(), the
> > implicit barrier in spin_lock() would've ordered that store wrt beginning
> > of the scope, and since dentry_free() is ordered wrt ->d_release()
> > the callback of call_rcu() in there wouldn't run until the the end of
> > the scope in question.  So I think it's OK, but having it done without
> > a single comment either on barriers or on memory safety...  Ouch.
> >
> >       Note that we *can* run into a dentry getting killed just after
> > RB_CLEAR_NODE() in there; it's just that store to ->d_flags of dying
> > or killed dentry is safe under ->d_lock and d_dispose_if_unused() is
> > a no-op for dying and killed ones - it's not just "If dentry has no
> > external references, move it to shrink list" as your comment in
> > fs/dcache.c says.  And in your case it very much does have an
> > external reference - it's just that it's an equivalent of RCU one,
> > with all the joy that inflicts upon the user.
>
> FWIW, here's what I've ended up with yesterday:
>
>         /*
>          * ->d_release() is ordered (on ->d_lock) after everything done
>          * while holding counting references, including all calls of
>          * fuse_dentry_add_tree_node().  Freeing a dentry is RCU-delayed
>          * and scheduling it is ordered after ->d_release().
>          *
>          * In ->d_release() we see the initialization and all stores done by
>          * fuse_dentry_add_tree_node(); since fuse_dentry_tree_work() is
>          * ordered wrt fuse_dentry_add_tree_node() (on dentry_hash[].lock)
>          * we also see all stores from fuse_dentry_tree_work() except possibly
>          * the last one.
>          *
>          * If the value fuse_dentry_release() observes in
>          *      if (!RB_EMPTY_NODE(&fd->node))
>          * has come from initialization, the node had never been inserted
>          * into rbtree and fuse_dentry_tree_work() won't see it at all.
>          *
>          * If the value we observe there comes from the last store in
>          * fuse_dentry_add_tree_node(), RB_EMPTY_NODE(&fd->node) will be
>          * false and we are going to enter a dentry_hash[].lock scope,
>          * providing an ordering wrt fuse_dentry_tree_work() which either
>          * won't find fd in rbtree, or will complete before we
>          * get to even scheduling dentry freeing.
>          *
>          * If the value we observe comes from fuse_dentry_tree_work(), we will
>          * be ordered past the beginning of dentry_hash[].lock scope that store
>          * had happened in.  Since call_rcu() that schedules freeing the dentry
>          * is ordered past the return from ->d_release(), freeing won't happen
>          * until the end of that scope.  Since there can be no subsequent calls
>          * of fuse_dentry_add_tree_node(), any subsequent calls of
>          * fuse_dentry_tree_work() won't see the node at all.
>          *
>          * Either way, if fuse_dentry_tree_work() sees a node, we are
>          * guaranteed that node->dentry won't get freed under it.

This is indeed subtle.

I think best way to un-subtle it would be to just remove the lockless
check and unconditionally call fuse_dentry_tree_del_node(), which
would make the ordering explicit on dentry_hash[].lock.

>          *
>          * Freeing the node itself is also RCU-delayed and scheduled in the
>          * very end of FUSE ->d_release(); similar considerations shows that
>          * if fuse_dentry_tree_work() sees a node, we are guaranteed that
>          * the node won't get freed under us either.
>          *
>          * While it is possible to run into a dying (or killed) dentry in
>          * fuse_dentry_tree_work(), d_dispose_if_unused() is safe to be
>          * used for those - it's a no-op in such case.
>          */
>
> Is the above sane?  If it is, something similar would be worth having
> written down somewhere in fs/fuse - it's not trivial and it's not hard
> to break accidentally...

Yeah, thanks for the analysis.

>
> As for the primitive itself...
>
> /**
>  * __move_to_shrink_list - try to place a dentry into a shrink list
>  * @dentry:     dentry to try putting into shrink list
>  * @list:       the list to put @dentry into.
>  * Returns:     true @dentry had been placed into @list, false otherwise
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
> __must_hold(&dentry->d_lock)
> {
>         if (likely(!dentry->d_lockref.count &&
>             !(dentry->d_flags & DCACHE_SHRINK_LIST))) {
>                 if (dentry->d_flags & DCACHE_LRU_LIST)
>                         d_lru_del(dentry);
>                 d_shrink_add(dentry, list);
>                 return true;
>         }
>         return false;
> }
> EXPORT_SYMBOL(__move_to_shrink_list);
>
> With something like
>         spin_lock(&fd->dentry->d_lock);
>         /* If dentry is still referenced, let next dput release it */
>         fd->dentry->d_flags |= DCACHE_OP_DELETE;
>         __move_to_shrink_list(fd->dentry, &dispose);
>         spin_unlock(&fd->dentry->d_lock);
> in fuse_dentry_tree_work() (along with the explanations of memory safety,
> that is)

Does this make any difference besides not having to lock d_lock twice?

Not against this change, just trying to understand the full implication.

Thanks,
Miklos
