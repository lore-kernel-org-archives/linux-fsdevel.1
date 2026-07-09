Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5772E3DFC94
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jul 2026 20:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783630270; cv=none; b=Yss9SWldQAT2wrTWzDOenTSkoAUivWoMxm+yFoxx6cJ54BXAo1M839rhxbeLkKZgrFrC0qoVHpa6c2eQB/BVrbqJahlYlerMkFnmZfeuWF1zR/vfAyvc7S7wqKxXBNfOqvxnRHuSjLxRQZLZycXS7chagulGFw2SfIGezKXhxvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783630270; c=relaxed/simple;
	bh=umElq0MMGVChNfw54yLreIQbIVGp8Pa7Qn2aXG+nAZc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LIHU00U8pThSv9igCIAa+oZC7bGPPxQjlVTt11lWXIh+aWyFUCpS6aBattA7kbm/jERDvW/ZK64GwHuO5btZUcX73NJl/CPPOEgKS2GZUQK0Y+kKMWVF85obMPqscDb3lx5FVB17A534q+/SYHrXeiiHKEISRQQW91umRBMWsvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=miReKt7D; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="miReKt7D"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-809b19a7f25so3717167b3.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Jul 2026 13:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1783630267; x=1784235067; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bKVrd/qb/dlrwb5LSbXIIv+cb80vqtWS2KIZBKKFOJI=;
        b=miReKt7Du1JAejKZMZVNrNtEwYY4An5oVNBjv7TIhVyyeBA4Y9OVf+JeicrpCDzgKc
         UIvQ0YkpW+/i0KubqGHkdAWz1xkP/RCYJ9duBWMl+RCbtC6APbCsbjWgLUsQuSwcaCY5
         PLuV2mvg2xoNTXasV886eQt5ETGAB3XucfpevUQkQfe0LUZ0udQ5CzxVu8Cj4hYar5qQ
         fZwZh7WOJeMTJ0PvmD2JYw0dTQ4trarL+9+6j8YCEcTZo+oREMl8+tRTp9UsEk8zu1hh
         4ZarBghoZ7bIiHGcL92FqJ5YkLg2FmFK5C/3YgXYS4UEv6qww4O+4XHhCQ811eNl0WNk
         N3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783630267; x=1784235067;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bKVrd/qb/dlrwb5LSbXIIv+cb80vqtWS2KIZBKKFOJI=;
        b=NeMcuHBC+0hYNbesf+TLIP45VAFLpUdbIM7Xf/EoGKoLKk3GervTyhhNxkql9o43+R
         3Tp4oMwYoKbByy46BLzPvYNZqhLj4NXtvZAkqGXuWQKE3o9rs0uWrGAhmP/FMPAZEpf7
         PwKFHFrZpB0Tcsnw8ku455BG0f4yrJDqP5HTAxDQHQ9Sk7GjOqzHk6AdzMzT9S9QFtAm
         MSDQ2eDvyyupWIir0n29bpryeLRBiAJwBDtcuglv6EeJkcfTMjBDkHHBJfbK5N8AXq/g
         zjnFO56D4NgbSk8GlDWbN9JZHvj3zvZa5PGEbGVD7twj4dr0mzd44WswGtvKb5FE2hZU
         vfuw==
X-Forwarded-Encrypted: i=1; AHgh+RpOatkSRQfcp67vq93nGAoE6wwBe3J5k/Sb8G+tEKoTvrp0XEMr+7kGEXj/IynxWLKzATTfREbe49aJUHXJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8copiK5XXPJyqQadlVgsdHBWqjgO2g9r+t1sOk2r3PgELQUVg
	mbypacSCz/qNDtlIP4+d/Ny135aAkZ7KZqAuK4SGINjDp+cuKMZwqIs63kUAM7x4WGE=
