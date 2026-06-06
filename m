Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D79322F74A
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Jun 2026 14:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780754951; cv=none; b=AekhO+cw5RbSltkW5Yq0usWZNSIqVi+JBfHfJjN49QG+JAd+ZDCwhfLVcadOifpIUipfSLkB6/2J5VNR1dGlXChY0JNoq0sPH9OQo+AINGP7iLLcMYNIn+3xbqEIdxyXcobBEz0ZRd+fh35Qezf1+v5cceq6xWUUQBmZ+mzOQGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780754951; c=relaxed/simple;
	bh=0eurt1o2AhBNOwYFsWDeme0y7OhkdUzyuOwKIbIEjtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rdgC0D8wdIaXmd/iKYx8XP/czpr8zFLK8Nry/GjGMg58lXTy92/kGR8CnTlHuMl/WMaWjOVw+Xri49c70XbL+wXqUXwM70X0oJOMWOmenLzwHOTGFQg+2gqXvgMz/RYE7KyME+S52HumHXO0T2xp/9WCOozTmJuc5R7MSB4e6Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LwshSlia; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LwshSlia"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490b8a97b11so31260625e9.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 06 Jun 2026 07:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780754949; x=1781359749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d5Vp+HRxR1+drvvdKZ4J18DC5b7lc3/zkS5h64DC9IY=;
        b=LwshSliauarKlnR4OixRorDjI7LMoY964sFWw2jl8iHs7wbe8iSeTlOIas7MoZO+6z
         xneaPG/awaeeu3lpTcsin+hekEBKUjiuXTLimkadXuejOOo8v4PRn08cGhNiUXDwOjTM
         4+fjRtdf5xLo0WFKR288PVLQMSx1Fl25zYVpnFa8JSuPFWrVEt+m3B04q6gBcsilEwlr
         yhw5jctBAWZkiGiEeGK6LwpcWVxKE2zgojM6oQ9GK6ICafj28F1Me1EGRrB65PWclMBl
         Qi9Tx316WMAKZLbZayQnmhL4yualRVOeM+DO+mwjQL+tmqB8haW0/J4wvWHCzv6N6vml
         kP4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780754949; x=1781359749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d5Vp+HRxR1+drvvdKZ4J18DC5b7lc3/zkS5h64DC9IY=;
        b=tBYmZrm2Ej2Qw28uUYvhRbcuHKHfNAhru6tfo39NDgdHgWQ3QYwmaKRsiV2556a5ij
         Q/G0XDw0iurNjsxKASYK9kLzFldEtH+y+SpEsxeT+WPJCefz9jp7vKa6s6ug2LFB8Hns
         Z90y02s3BB1x2YDeBruna3LWVSAib8VMEV3eebcGEBojbdFDoFPj4uptPiOrHjOcsoqb
         98fEyWH6LaW5GxYpnmpna9vXgfJ7T/DpSAkNhCiEY+y8IqkP3bmcBiosynO5OwOZR5ya
         5W5JcH8SsEuUWStFX/6+pZey/lM6hfMTlawSiCGqbX+z6tCxGfTWfP5tpe6gpSEteg8w
         krTA==
X-Forwarded-Encrypted: i=1; AFNElJ9lKcTu2KkBxb4ho52nMJHk53UUQAxlUghViso+CzzDImvwTeVR7PVk+6zSxDksSF1DMkVKHDZNB921YQBD@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv6QA1GpjFmzx6ad79IHnVKI3CIw08cv5+M8ijJExHJTZdt9CO
	J4vwkVBV7cBAVlUFGFSQaggsFjCstMyrjuxgUjRrHUrCh6p57yeLd5SL
X-Gm-Gg: Acq92OG/xdtOxz857kp/kXCss45JGGcpWB51o1yyxY5oGCR5Y+6R/ucduBiz6MvGKIY
	xGUDrL7Vv17fj+MoHQLywstd9QfwS547nDr84lDCox6s9EFQ1vZEOgB5USKR4jnXQnNFc2nkeQO
	u/h+belIEwaUsfON5+hiSsYxl/bBt/UKCj8C7IL1qNuJ4yj2yQIG9wqTOvcYXvNpm8OThpZLC9l
	3Mpq4o86LZh+0kw3+JSe9mnc6V3xgoISyeYEDVxgfJtpc1Qw3sicCYuym08ss4PBmcbwz6YhFpL
	c3O+bjj9qmMO7Y4lFljaLFWvZeSGwW46Fr18p60KGzTKTgTPPhcYvz1dl28xmCy53BZ9ZZo/hif
	ryCT+UOER3XuYQWZXctll3tg49YEKWmrJW7a+3wyTu31LhDc+aGgBpaRbesHXp6iSO7JKCkPbwK
	TyMSjY+6HYJSjqvZLg23hu0vy5pxD9fR8BGp7RPz6v28RAjwCPUA7UeoAxbCgCpTZQeQUFVEM=
