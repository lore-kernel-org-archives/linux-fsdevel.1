Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793081301;
	b=2+YbMowJsXCGp7VavLFSpW3OTZ1IsG4jQNliptKPTRF0I0FY8yFM3SkGhZrDAETRZjbI
	 JHSBSUwjNqadO4yP81TWQSdHPn/hB0ibU9UQIpvFLhGuDBiLbF1OjxZBYdmWXrGv87Ohk
	 qDBwaqm/BzWy7w2U5U1LgzvtGNaoVfgz3ccaZ1kDe9k9p8bm2M2/k21hJRDqJ6G7H0kPQ
	 G+hvFK6umG3nq5G16v5wDQqozyLgcctLRns3lH5hPBOrKzeWC5lvCEWBxo51ODZGwCwDb
	 4mIfiiYB82IXPLGXGYR6GVQD968y0CG6ZwaR4J5FWdqD4/v1JlqYbOjynCzOWzv+vdw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793081301;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=IgVNByFGNRaDuTcdCs60CTVgTyCqbZsDVgz3gl4WIHU=;
	b=oT3Z+yC+XeIURQhucaQVIeiEnOmLiaxDga050r9eibk4INJDkBFsJs/ryrXXUx6vomTN
	 qJVQYcnxIXa44s0TrMYy7+k+NAyF/httzWGTgKQ8LKCB8jjOkCmR00l+I2H+TDxAGJhBv
	 52HDc9W+VQfQAT/TNLbjjcKfyha73HNpCATlJmYPByIya0shGVdt57yQvlJpxoLttywU1
	 WIproHXdD3rsN1OrQ3tLgxdCZIVIVlogyyDOh3EvYMWyImxqKEGGMxwxES8EQhRpKjgzf
	 YGRi2ea6lRWjcCweKvhstvOwPQ8NilmKCkyqC9I4MsuK9LsknC3Du9IK3FB/CzWfoSw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=spSJsJOD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.44
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5F9606A322
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 06:08:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E5F9606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=spSJsJOD
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-677bc4704cbso3666183d50.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2026 23:08:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793081300; cv=none;
        d=google.com; s=arc-20260327;
        b=BFstn6sJtAdaCULBD5X1hb295akqj/ESQB58WM76I3KijM8spe73m5RWHlwXfOcXaG
         6vJyZ/DuhpMAzs71HWUPj2QIw24YpQ8DT7sUEEjvAk97cnLzqfU7Wsy7MtawK1Z9IMXF
         UFSqAAuUd81s619H0gOs3N9Tr0P1QzvhvOQluBZ5Nr2w3SyS4tRS0ZZgc7fbVWqcB7rr
         IhtzJc4amIxqchAeFg/WvRchDZKp3u3BfgpoNwO73P02zIiDLVv0BS5PeRwNo2j4AAXZ
         fLSf6MFxY3jR5E0FVUbqqqTECyvf2AwOozugDNA6/JUp3tzgCkorw8G02WtB3N3zyToD
         qfzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IgVNByFGNRaDuTcdCs60CTVgTyCqbZsDVgz3gl4WIHU=;
        fh=kgnGd67otD6WyyScellJ7CXI3E3N25g53Wa5kIWgpVU=;
        b=ZKUoO2zNWhnQ6izufjsINNkQYHbWkPRqPHhIUc+CUhZq6tqe/pm+kgQ30CsND4xso1
         M5Z2LtJ4c2bX6k+gVqAR20Ttvw684TlMMuSGCHZjiCZAqLr07Vvf3ezXWZ0Ac4WC2yxv
         bjKP8qpRfAz2CMZ1qZZlJr7Oo1GZWsPdWBxjXAteBO3fM/1Je9sL5lS1CtYpGIaggTp8
         sL66JhDxeyW2ipd234CcPl+QpW547ypfmomQjGPn/00/7KS7sFsd2oDxyXkjB3ewTCRp
         RLsIrw/YWCp9IMjo/JiDQxQfK971mKuvFpkMa4ZAn+vJld1f7mk/cm1nX56NKvcEgF5T
         mzUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793081300; x=1793686100; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IgVNByFGNRaDuTcdCs60CTVgTyCqbZsDVgz3gl4WIHU=;
        b=spSJsJODQApZkYTCD7i5i5bfJ0DnEh9cMjH6hMje7yLZpdTQ+zgch04XefdBMJ+qIJ
         8DBhXgDFFtI+GJRKpdnb9vu4ptgrIIXmeBqnIR1ZqQNAKnQ6ZT+ARmiWnDhHcCcfmZ1Y
         CROR1E0/DN8PgTxIu21n9pQrpoTenqZB096m1bTuKTkwycWyQzPs85tpIFsehJq9wCAL
         oRCdaEMprZ8QVpcoVxZRnU0Ef9CwfX5Z160xw2RbgA0W28l1FQURvvFYtbauiIrw8plA
         1BsZd0yeBBLJJrDmNS27KNNjPe7qzYFFiGltYEpo4h5WiLdJPjk3WIlzOIi9pkyrv5L9
         B4TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793081300; x=1793686100;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IgVNByFGNRaDuTcdCs60CTVgTyCqbZsDVgz3gl4WIHU=;
        b=tr96Dw7BSPyax758ezYLI2UqZ7sD2gyYwR2PXbUUtCvslEao+XZf5nGzv3bKmIQhkX
         /y64DXruY8AqY7dOqq+XZSvIpAMwrWscQA+8L/QvFiq0m2q58wqWmEdPrNpKP5qTGSLI
         unuGx9WBiEgfBEr1q3bQjWepc6UBX6wo6NU0T0eB/mQHNb0xPP7b1f/Sa7JGjwpXJdSp
         ojiM4q7ox7QIDUStQFnzVE2k/d7KmCQk+iQGwvTfXpAJijDtUcAI9UqjiI9r2EuNkD02
         1WQi7BkaEc1c3cg+lk58SVIvXqNK+uA40yXyR2EcoZGjeFynWySHII/nknIOp4N2aw2D
         98UQ==
