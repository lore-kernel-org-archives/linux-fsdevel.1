Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECD33D810D
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2026 22:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784240884; cv=pass; b=On7rpvZFr/zYpcywgSNpRcW9W4mUaW5itiI2uvz4nTTHxbLHKvdsmmpjGAvPCgSh0R7jlakj1gHZOUhDT6Z/ROsZOdrQ54ZWSrNAw1QOvx3wEBZblhPeyv/K+1pDt1Jva4hyCYIBUJaQppHHqFqUExossbJYgZ1lSDw5fLQK7L4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784240884; c=relaxed/simple;
	bh=36S0U8ZKHso0zSZbSUR6K0XPp7VyeMsY9Cy88ZBSqmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uQYQZytEC6iNs6wyatc+0BwTQTNCNvAyaDNvtJJXiRMF4j1Y5giTO92tG+4fQn0W/PmseACFIZfxeTNtUt7d4MNtFigDdNo/4SAypGdOm665vydcm1DY47/Mu/0htY9F2YZQxtXoID1FLPWEkweGJTWcAZYxc38XweoGB7F2z6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qwI7Ur/0; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qwI7Ur/0"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5b159850b16so3514217e87.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2026 15:27:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784240877; cv=none;
        d=google.com; s=arc-20260327;
        b=QZR3y/YS/2dBziEx7o9A5wnrd4gZhY2HxbCw0Iof5wdJ/gmGpmPh/Mh7GcVUr2t0DI
         c/oHlDiBj9gUGJkcTsbNfzBUbIkrIz/8NnFPHeLcC1Q1Oi86tKbDLD8kYpNpR34104ZY
         lGtYqTl/goIIx+W2FpqnYOtE61+Njen5kUik7A/jX2S8ZPOk0Wej08TVFeCWl8cRsGuk
         0d7Xjmeym245gL3x0mqnwVDghKl21QvEACKXQ7syw9x/zRXmmXIn7oaE+Lys1xU/fqSi
         PsDgkbDhrAeV7tSbbzceoxCKHBA+SBen4E6FBE5xfe5bkUoFHx+1k3e4Pc6tC8XmGPzN
         GiWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yESGPZGwteHWRt1wVlj6huMV7qPlDAM5pOXMbeHzuO0=;
        fh=rUaU6JZNsr1ZOc9f8apP4C5dGo7PoSlvtc1GWgSEas8=;
        b=qxBhZvEW2A5REifSjtwHptIZnG3NU/THvuHUh3czgCHnj3Btey9ErsgUCHhMHGdBkU
         yz1JFFkO/MO3SnaB6dwpeL4E1EWLfuoJ/p1LxSag0VH5/nJl47NsDSBmc4oTpEOwh9n5
         zow/IOBjwGYfogfc7imXWTxy+rVaQN2I5dxe8Og1pBizBp+lf+Jx5VO48PC7O0nuf4LE
         h8cx9wVpMLLP7e/dwo0qfXDFIo8ZGv391Fb7Jx/3ekskv+///aJKdriNwMMXlDqfOD7F
         7t+ENonfyDWU9n7+h8MhyuoKWYc0vr4LgFXiwp5o91zldJbD9fFkTDogbi3qC8R+MCzO
         Rq6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784240877; x=1784845677; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yESGPZGwteHWRt1wVlj6huMV7qPlDAM5pOXMbeHzuO0=;
        b=qwI7Ur/0cqgQcUe+DQE1UEySaybS5D5nfPfWl5l0i/CWR2DUZZVEUxhQPGznfBb23d
         EAC4YUXcWCUbH1w3RkZISONl9tlbPSmzzg5vWvS7SVWnCsjp2hx/fungMPNvPW8WfstX
         A84eSrDxHnXhs1xrjuvoKd2kYzwComrYyDPyA0HSsBNL+ckNuSZwQM4MySbDX9lMEckV
         /dyDb12TyHbl4bkx5d4vSVn8kJW835EgHTwnJZF3yo1frV7L4cHELhbAXI9TIHoemVUW
         MwnMU7jPK5GBrmwvB54PNjjDA0LiD3l+AiIZnUB6StKFQ0R/6HdlOYyTTVoMkVEKpNp0
         LTwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784240877; x=1784845677;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yESGPZGwteHWRt1wVlj6huMV7qPlDAM5pOXMbeHzuO0=;
        b=fumpRexwkoBwyvDbNRHiJRrA7HT2I5VQhPQpNcWwBIiVkwpvhdzd6yxoqVr8PxY0rk
         3F0FG662tjAOIHljSAgh4tf2jkPmm1Y5Kx17tiEkem5Zju6rJQ6Usq1JEJ4uakVXmlsu
         V1KQLC9EBpwyHwviISmto9CnexYDZE0hU1Aw+M5JsgAcqTJQuLH0kdxFc5t85jwOlKGi
         FfGIAzex9MPERNNydjVga49XfkabR4/WjBIccBm2W8p+83/Ym32bYKG7HXICyorTJeon
         fdlRrrhVqSARC7s0x/2zgFNVhmYCstaVloEV8Sct84tfXD7ZE9u+5LFxFmHrIDpAQVKl
         qHLQ==
