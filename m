Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847C1362133
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 21:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790198712; cv=pass; b=XR1XsdWDpMmEV+P6raf+4P1Fmn2RbEY/oqMtmEQ03T/0sv85NOt5KXzSB4SiL0WLOQlGlsSkDnIblX9cx3AfzesXnqnqbOdrLx+WoPkXnrlaPEJ1Al/RPVNcKyFaVWuOeO0oX+HEpkREmkR4KGaA8p9P3+U46XDeNs9q/Q8Xv7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790198712; c=relaxed/simple;
	bh=bkVTSCkLT0wuGyhcbASfZiPY4mAxSuc/xbUBdowVvu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s7ewQADjYyLKZ0uQzhM3aF5QZ4xqPKysw4JfbH8ul+hTV+RLzy2HIyh/m4ZwYVZpTLWBn7vzIS1tmHPYFb063UN5qSUWUElBiebYU8EAvmCfcOmYbgwnfo5+WL9QRu0M4dw47Ms6geK7X41GPhSb64lrbjsiNfduAvZcB7DceJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZnJR/GQ0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ty49pJIn; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZnJR/GQ0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ty49pJIn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790198702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FamOGz2XlQ4xC0lCyRvFWnDAClLJ38P0+XqqK7f7PF0=;
	b=ZnJR/GQ00PNkDw3WLyUCnIdVAt3vR/cB5XisAXYJH859akKhiqHpffjOjOPyjz5LtU0QBO
	D+dMC/7XZK8I/Uw2fVF4WD301VvBQwTfqoo2V2MBXUf5fB0yp1qAg6cohleA0Jupds90YR
	nyXWXCULGhwBb0ED4q35BR9/PuaBZ/c=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-qujgS_vuNOaweg2jQOMeSg-1; Wed, 23 Sep 2026 17:25:01 -0400
X-MC-Unique: qujgS_vuNOaweg2jQOMeSg-1
X-Mimecast-MFC-AGG-ID: qujgS_vuNOaweg2jQOMeSg_1790198700
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-66cdb701595so1827969d50.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 14:25:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790198700; cv=none;
        d=google.com; s=arc-20260327;
        b=iITuOwEk2HqClhMNPvJTAEu3C9IouGNGwXuqTqUpAcfGKqLBmEAz9zTsriV3iPXzod
         TkY03RTlSFRs96EFhaCWtfuC/RTGjzZS3a3syp9YNh+C9fJyJY694Ay8XJufqGIOp7zG
         4Bm6N5gchItNKTG2wIsqih/wzw3GDmiDm46+8xR14FFml6h7bA5fY4S8sVfpspUieW9H
         e1QzrsQgHzG43taSVmb7KXqT24uZiXLIJMkOp9du4hfzKByMawR19DHBjUl8QVSMTljz
         tZ/poebp3JW95SDadap/FGKcd1bidulGRYXPmzL8EOcfn1dAioJQkbQki4aWZZY2+lpn
         Q6Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FamOGz2XlQ4xC0lCyRvFWnDAClLJ38P0+XqqK7f7PF0=;
        fh=gf1Ng78XeOlY2q+AQBrzDwmgC0C8qhrPQjq3qH/D+sw=;
        b=pORwwbmobnLhKfT8qRwW8CVWaR53P4Uef6KaYTNG4Nt/8+5jaAmFMaJ7+4yPsiyWMI
         Ao5VvbKzYn6nl5uyv0oYZqCv2U20gLWENfkZbiHbqX7pQuFra3hxUSAywvX7q94EsstR
         5SxyYfsGxAv0sRz3NimDX1/wLYdp8g7NYmNuyzbJdqD45IJ2RLTI8yRmhRASzBMCkL5k
         x73epY1HjDxBOyOpjf/UZQ/9usvFXfyWA+ug2+xmo1p0yuLBniOoe6e2ZyQNB8U+dpq9
         68dvAiiiT8RQe7bnSWS4QLFpPI28nEc7glMEirYTU0+lDN7Nr+sRoHgi3lT1bQk/uD5H
         VD7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790198700; x=1790803500; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FamOGz2XlQ4xC0lCyRvFWnDAClLJ38P0+XqqK7f7PF0=;
        b=Ty49pJInZWiGrpjQcrmJp5JdkOAC/eqLpNzqOBpaOYZgzKLZQkVQOVm3ZO16UmPcxs
         lgfKlkKaJqQbKjzRs6cbHC5Quuj0sDZEYkNHY7y5otXMdk02+fUAkjsbV+RhRPVston0
         ECClO3b+xTloacFT5pwwDx/zDtr+/RFesvWFOAirmjdrPI05htY4bNbjJvFXRlAm2RMm
         8ScRkgDEmhLh/X0l3IQXVHapBf4Iw0nVLtnrBcW6FsizhQzC/xp/mkY+8Xb1UCqJVHhJ
         O1GAKzdCLbNd0aEjZvP+JSi2cPjEUoE7dfz7l02GHEA7g6apsyzyWneNKSzrww9mSUA4
         BWuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790198700; x=1790803500;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FamOGz2XlQ4xC0lCyRvFWnDAClLJ38P0+XqqK7f7PF0=;
        b=DfAEEDxnK44Sr7zU3SEXdqtIichUB2chWituStLzRrylj7kYLj2Ny2FgxiJc1iMIWA
         FKdSB5t1IhQjyoIdpczU97ECA9XeBy7oDIEPpYxJ3NDV9haHAu4Plh7JI15m3MJJ/4qP
         0nMcQUjfypYYVfKZPAzI7m/i0vcb8TEevSQukdnu70EHUb9qLJKwq2ZCzDxdbVU7OLf2
         zNwDfsTYzuIYmORB+hKv3BIOowuRX/s1OSBwFH9jBWPjEL5hhhKXK4nT/S0N50xJFuk5
         XCrjQWiNLPkobNUdnQcD9p1aESI7m62Q9gvvKmUU60TsyICCeRxoDWHRCKe/3E1FQ6s4
         VSLg==