X-Forwarded-Encrypted: i=1; AKwUvBxVrsg/6yPVZryVWRqyiBD/V+B/9iXqXYmZa3tGv+URFzz8NcMJZfDyfhjfD+7Fzb9E5eVYw88ZTkG6Hy2I@vger.kernel.org
X-Gm-Message-State: AFq9FYK5CaR6coWpc6tq4fsjSYpNm77kCREWScihADlNyWBLlKC2Bn5t
	ZTX9qwGOWkYgf5Sp0jtSaNvC4fO1uRkA/JaN6PW0+T99xQW6js5BspeZ9G7YKH8fgwr+EqK+p47
	/5Lb92t7Sqws2e59dT9sniVM0XKpiuHvCbsE2McF/fg==
X-Gm-Gg: AYBFou2WiwJSIJpz3RVTrrvNDvQpuJwSzD1bFt8oX8B2b3Q9gRzeoyMQMIPM7nJaKfF
	ievSBvD2FHNk58uzoLiKnugOm8L5Y85cxKg2Yb89IKLYntzawmOOJ6BbU7+/t5Suc2U/bowuEHX
	n360dGtEXitixE8t4g7jgWSOQow/bHy/NrIEiYZHrIi4txnSUyzpudROHFvzpOTiBOTyKcuIOq7
	H6rf7PYGeV3ujOPzF5CoMQ/XhgZNo+Cv5fPdOHjG48JEdb0yAElhcwPb7pxb5NPE17GJjQpJDNo
	BTEto+SfGOJEBUyu+8gzlxZhAFa6jfU/TtopaUuQu4JBQpstbC7tmoyRowv4NVhcVr+653YkB4a
	ztpjmZoCWFlUl7tzmvMgQq8gg6cbrAUTFNfZZhA==
X-Received: by 2002:a05:690e:1182:b0:673:e272:f3f8 with SMTP id
 956f58d0204a3-67a4525bb12mr4710546d50.20.1793081300158; Mon, 26 Oct 2026
 23:08:20 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026211010.3733399-2-jack@suse.cz>
In-Reply-To: <20261026211010.3733399-2-jack@suse.cz>
From: Hongyu Jin <hongyu.jin.cn@gmail.com>
Date: Tue, 27 Oct 2026 14:08:09 +0800
X-Gm-Features: AclHuK8YurQqj69d_CJGfDGrMIIkR8fIROVkyQxV8XfOqlVeWnaY-PymUAzidow
Message-ID: <CAMQnb4Nmynro93B1-xnM4pGoDk45-GEviHqDPXDf65GJaDn3pw@mail.gmail.com>
Subject: Re: [PATCH] writeback: Avoid postponing periodic data writeback indefinitely
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Commit 846 a3351ddfe4a86eede4bb26a205c3f38ef84d3 problem need to be conside=
red:

We have run into an issue that a task gets stuck in
balance_dirty_pages_ratelimited() when perform I/O stress testing.
The reason we observed is that an I_DIRTY_PAGES inode with lots
of dirty pages is in b_dirty_time list and standard background
writeback cannot writeback the inode.
After studing the relevant code, the following scenario may lead
to the issue:

