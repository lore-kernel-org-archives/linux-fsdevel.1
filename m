Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DB01DE2C9
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 02:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772159849; cv=none; b=OW8i5tFjV87HYVWnyW+T4V3kLJ6XPNPvqP98dHM95CdnIP7G7VTwLLkKNV8up240ZcL4v3yb9p4i+AAYnNJjaWRUnFenbtIPOTsuFv4KFmtGEEjzpjGyR8X0hEhfz7Le2Q2jW904Lz5GBik+8XjGX+plrm9QqmTb5ihFJfZXXPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772159849; c=relaxed/simple;
	bh=C28s0pkucCY1/3AUlZBnGHThQ3Km1467UYXZg75LfJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BDpSU25u+fLSO3mE4ZzRMwNlcfz/Q5bil78wY+2QKMhwewO60Uv1kP1znpdd3X+rm0uiBqmJYSoUZwJMmjLxgQfmTOZSd3cXeKRSOvahzzx9NxA7swcutjcQzwvr+akCY5Sa5AXt/VVEhVQDtpDc+WAnz++t2LI3qigfSvMXAZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FcWcb7ef; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FcWcb7ef"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c6e72d7a4d7so927927a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 18:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772159848; x=1772764648; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+5GScX1NjOU/hHr0ro6XId7zlzuoUAQ6PCqQbIHGtXo=;
        b=FcWcb7ef4pkYyX7YWNqkKIhHUUUQnALJMdgdRLcKVC2PALJXnup5U7eizHLgrtHwpd
         aDCKcvVKDKHwMhhoFIL7tMIY2jBGES8w5ePg3eGoXx+cfH/5QylGWGG9M88HkRSCarMG
         8sR4Ih8mDE6e2aTmqyeeocG3QaAbv25UAxPrFV0iw31UugROtNj/Xk20MBNmljB3ZzfR
         vokJIovTsnhtv9kyw9pEekJBuQIHXZUB78OLXwPYWo7cn3lfa0paskgXqA7WhEGVwPvH
         URoVOLDmWVen9bFIc2xOz8+f2uvIxp46gUqLTkLRAI/CfnD8aSvyGpDi10uESm1qc251
         sIVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772159848; x=1772764648;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+5GScX1NjOU/hHr0ro6XId7zlzuoUAQ6PCqQbIHGtXo=;
        b=e2SonP4xIpIq5vhpPB4SjGTktBfjd9K+DfsFQ5UZ6YyIpqcjpILn852go5R1tK7cfv
         +Y7f8+NDXLiRTb2/4qyOU4beV7KCdj8ZXYiOnjBcCO/T/d6XFmRDe6ArnX3bAsW20amw
         bgg570D8q6Dvu5CAC3qzLDsa4KOfF8p5rGOV6oiiSvZthxUtpXFeRzkdAklfPLIlEphM
         /6OUGM3umkYSGBAckf7ZgBlCR3M4fyda/6QSgvVGl4d1XQGEf684YCBDQXSkWJD1I14q
         jNWVe5RE1Ysg3IMo0KvYCK0TzB+4VTlK+IAK0WPRRZp3ewurUGSn9lx0BRkBRouB88pi
         e9tw==
X-Forwarded-Encrypted: i=1; AJvYcCVeHyNla0JQ9yjMtW14nR9RnhzXqcNFoBElO+T92oq46fIjo2sm3fm7tHkkdSt0IgopuM5VYBi/QFBxvELw@vger.kernel.org
X-Gm-Message-State: AOJu0YwedP7z3+CEOp3Z4sEQ6DStTyXPFKtnIVbtinM47xnYESS/o4cr
	BezsQmybOwVdDVmBi2H0XrPdt94AX+Cd+tLR6TBjbS0SlMLKOjD2DV8z
X-Gm-Gg: ATEYQzxduDi6457WR93wcnOeE69+COu2lbe+sL20M6Pv0rdKVDPG/9T+r+A9CMPdJkj
	0nL9jztBheFVQu8lEOwgoL15RPoYturPDBqfR1FJpIcf933pKDRjqwsfbabV4diIKuwUZEKynxZ
	TPVAtjiTwT8ZOAkx6W4FD9+FkJ9yaM1UnebWZhPqvjpMug8VrzAt9FSJKDuEy24++w7mOeUjGrc
	ExUKKxCa25pHLGtSPC/JADxBnXeKuAP+X3pH3TjyOPkOi1+tEK4PD2ihrA7JFpjQMzzHUwKPTlo
	g6Fgxdk7R9t/SiGvDYzlT62X1yh2iPozlwDdCVpPNMFoAwhRFZtcpiLKL1nZNxSEcVlvvkTfiPj
	bOrlkOUcalawRO+wUEpMYEe6oAEzemUbd6hlbtYRTFfdnkXWnzU/7Ec0qI8rFIUwt9wPc+6EwaN
	178F1k5Sz3rJJbaUnVZmPjdXl+
X-Received: by 2002:a05:6a21:114c:b0:366:187f:3365 with SMTP id adf61e73a8af0-395c373e8f9mr1304884637.0.1772159847894;
        Thu, 26 Feb 2026 18:37:27 -0800 (PST)
Received: from localhost ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa5ef857sm2982398a12.7.2026.02.26.18.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 18:37:26 -0800 (PST)
Date: Fri, 27 Feb 2026 11:37:24 +0900
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Ethan Tidmore <ethantidmore06@gmail.com>
Cc: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] ntfs: Add missing error code
Message-ID: <aaEDZEc0yJwCRDz9@hyunchul-PC02>
References: <20260226160906.7175-1-ethantidmore06@gmail.com>
 <20260226160906.7175-3-ethantidmore06@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260226160906.7175-3-ethantidmore06@gmail.com>

On Thu, Feb 26, 2026 at 10:09:05AM -0600, Ethan Tidmore wrote:
> If ntfs_attr_iget() fails no error code is assigned to be returned.
> 
> Detected by Smatch:
> fs/ntfs/attrib.c:2665 ntfs_attr_add() warn:
> missing error code 'err'
> 
> Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>

Looks good to me. Thank for the patch

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com> 
> ---
>  fs/ntfs/attrib.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
> index e260540eb7c5..71ad870eceac 100644
> --- a/fs/ntfs/attrib.c
> +++ b/fs/ntfs/attrib.c
> @@ -2661,6 +2661,7 @@ int ntfs_attr_add(struct ntfs_inode *ni, __le32 type,
>  	/* Open new attribute and resize it. */
>  	attr_vi = ntfs_attr_iget(VFS_I(ni), type, name, name_len);
>  	if (IS_ERR(attr_vi)) {
> +		err = PTR_ERR(attr_vi);
>  		ntfs_error(sb, "Failed to open just added attribute");
>  		goto rm_attr_err_out;
>  	}
> -- 
> 2.53.0
> 

-- 
Thanks,
Hyunchul
