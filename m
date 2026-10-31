Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=128.30.2.78
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793461000;
	b=gD5faqTFQ8bzD+TgbXzFCSNnJR0cvvvrsRNnfd3I4hGWy/4xmX1O9TSdcx3prIeypPEX
	 UnIfmzOHb+SYS9lc7A9eMDhmdQx+q98y5Q9kOYMcEk+jfhbjZbnIDCzjVRwRpN91YIPTD
	 lOh97MVDfa74cfHWQSw1SeEhavBGRN6RaGI2WzVWYdWz4v6VRvyTrvvI2/XjjC7m9KrRr
	 5wBtS1Ez5WPVp5km1Md6ZQV71NqySgtkgetG5uLyieLqKwyL+3S1YOFxS8iPUcGdIvBOf
	 l+KILsfPhkn2mdMzs+hokDZjLHLHeNnFB6AMz2+o1NxIycwiP/Mm9JzxHj5xZqkmF9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793461000;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=tV1+UDLJYd+M7YNpHqfgBg+V9639j/FuI7yQ9vqAvy0=;
	b=0/TTv7p77O2YLKlTyh/DJJqV6TIgr+2Rux5dl12YKmj1p9MRNIComE9mVDhLvD4VgLBy
	 gnKkHP3hgFij8d+4IS0rVQ2D7Z5LkoVYkIYxtifVVCj22OEkWAQVFlY22fMsJ6mKF+KqE
	 Gyg/fUgLEn3AUTgIZsu1J1rsBl4c5BiokDegseKQbVXzwUAiPqD4KckGfiFK1I8AqdZbe
	 6d/vzsErgmKU1xvZZF+QKxFvEKiNVwXlWZji7FdatBA6JZgepd8tSh5GODLkyil8z+puD
	 rQ8LJZRtAwpaAdiqEguW4LkUPBjAqzW7GaUlpAPmOA7TNWEbeHo0nq6NNRSyajm2ivQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=csail.mit.edu;
	spf=pass smtp.mailfrom=csail.mit.edu;
	dkim=pass header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.a=rsa-sha256 header.s=test20231205 header.b=yVidkvOr;
	arc=none smtp.remote-ip=128.30.2.78
Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3535A606A31F
	for <linux-fsdevel@vger.kernel.org>; Sat, 31 Oct 2026 15:36:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3535A606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.a=rsa-sha256 header.s=test20231205 header.b=yVidkvOr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=outgoing.csail.mit.edu; s=test20231205; h=Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tV1+UDLJYd+M7YNpHqfgBg+V9639j/FuI7yQ9vqAvy0=; t=1793461000; x=1794325000; 
	b=yVidkvOrwkWm8SB+W49r/R40G1xfTVU21pH7+f+zIuoK1WiWB9VwaS9C0DNHDHcE0yTpLzDw4ho
	etNP41jleapCRglubca8B1gKE3UlgiBx/vj7r8bdl/kLKkMMFbj1leCmLJH7o87UMJ6mjPQc/Y6lE
	JqDExAgjmyN4rBQTsUp2gxufj37gfkDU7LXbvIGclHAXrvHuzmWnFhyCsBhjmvwI0eqPFQxmjp9Cz
	dmLUETI4mdHRThS2YGN+ytxaI4uG6adj37Bh86lOd+wD7P0crGC+Lh1uDg28g4Nvr+T9BIsUCc6HA
	8BGk5rtUo2MOiPyYFXLH8icb+RkhpUWPU7yw==;
Received: from mail-dy1-f171.google.com ([74.125.82.171])
	by outgoing2021.csail.mit.edu with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.95)
	(envelope-from <nickolai@csail.mit.edu>)
	id 1xNB8D-00EXJD-Kd
	for linux-fsdevel@vger.kernel.org;
	Sat, 31 Oct 2026 11:36:33 -0400
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3550c917fd3so2270524eec.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Oct 2026 08:36:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBw/F15ta+idZqc6WMUJexV1OMJazRFf+D0i+YqRtX0+zgBXcTcIugwUUqfrfPUkBvkr31n1qpxfalBiuRA1@vger.kernel.org
X-Gm-Message-State: AFq9FYLVueD17UuEeiLTz5U/tcKNtUn/P8Djt2G5c7z3eFlsMJsxDNEX
	EZQFsKstEk4uV1RqD8sFgF8KB8pl0fwuLUXfB5jcITB2VmNhLKIQpSI++nBdBNTuaAyXvz49wpF
	nuA8HWNI8fZQ2AVrTq6aZfqJj/bYI41M=
