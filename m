Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42DC29E117
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2026 22:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779834463; cv=pass; b=ZhFMesJNWFoJsk0pyxX2Ovn7GnZxA6FXpt9VOSe1LfarBneeekRooXajjO7ZG89mdC3LB6CKMy2dhB/YezW8E+7Nvgq5qHxlADL+sS6AVpyKZxLDbTaKhaCstbbYNHaVsz94EmPwP/eK2meILHeEHO5jxSj8q/zLIH2br72SR+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779834463; c=relaxed/simple;
	bh=maV0I1NP1jCCX5+dedi7fheJJXGKqM11o/zLxwZPxsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HtZzaOI75tTLiPMcg5AJHKgOqosOjExW7nUH5EB1SMHU/f4h0YlvGQvKYmyI6+QfD2fwNYGnrzNxJzeVtMcD3cEuvXly8OXKVBgVgSblPhlLXJidyv9qOUonxE/7Yc6lm8pOLhZZoKXREeSMdt5ndGzyNs+VMiSELzbrNaEATic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NsdD7vGH; arc=pass smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NsdD7vGH"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-69d79fc48d2so3556696eaf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2026 15:27:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779834461; cv=none;
        d=google.com; s=arc-20240605;
        b=bvzK22qsScujxPaBcWNvpjv8wDWVJ8MX32dw0IJvfjvcGO5gXy5i+Qw6eh64u0ctI9
         2NU75Aan3rF8Z2hj90DZWgLqPNnV9Wa+Q+W8ruWYMDzpF6tzmaGwlJ+3IL/2Qb5dd5wb
         ZgPEPkJWCiTEakhBKnzvxg/iBaxlMsZJ4droHrseewSB/TevBOUlyO1UmcEAsSmLe4gE
         8+DcDGnHmsj769u8wHw0m4fiKKer4GQcdeCL+MCykSmOYQ9KJS1oGRC0BZ/hodjxc84k
         kd1Xvv9Gt3dEGp/Ulo3k4CdgqCwYfpZtyU8PCTfSC8nT0xviQl5IwYK4T0UXjbkp9jrY
         MRtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=wNoZs0zJdjzOYeBqS2/JyRw3os+7in3fs8BDVUaB6YY=;
        fh=CGpOe2swFKxRzgtGF/SZQMqT8VELxlu6FIHQG9O+H00=;
        b=VktK9YipAEixbr5bMHpfDEUPwK/AeAaj4/hh6iKzWu5sAUfjnQdEGwqxAfsh2uMVLc
         DgVxRAsIfUY4C2BDjwj31dVLjhb5KrZViaiw2JfM/wZyeMIDTUuGAllnNqfi0BnV3Xyx
         RBqiAAmfAhRkWrl08iEtbt84X4gaFzFQU0lE6ms4N3zXBxKM/tkma1/kX0Z9KGZeo1gj
         PU23dfi3rVWRs0n9BvYjOmf7sx97wD1/78HG1BzZEqMnFjHa1usECygDMKEB/kyGL8ol
         Fzq7IAxrvzqMQTRSwEvDqEXqesQ60THH7o5YscGrD55OLAPnMOewJFHzqom7T9zO+VI7
         gxEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779834461; x=1780439261; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wNoZs0zJdjzOYeBqS2/JyRw3os+7in3fs8BDVUaB6YY=;
        b=NsdD7vGHzCStiMDHXI++Y/dwJxjIp+QVIrBPyHBaieLWFCbCiTTH+PGZwE6o+lP+Df
         TEP8qOWcUWYdC6/t8trrjPyy1wp5gg4Ez8Vc01gbE9YsO57nZYKef3+tIO+gcFegM7+6
         RF5pqaRK+rtZkBeheKquVmhb3QjdTOwrjXQVaZN+Gm5gdaqF95nh9O0iF4Z/4/UYoICk
         pWLf7Lm27c5FEfgith6MgkC79MRx6p5O9NzXV9p/1yHV+AMSXk74izIsF+GhioAeq3ZM
         /IimCy5r3ONnZX7M8JCwKIHEbr7QpvjTlnYVPuU9vAbIiyi2vazdoswR/oO1DF0uZPOw
         MPJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779834461; x=1780439261;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wNoZs0zJdjzOYeBqS2/JyRw3os+7in3fs8BDVUaB6YY=;
        b=PrV7HooE7GCLW2upjGGBEsQC6FepKO8FoQeUktltSh73UoG/WZxVYZOG1fIHb11s/m
         yAPtAbetsIFelHp5h0jWP2QF1Rn85yeB+2hnYvWPubBXEJvPLFTecTvs4f15/YY3vSGX
         sBS/32pNHlMvDiTQFiDLJpp4Gpp1dsvB4T/prs2NfxPCib682a5yCBg+mTVfi3Ap45Mw
         2hdWFNaPmdpZYBzgerfaRo+WoL51VBRZZR0xTSGilxzTofmSZ91F9n5v/uDklstwjgkf
         p2sUCjrgINYJCUFNNK+QX3SOdG9UQP92faf7NLJFbGtU8hkwsMGnq/QdKUf0O+jmRB4J
         equw==
