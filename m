Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4071346FB5
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Apr 2026 20:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775075743; cv=pass; b=smfhcXRDz2kxj84Qv0cXYQHK+VXY255CbUTMh3kLj1V7A6Idy6cjaOQawtTixuVnaanlGLi0Qer/CxretmOK+phj7ylAsufntIsZhmWgHQz8LrhojJ3qZY1MAmIDIkl0CcrAqfW6zrBq7dt2wNUrPTXt+aI1uaOpTHI/02hVrv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775075743; c=relaxed/simple;
	bh=h11ew2YaT6kAlBIRTv70GyyTHBZ8xdPOdizqCNcSp0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DRT59gT2HexmzUhrsEn+DtDG13J5VFxRPi30hQvxpVd1OBMJI0FJB9QF8+juthc4mOx3kIUNCImIjIH6V97FJVrnML4oR5yImV4fUEKm7QxVrfK93g//e/DrC3z2lDqxOJeMhce2rWuyAXjLeY+oNI8CREeKP/Og96UCZxnH21Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ca5Z9P73; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ca5Z9P73"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43d02a71526so124362f8f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Apr 2026 13:35:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775075740; cv=none;
        d=google.com; s=arc-20240605;
        b=ezJQbpKEh6H283HUYfxUe4TbUK9w5X+tiY8Ka+HML6QcfkVgb2F8rKrhJ8KkUl8w7Z
         Z/c6IwLs6o+O1a+jiTVsbPMo/aRnoVsCD75vgW+rEXnkC7WUptGC6EKBBVZwnmViBZeh
         vHg53GTIuMLsT+/PO0xXUYAYzNV2IjSpmUPF+zUwXK4JXNMK541TfXB7/+Z92dd1Bnlg
         EhFMs9g4lVzTzqzXWxHXIFWba0e+4/SU/6LlC9tTh8xyWFHHKydxsehaEqyltZ/+nSmC
         tCFbzkL/ZQ6MOL6X2esxHpM/HmMvr879u6Lr4P7ZCgG9iK7KxvceP13foDDtDVGa3mTT
         h1EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vPqtjbIHY9N6YaK6d20kTyowUeVx4yekLDy+T7UaVb8=;
        fh=7E4zBi9gmrNa39nEO9LHcD1gwtEYf6a1GqPjI3DKZgU=;
        b=jL19xC3/QZDmPp5u5rPvSL2MfNZ8axM915KWn959Scb0jlNIWQA9GPcetaQyUqwov1
         fyy4nX9aKP3S1Tzv3Itdtj3My+POAgAKVGJaTb7fk0eJW1lAozh6ck3hzVzLPcIK5WqB
         cyYIZoIlNoqnlYG1155/7CRc0YNvmsuFTDTZxfI1Ozz/PkF/QtG58M9v5Glbr4KI4Wft
         z/aQSwMPnepdZHs7fK9NjBrCKtP1BLXJHex6n65dSNukSUR5+hqklVdU6WIrk6NgYc6/
         NVRt+HcnU3VSlXB10ytMkursjmmYuGSSGjIWed6mMv0j1hxeIbLCevPYTE193K39nWVB
         Io3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775075740; x=1775680540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vPqtjbIHY9N6YaK6d20kTyowUeVx4yekLDy+T7UaVb8=;
        b=Ca5Z9P73u/e1nHgUn2BVIZUp4+zSiKnBaawGQGCLtkdj8xX8TS5IseXz2t0n8kmbHB
         u8ktx6JaOZRI/Cj510DAKaz99Sl4CtKHjYTcXmoleP0QMXFYoMmUIn6mjocn1sCVvCgQ
         dscDRDXbrShrO+RUUUap71TLPKslzqrBkFhkylNDH8/eL3sAfF7RZQlS1RSlwg0fcwiL
         WUctkZtdjoHcd4T9rq4AFuc7/KCSOjyY4xM2beLlTtQxV3dk6ezubzZptH5Jj4uVyuvt
         dpyIRs3Zbd1Qdedef3uoSj7NfHHQ5aceLq/21gTC1FMZRC8A1c9BwcpVjbKAaHh+stin
         yGxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775075740; x=1775680540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vPqtjbIHY9N6YaK6d20kTyowUeVx4yekLDy+T7UaVb8=;
        b=mQTqm+JkFW0rpkGDEMM6Bc885605WbOeyOawN7KUxOntBe0jItxwknB9wGRtt0ETgP
         46BUFIYHy8d7Rb32dCV05WhEVShyCQZf+S2zQage1I1hrgMW3+srPHLDN/9EGhRhic4d
         dfWDega2pYZwb9dw3IISO+c9s/sFfnMWyHiEyg5tBr/kdjz6lDSjg6jkACVsywP6+q2x
         GCaC09gWbHf7S4jCjU0lKyMGgKjS96CCu7BODXwFGWCgAcfBz8xvgyCBCp2YNHM1q4jv
         lObkrMu8Kn3S/C8J33h6krmR5AqIY9mt2THiOrq1x2wbHs9J6ZY58YEjsBpBn9kZ+Yqe
         FsFw==
