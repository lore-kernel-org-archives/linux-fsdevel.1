Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327962C032E
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Mar 2026 15:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774626063; cv=pass; b=rlO+4IXL55C15VSzqA76r5q2DsW7oHBdQ9W1NgMKzCLwdQ3OLp0390FrDLcLMn9cMsU+HFp8/k3SXRlpuq161JkTX/MbBlUkItKG9Nz2HQ5Sh9AZlUwasfotnJqDhewqjJeJOiikF/rLyUZSn6TaG7CFyVtJbGd/DCpMh3dmdIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774626063; c=relaxed/simple;
	bh=wnFgi90p5vfAcJe7rV/FKKdfr+gLRqA84j30W8iPIUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fPo+h+AHWgSdbwZzf2UzRuszCZrpOVNiNkb4xM5zB6pCzDzb8d+rw19P1n3SWt37VQp5VqLgfftb2GKbUPA0xm279qsYn8hxJBZRMb4RDFlpw24tWVYkqajKTC4c2CrFS3/FNvEvgsj/5T6ZfNcU/X8SNgzdh5xthbW1x4SqAA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZRyynXw; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZRyynXw"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43b40003d13so1603260f8f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Mar 2026 08:41:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774626060; cv=none;
        d=google.com; s=arc-20240605;
        b=HUL75ogjdSbm/8btot4k1IJN1JiYjrIoGkvBYNMA65ofEjKqiL2Na2b0b5b9NooVWX
         gF5k36WeQHgE0ZXShA6xjEpsLMQM1GxAxMtaa7zXOhVo78sSW3l9M1UEGpebg0WxIv8H
         5lkMD43+j4fTEpmE4+l9fO7LrXQOsFXkz8qv5LVCz+H5EwIlMdq1quiWtTVxpqP+HEgY
         hFydUVWsNI/ho33+WKKOe+XbSo9BIRlRO+C6hMhHNWlWFCGh7T9y3HuOhcI5WZ+r1lvR
         sBFLiBkUjlKUm3NJGs/Oqg0H2XNQLraZmeUV32xB3MMI3JMIuxGe0YvZLDBsdPf4dGBW
         JLqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AmNl+TGTscER1d+QRM0zLY/xjiN1rJqy2IgAM1B32Go=;
        fh=B7LVSu1n0VtNnD5HDmftVGz1h8K+Ses2nf3emaGr/Gs=;
        b=g9K5eNx8ptWbvmGhfMza+sYhLA1vKp/tyxhup19Q1c6S1T36w/jCYYMbq70mZJJMMl
         BcAOIuOpOBvowP7zV93Emvl0oUaB76Exc6RlYolwPPOALzmzbb4YKV7WJrIRSWxWhfJO
         gqI7YdV4emoBtUVINSp7IbDOD/nqTst1lAD2sj/fWoPDSnmvpbro+cMdmJkLc6aftVRh
         lm4MFUiEXpWWnU7iBMmJTTdbxdaNwVeo+fTKC4p1phBgWmEcw4+5bGBFkGvW1D7CbAW8
         85rZA0auxNuLloKzfKp8ZOe+jFTCrco0n9Qa7JWlaK+7J2CZllTxZG0UCzkimJzOifkk
         VDvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774626060; x=1775230860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AmNl+TGTscER1d+QRM0zLY/xjiN1rJqy2IgAM1B32Go=;
        b=HZRyynXwKPz0iotQfcEf1uqd38OAKoCv17WtLr5l6oxoTzGFynyyp+pCNNGtMSq8KM
         y5zcVffFEL3haUJKftnouaj5HcdmJgmvlaIzOeSlU9MW8ayr0AsCXovX2eiL9xypsara
         npVganVfxaGElzcI5tjF+IW1d/y8aNV37eAdtPLsv7eByC5c01ujuVaTEy4esslAtFP7
         ZZ0+d9r+25fMJEm+QtwE3CIGeFCaaUgskSJt8PowWRqwjHamqj83Tfz/p8aYhcXJqouA
         IMAE73UcXe3h0v6JwCwha+VG0zexHqila5eWba3bQ/kdK/OP3jsvzpc9HdxtOj98N05y
         0W9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774626060; x=1775230860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AmNl+TGTscER1d+QRM0zLY/xjiN1rJqy2IgAM1B32Go=;
        b=iLhZ65Uj0PB7UztDj4EmURupCOEBdquxmbQN2RFpnUbb3CPXhSNaSUYvTrAqLaJvG9
         AgHvqCg+b6y3rTTnHSyDnvNBWZe/hoMH6d6+jszrX7Ui7QF26DiDSY3kJj5U+yGNw4Lw
         ABzLEe1PMBpRRLsB24tQ8gmseKVCiKVNu519Re6PWd6uZhcSeEuZpTvfgT3+PkjNbXr0
         ObfFVli1CXdjVBBgzbrBe9Otlku+Bxz7dowWumsx9ZIR27QHRazOlCCaNtcgOiV6I+hZ
         ZxXRK8x0iztqal/5Gab3YdyoBq6kqmq1Jf5ILqsXIM0PwdudA9UH1tz082b+3zSEYKS8
         K0Nw==
X-Forwarded-Encrypted: i=1; AJvYcCWmtVbBMZg9eWppoDafkuCl2k2Thg+iRDsFaNqeFTrK9HuVQXg1+LoKPSRCIKrZmffSNkGMEi+gAUniIb4N@vger.kernel.org
X-Gm-Message-State: AOJu0YzFy/bj5oeFmTIh081WRiPSarM07AIx5nNynOMvJ2iwEjTWj4L8
	a9NIfchJIE3fmT8EmZYpK7LcUFkmfUFrPg5tA+3txDEhiAobLWpvpokkxd4Yxrm8QYsUQPpCMcX
	o8FOldqF9MHgYFP2JlZrsK07dK8sx26/bJv+w
