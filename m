Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3A03B6BFD
	for <linux-fsdevel@vger.kernel.org>; Sun,  3 May 2026 23:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777851831; cv=none; b=iiI+zPQe0t5AvdyeZMALMEYC1vGEZrcmgi2b33TzEvJ/TzQNfuVVAl0xEJxz4gz/8SfAeW78Z5wlgys6xCHVuPnvOcXOe/vTu3TeYzeCWd9Epfu7zDCOC+fh501LwWiXkzOqVVjKIfEAzTV1sey1OAPgahBZoKXIii/3XncRdT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777851831; c=relaxed/simple;
	bh=TryQAaeaNl/WXC7Qho3o9IsCF/vU53RKO8+s0gaKOHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YU+UFt4PiAU51CgXyfhJWDXQfighYwPYR6bRpHLucu+bErFJHoBggJudadPZNpG3gQ6jey3LPIVxm7YTOylOzv4pmKRoIpfPhE+hsjqfqjEPaNvcYgHM/WkJZkDwBiC8NeAcAH0y1wLgOS8TkY+ajPISvy82Kn52ufC30tLED84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/IruFlj; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/IruFlj"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3567e2b4159so2711733a91.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 03 May 2026 16:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777851829; x=1778456629; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qxh7Fo/FDfHbi8FcrwiUdR6St43t90VEqeAwgvmBj5A=;
        b=O/IruFljqz/9VAOV0iUQja8NkHI9OBMWE4bbvH9O1VJREYVlIRB7UfynryP6KFwKqv
         NKdMmjgovTz6UKk0R2cLIVYbz+RP6D3pvhIxSlGQqJenfrvpJ7JEy2y2YHqiRXFssODu
         gKs4kylXn0CUGjYQfocmkPtKKhD98ZRbxIvbmnEwohwCeob+iCuxHW9II7XJbuwg4f20
         g7U6Y34IR7ud5MX8sdU7Sl84+SOhds9UI4/Eq8IqwkROd0VREAVF57MYZh0uWeA3j7xG
         KcSZs1MoB8tD595X9Kf239m1T9sdxN72HOGG6JGJW1wiE/Sc0QiaJ9+YwZFNRfRu2BiK
         mXSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777851829; x=1778456629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qxh7Fo/FDfHbi8FcrwiUdR6St43t90VEqeAwgvmBj5A=;
        b=byY5jz7hRpPeTECjXEOIVbs3HWMGafd7n21nmTOI/ZCx9XAUUZ5hHmKwsuC4mSKe3B
         xxhe1rxvVToSwRNkPYQH/PB5Ggru3k3vHPOcODjV2CdD4i8jYXArBXALAQkpzYvPUtYR
         RMOF5aABybA6GneH/rgUcftNXCCDXIOItLc2lZsXci9XdGIHV7TIDhICV4yqpLUBZ9Wf
         bQfXR2UVex1Vm71rx1kWPQ0GUdXOG44/FDJgD6pkAf7flPycytkovO5Z2ZnAd+Y8n639
         CvzmD4HZ/WTNPo7cxjDlPX3gYIUtE3Ci+HTy3o/jVdyL/bEaM/HIz2VjCuFWURho+GJh
         XFMw==
X-Forwarded-Encrypted: i=1; AFNElJ/h8IIQXGkAP9U4tG1PwD+31JvjbNEXglV5FZZNm6vydaWuyY4xXFW986CeR7Yu7Pdqo/7mI29jDh2MfpA5@vger.kernel.org
X-Gm-Message-State: AOJu0Yzho9zXZ1oLWF1RI1U9YLSprEc2iJ1e1A7QWhPz5OP3TWL8CL6g
	nKeG5YgrUYz3zKasRzdvWPODep8EPj98bTl+rZ/Yl48s/Tq07LnIc9jP
X-Gm-Gg: AeBDieu4JEJDI9MlRk0wbJP36ffqe7TZCtoIOrtQGl0IyFvAWmG0jlbGb44Faozsx0D
	h1nzGOiJWyb8B+k7JV4IGUJqk4knrzy5sFFTKbGMHQZsTAbj7irwPXNSU3PXq45yvT5xJY52jDC
	PGhImSIeT1/irOUx9AaWL9Fp6oX3Qd20dS6zmOzNohmoz3ubd12irTRieeN4v7pWZDQEZ9d8Juz
	l93KzUDFm9j2OKvh4xu/gVjSklsqUF8h1pobaH0Gcq/5dF/uclWxfKk0lqoV5YiYivSTiKubYcd
	LRspALEH+QJhKd9vqBcNepoWxWY8yw88LNi3vMLUJc+3qBmLKkNnjOY34zPwJfxCNI50O8s0Obs
	snFoFFltKq1B3zsQEK5xwPo/NZGth4A2swQDTF/zkjNulIoE9ky4KZXg/tDX+W5+dcY3ySEt/wY
	OIbcEQda6AUJep16VbE9q/A9APtTHeDp8x0TU=
X-Received: by 2002:a17:90b:3e89:b0:35d:a38a:a117 with SMTP id 98e67ed59e1d1-3650ce235b6mr7192293a91.15.1777851829017;
        Sun, 03 May 2026 16:43:49 -0700 (PDT)
