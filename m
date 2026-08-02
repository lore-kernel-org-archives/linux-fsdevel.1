Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7C7489884
	for <linux-fsdevel@vger.kernel.org>; Sun,  2 Aug 2026 02:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785638423; cv=pass; b=egdZ8knEt8DJ5AxKZaovtnEAWyi5p1x/C05AeJHEtA3nzGj1Sg/o0hJCw/mdOBCjH1DMKXEdsPCtanfylSEpK2JqVxbVvGpT1xk8dcKdyKSXycIPJJTxzCWrhG4fkk++gZ1zSgKgnuIcNdeHgXti0sKyJ/lPFxD5iOvnHlYoM+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785638423; c=relaxed/simple;
	bh=dWYzkBPHjoRWTktMR28GquvCS5W2PfaR5W+p3DMyDjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IuCS4tUoVCdCKUzo0cfBO2JMq1+bzzoGsVtu76IzMm4l8t4qOKTZUnft8SzVKfDUIWQspyzuNoLbp+62bHpATeJuIFlSD8cWAJRKYnHFUZeMStMCyknm8LyO+3Yy/XEZz1MXhI/G43dLh+m6b9gFvm2232dYrWPztNgMmp4cCPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fIqclEGj; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fIqclEGj"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5b2a8e4c77eso2256722e87.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 01 Aug 2026 19:40:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785638420; cv=none;
        d=google.com; s=arc-20260327;
        b=a/9QbTdgOxVZifY3mxmcn+UhhBZV0bRooPTKdTiVWsQi17MKwCS6Fn3bvIAU+8Fd45
         0O28rD3oFm+alDhWi40XS+e/XHwxJWFmJZ61COz3j2LeeAsLTGXIxYzdbACgnAC4Irv5
         QCHvE4oy0Bjlhwwn6P5xj/o47YcdHazthtO0qucW9YyaMNrp0DWgBP5Ea1gjv0Fq7zqS
         14bLeaYu6STyNi+GG59BqgnWgEfaVsLckMCYdcwaeE2QPT+k7HYMr1jX9zUpV9Fci2f0
         drLVbfUMx33csWwnOl13rejqiOYypYj67okYDUwNZe9quwQGQe8tPTFB6g1GuCvAun4L
         BgBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jMqriKZrmU/aQM9SZtLPb82GZ5/DQwM7KJHSXQ48bRw=;
        fh=Z7dh6Maqkc0BSkFo5Pfa6YqH437NV7KYNhyLguiMPho=;
        b=A/H13/zQOtHAI7Kw89H25P7oQiKQswqgLT8hUt/qlK0U4AbM8m+2ivUyjMdT/d/b6Z
         YpHBXR9wRYV9wM266atSXDW/xzZsjYtCbiS6VDydlobgI6cXv/TlXVbaeLqgs8FhSif/
         4zZece+oZstTwiQ1pq2LVe971or6NeIYfNzA+dPIt5O2gSeTjGz6tY48QETbCNzvz8kG
         0dJBRpw9Ry2CnfqDE1EbpyJx/o6ZZoKzy5MT7K3jyR9ucUGEv51AdIqg4a8tn4Wisuyh
         qD4/skxr6b2/BHxC+izsDRy1gNdXKipiPBWqFvO47TNZIBsep4QfixjPvIyBZr8OZ+t5
         9VTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785638420; x=1786243220; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jMqriKZrmU/aQM9SZtLPb82GZ5/DQwM7KJHSXQ48bRw=;
        b=fIqclEGjyGL4t+++yHQI4rukkLQR0OmpLRrCrgPnvVftV/5LcW8ljjb953/f9CQsWJ
         xf8ca6izG+KYiWrB3l1+eb3Fdo/heLRfGabGC5l8Wg0cZIEl1Lnt7riT8m1S3UwOOVOo
         +2q8bbeqHJ/NVhDt5PN0cBBfSP9n3Jeb0QcpP6L2qAC7sGaN2TF3hf76IELOEAXHeC1T
         u7D183KQMlu1GXQgR2GzvyyHSA//l8UFGoZEuxs4IZWe6hWaom7y4FpPX3ZoKX8g5CNs
         43x44EO0PY7QErFj8JPtAQdRBfWCzLrIDNQG+PW+HfzxwAHRYNSQpaoUbH+ELnAQsxIt
         KzZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785638420; x=1786243220;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jMqriKZrmU/aQM9SZtLPb82GZ5/DQwM7KJHSXQ48bRw=;
        b=JGIx9+6J3SS7qdLxmv5lMHMYa0At9EGyev5SVMj3+B3NbzBFAUQvnenVShrYpfQWuX
         r73/3LE4VpzgI1M+jGiOJpInP/2gV9eLKfHbNAsvXyZJBHdbAP/gvTOSi7MS1JLgObB8
         vfqnt60tGUQRxH9pWyhMqydeONqwOHbruoYTUmqDNiFJXo9uGL+yn5IEiZAD2FQDV6Yp
         geMjpikR+XF3d+OMC3LbZEn/B3A9I3/j75u0xMT33CyKiaaWWuuUHuNmHV80bHWsYcwO
         EgdNQ7B563t9gNZSXQvKKAUDZl7vhcEyLn9OUrCCaYVkb2ur9ZtHzuUYSc4o7MJNXAI0
         JIMw==
