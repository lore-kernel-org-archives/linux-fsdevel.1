Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BCF283FCF
	for <linux-fsdevel@vger.kernel.org>; Sun,  3 May 2026 23:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777851505; cv=none; b=r4ik0jpU2GNSpBOkjE+fvfUGujOeSZ1iLyYJBLoFh93hOGxvUWhy3odV9UizGZ8TmO2vaTcghcViFx95pP/VQihJPO61yMwC7lpqUpx/5Z/gw7YyoWQHZOTtX3HQ2eUNFKjmSne0IX1wwaD9NWjOWZ74nKcQXV3jMdnZYxmCF7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777851505; c=relaxed/simple;
	bh=DMkeLNSRw0Vipi8kPqVoRPzGkix24BZuW6Cu0MPUu6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EsFlXgKbwlNbtEEiS0yM7kh8wqDrKkzCA+g/XoHV0+wAIudGnbMqOteErk45EsAECkNQ7CXnMkD88b1dHRHGBexns3y4DTMaAlEANvbUnd57RXvoecW2uUtx0vjMmg5COMVSQqup+vebkeYMJGwJti1Ziz17jUeKNDCo15fXJhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W1fX7qI5; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1fX7qI5"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-835386ff122so846515b3a.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 03 May 2026 16:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777851504; x=1778456304; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lkQeaIxqH1YwX1zzJwc9tP4I54nuab427z7yS8l8uFQ=;
        b=W1fX7qI5h2z9+Jwfj7MNBkauDUhfPrMYMKePcmhrWcukRfMsyS5hhnFVczb/zlfn3G
         rqLCzJMwAIhoTilSRi8mq3Yp/POmIXCJb6pEwinMEv02vv5pJd/V/A7hPXalTh5DDeY7
         9UwrO9qgLnQkHfs+wQlCcc/btmHBWdl/cFk6/SyXIlTo4g8t3EfKB1SIdrNRSMZKK2aQ
         TCg/JtYT6IU7Tger3cEh/1zOh0xR/83PYMKD2N6mZIdSNDfOqIgZihEZXsen5+64zESl
         oSPtckTrHeIBR/2J4qpi0HnuR8lvmWY1wggrWgw7egJENuNJoljuWdOjrTrhxfQM++mD
         S96w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777851504; x=1778456304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lkQeaIxqH1YwX1zzJwc9tP4I54nuab427z7yS8l8uFQ=;
        b=o2Zv2B4Djg/yj+juDLzBaY22+mK33ZMPub0deU+GtisUN2k7j4yaZuL9YLOA9Wvn+J
         zH2ocMdq264aPXnsv0h919iqiusWYfgq2nM++9SLrXc9RDFflc3T6O2rA5wZgPdkWmnp
         C96ByOtHXSHjtTFkL9OaU8DfBDGM/x8YWnpmuYI4mjLF2EUhPtzB7DaGTwiJZCmeCNFI
         6Ye6vEcPtloitdHWHGkeJ7vEPNc/88UnQ9KFeDPbbuScMPhge67XaBzNPKHYdO31JbRQ
         wJoI0NcSDpD8xVC1lH9KkFHp0U6/4AO1l30uhvMpJrDDBGcvdDAY86fXbTpkDRscc6Kb
         V67g==
X-Forwarded-Encrypted: i=1; AFNElJ+LKsNWKmnfMKt2+ZYvB7EZxI5OYd0xnES0OnIVfeUkAD9+M2HrBULl+fHbz0Z3G6u99xnydvyGG3W/9maP@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4U8B7ZiP7WVVnQ9o3n+xX90iYP+zFykmdQYcUJB2hJ3jMXm7m
	iaPcqgYCI2XrLl/ZLwDt5NirNJ8l/8K9/1d4sJ9dwvTWr+YXoLs15BFR
X-Gm-Gg: AeBDietbkgsutwkj1WdZ+mtej93zJfF5s7Fh2m2pLpmSsayxEmEpazp2+2TB5cYM2Jo
	a90ZNzsBcAAn6JfKRFOTU5BmtOTKSWUxYuGGXQI2+PBxMp/oJr2VlaKq1pfdF9SU/Vgv7Vii38s
	UoE4o16+Nuql5hcIMPpigqQSBf5/oyIC5Kr9xPlv92iQbxYuLZr5Pzti8VtuaQ7DNsUj1cGqZex
	v4uzjKkrd7dhCc42WBU8JJFnu+Lgq8X2mQBqKUGLzB8ryFSbNrtSIMA+uRTWnCegEkgGn1uD7e/
	fMkif2qOqrnzw2L6MZYOFT5Hfj8moMjca/goP939MPa/hAmHn8glsqrKVb6/QBEWhYrNdMtsQzo
	a+pNCqIJ89dQl4mH2XSyBImDWL2aGhZrK1nPKjGlYkcE1H44T0/C2oz5CksZ+kdTdLmkr970Ld0
	fAbL/iUx3mdHfpT3bjpiihsjMI
X-Received: by 2002:a05:6a00:448b:b0:82c:d986:e917 with SMTP id d2e1a72fcca58-8352d17725cmr7352994b3a.22.1777851503953;
        Sun, 03 May 2026 16:38:23 -0700 (PDT)
