Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2F33A8F7
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jun 2026 09:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780563689; cv=pass; b=CnmOYLmJRP9zwPV1JyDBIYZFH7HElmiR3gnKOvKYDzYNSPIso1JSddpTS1+8Pxl7o0zN8kWk3tU1Q2qG0xDG6tF5W29PqgaUTU6Z0XWtt1CJuQAbbIcy1edW9xh6J/xjtX7y2fJ0nsu43B0EcTu2w0tYhaWUGgvXn+hoSay/d7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780563689; c=relaxed/simple;
	bh=4T2D2tpQxgl2tH0H+dPM8kNaOFN7DhgmLwudpzcS6wI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NVMvuPflNc3p2N4kKN3sAWZuL5dk4BvQLmF+vhOifudA96go0UliCzCnJ31pvSs8t1dAbYG1IqYnRjGl19iRVOKyMs8HVZArBVeJkQYI5mDq4qce3Bm0xiGPV6j7JG1CKRw0psUXKhAvLBCJ+Jv8s4i1PDkize7phlTl4QvEIO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGhl2JkW; arc=pass smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGhl2JkW"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-396669329fbso15026161fa.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Jun 2026 02:01:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780563685; cv=none;
        d=google.com; s=arc-20240605;
        b=OI6hstjabHdgM2bRtfJ76Q1kVdxYpGs8PgT79KXwN/vbQo3WXv5SyJLfrlh9R4m8RN
         j1rRp32FQ3EiqgTepTmQW1fVT+vxpVcezdlaAOJvrqhJxWzYvryHSzGEWW33lZs2CjP3
         wd4IT+BqQkO9DjfVMKN5/nskoslqcWEJxQf2SPMVzO1oQ1o4k1fIzqg6akfH2kysXxOM
         ikXMMEs+cgi+UrUeIt8h9xkXI6wSWx4ue52nYOa4qDWWfbNrf6zPujXsz0YAbBHwT81n
         bYNdF/NYwoVZ6yhQE0xD9OSdzBBqs1y8q2PmxZCSdMdLQL+p1CykmG3JHeye/vA7dk5S
         Z/FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XpaGhX3yU6zNFhiI4Kk7DMmiLvZepBTS4HIVT+KVt6k=;
        fh=vQFImZhvUVoiSJdGaZ9Z0xYOJ6+/+LRCi1KGLIldR84=;
        b=DRpn3EfWlEeSKvDxC7XSNQ0ISQydEPwtLYslDR7qOOiVhHZjoLqS0BYC9HIBoaY8Ax
         PhhWijW+P5G1ZK/HE/ON1idMGXKc/1cSmKCV8l5wwZzHY5F2QSMvcXbpoQzeZzGM8u+K
         fnNCjr9d49ZDRwJ0VNwNEIqlznbnpwClJPTM14M4I6IaXcbyT0vLeIqeuGZdmg/8uJdb
         MGcY3azksZ2zi5P5sM8aLFnwQTJsL5p38/FtjrAb4UDJn++28Ny0mQ83+/3wWiBU4+hz
         qScBO9sOREYC8QOmzqcnakpNcvSspXCkCLsfx97xERqtBDevcswj7noTd2dqmNVJ6duJ
         aGJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780563685; x=1781168485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XpaGhX3yU6zNFhiI4Kk7DMmiLvZepBTS4HIVT+KVt6k=;
        b=FGhl2JkWgzGv1kNplUGHe4VR5dOqnxAW6fmCg6NQPiqMgkU7Qc1Z6yGIqZV8+OT7zU
         iQJyWoFBqoR5+KlxE7UdLWurc2YvmyniAc+Q4whq2a4+wikeKtqAhSqnHvS7xMM5oD90
         7ywtg+SJC5fd0es6io/olpQFibwzOwJSC3fNzW0rqkzgME+0TnP01M7TasHar3LeY3SE
         OHA4NVskN6kAUckYKrGzlOOhAPWYz+sblbcspal8MhILELdSGTqmQV9kNulgtCvdZS1z
         wOEB+byhKLARI1RQPSY5LuYPBbk60xmg0siVMhhSvMtetschgnlQhCwaPh7SPp94r13V
         uq/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780563685; x=1781168485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XpaGhX3yU6zNFhiI4Kk7DMmiLvZepBTS4HIVT+KVt6k=;
        b=nwEBExT90xXMGvgCAXymjoo2q2cQOdr/syN20dL4sjR+iiqHVaus8D+vJainc0cNmC
         k+Q5BU9Q799Fc0wwI/68sPKS5Chtqvcbese/I6VW0E/1bEImFGPowpOW3DcipEgeYfSy
         /kHxQHHxsLUwrdtjyytuhXz2EM/lLydS5mc2hwTk+aWZ+n/Bl+tCN4q7xrEnqwRmePFH
         ynrdE96g++7aW3zdkbvpWbpu+scf6bj3c99v+wdlUSW173VD08WLiNtRl1JAcrBmCmS2
         tg2kNCurXoaCy49tIWSmk8CXcy5tXk9LyfwnYzGA3A6HaxjEpbHKgLoMSqAUZxjsTW6S
         mDYg==
