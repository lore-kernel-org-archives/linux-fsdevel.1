Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E793F210F
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jun 2026 08:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780562701; cv=pass; b=V4XXTPYNFVghrvhCxrzvvVoN66Zs+0O7emMBlruCzd0+uJnjbD26S/2fSxmLjMsuTChEGy6eyPKSujTFTA3cJmRPbAYJLNZ+nsScFzn9LoYFiQJqzCio+Q/gWYSW9QSihHsitikDpFAAktDu/pXy8ol2qwmQA4dkO6B4R/TEsvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780562701; c=relaxed/simple;
	bh=tcixqLie982hIv8PBoKm9gcqeCdyh5cEMqTulnWGYlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qkfChgQ446JKCLdIMOLQJRnFg8t4/uxIiRZUo+5w4h8AROnQNAQJoMNL+RP1VlshIVot1kJkw1V74xHNYsUu7KkthySb9HR/cV3G5R9lLakEUBciyKrHlJKyFVAEKh8XRr1bOepywlOm/V3o0q5qgCVqRXP5Edp8ugOs3A7Qoi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CHBpme87; arc=pass smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHBpme87"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-396753f343aso4314641fa.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Jun 2026 01:44:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780562697; cv=none;
        d=google.com; s=arc-20240605;
        b=Wpayg0BKVhbEDme+sNTPAYnhe5pca8bn08FiQnynRdqmybC/FfVnk+hR0WvAwdOG/O
         lYGajJrDVP4SkhmyqEHLV511DnXu1ipPkOUUqof2n9YZaQFs0z7jlLUECFhqw/wbUaSj
         nBr6Qrrz7OPgt8wKo5h+GbNhxwH4+Z1qUKmlMNqfHFKRcQsgEMejZyJ43RvC0rerGCtu
         KP8q1siHvs9S1HlE+6nwRvsyiOAvDfzYWhBB9YldUzTJBTyt1zTmEERbXbfhA+ZYrAFK
         Zc6P3KZKWXEwpd046zd4Px0YOdr2yQAh2VinNBS1krThQQMFeTFeYuRm0K3RVlpbZqEz
         4y0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=L3cHoNPUe8V/yezCa2R1yfqgPO4v4dtOtG0GaxmqbF4=;
        fh=ND1nzP2KL91gifCQQ8ZXoJ7/Hwlv4Y8fFPVUZTkBgkY=;
        b=N2CmtbX0N9ls7TGccIkEagzz2gr+9fQScEg1rQXFCj1HNcsQoW5ULAu0oEISYwoJdi
         NU72dqP5VNa1ZwUgUfaJUUQpsaVECQrtaKlyGEnJE024ojszikjspT+YqHO3CE3X9Vao
         MCyCKevAA7TwOgoYGpRJ4ARtwF0LB1rqLf35D4X2y9/Zyd/U/DCn+yG7wyCdCePl6D9h
         HcwUK4Eukh+mJO80q0y9rvlAa367ttdB1GtPvBkvHdq4OuL3J6pplq2OUeqj1yjpwDD5
         40n91pq5JQD7JYIoA4Ne9YtOcwvpoVHCaHQAnm9hKcIukORJsIxLdl7A957fFkpL+gMU
         SoGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780562697; x=1781167497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L3cHoNPUe8V/yezCa2R1yfqgPO4v4dtOtG0GaxmqbF4=;
        b=CHBpme87upw/lIl0wle+L+gbSDVHKZ4ViKYCW47ZhfKCuXcw5+EO2plk4WW43DKqht
         sq6zCXBsBAeM4VDwQVHwMSJdqNOXF/qrUnDf+e/GKRn5p0F3TlNUKYRPTtHI3NiSt2yn
         lqJT+uApyXW2uGgmO8ot5sbpE4WcWl1trzHvVZwxvv5EoPy7LrQmdhkpMuLCy7jTRqxK
         769UMF60wTANCiLfjSNOUOrr0W1BqS3brN+wLzFAQ6rl5g0J6fDGX2yHhm29UxnG5Yst
         3C1vbey1C3sFvs25ZgtQCKAxoutI1pfEBBnsTNGqpQyAY/rFWXAL3P4/B8Z5gUPN54t5
         zpNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780562697; x=1781167497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L3cHoNPUe8V/yezCa2R1yfqgPO4v4dtOtG0GaxmqbF4=;
        b=Iv/ri7Z48kJokpek7qPEhUe2cIHxWqvgtev1+9RWp/+x9SBg7EKlc3cKvhv4JkMXdy
         eDMM3Y3qZAZSVEOZNfZ4gYC8OzNVU303erITa81OXlUU4W8eeJ/4rTCHDGIybi3GM2Ts
         eKHt4jGa1UETCnsQrB0RmsDDQzI/PMis5nNmvYkhCilE0+uQQnmVH0gpNsAM4ygQpd+S
         8YNYAYgTEC/ocggyzg3RfFIpy8U1S0/VlQqZEyW+1irhmCc3BptGcR/3EW6rwDpUPUwU
         u9UxrO9JnALXCxme57BE2a3UlNBABTWRFo4CZiCQedl8IzItnF4xNHs2YPVt+rjLAZmh
         5DJw==