X-Forwarded-Encrypted: i=1; AFNElJ/RcZZGMmmcaONhJr/iiVa71dVC9I5e4H7+VKdGrIgiZT+9rJU9OzU8+dNFeKmOnD6tTFA6sTy1gTUFWK0S@vger.kernel.org
X-Gm-Message-State: AOJu0YzokTZGgUFAqY0Yp5CRbUhEYXaUFWqERC/YeI6VzU0sCPzaOpg0
	F6vikxdxIuHDcO+yJjrtiDxnyNOsfqxoUb52bNFN7wVdPNdrmcqu3HOuijTjJmJwUzromBkJ+3C
	Gb2t8sqkrjGIyFF0Sl59zCx9PsdXoI5aiGIRc
X-Gm-Gg: Acq92OHrgzeoq6YXYIRW4sitZWZPgiPjXczYZXzGy67M4LrZt98JE0imr7WYU7nVLzS
	UeHMdAM5PCwSXAm5YgVZtYN8IUgLnh1PTiGTqnz80TBhhqunHUpE8kFLyA6sJlgtupuu0YpE6p6
	u/SvweIEYFoaNs2k4a+iKNtBaQgkqHWVtFJc2k6VulpR2lsSAMQdyA0NRmflWBGdHaX4Yil3m+7
	wdy4FuwvsNdzjJ6FJEzR0TsOsD+MTm6FFM8vI1R/vw2OIuGs2Yt+KZJk9wDZyo+ky/j0aZ+vl1Y
	elz0118uryYsfbVR
X-Received: by 2002:a05:6820:1612:b0:696:982b:1c24 with SMTP id
 006d021491bc7-69d7ece2e97mr10610014eaf.57.1779834460731; Tue, 26 May 2026
 15:27:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260525171931.4144395-1-willy@infradead.org>
In-Reply-To: <20260525171931.4144395-1-willy@infradead.org>
From: =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date: Wed, 27 May 2026 00:27:29 +0200
X-Gm-Features: AVHnY4LmuYpZHB23ToMLo1n7WZk_snTqqB948WU5CJiroL1sdwP-ZA6HSyOYucc
Message-ID: <CAHpGcMJX+6qctmM6TRJ-0cin_nOiFM4GM8BNeF=TzKfM8BP8XQ@mail.gmail.com>
Subject: Re: [PATCH 00/34] Remove b_end_io from struct buffer_head
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Am Mo., 25. Mai 2026 um 19:18 Uhr schrieb Matthew Wilcox (Oracle)
<willy@infradead.org>:
> There are three benefits to this patchset.  First, it removes an
> indirect function call from the completion path.  Instead of setting
> bio->bi_end_io to end_bio_bh_io_sync() which then calls bh->b_end_io(),
> we set bio->bi_end_io to the appropriate completion handler, replacing
> two indirect function calls with one.
>
> Second, there is a slight security advantage to this.  It is one fewer
> function pointer in the middle of a writable data structure that can
> be corrupted.  Third, it shrinks struct buffer_head from 104 bytes to 96
> bytes, allowing for appropriximately 7% reduction in the amount of memory
> used by buffer_heads (or, alternatively, allows 7% more buffer_heads to
> be cached in the same amount of memory).
>
> I've run ext4 through its paces, and everything seems OK.  I've only
> compiled ocfs2/gfs2/nilfs/md-bitmap.  Hopefully the maintainers can give
> this series a try.  I'm sending the entire series to linux-fsdevel
> and cc'ing the fs-specific mailing lists for the fs-specific patches.
>
> I have some unresolved thoughts while working on this:
>  - Should gfs2_aspace_write_folio() be passing its wbc into __bh_submit()?

