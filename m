Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793944263;
	b=3cayaK878Lr1PKdsrYnuob+1TyTPRfd4/zGgd85g6AJwsu15eC2chIH+JIlUta2r+h6/
	 U9TpBdY9GA1QsXFV/jBoP4s4LjQjLabj+7Q4nLqYuve7cDm8FaQnuS+gsfxvDMFurIQm9
	 LFpnkGZQZi81bD7h0z4dpqa/VztnLaCz+lpZ9VcJhp+WlGS1XO0ZG6wj10VzXxdT/XAvn
	 Shxp4JCc93OSWvM3i6JcIeSi2P2OJh2n3t3qIkLRejeQPPjO4jwFq0+0AMMflWFW2kWvt
	 l3M2f6F1eTcaYzXyCn0Futme8YlZwENvUJKkycrcm/nEbLZpeYx+kxhPsAcKH6ySaAA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793944263;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=rsMKU5+NnoIl8c0Lhh3jqd04mpuBQb4VVqBOw1r/IDY=;
	b=kR/EE095l04ulYFZ71qeu/F92WN64O2dThrG92PCWf8tazSZQ1FFB3hLcsAbhVS4Om+r
	 8vEs5rbtuKSOu5uvJlykEhU5aItn+whMhl3MvvuwgMg5yV0jaxrPTNd7vxHVFue3q2ds7
	 yyVR49Cym1HpNb9Wm0tt8xnmePTpjgXcgKwb01hAzcwzIYgE8mENvhO6U0yg9K08eyZa1
	 ckD880mjFyDDSqt2ewMqsZmx5cyfQ0n76/a+d126QC7C3LGoZwjF80dXqDaZ0ek06i36E
	 J13oFk/riRmugyltBDiLKEnyYKezWXMr3oqyyfGZ2WIfW6cSslneetEwwe8h8/Hfbqw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kebBdQkb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.47
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1DB606D81C
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Nov 2026 05:51:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE1DB606D81C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kebBdQkb
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-67c0ffaae1dso968966d50.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 21:51:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793944261; cv=none;
        d=google.com; s=arc-20260327;
        b=p3WXResbJJu6546ActBsB4oP/h+2h9i6qYAbdXw311/4YxlLgdwtrkmBwolEFO9sS8
         J9kaNGHuWWsNHKxmF0FYZ/y9cvBVBBuWWhxfKrzbAc8PrIx5hqJVvfCAQ5bzNsiznoWr
         IwNDSlQedvJ1aJSq3tsMriatSfsg5rMFTDJANgwIuDPHDkwekNQHQXIVRZYy9pmi9fjX
         3lsIJRWrZNE8BODy5TaWJJ3bD2uGx3MU0/KtBMQeO/8AX8DD1znzMHEd/tZ3RfwrDbEY
         AIzSW9e0UX/GyKF8QTASJNb1WLNsb2XGfXtO0OHUEVuv7tqPA6PZkXVi6MPOi49kfURx
         tvpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rsMKU5+NnoIl8c0Lhh3jqd04mpuBQb4VVqBOw1r/IDY=;
        fh=OQUzemWhcRk4F/CYk9+Voxl04Wdjoa4DYPniA+p910c=;
        b=fm9I2p5OIoRX6caV+6ebWSCHsBO+BrMZCLCXEYrnf4izzK/IQFzCJbTEdL873G5cPP
         NUi9LLnn0sbjfAcYmje0aAAVVKyzFrkZpShFn/TUL5NOEVmHbtuSOijM46sP/G+w7AxT
         RgKF8VxN4Cb+S3jHJ0tzINdB90WxpNAr+PEuXSqYlE0yxyIxlVEZvx6si0nN/Jowznmg
         jNQn2fZPKi+rJYrv0K44NDR+vsqp0lm5y/boGa+p3He9Dg0KDJOrR8E1rGMptCSJ8Owd
         TNDmppSWb6rHII//HrLLbrOSCSExYzXK05A9fnZ6HBif4jwFp5qXO4SOOtCvm7bJ/TcH
         /1IA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793944261; x=1794549061; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rsMKU5+NnoIl8c0Lhh3jqd04mpuBQb4VVqBOw1r/IDY=;
        b=kebBdQkbzXE5PD6cDUskNGXyi9t9NNtYi7zSnPCI8yX9QMeP01Nlh+9BbzvcBemKEQ
         BfWvgdXj1skm+5MFdcJJF4p9EpgCKPD+IBLUlq67c2oZHD2TrF8D4oz+72d1teZqyYMx
         yQ/Jq/AVCt/nv1wq5EJENnHq2AC7M5gMTSfK+omLnurLGxnuPsWBtCNMUQ/SrVqFcYlE
         4OTYmo119Db2UowfFRNhMCfCUbwE+dQKpxF0NMq1kCXlcnTPr/Dj/JkQgy64jZ0zCPK5
         ZPw4f5YnSbYatAhWvrTomKw7M1epniiBBCOsU57ABJIdfoqPLoJaZ1iTBTlOOMBvkJ0q
         aRQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793944261; x=1794549061;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rsMKU5+NnoIl8c0Lhh3jqd04mpuBQb4VVqBOw1r/IDY=;
        b=GhFvgRWPIRl8y6ul11zQxBbx9nl/KxgwoEXQavye1X+n7B3nT96+pZ8Se/pjIw8Whq
         oPKESp0bedZpvtJOMZnjd2NtVWrv9HBPEuTlxUuhe6SzbXS9kB+GXjsA50beCTcsxKIx
         rXoETAqNj8jzmoSdrZnzCAC4GS5mobSnXj2igBZEFZo+w3HXheClE7GHK5M3ydFvWdm7
         A04tluHG2C+GSg8HMyz9PNmh/v/IVRFw/mAP25O3j84gjaoEPK3l4O6fCZvYA4tJ4MTJ
         kVx9Q2EpTruvawQVaW23TNFWwEYJ9p7ZPfbFxNWifLVjibnCYESoTbBCoqzsD/c26YbP
         M8zw==