X-Forwarded-Encrypted: i=1; AFNElJ9ToLE88lQ4xbbQvXh6xzrdciyUYhsF3azA4/go2X70EUfFpnNdlllcy0xb0n6mxTVMXpj/8n3xKQqt51R2@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2EPu3kbGJ/MhEigGaXIdiiYZq17xcExsToT8s3pWnRjbxZsak
	1luwAFdDyHXEA4uDqwuXic4Dv1Lk07m3Kt6glnQ+V752KNzYE1ysO5pN1TexB/97CrLu71G/yEX
	+DmGyc9sq0O8H3PqkA5X8X948TDfx7MoreW1c
X-Gm-Gg: Acq92OECPJpLps2/XpYDrI+JmFncULfppj/sr68e59+LqN9WrV5ZFP0bKQpvKtYcH2V
	j6g8FK2GptuVgcHAqkW6ApuoKPNnVfb2i3H2k6Fyu2Nq0Bid8uElU7opcibOiWK4zylOD7abvNS
	sE4tyxx5A8lMRQDccZXHKnfS+ZOggxV2dKqKzWBbmUjcU1adNIvcjjpl6ricXpybT9awq3o4LCf
	Pt0d1bcwShEH3QDzVuS9a3zcd1AtLrUIA7FhNo81N1IN/yKQuj8fMKTloi/SDDQBJeq4pvAdi3P
	ivxRVpc+SWU2yst3cw==
X-Received: by 2002:a05:6512:3514:b0:5aa:7397:73a8 with SMTP id
 2adb3069b0e04-5aa80ca287dmr791805e87.15.1780563683636; Thu, 04 Jun 2026
 02:01:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604053921.100409-1-hexlabsecurity@proton.me>
In-Reply-To: <20260604053921.100409-1-hexlabsecurity@proton.me>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Thu, 4 Jun 2026 18:01:12 +0900
X-Gm-Features: AVVi8CdKKXIO7p1zOxL1E4wrCJd1Ll9yoxzi4fAzq8gMf1aoAuF-rv5A2KL6TkI
Message-ID: <CANFS6bYtjMEtu_pn=XzrRd1Vyof00T75G3UEB9vLSy9Wqz2v2w@mail.gmail.com>
Subject: Re: [PATCH] ntfs: validate $FILE_NAME length before converting the name
To: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bryam,