Received: from localhost ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364d1c70d8csm18522037a91.13.2026.05.03.16.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 16:43:48 -0700 (PDT)
Date: Mon, 4 May 2026 08:43:46 +0900
From: Hyunchul Lee <hyc.lee@gmail.com>
To: DaeMyung Kang <charsyam@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ntfs: fix copy length in ntfs_bdev_write() for
 non-page-aligned start
Message-ID: <affdssAo783VNm9L@hyunchul-PC02>
References: <20260502004852.491934-1-charsyam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260502004852.491934-1-charsyam@gmail.com>

On Sat, May 02, 2026 at 09:48:52AM +0900, DaeMyung Kang wrote:
> This is not a normal data I/O hot path.  The single in-tree caller is
> the $LogFile emptying path used during read-write mount/remount, and
> the bug only becomes visible on NTFS volumes whose cluster_size is
> strictly smaller than the kernel's PAGE_SIZE (typically 4 KiB on
> x86_64).  Per Microsoft's format command documentation, NTFS supports
> allocation unit sizes starting at 512 bytes, so 512 B, 1 KiB and 2 KiB
> clusters are uncommon but valid on-disk configurations.  When
> cluster_size >= PAGE_SIZE every "start" passed in is page-aligned and
> the buggy "from != 0" path is never taken.
> 
> ntfs_bdev_write() splits the write across one or more block-device
> folios.  Inside the loop, "to" is computed as the *end byte offset*
> within the current page (0..PAGE_SIZE), and "from" is the start byte
> offset within the page (reset to 0 from the second iteration onward).
> The copy length should therefore be "to - from", but the current code
> uses "to" directly:
> 
> 	to = min_t(u32, end - offset, PAGE_SIZE);
> 	memcpy_to_folio(folio, from, buf + buf_off, to);
> 	buf_off += to;
> 
> When "from != 0" (i.e. "start" is not page-aligned) memcpy_to_folio()
> copies "from" extra bytes:
> 
>   - it reads "from" bytes past the source buffer into kernel heap;
>   - it writes "from" bytes past the requested range into the next part
>     of the block-device page (or, if "from + to > PAGE_SIZE", past the
>     folio boundary entirely, which trips the VM_BUG_ON inside
>     memcpy_to_folio() on CONFIG_DEBUG_VM=y kernels).
> 
> "buf_off" is then advanced by the wrong amount, so every subsequent
> iteration also reads the source buffer at the wrong offset and writes
> the wrong content to disk.
> 
> ntfs_empty_logfile() calls
> 
> 	ntfs_bdev_write(sb, empty_buf, NTFS_CLU_TO_B(vol, lcn),
> 			vol->cluster_size);
> 
> with empty_buf sized to vol->cluster_size.  On a sub-PAGE_SIZE-cluster
> volume, any $LogFile run whose LCN is not aligned to
> PAGE_SIZE / cluster_size reaches the non-page-aligned path.  The
> over-copy can read beyond empty_buf and overwrite the sectors following
> the requested cluster in the block-device page with unrelated kernel
> heap contents while $LogFile is being emptied.
> 
> A userspace reducer of the same arithmetic and copy loop confirms the
> bug under AddressSanitizer: ASan reports a heap-buffer-overflow read
> past the source buffer for the buggy length, and the fixed version is
> ASan-clean.
> 
> Compute the copy length as "to - from" and advance buf_off by the same
> amount.
> 
> Fixes: 5218cd102aec ("ntfs: update misc operations")
> Link: https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/format
> Signed-off-by: DaeMyung Kang <charsyam@gmail.com>

Looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

> ---
>  fs/ntfs/bdev-io.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ntfs/bdev-io.c b/fs/ntfs/bdev-io.c
> index 67e65c88d681..27d7c2767a33 100644
> --- a/fs/ntfs/bdev-io.c
> +++ b/fs/ntfs/bdev-io.c
> @@ -97,6 +97,8 @@ int ntfs_bdev_write(struct super_block *sb, void *buf, loff_t start, size_t size
>  		idx_end++;
>  
>  	for (; idx < idx_end; idx++, from = 0) {
> +		u32 len;
> +
>  		folio = read_mapping_folio(sb->s_bdev->bd_mapping, idx, NULL);
>  		if (IS_ERR(folio)) {
>  			ntfs_error(sb, "Unable to read %ld page", idx);
> @@ -105,9 +107,10 @@ int ntfs_bdev_write(struct super_block *sb, void *buf, loff_t start, size_t size
>  
>  		offset = (loff_t)idx << PAGE_SHIFT;
>  		to = min_t(u32, end - offset, PAGE_SIZE);
> +		len = to - from;
>  
> -		memcpy_to_folio(folio, from, buf + buf_off, to);
> -		buf_off += to;
> +		memcpy_to_folio(folio, from, buf + buf_off, len);
> +		buf_off += len;
>  		folio_mark_uptodate(folio);
>  		folio_mark_dirty(folio);
>  		folio_put(folio);
> -- 
> 2.43.0
> 

-- 
Thanks,
Hyunchul
