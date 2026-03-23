Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA0F3BF678;
	Mon, 23 Mar 2026 17:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774288402; cv=none; b=ikiiL0FBRJVvjsScelehX+rki+j5HI4fjW8qWk4Y+fP+K9wrcpnnLAAj3Z/F7DQyZX7dpjbuJmD3pVQdqBmZnU4dbrjfEmK2UCN/JIjiBh9iFdVfGc8q8WUKvBvT/FFCld8OJupgT7uKLSM7Od8JyQzDs2mi1x7tF4kTXelt1S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774288402; c=relaxed/simple;
	bh=+EKU6hnfBkd36dW+9myUioJzQ4owVa3INrYW2QiBUYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qTkObDPm2XPHgqBPS1TkjCxytFRrqdHrDPsgOQVQIqZA6xY3hWKA2d5wwqWWQMOy9zI8rfF2cnVksOStcha08gIGdOpeNQXDyEU/TMOF/nW0iYMy95rwesfLr1IDSYIQ+8G94/wkYYYc1hGPZqRtaOlMT2AOR5j8buZ22Y1UAzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eyV16Ud8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eyV16Ud8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBC89C2BC9E;
	Mon, 23 Mar 2026 17:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774288402;
	bh=+EKU6hnfBkd36dW+9myUioJzQ4owVa3INrYW2QiBUYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eyV16Ud88vO3anLZuUdNZwyPYOrAPGl3YmXgEYrZ8mNwVPahOKLRqtwyYiEWgXmCV
	 WNhIqLPpAB6xyvo7gr/S3v6VhFbzeSPUw/6PsT1+glPB6b0JxeqpyEIMMHRtdI+vWr
	 o1umeWXFrGQqagzr2POv5b+6CtoKfOnXOCxtRfNKtOvuuWlCsWC3iorOw7ahJ/ahmR
	 4CRJY2c67+ncZ3pSX1A7hVY0ocdbZgl3GQ8o26xQ/5DHJQH1BFT4I8EG+ybOHox8w/
	 ErmuUt0d3haKC+9Pm9FY8Qw78Ou1m/KlQ3KWkXcpBcfing+OPQztGVFjH5xtYeI/ym
	 W63QmQQcjAQug==
Date: Mon, 23 Mar 2026 10:53:21 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org,
	Bernd Schubert <bernd@bsbernd.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/7] fuse: abort on fatal signal during sync init
Message-ID: <20260323175321.GB6202@frogsfrogsfrogs>
References: <20260316165320.3245526-1-mszeredi@redhat.com>
 <20260316165320.3245526-2-mszeredi@redhat.com>
 <CAJnrk1ZCLS4BhGJm7y4HC07tvAL-KHeU_B-0ep_1r9kaaf1Lnw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1ZCLS4BhGJm7y4HC07tvAL-KHeU_B-0ep_1r9kaaf1Lnw@mail.gmail.com>

On Mon, Mar 16, 2026 at 11:48:09AM -0700, Joanne Koong wrote:
> On Mon, Mar 16, 2026 at 9:53 AM Miklos Szeredi <mszeredi@redhat.com> wrote:
> >
> > When sync init is used and the server exits for some reason (error, crash)
> > while processing FUSE_INIT, the filesystem creation will hang.  The reason
> > is that while all other threads will exit, the mounting thread (or process)
> > will keep the device fd open, which will prevent an abort from happening.
> >
> > This is a regression from the async mount case, where the mount was done
> > first, and the FUSE_INIT processing afterwards, in which case there's no
> > such recursive syscall keeping the fd open.
> >
> > Fixes: dfb84c330794 ("fuse: allow synchronous FUSE_INIT")
> > Cc: stable@vger.kernel.org # v6.18
> > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> 
> LGTM but left a comment below
> 
> Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
> 
> > ---
> >  fs/fuse/dev.c    | 6 +++++-
> >  fs/fuse/fuse_i.h | 1 +
> >  fs/fuse/inode.c  | 1 +
> >  3 files changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > index 2c16b94357d5..f0631c48abef 100644
> > --- a/fs/fuse/dev.c
> > +++ b/fs/fuse/dev.c
> > @@ -576,6 +576,9 @@ static void request_wait_answer(struct fuse_req *req)
> >                         removed = fuse_remove_pending_req(req, &fiq->lock);
> >                 if (removed)
> >                         return;
> > +
> > +               if (req->args->abort_on_kill)
> > +                       fuse_abort_conn(fc);
> 
> Maybe more straightforward to move this logic a few lines above? eg
> 
> @@ -570,6 +570,11 @@ static void request_wait_answer(struct fuse_req *req)
>                 /* Only fatal signals may interrupt this */
>                 err = wait_event_killable(req->waitq,
>                                         test_bit(FR_FINISHED, &req->flags));
>                 if (!err)
>                         return;
> 
> +               if (req->args->abort_on_kill) {
> +                       fuse_abort_conn(fc);
> +                       return;
> +               }

Either's fine with me -- AFAICT it doesn't matter if we just abort the
connection without fiddling with the request in which case FUSE_INIT
fails with ECONNABORTED; or we try to remove it and end up cancelling it
with EINTR.  Either way the connection aborts, the mount stops working,
and the fuse server is gone.

I like this fix much better :)
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> 
> Thanks,
> Joanne
> 
> >         }
> >
> >         /*
> > @@ -676,7 +679,8 @@ ssize_t __fuse_simple_request(struct mnt_idmap *idmap,
> >                         fuse_force_creds(req);
> >
> >                 __set_bit(FR_WAITING, &req->flags);
> > -               __set_bit(FR_FORCE, &req->flags);
> > +               if (!args->abort_on_kill)
> > +                       __set_bit(FR_FORCE, &req->flags);
> >         } else {
> >                 WARN_ON(args->nocreds);
> >                 req = fuse_get_req(idmap, fm, false);
> > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > index 7f16049387d1..23a241f18623 100644
> > --- a/fs/fuse/fuse_i.h
> > +++ b/fs/fuse/fuse_i.h
> > @@ -345,6 +345,7 @@ struct fuse_args {
> >         bool is_ext:1;
> >         bool is_pinned:1;
> >         bool invalidate_vmap:1;
> > +       bool abort_on_kill:1;
> >         struct fuse_in_arg in_args[4];
> >         struct fuse_arg out_args[2];
> >         void (*end)(struct fuse_mount *fm, struct fuse_args *args, int error);
> > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > index e57b8af06be9..84f78fb89d35 100644
> > --- a/fs/fuse/inode.c
> > +++ b/fs/fuse/inode.c
> > @@ -1551,6 +1551,7 @@ int fuse_send_init(struct fuse_mount *fm)
> >         int err;
> >
> >         if (fm->fc->sync_init) {
> > +               ia->args.abort_on_kill = true;
> >                 err = fuse_simple_request(fm, &ia->args);
> >                 /* Ignore size of init reply */
> >                 if (err > 0)
> > --
> > 2.53.0
> >
> >
> 
