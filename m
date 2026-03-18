Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8773B8953
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2026 09:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773826457; cv=pass; b=FhbLjp3QUwpverryq/f9VL9OyFJsbq0kIkMnYcrKli+J4egwvNf5tmjHjOYWHjX6e+oaWt4clhF3T9aHqqfCrJfnBWjVaP+C9o7pWpFXVa6SJXk49+3hb0b5sqyhVQJwWuv1Y0UsESbHcOfngGJ+TF/MPHiz9VwaDK2q+8GBcek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773826457; c=relaxed/simple;
	bh=FgwypM2/jduioBmSjpVWhPtL8Tudc0OhB5HXfAUjt0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AoWR2HkXfnGTEC6oZ5YOTf0QGdZ5Wl0/822d134P/nrx1mqO6ez32qjayveIHPhA01QcU78QtPf1OwdaLfURGIfPpjS+uwqOKZOmQqnc7/cvBp8pM+whkUzcMXpQ6iCKGf6s6T8xvy+VCgVGAzMD4U4zgm7Xb2IZhj1Na9NYXd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=K+JEMtYW; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="K+JEMtYW"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-506aa685d62so39207301cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2026 02:34:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773826449; cv=none;
        d=google.com; s=arc-20240605;
        b=kAoB2Mo2jAxgzVDoBRCHb2J9Vfi0WmWKAAWPJ0YajKYwuHc6IW/qVcjOq5Fyg3lZdg
         RLGGEbYTbq31iV1hUIs7rRTKdkDBIm14F2T/0FeHADcVqRJAiF4eawppNAoRo9JjSJBM
         mcx55K6/SypSi6nZdFAHxLA6GKEdHfkBwmvmmBMSb0hVfxLCtbF2B+T2e46k7pkJo8W2
         h4jQCo1ITEn2IkiXO87vVEN8URz9DhKUm4qk6qfVJpf5YXC9UlnZFqjU7oN0VPz8l966
         8V8WJ8uuMtCFaIyTSnYeqvYE69Hf42pzw4VKC1QnYw17/CzyIl3/82V/eO2kBDctZcTt
         Ct+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=sSllBgqSMghiwQLqLxGBHsfbw2/TvkAtTe1iuB8Im0A=;
        fh=T1S3h5TnACq084V5QOme0N8o/FEBWOxZGaFWrDKSQmc=;
        b=QBv+AsDPxQQnBusBQEEGWDQQi9fl2pXpXJDja5bU38YXl6M5giWzvHg/36VIvyz05Q
         o4OAdaGgqUxyVcBSvGdw+nwuY19P1kLFrASAkHNo2K6nOnf+3Lv2fpkyH0AGlWQGqmZK
         FCpaD7/W3MMvmPX1g6pyYKazixkrgkSlTzjOjQdYEXNLPZnBzsF2q7oIuK+MwcSxlVsH
         hnlS6sUPEdA6jB70yaILkf3ROERZ8bQEzhCwJY+cha30VoSHQVPQGQcMAIV/x+mM3B6F
         yDCjMddUtZxSYVNXVgTUZ0qAKv8tizF8PV58XxdeGijX62pDkgPFp3so/FEwf9J4AkoK
         lifg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1773826449; x=1774431249; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sSllBgqSMghiwQLqLxGBHsfbw2/TvkAtTe1iuB8Im0A=;
        b=K+JEMtYWVlubcp1/NWU4UXfcjCLBId6bLRLK3xNG0dJVOi77qaMEW2ptk4kMf+ZxsH
         Djq7yTwZnAd0C4RcSa0c230oe1TV1VQr+InEx+f2j0JZzxR8fI6hHl8ng32XukPm1GyX
         7w0jH4RavfDza6z2HHSAfr4JyPXBxjSqhsYgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773826449; x=1774431249;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sSllBgqSMghiwQLqLxGBHsfbw2/TvkAtTe1iuB8Im0A=;
        b=i2oNMJSK3qzmdd6+f9WDmKISNfpS0hQsPUNFnhzgDTTCrCDnE1/yE7ZqS9kTz4KTPC
         j09lr1LKkjt1VGNLllMYkuMdq+7m77z+YSincMW+L2MtURxA8245iZ3FQPHHbGNt6qjL
         ljPprP9DYotIc+2rAEfCT5v7Ixu9nyyOD3/dlZYndjAEgoqBrwCfzxX3n861uGjLrFps
         fSIGN6hFA3sX+18YqdIE/EKhKw9H+r7rEf9Izb/+zWkb9MmghSuphYDOc+a7dqVBH6Sx
         yQsYyhmXAiCJD76KR5vEEDi5Orhs3/TfTHAvfBG9Yj6iwmxHcA7vXya9D20Ty4DOl+EU
         6Azw==
