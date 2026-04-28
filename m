Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F59F481FC0
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Apr 2026 23:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777418731; cv=none; b=kjqIArOKDpuwZ+Db9ZYKQxoeG4UvBxWq7lNuTlMOemCyAVE3gFC8mfJ9k+CNTYzUrCT1+qAKiQLpJuDSL4yIsMw11KB9ImDNvuq5nqUPYGkJBj9AHiAIoM2CHXmY6NrTdYto1/kABdw66XESLw/1huS1zXa+++/IyiFPALEGFRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777418731; c=relaxed/simple;
	bh=R6cQfvSjsIKmI/Y08xsoDpxCht3Jq53qKnqck3FE+rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fBno4BMjXHt0TyIYIQ02NK4KOAkd61z8osuql1oXMNRfS9RFQ+UPiEsg8Qt76tRIZ7bduaQRkf99h09RNAuyBIt0b9M8636WLePbiBDkyEhhSEfOGLLvqtIH86acrwFy6wtkFh/1QnpXOfTZfRFasHcYyv2+QU2ZSzwA82bQrd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMLm+pI/; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMLm+pI/"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-362bb3260f1so6006658a91.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Apr 2026 16:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777418729; x=1778023529; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tOJluPxYzNGos+SwkCBaicu5SwImO2KTCLCxq5NtkQk=;
        b=GMLm+pI/TVwFbWofeaJallLHwv/cLzYJZoyurNSaTjZAxnf5QMDFJIMdvgjbrvC5vx
         EdX6jV1ukWB+qWpkZvX7xafRXY4IZlY8x+18rR/DquRVGrhjYwsUS8yYRqz678Wlhy4f
         eALVaWZAHLhlzp5AEM+1rwvxf/5I1mUvhfWFGSGrz21ns6r88Vfg2IvbIKiwAo54MYl6
         G6siiuef2y9YavoX2iPMxrwfMoi+VcNF3zYk8nl34D4iIl2mlEuROZC6W92JlChl5Uep
         Gb7MPeVE7i0kP7bNnT/+dYhXxifE7lz/9Q60kqO2TLsaXBIGtua3VNHbb4W/t2gsPT5O
         0Stw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777418729; x=1778023529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tOJluPxYzNGos+SwkCBaicu5SwImO2KTCLCxq5NtkQk=;
        b=B3fHgDjx2NQtd9rgHO0kSM3bvk5pt5Hun4+bqYfc5rNFp8I3zs0XNuCT26SPX4Kf/c
         mAtBHwEzJKtDSOyzQXeWBB1rKdTVM9BqKw4ktlSU+FFmrDBZA7ZZfhYhNIjyp+qu0NSk
         y416JRVxrwyl2y71ygP0kjeWXRbCxKNsOfw8I3j6exku/imcg2YRN0LTkwlSgHg6xumU
         Gi9ZGDNmPQejA9U78ywHuQNwuYUdQRzHIto8Se+MEDxU/xMCnkeSAy77FAbxexDFGE/H
         a5vF2a7b08SiQ3sqC1finTz4YaZ3PbUyWnETg+XYl//xUDXmlO/xzBlom6+/k6GEOgoe
         SWTA==
X-Forwarded-Encrypted: i=1; AFNElJ8Lv9gF8rAgcD6yzu3DCviKW5stk49D/3yQLyB3hdk13O7Ox6E92w/0Uym99PUHKcLNFkYTLzobLIFw+CvW@vger.kernel.org
X-Gm-Message-State: AOJu0YwV2uShndh0tcjQzZVzhh7+DuPO97Jr8gncvKralgkTOLbEDhud
	3z2+H7bfBDDmwS+6u9ONFnUwQgA56STHFE9HTguuOX7sQaDTYRpztYob
