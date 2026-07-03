Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E893F3264F3
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Jul 2026 04:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783054207; cv=pass; b=IS0G6nt5HXD8iEPIpErkTiODZny++3mh/Sy/nQbw9o0cQil7nRjEq5sW+wM0pNjlTc2mgRRDZ1CPId+4G+xiBMRChiDCCp1bn5tvdXj8deCnnLpOEJDz4m1h3pXEEpsseu3auG608qmI5g0t57/UK3sSYAjUiKyLk7QvQBJET10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783054207; c=relaxed/simple;
	bh=WNaI7evD2W1G/CdnGJTvDBBueYGbm7A4pArwx/U7aqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rGYbxY9lH9aFmo7EcY3X9BkkcAIQDqkDM4XhK5/EpDT8Jfvs2QPny1mMGgd14Nr8qoNxQP4C037D89YOL5VS7+zlo5fu65kZrLJ0DTnPa2xVnJeIWMDmw7ELkw8AMAsQN4Cf78gfqfk2MzR5Wllpo25DLJ78jqvOkyNkcCq8X9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j7juXO4z; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7juXO4z"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c12a430d71dso10284866b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jul 2026 21:49:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783054195; cv=none;
        d=google.com; s=arc-20260327;
        b=ddmArLfeilj7EyBojqYicpc0JdQPBvn4nqaeRlvMkJ+ITzbvuwlQJaAAQsxthz1iWa
         mW+twZzgp+Da1P0ohZbbGIbzOdwX09I0ADFhgqZ29TuSO3Rpl7lp92Odrqyw7XTSQamL
         hrKopADfbQ0ykkT+g/bue88kpPtJovWE1B0aj6Hpoacvl0V5eaiMY4xkV93AUNudUcp4
         r0mUe5yLYzfB+aBEz0JBD3RdHqvJxSc2kziYmErTFDEjBezL+jYmY8g9mxpgPu2mugDC
         5EWXZYu+rJHwDpE556zQsA1QYBE1f3IkakuW8dn1C4yqDV1zedu3s+lHL3em+5pF7DiE
         366Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=abYqechUaVMX68IHoATU67J3c08QbMDJ1JRtoo3TnyU=;
        fh=dnd+/wL101jyVfQ/PA9SyQ6IUy196wxxivON0QG5vGM=;
        b=rDO4/1pXRgtCc0ThAEbp4RK4FtaXfNczbURkQyAZgG+b4sLkrPOEGsYgzkPBI6tMc0
         egbeQ8tVO1L3hB5m86bWkMh44fjXWQHBKpMFg4XcuY6N1h6jLd8h0G70zkt0w2lthzRH
         Bgdlz6U9ac4AHX+GY6Gh3V9TIem/1bxGy40p6XWOhLYDXU8RvuxcFwzDsh2EFFhmAUbI
         wvPrhVuhcZMOEM5xhVfqruaaLJtJ3xCYFc5ARcKK8aEnLbYysgD5BZLdBCzmJtlfKah/
         SQVt3QmK6n9CAVSKNdXUtsbDMveJcHOBRLpq4Nap/TrZHhhXGUmDwEnorWq0t3DJz8J4
         cCZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783054195; x=1783658995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=abYqechUaVMX68IHoATU67J3c08QbMDJ1JRtoo3TnyU=;
        b=j7juXO4zQpUk5pEHlFBGKWimbFyWqQYZMPxoaI9p1yXpjwlF43NeRfyDqFjaRw80oT
         m9X2L5n2gd6hni/X6vQRH+pS4zgZGbu2t1U8vRLW/YWKhR4UO/oGcbZAvmCRGefHZGU+
         ZlQ996GB00E94ALJmhUoBICX4oQ7ELJnqGF7oCfCqxQsNzVG8E3jR/HIBcVKkHrEgG3B
         +Av0ch4dtVJ+EVlhobsOPAWlXeofLz9CBZbyIGXqzNDBZkdVXZwtGjz29eIIY+h6oSnF
         +D8/C3a0LKz9Cpi3lJc+/4Q25RBY6LB8Zox2T3F0ODcNof2n2AGerdqwH5gVCeXy2srB
         8wEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783054195; x=1783658995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=abYqechUaVMX68IHoATU67J3c08QbMDJ1JRtoo3TnyU=;
        b=US+xintVGrAfNKka32cds26pR6Cx0R4C2WVJDn+RAnuSmtXAPqwjFcxSyI64YmATmG
         IJ6fot8M2Gu09dlMyZnMSYnpqBME6y1QHf/fKlSmusZkY0ecCNSDWEAvK0w0V8955+gb
         zP9dZ6H2laytkdbDoYytm2SW+7oYYIw7iyY/YNccUZRohSS8T0Vgy0XlbbNscLixGKN5
         QifmHK6dfN0HzdFf+G0QcgbExGiu9qLLdMxMEGPrBZt/wL80tNqOaktuvarft09DZTCA
         dI7qW/A6VPVRhdZH6ijL8nQCuAbjNs/LR3mIBkmIBOuIFQ3yL5e/oKhSZQaD9zndHIQs
         Q5yA==
