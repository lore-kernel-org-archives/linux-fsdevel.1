Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87E91990A7
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jul 2026 00:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783297357; cv=pass; b=fiqCb0V6sU6lWdsBrvjMSIgWOdPI5iU5hUj6Jr6ggaa5f2p9kiESEFSlbXofwPLgzIoIpfWDz60CoqxuSbPFOR+WloRQVYARRZYlZSAqIgUvTyZY039nxJR0KxdL7DRTxSbWtuv7bIKV9NU+hc9/r3wRWvKhjzfHaeCsy4ZWovs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783297357; c=relaxed/simple;
	bh=SELHEft1jz1Xoqv7Iyp3qKTfA3829EWzEdfzt0ypDxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PQmc4IH6TW95RZQByajtgRcF8f71Gjgd3VYyAnhW7R1/4rCYexb2+NADvupZrwwTMyvGN6xFHX2lNUP6r4SHGzDTSf5dBvKPQUUeXkBhmY4weMdPxz6nOqg1+xEsNND9pl8EdXgwOWKhvUZB1KGujzsJZai288y63TaHU1dy0FY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZZ/QY/RU; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZ/QY/RU"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5aeb18fe7ceso1321501e87.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 Jul 2026 17:22:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783297354; cv=none;
        d=google.com; s=arc-20260327;
        b=DQMKanfafJb/2l36IsPdTMtv7GXu2EQU6VkI1YaZ+iVDB9kB90P8RVohEC9lQPqoxm
         lBGHNwlfw9TkrwIqIroKzH2cbZ5j12CwzcghNTrnDNNs897pUfxRHt5WYIvSQypOK/ya
         R3+clt5VeaMhNptFHq6Z1081+lt64Qwb/wLGTotgmEta66zlCqLLe3qG3IsttY3rnWgM
         eqww6sJrwvCDzN7/uwUoGKA7pnMOG1jyG8g/PQeIRNQR0GWClq22r3Q6EkvuiiDW6Slq
         RbLmdEBnccwfp0T/ZEG/UWPSwEESJHHEMGH3LLEDVtf/yl6fUxWETnovdEDzC95Bwz6g
         5Eww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uf8TLOzXIp0mI3acHoGcmNpmOInMyt/I+I11Ad6yDbw=;
        fh=JzrNobGxi88pwiuScx34xB1u3hwubPyGp9m6IMWXSbQ=;
        b=Lg3CAv/bjX0s66rdNuAM0nvEePtr29uYn5s7i3c3RrRUKAXvUmbsluQ7LflT7tuvmo
         KCtz3usmITQK0YhZ/27TtM+0oIULl9202ytSwYEImlk0QbIIr7NX9M5YKHfcnxIdqapq
         3lYxhGOqQP1c75b/sivxZZb2yQAla5Zp+mt0O49zPx5ut+iMNyT+hyAHw666LjtXw1mK
         lbhUqbOXc1pZJjkgpWS12iyTOg5pTsQvILihPgmmEbfXVcaGKDYXBkhpXgKrMzPkBgag
         dX1MofqZ66L9kzkXOUx7ge5TESpPvWlxw9UMmmP84eZhwhDdRkanIfPbrLmg5ks2KiFz
         oHdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783297354; x=1783902154; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uf8TLOzXIp0mI3acHoGcmNpmOInMyt/I+I11Ad6yDbw=;
        b=ZZ/QY/RUz7A6yRO0y7k+5wSAeUHOawm58mAfBOl/RCIuS1ZDHB6f/C1Gox/E7fFGHP
         1eN+X9mPPEVjG2cNOybTNGGdbeLJVtug/oZgNJ6yfqKVL3oc/7s8ukupWMDktmABc87W
         0orIRPXA/aN/swGD2jrCb6fKlDdXYLAuYR/96McWFdb6Zm0YS514kOgoQG5z0oyJnx7U
         ArD4wB/Dp76VNZ1mJ/VMp70jD90cVrDzRbkJTA5Q/iyfQ8TjVFD2GKyyfVk31IYLjvlW
         xqoKpQ2LDxeMQgOsjkbQV/+GZn3hV32luVjD8bEjwmvWy5ECpAF78lf9Ni39sLPovBIy
         selg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783297354; x=1783902154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uf8TLOzXIp0mI3acHoGcmNpmOInMyt/I+I11Ad6yDbw=;
        b=pICb7oJaKclhBsfJGZ43QS7wIXoVobWXYZ3CkmWtWgA7JgzOwuN8icArUcvUVYEfMk
         xEYJehRX7ussvvYBhdR7Ino2N8aMX1HxgRQ4Qg4sCQC5VVFUXZl7cbus5+uQyNR828by
         GH0fCnCUhEJ4oQUcLKnv3J07itvuXMaYkZ6VmmreT1QkGUoUpR9Uaufy8ckHlRaPt7gz
         3MLfGRaB3dt/aWyHxKdre7iV2pie9RvvI+bX6Wk7Xjb2ME8sXhHgMgz0DIfy/7KuYrUe
         VyCD/DUyko3wtTzaZW+rJl+l3UZ54nycSXaFo9JKxqkj7PcH4uFBI44VE3TOqspjfn6c
         cCZg==
