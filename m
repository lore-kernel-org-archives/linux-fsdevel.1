Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE6E8248B
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 May 2026 01:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777857686; cv=none; b=AhUVNQwMyH3S9LX3hPsz+xzEMPCJxuqcAOgn15wyrz/mbyZoj86DxH4y6aekPqJldLidnSZY5oCJNTzZVSUVp9zfDeTzIPHHLy08y3fqyipFmjeS/brRURHP8WhiTPT9/n6TC5av2tsEFXCMWl2rniDW7itHZ8E2mAHKGK+f6XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777857686; c=relaxed/simple;
	bh=zAYJoNUaBELZR3WB64We+ZfbxOb79lINvAnLRbwhS7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kc1J9j6kYhTVnvbbURrXukGCMJ0w/1JEbSvCJ3OPl/DTG/uKN5NeDAqY7dmwHPFZVuXlI6bK1Uv/tYk9oQs6fEO/dFLAhG5Iol1t4AmM+2EwsK/I6/wLxrud8JrDtON8pxwuOMG7m2q/CQKjFieV4qV/OiKsWch8Q4ism2gMvoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OLr6W0MD; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLr6W0MD"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8379e010b01so117974b3a.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 03 May 2026 18:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777857684; x=1778462484; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TcjgVgeoOS+w7RApS/0PsoWQn2J16/2RVvUFUY/yrxg=;
        b=OLr6W0MDkRFdtFCY9kST7tNIXRj7dZeKJPbreeIPjSh3eko0ejdFAzAn0BamcsQcUM
         gSL9vQzg58ytDVCebgZ5QLF10TtWqI9U1UZLa+RjT04mdFD0t2Wr0DTUCV7XEq0vBd8F
         AyY/1WafjIXU6GreIpjFRJhb+YsOH9zZZEtui2fmHv+2vcBtT20mfjGKHTKjO2G3+yPk
         HkoW9RQID2YIRCcqhs0hO2iORE90Ot8kFuGXNkhxirDPcRZg8CLTGzClGrUJPRzliuvB
         VJRTrNP7920Wz/185cnfgNSJfP6gU8AmQzcmNU483C3JHZB++pb2BAd7RVhF7wEtuuPu
         Eq3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777857684; x=1778462484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TcjgVgeoOS+w7RApS/0PsoWQn2J16/2RVvUFUY/yrxg=;
        b=negiHbf3NmXzjvv4tFoHfg/qxPljLeEEjgebb47O3ejnb2n0K55gJx6C2mW8CmpfYl
         rLlaYz5If8NL0YcoHs0eKcJTbGqIJrQzunWUSBWvLceaBqsxchH+xHxTLmIUc7KFh4GO
         abGuK1aqOAQflEE4w6JNN7XlrOhVzo3kK4Pvt26wYld8/ppEZAX2nP3LE+jJEY+a+0Jy
         LXZmuAcDCWOZijwVogKWPMI3bD/++ErEQ9blfpIsntVnx/mRwU4bP0hDcuTYwqMGhFeN
         NEoQ2XI0AYGC0P0NeDnuVPG8XqZ5pXu+S1NIMnRAdpru9nyADQtF/PILe2HRz5V4mxb7
         Z2aw==
X-Forwarded-Encrypted: i=1; AFNElJ+Be0AbXx9XW1skp8VU1/JyJx+J2aOacrxrPbK4mCGt1BKpGO6takhJyo1NWluWMFe9qvWWcR86Jq5XVunH@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2cFUxUPLRbfTfaO13SZBQfi6OvvXUbYoJoQwfaHZ2eBB9TCT/
	aS/DsgdVyjMhzI0ieLlfgLWXCf3BJYcoeIyOXJUSv/tSoJnq0XkODncC
X-Gm-Gg: AeBDieuHzMHKuEcawb3+F1RfXkxibYXbGjPx1VZMFiphohJrqabNkQk3WGAgH9ef5zk
	qBnWd7y43HgK3l1suVOyaUkT5oqjYjzuFyZ7ErsyVaKBFHW+THqVMGk951XWQqwlLV7drC6/jLf
	57gg7dd6FtCWfrj7mJNFjjYiOdeu/+ZtAb8nyT0N9q0NuKPR/Bxp8LXrUehgezcNnq9wbBdd0ju
	TuwDq/b3i4eAIghI/pnkd1E0KkAy7xWZVvMta3HtjtSfadoIaOzHXx7JLnn/eZU8w7x/vPgP8Tw
	GvjeR4nX7lJAYjBpc8SMUDnJjePvey3JYyaRSgr7LMFABDxP33/vMa6PGfMs0RmAfv1ZJAU71Oi
	5GvX11SKp1ipn+oqzRYzXTTKyjIczuST9YouxkiC4FXnSNDx+uO06fu9HSU+3z3KICSXJM110am
	rT09aE70WfQoI277wJPCtfCRAI