X-Gm-Gg: AfdE7cmPod0fbMCveBOFdLHbRGRSbcRFlAogeQV0DHW19eLtmMAd+7tnIHVdYEvvsom
	7Op+X9l5gw+LmNPS1WF7F7pXOTyeqxpZfI308OOF2ez+azV8pcR2aCYFyPgAJdQJpLqvPoImNTF
	fX/9zmQFcWCgYSMkPnSAUM/DIWZPyFFbQo3fWeOvzeEhutzFI21C7lYC+4+nPpj7fngB1Wfc4jd
	RSKeBHV74DY1Q3PXeodZ7EZuuOkfL0lsunkaxGCYqjrberdVwEgDJE9oPPwS/Hstz0nQx5Utf6k
	N5uK/Jm7h9BTgpeZXOlMPuHZXHROa/ibY8x1XDeTuA0K0onm6mhk/oQRvsURKfepRypM5GRhhni
	Tk3HLH9GGDST/w+Co53Tooj6yBKW42BvdxnfnPr5pYe7Wcfef+nE2vIVA41kbsUrWziuzfri4yU
	gcgbnELa6oj5PEPAD/kWGQ8jL5FmKXKPnwCIMwoZZrBvdK97RG0CoYmzGwprE362hqwNJsRZwJX
	vMDZfbEAH1BT8SV4pZQLbqeoSZ3l6mw++kK3JEyqEfTqjjwel1UXbkNV2YiQ4FY0esJ+n2nWzH5
	mcVTdfI=
X-Received: by 2002:a05:690c:6289:b0:7fd:4ef9:e5a4 with SMTP id 00721157ae682-81dbeb6267fmr74443757b3.29.1783630267267;
        Thu, 09 Jul 2026 13:51:07 -0700 (PDT)
