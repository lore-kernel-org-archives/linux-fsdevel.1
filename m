Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D717191
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 00:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776816377; cv=pass; b=Vu0ntZ7F/38/qLdI17dpPzBRXJXpfa55x9nCyCf64rN+J0lPGy8UvLlYoULEWgZO5AyACINp9aXEipvI0XWojvryCCgstKn70vhWNVUYAFAVO7zQJQGT8+Gf6TT61yhHWaiVMOX1Y9/8aMgxv6xd3TuOO4hWaLu6fFO9u2SHvas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776816377; c=relaxed/simple;
	bh=QyZPwNxyqVylhuhPTq5pt2TIW/UbRQvTce/UZSbSBOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qgXW4/XB2SpMSKzz3rPKdFfqSU/gIG0gqgU7qQdtN6JiHWehKnVYbS6CRK4wySdRssZE/w8Qz6fKKP6odf3XFMiJCTc1cgfeb8XLcc6jgzzaPi+aW+fEO3Z08xWOA0GC3lYADLMXc57PBkGhaW+q8Tx9a5RV+AM96PfOYz/+xrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OqZBMsk3; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqZBMsk3"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a0ff30b240so7240206e87.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Apr 2026 17:06:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776816375; cv=none;
        d=google.com; s=arc-20240605;
        b=Oyz78ZtAK3pgF42Ew9MVSy8GIXr44sCpus4f9n03lq5N7DJ6JyHO9hIMlhYSHrdMzc
         fNqvFwhU8LqsYHJFTWViHtFIpCffMWiGQiRtwPeo7S6CgeWS1U/AawooK9+ciesmos7J
         qrSs03Mx5MF1X40hhJOd0QJ+1O8lqxqKVJpYDbCwUK0h32WqVaNZu5cnLA/bjLNNE8CA
         D+pJ3/YJq7VsJ+ImEzEfhCCSZOOoWgzf1FmA66J/vaM3h3e7IYNxjI69TOSouoqGzIVg
         wrqZsSw+utt54onLAg3NZI1e7CVAxsTHBqowCM3oPsNixJ/wtPWUNEnWVjA3um4wMOYC
         +izQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QjP+le5kgeCov+lKAbdpaAPtd8flVQyQ6xad4kv+i4g=;
        fh=M6h2ME2Mz/9+EulqOscdmn8muGXxmGkhvN1VQL0cUPw=;
        b=F1TFZbmUkJjJU0/MSxuCr0m7UxWl+yshIvBSR8ikTBRvv4EYZefVIxIMtbWqEWnu8w
         Z0/DWUBOY87owsZwugVDIxH9JFL0D268Z9LRq5d2URF4dnYPNaIK3uwH7Fof8AjSaIIn
         xMLM2Kvf01EEjtLs+7ELQXAu17hv1Obv0hr6lcxS/TjFafm9r1h2u+hzR09GFUR/1H8v
         PuVm8HHCMvS1h3oIsg86cWdu3A3JZYJIrGWdJ4UzHzLIrzTziWWa0wt1SQRogR/WqnPL
         aCMM5mqvS6I+FT7rQXuRgHg6pgMvFOtljk8xn4/TCoqdoXxa9WzTtZ71f/LY+PL2z8nh
         sHew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776816375; x=1777421175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QjP+le5kgeCov+lKAbdpaAPtd8flVQyQ6xad4kv+i4g=;
        b=OqZBMsk360RAmG0GJLJ42FmZk6vOercSRq45fyTtxHxkxBlqFLJr1UqBjGSIELtT9j
         +GSOspmAXaUW5er2JqATZnKxAqS0xU8xK9dOo7Cyy6u+FPdGrxQWUpkjhDtUWvdHvH5A
         tLWkT1PtlbywMAga4HvIlsOIEeAnfH6Au1PkJSGntKfa+s4R6rqh6LbzscDr7YzMEOWe
         qa076DVGVqGD7sasjdqzjfzNq1l2AN8Ki1ymsDBsqdXnVKQI03tS0E9iDF3WsXZzTnwA
         cJr4qJ/5Mt5B76HMXOGStDejSpkSlxx+0Et0/+KI0zaLCIQEE8Do+mQEwsJeumYPZkpU
         Uwvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776816375; x=1777421175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QjP+le5kgeCov+lKAbdpaAPtd8flVQyQ6xad4kv+i4g=;
        b=IibO3BGVeCn6iw+JD2bATzaqvf0csIws6lw6WaARQ/Zu0Pscvx/1ZpxxHc50RWFpFi
         p65YMrHIcGOclH19oYWwLl7x/IlyI3p7FhmzQAxHPLBDPx5Ozm5fYKTbEROspf94f2KL
         K+Cct75jWJmDcAcEA9oCAfzOPcD3eCxU84LfNfMbH5dslPve+IJnpURQqlQzr+K+vKGn
         GGqAbR9A5PdWoYSEorBSEDvRnUv+IwdKqC5NhLoTAKKc4SiLqhCrayy7FM1EFzMu79rC
         6Lf74g/7px6TexG/kNtKdWwgaMrz9MJ16KKz94fKdS9WaNeTlcMuIwew885GV7UDDRN9
         MlFA==
