Received: from smtp03-ext2.udag.de (smtp03-ext2.udag.de [62.146.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B311A9FA4;
	Wed,  1 Apr 2026 13:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775050898; cv=none; b=AX5ZDwBzF14ZpdqKIe0pQe5uUooZGe2KzZFfdK3ACYqgbBz+7xdb5F8TSCbHz562h+mTtlgJPg69VTHZ7zWJ9u1jvsRG/V8Vl/jMF8OkHXVcyISP0b1ya+x80nLXq5vyH3k4CaA4WdYP1ELw47AY2TUPsvLP8mWXz1LH6XezKkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775050898; c=relaxed/simple;
	bh=jJq3NGAm+CE5sGuKaC3Yp0Fgs9bkX5VmbwJJmEs1ZFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f7NfHHB0Yzg8QuFUm1yeL7zXhZrMwHac20Fen7Q7Pg0SiwhXt9B+Gj7lhEKOjGFjfKHGCoMje0VirokK4WdCo+YRx+Zab+uCqchxQcVG2n5M9HwXtAG7W5xV24wiadME+NQaTKbI5SkWn9uCxFKyZn4mPQTGQDb+ptq79HGj2ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (108-141-067-156.ip-addr.inexio.net [156.67.141.108])
	by smtp03-ext2.udag.de (Postfix) with ESMTPA id A9810E020F;
	Wed,  1 Apr 2026 15:41:28 +0200 (CEST)
Authentication-Results: smtp03-ext2.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Wed, 1 Apr 2026 15:41:27 +0200
From: Horst Birthelmer <horst@birthelmer.de>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Li Wang <liwang@kylinos.cn>, Miklos Szeredi <miklos@szeredi.hu>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] fuse: Send FORGET over io_uring when ring is ready
Message-ID: <ac0f6eN4PFE98diI@fedora.fritz.box>
References: <20260401104008.8827-1-liwang@kylinos.cn>
 <04bfb0c9-a0fc-4825-8c81-8c90774a4bb1@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04bfb0c9-a0fc-4825-8c81-8c90774a4bb1@bsbernd.com>

On Wed, Apr 01, 2026 at 11:52:28AM +0000, Bernd Schubert wrote:
> 
> 
> On 4/1/26 10:40, Li Wang wrote:
> > Once the FUSE io_uring is registered and marked ready, most request
> > types are delivered through io_uring, while FORGET notifications were still
> > queued with fuse_dev_queue_forget() and only consumed through the legacy
> > path on /dev/fuse.
> > 
> > Deliver single FORGET operations through fuse_uring_queue_fuse_req() when
> > the ring is ready. Otherwise, fall back to fuse_dev_queue_forget()
> > so behavior matches the previous implementation.
> > 
> > Benefits:
> > - While io-uring is active, the daemon can handle forgets in the same
> >   commit/fetch loop as other opcodes instead of also draining a separate
> >   /dev/fuse read path for forget traffic.
> > - Reduces split-brain transport for high-volume forgets (eviction,
> >   unmount) when the ring is already the primary channel, which simplifies
> >   userspace and keeps teardown forgets on the same completion path as
> >   other uring-backed work.
> > - Reuses the same per-queue io-uring machinery and noreply/force request
> >   setup (creds, FR_WAITING/FR_FORCE, etc.) already used for similar
> >   kernel-initiated traffic.
> > 
> > Signed-off-by: Li Wang <liwang@kylinos.cn>
> > ---
> >  fs/fuse/dev.c        | 84 ++++++++++++++++++++++++++++++++++++++++++++
> >  fs/fuse/dev_uring.c  |  2 +-
> >  fs/fuse/fuse_dev_i.h |  4 +++
> >  3 files changed, 89 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > index b212565a78cf..f58abc80fd7b 100644
> > --- a/fs/fuse/dev.c
> > +++ b/fs/fuse/dev.c
> > @@ -665,6 +665,90 @@ static void fuse_args_to_req(struct fuse_req *req, struct fuse_args *args)
> >  		__set_bit(FR_ASYNC, &req->flags);
> >  }
> >  
> > +#ifdef CONFIG_FUSE_IO_URING
> > +struct fuse_forget_uring_data {
> > +	struct fuse_args args;
> > +	struct fuse_forget_in inarg;
> > +};
> > +
> > +static void fuse_forget_uring_free(struct fuse_mount *fm, struct fuse_args *args,
> > +				   int error)
> > +{
> > +	struct fuse_forget_uring_data *d =
> > +		container_of(args, struct fuse_forget_uring_data, args);
> > +
> > +	kfree(d);
> > +}
> > +
> > +/*
> > + * Send FUSE_FORGET through the io-uring ring when active; same payload as
> > + * fuse_read_single_forget(), with userspace committing like any other request.
> > + */
> > +void fuse_io_uring_send_forget(struct fuse_iqueue *fiq,
> > +				struct fuse_forget_link *forget)
> > +{
> > +	struct fuse_conn *fc = container_of(fiq, struct fuse_conn, iq);
> > +	struct fuse_mount *fm;
> > +	struct fuse_req *req;
> > +	struct fuse_forget_uring_data *d;
> > +
> > +	if (!fuse_uring_ready(fc)) {
> > +		fuse_dev_queue_forget(fiq, forget);
> > +		return;
> > +	}
> > +
> > +	down_read(&fc->killsb);
> > +	if (list_empty(&fc->mounts)) {
> > +		up_read(&fc->killsb);
> > +		fuse_dev_queue_forget(fiq, forget);
> > +		return;
> > +	}
> > +	fm = list_first_entry(&fc->mounts, struct fuse_mount, fc_entry);
> > +	up_read(&fc->killsb);
> > +
> > +	d = kmalloc(sizeof(*d), GFP_KERNEL);
> > +	if (!d)
> > +		goto fallback;
> > +
> > +	atomic_inc(&fc->num_waiting);
> > +	req = fuse_request_alloc(fm, GFP_KERNEL);
> > +	if (!req) {
> > +		kfree(d);
> > +		fuse_drop_waiting(fc);
> > +		goto fallback;
> > +	}
> > +
> > +	memset(&d->args, 0, sizeof(d->args));
> > +	d->inarg.nlookup = forget->forget_one.nlookup;
> > +	d->args.opcode = FUSE_FORGET;
> > +	d->args.nodeid = forget->forget_one.nodeid;
> > +	d->args.in_numargs = 1;
> > +	d->args.in_args[0].size = sizeof(d->inarg);
> > +	d->args.in_args[0].value = &d->inarg;
> > +	d->args.force = true;
> > +	d->args.noreply = true;
> > +	d->args.end = fuse_forget_uring_free;
> > +
> > +	kfree(forget);
> > +
> > +	fuse_force_creds(req);
> > +	__set_bit(FR_WAITING, &req->flags);
> > +	if (!d->args.abort_on_kill)
> > +		__set_bit(FR_FORCE, &req->flags);
> > +	fuse_adjust_compat(fc, &d->args);
> > +	fuse_args_to_req(req, &d->args);
> > +	req->in.h.len = sizeof(struct fuse_in_header) +
> > +		fuse_len_args(req->args->in_numargs,
> > +			      (struct fuse_arg *)req->args->in_args);
> > +
> > +	fuse_uring_queue_fuse_req(fiq, req);
> > +	return;
> > +
> > +fallback:
> > +	fuse_dev_queue_forget(fiq, forget);
> > +}
> > +#endif
> > +
> >  ssize_t __fuse_simple_request(struct mnt_idmap *idmap,
> >  			      struct fuse_mount *fm,
> >  			      struct fuse_args *args)
> > diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> > index 7b9822e8837b..a96539ea400a 100644
> > --- a/fs/fuse/dev_uring.c
> > +++ b/fs/fuse/dev_uring.c
> > @@ -1360,7 +1360,7 @@ bool fuse_uring_remove_pending_req(struct fuse_req *req)
> >  
> >  static const struct fuse_iqueue_ops fuse_io_uring_ops = {
> >  	/* should be send over io-uring as enhancement */
> > -	.send_forget = fuse_dev_queue_forget,
> > +	.send_forget = fuse_io_uring_send_forget,
> 
> I will check the other parts more thoroughly in the evening, but please
> take a look into fuse_uring_register(), it also also overrides other
> pointers at startup - I would like leave it here as it is, move the
> function above into dev_uring.c and then update this part in dev_uring.c
> 
> static const struct fuse_iqueue_ops fuse_io_uring_ops = {
>         /* should be send over io-uring as enhancement */
>         .send_forget = fuse_dev_queue_forget,

Hi Bernd,

I have never asked the question before, but now I'm a bit intrigued ...
Why wasn't this not done before? Was it a performance thing?

thanks,
Horst

> 
> 
> Thanks,
> Bernd
> 