X-Gm-Gg: ATEYQzzAQ2PJhYbsHyelt2KiliEbcXm8r8EIcOynHnixNltmWouIig/e9IDYgDMAnAW
	R3Kw/hx1JxPp8vDmAoXlMNpISN4iEYMv4tqnbYmHJbQAnTGwqVDi3H1I4TkacCUAnSlEhPC38a3
	6bcQYEevCdgfH7bMjIXkgnHdwKoCEEJ37PpZ6q2+9FnlZNtmuE6lGqBTD1Vqi+fCdYcQI35lhmL
	vwvf5T7BTKxUrK/5JxIAhSQ03NfVcRWWBEIAlUREaNyG5Ff50mBslW3AHFZ0dYN0cXu0MphQKPk
	+VNk3A==
X-Received: by 2002:a05:6000:2406:b0:439:b59e:5e6a with SMTP id
 ffacd0b85a97d-43b9e9e8424mr5088079f8f.14.1774626060269; Fri, 27 Mar 2026
 08:41:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327-fix-inode-init-race-v2-1-22b1757109f8@ddn.com>
In-Reply-To: <20260327-fix-inode-init-race-v2-1-22b1757109f8@ddn.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 27 Mar 2026 08:40:49 -0700
X-Gm-Features: AQROBzDOCwV5uD1bV76jbOFKrR98cl_gzi61PlzezLVbUndcEbK9zgqjL2n3oBw
Message-ID: <CAJnrk1YuxmmkqC+J5f=YyXoFeUgYZPsURyLdkzUJPBKK+CjcFw@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: fix inode initialization race
To: Horst Birthelmer <horst@birthelmer.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bernd@bsbernd.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 12:36=E2=80=AFAM Horst Birthelmer <horst@birthelmer=
.com> wrote:
>
> From: Horst Birthelmer <hbirthelmer@ddn.com>
>
> Fix a race between fuse_iget() and fuse_reverse_inval_inode() where
> invalidation can arrive while an inode is being initialized, causing
> the invalidation to be lost.
> By keeping the inode state I_NEW as long as the attributes are not valid
> the invalidation can wait until the inode is fully initialized.
>
> Suggested-by: Joanne Koong <joannelkoong@gmail.com>
> Signed-off-by: Horst Birthelmer <hbirthelmer@ddn.com>
> ---
> Changes in v2:
> - switch from waitq guided by attr_version to wait_on_new_inode() and unl=
ock_new_inode() when
> the inode is fully initialized
> - Link to v1: https://lore.kernel.org/r/20260318-fix-inode-init-race-v1-1=
-a7e58b2ddb9a@ddn.com
> ---
>  fs/fuse/inode.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index e57b8af06be93ecc29c58864a9c9e99c68e3283b..fa0adc2bbe58cee6f63153c60=
c401b78ec3695bf 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -470,6 +470,7 @@ struct inode *fuse_iget(struct super_block *sb, u64 n=
odeid,
>         struct inode *inode;
>         struct fuse_inode *fi;
>         struct fuse_conn *fc =3D get_fuse_conn_super(sb);
> +       bool is_new_inode =3D false;
>
>         /*
>          * Auto mount points get their node id from the submount root, wh=
ich is
> @@ -505,13 +506,13 @@ struct inode *fuse_iget(struct super_block *sb, u64=
 nodeid,
>         if (!inode)
>                 return NULL;
>
> -       if ((inode_state_read_once(inode) & I_NEW)) {
> +       is_new_inode =3D inode_state_read_once(inode) & I_NEW;
> +       if (is_new_inode) {
>                 inode->i_flags |=3D S_NOATIME;
>                 if (!fc->writeback_cache || !S_ISREG(attr->mode))
>                         inode->i_flags |=3D S_NOCMTIME;
>                 inode->i_generation =3D generation;
>                 fuse_init_inode(inode, attr, fc);
> -               unlock_new_inode(inode);
>         } else if (fuse_stale_inode(inode, generation, attr)) {
>                 /* nodeid was reused, any I/O on the old inode should fai=
l */
>                 fuse_make_bad(inode);
> @@ -528,6 +529,8 @@ struct inode *fuse_iget(struct super_block *sb, u64 n=
odeid,
>  done:
>         fuse_change_attributes_i(inode, attr, NULL, attr_valid, attr_vers=
ion,
>                                  evict_ctr);
> +       if (is_new_inode)
> +               unlock_new_inode(inode);
>         return inode;
>  }
>
> @@ -565,6 +568,9 @@ int fuse_reverse_inval_inode(struct fuse_conn *fc, u6=
4 nodeid,
>         if (!inode)
>                 return -ENOENT;
>
> +       /* Wait for inode initialization to complete */
> +       wait_on_new_inode(inode);

This isn't needed.

The fuse_ilookup() -> ilookup5() already waits on I_NEW.

Thanks,
Joanne

> +
>         fi =3D get_fuse_inode(inode);
>         spin_lock(&fi->lock);
>         fi->attr_version =3D atomic64_inc_return(&fc->attr_version);
>
> ---
> base-commit: f338e77383789c0cae23ca3d48adcc5e9e137e3c
> change-id: 20260318-fix-inode-init-race-a47a7ba4af1e
>
> Best regards,
> --
> Horst Birthelmer <hbirthelmer@ddn.com>
>
