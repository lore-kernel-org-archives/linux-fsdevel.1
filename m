Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038A822652D
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 May 2026 13:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777640690; cv=pass; b=XlIviisD8sChG160I8jDf+PtVHY2QtRgNVTIvTsXKOYPyutxx7L713C1jNnRzuK/OjB5tPw6WHDoE8uL2z/fKE+j3e7baZP9STGCgOxJVzy20GAOqvxIhRCfP6SY2uFu/jKWS7F8KshswMA6h9H2tBZqr/zQRZtiPt+x0zy7BsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777640690; c=relaxed/simple;
	bh=a5s0Ws8xxjmTlA6TNYrog795OBqbc0Pp0SU5QDM2Qrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E6nz3n7VI3bk/ZZRoAEMMhYd646mAFk/gSJq7vmTrV5d++hxbxDqJ0sxBmxYVZgFg1KTjGHdKWFOCsVIfqaToAinSkwzkYbUF7HqJ7MVTBePZy4et3OkT9ViujoE2WInh9bJHdKmDiIbNGODGeWLMCLewvwuF9XYFTYdf1Xpp+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KlIS2nPH; arc=pass smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlIS2nPH"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-38e96a071c3so19975971fa.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 May 2026 06:04:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777640687; cv=none;
        d=google.com; s=arc-20240605;
        b=az/1zVaCHusKvT9B/sYjn5S7bZwwt5Uzfqf5dYlf/VoL+nk1oQ9FtfSlPkEid+FPHC
         TcsBIGU0Ce/g6diKRJyHzHQ5FYntaNvGUMhiFUMzwZ+jJRd+apAb82ObTdbFRtvn22z7
         LbvFx+rvRD8FnrmNJ7MyjdBk2SFpXg8srSazd4x0MAZxjbVgmeeL2Kak4PLPzqemKEfN
         j7t2TFQWP6dNg+T+3PO7e3Aq2CicfYI478BaOr7pVkBCd7QX0UOSjvDxuz0Cs8REN0QW
         nbMtvhOXWmFpMdjVxLLEMdJG4EprachqluveFMMMSixKJBRKhV8mi5Kyltjuqmmi/hRP
         Q3Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8T+W5p+jhDuKYVoO31TNQcR6W250JWtg5kdm/5Dy47o=;
        fh=voOBjJxyFFdZoHutoNT48AaJWV8YLKYpG2PFSfVyteo=;
        b=LxPeYDSZurNymfTq3Pt2VOUn0NIuuEUUQ57JnV4kdmnfx5SAWvuI5DH7H24YrfZEfv
         40ieW4tR8+fK18i78rbUxoEQr+FDBN9F+3QP78PK/9lRkE/ic5UkFXqfH6LZof5cS7Rd
         9UV43DuxGq7W3L4XTKqyAlu+QW6AMshG8y7ELG1xFtXbUJ18AUixULxG1yT1dFWwQ/Os
         WWDcJZUXMMIbTIVGiKw63DX+P5TkAwCjMX/aS9sgrwEJVt3BY4z4dad/cIPIuuwafk6+
         V1RhjGyTgGdqh1a0q/wgslI/Avdtc9iaO/vTO/wUJUvEJvu/0BeA3Q2NIvNrUOXKUySn
         fc9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777640687; x=1778245487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8T+W5p+jhDuKYVoO31TNQcR6W250JWtg5kdm/5Dy47o=;
        b=KlIS2nPHGV3mK2zClCSMYWiGmYBIoXSAlFM8aYlzx5eSkyjzhaEA9Cl//9XRe5NL2V
         kkr4gsO3b+Sm46SThV17gpaHoU5n4Q4drtkvQ9n2iCHSw4q9dlONcq5ZDZLstQblQJoG
         L32Geg1ckBqXyfz6SpSBmMxMhVjC30iwV5G6NnSRs9iflf/ENzBz6835RUVuXrt9vLBs
         kC/hItAl3kTVMmRm/fZS8sXUUG/lf7ee1EnOEHj3/SnlDz+J8iyy199AAvX6P2CovG5T
         tr9lKrx4VytvZc/3n2Iu31NDJ3YbS37htXEvy9kkYzs905V3S5YFKI5s0Z7jYSLKRSNI
         7iRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777640687; x=1778245487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8T+W5p+jhDuKYVoO31TNQcR6W250JWtg5kdm/5Dy47o=;
        b=EN5qoN1j4mmGhyxOpVoIYeTl5dtF88MUTqP082Kd/0Mw+rPBBdgwdrbAZ0ORycLrYf
         kTXm6QwLwr4j3Iz4IpXeVcNICKujvM+RCsUQ97nPZ3zcLnPeg3oGJ8R6PrK2xLi9nb/E
         ExYR4IWH62Swu+3bMt7D7tcPIbjZXIdm4g36Cup1ind70R6syq8OrhLpFyLrLJ/SdI0O
         leoYvQWkwHgDBFh4Xu2nccc7ItDm/cXVNQUcaPeA1kQN1jz3aRLWMjuT8ZOVawbV6EQl
         XiZl+aCDA1ZANkJXNQSbvD3v/rp5zkUmFBRvzHaCY1F6HKXJlJycFGVHfhuEJlCpiO5r
         M1BA==