X-Forwarded-Encrypted: i=1; AHgh+Rq0utltEhEVBvu68b1YXMOUY8BrCGqUe6M6LXLXlx0DNYSgE/peLighWonZ+HDHuUySVQXlp7Pddqlrna6L@vger.kernel.org
X-Gm-Message-State: AOJu0YxEZ9tABl0MWYVCqZRLVMT6uRJmZkvznWdgo45BzKIT2VQ+2AxJ
	OcIhMmSw9TSuwrXd1mGy7pH+eeQ1wvLQwwCk6DabzssHJnxZJmoqunnz5bLNyEZ9DMuLmppKBwr
	fjOToH+dRuPQGFqj/eJaDHbE09hm6MRM=
X-Gm-Gg: AfdE7cmNRdNjy6LYVINCwVoPgniyvfAhxMsrmslCCy/CXgg/PI7rfPICUcV5hkWrxcu
	bdkUmPH6J1BgHPXB9zLNo0bTl4iFCnITviuA53x/XpOTEh9bnVtZz0oK+pkDJDG70d6aW4wf1Fu
	jG4TJ7LhSSXVdwKMZrI5Wab1HJjCmLqhqbPkEeIjls+VKHYbt6ohLUjru8f/xO13aKWlzTumKkC
	HZnNoDNtudA4BGa2hYLKqYmgyYuN7HiQmYkwYTa8VUeZjRkIpQbErN52mSK3z2bDR0Y1s3y
X-Received: by 2002:a05:6512:6206:b0:5ae:bba1:f22b with SMTP id
 2adb3069b0e04-5aed5094ba3mr1192502e87.51.1783297353923; Sun, 05 Jul 2026
 17:22:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260704094007.426882-1-yashnikov.valeriy@gmail.com>