Received: from [10.0.0.3] (162-197-212-70.lightspeed.sntcca.sbcglobal.net. [162.197.212.70])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e6c1ee792sm28642097b3.38.2026.07.09.13.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 13:51:06 -0700 (PDT)
Message-ID: <18201652f2112bd00148e31be04b696b088d017a.camel@dubeyko.com>
Subject: Re: [PATCH v5] hfsplus: validate thread record before delete key
 rebuild
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Kyle Zeng <kylebot@openai.com>, linux-fsdevel@vger.kernel.org
Date: Thu, 09 Jul 2026 13:51:05 -0700
In-Reply-To: <20260709010203.49664-1-kylebot@openai.com>
References: <20260709010203.49664-1-kylebot@openai.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-07-08 at 18:02 -0700, Kyle Zeng wrote:
> hfsplus_delete_cat() is called with str =3D=3D NULL when the last open
> reference to an unlinked HFS+ hardlink backing inode is closed. In
> that
> case, the function finds the catalog thread by CNID and rebuilds the
> catalog key from thread.nodeName.
>=20
> That reconstruction path reads thread.nodeName.length directly from
> the
> catalog B-tree into fd.search_key and then copies length * 2 bytes
> into
> fd.search_key->cat.name.unicode. It does not first check that the
> found
> record is a thread record or that its size matches the thread name.
>=20
> A corrupted image can therefore provide an oversized thread name
> length
> and make hfs_bnode_read() write past the catalog search-key
> allocation.
>=20
> Read the CNID record through hfsplus_brec_read_cat(), which bounds
> the
> record read to sizeof(hfsplus_cat_entry) and verifies that a thread
> record's size exactly matches nodeName.length. Together, these checks
> ensure an accepted thread name fits HFSPLUS_MAX_STRLEN. Reject non-
> thread
> records before building the delete key from the validated thread
> name.
>=20
> Share the thread-record-type helper between hfsplus_find_cat() and
> hfsplus_delete_cat().
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Assisted-by: Codex:gpt-5.6
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> ---
> =C2=A0fs/hfsplus/catalog.c=C2=A0=C2=A0=C2=A0 | 25 ++++++++++++-----------=
--
> =C2=A0fs/hfsplus/hfsplus_fs.h |=C2=A0 6 ++++++
> =C2=A02 files changed, 18 insertions(+), 13 deletions(-)
>=20
> diff --git a/fs/hfsplus/catalog.c b/fs/hfsplus/catalog.c
> index 776ce36cf076..fe11c4b6dd99 100644
> --- a/fs/hfsplus/catalog.c
> +++ b/fs/hfsplus/catalog.c
> @@ -204,7 +204,7 @@ int hfsplus_find_cat(struct super_block *sb, u32
> cnid,
> =C2=A0		return err;
> =C2=A0
> =C2=A0	type =3D be16_to_cpu(tmp.type);
> -	if (type !=3D HFSPLUS_FOLDER_THREAD && type !=3D
> HFSPLUS_FILE_THREAD) {
> +	if (!is_hfs_thread_record_type(type)) {
> =C2=A0		pr_err("found bad thread record in catalog\n");
> =C2=A0		return -EIO;
> =C2=A0	}
> @@ -350,23 +350,22 @@ int hfsplus_delete_cat(u32 cnid, struct inode
> *dir, const struct qstr *str)
> =C2=A0		goto out;
> =C2=A0
> =C2=A0	if (!str) {
> -		int len;
> +		hfsplus_cat_entry entry =3D {0};
> =C2=A0
> =C2=A0		hfsplus_cat_build_key_with_cnid(sb, fd.search_key,
> cnid);
> -		err =3D hfs_brec_find(&fd, hfs_find_rec_by_key);
> +		err =3D hfsplus_brec_read_cat(&fd, &entry);
> =C2=A0		if (err)
> =C2=A0			goto out;
> =C2=A0
> -		off =3D fd.entryoffset +
> -			offsetof(struct hfsplus_cat_thread,
> nodeName);
> -		fd.search_key->cat.parent =3D cpu_to_be32(dir->i_ino);
> -		hfs_bnode_read(fd.bnode,
> -			&fd.search_key->cat.name.length, off, 2);
> -		len =3D be16_to_cpu(fd.search_key->cat.name.length) *
> 2;
> -		hfs_bnode_read(fd.bnode,
> -			&fd.search_key->cat.name.unicode,
> -			off + 2, len);
> -		fd.search_key->key_len =3D cpu_to_be16(6 + len);
> +		type =3D be16_to_cpu(entry.type);
> +		if (!is_hfs_thread_record_type(type)) {
> +			pr_err("found bad thread record in
> catalog\n");
> +			err =3D -EIO;
> +			goto out;
> +		}
> +
> +		hfsplus_cat_build_key_uni(fd.search_key, dir->i_ino,
> +					=C2=A0 &entry.thread.nodeName);
> =C2=A0	} else {
> =C2=A0		err =3D hfsplus_cat_build_key(sb, fd.search_key, dir-
> >i_ino, str);
> =C2=A0		if (unlikely(err))
> diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
> index ec04b82ad927..7c8667d5a49c 100644
> --- a/fs/hfsplus/hfsplus_fs.h
> +++ b/fs/hfsplus/hfsplus_fs.h
> @@ -521,6 +521,12 @@ static inline u32 hfsplus_cat_thread_size(const
> struct hfsplus_cat_thread *threa
> =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 be16_to_cpu(thread->nodeName.=
length) *
> sizeof(hfsplus_unichr);
> =C2=A0}
> =C2=A0
> +static inline
> +bool is_hfs_thread_record_type(u16 type)
> +{
> +	return type =3D=3D HFSPLUS_FOLDER_THREAD || type =3D=3D
> HFSPLUS_FILE_THREAD;
> +}
> +
> =C2=A0int hfsplus_brec_read_cat(struct hfs_find_data *fd,
> hfsplus_cat_entry *entry);
> =C2=A0
> =C2=A0/*

OK. Let's minimize the fix only by these modifications. The patch looks
good.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.
