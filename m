Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779A93BB114
	for <linux-fsdevel@vger.kernel.org>; Sun, 27 Sep 2026 07:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790494050; cv=pass; b=phT4wtIYNa6do/R8rT63MwGN5fRg0sL3hKZAClAooXKK1U5nBROFtjil2e95oPoEnM68NS31bKMtghnMHAnyddHtoACWk9OSN/gOCRBiFBAKCRHIa49od1Ig1XhRgfVR0UY2XGu1UXGvL/QmsvnTJcSSs1eRbm7gktwFeLLZuC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790494050; c=relaxed/simple;
	bh=08YlvvKTuuhXI9bTdUpQ2WLGjZPd4IBv+KACV3DWHbg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lKtVMZarlwQPnkkRBQPD+s1W5BTHumRUh3HRls75nR7Nuoqdzd/OSs6+Zm77kvmgfsUsiV/v8Mg/6MvKtO2J8MQtLAPwhsDhQAqyxqg/D6lRM8dW1CKdRkjji2gWVpKKpOjCXtXAR+DTo6LmBEbdphZXixAMqIl60T1vJZGpxWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z1/echsb; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1/echsb"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6aaf28a86b9so2701198a12.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 27 Sep 2026 00:27:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790494044; cv=none;
        d=google.com; s=arc-20260327;
        b=ZRaswhmX9qV3tp6xcDWHBVD/ZA20SMSFVIwKKHSPnSCCVtXQ7ZBybUdncR8K6DBONO
         R8DN6tjRBDuod5ZFlOe5gkUPa+rqrKBtRIw6WCZSvbMLip2ExZJ3OH7CNP/IzoiZiUwp
         TLKyPniiUQFSQzORW0jgxSnMx5SBMOJedAMvXv1/t3WigWlnUsRz9AEDflfRXz31+7N4
         k8uGK4BSnnIgBAEA6iGdXSAWKPOMfihJiublbV1fNe4cn3+JetLbxBVKuPOiFmbKakC6
         6xrI+3Uznk7Il0T7Q4P+1QAc4jGqmjwJuuS/bwZ19KIMwSk+Q28WQhStq4M35onnqQt/
         +YGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r2dA4rveDo/qwHzdV4fULmqnRkPVTOlAOyvtUxne+BI=;
        fh=IOjgDbgN+gwW0yD5C2PS3JDwwxK4qxqwCCp+4IcXbBA=;
        b=jsn/SG4yDS3l30JFtsqO+1Ia5ER4CGQu8hC6A6WivY8CW2nxM4iVFkytkwRWmDRZr/
         K2fASQh7ej0LcHPT5HVDSywH24s5EeAJdlPTTm2XpGh4ni43vxHRvhGr5TxWr/BZX/t8
         qZIdNTLKaA4IQj/Dap/3jEPamgI5O3IEWLYG5swHP/PyNHPhVywAuFYHRabGH0RC2EWw
         9a6x1+tGLLebPYbQGLEzxuY04jepp2xoDp4b0iKJz/WyDnFNIAGoYKGB+qMS2Dyg5EQG
         y7x1/Y0JI/zxYDdDKmlrVy8WddhLyVntUQiuJPqn9V11hgXuINMTSz0ArDn6S3rIjXK4
         SxVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790494044; x=1791098844; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r2dA4rveDo/qwHzdV4fULmqnRkPVTOlAOyvtUxne+BI=;
        b=Z1/echsbyMPd0CB9aI55LHMADPFBj9dl6MzKL0ccG5XLsCtaMMucvL0H9f0//GcHa0
         TyDZ/vLX0VW4xf3WZP5wMdJy6PkDUG1y2jOAfqpBzj155U+1EqclLFcjXxNYct0WZwDz
         zKXYfoialvMjWX/lUyoFhVjxX+mNvORtGLmzOOXMEE+L55VYVF2iDmqGnnpfd4q+TlVC
         jY37dKFGcWf8JGIdGrvqNFc9/hvE0i9RKfC0RqdkX1wvsxCqOVZGQV8vbv+g4T3CHgqB
         kJBW+xEpI5WDCQ11Xu8VPKQSF8TZl49OsEE7h0lzs+h6JSOKZL3Tj6UrYKsKKFMhFC91
         xYBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790494044; x=1791098844;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r2dA4rveDo/qwHzdV4fULmqnRkPVTOlAOyvtUxne+BI=;
        b=k03rcPgPhaKOeb6egnZLhmtpr49Zqc3niIwIIb4Tm9rGAn/WN6TI62fW+QAbHltF5q
         32lNm40CSAjrXdroBL3M3NtBcKCFf70XcwbnZQcq3XjApoXqMWRkn14URRIFkIfQNuNN
         n/5hF3wz/XIpyjb9C6G9vXOGcSvHgMeF6OWB5DhLYQhBAptsBKO0NYDQFXVmDEKh5Yb/
         WqEfb5EOtD47u8EvxU+CVgpmDtwoo44e8Qa+O/jRzJkR27KWcdBFT2guikP/mXF/OCKe
         yYjXTccfn4pyMX7kNHVHd7GCvFcIcpzi7ljPYsxbxGeAQ37jMTB6fbJsE6mWQN68CNRw
         7rpg==
