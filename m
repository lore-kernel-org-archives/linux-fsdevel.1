Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D6243F097
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2026 23:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784244400; cv=pass; b=VVlZgbeI+FDM3KAiNa89xQy8b7yAgtSt3OKEPnwxL2yirDyYkMSs0ahbO4LCCrS9mIaCNB/cqJdBEC72Tp8FN08nFxeCegTDYfm0594HItttbWRseSNUXmarl5umUM8d0oNAqEOYr49tJTGfAGlTkhFuvqNpqOL+WQg7SVWNiGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784244400; c=relaxed/simple;
	bh=g+zbN7i0Ld0/5VxtaP8iuYmbfEiLGqlXkkdPJoQb1c0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z3pHdioru/Bpt0KNzB3Esq5AhfG4LXR7psGitG+An7KY9b1n19pfCr52wt1qksmgE3KfbJBeYcUNPrqPbtfwlbwLjbjDHAVZAnr/Kwo1jcOH6eSW3T6btjj3l7bzPxsxalRAuk+9AqVhU3piRPiu9vtCfjnos2+Ct6le9ORVApQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FfvxGUUW; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfvxGUUW"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5b28c91fba5so920272e87.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2026 16:26:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784244395; cv=none;
        d=google.com; s=arc-20260327;
        b=saQXEl78nI3Kl72k1eWrqWfvx5tr5PsU1KQHAVDezxF6z9e+ewx/KW6RnWXyzmELhu
         /bjJt+oFozMhb4/cB9EJ602py8lgm63IqHLbK9Q8o//VZqABadCC1PtlNf9ONZFa/PFh
         HkkJD/g7wShMO1DaYoQCsWbSfqnrPcRp/gAl4pPddDQvEnsqPlvHuJnfbohEsc1gztbm
         7h11fYomVIj+JkOXNHAIwt5BclbAkOYuyZuvZy3eWts/q/0OeZIFKE8abG3rO/3SlLBi
         P+xUKOs0MqYiLcdQ79eDi6mI6wXEFq/JrjzsC/SRf8qB0/aMBQ8qS7UUu8wQMfSw67Ub
         XAFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TUDZG6t3tBj+v+xcwcH2u+ZyuWYZ6P6HE5tnGyLIGcI=;
        fh=on4Csze/kbgcZrRM5mwI2x1PY9LdE5Jl18ZvGVjtysM=;
        b=gww/5LLK2W+HwnDka8Kf7eXirPJzN/JwIxd2GXU3QAfxhON8ME1WbG+SCCqAQFr7Gb
         We8YfLLNFEJZ4JJSedZlBRSmDnFrkVoM8nHr5qastvB5HaI4M2Xd5VhmHxnjucLWcmzW
         KpfTbS3JhEckHwqd5OuNcsUVwM73WWM+xmVbbyZJQavodnTLlYJ32zhiBiVhHMX02Mu7
         WoTjjjdvqbXnF128e4LzIR6rqnwckNvTn5RPXv6KtwG3KfR0XC56YChDzXn5fng+9SjX
         2ptWHKrqgmHENKQC9pi4YhQ4DQYPYE/LunlVEjL+5RADjLHbrjCPBSD1hiQCh4BwaZMA
         cNWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784244395; x=1784849195; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TUDZG6t3tBj+v+xcwcH2u+ZyuWYZ6P6HE5tnGyLIGcI=;
        b=FfvxGUUWz88xMIyR/P65lKvhJUVGzZRh1xRb3LK8gNM8rbyfmmD24V6PKs/yt7sBzb
         qTZL0SYZ9shXd1wSwj6/jl8rttXVBKbr6RwfV58w+vb1em/4AVFGAttjqR52t9+/+Kxu
         D/HL3+K/sOegCtjfy2XO22/BCpuw9JMLVOcr0EL+83E8XSHvCLXpTYh5Ejk8Dh69LvtW
         bTrroFmo9D0xa94ecRtZnBCjmfQWkXJTVAL+7885Fff4G7J7AUIjW63F+9Vbd3r0tzeh
         GHbWYttEvqTzZoo/c+tvEz6HdrBDejW/eL+GSUhjDJMIY9yl73ywzNF3Coa35zMEwkk7
         Q+Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784244395; x=1784849195;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TUDZG6t3tBj+v+xcwcH2u+ZyuWYZ6P6HE5tnGyLIGcI=;
        b=jkU1z5zqUC1LPIqmWvK27wyaaAajhyeU+ZIfesqMONQowAIhB9egZ/FqTW/RAhCmuJ
         0Imb3V2FCM1LN1KL1hQjTGcEIlvKmniRQ9PtxU72lB4ixypoAghdyyt0zGD68UNvhdkG
         XSapCJzlrBrumSajPpf92pYESM8VIeNVJ7iTkLGnHVAIbxpNpC5X7ospY2epq0nW9t9h
         fYAkYJkuPCcK6JDVdVTyMgwJgXTvGXSeL6eHyf7oBaGX7xxyivm3T+/SkW9EURfu1MZ8
         FjM+vauJu/tDz1GUyk8MKQ1oKaSpA1dkVWIBUyQBmVqUPioxqEPDIMGj2PVfznyQWi8l
         ZlgQ==