X-Forwarded-Encrypted: i=1; AL+hErHgAT9wMb3UFS3e9GaijaQv9YYXEgwCEnlAXaKOAdVrCoRIrWMLQnCk70IzbP9TvGK+hV2E6jAUFSGBACaV@vger.kernel.org
X-Gm-Message-State: APuU4Z9wOUj8Zd422R9Hoe5dVISLjW6ihxfKW9iEZ6vHKqrYzlpb/R6/
	DzTaam8InUCq+TcxXd55q0o/6ZGD2kiYfmSdEwpWaWm4yyFV+hxthRejIEMjRW/RsssXLBGGXAe
	iwsWTJluyHqejWlojt/STqT0T7/s059ZLu7l4mNw=
X-Gm-Gg: AYBFou0Yy19yirkMPbc/whjZKzHWhli3+g21UCtCYBd6GYWMAschuWg30wZ4pjmckGj
	iGlGmo4qfyBFxpYUhDPVts1ZtkCJ5oDgpSpwlWjiQ2j7J/7EyYzRmNdnXCO2VP1k7st2C2O0pvV
	D0ifKXkiRObZdPacd/XGeatPmHO2AeWSjpdXfi91sYUmpwHkVZ6dek9HtrWtH/BElUZUuUWPH3B
	p2nSYXc+bG3sQpm0mtoogjZhOhx3jIyfL6ViflgTzBHuBwbFwQagilmeeZyKpamahvb0IK/LgYb
	zEBJOgdu6+Z33KwssYfwV2lZSMK0UyNnz45crQWcmcHo1x1sHray2EG8pKaAfrrIR7SrsnjJU3N
	O6+/+Taa1GaE8K/dyv98n4tDbYtvEYhSaIeltVg==
X-Received: by 2002:a05:690e:13ca:b0:679:a5fc:2f35 with SMTP id
 956f58d0204a3-67c035c51aamr3192504d50.19.1793944261497; Thu, 05 Nov 2026
 21:51:01 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <azdwnedsaesxdsp6vxjxgzg6ynrszveibmqkpznn3yuqyttlcj@5lz4p2aw5hxk> <20261029015217.840177-1-hongyu.jin@unisoc.com>