X-Forwarded-Encrypted: i=1; AHgh+RrktOTS7TBvHRYPkhn0gQ2a1JHoqyL/CKh3HVFNuZsigWykY7yleAL0BL0Pg2M5YP1PMxy5EvCgjNrPD90/@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk74iXTKkJyxmCQBVDDwBZvJZgotKag7Qa2Q4TpyC8+91OGz3Q
	CrRzYq6OrcO7X7nwK48I2e4QSHuvnJ48fL7fmPEyfjEgts0cVFNw1YGJIwc9WkpClz0GB7ZG9Gs
	cwZV7BceG5pbYU+IzolDDpFQHULU6/Lk=
X-Gm-Gg: AfdE7cmb8yAPVUx3+SJC97U8tG/7xajEPAlkifQIMQ12C+3T6JWoVi0c+SvzVTPMFSL
	rQ0Kb67MqI4uNFWMfCJQdoZ0KijWq/yiWR/Ryxhs9PfW4CqUPfMYWvjmmW2UkFMs9Ya7XYzS094
	2jjiSnObWNnytnSZE++bVlPcAmllWGruGETNXr5YjEKhuWeRWYBe093wnrAwY6If2fsm3bVl8jg
	uSjCIOzLnryIRFIXVNyMi0hw9L1eEtHJFRv2jh48tfiagFPnLuZ/D6KDQdCDpHu+CKWCpzRHjh9
	QbnJ3MT5Zt8snHeBYp93kZeGBOafV9I=
X-Received: by 2002:a17:907:8e15:b0:c12:39b4:413e with SMTP id
 a640c23a62f3a-c12a9d72229mr414235966b.21.1783054194228; Thu, 02 Jul 2026
 21:49:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703042443.1655-1-aditya.ansh182@gmail.com>
In-Reply-To: <20260703042443.1655-1-aditya.ansh182@gmail.com>
From: Aditya Prakash Srivastava <aditya.ansh182@gmail.com>
Date: Fri, 3 Jul 2026 10:19:42 +0530
X-Gm-Features: AVVi8CdQ1KZMsBrMLSF8_EkTpENETnVSnkm3giXCsXB_qmCdUUAHyyvcaXeDwEI
Message-ID: <CAK5ssPORQt=5FyKw51n9=Onf8CfXZzRPdsfg_9ipFGgcXtpzXQ@mail.gmail.com>
Subject: Re: [PATCH v3] ext4: use fsdata to track inline data write state and
 fix race
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.cz>, 
	Baokun Li <libaokun@linux.alibaba.com>, Ojaswin Mujoo <ojaswin@linux.ibm.com>, 
	Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>, Tao Ma <boyu.mt@taobao.com>, 
	syzbot+0c89d865531d053abb2d@syzkaller.appspotmail.com, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Please ignore this as the subsequent cleanup of
CONVERT_INLINE_DATA will have to be dependent on this
patch and should have been sent as a two patch series in the
first place.

Thanks,
Aditya