In-Reply-To: <20260704094007.426882-1-yashnikov.valeriy@gmail.com>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Mon, 6 Jul 2026 09:22:22 +0900
X-Gm-Features: AVVi8CePQRabhZqz3aY2fgbZY7t7O0E-jC0ScvcJh7YpinzZ0RGo28viQldT5Es
Message-ID: <CANFS6bYRew3iXDOzC0adcrno3hAQHbjENV_b8ShXcCR2b28LbQ@mail.gmail.com>
Subject: Re: [PATCH] ntfs: avoid calling post_write_mst_fixup() for invalid index_block
To: Valeriy Yashnikov <yashnikov.valeriy@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 7=EC=9B=94 4=EC=9D=BC (=ED=86=A0) =EC=98=A4=ED=9B=84 6:39, Va=
leriy Yashnikov <yashnikov.valeriy@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=
=EC=84=B1:
>
> ntfs_icx_ib_sync_write() calls post_write_mst_fixup() when ntfs_ib_write(=
)
> returns an error, intending to restore the buffer after a failed write.
>
> However, ntfs_ib_write() returns an error immediately if
> pre_write_mst_fixup() validation fails. The caller,
> ntfs_icx_ib_sync_write(), interprets any error as a write failure
> requiring rollback. It does not differentiate between I/O errors and
> validation failures, and calls post_write_mst_fixup() anyway.
>
> Since post_write_mst_fixup() assumes that the index_block contents is
> correct, it doesn't perform the boundary checks, which results in
> out-of-bounds memory access.
>
> An attacker can craft a malicious NTFS image with:
>   - large index_block.usa_ofs offset, pointing outside the ntfs_record
>   - index_block.usa_count =3D 0, causing integer underflow
>   - or index_block.usa_count larger than actual number of sectors in the
>     ntfs_record, causing out-of-bounds access
>
> KASAN reports describing the memory corruption:
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   BUG: KASAN: slab-out-of-bounds in post_write_mst_fixup+0x19c/0x1d0
>   Read of size 2 at addr ffff8881586c9018 by task p/9428
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x100/0x190
>    print_report+0x139/0x4ad
>    ? post_write_mst_fixup+0x19c/0x1d0
>    ? __virt_addr_valid+0x262/0x500
>    ? post_write_mst_fixup+0x19c/0x1d0
>    kasan_report+0xe4/0x1d0
>    ? post_write_mst_fixup+0x19c/0x1d0
>    post_write_mst_fixup+0x19c/0x1d0
>    ntfs_icx_ib_sync_write+0x179/0x220
>    ntfs_inode_sync_filename+0x83d/0x1080
>    __ntfs_write_inode+0x1049/0x1480
>    ntfs_file_fsync+0x131/0x9b0
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   BUG: KASAN: slab-out-of-bounds in post_write_mst_fixup+0x1aa/0x1d0
>   Write of size 2 at addr ffff8881586c91fe by task p/9428
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x100/0x190
>    print_report+0x139/0x4ad
>    ? post_write_mst_fixup+0x1aa/0x1d0
>    ? __virt_addr_valid+0x262/0x500
>    ? post_write_mst_fixup+0x1aa/0x1d0
>    kasan_report+0xe4/0x1d0
>    ? post_write_mst_fixup+0x1aa/0x1d0
>    post_write_mst_fixup+0x1aa/0x1d0
>    ntfs_icx_ib_sync_write+0x179/0x220
>    ntfs_inode_sync_filename+0x83d/0x1080
>    __ntfs_write_inode+0x1049/0x1480
>    ntfs_file_fsync+0x131/0x9b0
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Let's move the post_write_mst_fixup() call to ntfs_ib_write().
> The ntfs_ib_write() function calls pre_write_mst_fixup() at the beginning=
.
> If the index_block contents is invalid, pre_write_mst_fixup() fails and
> ntfs_ib_write() returns early without calling post_write_mst_fixup() on
> bad index_block.
>
> Fixes: 0a8ac0c1fa0b ("ntfs: update directory operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Valeriy Yashnikov <yashnikov.valeriy@gmail.com>

Looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

> ---
>  fs/ntfs/index.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ntfs/index.c b/fs/ntfs/index.c
> index c5f2cf75b750..faa7ee920a3a 100644
> --- a/fs/ntfs/index.c
> +++ b/fs/ntfs/index.c
> @@ -110,6 +110,10 @@ static int ntfs_ib_write(struct ntfs_index_context *=
icx, struct index_block *ib)
>         ret =3D ntfs_inode_attr_pwrite(VFS_I(icx->ia_ni),
>                         ntfs_ib_vcn_to_pos(icx, vcn), icx->block_size,
>                         (u8 *)ib, icx->sync_write);
> +
> +       /* Perform data restoration before returning */
> +       post_write_mst_fixup((struct ntfs_record *)ib);
> +
>         if (ret !=3D icx->block_size) {
>                 ntfs_debug("Failed to write index block %lld, inode %llu"=
,
>                                 vcn, (unsigned long long)icx->idx_ni->mft=
_no);
> @@ -147,7 +151,6 @@ int ntfs_icx_ib_sync_write(struct ntfs_index_context =
*icx)
>                 icx->ib =3D NULL;
>                 icx->ib_dirty =3D false;
>         } else {
> -               post_write_mst_fixup((struct ntfs_record *)icx->ib);
>                 icx->sync_write =3D false;
>         }
>
> --
> 2.54.0
>


--=20
Thanks,
Hyunchul
