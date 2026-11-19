Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795097855;
	b=KSK1iMQS0+jkYNneCa8n3YybVBr3BM5eyV6zVyVvbjp15PcsScNdL51uGzqBrmzqaXR/
	 kOdtcIshWJqoUy6GvJi+Cw73ShEt99rzgGhuL93ONGB1WstqgtTrL0aKX1dZouwPYNaJ5
	 01+I1EtK4omLRwBsfG2q/k3IW7wDekwAa79W6Ok5x+Rop3gwUBuKtmOUbAsaeMqL/eHDH
	 RzWOodjODybODK4SnGtz6Tr0CdgTyw9T7RqKBQQSS2e6Lt7wOM/Bq7VfrgscnjTP3q426
	 j+iahoP43hRSbh6TCxNQimnxnqNEPAumV0Mag9PxiiLWmW6DFFUF40xC0hI9y8FpplQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795097855;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=a0wuRDfCqI9H1yXKDYU9ffVxzYM0+S41Bo3dJny90cA=;
	b=AVv4uWPri0IdHRL0lNClPO4NtmNGB3XV7Nv5X2K070zWldb+EgbHDRbwBFAcM2ELG/I3
	 CZjz1Sn0W7I/CPWGatU6vcxidmX3JbD6blvWSi7owKxnE4UH9L/o0Z0uEBTH8/rb65N8e
	 7Y80+DpvcIVZFnGKWd7mloXXRkebjvpRiY8bCZYUSYmXyKi3E/DoeGZSKAK9PgdsPvJXK
	 j/sgvybFn/AUjCG0FNyMeZ9zDeIAIC6SlADO7915yA0E3Bq98sSpFIIEKbjQTbNf6Upsg
	 DBULtQiJiqKtkgngQ+H4t97I67CqqQWqRt01Dnknx8l1Wn8dDJCbaNfNSpG/gNA5VyA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TbGqy1fR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087E1606A339
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 14:17:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 087E1606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TbGqy1fR
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b887ca9f5cso1833238a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 06:17:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795097853; cv=none;
        d=google.com; s=arc-20260327;
        b=BeYt7gXolCR9Nd0+PUl1U9kx3/kMayqHx8I+VpQA98FKs70CfD6/dsIIQ76jzN6XFI
         5kZ521cIGe9a1oQ+lai545+z9qzXbom0ujmm7MHH5/A7FghLCMZYRAIqa8bMx36uyTQQ
         tmi5db9aqQztjK7I5R8U+H6pKKJtnYDW/z5G5dr2Y34ENFeqiPzkQUr8pinQCmrFc1cj
         xcfDS44uPICdI7QxxnN9NcK9q32wkyMxRynXx6hECvYyHzOjSfz1nZSGdL7tjbJJL2No
         iMcJzvpM2o7CUqcgwSpWXP/99y8cXv1tx3LW0Ns+qreK5BcaAtwo1LesSLzdo2rGHTWf
         PDvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a0wuRDfCqI9H1yXKDYU9ffVxzYM0+S41Bo3dJny90cA=;
        fh=yBmwDc3W0cfV5GrOOhFG8NEIUTbM/dnsZa3D/RpW+Hg=;
        b=VlDQI1PG3TcFA85rN4GB8rM6f2TmiKRqE6aTvXwA+k5nogOPwVCJWwJkZNiUlaKig0
         nMkepHd0IBBvJkggUkhGBsfNK9QEJvvIqY8Pp6S0iEO2ctBn75rkhSi83Kd5RzFS2Cia
         vwGfQTIXy4lcnt9VU/fsn/6f83XOJc7yVOEuLq0K/IxgQGKgMPWP3F8dpxE7RVSJZT3g
         BFFIRTZzUx4CzjaLDIe7fw6Lp48VbJgjzMyXls4b0fAcfMQBB7kqF1qlHzD66ckPEfA+
         EYUjfcJ9uKN8Di4RcDexhZuvh4dASJ9TyZHeP+IUn5CAY4ASN6alQ0rFtcd3ibF2RXCL
         z0Zw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795097853; x=1795702653; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=a0wuRDfCqI9H1yXKDYU9ffVxzYM0+S41Bo3dJny90cA=;
        b=TbGqy1fRVKgwF2lZaswTfp3fokRXgv8XWxCTnSKNQvTtTRphn8ZCJfjk6bUa/Qx1BZ
         qZnEED/So4mIQd6Sr/qpNVamWkY0xMRCdoGtLZ1XTK5hFhKjhBu2rQSPHM6LzP7+pgQ9
         0rGu7OQOMr3M7/94bnSZL8OHWDeSlJe6Sfyj1YYiOpNKqIOe4+6YjDw4KiGqR1IwZxYB
         mBVvUjf2St34KYwwp5cD8OvIuQU0GN0hGHsndcf+8CKVQNdYZzzc7VJplmzUnUNjJTly
         f/HT3Z0EMjSs/OmaV9rlYCX5HUpDq8a4oL0zeaKeOqrLsetJhPwjhVHplP+/iIXL5PF8
         PqHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795097853; x=1795702653;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a0wuRDfCqI9H1yXKDYU9ffVxzYM0+S41Bo3dJny90cA=;
        b=dn8x/R78yn3x2Tyq8Ng+sCKre/kxclofgQ8EtCOqQwRg+hDXRPrx/Xg0PUBVSaekVY
         gIp4yGibERGJDGUn72PgFpqIIr2sIPRu41Hf1MiUq/MMjhioVGQ2FtbuiyB8JQ2vOZXZ
         YI1w9q4N/zTaB8u+nSI7ZyjVyMduY/RUXCmPoe3LjhgOElR1jO1lhsFul0ut5ko1ejaX
         xfcbYuVFK+zgqCZcdDN86bRH+bHbop4AxTWHMNKpgIbqSR0lATQnCsPYCoUQ2Up3m/Rj
         3n3ez8JZtfKNpYjOTY3RsVJfVm1OB9l2KIN/+45FCR+kSCRv0YmaKne5ogIR/R0Qa1Mi
         LVrg==