X-Received: by 2002:a05:701b:2087:10b0:143:7001:7645 with SMTP id
 a92af1059eb24-1ac5d889adcmr7929877c88.47.1793460992692; Sat, 31 Oct 2026
 08:36:32 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030-work-libfs-offset_readdir-v1-1-ed733c14229e@kernel.org>
In-Reply-To: <20261030-work-libfs-offset_readdir-v1-1-ed733c14229e@kernel.org>
From: Nickolai Zeldovich <nickolai@csail.mit.edu>
Date: Sat, 31 Oct 2026 11:36:20 -0400
X-Gmail-Original-Message-ID: <CADGQE7Gifns2LFRzVXEHp030VB5e9qmkqO=v3_fDKo84YX5Bfg@mail.gmail.com>
X-Gm-Features: AclHuK_9tCWKBg9Ks5hc8eLg4nOd33iRWrW9FMpj8uu7Cjr0UdJtSmOskTXcyLo
Message-ID: <CADGQE7Gifns2LFRzVXEHp030VB5e9qmkqO=v3_fDKo84YX5Bfg@mail.gmail.com>
Subject: Re: [PATCH] libfs: walk offset directories in offset order
To: Christian Brauner <brauner@kernel.org>
Cc: Chuck Lever <cel@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Yongjian Sun <sunyongjian1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This looks good to me -- thank you for the better fix!