task1                                   task2
-----                                   -----
fuse_flush
 write_inode_now // in b_dirty_time
  writeback_single_inode
    __writeback_single_inode
                                  fuse_write_end
                                   filemap_dirty_folio
                                    __xa_set_mark:PAGECACHE_TAG_DIRTY
     lock inode->i_lock
     if mapping tagged PAGECACHE_TAG_DIRTY
     inode->i_state |=3D I_DIRTY_PAGES
     unlock inode->i_lock
                                    __mark_inode_dirty:I_DIRTY_PAGES
                                       lock inode->i_lock
                                       -was dirty, inode stays in b_dirty_t=
ime
                                       unlock inode->i_lock

    if(!(inode->i_state & I_DIRTY_All))
      -not true,so nothing done


Jan Kara <jack@suse.cz> =E4=BA=8E2026=E5=B9=B410=E6=9C=8827=E6=97=A5=E5=91=
=A8=E4=BA=8C 05:10=E5=86=99=E9=81=93=EF=BC=9A
>
> Hongyu Jin has reported that f2fs periodically calls
> sync_inode_metadata() for some inodes. The logic in
> writeback_single_inode() thus periodically calls to redirty_tail() and
> the inode's dirtied_when timestamp never gets old enough for the inode
> to be eligible for periodic data writeback. Thus dirty data from it is
> only ever written on explicit request (fsync(2), sync(2), unmount) or
> on dirty limit pressure.
>
> The redirty_tail() logic in writeback_single_inode() actually should not
> be necessary. Since this function is used only for once-off writeback,
> there's no need for any livelock protection among inodes and
> writeback_single_inode() is only responsible for demoting inode to "less
> dirty" list based on dirty bits cleared as a result of writeback. So
> remove the redirty_tail() logic and add a comment explaining the rules.
>
> Link: https://lore.kernel.org/all/20261023023707.263101-1-hongyu.jin@unis=
oc.com
> Reported-by: Hongyu Jin <hongyu.jin.cn@gmail.com>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/fs-writeback.c | 35 ++++++++++++++++++++++-------------
>  1 file changed, 22 insertions(+), 13 deletions(-)
>
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 58a6403780aa..de86c9055ffb 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -1946,22 +1946,31 @@ static int writeback_single_inode(struct inode *i=
node,
>          * as it can be finally deleted at this moment.
>          */
>         if (!(inode_state_read(inode) & I_FREEING)) {
> +               enum inode_state_flags_enum istate =3D inode_state_read(i=
node);
> +
>                 /*
> -                * If the inode is now fully clean, then it can be safely
> -                * removed from its writeback list (if any). Otherwise th=
e
> -                * flusher threads are responsible for the writeback list=
s.
> +                * __mark_inode_dirty() is responsible for promoting inod=
e to
> +                * the proper list (b_attached -> b_dirty_time -> b_dirty=
).
> +                * Here we are responsible for demoting inode after some =
dirty
> +                * bits were cleared.
> +                *
> +                * If the inode is now fully clean, then it can be safely=
 moved
> +                * to b_attached list. If the inode is dirty, we don't wa=
nt to
> +                * touch it - it should be already put to the dirty list =
by
> +                * __mark_inode_dirty() and we'd just unnecessarily clobb=
er the
> +                * dirtied_when stamp (which is particularly problematic =
when
> +                * we were called from sync_inode_metadata()). We also ca=
nnot
> +                * touch the dirty list association when I_SYNC_QUEUED is=
 set
> +                * and flush worker is responsible for it. Otherwise move=
 the
> +                * inode to b_dirty_time list as that's the only remainin=
g
> +                * possibility.
>                  */
> -               if (!(inode_state_read(inode) & I_DIRTY_ALL))
> +               if (!(istate & I_DIRTY_ALL))
>                         inode_cgwb_move_to_attached(inode, wb);
> -               else if (!(inode_state_read(inode) & I_SYNC_QUEUED)) {
> -                       if ((inode_state_read(inode) & I_DIRTY))
> -                               redirty_tail_locked(inode, wb);
> -                       else if (inode_state_read(inode) & I_DIRTY_TIME) =
{
> -                               inode->dirtied_when =3D jiffies;
> -                               inode_io_list_move_locked(inode,
> -                                                         wb,
> -                                                         &wb->b_dirty_ti=
me);
> -                       }
> +               else if (!(istate & I_SYNC_QUEUED) && !(istate & I_DIRTY)=
) {
> +                       WARN_ON_ONCE(!(istate & I_DIRTY_TIME));
> +                       inode->dirtied_when =3D jiffies;
> +                       inode_io_list_move_locked(inode, wb, &wb->b_dirty=
_time);
>                 }
>         }
>
> --
> 2.51.0
>