In-Reply-To: <20261029015217.840177-1-hongyu.jin@unisoc.com>
From: Hongyu Jin <hongyu.jin.cn@gmail.com>
Date: Fri, 6 Nov 2026 13:50:49 +0800
X-Gm-Features: AclHuK8NUDHexxCvw24bOaA7YGWPl4y47tQIq4E1vqMshmUv6Vcvqjnc0fhH-iE
Message-ID: <CAMQnb4MVyDMnS039hE1A=2jp6y2WF1zQFw1DfDzeEYsT0tKk3g@mail.gmail.com>
Subject: Re: [PATCH v2] writeback: Avoid postponing periodic data writeback indefinitely
To: jack@suse.cz
Cc: brauner@kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hongyu Jin <hongyu.jin.cn@gmail.com> =E4=BA=8E2026=E5=B9=B410=E6=9C=8829=E6=
=97=A5=E5=91=A8=E5=9B=9B 09:52=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Jan Kara <jack@suse.cz>
>
> f2fs periodically calls sync_inode_metadata() for some inodes. The logic
> in writeback_single_inode() thus periodically calls to redirty_tail() and
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
> The redirty_tail() did hide a race though, the one fixed by
> commit 846a3351ddfe ("writeback: Avoid skipping inode writeback").
> __writeback_single_inode() sets I_DIRTY_PAGES again when the mapping
> is still tagged dirty. If the inode had no I_DIRTY bits (e.g.
> write_inode_now(inode, 0) or sync_inode_metadata(inode, 0) of an inode
> with only I_DIRTY_TIME), the dirty pages come from a racing writer,
> whose __mark_inode_dirty() then finds I_DIRTY_PAGES set and does not
> queue the inode, leaving it on b_dirty_time or b_attached. Call
> __mark_inode_dirty() in that case instead, so that the inode gets queued
> on b_dirty.
>
> Fixes: 846a3351ddfe ("writeback: Avoid skipping inode writeback")
> Reported-by: Hongyu Jin <hongyu.jin.cn@gmail.com>
> Link: https://lore.kernel.org/all/20261023023707.263101-1-hongyu.jin@unis=
oc.com
> Cc: stable@vger.kernel.org
> Signed-off-by: Jan Kara <jack@suse.cz>
> [hongyu.jin: let __mark_inode_dirty() queue an inode whose pages were
>  dirtied while it had no I_DIRTY bits, update comments]
> Signed-off-by: Hongyu Jin <hongyu.jin@unisoc.com>
> ---
>  fs/fs-writeback.c | 60 +++++++++++++++++++++++++++++++++--------------
>  1 file changed, 43 insertions(+), 17 deletions(-)
>
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 58a6403780aa..c7979b0cd375 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -1780,7 +1780,9 @@ bool sync_lazytime(struct inode *inode)
>   *
>   * This doesn't remove the inode from the writeback list it is on, excep=
t
>   * potentially to move it from b_dirty_time to b_dirty due to timestamp
> - * expiration.  The caller is otherwise responsible for writeback list h=
andling.
> + * expiration, or to queue it on b_dirty via __mark_inode_dirty() when i=
ts
> + * pages were dirtied while it had no I_DIRTY bits.  The caller is other=
wise
> + * responsible for writeback list handling.
>   *
>   * The caller is also responsible for setting the I_SYNC flag beforehand=
 and
>   * calling inode_sync_complete() to clear it afterwards.
> @@ -1790,6 +1792,7 @@ __writeback_single_inode(struct inode *inode, struc=
t writeback_control *wbc)
>  {
>         struct address_space *mapping =3D inode->i_mapping;
>         long nr_to_write =3D wbc->nr_to_write;
> +       bool mark_pages =3D false;
>         unsigned dirty;
>         int ret;
>
> @@ -1843,12 +1846,23 @@ __writeback_single_inode(struct inode *inode, str=
uct writeback_control *wbc)
>          * still has dirty pages.  The flag is reinstated after smp_mb() =
if
>          * necessary.  This guarantees that either __mark_inode_dirty()
>          * sees clear I_DIRTY_PAGES or we see PAGECACHE_TAG_DIRTY.
> +        *
> +        * If the inode had any I_DIRTY bits, __mark_inode_dirty() has al=
ready
> +        * queued it (if it is to be queued at all) and we can just reins=
tate
> +        * I_DIRTY_PAGES.  Otherwise the pages were dirtied by a racing w=
riter
> +        * and the inode may sit on b_dirty_time or b_attached.  Setting =
the
> +        * flag here would make the writer's __mark_inode_dirty() bail ou=
t
> +        * without queueing the inode, so let __mark_inode_dirty() set it=
 and
> +        * queue the inode instead.
>          */
>         smp_mb();
>
> -       if (mapping_tagged(mapping, PAGECACHE_TAG_DIRTY))
> -               inode_state_set(inode, I_DIRTY_PAGES);
> -       else if (unlikely(inode_state_read(inode) & I_PINNING_NETFS_WB)) =
{
> +       if (mapping_tagged(mapping, PAGECACHE_TAG_DIRTY)) {
> +               if (dirty)
> +                       inode_state_set(inode, I_DIRTY_PAGES);
> +               else
> +                       mark_pages =3D true;
> +       } else if (unlikely(inode_state_read(inode) & I_PINNING_NETFS_WB)=
) {
>                 if (!(inode_state_read(inode) & I_DIRTY_PAGES)) {
>                         inode_state_clear(inode, I_PINNING_NETFS_WB);
>                         wbc->unpinned_netfs_wb =3D true;
> @@ -1858,6 +1872,9 @@ __writeback_single_inode(struct inode *inode, struc=
t writeback_control *wbc)
>
>         spin_unlock(&inode->i_lock);
>
> +       if (mark_pages)
> +               __mark_inode_dirty(inode, I_DIRTY_PAGES);
> +
>         /* Don't write the inode if only I_DIRTY_PAGES was set */
>         if (dirty & ~I_DIRTY_PAGES) {
>                 int err =3D write_inode(inode, wbc);
> @@ -1946,22 +1963,31 @@ static int writeback_single_inode(struct inode *i=
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
> 2.53.0
>

 Hi maintainers, have any suggestions for this patch?