X-Forwarded-Encrypted: i=1; AJvYcCUz7RSqFzoPN3DSZdbMI0fFcc1B4/mcX8aV/Cq/FPBTtCITCJ+/uL8egOPRNugm0RefrdKOiyMSEODh1iBK@vger.kernel.org
X-Gm-Message-State: AOJu0YyTriuMbvQ/dv/qBJZGP5wbDW/xdm55PAqu2fTlLR+775jusyZ9
	5v8vnGM9W/n4907cgPzvfix+EEUU+QQPOd0FSaFECIjyALZVP2225RTiPBNG0WTJ84PjGFGC8sT
	VzxODuoAWYzxBlcYMunfqQvmUQsfpJeMg8LPIgzZkXg==
X-Gm-Gg: ATEYQzwh+CCUcoF2OIytmXOSaRE6AlMONqD8Iq17o1WjaS3XUzrFOkcAUHtdg/5eiYq
	4luwQHEEGuI6TVMOtD+1Ceq+CQh5OJyU1t6Lr+KbO1de9vpE5u2v5aKriB5GD5GYGvIQrYj2A4z
	xgYJninyVprxt2Q2dAZewy2R4oUODrVYs3R417lgIXqk5ls7BBFxR5ezYH+uO2TGevj9flQo9al
	NMuXyD89c08ki3KahS/j1ZemXHiFBpwvs4B8EwFOw2voFGu9ZI9w2z6+UTpuJp+Z+7UzI+/EmOm
	0imhzfiGXxh2oh3h+Giq199mU+E9buwfF3w0Zd/P
X-Received: by 2002:ac8:7d0b:0:b0:509:44c3:5ff6 with SMTP id
 d75a77b69052e-50b147cb2d8mr29167171cf.32.1773826449375; Wed, 18 Mar 2026
 02:34:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316165320.3245526-1-mszeredi@redhat.com> <20260316165320.3245526-2-mszeredi@redhat.com>
 <0fb13941-6fca-433f-a560-9da51113d88f@bsbernd.com>
In-Reply-To: <0fb13941-6fca-433f-a560-9da51113d88f@bsbernd.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 18 Mar 2026 10:33:58 +0100
X-Gm-Features: AaiRm52YxwAdl4yxvi4IYC4_ikRu2-TvWci0NKOKZP5OiNNSFOCKGcwpuJP2NGA
Message-ID: <CAJfpeguhwLHh=Fk+EGG_j9ap8yHgn9Mkocy-9X_0O-uuo_q3-A@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] fuse: abort on fatal signal during sync init
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Mar 2026 at 21:24, Bernd Schubert <bernd@bsbernd.com> wrote:
>
>
>
> On 3/16/26 17:53, Miklos Szeredi wrote:
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
> >                       removed = fuse_remove_pending_req(req, &fiq->lock);
> >               if (removed)
> >                       return;
> > +
> > +             if (req->args->abort_on_kill)
> > +                     fuse_abort_conn(fc);
> >       }
> >
> >       /*
> > @@ -676,7 +679,8 @@ ssize_t __fuse_simple_request(struct mnt_idmap *idmap,
> >                       fuse_force_creds(req);
> >
> >               __set_bit(FR_WAITING, &req->flags);
> > -             __set_bit(FR_FORCE, &req->flags);
> > +             if (!args->abort_on_kill)
> > +                     __set_bit(FR_FORCE, &req->flags);
> >       } else {
> >               WARN_ON(args->nocreds);
> >               req = fuse_get_req(idmap, fm, false);
> > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > index 7f16049387d1..23a241f18623 100644
> > --- a/fs/fuse/fuse_i.h
> > +++ b/fs/fuse/fuse_i.h
> > @@ -345,6 +345,7 @@ struct fuse_args {
> >       bool is_ext:1;
> >       bool is_pinned:1;
> >       bool invalidate_vmap:1;
> > +     bool abort_on_kill:1;
> >       struct fuse_in_arg in_args[4];
> >       struct fuse_arg out_args[2];
> >       void (*end)(struct fuse_mount *fm, struct fuse_args *args, int error);
> > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > index e57b8af06be9..84f78fb89d35 100644
> > --- a/fs/fuse/inode.c
> > +++ b/fs/fuse/inode.c
> > @@ -1551,6 +1551,7 @@ int fuse_send_init(struct fuse_mount *fm)
> >       int err;
> >
> >       if (fm->fc->sync_init) {
> > +             ia->args.abort_on_kill = true;
> >               err = fuse_simple_request(fm, &ia->args);
> >               /* Ignore size of init reply */
> >               if (err > 0)
>
>
> I haven't looked at the other patches yet, so basically the mount can be
> aborted with ctrl-c, but no self abort in this patch yet.

This should work with all kinds of exit, since they ultimately
generate signals on all threads.

So the rest of the patchset are not even part of this fix, they are
just cleanups/improvements.

Thanks,
Miklos