X-Forwarded-Encrypted: i=1; AFNElJ9V2wbTSQq6ryavpi5Y27/rrL80T/nAyeOzYY/zYlZE2Jbaz4A3gFmTRwwS1ytlYGI0DT/Wkox6xjhJ1Lhx@vger.kernel.org
X-Gm-Message-State: AOJu0YwkIyGIYRfasD1TPlVJJYIEhcVYKGZIiM7lryHyFTzJ+K5MoKzJ
	19grI43L6KMRGPX9gqxoYATohVg98MT5MiMwFnuZeea06XP+dTxIkGLUFjPtDzyNwaw4aYzYiU0
	OVMh3BukQ3FTLbjltGWUTUvmlgXXByGg=
X-Gm-Gg: Acq92OGFqhiliU6XoGZ8osHjH0vyG29CIwe44ncmLe0f5HRUFUwBOWaOY6iwCC/kMRR
	d6T7PaftFq8yxOMcsJmGlvSrWVE4cDuznxO/K/96/oDabdcn5tt+UtNkSYIquv5XwBkr/4Hbhwp
	k5w/Z2TOVHArOVfqzuCXaHGrW1QRJrvUXKDqcJzBKioTWTA4qYeWS7sc7IF9LbeJf/i2mXnANP4
	Kj3bbCFbtl7iUE+wgBuJYpjORuDiTda2Bqm5hgPPfvMZecbhLzQ/AeQpnCXGdBHXhQ9ENtpFvNS
	ekjcSnEYpWPmwmmEUQ==
X-Received: by 2002:a05:6512:1313:b0:5a8:7317:5417 with SMTP id
 2adb3069b0e04-5aa7c08d4c4mr2669405e87.9.1780562696922; Thu, 04 Jun 2026
 01:44:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603175949.11665-1-hexlabsecurity@proton.me>
 <20260604042912.89893-1-hexlabsecurity@proton.me> <20260604042912.89893-3-hexlabsecurity@proton.me>
In-Reply-To: <20260604042912.89893-3-hexlabsecurity@proton.me>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Thu, 4 Jun 2026 17:44:45 +0900
X-Gm-Features: AVVi8Ceo4mqgz41kDK9SJ-522NW31Z-ehrj1eBRbavT1a28Kcl7EinaEK-o6kDM
Message-ID: <CANFS6bbHSkaPXyJvbs7QbvVKKXzjMvs3thweXYbEvoEKow5=0Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] ntfs: bound the attribute-list entry in ntfs_read_inode_mount()
To: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 6=EC=9B=94 4=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 1:29, Br=
yam Vargas <hexlabsecurity@proton.me>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> The $MFT attribute-list walk in ntfs_read_inode_mount() validates each
> entry only with "(u8 *)al_entry + 6 > al_end" and
> "(u8 *)al_entry + le16_to_cpu(al_entry->length) > al_end", but then reads
> al_entry->lowest_vcn (an __le64 at offset 8) and al_entry->mft_reference
> (offset 16) -- fields beyond the 6 bytes proven in range. al_entry->lengt=
h
> is attacker-controlled and only required non-zero, so a short entry (e.g.
> length 8) placed at the tail passes both checks while the lowest_vcn /
> mft_reference reads fall past al_end.
>
> al_end is ni->attr_list + attr_list_size (the on-disk size); the buffer i=
s
> kvzalloc(round_up(attr_list_size, SECTOR_SIZE)), so the sector rounding
> usually absorbs the over-read -- but when attr_list_size is a multiple of
> SECTOR_SIZE there is no slack and a crafted $MFT attribute list produces =
an
> out-of-bounds read at mount time.
>
> Validate the entry with ntfs_attr_list_entry_is_valid() (added in patch
> 1/3) before dereferencing it, matching the bound the other attribute-list
> walks now use.
>
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
> ---
> v3 (Hyunchul Lee review): validate with the extracted
>    ntfs_attr_list_entry_is_valid() helper (added in 1/3) rather than an
>    open-coded bound, matching the other attribute-list walks.
> v2: dropped the redundant Reported-by; reproducer omitted on the public l=
ist
>    (available to the maintainers on request).
>
> Sibling of the ntfs_external_attr_find() look-ahead OOB (2/3): the same
> struct attr_list_entry fixed fields (lowest_vcn at 8, mft_reference at 16=
)
> are read here with a weaker bound. Geometry is arch-independent (identica=
l
> -m32/-m64). Please add the appropriate Fixes: tag for the commit that
> introduced ntfs_read_inode_mount() in the new fs/ntfs driver (v7.1 merge
> window).
>
>  fs/ntfs/inode.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
> index a5f7400fd19d..77d7ea4a855b 100644
> --- a/fs/ntfs/inode.c
> +++ b/fs/ntfs/inode.c
> @@ -2002,8 +2002,7 @@ int ntfs_read_inode_mount(struct inode *vi)
>                                 goto em_put_err_out;
>                         if (!al_entry->length)
>                                 goto em_put_err_out;

It seems that some of the above conditions can be removed.

> -                       if ((u8 *)al_entry + 6 > al_end ||
> -                           (u8 *)al_entry + le16_to_cpu(al_entry->length=
) > al_end)
> +                       if (!ntfs_attr_list_entry_is_valid(al_entry, al_e=
nd))
>                                 goto em_put_err_out;
>                         next_al_entry =3D (struct attr_list_entry *)((u8 =
*)al_entry +
>                                         le16_to_cpu(al_entry->length));
> --
> 2.43.0
>
>


--=20
Thanks,
Hyunchul
