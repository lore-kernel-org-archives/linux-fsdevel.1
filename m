Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795186599;
	b=MLuREyoPyzopd8G539AObkSeTPJfpL79+c+0ogJ/czLuCn0FNO33MTyw5b/Km4appz8L
	 7EfDnTFt+wUVq6w3rR3KsfTTvU2unAgKQiFvnlTAAP+3MOtMR521QUDWQR8+c5dZmiJkh
	 E365jwAKpFqilu4djK+AP1ba+43EStxscKrd3Ud45Vl6XO/4ROh931v0U1lL8racQIL6H
	 D/2440vzzBE+0E3JAJcGUHece1jThefXer6gWHDP9PMQT72H79LCh2slQtFB2VM0QA9Ft
	 PiN2U+DYPmR1IeEfGZiiZKDoyhkxqR61kG2QzxioymxK4XVIMNv/7cet1E679cOwxMQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795186599;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=yo11Eu8FVAj7BGu1LSTgiAFkJHWFwxDpoxDkv06j5xE=;
	b=KlIbljogX27jgK2QK72E0A8W9JvfUFHH8S5htC2b4sS7lSG9wBKecDoRNfUxtJQ1e7+b
	 BiDNTnT2UvT9qeHeIw1o6s412ay5kMNxovwvI4uh6v8dXQvdmr1mziYtxZszIVnIQ8rrp
	 SBe8LjZWRDYddlk4/0pMwKWMXXC9axO5PoPn1jBgKU+dkdKbRE5FA9bww6WnxDtDHLl9X
	 iQd6ClY50f98fW2wNo6FeaRTa0w+jBA+7zTs0wR30CEJVEpCoti/KTIusb92kO4qOn/l4
	 bHb7+/4zuylHtmNBYQXdxoxY5WAP9AA6YQAkCDh5tCsfhysAC/XkpZLTzHUm+r/bxSw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SDjOLAM1;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=CtmTlrFm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9FB606A326
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 14:56:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A9FB606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SDjOLAM1;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=CtmTlrFm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795186597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yo11Eu8FVAj7BGu1LSTgiAFkJHWFwxDpoxDkv06j5xE=;
	b=SDjOLAM1l0pNx+Ot+8jdCcJ+s1mBhvKEKDRktA8EgMIjXbkT+gnvsppKPAEr5w+rCpUF+U
	b4KdhkBfofX2oKMVh8CaQHGSxo/Kw3+/I8ForQHRpb0GJbWsucD0bRykI9cQeYSUXnU1QB
	Agd2F4IPY/DmIkLvXpGFJLv/+Y2Rj6A=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-lB6EgJ2xOEeftBNpyBCxDA-1; Fri, 20 Nov 2026 14:56:36 +0000