X-Received: by 2002:a05:600c:4fc6:b0:490:b432:6f1e with SMTP id 5b1f17b1804b1-490c2614bf9mr132653825e9.33.1780754948502;
        Sat, 06 Jun 2026 07:09:08 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3cc0f8sm235269535e9.8.2026.06.06.07.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 07:09:08 -0700 (PDT)
Date: Sat, 6 Jun 2026 15:09:05 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Namjae Jeon <linkinjeon@kernel.org>, Hyunchul Lee <hyc.lee@gmail.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ntfs: fix u16 truncation of restart-area length check
Message-ID: <20260606150905.30362284@pumpkin>
In-Reply-To: <20260606102606.74510-1-hexlabsecurity@proton.me>
References: <20260606102606.74510-1-hexlabsecurity@proton.me>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 06 Jun 2026 10:26:10 +0000
Bryam Vargas <hexlabsecurity@proton.me> wrote:

> ntfs_check_restart_area() validates that the $LogFile restart area and
> its trailing log client record array fit within the system page size:
> 
> 	u16 ra_ofs, ra_len, ca_ofs;
> 	...
> 	ra_len = ca_ofs + le16_to_cpu(ra->log_clients) *
> 			sizeof(struct log_client_record);
> 	if (ra_ofs + ra_len > le32_to_cpu(rp->system_page_size) || ...)
> 		return false;
> 
> ra_len is u16, but the right-hand side is computed in size_t
> (sizeof(struct log_client_record) == 160). Both ca_ofs and log_clients
> come straight from the on-disk restart area. With an on-disk
> log_clients of 410 the product 410 * 160 = 65600; adding ca_ofs and
> storing into the u16 ra_len truncates modulo 65536 (e.g. ca_ofs 64
> gives ra_len 128), so the "fits in the page" check passes even though
> the client array described by log_clients extends far beyond the page.
> 
> ntfs_check_log_client_array() then walks the array bounded only by the
> on-disk log_clients count:
> 
> 	cr = ca + idx;
> 	if (cr->prev_client != LOGFILE_NO_CLIENT) ...
> 
> For log_clients 410 it dereferences records up to ca + 409 * 160,
> ~64 KiB past the kvzalloc(system_page_size) restart-page buffer -- an
> out-of-bounds read of attacker-controlled extent, reachable when a
> crafted NTFS image is mounted (load_and_check_logfile() at mount time).
> This is the in-kernel analogue of CVE-2022-30789, fixed in the ntfs-3g
> userspace driver but never in this revived classic driver.
> 
> Compute the restart-area length in a u32 so the existing bounds check
> rejects an over-large client array instead of being defeated by the
> truncation.
> 
> Fixes: 1e9ea7e04472 ("Revert \"fs: Remove NTFS classic\"")
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
> ---
> Reproduced on a KASAN build (in-kernel ntfs, fresh-boot slab) by
> mounting a crafted image whose $LogFile restart area sets
> log_clients=410 (ra_len truncates to a value that passes the
> system-page-size check):
> 
>   BUG: KASAN: slab-out-of-bounds in ntfs_check_logfile+0x1e52/0x2460 [ntfs]
>   Read of size 2 ... by task mount
>     (cr->prev_client, with ntfs_check_log_client_array() inlined)
>     ntfs_fill_super -> ntfs_iget -> ntfs_check_logfile
>   Allocated by task ...: __kasan_kmalloc -- the kvzalloc(system_page_size)
>   restart-page buffer (the OOB read lands at buffer_base + system_page_size)
> 
> With this patch the same image is rejected by the existing
> ntfs_check_restart_area() bound (ra_len is no longer truncated), so
> ntfs_check_log_client_array() is never reached, no OOB access occurs,
> and the mount fails over to read-only. A clean image is unaffected.
> Full A/B logs available on request.
> 
>  fs/ntfs/logfile.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ntfs/logfile.c b/fs/ntfs/logfile.c
> --- a/fs/ntfs/logfile.c
> +++ b/fs/ntfs/logfile.c
> @@ -132,7 +132,8 @@ static bool ntfs_check_restart_area(struct inode *vi, struct restart_page_header *rp)
>  {
>  	u64 file_size;
>  	struct restart_area *ra;
> -	u16 ra_ofs, ra_len, ca_ofs;
> +	u16 ra_ofs, ca_ofs;
> +	u32 ra_len;

I'd change all of them to u32 (unless you actually need the 'mod 64k').

>  	u8 fs_bits;

Similarly, but look up ilog2().

-- David

> 
>  	ntfs_debug("Entering.");
> --
> 2.43.0
> 
> 