X-Gm-Message-State: AFuF++k5PmG6/9UmJejv3V8xgiYjqmtccf7NJrrDn7YvB/Qdtq0FIqR8
	Brdzyzsr3zF/6zZC6OPmGTcwixnA4hUPAwonUPKtlcSuZLqd015A9tT9rbg3yCTWn6ov+8oMlAb
	KFp45chAjGhm45qTP9WExIaFGkEKA2zIdD67uFMH1q0aUwrlXAExC+aNGz3oWOVxWjGdvD0hScQ
	2Z7bx43lWseEKrqDhVcBaeBiwHtm4L/7j1VC1iiBa+Yw==
X-Gm-Gg: AYBFou1ir1U8EqstknsOL9J99krbWxxqCW3Q4hJ7RxwTJjqNkRz8Mi/V5qZi5oow30z
	0p3AUSztdg0n6gozlBkiMTijZjtOnuXbI4nqqGyLD/rMik1PNhbBScX6TBGLSKpirEAIwmNQADC
	Vv+IYLS2hhnYommBiLPFrP187bYfPM3WNZsw604i9xNLy0cZ33ubj/QAfYy6N+RszaJlVOF/MiE
	QxIKwcOg2zbUVQyHOtp9PSITuN4bqLxfrWHES4N8VhGJw==
X-Received: by 2002:a05:690e:1486:b0:671:4cca:b8ce with SMTP id 956f58d0204a3-672ed341c62mr456310d50.61.1790198700230;
        Wed, 23 Sep 2026 14:25:00 -0700 (PDT)
X-Received: by 2002:a05:690e:1486:b0:671:4cca:b8ce with SMTP id
 956f58d0204a3-672ed341c62mr456294d50.61.1790198699257; Wed, 23 Sep 2026
 14:24:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911081309.14137-1-jack@suse.cz> <20260911085142.1774803-9-jack@suse.cz>
In-Reply-To: <20260911085142.1774803-9-jack@suse.cz>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Wed, 23 Sep 2026 23:24:48 +0200
X-Gm-Features: AcwNN1UUNn7Z0AbdqvvAesVcD7LzQJPt6i69kIPsPcPyFL4ciR1XZGgS4-FnymY
Message-ID: <CAHc6FU6YT4EzM8VDX8V0+dhfRJtSrtWxbuwht+b8HG5yzyq7Lw@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] fs: Add throttling to deferred inode reclaim
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@infradead.org>, 
	Mikhail Rudenko <xyzzy@yandex-team.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 10:51=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