X-Forwarded-Encrypted: i=1; AL+hErEHdvFi66FJqhGY/6e3qDOzcZdehOYgOrRqFCt9s562mxGufMxsBmCDakGpUNTGfau1Ac1LlyJPY4vppSV9@vger.kernel.org
X-Gm-Message-State: APuU4Z/ddLxaFtjDgsAFckTKWRcODBmHvxeIKdEmLFUiVNjw3i8K0p7I
	6PENFth5gd8ei8H2WnzXYGQG2XtcAee1EQf41YYNdpmnKCW5lRY9nJpDYwf2s0YiuH9Ym+FnwbQ
	DczJIwOfNiCtvt2n0B2nUAEOznW06UWY=
X-Gm-Gg: AYBFou3DWHKy+Pwg5oh3mqVOQtX9ZEZvd7GM81o8VqLNRv2PNcTb6W6e6V2uEv1ESpu
	kSl2tunla1sskM3NEZMM6M+gobe1L0P+cg3XTEL3FI/htGiCz5/gThR0x3898mRoRMWxktsI1d7
	FcBvl4uglZFR98/fNTD3FqSdRlPdwn4Dma7FKjN1WF5WtW5nk1UBnOq3vQXBV7AJPQEe/t4ucuu
	0U+HW0FvHFP0qE36hIPzdDkjvLKNLaxHLyeAygLMKei76OW948lM10q1C/6Zf9kDbqY15Qw1P7b
	WHAWdHREELoL/J4QjQSRZkJwWHytVdZRiwSGVg3O4zlbWGnRDcLSrcKC7WZUH3p7drKi8d2TQXS
	H7qYVzqlWeuNGf7RSV+Evze1F0aTDfxcp0Ruxa7ODGw+PMMhb696GFqJaCaQVS/jF/gMxIBsoOb
	wmah4QM9CqPjIptSs=
X-Received: by 2002:aa7:c1c7:0:b0:6b8:6923:91e3 with SMTP id
 4fb4d7f45d1cf-6b887ef17admr3757230a12.7.1795097853003; Thu, 19 Nov 2026
 06:17:33 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119025942.2848130-1-neilb@ownmail.net> <20261119025942.2848130-5-neilb@ownmail.net>