X-Gm-Message-State: AOJu0YxnF5oEu3JlDZCSbbStCyjGg5QpRuXWNLPpmeIsmsn4apeYSc2O
	2iFr3ycWcnSd+ZwBgTuXESxoYlgGl2lDq2JbkRBqP5PBMsDWX+YKOvq7fAHgwXDiZOGDX4zIbDJ
	dbAOnUyUjl4W5AGKsRdlLu4mTjG4y0ls=
X-Gm-Gg: AeBDievUoY2xNA63QUVDZitF/VKwBpC9tE5lAkYqqfSux+scOVzTsnQeHDgcThPpWCy
	OwM1LIwjLZ9L+smav03ohEL2jRH6o4umWLyfRxd1M8X5fqWJsGcbWwSCxFsQ65XUAg/lu886ECM
	mO/8M7zLgJHUNhroTDOWpmcm7KuAkPXVufHHeD6UqQZ+4hkMtoKhlts3nx1+rEX5kehKdbrqkkz
	dQJL6ayGQGEXDNJovmHbJ5fl0WZ143Yc5YJpVHj0Q/fIZnicI7wYHInNcydpqmFXO25ybhfIHQo
	+59FTrJyAu+VJ6wA3u9YHwPbu2e2
X-Received: by 2002:a05:6512:3b8f:b0:5a3:cee3:a10f with SMTP id
 2adb3069b0e04-5a4172be0e6mr5949817e87.7.1776816374446; Tue, 21 Apr 2026
 17:06:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421095916.6496-1-linkinjeon@kernel.org>
In-Reply-To: <20260421095916.6496-1-linkinjeon@kernel.org>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Wed, 22 Apr 2026 09:06:01 +0900
X-Gm-Features: AQROBzDHZLNzhSCm2y4SXUP2XFcAQoG_mGPEmstH0mFOaWzu9gf2qhdR7B-w-Ew
Message-ID: <CANFS6bYaceOTd7wX9vnqa1-OJzS_OgFhgFOjhztrgKRHNFYdUA@mail.gmail.com>
Subject: Re: [PATCH] ntfs: fix mmap_prepare writable check for shared mappings
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 4=EC=9B=94 21=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 7:00, N=
amjae Jeon <linkinjeon@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Linus pointed out that checking only VMA_WRITE_BIT is incorrect.
> Private writable mappings (MAP_PRIVATE) set VM_WRITE but do not
> write back to the filesystem. Also, mappings that can become
> writable via mprotect() (VM_MAYWRITE) must be handled.
>
> Use vma_desc_test_all(VMA_SHARED_BIT, VMA_MAYWRITE_BIT) instead,
> which matches what other filesystems do.
>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>

Looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

> ---
>  fs/ntfs/file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
> index f55f55d4ca9a..e0265a8825f2 100644
> --- a/fs/ntfs/file.c
> +++ b/fs/ntfs/file.c
> @@ -650,7 +650,7 @@ static int ntfs_file_mmap_prepare(struct vm_area_desc=
 *desc)
>         if (NInoCompressed(NTFS_I(inode)))
>                 return -EOPNOTSUPP;
>
> -       if (vma_desc_test(desc, VMA_WRITE_BIT)) {
> +       if (vma_desc_test_all(desc, VMA_SHARED_BIT, VMA_MAYWRITE_BIT)) {
>                 struct inode *inode =3D file_inode(file);
>                 loff_t from, to;
>                 int err;
> --
> 2.25.1
>


--=20
Thanks,
Hyunchul