X-Forwarded-Encrypted: i=1; AJvYcCWArqR19zBHKnRGjM+bAaI3sel0I9ve4H8f+BwgdPjIhSTg+UV7hs87NhdiTHc25wUMO+Dj89N8nidvZHji@vger.kernel.org
X-Gm-Message-State: AOJu0YwM1lSvmKZrtzaB3/YMIRojUTBoIgYMTKcyU1BChciSTqRbfgbx
	vFd7pl9j447S5KrBaYZVVj4rp7yTV2a2X7J5B39l4wEXaDiTjsNJ8kmBpORsPpD9wgtfXPkWnRz
	UjIG8qLZF7WPRHtXhZXxu36IxmZ69Y1g=
X-Gm-Gg: ATEYQzxIMRxrxHyo93FkGFOqYPYrvtTHy7X2nT7ewsqaF2HP7FrLUmXZwpDxiKRoyQT
	Mimxg29Qs2WjlkSKgYvSDKxzP3uhzL7vivZ7iCmt8CGvdM8JsYHlp9BmeOHDUsGnmKn2eDxrtM3
	GifhIdrtCZB1i4LA1/1uzPDMMj/7+Pwl08cDx3fPCmbxbYEH8bJCjldd5MDmABcK9nKVOzqPBoE
	OQHWZR4uD97I46PmtOmLF5HtyD+EujocWFTXNSLMitE0jbicVOkhOPZqTCi0d0h4VTl8XyZkd4y
	56NgnA==
X-Received: by 2002:a05:6000:4024:b0:43c:fd18:a30e with SMTP id
 ffacd0b85a97d-43d150e8bd5mr9355563f8f.35.1775075739339; Wed, 01 Apr 2026
 13:35:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401184915.747714-1-joannelkoong@gmail.com> <278724ec-0c5a-4b3b-b4d7-c5a3c0ceef3b@bsbernd.com>
In-Reply-To: <278724ec-0c5a-4b3b-b4d7-c5a3c0ceef3b@bsbernd.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 1 Apr 2026 13:35:27 -0700
X-Gm-Features: AQROBzBSj_Y99aKXQv_Llm4vNJvlK83PyOhwMZbsHBcC7Q6afH4s2dZTPHnIjq8
Message-ID: <CAJnrk1bH2_hk=mfbk0Ac+9UQV7bPHuD9CseWDhj623um7NmdgQ@mail.gmail.com>
Subject: Re: [PATCH v1] fuse: fix io-uring background queue stall on request completion
To: Bernd Schubert <bernd@bsbernd.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, 
	Horst Birthelmer <hbirthelmer@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 12:49=E2=80=AFPM Bernd Schubert <bernd@bsbernd.com> =
wrote:
>
Hi Bernd,