X-Forwarded-Encrypted: i=1; AHgh+RokNl+tCRE84KgQQgq28twpSMapQjqtOixRLuUc/cehiEZD0M2wwlMdog8j5FjFPT88ZiUyRmXnaSE83xrW@vger.kernel.org
X-Gm-Message-State: AOJu0YxkKxdd02mD1Qv8V2//OvCiEqJBp64BOs29DS0rQ+gV84fCiM6R
	Ip5hkntPiDHTFa/76qdqsTziNupW2o76Ax1FqiNKgiLSW+696o4w1hBXEYYpyobgvqtzUNo+quq
	eOc/89+9gULAECe5+oNhCWOQoMpLEDqs=
X-Gm-Gg: AfdE7cnHMdc/Vv/UnuqI6by9T0j8pbOg9Fm9nDwZe1/Nt35XX3c5cUFCTq6xfC47P7I
	YOgj7lUSBPLb/j1bh6+N/Qb/ccxrcfoCAqOlBBoENDvSbZ3SUlyzEpknCzKvHjHjYEqj8TJZz27
	IAl7LN+F/yLZC0KfXsdBlm2Ro3qnVQwLL+MjiTQ9P68fJn+/pxZqJ36fUM14Z3A4mzYD4g0LQNv
	wprYd1VAxNU/Ud1Qp8Tmyp8TdyKEY+nPSQhPfYABbIQF6jarELgMiA+mTNZt4I=
X-Received: by 2002:a05:6512:a8c:b0:5b1:5d07:13bc with SMTP id
 2adb3069b0e04-5b28fabd161mr9767e87.61.1784240876841; Thu, 16 Jul 2026
 15:27:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716024640.13396-1-linkinjeon@kernel.org> <20260716024640.13396-4-linkinjeon@kernel.org>
In-Reply-To: <20260716024640.13396-4-linkinjeon@kernel.org>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Fri, 17 Jul 2026 07:27:44 +0900
X-Gm-Features: AUfX_mz0iAFih-MBNpzHqi0dioHhRuBKpWq9areKXLAW3ZjVjUvJnT4ddJRwB9c
Message-ID: <CANFS6bZbBGuTugd4fNZK4i2JcyODeZGtGPObj-qPZFu62mznyQ@mail.gmail.com>
Subject: Re: [PATCH] ntfs: fix kmap_local_page() usage in compress
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: ntfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 7=EC=9B=94 16=EC=9D=BC (=EB=AA=A9) =EC=98=A4=EC=A0=84 11:47, =
Namjae Jeon <linkinjeon@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Several compressed I/O paths discard the address returned by
> kmap_local_page() and later access or unmap the page using page_address()=
.
> This is invalid for highmem pages, and local mappings must also be unmapp=
ed
> using the address returned by kmap_local_page().
>
> Map each destination page in ntfs_decompress() only while producing the
> current sub-block. Use memcpy_from_page(), memcpy_to_page(), and
> memzero_page() for the other page accesses. Remove unnecessary local
> mappings from ntfs_write_cb(), where pages are accessed through the vmap(=
)
> mapping.
>
> Fixes: 495e90fa3348 ("ntfs: update attrib operations")
> Reported-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>

Looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