> Deferring difficult inode reclaim from prune_icache_sb() to a workqueue
> removes the natural feedback loop of blocking tasks in direct reclaim
> until they make space for new allocations. This can result in the list
> of deferred inodes to grow beyond any bounds and possibly push the
> machine to a reclaim storm or OOM.
>
> Add a throttling mechanism slowing down tasks in
> mark_inode_reclaim_deferred() if the number of deferred inodes to
> reclaim for a superblock grows over limit. We measure average time it
> takes to reclaim inode on deferred list for a superblock and block tasks
> proportionally to that.
>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/inode.c                       | 102 +++++++++++++++++++++++++++----
>  include/linux/fs/super_types.h   |   2 +
>  include/trace/events/writeback.h |  51 ++++++++++++++++
>  3 files changed, 144 insertions(+), 11 deletions(-)
>
> diff --git a/fs/inode.c b/fs/inode.c
> index e902095cf39b..0491300c5ccb 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -1113,23 +1113,53 @@ static int get_inode_reclaim_batch(int *id, struc=
t list_head *list)
>         return count;
>  }
>
> +static void inode_reclaim_update_stat(struct super_block *sb, unsigned i=
nt n,
> +                                     u64 start)
> +{
> +       u64 delay;
> +
> +       if (!sb)
> +               return;
> +
> +       delay =3D div_u64(ktime_get_ns() - start, n);
> +       /*
> +        * Smooth delay updates with exponential moving average. Updates =
can
> +        * get lost if workers race but we don't really care.
> +        */
> +       WRITE_ONCE(sb->s_deferred_reclaim_delay,
> +                  (63 * READ_ONCE(sb->s_deferred_reclaim_delay) + delay)=
 / 64);
> +
> +       trace_inode_reclaim_update_stat(sb, n, delay,
> +                               READ_ONCE(sb->s_deferred_reclaim_delay));
> +
> +       /*
> +        * The elevated s_deferred_reclaim_count keeps sb alive until we =
drop
> +        * it
> +        */
> +       if (!atomic_sub_return(n, &sb->s_deferred_reclaim_count))
> +               wake_up_var(&sb->s_deferred_reclaim_count);
> +}
>
>  static void inode_reclaim_deferred(struct work_struct *work)
>  {
>         struct inode *inode;
>         LIST_HEAD(inode_batch);
> +       u64 start;
> +       int id, count;
> +       struct super_block *sb;
> +
>         /*
>          * We start with the list corresponding to the work but rolling a=
 dice
>          * would work as well
>          */
> -       int id =3D work - deferred_reclaim.work;
> +       id =3D work - deferred_reclaim.work;
>
>         while (1) {
>                 if (!get_inode_reclaim_batch(&id, &inode_batch))
>                         break;
> -               while (!list_empty(&inode_batch)) {
> -                       struct super_block *sb;
> +               sb =3D NULL;
>
> +               while (!list_empty(&inode_batch)) {
>                         /*
>                          * inode_batch list is private and I_FREEING flag=
s
>                          * protect us from anybody else trying to remove =
the
> @@ -1137,17 +1167,20 @@ static void inode_reclaim_deferred(struct work_st=
ruct *work)
>                          */
>                         inode =3D list_first_entry(&inode_batch, struct i=
node,
>                                                  i_lru);
> +                       if (inode->i_sb !=3D sb) {
> +                               inode_reclaim_update_stat(sb, count, star=
t);
> +
> +                               sb =3D inode->i_sb;
> +                               count =3D 0;
> +                               start =3D ktime_get_ns();
> +                       }
> +                       count++;
>                         list_del_init(&inode->i_lru);
> -                       sb =3D inode->i_sb;
>                         evict(inode);
> -                       /*
> -                        * The elevated s_deferred_reclaim_count keeps sb=
 alive
> -                        * until we drop it
> -                        */
> -                       if (atomic_dec_and_test(&sb->s_deferred_reclaim_c=
ount))
> -                               wake_up_var(&sb->s_deferred_reclaim_count=
);
>                         cond_resched();
>                 }
> +
> +               inode_reclaim_update_stat(sb, count, start);
>         }
>  }
>
> @@ -1183,14 +1216,61 @@ static void __init deferred_reclaim_init(void)
>         }
>  }
>
> +/*
> + * Size of deferred reclaim list from which we start throttling tasks cr=
eating
> + * inodes marked for deferred reclaim.
> + */
> +#define INODE_DEFERRED_RECLAIM_LIMIT 8192
> +
> +static void throttle_inode_deferred_reclaim(struct inode *inode)
> +{
> +       struct super_block *sb =3D inode->i_sb;
> +       unsigned int len;
> +
> +       /*
> +        * If inodes with deferred reclaim are accumulating too much, slo=
w down
> +        * tasks creating them. This doesn't provide any kind of guarante=
e on
> +        * the length of the deferred list since lots of inodes with
> +        * I_DEFER_RECLAIM can be already present in the inode cache and =
we
> +        * have no control when they reach the deferred list. But if the
> +        * pressure on the deferred list is sustained, the balance should
> +        * eventually be established.
> +        */
> +       len =3D atomic_read(&sb->s_deferred_reclaim_count);
> +       if (len > INODE_DEFERRED_RECLAIM_LIMIT) {
> +               u64 delay =3D READ_ONCE(sb->s_deferred_reclaim_delay);
> +
> +               if (!delay)
> +                       return;
> +               /*
> +                * Scale the delay based on how much we exceed the limit.=
 Wait
> +                * at most 4x as long as estimated time to reclaim the in=
ode.
> +                */
> +               len =3D min(len, 5 * INODE_DEFERRED_RECLAIM_LIMIT);
> +               delay =3D div_u64(delay * (len - INODE_DEFERRED_RECLAIM_L=
IMIT),
> +                               INODE_DEFERRED_RECLAIM_LIMIT);
> +               trace_mark_inode_reclaim_deferred_throttle(inode, len, de=
lay);
> +
> +               schedule_timeout_killable(nsecs_to_jiffies(delay));
> +       }
> +}
> +
>  void mark_inode_reclaim_deferred(struct inode *inode)
>  {
> +       bool throttle =3D false;
> +
>         if (inode_state_read_once(inode) & I_DEFER_RECLAIM)
>                 return;
>
>         spin_lock(&inode->i_lock);
> -       inode_state_set(inode, I_DEFER_RECLAIM);
> +       if (!(inode_state_read(inode) & I_DEFER_RECLAIM)) {
> +               inode_state_set(inode, I_DEFER_RECLAIM);
> +               throttle =3D true;
> +       }
>         spin_unlock(&inode->i_lock);
> +
> +       if (throttle)
> +               throttle_inode_deferred_reclaim(inode);

I would expect the throttling to happen when too many inodes marked
I_DEFER_RECLAIM are evicted, but not here. In my use case [*], inodes
would only require deferred reclaim intermittently, while they have
outstanding revokes. Once there are no more outstanding revokes, those
inodes can just be evicted directly.

[*] https://lore.kernel.org/linux-fsdevel/CAHc6FU4Rf9-r8m8SSb=3De0k0zyoFhQA=
djupHMWvT6rStBshntug@mail.gmail.com/T/#t

>  }
>  EXPORT_SYMBOL_GPL(mark_inode_reclaim_deferred);
>
> diff --git a/include/linux/fs/super_types.h b/include/linux/fs/super_type=
s.h
> index a41bd57fc2e6..6db5df6fd35f 100644
> --- a/include/linux/fs/super_types.h
> +++ b/include/linux/fs/super_types.h
> @@ -234,6 +234,8 @@ struct super_block {
>
>         /* Number of inodes queued for deferred reclaim */
>         atomic_t                                s_deferred_reclaim_count;
> +       /* Average time to reclaim one deferred inode */
> +       u64                                     s_deferred_reclaim_delay;
>
>         /* Number of inodes with nlink =3D=3D 0 but still referenced */
>         atomic_long_t                           s_remove_count;
> diff --git a/include/trace/events/writeback.h b/include/trace/events/writ=
eback.h
> index 4a9cfe458820..aec38eaeb10e 100644
> --- a/include/trace/events/writeback.h
> +++ b/include/trace/events/writeback.h
> @@ -881,6 +881,57 @@ DEFINE_EVENT(writeback_inode_template, sb_clear_inod=
e_writeback,
>         TP_ARGS(inode)
>  );
>
> +TRACE_EVENT(inode_reclaim_update_stat,
> +       TP_PROTO(
> +               struct super_block *sb,
> +               unsigned int n,
> +               u64 batch_delay,
> +               u64 avg_delay
> +       ),
> +       TP_ARGS(sb, n, batch_delay, avg_delay),
> +
> +       TP_STRUCT__entry(
> +               __field(dev_t,          dev)
> +               __field(unsigned int,   n)
> +               __field(u64,            batch_delay)
> +               __field(u64,            avg_delay)
> +       ),
> +
> +       TP_fast_assign(
> +               __entry->dev =3D sb->s_dev;
> +               __entry->n =3D n;
> +               __entry->batch_delay =3D batch_delay;
> +               __entry->avg_delay =3D avg_delay;
> +       ),
> +
> +       TP_printk("dev %d,%d batch size %u batch delay %llu ns avg delay =
%llu ns",
> +                 MAJOR(__entry->dev), MINOR(__entry->dev), __entry->n,
> +                 __entry->batch_delay, __entry->avg_delay)
> +);
> +
> +TRACE_EVENT(mark_inode_reclaim_deferred_throttle,
> +       TP_PROTO(struct inode *inode, unsigned int len, u64 delay),
> +       TP_ARGS(inode, len, delay),
> +
> +       TP_STRUCT__entry(
> +               __field(u64,            ino)
> +               __field(dev_t,          dev)
> +               __field(unsigned int,   len)
> +               __field(u64,            delay)
> +       ),
> +
> +       TP_fast_assign(
> +               __entry->ino =3D inode->i_ino;
> +               __entry->dev =3D inode->i_sb->s_dev;
> +               __entry->len =3D len;
> +               __entry->delay =3D delay;
> +       ),
> +
> +       TP_printk("dev %d,%d ino %llu deferred list len %u delay %llu ns"=
,
> +                 MAJOR(__entry->dev), MINOR(__entry->dev),
> +                 __entry->ino, __entry->len, __entry->delay)
> +);
> +
>  #endif /* _TRACE_WRITEBACK_H */
>
>  /* This part must be outside protection */
> --
> 2.51.0
>
>

Thanks,
Andreas