In-Reply-To: <20261119025942.2848130-5-neilb@ownmail.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 19 Nov 2026 15:17:21 +0100
X-Gm-Features: AclHuK8T6bEqIG7WMipfNp1tO_FH1yaTNDotviQIju2dOKQkw2iC5zD9XaDKryQ
Message-ID: <CAOQ4uxgan=mpQ9yHOyZwZZp8E69+oH3uaPJ5CBkP7Z5BCO-5jA@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] Add d_for_each_positive_child family of iterators
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Kent <raven@themaw.net>, Jake Edge <jake@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 4:00=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote=
:
>
> From: NeilBrown <neil@brown.name>
>
> Provide iterators for the d_children/d_sib lists.  These iterators only
> report dentries that are positive (though they could be negative by the
> time they are used).  As DCACHE_DENTRY_CURSOR dentries are never
> positive they are never reported.
>
> d_for_each_positive_child() takes the parent lock and sets the iterator
> to each positive child in turn.
>
> d_for_each_positive_child_continue() can continue after an existing
> dentry, or (when initialised to NULL) behave like
> d_for_each_positive_child().  This requires that something prevent the
> start dentry from being moved before
> d_for_each_positive_child_continue() can take the parent lock -
> typically ->i_rwsem.
>
> The use of scoped_guard() in these macros makes it safe to "break" or
> "goto" out of the loop - the lock will be dropped in that case.
>
> As there are reports that large numbers of negative dentries can lead to
> soft lockups when walking the d_children/d_sib list, particularly in
> fsnotify_set_children_dentry_flags(), we call cond_resched() as needed
> during the walk.
>
> To achieve this we use an on-stack dentry (about 330 bytes) to place a
> cursor while calling cond_resched().  On-stack dentries are not standard
> practice but should be safe since
>
> Commit 3df5153c5f12 ("make cursors NORCU")
>
> made cursors NORCU, confirming that they can safely be released without
> waiting.  Also importantly nothing ever takes a reference on a cursor
> that it doesn't own.
>
> To facilitate this, a new __d_init() is split out of __d_alloc() and
> used in d_init_cursor() which can be called on an on-stack dentry as is
> done in the new d_next_sibling_sched().
>
> Link https://lwn.net/Articles/1079407/
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/dcache.c            | 119 ++++++++++++++++++++++++++++++++++-------
>  include/linux/dcache.h |  67 +++++++++++++++++++++++
>  2 files changed, 166 insertions(+), 20 deletions(-)
>
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 0dc54ba31d8c..bacb218400a8 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -1950,6 +1950,27 @@ void d_invalidate(struct dentry *dentry)
>  }
>  EXPORT_SYMBOL(d_invalidate);
>
> +static void __d_init(struct dentry *dentry, struct super_block *sb)
> +{
> +       dentry->d_flags =3D 0;
> +       lockref_init(&dentry->d_lockref);
> +       seqcount_spinlock_init(&dentry->d_seq, &dentry->d_lock);
> +       dentry->d_inode =3D NULL;
> +       dentry->d_parent =3D dentry;
> +       dentry->d_sb =3D sb;
> +       dentry->d_op =3D sb->__s_d_op;
> +       dentry->d_flags =3D sb->s_d_flags;
> +       dentry->d_fsdata =3D NULL;
> +       INIT_HLIST_BL_NODE(&dentry->d_hash);
> +       INIT_LIST_HEAD(&dentry->d_lru);
> +       INIT_HLIST_HEAD(&dentry->d_children);
> +       dentry->waiters =3D NULL;
> +       INIT_HLIST_NODE(&dentry->d_sib);
> +
> +       lockdep_init_map(&dentry->dep_map, "DCACHE_PAR_LOOKUP",
> +                        &sb->s_type->d_lookup_key, 0);
> +}
> +
>  /**
>   * __d_alloc - allocate a dcache entry
>   * @sb: filesystem it will belong to
> @@ -1959,7 +1980,6 @@ EXPORT_SYMBOL(d_invalidate);
>   * available. On a success the dentry is returned. The name passed in is
>   * copied and the copy passed in may be reused after this call.
>   */
> -
>  static struct dentry *__d_alloc(struct super_block *sb, const struct qst=
r *name)
>  {
>         struct dentry *dentry;
> @@ -1991,14 +2011,14 @@ static struct dentry *__d_alloc(struct super_bloc=
k *sb, const struct qstr *name)
>                 p =3D kmalloc_flex(*p, name, name->len + 1,
>                                  GFP_KERNEL_ACCOUNT | __GFP_RECLAIMABLE);
>                 if (!p) {
> -                       kmem_cache_free(dentry_cache, dentry);
> +                       kmem_cache_free(dentry_cache, dentry);
>                         return NULL;
>                 }
>                 atomic_set(&p->count, 1);
>                 dname =3D p->name;
>         } else  {
>                 dname =3D dentry->d_shortname.string;
> -       }
> +       }
>
>         dentry->__d_name.len =3D name->len;
>         dentry->__d_name.hash =3D name->hash;
> @@ -2008,23 +2028,7 @@ static struct dentry *__d_alloc(struct super_block=
 *sb, const struct qstr *name)
