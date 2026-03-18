Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA12E3B8BC7
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2026 09:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773827459; cv=pass; b=UJKwBHyrBHOEfQgLFWxax/T/LIhCxroHRadTberaG6JJJL+RvTGWQxD5e6AqBPRWvjr29pm5TOLl3TNsOn5wKMCFtywJpCnDWFJ4qAlPH9Qp26AdTKvTY4mdeFufIxdflqn7qG2NTGlQyHP/EUpVIfcslVpake5kQIxywDwE8k4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773827459; c=relaxed/simple;
	bh=qe/Mvna6SvB/mhACl4oTRvJAGn5NV83gGkjq0+1AQdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fROS1jnbTfosOkq7N+BnQbljo8n+MZ3fBq9tpWITz6KA2UwsizQAWc98KKHlYVisvLxBVZc4w8gdvtigfjdcjVKohDbwxlGiK6v/kEMFH1pWfJA0JhYWYR2yM8UynFaXLZ9MnZPMeZwce2AP3321FZU8cAOUpY9iqBoagVlxR5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=HqZMXjCa; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="HqZMXjCa"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50905b779dfso81367241cf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2026 02:50:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773827450; cv=none;
        d=google.com; s=arc-20240605;
        b=VJdu/t8yOrL0tL/1wKqtRILikT4bxy8jDK42ud2A9w8tfkzpzHo1XY9xcBWw1nRWCu
         graGFtkb6PXocIuIo6X1I6EiQhDTGnWZ/JQcM/bYC2S96WWiiqdnmDVpZv5H3XMYCsu9
         aSfDYrSUzgJewypncfg2jSL4AMiTWa77FSLydu1Y7ddKpFx2YNCnvnTOpKmQxEsSesFz
         uSwJxaf10yfPYjAcUCxDboPIPH0KOk5kaPg/1JaK/SnO2q9hZmnHPGs7fBVWsC4Lpo6U
         qsjVDPo+PyUUC/l2bp5WAZ5bPFRhXSSgTg38g+3AVTob6IIel3NvSrrCkI+3JnnLcTDx
         CwEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Rey+FlnqJyioIRxvqm44Uav5RoJSKdI9UnJXnJgeXpU=;
        fh=+Vlx1ug7X/QySlvPp8Fa6dyfnW3MOXe/65v3ub9PMQs=;
        b=F5MSmZ7Gtz83hN1ayMaVmy/87Fp38Aie669SCtwinH/lGrUvD2c0XBj+sKOEp2YqOW
         rYeTFTOlMfQk6+HPubsRN6W7SIHDHceBErmzHW9LvUN2gWl3OQ3Hg5rfZIBgBy/D/UOx
         cmHs5VUApJz5UdmJBclNyBoPAdlkgVtsG58ExqT2mNEtPoH5Ohqa7yvFjopET0xv/FLT
         6N5DLMuVy9Zav/SPOQd3l4jMTCi/yhuIbA8C+OUhciBUaFnfZAhlWwGxytGybdW9YtWv
         CoEeP1+d53JR0g8uTeMp0vM5FniI8heeQFl0xYLD/VoZi4pg8vVkafPXrYLrgz/AuR3c
         mw+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1773827450; x=1774432250; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rey+FlnqJyioIRxvqm44Uav5RoJSKdI9UnJXnJgeXpU=;
        b=HqZMXjCax7E+0qq37p1isK29HKMGwXOw7ygg4gqm1BT/P32MUcWNEEappH4q09ZVUh
         y8Yao/MylJ5gDFg16m5f8Y71QDrecf2FUH3MnpBTZn/ZY9tdCAMlsBjF6xyMGHiZKH/s
         SKlJ8LDeUgz15lMnesPEhadafXRnpxK5UjEUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773827450; x=1774432250;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rey+FlnqJyioIRxvqm44Uav5RoJSKdI9UnJXnJgeXpU=;
        b=I/46QKWzCipdey6gmRC8vsx95s6lRKL4giQ1NkmAb9uqg6BLmsvkZeNC97UUaTLG3j
         J0Gz8cryqkOme1hzeDGwxV79cX7uw79v3JDmoziRaTuKaZy8SthB/VVuf/HHgA4vaNWy
         780eqMcg12nDN8TsFbw2YmyUNSQDNsfHu3yCJNsyDTJ5E0F015PLlDu6IwUmUGCiMc1k
         XxgIpgYWjShDFrIAHrbp8KoAbSlmeqz3kerAYPZ3rCxwayLCA9glEMVL8X2WOKG5c2f0
         R2IwtBRtuPmPv9obN2R08fIGY3bteBDNy8JzDArdXBbFzYBofhuExl106nV4Je6MuEHZ
         aSeQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0tbrMfNqgrceiA+B1MROkgIujShivRK0CJj2UXxxRInT2/OrdfkR47H9BytbWKFEk7OqIQ20deIRP6n3b@vger.kernel.org