X-Gm-Gg: AeBDievpWd9WzdGTm9Yh02kgYqJOC20svyYIs/HNajdgIvpqoxqwvW66fSH8cZBXoZC
	WPomOzjRvVS3CmLpUlIoUCwtmxkcVjd3bHM3zEFgRbdecbLbUk2Acgm3YPCDM8spEjIpWLZBjte
	bYCPfSLLv5m8TmGR6Te9aF+mxpefqkNIUymk7dmfcZjEMgVUvJnLY/Lg6PlAgH+jo2E1hTQHlD9
	sZhs5BKgHh+KSr2E5DTtyRRDj7jZSwrNaJLYddIB4KexGOQR0Yba69QasepfL0xTrMQOCm/q1EU
	ot+5Qc7hQrUye586UX8Hm0gyI6vDVFtrZgVFkrqae+BaUWJuGu0SlyPqCjKV639LH86fNt3+zHs
	tI+/houKm66fJ20MEf59n3M+4M9KinmkTHM4rJQCK46Bw2lrLIj22VCfkvGgpRdpHdIsxLsAxKt
	5G3WmZm3OdtpXNMvfWD3Gq6i55
X-Received: by 2002:a17:90b:264c:b0:35b:a418:698c with SMTP id 98e67ed59e1d1-364a0b82c88mr1309297a91.12.1777418729293;
        Tue, 28 Apr 2026 16:25:29 -0700 (PDT)
Received: from localhost ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364a0115274sm803468a91.2.2026.04.28.16.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 16:25:28 -0700 (PDT)
Date: Wed, 29 Apr 2026 08:25:26 +0900
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Zhan Xusheng <zhanxusheng@xiaomi.com>,
	linux-fsdevel@vger.kernel.org, llvm@lists.linux.dev,
	patches@lists.linux.dev
Subject: Re: [PATCH] ntfs: Use return instead of goto in
 ntfs_mapping_pairs_decompress()
Message-ID: <afFB5jP8Wer3MYRp@hyunchul-PC02>
References: <20260428-ntfs-fix-sometimes-uninit-rl-v1-1-31e0c8025430@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260428-ntfs-fix-sometimes-uninit-rl-v1-1-31e0c8025430@kernel.org>

On Tue, Apr 28, 2026 at 03:21:38PM -0400, Nathan Chancellor wrote:
> Clang warns (or errors with CONFIG_WERROR=y / W=e):
> 
>   fs/ntfs/runlist.c:755:6: error: variable 'rl' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
>     755 |         if (overflows_type(lowest_vcn, vcn)) {
>         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   ...
>   fs/ntfs/runlist.c:971:9: note: uninitialized use occurs here
>     971 |         kvfree(rl);
>         |                ^~
>   ...
> 
> rl has not been allocated at this point so the 'goto err_out' should
> really just be a return of the error pointer -EIO.
> 
> Fixes: cad7c6f0a514 ("ntfs: fix VCN overflow in ntfs_mapping_pairs_decompress()")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Thank you for this patch.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

> ---
>  fs/ntfs/runlist.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ntfs/runlist.c b/fs/ntfs/runlist.c
> index be6ca3d374bb..da21dbeaaf66 100644
> --- a/fs/ntfs/runlist.c
> +++ b/fs/ntfs/runlist.c
> @@ -754,7 +754,7 @@ struct runlist_element *ntfs_mapping_pairs_decompress(const struct ntfs_volume *
>  	/* Validate lowest_vcn from on-disk metadata to ensure it is sane. */
>  	if (overflows_type(lowest_vcn, vcn)) {
>  		ntfs_error(vol->sb, "Invalid lowest_vcn in mapping pairs.");
> -		goto err_out;
> +		return ERR_PTR(-EIO);
>  	}
>  	/* Start at vcn = lowest_vcn and lcn 0. */
>  	vcn = lowest_vcn;
> 
> ---
> base-commit: d986ba0329dcca102e227995371135c9bbcefb6b
> change-id: 20260428-ntfs-fix-sometimes-uninit-rl-cfe3c6a9c34e
> 
> Best regards,
> --  
> Nathan Chancellor <nathan@kernel.org>
> 

-- 
Thanks,
Hyunchul