X-Received: by 2002:a05:6a00:4b4f:b0:82f:8a29:e3de with SMTP id d2e1a72fcca58-8352d282e4amr6973731b3a.40.1777857684403;
        Sun, 03 May 2026 18:21:24 -0700 (PDT)
Received: from localhost ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8353f8b0228sm4449945b3a.15.2026.05.03.18.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 18:21:23 -0700 (PDT)
Date: Mon, 4 May 2026 10:21:21 +0900
From: Hyunchul Lee <hyc.lee@gmail.com>
To: DaeMyung Kang <charsyam@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] ntfs: wait for sync mft writes to complete
Message-ID: <aff0kZFdQsa2_hme@hyunchul-PC02>
References: <cover.1777568957.git.charsyam@gmail.com>
 <afaac877edbd92ee82bb443ca35fd110f823a31d.1777568957.git.charsyam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <afaac877edbd92ee82bb443ca35fd110f823a31d.1777568957.git.charsyam@gmail.com>

On Fri, May 01, 2026 at 02:20:53AM +0900, DaeMyung Kang wrote:
> ntfs_sync_mft_mirror() and write_mft_record_nolock() with @sync set
> are both documented as synchronous, but neither actually waits for
> the bio they submit nor inspects bi_status.  write_inode() can
> return success while dirty mft record bytes are still in flight, and
> bio errors are silently dropped: the volume is not marked with
> errors and the inode is not redirtied.  This breaks fsync()/sync
> metadata durability.
> 
> Switch ntfs_sync_mft_mirror() and the @sync path of
> write_mft_record_nolock() to submit_bio_wait() and propagate the
> returned error to the caller.  Capture ntfs_sync_mft_mirror()'s
> return value at its call sites in write_mft_record_nolock() so a
> mirror write failure surfaces too.
> 
> The @sync parameter only controls the main MFT bio.  The !@sync main
> submission is therefore unchanged and still uses ntfs_bio_end_io() to
> drop the folio reference taken before submission.  The mirror call
> has always been documented as performing synchronous I/O regardless
> of @sync, so making it actually block restores the originally
> intended contract for both @sync and !@sync callers.
> 
> Note this only fixes the synchronous mirror/main paths reachable
> from write_mft_record_nolock().  The main MFT write submitted from
> ntfs_write_mft_block() (the .writepages path) still does not wait
> for completion or check bi_status; that requires a larger
> restructuring and is left to a follow-up patch.
> 
> Fixes: 115380f9a2f9 ("ntfs: update mft operations")
> Signed-off-by: DaeMyung Kang <charsyam@gmail.com>

Looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