X-Gm-Message-State: AOJu0YwLflldb0wO5PxFhA/1IkrEed/S2tBQ6WiQlz7RGTTCkLq7k6Y9
	nUKXxVMQrDdgbNrM6rfOXQwHKmpqx1a+54q7qBEx1tnBRu8vhsgH1fObdCP+CZRh5M8j0qZMLXu
	TzeIBtmj7uh7ozdbWYVbath93A+EQiGENfkWnlgSl7g==
X-Gm-Gg: ATEYQzwFSpL9Fqy3Hv9wmu/HxKaoR5SbDnfRf2eQQWfeg4UGTsqUgO/FYbIxN+rQgFj
	ayK0JeNmpUcuKRFO9bmBQQ+ash0VhA71J4cm+2Dz/v0/KqP9djcw9yBf5RwvANjSExIFv8QJxAh
	ULRHR5iEfXpwuP6RT0dRWbBOUqSBqrMdEuDKNFFPeCFvNGkddMxz2Nw9p/T+snWv9PXaDL0/xxE
	sGSft/QHXy6KT97XVP4vkvGoOJbzaN1eNXziU6u0xaQUtCHXVERizKy22JYiFPy3s6ePnMigbUU
	KiDbzS1wKnin7B2KKt/ecGz60/WcvWQLBrV1+/dO
X-Received: by 2002:a05:622a:1813:b0:4b6:24ba:dc6a with SMTP id
 d75a77b69052e-50b14863dd8mr31318901cf.38.1773827450307; Wed, 18 Mar 2026
 02:50:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316165320.3245526-1-mszeredi@redhat.com> <20260316165320.3245526-4-mszeredi@redhat.com>
 <671ace3d-bac5-4024-9e14-62262244949c@bsbernd.com>
In-Reply-To: <671ace3d-bac5-4024-9e14-62262244949c@bsbernd.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 18 Mar 2026 10:50:39 +0100
X-Gm-Features: AaiRm5273yGMjSvoRC0FSNUFRaLx7BzsCXUwmUiWtgpOS6DZZbdpDyqNlLUj2bc
Message-ID: <CAJfpegvxhGDqCQuQQd6uf0+SOPzSnUJHy=tN68YehfUksGOCPw@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] fuse: add refcount to fuse_dev
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Mar 2026 at 23:16, Bernd Schubert <bernd@bsbernd.com> wrote:
>
>
>
> On 3/16/26 17:53, Miklos Szeredi wrote:
> > This will make it possible to grab the fuse_dev and subsequently release
> > the file that it came from.
> >
> > In the above case, fud->fc will be set to FUSE_DEV_FC_DISCONNECTED to
> > indicate that this is no longer a functional device.
> >
> > When trying to assign an fc to such a disconnected fuse_dev, the fc is set
> > to the disconnected state.
> >
> > Use atomic operations xchg() and cmpxchg() to prevent races.
>
> So the actual motivation is in fuse_fill_super_common() which checks if
> the file descriptor got closed during the mount? I.e. one thread mounts
> and another thread closes the fd for the mount?