On Fri, Jul 3, 2026 at 9:55=E2=80=AFAM Aditya Srivastava
<aditya.ansh182@gmail.com> wrote:
>
> From: Aditya Prakash Srivastava <aditya.ansh182@gmail.com>
>
> Instead of checking the live inode state (ext4_has_inline_data(inode)
> and ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA)) in the
> write_end handlers, use the fsdata parameter of the address space
> operations to explicitly pass down the state in which write_begin
> prepared the write.
>
> A concurrent thread (such as ext4_page_mkwrite()) can convert the
> inline data to an extent between write_begin and write_end. If this
> happens, the write_end handlers would previously miss the inline
> write_end path and fall through to extent-based write_end logic.
> However, since block buffers were never allocated in write_begin,
> this resulted in NULL pointer dereferences or data loss because
> folio_buffers(folio) was NULL.
>
> Define EXT4_WRITE_DATA_INLINE (4) as a bit flag (Bit 2), treating
> fsdata as bitwise flags rather than mutually exclusive enums to keep
> states of the write path independent. Communicate this state via
> fsdata:
> 1) ext4_write_begin() and ext4_da_write_begin() set the
>    EXT4_WRITE_DATA_INLINE bit in *fsdata via bitwise OR when an inline
>    write is successfully prepared.
> 2) On entry, ext4_write_begin() clears the EXT4_WRITE_DATA_INLINE bit
>    to safely handle VFS retries (where generic_perform_write() bypasses
>    the fsdata initialization on its retry jump).
> 3) The write_end handlers perform a bitwise AND to check if the
>    EXT4_WRITE_DATA_INLINE bit is set and invoke the inline write_end
>    helper accordingly.
>
> Furthermore, during a buffered write, ext4_write_inline_data_end()
> acquires the xattr lock after preparing the write. If a concurrent
> page fault (ext4_page_mkwrite()) converts the inline data to an extent
> after the write_end handlers check the state but before
> ext4_write_inline_data_end() acquires the xattr write lock, the
> subsequent check will trigger a kernel panic via
> BUG_ON(!ext4_has_inline_data(inode)).
>
> To keep git history working and bisectability clean, replace the
> BUG_ON check in ext4_write_inline_data_end() with a graceful error-
> handling retry path in this same commit. If the inline data is cleared
> after locking the xattr, we safely release all resources (releasing
> iloc.bh, unlocking/putting the folio, stopping the active journal
> transaction handle) and return 0 (VFS retry) to let the generic write
> path retry the operation safely.
>
> Reported-by: syzbot+0c89d865531d053abb2d@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D0c89d865531d053abb2d
> Fixes: 3fdcfb668fd7 ("ext4: add journalled write support for inline data"=
)
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Aditya Prakash Srivastava <aditya.ansh182@gmail.com>
> ---
> Changes in v3:
> - Changed EXT4_WRITE_DATA_INLINE to 4 (Bit 2) and treat fsdata as
>   bitwise flags, allowing decoupling of independent states in the
>   write path (e.g. standard fallback and inline writes), as suggested
>   by Jan Kara.
> - Clear the EXT4_WRITE_DATA_INLINE bit on entry to ext4_write_begin() to
>   safely unroll state for any VFS write retries.
> - Perform bitwise AND checks for EXT4_WRITE_DATA_INLINE and
>   FALL_BACK_TO_NONDELALLOC flags in the write_end and da_write_end
>   handlers.
>
> Changes in v2:
> - Folded the BUG_ON fix from the second patch into the first one to
>   ensure bisectability across git history, as suggested by Jan Kara.
> - Removed the pointless initialization `*fsdata =3D NULL` on entry to
>   `ext4_write_begin()`.
> - Removed the redundant check `if (fsdata)` in `ext4_write_begin()`.
>
>  fs/ext4/ext4.h   |  1 +
>  fs/ext4/inline.c | 14 +++++++++++++-
>  fs/ext4/inode.c  | 24 +++++++++++++-----------
>  3 files changed, 27 insertions(+), 12 deletions(-)
>
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index b37c136ea3ab..9e6f6467bdeb 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -3138,6 +3138,7 @@ int do_journal_get_write_access(handle_t *handle, s=
truct inode *inode,
>  void ext4_set_inode_mapping_order(struct inode *inode);
>  #define FALL_BACK_TO_NONDELALLOC 1
>  #define CONVERT_INLINE_DATA     2
> +#define EXT4_WRITE_DATA_INLINE  4
>
>  typedef enum {
>         EXT4_IGET_NORMAL =3D      0,
> diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
> index 8045e4ff270c..cfd591dc1d9c 100644
> --- a/fs/ext4/inline.c
> +++ b/fs/ext4/inline.c
> @@ -812,7 +812,19 @@ int ext4_write_inline_data_end(struct inode *inode, =
loff_t pos, unsigned len,
>                         goto out;
>                 }
>                 ext4_write_lock_xattr(inode, &no_expand);
> -               BUG_ON(!ext4_has_inline_data(inode));
> +               /*
> +                * We could have raced with ext4_page_mkwrite() convertin=
g
> +                * the inode and clearing the inline data flag, so we jus=
t
> +                * release resources and retry the whole write.
> +                */
> +               if (unlikely(!ext4_has_inline_data(inode))) {
> +                       ext4_write_unlock_xattr(inode, &no_expand);
> +                       brelse(iloc.bh);
> +                       folio_unlock(folio);
> +                       folio_put(folio);
> +                       ext4_journal_stop(handle);
> +                       return 0;
> +               }
>
>                 /*
>                  * ei->i_inline_off may have changed since
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index ce99807c5f5b..4e1bf54e511d 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -1302,6 +1302,8 @@ static int ext4_write_begin(const struct kiocb *ioc=
b,
>         if (unlikely(ret))
>                 return ret;
>
> +       *fsdata =3D (void *)((unsigned long)*fsdata & ~EXT4_WRITE_DATA_IN=
LINE);
> +
>         trace_ext4_write_begin(inode, pos, len);
>         /*
>          * Reserve one block more for addition to orphan list in case
> @@ -1316,8 +1318,10 @@ static int ext4_write_begin(const struct kiocb *io=
cb,
>                                                     foliop);
>                 if (ret < 0)
>                         return ret;
> -               if (ret =3D=3D 1)
> +               if (ret =3D=3D 1) {
> +                       *fsdata =3D (void *)((unsigned long)*fsdata | EXT=
4_WRITE_DATA_INLINE);
>                         return 0;
> +               }
>         }
>
>         /*
> @@ -1450,8 +1454,7 @@ static int ext4_write_end(const struct kiocb *iocb,
>
>         trace_ext4_write_end(inode, pos, len, copied);
>
> -       if (ext4_has_inline_data(inode) &&
> -           ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA))
> +       if ((unsigned long)fsdata & EXT4_WRITE_DATA_INLINE)
>                 return ext4_write_inline_data_end(inode, pos, len, copied=
,
>                                                   folio);
>
> @@ -1560,8 +1563,7 @@ static int ext4_journalled_write_end(const struct k=
iocb *iocb,
>
>         BUG_ON(!ext4_handle_valid(handle));
>
> -       if (ext4_has_inline_data(inode) &&
> -           ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA))
> +       if ((unsigned long)fsdata & EXT4_WRITE_DATA_INLINE)
>                 return ext4_write_inline_data_end(inode, pos, len, copied=
,
>                                                   folio);
>
> @@ -3161,8 +3163,10 @@ static int ext4_da_write_begin(const struct kiocb =
*iocb,
>                                                      foliop, fsdata, true=
);
>                 if (ret < 0)
>                         return ret;
> -               if (ret =3D=3D 1)
> +               if (ret =3D=3D 1) {
> +                       *fsdata =3D (void *)((unsigned long)*fsdata | EXT=
4_WRITE_DATA_INLINE);
>                         return 0;
> +               }
>         }
>
>  retry:
> @@ -3291,17 +3295,15 @@ static int ext4_da_write_end(const struct kiocb *=
iocb,
>                              struct folio *folio, void *fsdata)
>  {
>         struct inode *inode =3D mapping->host;
> -       int write_mode =3D (int)(unsigned long)fsdata;
> +       unsigned long write_mode =3D (unsigned long)fsdata;
>
> -       if (write_mode =3D=3D FALL_BACK_TO_NONDELALLOC)
> +       if (write_mode & FALL_BACK_TO_NONDELALLOC)
>                 return ext4_write_end(iocb, mapping, pos,
>                                       len, copied, folio, fsdata);
>
>         trace_ext4_da_write_end(inode, pos, len, copied);
>
> -       if (write_mode !=3D CONVERT_INLINE_DATA &&
> -           ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA) &&
> -           ext4_has_inline_data(inode))
> +       if (write_mode & EXT4_WRITE_DATA_INLINE)
>                 return ext4_write_inline_data_end(inode, pos, len, copied=
,
>                                                   folio);
>
> --
> 2.47.3
>