> ---
>  fs/ntfs/compress.c | 38 +++++++++++++++-----------------------
>  1 file changed, 15 insertions(+), 23 deletions(-)
>
> diff --git a/fs/ntfs/compress.c b/fs/ntfs/compress.c
> index d83d3e8e06ae..e866f43ca30b 100644
> --- a/fs/ntfs/compress.c
> +++ b/fs/ntfs/compress.c
> @@ -177,6 +177,7 @@ static int ntfs_decompress(struct page *dest_pages[],=
 int completed_pages[],
>
>         /* Variables for uncompressed data / destination. */
>         struct page *dp;        /* Current destination page being worked =
on. */
> +       u8 *dp_kaddr;           /* Local kmap for the current destination=
 page. */
>         u8 *dp_addr;            /* Current pointer into dp. */
>         u8 *dp_sb_start;        /* Start of current sub-block in dp. */
>         u8 *dp_sb_end;          /* End of current sb in dp (dp_sb_start +=
 NTFS_SB_SIZE). */
> @@ -191,6 +192,7 @@ static int ntfs_decompress(struct page *dest_pages[],=
 int completed_pages[],
>         /* Default error code. */
>         int err =3D -EOVERFLOW;
>
> +       dp_kaddr =3D NULL;
>         ntfs_debug("Entering, cb_size =3D 0x%x.", cb_size);
>  do_next_sb:
>         ntfs_debug("Beginning sub-block at offset =3D 0x%zx in the cb.",
> @@ -223,7 +225,6 @@ static int ntfs_decompress(struct page *dest_pages[],=
 int completed_pages[],
>                                  */
>                                 handle_bounds_compressed_page(dp, i_size,
>                                                 initialized_size);
> -                               kunmap_local(page_address(dp));
>                                 SetPageUptodate(dp);
>                                 unlock_page(dp);
>                                 if (di =3D=3D xpage)
> @@ -269,7 +270,8 @@ static int ntfs_decompress(struct page *dest_pages[],=
 int completed_pages[],
>         }
>
>         /* We have a valid destination page. Setup the destination pointe=
rs. */
> -       dp_addr =3D (u8 *)page_address(dp) + do_sb_start;
> +       dp_kaddr =3D kmap_local_page(dp);
> +       dp_addr =3D dp_kaddr + do_sb_start;
>
>         /* Now, we are ready to process the current sub-block (sb). */
>         if (!(le16_to_cpup((__le16 *)cb) & NTFS_SB_IS_COMPRESSED)) {
> @@ -290,6 +292,8 @@ static int ntfs_decompress(struct page *dest_pages[],=
 int completed_pages[],
>                 /* Advance destination position to next sub-block. */
>                 *dest_ofs +=3D NTFS_SB_SIZE;
>                 *dest_ofs &=3D ~PAGE_MASK;
> +               kunmap_local(dp_kaddr);
> +               dp_kaddr =3D NULL;
>                 if (!(*dest_ofs)) {
>  finalize_page:
>                         /*
> @@ -324,6 +328,8 @@ static int ntfs_decompress(struct page *dest_pages[],=
 int completed_pages[],
>                 }
>                 /* We have finished the current sub-block. */
>                 *dest_ofs &=3D ~PAGE_MASK;
> +               kunmap_local(dp_kaddr);
> +               dp_kaddr =3D NULL;
>                 if (!(*dest_ofs))
>                         goto finalize_page;
>                 goto do_next_sb;
> @@ -429,6 +435,8 @@ static int ntfs_decompress(struct page *dest_pages[],=
 int completed_pages[],
>         goto do_next_tag;
>
>  return_overflow:
> +       if (dp_kaddr)
> +               kunmap_local(dp_kaddr);
>         ntfs_error(NULL, "Failed. Returning -EOVERFLOW.");
>         goto return_error;
>  }
> @@ -557,7 +565,6 @@ int ntfs_read_compressed_block(struct folio *folio)
>                          * least wasting our time.
>                          */
>                         if (!PageDirty(page) && (!PageUptodate(page))) {
> -                               kmap_local_page(page);
>                                 continue;
>                         }
>                         unlock_page(page);
> @@ -643,8 +650,7 @@ int ntfs_read_compressed_block(struct folio *folio)
>                 }
>
>                 lock_page(lpage);
> -               memcpy(cb_pos, page_address(lpage) + page_ofs,
> -                      vol->cluster_size);
> +               memcpy_from_page(cb_pos, lpage, page_ofs, vol->cluster_si=
ze);
>                 unlock_page(lpage);
>                 put_page(lpage);
>                 cb_pos +=3D vol->cluster_size;
> @@ -683,14 +689,7 @@ int ntfs_read_compressed_block(struct folio *folio)
>                 for (; cur_page < cb_max_page; cur_page++) {
>                         page =3D pages[cur_page];
>                         if (page) {
> -                               if (likely(!cur_ofs))
> -                                       clear_page(page_address(page));
> -                               else
> -                                       memset(page_address(page) + cur_o=
fs, 0,
> -                                                       PAGE_SIZE -
> -                                                       cur_ofs);
> -                               flush_dcache_page(page);
> -                               kunmap_local(page_address(page));
> +                               memzero_page(page, cur_ofs, PAGE_SIZE - c=
ur_ofs);
>                                 SetPageUptodate(page);
>                                 unlock_page(page);
>                                 if (cur_page =3D=3D xpage)
> @@ -708,8 +707,7 @@ int ntfs_read_compressed_block(struct folio *folio)
>                 if (cb_max_ofs && cb_pos < cb_end) {
>                         page =3D pages[cur_page];
>                         if (page)
> -                               memset(page_address(page) + cur_ofs, 0,
> -                                               cb_max_ofs - cur_ofs);
> +                               memzero_page(page, cur_ofs, cb_max_ofs - =
cur_ofs);
>                         /*
>                          * No need to update cb_pos at this stage:
>                          *      cb_pos +=3D cb_max_ofs - cur_ofs;
> @@ -730,7 +728,7 @@ int ntfs_read_compressed_block(struct folio *folio)
>                 for (; cur_page < cb_max_page; cur_page++) {
>                         page =3D pages[cur_page];
>                         if (page)
> -                               memcpy(page_address(page) + cur_ofs, cb_p=
os,
> +                               memcpy_to_page(page, cur_ofs, cb_pos,
>                                                 PAGE_SIZE - cur_ofs);
>                         cb_pos +=3D PAGE_SIZE - cur_ofs;
>                         cur_ofs =3D 0;
> @@ -741,7 +739,7 @@ int ntfs_read_compressed_block(struct folio *folio)
>                 if (cb_max_ofs && cb_pos < cb_end) {
>                         page =3D pages[cur_page];
>                         if (page)
> -                               memcpy(page_address(page) + cur_ofs, cb_p=
os,
> +                               memcpy_to_page(page, cur_ofs, cb_pos,
>                                                 cb_max_ofs - cur_ofs);
>                         cb_pos +=3D cb_max_ofs - cur_ofs;
>                         cur_ofs =3D cb_max_ofs;
> @@ -758,7 +756,6 @@ int ntfs_read_compressed_block(struct folio *folio)
>                                  */
>                                 handle_bounds_compressed_page(page, i_siz=
e,
>                                                 initialized_size);
> -                               kunmap_local(page_address(page));
>                                 SetPageUptodate(page);
>                                 unlock_page(page);
>                                 if (cur2_page =3D=3D xpage)
> @@ -794,7 +791,6 @@ int ntfs_read_compressed_block(struct folio *folio)
>                                 page =3D pages[prev_cur_page];
>                                 if (page) {
>                                         flush_dcache_page(page);
> -                                       kunmap_local(page_address(page));
>                                         unlock_page(page);
>                                         if (prev_cur_page !=3D xpage)
>                                                 put_page(page);
> @@ -818,7 +814,6 @@ int ntfs_read_compressed_block(struct folio *folio)
>                                 "Still have pages left! Terminating them =
with extreme prejudice.  Inode 0x%llx, page index 0x%lx.",
>                                 ni->mft_no, folio->index);
>                         flush_dcache_folio(folio);
> -                       kunmap_local(page_address(page));
>                         folio_unlock(folio);
>                         if (cur_page !=3D xpage)
>                                 folio_put(folio);
> @@ -856,7 +851,6 @@ int ntfs_read_compressed_block(struct folio *folio)
>                 page =3D pages[i];
>                 if (page) {
>                         flush_dcache_page(page);
> -                       kunmap_local(page_address(page));
>                         unlock_page(page);
>                         if (i !=3D xpage)
>                                 put_page(page);
> @@ -1308,7 +1302,6 @@ static int ntfs_write_cb(struct ntfs_inode *ni, lof=
f_t pos, struct page **pages,
>                 }
>                 pages_disk[i] =3D pg;
>                 lock_page(pg);
> -               kmap_local_page(pg);
>         }
>
>         outbuf =3D vmap(pages_disk, pages_count, VM_MAP, PAGE_KERNEL);
> @@ -1443,7 +1436,6 @@ static int ntfs_write_cb(struct ntfs_inode *ni, lof=
f_t pos, struct page **pages,
>         for (i =3D 0; i < pages_count; i++) {
>                 pg =3D pages_disk[i];
>                 if (pg) {
> -                       kunmap_local(page_address(pg));
>                         unlock_page(pg);
>                         put_page(pg);
>                 }
> --
> 2.25.1
>


--=20
Thanks,
Hyunchul