2026=EB=85=84 6=EC=9B=94 4=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 2:39, Br=
yam Vargas <hexlabsecurity@proton.me>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> ntfs_is_extended_system_file() walks a base inode's $FILE_NAME attributes
> and, for a name whose parent is $Extend, converts the on-disk name to the
> local charset via ntfs_attr_name_get() -> ntfs_ucstonls(). It checks that
> the resident value [file_name_attr, +value_length) lies within the
> attribute, but never checks that file_name_length (an on-disk u8) fits
> inside that value.
>
> ntfs_ucstonls() then reads file_name_length __le16 characters starting at
> file_name_attr->file_name (offset 66 in the __packed struct), so a crafte=
d
> $FILE_NAME whose value_length covers just the fixed header but whose
> file_name_length is 255 drives an out-of-bounds read of up to ~508 bytes
> past the resident value -- and, when the MFT record buffer is a tight
> kmalloc (mft_record_size equal to a power-of-two slab bucket), past the
> allocation itself.
>
> Reject the attribute when file_name_length does not fit within
> value_length before the name is read.
>
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
> ---
> Reproducer omitted on the public list -- available to the maintainers on
> request. This is a crafted-image filesystem bug; posting publicly per the
> security@kernel.org guidance on the sibling fs/ntfs attribute-list fixes =
that
> such bugs fall outside the kernel security process's threat model.
>
> The over-read was observed under KASAN by mounting a crafted NTFS image
> (fs/ntfs built as a module against v7.1-rc5): a $FILE_NAME on a system fi=
le in
> $Extend with value_length 68 and file_name_length 255 trips, during inode
> read, a slab-out-of-bounds read of size 2 in utf16s_to_utf8s() along the =
chain
>
>   ntfs_ucstonls <- ntfs_attr_name_get <- ntfs_is_extended_system_file <-
>   ntfs_read_locked_inode <- ntfs_iget <- ntfs_fill_super
>
> off the kmalloc-1k MFT record buffer (mft_record_size 1024, allocated by
> map_mft_record_folio). A benign mkntfs image is clean on the same kernel
> (control). With this bound in place the crafted $FILE_NAME is rejected wi=
th
> -EIO ("Corrupt file name attribute") before the conversion, while a benig=
n
> name (value_length =3D=3D 66 + file_name_length * 2) still passes. The bo=
und is arch-independent: struct
> file_name_attr is __packed, so offsetof(.., file_name) =3D=3D 66 and the =
check
> decides every case identically built -m32/-m64.
>
> The only other reader of file_name_length for name conversion is under
> #ifdef DEBUG in fs/ntfs/namei.c (not built in production); it can be guar=
ded
> the same way if desired.
>
> The flaw is original to the fs/ntfs driver: ntfs_is_extended_system_file(=
)
> landed with the driver itself (linkinjeon/ntfs, v7.1 merge window). A Fix=
es:
> tag against that introducing commit is appropriate -- I'd appreciate you
> pinning the exact SHA from your tree, as it is not unambiguously citable =
from
> a mainline clone. checkpatch clean.
>
>  fs/ntfs/inode.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
> index 360bebd1ee3f..d1a79c276502 100644
> --- a/fs/ntfs/inode.c
> +++ b/fs/ntfs/inode.c
> @@ -581,6 +581,17 @@ static int ntfs_is_extended_system_file(struct ntfs_=
attr_search_ctx *ctx)
>                 p2 =3D (u8 *)file_name_attr + le32_to_cpu(attr->data.resi=
dent.value_length);
>                 if (p2 < (u8 *)attr || p2 > p)
>                         goto err_corrupt_attr;
> +               /*
> +                * The name is converted below; file_name_length is an on=
-disk
> +                * u8 that is not otherwise cross-checked, so make sure t=
he name
> +                * fits within the resident value before it is read.
> +                */
> +               if (le32_to_cpu(attr->data.resident.value_length) <
> +                               offsetof(struct file_name_attr, file_name=
) ||
> +                   offsetof(struct file_name_attr, file_name) +
> +                               file_name_attr->file_name_length * sizeof=
(__le16) >
> +                               le32_to_cpu(attr->data.resident.value_len=
gth))
> +                       goto err_corrupt_attr;

There is already a patch that validates this in ntfs_attr_lookup().
Please refer to the link below:
https://lore.kernel.org/all/20260530143514.3083601-2-charsyam@gmail.com



>                 /* This attribute is ok, but is it in the $Extend directo=
ry? */
>                 if (MREF_LE(file_name_attr->parent_directory) =3D=3D FILE=
_Extend) {
>                         unsigned char *s;
> --
> 2.43.0
>


--
Thanks,
Hyunchul