X-MC-Unique: lB6EgJ2xOEeftBNpyBCxDA-1
X-Mimecast-MFC-AGG-ID: lB6EgJ2xOEeftBNpyBCxDA_1795186595
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-8b4d1cfe3cdso10236967b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 06:56:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795186595; cv=none;
        d=google.com; s=arc-20260327;
        b=rut6I0LWXtW/C3TfSDyYqLVDxutrDpnzHwKkTRLJ6pr61IMIFil3sm6thMDz/8XT3v
         NEXXhPZMIv9tGC2hWWULRBtaP6wPC+ofJmQPralNcaDg50JrnF5PtwLQjUq7YOUd12lM
         qj6H2LdEXKb8+q1EN0KRFSUi1pHCNYW+hfhiYazvCsMk4ldInQJ8yDwTRg0B5skc9UrA
         dqYAIwBERmTB8CvBfNo3gtQoKP6HS2kub4Nypi7+mxZwum+HSaMwCZ9FOzVsAPjttphN
         7+V2ndchj3g/tbYuWKddi+1q9iLcD2+cvWgV+o5eDNdkVTtHKd9mmh1F4OKhEybrVxSn
         l71A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yo11Eu8FVAj7BGu1LSTgiAFkJHWFwxDpoxDkv06j5xE=;
        fh=clytmMQDjYzqtRiYvvicTUPSkaGOW+R820252Qlx8gs=;
        b=qjKsjwWXzDIsVtt5ebdy5h3sTQuDwoZCgkksD4fKdqyIiDC8fJMn85uh+PO5PPxM7N
         TyD3AhGi9BYHfqSFLDVCIMIvzU2Z0n57ZTqeL+9Aq/1Xg1yQAffelEcHKErWq3j77DJl
         Ot2yRIa4Kf5u/1Gw3dKEWhexIYccskKeV/y9iKm1FFc+Uv/8RcngqLpLqZqcIZqm96Fi
         hcBU91KjwaRx2trYQM9BYNSillDUppVfDx5hnMUZ/qaQ6cyGAKfW+6WTDACxvBf2ZbO4
         SdXWZrKyjJ09yMxyAgot39KWBbjQDa1tyVEqHiLz3I/2M/QJfx4jBO6PG15XPjLa2CXR
         BFrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795186595; x=1795791395; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yo11Eu8FVAj7BGu1LSTgiAFkJHWFwxDpoxDkv06j5xE=;
        b=CtmTlrFmZQU2mZ/eZM2NR8asfuX6D2DCONAiCYRZPU8cuUA61PR0XBSbsDUMF2a5C7
         GRBbpGCrfH9c31jvTVhHBFwu5EpimnDfeTufNrZ3oG2Wqk8stnl90TPB0KQXE9DJOqTG
         CMC7DkvWun3uDFjpH7oEc5/NhrJSMx9k7WBEkCYwbZq+bl4sZluncePRd01tsV2+twc3
         a5OW2t5jZEtdzHQpoQEPWaeOAUKdKy4MRkSlSmoTqLFSZzHAoEyRcGNKTwA7i/61CM1U
         ZSSAKx/Lu8G2jJ+9ju29WyJFAT1BOVUms9+idCcGTLG3Yp2L4qSyy4xk6i96bfH2w2V2
         +4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795186595; x=1795791395;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yo11Eu8FVAj7BGu1LSTgiAFkJHWFwxDpoxDkv06j5xE=;
        b=tI9j2PdJpXZslU76nAWrfJkxUJo9guiIoMNmwV13FlNJU/1I0VoNs4WQ7hFgXZOq53
         xtAElYLl5lc3x2SyH81p0fwhL4LA9IErwj1bymndXjC2ustdHfzDss9DE5E3DOjCNnJw
         m2AzgII5hYHI9B+Swx+0+8Ywe6YdohUXqeopxcDVkPfvfOFe1kYPWgfXf5DLMG8hT4Ho
         x0yhvW48SNEnuos7mmiDsUkqMqtpI/QWzpKHeBmESOGCsEQNM91thtWTu1tCYhwNT6vq
         cGgGvEzElGYQ4A/pvpQ43wODk6HQAW2podHS2p62QK+vTRjsMTzyjh+xjqkqlNiLmsik
         S3jA==
X-Forwarded-Encrypted: i=1; AL+hErGvUMwQWwzMmrEyHZSLnVY2Sz512CDTpII00BahwKKrca6REL7JlfAoXyWjHWNvoQ20i6uUqTcGguwBk7vl@vger.kernel.org
X-Gm-Message-State: APuU4Z+/AYjiHVfixzYVhDS3WwYkS5e9pTMpjaAl3vzCCCM7xWoejknL
	5ZK5xxcy9BxaIuN2yK+DnnQU4rzB4ZMq6k3aFvwWhxP5zGAmVxEqsjILfSNLgU7/KGnOy8Kny9U
	976NUj3CmEFKWBn6tS2OvaNXqks7e5KM8ZlAiZgY02SOABIWtcdAEgnaV53JfFAigp88HEINf8L
	M5obeypWHYtOQ1nX1sYmp7bLQQ5QVb7oOI5yELzqgvKg==
X-Gm-Gg: AZFdTZfAyo3WXMrcKfANcd2KPr8CPzh5y77Shda6ALhRdiNQfSZxQ3oxq/hEtsvqmQv
	G6tW4Q51Nh22AYtk2HMMG6UillpV8X4KxACLObzI1sRlpr4Ooq4AA5UAX2vFJfMJ/EMIlYvP9mu
	z4PUI7l7QReVUW22h6Z9IdsEc5Un/1FvSBK2dfzmtPeO9DOCR9HEX6uIxSl4WZq3UnvyRsdIGlf
	Gq1Kh0t51IazI7Tc/+oEm6hDzEaoNH/F4psdki1i0fkuw==
X-Received: by 2002:a05:690c:296:b0:8ae:a9c6:2740 with SMTP id 00721157ae682-8b5204dbbf4mr17277147b3.48.1795186595319;
        Fri, 20 Nov 2026 06:56:35 -0800 (PST)