Received: from localhost ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515ad0049sm10284197b3a.33.2026.05.03.16.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 16:38:23 -0700 (PDT)
Date: Mon, 4 May 2026 08:38:21 +0900
From: Hyunchul Lee <hyc.lee@gmail.com>
To: DaeMyung Kang <charsyam@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ntfs: avoid use-after-free of index inode in
 ntfs_inode_sync_filename()
Message-ID: <affcbaq5uSsK4XCo@hyunchul-PC02>
References: <20260502004916.492207-1-charsyam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260502004916.492207-1-charsyam@gmail.com>

On Sat, May 02, 2026 at 09:49:16AM +0900, DaeMyung Kang wrote:
> ntfs_inode_sync_filename() walks every FILE_NAME attribute and, for
> each one that points at a different parent, opens the parent index
> inode with ntfs_iget() and locks index_ni->mrec_lock.  All three error
> branches (NInoBeingDeleted, ntfs_index_ctx_get failure, ntfs_index_lookup
> failure) drop the parent reference before unlocking:
> 
> 	iput(index_vi);
> 	mutex_unlock(&index_ni->mrec_lock);
> 	continue;
> 
> index_ni is NTFS_I(index_vi), so the ntfs_inode (and its mrec_lock) is
> embedded in the inode allocation.  If the parent directory is not held
> outside the icache - no open dentry, recently evicted from dcache, no
> other concurrent lookup - ntfs_iget() returns with i_count == 1 and
> our iput() drops the last reference.  evict_inode() then runs and
> destroy_inode() schedules the slab object for RCU free, while
> mutex_unlock() on the next line is still touching index_ni->mrec_lock.
> 
> Swap the order so the mutex is dropped while index_vi is still alive,
> matching the success path at the bottom of the loop which already
> unlocks before iput().
> 
> Reproduced under KASAN with a debug build that forces
> ntfs_index_ctx_get() to fail when the parent index inode has been
> opened with i_count == 1.  KASAN reports a slab-use-after-free read
> on the parent's mrec_lock from mutex_unlock() on the writeback worker:
> 
>   BUG: KASAN: slab-use-after-free in __mutex_unlock_slowpath+0xb5/0x970
>   Read of size 8 at addr ffff8880014b7598 by task kworker/u8:0/12
>   Workqueue: writeback wb_workfn (flush-253:0)
>   Call Trace:
>    mutex_unlock
>    ntfs_inode_sync_filename
>    __ntfs_write_inode
>    ntfs_write_inode
>    __writeback_single_inode
> 
>   Allocated by task 103:
>    ntfs_alloc_big_inode
>    ntfs_iget
>    ntfs_lookup
>    __x64_sys_mkdir
> 
>   Freed by task 12:
>    ntfs_free_big_inode
>    i_callback
>    rcu_do_batch
> 
>   Last potentially related work creation:
>    call_rcu
>    destroy_inode
>    evict
>    dispose_list
>    evict_inodes
>    ntfs_inode_sync_filename
>    __ntfs_write_inode
> 
>   The buggy address belongs to the object at ffff8880014b7440
>    which belongs to the cache ntfs_big_inode_cache of size 1800
> 
> The freed object is the parent directory inode itself: allocated by
> mkdir(2) via ntfs_iget(), then released through call_rcu(i_callback)
> that destroy_inode() scheduled when evict_inodes() ran from inside
> ntfs_inode_sync_filename().  Re-running the same workload with
> mutex_unlock() moved before iput() runs cleanly under KASAN.
> 
> Fixes: af0db57d4293 ("ntfs: update inode operations")
> Signed-off-by: DaeMyung Kang <charsyam@gmail.com>

Looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

> ---
>  fs/ntfs/inode.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
> index 16890d411194..360bebd1ee3f 100644
> --- a/fs/ntfs/inode.c
> +++ b/fs/ntfs/inode.c
> @@ -2582,8 +2582,8 @@ int ntfs_inode_sync_filename(struct ntfs_inode *ni)
>  
>  		mutex_lock_nested(&index_ni->mrec_lock, NTFS_INODE_MUTEX_PARENT);
>  		if (NInoBeingDeleted(ni)) {
> -			iput(index_vi);
>  			mutex_unlock(&index_ni->mrec_lock);
> +			iput(index_vi);
>  			continue;
>  		}
>  
> @@ -2591,8 +2591,8 @@ int ntfs_inode_sync_filename(struct ntfs_inode *ni)
>  		if (!ictx) {
>  			ntfs_error(sb, "Failed to get index ctx, inode %llu",
>  					index_ni->mft_no);
> -			iput(index_vi);
>  			mutex_unlock(&index_ni->mrec_lock);
> +			iput(index_vi);
>  			continue;
>  		}
>  
> @@ -2601,8 +2601,8 @@ int ntfs_inode_sync_filename(struct ntfs_inode *ni)
>  			ntfs_debug("Index lookup failed, inode %llu",
>  					index_ni->mft_no);
>  			ntfs_index_ctx_put(ictx);
> -			iput(index_vi);
>  			mutex_unlock(&index_ni->mrec_lock);
> +			iput(index_vi);
>  			continue;
>  		}
>  		/* Update flags and file size. */
> -- 
> 2.43.0
> 

-- 
Thanks,
Hyunchul