> ---
>  fs/ntfs/mft.c | 63 +++++++++++++++++++++++++++++++++------------------
>  1 file changed, 41 insertions(+), 22 deletions(-)
> 
> diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
> index 7d989267a82b..4051b4823162 100644
> --- a/fs/ntfs/mft.c
> +++ b/fs/ntfs/mft.c
> @@ -449,7 +449,7 @@ static void ntfs_bio_end_io(struct bio *bio)
>  int ntfs_sync_mft_mirror(struct ntfs_volume *vol, const u64 mft_no,
>  		struct mft_record *m)
>  {
> -	u8 *kmirr = NULL;
> +	u8 *kmirr;
>  	struct folio *folio;
>  	unsigned int folio_ofs, lcn_folio_off = 0;
>  	int err = 0;
> @@ -479,6 +479,7 @@ int ntfs_sync_mft_mirror(struct ntfs_volume *vol, const u64 mft_no,
>  	kmirr = kmap_local_folio(folio, 0) + folio_ofs;
>  	/* Copy the mst protected mft record to the mirror. */
>  	memcpy(kmirr, m, vol->mft_record_size);
> +	kunmap_local(kmirr);
>  
>  	if (vol->cluster_size_bits > PAGE_SHIFT) {
>  		lcn_folio_off = folio->index << PAGE_SHIFT;
> @@ -490,20 +491,22 @@ int ntfs_sync_mft_mirror(struct ntfs_volume *vol, const u64 mft_no,
>  		NTFS_B_TO_SECTOR(vol, NTFS_CLU_TO_B(vol, vol->mftmirr_lcn) +
>  				 lcn_folio_off + folio_ofs);
>  
> -	if (!bio_add_folio(bio, folio, vol->mft_record_size, folio_ofs)) {
> +	if (bio_add_folio(bio, folio, vol->mft_record_size, folio_ofs))
> +		err = submit_bio_wait(bio);
> +	else
>  		err = -EIO;
> -		bio_put(bio);
> -		goto unlock_folio;
> -	}
> +	bio_put(bio);
>  
> -	bio->bi_end_io = ntfs_bio_end_io;
> -	submit_bio(bio);
> -	/* Current state: all buffers are clean, unlocked, and uptodate. */
> +	/*
> +	 * The in-memory mirror is now valid because we just memcpy()'d the
> +	 * mst-protected mft record into it.  Mark the folio uptodate even on
> +	 * write error so a subsequent read_mapping_folio() does not refetch
> +	 * the stale on-disk mirror and overwrite this copy.  The error is
> +	 * propagated to the caller via @err.
> +	 */
>  	folio_mark_uptodate(folio);
>  
> -unlock_folio:
>  	folio_unlock(folio);
> -	kunmap_local(kmirr);
>  	folio_put(folio);
>  	if (likely(!err)) {
>  		ntfs_debug("Done.");
> @@ -588,20 +591,36 @@ int write_mft_record_nolock(struct ntfs_inode *ni, struct mft_record *m, int syn
>  		}
>  
>  		/* Synchronize the mft mirror now if not @sync. */
> -		if (!sync && ni->mft_no < vol->mftmirr_size)
> -			ntfs_sync_mft_mirror(vol, ni->mft_no, fixup_m);
> +		if (!sync && ni->mft_no < vol->mftmirr_size) {
> +			int sub_err = ntfs_sync_mft_mirror(vol, ni->mft_no,
> +							   fixup_m);
> +			if (unlikely(sub_err) && !err)
> +				err = sub_err;
> +		}
>  
> -		folio_get(folio);
> -		bio->bi_private = folio;
> -		bio->bi_end_io = ntfs_bio_end_io;
> -		submit_bio(bio);
> +		if (sync) {
> +			int sub_err = submit_bio_wait(bio);
> +
> +			bio_put(bio);
> +			if (unlikely(sub_err) && !err)
> +				err = sub_err;
> +		} else {
> +			folio_get(folio);
> +			bio->bi_private = folio;
> +			bio->bi_end_io = ntfs_bio_end_io;
> +			submit_bio(bio);
> +		}
>  		offset += vol->cluster_size;
>  		i++;
>  	}
>  
>  	/* If @sync, now synchronize the mft mirror. */
> -	if (sync && ni->mft_no < vol->mftmirr_size)
> -		ntfs_sync_mft_mirror(vol, ni->mft_no, fixup_m);
> +	if (sync && ni->mft_no < vol->mftmirr_size) {
> +		int sub_err = ntfs_sync_mft_mirror(vol, ni->mft_no, fixup_m);
> +
> +		if (unlikely(sub_err) && !err)
> +			err = sub_err;
> +	}
>  	kunmap_local(kaddr);
>  	if (unlikely(err)) {
>  		/* I/O error during writing.  This is really bad! */
> @@ -617,10 +636,10 @@ int write_mft_record_nolock(struct ntfs_inode *ni, struct mft_record *m, int syn
>  	bio_put(bio);
>  err_out:
>  	/*
> -	 * Current state: all buffers are clean, unlocked, and uptodate.
> -	 * The caller should mark the base inode as bad so that no more i/o
> -	 * happens.  ->drop_inode() will still be invoked so all extent inodes
> -	 * and other allocated memory will be freed.
> +	 * The caller should mark the base inode as bad so no more I/O
> +	 * happens. ->drop_inode() will still be invoked so all extent inodes
> +	 * and other allocated memory will be freed. ENOMEM is retried by
> +	 * redirtying the mft record below.
>  	 */
>  	if (err == -ENOMEM) {
>  		ntfs_error(vol->sb,
> -- 
> 2.43.0
> 

-- 
Thanks,
Hyunchul