>         /* Make sure we always see the terminating NUL character */
>         smp_store_release(&dentry->__d_name.name, dname); /* ^^^ */
>
> -       dentry->d_flags =3D 0;
> -       lockref_init(&dentry->d_lockref);
> -       seqcount_spinlock_init(&dentry->d_seq, &dentry->d_lock);
> -       dentry->d_inode =3D NULL;
> -       dentry->d_parent =3D dentry;
> -       dentry->d_sb =3D sb;
> -       dentry->d_op =3D sb->__s_d_op;
> -       dentry->d_flags =3D sb->s_d_flags;
> -       dentry->d_fsdata =3D NULL;
> -       INIT_HLIST_BL_NODE(&dentry->d_hash);
> -       INIT_LIST_HEAD(&dentry->d_lru);
> -       INIT_HLIST_HEAD(&dentry->d_children);
> -       dentry->waiters =3D NULL;
> -       INIT_HLIST_NODE(&dentry->d_sib);
> -
> -       lockdep_init_map(&dentry->dep_map, "DCACHE_PAR_LOOKUP",
> -                        &sb->s_type->d_lookup_key, 0);
> +       __d_init(dentry, sb);
>
>         if (dentry->d_op && dentry->d_op->d_init) {
>                 err =3D dentry->d_op->d_init(dentry);
> @@ -2041,6 +2045,81 @@ static struct dentry *__d_alloc(struct super_block=
 *sb, const struct qstr *name)
>         return dentry;
>  }
>
> +/**
> + * d_init_cursor - initialise an on-stack dentry cursor
> + * @dentry: the dentry to be initialised
> + * @parent: dentry of parent where cursor will be used.
> + *
> + * A DCACHE_DENTRY_CURSOR is initalised for use in marking
> + * a place in the d_children/d_sib list.  While sb-related
> + * fields are filled in, they should never be used.
> + * The filesystems d_init is not called and a final d_put()
> + * should not be called, else d_release would be called.
> + */
> +static void d_init_cursor(struct dentry *dentry, struct dentry *parent)
> +{
> +       const struct qstr *name =3D &slash_name;
> +       char *dname;
> +
> +       /*
> +        * We guarantee that the inline name is always NUL-terminated.
> +        * This way the memcpy() done by the name switching in rename
> +        * will still always have a NUL at the end, even if we might
> +        * be overwriting an internal NUL character
> +        */
> +       dentry->d_shortname.string[DNAME_INLINE_LEN-1] =3D 0;
> +       name =3D &slash_name;
> +       dname =3D dentry->d_shortname.string;
> +
> +       dentry->__d_name.len =3D name->len;
> +       dentry->__d_name.hash =3D name->hash;
> +       memcpy(dname, name->name, name->len);
> +       dname[name->len] =3D 0;
> +
> +       /* Make sure we always see the terminating NUL character */
> +       smp_store_release(&dentry->__d_name.name, dname); /* ^^^ */
> +
> +       __d_init(dentry, parent->d_sb);
> +       dentry->d_parent =3D parent;
> +       dentry->d_flags |=3D DCACHE_DENTRY_CURSOR | DCACHE_NORCU;
> +}
> +
> +/**
> + * d_next_sibling_sched - return next sibling, but schedule() first
> + * @child:  current child
> + *
> + * This behaves like d_next_sibling(), but drops the parent d_lock
> + * and calls cond_resched() to avoid any soft-lockup.  A cursor
> + * is inserted as place holder.
> + *
> + * Caller must hold the parents d_lock, and must hold a counted
> + * reference on the parent.
> + *
> + * Returns: the next sibling, or %NULL if there is none.
> + */
> +struct dentry *d_next_sibling_sched(struct dentry *child)
> +__must_hold(&child->d_parent->d_lock)
> +{
> +       struct dentry cursor;
> +
> +       /* always skip cursors to ensure we make some real progress */
> +       while (child && (child->d_flags & DCACHE_DENTRY_CURSOR))
> +               child =3D d_next_sibling(child);
> +       if (!child)
> +               return child;

Why is this skip loop here and not after the resched?

As this is written, if the caller passed @child which is another cursor,
now child the next real dentry after another cursor and hlist_add_behind()
below will insert our cursor after the real dentry.

Thanks,
Amir.

> +
> +       d_init_cursor(&cursor, child->d_parent);
> +       hlist_add_behind(&cursor.d_sib, &child->d_sib);
> +       spin_unlock(&cursor.d_parent->d_lock);
> +       cond_resched();
> +       spin_lock(&cursor.d_parent->d_lock);
> +       child =3D d_next_sibling(&cursor);
> +       d_detach_cursor(&cursor);
> +       WARN_ON(d_count(&cursor) !=3D 1);
> +       return child;
> +}
> +EXPORT_SYMBOL(d_next_sibling_sched);
> +
>  /**
>   * d_alloc - allocate a dcache entry
>   * @parent: parent of entry to allocate
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index fff8393ec06b..7150ecd81d72 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -692,6 +692,73 @@ static inline struct dentry *d_next_sibling(const st=
ruct dentry *dentry)
>         return hlist_entry_safe(dentry->d_sib.next, struct dentry, d_sib)=
;
>  }
>
> +struct dentry *d_next_sibling_sched(struct dentry *child);
> +
> +static inline struct dentry *d_next_positive(struct dentry *child)
> +{
> +       do {
> +               if (need_resched())
> +                       child =3D d_next_sibling_sched(child);
> +               else
> +                       child =3D d_next_sibling(child);
> +       } while (child && !d_is_positive(child));
> +       return child;
> +}
> +
> +static inline struct dentry *d_first_positive(const struct dentry *paren=
t,
> +                                             struct dentry *child)
> +{
> +       if (!child)
> +               child =3D d_first_child(parent);
> +       else
> +               child =3D d_next_sibling(child);
> +       if (child && !d_is_positive(child))
> +               child =3D d_next_positive(child);
> +       return child;
> +}
> +
> +/**
> + * d_for_each_positive_child - iterate over positive children in the dca=
che
> + * @child: iterator dentry
> + * @parent: dentry of parent
> + *
> + * Iteratively set @child to each positive child of @parent.
> + * @parent->d_lock should NOT be held.
> + * @child may no longer be positive when the caller examines it
> + * so care is still needed which could involve locking the child
> + * or using d_inode_rcu() to access the inode.
> + *
> + * DCACHE_DENTRY_CURSOR dentries will never be returned, only true child=
ren
> + * which have at some point in the past been positive.
> + */
> +#define d_for_each_positive_child(child, parent)                       \
> +       if (({might_sleep();0;})) ; else                                \
> +               scoped_guard(spinlock, &parent->d_lock)                 \
> +                       for (child =3D d_first_positive(parent, NULL);   =
 \
> +                            child;                                     \
> +                            child =3D d_next_positive(child))
> +
> +/**
> + * d_for_each_positive_child_continue - iterate over remaining positive =
children
> + * @child: iterator dentry and starting point.
> + * @parent: dentry of parent
> + *
> + * If @child is %NULL this behaves identically to d_for_each_positive_ch=
ild().
> + * Otherwise @child must be an existing child of %parent and subsequent =
children
> + * in the d_children list of @parent are returned.
> + *
> + * Safely using this requires that something prevents @child from being
> + * renamed to a different directory before we get the lock.  Holding
> + * i_rwsem on the @parent is sufficient.
> + *
> + */
> +#define d_for_each_positive_child_continue(child, parent)              \
> +       if (({might_sleep();0;})) ; else                                \
> +               scoped_guard(spinlock, &parent->d_lock)                 \
> +                       for (child =3D d_first_positive(parent, child);  =
 \
> +                            child;                                     \
> +                            child =3D d_next_positive(child))
> +
>  void set_default_d_op(struct super_block *, const struct dentry_operatio=
ns *);
>  struct dentry *d_make_persistent(struct dentry *, struct inode *);
>  void d_make_discardable(struct dentry *dentry);
> --
> 2.50.0.107.gf914562f5916.dirty
>