X-Forwarded-Encrypted: i=1; AHgh+RrIzMHwsmVTJZ5hrpTt+z6R8JuUO8yY4EL7gFJqIEY0eJfv6pVXQsTZ2PlM18baAxrhpJI+pBs8gLZt4Pm7@vger.kernel.org
X-Gm-Message-State: AOJu0YxTp8erL7D5EEz55W3ejD7TUL2jU/Vm5ugO91uQWuwv4FMuk6Lh
	+DzggEhMXZfnGgqc6VSjxILPDNzcaC+AovgdfcNaAgcnVcZjwxtHI4C7LJv3eECobsUTQTELl54
	sT4QdJgh+uBwL2XClGLEeGInQASGPhGQ=
X-Gm-Gg: AfdE7ckY8O3NohcLDNHAc7GB54WVJCuaJB9SXRcGlX1YexlG3Fi5CJBEfuwLNttIGv5
	zeOBm5hRnA8eG4gxiPAGOuBeqc5Rwvk/1OUGSC8C+9c2AdJMXQjbGO6mxxJPRyeYRzAWtWAav09
	vRXBkzyAuYSEtyC0tyq8muq9ab6/Q/GopNTRM+YEF+sGpGvgf+1Zmln3/yB3YZ9uP/oQrGYl+iT
	fG85u5nsWUxHLz7qodm6lx3ZObTEv7doXOEDcROCfJKR4mzi7AV/K8pLfdxAmg=
X-Received: by 2002:a05:6512:1253:b0:5ae:badc:47d3 with SMTP id
 2adb3069b0e04-5b28a1bb566mr937877e87.28.1784244395307; Thu, 16 Jul 2026
 16:26:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <714A2D6E-5B61-4185-AD6C-328250C8E040@nozominetworks.com>
In-Reply-To: <714A2D6E-5B61-4185-AD6C-328250C8E040@nozominetworks.com>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Fri, 17 Jul 2026 08:26:22 +0900
X-Gm-Features: AUfX_mzpJvJDTCE5ql8NEhcy82qiN6QH2IrJOqE6Gxg5V3dZK23CkDPcqz3eTvo
Message-ID: <CANFS6bbAW=XRf=d5Pb6zkyoJkAOQM1H3Wu6F5T31s8j664L52A@mail.gmail.com>
Subject: Re: [PATCH] fs/ntfs: Fix index_root heap OOB write in ntfs_ir_to_ib()
To: =?UTF-8?Q?Alexandro_Cal=C3=B2?= <alexandro.calo@nozominetworks.com>
Cc: "linkinjeon@kernel.org" <linkinjeon@kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 7=EC=9B=94 16=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 6:46, A=
lexandro Cal=C3=B2
<alexandro.calo@nozominetworks.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> From: Alexandro Calo <alexandro.calo@nozominetworks.com>
> Date: Thu, 16 Jul 2026 11:30:04 +0200
> Subject: [PATCH] fs/ntfs: Fix index_root heap OOB write in ntfs_ir_to_ib(=
)
>
> ntfs_ir_to_ib copies all entries from index_root into a freshly allocated
> index_block_size-byte buffer without verifying that the entries fit in th=
e
> available space. The entries in index_root may be larger than the usable
> entry space in the index block.
>
> This can cause OOB writes past the end of the allocation.
>
> The validator ntfs_index_root_inconsistent() checks that entries are
> self-consistent within the IR value, but never cross-checks them against
> index_block_size. There is no bounds check in ntfs_ir_to_ib() before the
> memcpy.
>
> Fixing this at the sink in ntfs_ir_to_ib() since
> ntfs_index_root_inconsistent() validates the logical consistency of
> index_root as a structure and a root with large entries is a structurally
> valid root. The bug is a size conflict of ntfs_ir_to_ib().
> Also, the validator is called once per inode load in
> ntfs_read_locked_inode() while ntfs_ir_to_ib() is only called during a
> reparent, a check there adds no overhead to the common path.
> Moreover, even a future call path that bypasses the validator would still
> be protected.
>
> This heap out-of-bounds write is triggered by a crafted filesystem image,
> which is not in the kernel threat model, anyway, fixing memory errors wou=
ld
> be nice to keep  things secure.
>
> Signed-off-by: Alexandro Calo <alexandro.calo@nozominetworks.com>
> ---
>  fs/ntfs/index.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/fs/ntfs/index.c b/fs/ntfs/index.c
> index faa7ee920a3a..529697b5891e 100644
> --- a/fs/ntfs/index.c
> +++ b/fs/ntfs/index.c
> @@ -1112,6 +1112,7 @@ static struct index_block *ntfs_ir_to_ib(struct ind=
ex_root *ir, s64 ib_vcn)
>         struct index_entry *ie_last;
>         char *ies_start, *ies_end;
>         int i;
> +       u32 ib_cap;
>
>         ntfs_debug("Entering\n");
>
> @@ -1127,6 +1128,15 @@ static struct index_block *ntfs_ir_to_ib(struct in=
dex_root *ir, s64 ib_vcn)
>          * as well, which can never have any data.
>          */
>         i =3D (char *)ie_last - ies_start + le16_to_cpu(ie_last->length);
> +
> +       /* Entries must fit in the allocated index block */
> +       ib_cap =3D le32_to_cpu(ib->index.allocated_size)
> +               - le32_to_cpu(ib->index.entries_offset);
> +       if ((u32)i > ib_cap) {
> +               kvfree(ib

Could you add an error message?
Other than that, it looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

> +               return NULL;
> +       }
> +
>         memcpy(ntfs_ie_get_first(&ib->index), ies_start, i);
>
>         ib->index.flags =3D ir->index.flags;
>
> base-commit: 37e2f878a7a660a216cc7a60459995fefd150f25
> --
> 2.47.3
>


--=20
Thanks,
Hyunchul