X-Received: by 2002:a05:690c:296:b0:8ae:a9c6:2740 with SMTP id
 00721157ae682-8b5204dbbf4mr17276957b3.48.1795186594739; Fri, 20 Nov 2026
 06:56:34 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120031305.3561045-1-huangsj@hygon.cn> <20261120031305.3561045-2-huangsj@hygon.cn>
In-Reply-To: <20261120031305.3561045-2-huangsj@hygon.cn>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Fri, 20 Nov 2026 15:56:23 +0100
X-Gm-Features: AclHuK-KPlGaYd21yj03z7EB2mPfkwiCHXM0MaDKxGgj2dWKdsX7kpdNXfvoeLg
Message-ID: <CAHc6FU7VUBLg=gX-xspFfp4jPffdH7Pc4oVx5nRDo7A3aiVWug@mail.gmail.com>
Subject: Re: [PATCH v3 01/11] vfs: add super_iter_inodes()
To: Huang Shijie <huangsj@hygon.cn>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	hch@infradead.org, mic@digikod.net, axboe@kernel.dk, gnoack@google.com, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, legion@kernel.org, 
	aleksa@amutable.com, libaokun@linux.alibaba.com, ebiggers@kernel.org, 
	djwong@kernel.org, sandeen@redhat.com, zhongyuan@hygon.cn, 
	fangbaoshun@hygon.cn, yingzhiwei@hygon.cn, wujianyong@hygon.cn, 
	shijie8@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 4:19=E2=80=AFAM Huang Shijie <huangsj@hygon.cn> wro=