gfs2 doesn't support cgroups, so I don't think it would make a difference.

>  - Should we allow callers of bh_submit() to pass in NULL instead of
>    bh_end_read / bh_end_write and infer which one to use from the opf
>    being REQ_OP_READ or REQ_OP_WRITE?
>  - Should some of these callers of bh_submit() be calling higher level
>    functions in buffer.c insteaad?  eg nilfs_mdt_submit_block() could
>    call __bh_read().

- The only caller of end_buffer_read_sync() outside of fs/buffer.c
left at the end of his patch queue is gfs2_meta_read_endio(), so I
wonder if end_buffer_read_sync() should be inlined into its remaining
two callers and removed.

> Matthew Wilcox (Oracle) (34):
>   buffer: Remove forward declaration of submit_bh_wbc()
>   buffer: Add bh_submit()
>   buffer: Remove mark_buffer_async_write_endio()
>   buffer: Add bh_end_read(), bh_end_write() and bh_end_async_write()
>   buffer: Convert write_dirty_buffer to bh_submit()
>   buffer: Convert __bread_slow to bh_submit()
>   buffer: Convert __sync_dirty_buffer to bh_submit()
>   buffer: Convert __bh_read to bh_submit()
>   buffer: Convert __bh_read_batch to bh_submit()
>   buffer: Convert block_read_full_folio to bh_submit()
>   buffer: Convert __block_write_full_folio to __bh_submit()
>   ext4; Convert __ext4_read_bh() to bh_submit()
>   ext4: Convert ext4_fc_submit_bh() to bh_submit()
>   ext4: Convert write_mmp_block_thawed() to bh_submit()
>   ext4: Convert ext4_commit_super() to bh_submit()
>   jbd2: Convert journal commit to bh_submit()
>   jbd2: Convert jbd2_write_superblock() to bh_submit()
>   ocfs2: Convert ocfs2_write_block to bh_submit()
>   ocfs2: Convert ocfs2_read_block to bh_submit()
>   ocfs2: Convert ocfs2_read_blocks to bh_submit()
>   ocfs2: Convert ocfs2_write_super_or_backup to bh_submit()
>   gfs2: Convert gfs2_metapath_ra to bh_submit()
>   gfs2: Convert gfs2_dir_readahead to bh_submit()
>   gfs2: Remove use of b_end_io in gfs2_meta_read_endio()
>   gfs2: Convert gfs2_aspace_write_folio to bh_submit()
>   buffer: Remove mark_buffer_async_write()
>   nilfs2: Convert nilfs_btnode_submit_block to bh_submit()
>   nilfs2: Convert nilfs_gccache_submit_read_data to bh_submit()
>   nilfs2: Convert nilfs_mdt_submit_block to bh_submit()
>   md-bitmap: Convert read_file_page and write_file_page to bh_submit()
>   buffer: Remove submit_bh()
>   buffer: Remove b_end_io
>   buffer: Remove __end_buffer_read_notouch()
>   buffer: Remove end_buffer_write_sync()
>
>  Documentation/filesystems/locking.rst |  14 -
>  Documentation/trace/ftrace.rst        |   4 +-
>  drivers/md/md-bitmap.c                |  27 +-
>  drivers/md/raid5.h                    |   6 +-
>  fs/buffer.c                           | 372 ++++++++++++++------------
>  fs/ext4/ext4.h                        |  10 +-
>  fs/ext4/fast_commit.c                 |   8 +-
>  fs/ext4/ialloc.c                      |   5 +-
>  fs/ext4/mmp.c                         |   4 +-
>  fs/ext4/super.c                       |  16 +-
>  fs/gfs2/bmap.c                        |   7 +-
>  fs/gfs2/dir.c                         |   6 +-
>  fs/gfs2/meta_io.c                     |  11 +-
>  fs/jbd2/commit.c                      |  13 +-
>  fs/jbd2/journal.c                     |   3 +-
>  fs/nilfs2/btnode.c                    |   3 +-
>  fs/nilfs2/gcinode.c                   |   3 +-
>  fs/nilfs2/mdt.c                       |   3 +-
>  fs/ocfs2/buffer_head_io.c             |  20 +-
>  include/linux/buffer_head.h           |  16 +-
>  mm/vmscan.c                           |   2 +-
>  21 files changed, 280 insertions(+), 273 deletions(-)
>
> --
> 2.47.3

Thanks,
Andreas