On Fri, Oct 30, 2026 at 11:58=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> offset_iterate_dir() walks d_children from the head and only uses the
> maple tree to map ctx->pos back to a dentry when a getdents64() call
> resumes. offset_dir_lookup() finds the entry at ctx->pos, or the one
> with the next lower offset if it is gone, and the list walk continues
> from there.
>
> That only works if list order and offset order agree and quite often
> they don't. A rename over an existing name gives the moved dentry the
> offset of the name it replaced but __d_move() puts it at the head of
> d_children. RENAME_EXCHANGE does the same to both dentries. And once
> the cyclic offset allocator wraps new entries get low offsets at the
> head of the list.
>
> So if the entry at ctx->pos is unlinked between two getdents64() calls
> we resume at the entry with the next lower offset and that one can sit
> anywhere in the list:
>
> (1) If it sits further down the list everything in between is skipped.
>     Create y, t, a, b and rename b over t. The list is now t(4) a(5)
>     y(3). Stop the listing at t and unlink t. The next call resumes at
>     y and a is never returned although nobody touched it.
>
> (2) If there is no lower entry we restart at the head and return the
>     whole directory again. Nickolai reported this for the simple case
>     of unlinking the oldest entry while a listing is about to reach it.
>     Ending the walk there instead turns this into (1): create a, b, c,
>     rename c over a, stop the listing at the renamed entry, unlink it,
>     and b is lost.
>
> Instead of the list let's walk the maple tree itself in descending
> offset order. Then ctx->pos really means that everything above it has
> been emitted and resuming at the highest offset at or below it is right
> no matter where the dentry sits in d_children. Entries created or
> renamed to a new name after the listing started get an offset above
> ctx->pos and aren't returned, same as with the list walk which never
> went back to the head. So a readdir loop that renames or creates an
> entry for each one it reads still terminates.
>
> The maple tree can't change under us as all modifications happen with
> the directory's i_rwsem held exclusive and offset_readdir() holds it
> shared.
>
> Fixes: b9b588f22a0c ("libfs: Use d_children list to iterate simple_offset=
 directories")
> Fixes: f70681e9e606 ("libfs: Fix duplicate directory entry in offset_dir_=
lookup")
> Reported-by: Nickolai Zeldovich <nickolai@csail.mit.edu>
> Link: https://patch.msgid.link/20261018024549.798968-1-nickolai@csail.mit=
.edu
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Nickolai Zeldovich <nickolai@csail.mit.edu>

> ---
>  fs/libfs.c | 56 ++++++++++++++++++++++----------------------------------
>  1 file changed, 22 insertions(+), 34 deletions(-)
>
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 96a6e9b1535f..8d5de5f61ffd 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -446,31 +446,11 @@ static loff_t offset_dir_llseek(struct file *file, =
loff_t offset, int whence)
>         return vfs_setpos(file, offset, LONG_MAX);
>  }
>
> -static struct dentry *find_positive_dentry(struct dentry *parent,
> -                                          struct dentry *dentry,
> -                                          bool next)
> -{
> -       struct dentry *found =3D NULL;
> -
> -       spin_lock(&parent->d_lock);
> -       if (next)
> -               dentry =3D d_next_sibling(dentry);
> -       else if (!dentry)
> -               dentry =3D d_first_child(parent);
> -       hlist_for_each_entry_from(dentry, d_sib) {
> -               if (!simple_positive(dentry))
> -                       continue;
> -               spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
> -               if (simple_positive(dentry))
> -                       found =3D dget_dlock(dentry);
> -               spin_unlock(&dentry->d_lock);
> -               if (likely(found))
> -                       break;
> -       }
> -       spin_unlock(&parent->d_lock);
> -       return found;
> -}
> -
> +/*
> + * Find the entry with the highest offset at or below @offset. Entries a=
re
> + * emitted in descending offset order, so this is the next entry to emit
> + * when resuming at @offset.
> + */
>  static noinline_for_stack struct dentry *
>  offset_dir_lookup(struct dentry *parent, loff_t offset)
>  {
> @@ -480,14 +460,19 @@ offset_dir_lookup(struct dentry *parent, loff_t off=
set)
>
>         MA_STATE(mas, &octx->mt, offset, offset);
>
> -       if (offset =3D=3D DIR_OFFSET_FIRST)
> -               found =3D find_positive_dentry(parent, NULL, false);
> -       else {
> -               rcu_read_lock();
> -               child =3D mas_find_rev(&mas, DIR_OFFSET_MIN);
> -               found =3D find_positive_dentry(parent, child, false);
> -               rcu_read_unlock();
> +       if (offset < DIR_OFFSET_MIN)
> +               return NULL;
> +
> +       rcu_read_lock();
> +       while ((child =3D mas_find_rev(&mas, DIR_OFFSET_MIN))) {
> +               spin_lock(&child->d_lock);
> +               if (simple_positive(child))
> +                       found =3D dget_dlock(child);
> +               spin_unlock(&child->d_lock);
> +               if (found)
> +                       break;
>         }
> +       rcu_read_unlock();
>         return found;
>  }
>
> @@ -504,7 +489,10 @@ static void offset_iterate_dir(struct file *file, st=
ruct dir_context *ctx)
>         struct dentry *dir =3D file->f_path.dentry;
>         struct dentry *dentry;
>
> -       dentry =3D offset_dir_lookup(dir, ctx->pos);
> +       if (ctx->pos =3D=3D DIR_OFFSET_FIRST)
> +               dentry =3D offset_dir_lookup(dir, DIR_OFFSET_MAX);
> +       else
> +               dentry =3D offset_dir_lookup(dir, ctx->pos);
>         if (!dentry)
>                 goto out_eod;
>         while (true) {
> @@ -514,7 +502,7 @@ static void offset_iterate_dir(struct file *file, str=
uct dir_context *ctx)
>                 if (!offset_dir_emit(ctx, dentry))
>                         break;
>
> -               next =3D find_positive_dentry(dir, dentry, true);
> +               next =3D offset_dir_lookup(dir, ctx->pos - 1);
>                 dput(dentry);
>
>                 if (!next)
>
> ---
> base-commit: b44341e39d856e4cc6ad8ed94ebffd440f39846c
> change-id: 20261030-work-libfs-offset_readdir-807d3b774260
>

Nickolai.