Thanks for taking a look at this.
>
> On 4/1/26 20:49, Joanne Koong wrote:
> > When a background request completes via the io_uring path, the
> > background queue gets flushed to dispatch pending background requests,
> > but this is done before the connection-level background counters
> > (fc->num_background, fc->active_background) are properly accounted,
> > which can leave pending background requests stuck in the per-queue
> > background queue.
>
> I don't think it ever gets stuck. In fuse_uring_flush_bg()
>
>         while ((fc->active_background < fc->max_background ||
>                 !queue->active_background) &&
>

If the queue already has other background requests in-flight, then
this check never passes due to the stale fc->active_background value
and all pending background requests on the queue are stuck until that
in-flight background request completes, no? I'm rereading my commit
message, maybe the wording is unclear - do you prefer it to be
reworded to "which can leave pending background requests in the
per-queue background queue stalled"?

>
> And queue->active_background gets decreased in the caller,
> fuse_uring_req_end. Idea is to always let through at least one
> background request per queue. Reson is that the global
> fc->num_background might be at the limit already, a
> queue then might get a request, it would get added to
> queue->fuse_req_bg_queue, but once fc->active_background goes
> down, there wouldn't be anything to wake up these requests.
> Issue: Only one request allowed per queue when this comes up.
>
> >
> > The connection-level counters are decremented in fuse_request_end(), bu=
t
> > flush_bg_queue() flushes the /dev/fuse path queue (fc->bg_queue), not
> > the io_uring per-queue bg one, which means pending uring background
> > requests on the queue are never dispatched.
> >
> > Fix this by accounting the connection-level background counters first
> > before flushing the queue's background queue. Since
> > fuse_request_bg_finish() clears FR_BACKGROUND, fuse_request_end() will
> > skip the background cleanup branch entirely, which avoids any
> > double-decrements; it will call the wake_up(&req->waitq) branch but thi=
s
> > is effectively a no-op as background requests have no waiters on
> > req->waitq.
> >
> > Fixes: 857b0263f30e ("fuse: Allow to queue bg requests through io-uring=
")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  fs/fuse/dev.c        | 41 ++++++++++++++++++++++++-----------------
> >  fs/fuse/dev_uring.c  |  1 +
> >  fs/fuse/fuse_dev_i.h |  1 +
> >  3 files changed, 26 insertions(+), 17 deletions(-)
> >
> > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > index b212565a78cf..35cdfc162ba5 100644
> > --- a/fs/fuse/dev.c
> > +++ b/fs/fuse/dev.c
> > @@ -447,6 +447,29 @@ static void flush_bg_queue(struct fuse_conn *fc)
> >       }
> >  }
> >
> > +void fuse_request_bg_finish(struct fuse_conn *fc, struct fuse_req *req=
)
> > +{
> > +     lockdep_assert_held(&fc->bg_lock);
> > +
> > +     clear_bit(FR_BACKGROUND, &req->flags);
> > +     if (fc->num_background =3D=3D fc->max_background) {
> > +             fc->blocked =3D 0;
> > +             wake_up(&fc->blocked_waitq);
> > +     } else if (!fc->blocked) {
> > +             /*
> > +              * Wake up next waiter, if any.  It's okay to use
> > +              * waitqueue_active(), as we've already synced up
> > +              * fc->blocked with waiters with the wake_up() call
> > +              * above.
> > +              */
> > +             if (waitqueue_active(&fc->blocked_waitq))
> > +                     wake_up(&fc->blocked_waitq);
> > +     }
> > +
> > +     fc->num_background--;
> > +     fc->active_background--;
> > +}
> > +
> >  /*
> >   * This function is called when a request is finished.  Either a reply
> >   * has arrived or it was aborted (and not yet sent) or some error
> > @@ -479,23 +502,7 @@ void fuse_request_end(struct fuse_req *req)
> >       WARN_ON(test_bit(FR_SENT, &req->flags));
> >       if (test_bit(FR_BACKGROUND, &req->flags)) {
> >               spin_lock(&fc->bg_lock);
> > -             clear_bit(FR_BACKGROUND, &req->flags);
> > -             if (fc->num_background =3D=3D fc->max_background) {
> > -                     fc->blocked =3D 0;
> > -                     wake_up(&fc->blocked_waitq);
> > -             } else if (!fc->blocked) {
> > -                     /*
> > -                      * Wake up next waiter, if any.  It's okay to use
> > -                      * waitqueue_active(), as we've already synced up
> > -                      * fc->blocked with waiters with the wake_up() ca=
ll
> > -                      * above.
> > -                      */
> > -                     if (waitqueue_active(&fc->blocked_waitq))
> > -                             wake_up(&fc->blocked_waitq);
> > -             }
> > -
> > -             fc->num_background--;
> > -             fc->active_background--;
> > +             fuse_request_bg_finish(fc, req);
> >               flush_bg_queue(fc);
> >               spin_unlock(&fc->bg_lock);
> >       } else {
> > diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> > index 7b9822e8837b..ae916733f18a 100644
> > --- a/fs/fuse/dev_uring.c
> > +++ b/fs/fuse/dev_uring.c
> > @@ -90,6 +90,7 @@ static void fuse_uring_req_end(struct fuse_ring_ent *=
ent, struct fuse_req *req,
> >       if (test_bit(FR_BACKGROUND, &req->flags)) {
> >               queue->active_background--;
> >               spin_lock(&fc->bg_lock);
> > +             fuse_request_bg_finish(fc, req);
>
> This basically solves the issue that situations could come up where only
> one requests runs at a time.
>
> >               fuse_uring_flush_bg(queue);
> >               spin_unlock(&fc->bg_lock);
> >       }
> > diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
> > index 134bf44aff0d..7da505af6d35 100644
> > --- a/fs/fuse/fuse_dev_i.h
> > +++ b/fs/fuse/fuse_dev_i.h
> > @@ -59,6 +59,7 @@ unsigned int fuse_req_hash(u64 unique);
> >  struct fuse_req *fuse_request_find(struct fuse_pqueue *fpq, u64 unique=
);
> >
> >  void fuse_dev_end_requests(struct list_head *head);
> > +void fuse_request_bg_finish(struct fuse_conn *fc, struct fuse_req *req=
);
> >
> >  void fuse_copy_init(struct fuse_copy_state *cs, bool write,
> >                          struct iov_iter *iter);
>
>
> Reviewed-by: Bernd Schubert <bernd@bsbernd.com>
>
>
>
> PS: If you should be chasing a stuck bg queue issue at tear down, Horst
> is chasing a teardown issue with bg queue.

Awesome, looking forward to seeing Horst's investigation.

Thanks,
Joanne

> We are currently testing this patch
>
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index 3de97ed2280f..451bf8981e19 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -136,11 +136,10 @@ void fuse_uring_abort_end_requests(struct fuse_ring=
 *ring)
>                 if (!queue)
>                         continue;
>
> -               queue->stopped =3D true;
> -
>                 WARN_ON_ONCE(ring->fc->max_background !=3D UINT_MAX);
>                 spin_lock(&queue->lock);
>                 spin_lock(&fc->bg_lock);
> +               queue->stopped =3D true;
>                 fuse_uring_flush_bg(queue);
>                 spin_unlock(&fc->bg_lock);
>                 spin_unlock(&queue->lock);
>
>
> Thanks,
> Bernd