te:
> Iterating the cached inodes of a superblock is open coded in the
> kernel. Add super_iter_inodes() for the callers which can work without
> holding the sb->s_inode_list_lock.
>
> For super_iter_inodes():
> -- By default, it runs @iter_fn with a referenced inode and with
>   sb->s_inode_list_lock dropped, so the callback is free to block and to
>   do whatever it wants with the inode except drop the reference the
>   iterator holds.
>
> -- Three flags change the default behaviour.
>
>   INO_ITER_F_REFERENCED restricts the walk to inodes which still have a
>   reference.
>
>   INO_ITER_F_NOREF does the opposite: only inodes whose reference count
>   has already reached zero are handed out.
>
>   INO_ITER_F_NOIGET tells the iterator do not call __iget for the inode.
>   Used with INO_ITER_F_NOREF in evict_inodes().
>
>   The flags are not orthogonal, so super_iter_inodes() warns if an unknow=
n
>   bit is set or if INO_ITER_F_REFERENCED is combined with either of the
>   no-reference flags.
>
> Signed-off-by: Huang Shijie <huangsj@hygon.cn>
> ---
>  fs/super.c                     | 87 ++++++++++++++++++++++++++++++++++
>  include/linux/fs/super_types.h | 29 ++++++++++++
>  2 files changed, 116 insertions(+)
>
> diff --git a/fs/super.c b/fs/super.c
> index c5a0658f7aaf..204c70c7f179 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -171,6 +171,93 @@ static void super_wake(struct super_block *sb, unsig=
ned int flag)
>         wake_up_var(&sb->s_flags);
>  }
>
> +static bool super_iter_check(struct inode *inode, int flags,
> +                            ino_iter_eligible_fn eligible, void *priv)
> +{
> +       bool ret =3D false;
> +
> +       if ((flags & INO_ITER_F_REFERENCED) && !icount_read_once(inode))
> +               return false;
> +       if ((flags & INO_ITER_F_NOREF) && icount_read_once(inode))
> +               return false;
> +
> +       spin_lock(&inode->i_lock);
> +
> +       if ((flags & INO_ITER_F_NOREF) && icount_read(inode))
> +               goto out_unlock;
> +
> +       if (inode_state_read(inode) & (I_NEW | I_FREEING | I_WILL_FREE))
> +               goto out_unlock;
> +
> +       if (eligible && !eligible(inode, priv))
> +               goto out_unlock;
> +
> +       if (!(flags & INO_ITER_F_NOIGET))
> +               __iget(inode);
> +
> +       ret =3D true;
> +out_unlock:
> +       spin_unlock(&inode->i_lock);
> +       return ret;
> +}
> +
> +/**
> + * super_iter_inodes - iterate all the cached inodes on a superblock
> + * @sb: superblock to iterate
> + * @iter_fn: called for each inode, with a reference held
> + * @eligible: optional filter, called before the reference is taken
> + * @priv: caller data, passed to @iter_fn and @eligible
> + * @flags: INO_ITER_F_* control flags
> + *
> + * This function iterates all cached inodes on a superblock that are not=
 in
> + * the process of being initialised or torn down. By default it runs @it=
er_fn
> + * with a valid, referenced inode, so it is safe for the caller to do an=
ything
> + * it wants with the inode except drop the reference the iterator holds.
> + *
> + * The flag INO_ITER_F_NOIGET changes that contract. It runs @iter_fn wi=
thout
> + * grabbing the inode with __iget().
> + *
> + * Return INO_ITER_RET_DONE if the iteration runs to the end.
> + * Return other value if the iteration breaks.
> + */
> +int super_iter_inodes(struct super_block *sb, ino_iter_fn iter_fn,
> +                     ino_iter_eligible_fn eligible, void *priv, int flag=
s)
> +{
> +       struct inode *inode, *old_inode =3D NULL;
> +       int ret;
> +
> +       WARN_ON_ONCE(flags & ~INO_ITER_F_ALL);
> +       WARN_ON_ONCE((flags & INO_ITER_F_REFERENCED) &&
> +                    (flags & (INO_ITER_F_NOREF | INO_ITER_F_NOIGET)));
> +
> +       spin_lock(&sb->s_inode_list_lock);
> +       list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
> +               if (!super_iter_check(inode, flags, eligible, priv))
> +                       continue;
> +
> +               spin_unlock(&sb->s_inode_list_lock);
> +
> +               if (!(flags & INO_ITER_F_NOIGET))
> +                       iput(old_inode);
> +
> +               ret =3D iter_fn(inode, priv);
> +
> +               old_inode =3D inode;
> +               if (ret !=3D INO_ITER_RET_NEXT)
> +                       goto out_loop;
> +
> +               cond_resched();
> +               spin_lock(&sb->s_inode_list_lock);
> +       }
> +       spin_unlock(&sb->s_inode_list_lock);
> +       ret =3D INO_ITER_RET_DONE;
> +out_loop:
> +       if (!(flags & INO_ITER_F_NOIGET))
> +               iput(old_inode);
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(super_iter_inodes);
> +
>  /*
>   * One thing we have to be careful of with a per-sb shrinker is that we =
don't
>   * drop the last active reference to the superblock from within the shri=
nker.
> diff --git a/include/linux/fs/super_types.h b/include/linux/fs/super_type=
s.h
> index 72f4288e16c5..974d3c087952 100644
> --- a/include/linux/fs/super_types.h
> +++ b/include/linux/fs/super_types.h
> @@ -80,6 +80,35 @@ enum freeze_holder {
>         FREEZE_EXCL             =3D (1U << 3),
>  };
>
> +/* Inode iteration callback return values */
> +#define INO_ITER_RET_DONE      0
> +#define INO_ITER_RET_ABORT     1
> +#define INO_ITER_RET_NEXT      2
> +
> +/* Inode iteration control flags */
> +/* Only iterate inodes that still have a reference. */
> +#define INO_ITER_F_REFERENCED  BIT(0)
> +/* Only iterate inodes whose reference count has reached zero. */
> +#define INO_ITER_F_NOREF       BIT(1)
> +/* Do not take a reference on the inodes handed to the callback. */
> +#define INO_ITER_F_NOIGET      BIT(2)
> +
> +/* REFERENCED and NOREF ask for opposite things, so only one may be set.=
 */
> +#define INO_ITER_F_ALL         (INO_ITER_F_REFERENCED | INO_ITER_F_NOREF=
 | \
> +                                INO_ITER_F_NOIGET)
> +
> +typedef int (*ino_iter_fn)(struct inode *inode, void *priv);
> +
> +/*
> + * Optional filter, called from inside the inode's i_lock and before
> + * __iget(), so that an inode can be rejected without paying for a
> + * reference.
> + */
> +typedef bool (*ino_iter_eligible_fn)(struct inode *inode, void *priv);
> +
> +int super_iter_inodes(struct super_block *sb, ino_iter_fn iter_fn,
> +                     ino_iter_eligible_fn eligible, void *priv, int flag=
s);
> +
>  struct super_operations {
>         struct inode *(*alloc_inode)(struct super_block *sb);
>         void (*destroy_inode)(struct inode *inode);
> --
> 2.53.0

Sorry to say, but this has gone quite a bit off course. Can you try a
construct like iomap_iter() instead?

Thanks,
Andreas