X-Forwarded-Encrypted: i=1; AHgh+RoKohH/PWsPsVZg8hX4PzM8VHLcLd6yRRrmHlEMg0KrMZ2GI4nnFfa44hxMcNdMTY2NBH394XJMtRFdfcov@vger.kernel.org
X-Gm-Message-State: AOJu0YyMcnZYnTGuGeNSHejdd+GCZnG50K3juWy1ZlRqsNg0SToFhPRl
	9qtAxh00IR3l9gewrLJAlw+5C30JsarW6DUGrYQ4k4KT095TgNaV7NwXQTsG4wEF3khGWTtWlQ5
	T49JrTG4y+yZOspz6jUk4f+K56AEZFS0=
X-Gm-Gg: AR+sD12eyhm6RECQlVNT7AGsIvcRzu9whkd2t6KONOnfUZRJ/BThzj2NmDwtXsNLRDN
	DxCJvGCaldh6GdQgXoYkeNBuuf5LEqgiQMwfJgZ6K1wYrExCYmq9Dn6d/Lpf+c5zr9svsAyMzLh
	yJYT4lMM8/8uO/RJ9prJYqHZEcFnipcsuzw64nWmhFibINlixlKP7C87HIdFSIF/IlPVnHgs13U
	/8MnYXalywBuPX6ibWp4sXIYGSJfEQRZLO93kGtZ5JuCr9YjDfUTteAdaAC1uPjaIc5mN9WxRTz
	prm/YncHdEFYkfaxI9tWFLq7d6ucbSrAeR0VHlrhWlRUgg==
X-Received: by 2002:a05:6512:10cd:b0:5b1:59ec:2452 with SMTP id
 2adb3069b0e04-5b2e4f1af20mr802759e87.9.1785638420093; Sat, 01 Aug 2026
 19:40:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729110036.12129-1-linkinjeon@kernel.org>
In-Reply-To: <20260729110036.12129-1-linkinjeon@kernel.org>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Sun, 2 Aug 2026 11:40:08 +0900
X-Gm-Features: AUfX_mz1QryY1YiO8B-7V1ridiP1cPu51EZnnD1BpsBy69qUokY6kOuLPiyUdPc
Message-ID: <CANFS6bY95QuokT5bDLnVTkHbJt_jwzS9jgBSp_rFhMMZp4+p_Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] ntfs: add ioctl support for named data streams
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: ntfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sebastian.n.feld@gmail.com, 
	cedric.blancher@gmail.com, Lionelcons1972@gmail.com
Content-Type: text/plain; charset="UTF-8"

> +
> +       bytes = ntfs_inode_attr_pwrite(attr_vi, offset, len, data_stream,
> +                                      false);
> +       if (bytes < 0)
> +               err = bytes;

offset is u64, but ntfs_inode_attr_pwrite takes s64.
If offset is U64_MAX and len = 1, pos becomes -1.
A resident stream can the reach memcpy(addr + pos, ...),
causing an out-of-bounds write.

> +static int ntfs_remove_named_stream(struct ntfs_inode *ni, __le16 *uname,
> +               u32 uname_len)
> +{
> +       if (!ni || !uname || uname_len == 0)
> +               return -EINVAL;
> +
> +       return ntfs_attr_remove(ni, AT_DATA, uname, uname_len);

Dirty folios are not guaranteed to be evicted before
ntfs_attr_rm() frees clusters. So invalidating
page caches seem to be needed.

And we have to serialize ntfs_attr_remove() against
other mft record modifications.

> +       case NTFS_STREAM_OP_WRITE:
> +               err = mnt_want_write_file(filp);
> +               if (err)
> +                       break;
> +               err = ntfs_write_named_stream(ni, sname, sname_len,
> +                                             req->stream_offset, req->io_len,
> +                                             kdata,
> +                                             &req->bytes_returned);
> +               mnt_drop_write_file(filp);
> +               if (!err) {
> +                       if (copy_to_user(&ureq->bytes_returned,
> +                                        &req->bytes_returned,
> +                                        sizeof(req->bytes_returned)))
> +                               err = -EFAULT;
> +               }
> +               break;
> +

We have to check NVolShutdown().