X-Gm-Message-State: AFq9FYL5UBH9IGqegG7N4vuZsunXVnNLGPdi4EfEF0OvOmsBrW04ocHt
	5HRriq1RevrT2hytqEzFjgH9vM4UVgN4CXIum18Je8EW8TUea2wflRpfuYphcMkoEej77iw5nV8
	b1Dhgy/e6XGR2rth4R4EVQm/jJbKmo3s=
X-Gm-Gg: AYBFou2Oh1OwqR6daK35bZtobp3Akv20MjadVwA5cSOEvx9/OXFvbN9opqkXKpFPXKY
	b/YNPccNZiDuCZLlnZfBeGfETR40ktepq3U+jPwqYym2B7ZECZxi4MY0V9/hah2w9SUBnmoJlVd
	4FtroEHli+spUVdxWZYx/DSifuadeS9V4PXpl2TGUUMdcOpLdo/V/8ZxRiLq3zSsYXyUg/mIF8c
	YvbPgXDp9jYVwB1znqqVgGUCZCY+oHDb6sVNtJJprvyRJNFiWcGI14SuzrrTF18ZmoQIShvGHAh
	r7Qb4huf1t9v3Wfh07xUF3aGmx040+J5T6FO9Q8vToTyrquMC2Duil12
X-Received: by 2002:aa7:d9cd:0:b0:6aa:ff32:55ad with SMTP id
 4fb4d7f45d1cf-6aaff325ad6mr2463712a12.19.1790494043761; Sun, 27 Sep 2026
 00:27:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260926043836.3301898-1-matthias.goergens@gmail.com> <20260926043836.3301898-3-matthias.goergens@gmail.com>
In-Reply-To: <20260926043836.3301898-3-matthias.goergens@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 27 Sep 2026 09:27:12 +0200
X-Gm-Features: AclHuK9WcN0QE-CMoABg-3S0S9ooiM3h6-ZB760atxT6Z4stK_0t8ClGGX6L1CA
Message-ID: <CAOQ4uxhCZGqu4C_wonPZq_AC7qr=qS3_Y9kA+W1feahYBBOYPA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] vfs: add FILE_DEDUPE_RANGE_REPORT_PROGRESS flag to FIDEDUPERANGE
To: Matthias Goergens <matthias.goergens@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, linux-kernel@vger.kernel.org, hch@infradead.org, 
	djwong@kernel.org, david@fromorbit.com, ansgar.loesser@kom.tu-darmstadt.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 26, 2026 at 6:38=E2=80=AFAM Matthias Goergens