Yes.
> > +/* fud->fc gets assigned to this value when /dev/fuse is closed */
> > +#define FUSE_DEV_FC_DISCONNECTED ((struct fuse_conn *) 1)
>
> Hmm, these things always give me a headache, because now all callers
> need to check for FUSE_DEV_FC_DISCONNECTED? Main protection is then vfs,
> which disallows device release when there are competing operations?

This value gets set on release, so all callers that hold a reference
to the device file can not see this value.

Only mount can, which will take a ref to struct fuse_dev and release
struct file.  In that case if the file is closed, then fud->fc will be
set to
FUSE_DEV_FC_DISCONNECTED, mount will check if fud->fc is set anyway
(since it could have been set by another mount or FUSE_DEV_IOC_CLONE)
and will return an error in that case (either -EINVAL or -ENOTCONN
depending on when excatly the dev fd was closed).

So in fact the actual value need not be checked anywhere, the only
place it *is* checked is fuse_dev_put(), but we could probably rework
virtiofs so that it cleans up the fc before calling fuse_dev_put().

Thanks,
Miklos
>
>
> > +
> >  /*
> >   * Lockless access is OK, because fud->fc is set once during mount and is valid
> >   * until the file is released.
> > + *
> > + * fud->fc is set to FUSE_DEV_FC_DISCONNECTED only after the containing file is
> > + * released, so result is safe to dereference in most cases.  Exceptions are:
> > + * fuse_dev_put() and fuse_fill_super_common().
> >   */
> >  static inline struct fuse_conn *fuse_dev_fc_get(struct fuse_dev *fud)
> >  {
> > -     /* Pairs with smp_store_release() in fuse_dev_fc_set() */
> > +     /* Pairs with xchg() in fuse_dev_install() */
> >       return smp_load_acquire(&fud->fc);
> >  }
>
> Minor nit: Pairs with cmpxchg?
>
> >
> > -static inline void fuse_dev_fc_set(struct fuse_dev *fud, struct fuse_conn *fc)
> > -{
> > -     /* Pairs with smp_load_acquire() in fuse_dev_fc_get() */
> > -     smp_store_release(&fud->fc, fc);
> > -}
> > -
> >  static inline struct fuse_dev *fuse_file_to_fud(struct file *file)
> >  {
> >       return file->private_data;
> > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > index 94b49384a2f7..230201dc3f90 100644
> > --- a/fs/fuse/fuse_i.h
> > +++ b/fs/fuse/fuse_i.h
> > @@ -577,6 +577,9 @@ struct fuse_pqueue {
> >   * Fuse device instance
> >   */
> >  struct fuse_dev {
> > +     /** Reference count of this object */
> > +     refcount_t ref;
> > +
> >       /** Issue FUSE_INIT synchronously */
> >       bool sync_init;
> >
> > @@ -1343,8 +1346,8 @@ void fuse_conn_put(struct fuse_conn *fc);
> >
> >  struct fuse_dev *fuse_dev_alloc_install(struct fuse_conn *fc);
> >  struct fuse_dev *fuse_dev_alloc(void);
> > -void fuse_dev_install(struct fuse_dev *fud, struct fuse_conn *fc);
> > -void fuse_dev_free(struct fuse_dev *fud);
> > +bool fuse_dev_install(struct fuse_dev *fud, struct fuse_conn *fc);
> > +void fuse_dev_put(struct fuse_dev *fud);
> >  int fuse_send_init(struct fuse_mount *fm);
> >
> >  /**
> > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > index c2d1184d5ba5..0e848e3a13c2 100644
> > --- a/fs/fuse/inode.c
> > +++ b/fs/fuse/inode.c
> > @@ -1623,6 +1623,7 @@ struct fuse_dev *fuse_dev_alloc(void)
> >       if (!fud)
> >               return NULL;
> >
> > +     refcount_set(&fud->ref, 1);
> >       pq = kzalloc_objs(struct list_head, FUSE_PQ_HASH_SIZE);
> >       if (!pq) {
> >               kfree(fud);
> > @@ -1636,12 +1637,32 @@ struct fuse_dev *fuse_dev_alloc(void)
> >  }
> >  EXPORT_SYMBOL_GPL(fuse_dev_alloc);
> >
> > -void fuse_dev_install(struct fuse_dev *fud, struct fuse_conn *fc)
> > +bool fuse_dev_install(struct fuse_dev *fud, struct fuse_conn *fc)
> >  {
> > -     fuse_dev_fc_set(fud, fuse_conn_get(fc));
> > +     struct fuse_conn *old_fc;
> > +
> > +     fuse_conn_get(fc);
> >       spin_lock(&fc->lock);
> > +     /*
> > +      * Pairs with:
> > +      *  - xchg() in fuse_dev_release()
> > +      *  - smp_load_acquire() in fuse_dev_fc_get()
> > +      */
> > +     old_fc = cmpxchg(&fud->fc, NULL, fc);
> > +     if (old_fc) {
> > +             /*
> > +              * failed to set fud->fc because
> > +              *  - it was already set to a different fc
> > +              *  - it was set to disconneted
> > +              */
> > +             spin_unlock(&fc->lock);
> > +             fuse_conn_put(fc);
> > +             return false;
> > +     }
> >       list_add_tail(&fud->entry, &fc->devices);
> >       spin_unlock(&fc->lock);
> > +
> > +     return true;
> >  }
> >  EXPORT_SYMBOL_GPL(fuse_dev_install);
> >
> > @@ -1658,11 +1679,16 @@ struct fuse_dev *fuse_dev_alloc_install(struct fuse_conn *fc)
>
> Shouldn't all callers, i.e. also  fuse_dev_alloc_install() and
> fuse_device_clone() check for success?
>
>
> >  }
> >  EXPORT_SYMBOL_GPL(fuse_dev_alloc_install);
> >
> > -void fuse_dev_free(struct fuse_dev *fud)
> > +void fuse_dev_put(struct fuse_dev *fud)
> >  {
> > -     struct fuse_conn *fc = fuse_dev_fc_get(fud);
> > +     struct fuse_conn *fc;
> >
> > -     if (fc) {
> > +     if (!refcount_dec_and_test(&fud->ref))
> > +             return;
> > +
> > +     fc = fuse_dev_fc_get(fud);
> > +     if (fc && fc != FUSE_DEV_FC_DISCONNECTED) {
> > +             /* This is the virtiofs case (fuse_dev_release() not called) */
> >               spin_lock(&fc->lock);
> >               list_del(&fud->entry);
> >               spin_unlock(&fc->lock);
> > @@ -1672,7 +1698,7 @@ void fuse_dev_free(struct fuse_dev *fud)
> >       kfree(fud->pq.processing);
> >       kfree(fud);
> >  }
> > -EXPORT_SYMBOL_GPL(fuse_dev_free);
> > +EXPORT_SYMBOL_GPL(fuse_dev_put);
> >
> >  static void fuse_fill_attr_from_inode(struct fuse_attr *attr,
> >                                     const struct fuse_inode *fi)
> > @@ -1901,8 +1927,10 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
> >       list_add_tail(&fc->entry, &fuse_conn_list);
> >       sb->s_root = root_dentry;
> >       if (fud) {
> > -             fuse_dev_install(fud, fc);
> > -             wake_up_all(&fuse_dev_waitq);
> > +             if (!fuse_dev_install(fud, fc))
> > +                     fc->connected = 0; /* device file got closed */
> > +             else
> > +                     wake_up_all(&fuse_dev_waitq);
> >       }
> >       mutex_unlock(&fuse_mutex);
> >       return 0;
> > diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> > index f685916754ad..12300651a0f1 100644
> > --- a/fs/fuse/virtio_fs.c
> > +++ b/fs/fuse/virtio_fs.c
> > @@ -486,7 +486,7 @@ static void virtio_fs_free_devs(struct virtio_fs *fs)
> >               if (!fsvq->fud)
> >                       continue;
> >
> > -             fuse_dev_free(fsvq->fud);
> > +             fuse_dev_put(fsvq->fud);
> >               fsvq->fud = NULL;
> >       }
> >  }
>
> Thanks,
> Bernd
>