X-Forwarded-Encrypted: i=1; AFNElJ/HpDI23EmdYGO1aW8GiTxhFlf6rrCtpLNXrz6Pr3VYFikY1caF4uvfFR+pZsS3r4icsjkbAYJB6PIrYCsQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxnN1t/GhqFYi0BhWUsqW2tOZtJAiyCozaw1bxdiqFrBh8hTdsi
	ENDUv7N66cirokrGSq0LqBjJZmjUSYGdxrBXrPTa7YyZtofICxZc/QxND5ELplixbzg4Zebcylt
	Sgh0uAx7Y328B/kb54zY3AcbYWEoU1rM=
X-Gm-Gg: AeBDietpQrX+FGxGrCkSbTWKJkTtU33b2d7/3v2lhfwce4c1HI22P2qZbqWmSb3MU8f
	ljyJ3e3PgovmMo86Kzw+SVeP7cxrtTvVW6ymFIMKfJ4FvTpN6PsYZ2+oRcpek/EQjUPWvgLzAbg
	ArriHeHFnzCvdCIwO430G94uSw/3EHtiDpeKml4USaYDP8WzqIHMQrVDRpieHTPsEKFBpqw0VZ8
	KDOnx/DJbzH74yXij/Btem/gFlmJvQfqnfRa87hFYbwK3oRVUZO6ZVOlLyoWrNFSbM/yrT4g+mv
	qDM00hqD5CE0LWJT2I8=
X-Received: by 2002:a05:651c:1581:b0:38e:da0:cc0 with SMTP id
 38308e7fff4ca-3934e1d6335mr25873961fa.14.1777640687101; Fri, 01 May 2026
 06:04:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777568957.git.charsyam@gmail.com> <0d61bd7f181f4e46207572c5d8a4b026e370a57b.1777568957.git.charsyam@gmail.com>
In-Reply-To: <0d61bd7f181f4e46207572c5d8a4b026e370a57b.1777568957.git.charsyam@gmail.com>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Fri, 1 May 2026 22:04:33 +0900
X-Gm-Features: AVHnY4JSuPGKUI1_UrSgt9RiXw8O4kUFz4HQWvBVC-psvcppq69IPx8pMlJ9f4M
Message-ID: <CANFS6bbpnXFy3ZPHMfrqb9+KpNGDVntPDy8hJ4NG_2Z7+A8BAQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] ntfs: redirty folio when ntfs_write_mft_block() runs
 out of memory
To: DaeMyung Kang <charsyam@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 5=EC=9B=94 1=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 2:21, Da=
eMyung Kang <charsyam@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> ntfs_write_mft_block() is called by writeback_iter() with the folio
> locked.  When the per-call allocations for @locked_nis or @ref_inos
> fail, the function returns -ENOMEM directly without unlocking the
> folio.  Any later task that needs the folio's lock then stalls, and
> the folio's dirty state is silently lost from the writeback
> iterator's point of view.
>
> Use folio_redirty_for_writepage() so the folio remains dirty for a
> subsequent writeback pass, unlock it, and only then return -ENOMEM
> so the caller can propagate the error to fsync()/sync_filesystem().
>
> Fixes: f462fdf3d6a4 ("ntfs: reduce stack usage in ntfs_write_mft_block()"=
)
> Signed-off-by: DaeMyung Kang <charsyam@gmail.com>

Looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>


> ---
>  fs/ntfs/mft.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
> index 4051b4823162..00f172fd1b21 100644
> --- a/fs/ntfs/mft.c
> +++ b/fs/ntfs/mft.c
> @@ -2740,8 +2740,11 @@ static int ntfs_write_mft_block(struct folio *foli=
o, struct writeback_control *w
>         ntfs_debug("Entering for inode 0x%llx, attribute type 0x%x, folio=
 index 0x%lx.",
>                         ni->mft_no, ni->type, folio->index);
>
> -       if (!locked_nis || !ref_inos)
> +       if (!locked_nis || !ref_inos) {
> +               folio_redirty_for_writepage(wbc, folio);
> +               folio_unlock(folio);
>                 return -ENOMEM;
> +       }
>
>         /* We have to zero every time due to mmap-at-end-of-file. */
>         if (folio->index >=3D (i_size >> folio_shift(folio)))
> --
> 2.43.0
>


--
Thanks,
Hyunchul