<matthias.goergens@gmail.com> wrote:
>
> Deduplication tools such as duperemove, bees and rmlint advance their
> file offsets by the bytes_deduped the kernel returns for each
> FIDEDUPERANGE call.
>
> vfs_dedupe_file_range() passes REMAP_FILE_CAN_SHORTEN, so
> generic_remap_checks() may round the length down to a block multiple,
> but the ioctl still reports the requested length in bytes_deduped. The
> caller cannot tell that the tail of its request was left alone: rmlint
> 2.10.3 on btrfs (4 KiB blocks) deduping a 100000-byte file against a
> 250000-byte file with the same prefix is told bytes_deduped=3D100000
> with status SAME while only 98304 bytes were actually shared; its loop
> ends and it reports the pair fully deduplicated. duperemove and bees
> advance the same way, and jdupes advances by its own requested length
> without reading the field; all of them skip such a tail.
>
> Add FILE_DEDUPE_RANGE_REPORT_PROGRESS for file_dedupe_range.flags:
> with it, bytes_deduped is the length the filesystem actually
> deduplicated when status is FILE_DEDUPE_RANGE_SAME, and 0 on
> FILE_DEDUPE_RANGE_DIFFERS or error. Callers advance by it as today,
> but must treat 0 as "stop or subdivide", not retry unchanged. One
> cause of SAME with 0 is a sub-block request that does not end at both
> files' EOF, which the generic range preparation shortens to nothing.
> On DIFFERS there is no sound progress or mismatch offset to report, so
> 0 leaves subdividing to the caller, as rmlint already does.
>
> The default cannot change: commit 4a57a8400075 ("vf/remap: return the
> amount of bytes actually deduplicated") did exactly that and was
> reverted the next day; among deployed callers, duperemove re-queues a
> request while its status is 0 and would re-issue the same sub-block
> request forever.
>
> Without the flag nothing changes.
>
> Suggested-by: Darrick J. Wong <djwong@kernel.org>
> Link: https://lore.kernel.org/linux-fsdevel/20260805071414.3414870-1-matt=
hias.goergens@gmail.com/
> Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/remap_range.c        |  4 +++-
>  include/uapi/linux/fs.h | 11 ++++++++++-
>  2 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/fs/remap_range.c b/fs/remap_range.c
> index 26afbbbfb10c..63f1b6f90c16 100644
> --- a/fs/remap_range.c
> +++ b/fs/remap_range.c
> @@ -503,7 +503,7 @@ int vfs_dedupe_file_range(struct file *file, struct f=
ile_dedupe_range *same)
>         if (!(file->f_mode & FMODE_READ))
>                 return -EINVAL;
>
> -       if (same->reserved1 || same->reserved2)
> +       if (same->reserved1 || (same->flags & ~FILE_DEDUPE_RANGE_REPORT_P=
ROGRESS))
>                 return -EINVAL;
>
>         off =3D same->src_offset;
> @@ -555,6 +555,8 @@ int vfs_dedupe_file_range(struct file *file, struct f=
ile_dedupe_range *same)
>                         info->status =3D FILE_DEDUPE_RANGE_DIFFERS;
>                 else if (deduped < 0)
>                         info->status =3D deduped;
> +               else if (same->flags & FILE_DEDUPE_RANGE_REPORT_PROGRESS)
> +                       info->bytes_deduped =3D deduped;
>                 else
>                         info->bytes_deduped =3D len;
>
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index 34c6f219462a..c61bc98909cc 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -178,13 +178,22 @@ struct file_dedupe_range_info {
>         __u32 reserved;         /* must be zero */
>  };
>
> +/* flags for struct file_dedupe_range */
> +/*
> + * Without this flag, bytes_deduped is the requested length on success,
> + * even if the filesystem deduplicated fewer bytes (e.g. after shortenin=
g
> + * the request to a block boundary).  With this flag, bytes_deduped is
> + * the number of bytes actually deduplicated.
> + */
> +#define FILE_DEDUPE_RANGE_REPORT_PROGRESS (1U << 0)
> +
>  /* from struct btrfs_ioctl_file_extent_same_args */
>  struct file_dedupe_range {
>         __u64 src_offset;       /* in - start of extent in source */
>         __u64 src_length;       /* in - length of extent */
>         __u16 dest_count;       /* in - total elements in info array */
>         __u16 reserved1;        /* must be zero */
> -       __u32 reserved2;        /* must be zero */
> +       __u32 flags;            /* in - FILE_DEDUPE_RANGE_* flags */
>         struct file_dedupe_range_info info[];
>  };
>
> --
> 2.55.0
>
