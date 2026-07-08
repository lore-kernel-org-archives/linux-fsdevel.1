Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656B12FB969
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2026 18:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783534450; cv=none; b=J9Pk4JpddHYewjPhGwBWvV3MUbLD2TNFBgOPOuUvsFFsQJ75VEeYysKl4T6b4hhks2GyeApxetNyh8saYLP6inccTBxS7fS6KFm2ufDGe60dVp9+jVFQkR+o1U/gPdmezYvaWQXfuxTaZrfCL555GSLA7Nn5i/tSVnSl4rzUEj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783534450; c=relaxed/simple;
	bh=TBqvo6v5BsUcUO/iCavdx7UBwHoo5CajuSynZNc0cs4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NFrEcmrqUEbuCTFsmTG4OANsL+K5042yFQI5LiaAEw8BErhOCS7HuHKdaCLzIPvUfcMQ+2Vk7yMwCgXou/jtUPjypoW1YS5PBg2ES2aPaDf+CbxZLhiTeFfS51y8EAFtp3CvvGZvMS+BSKlfOTFVRIZ0ltwx3R3XAdRiLzqmiQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=UksV+tpY; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="UksV+tpY"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-667923d86a7so290759d50.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2026 11:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1783534446; x=1784139246; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8T5cKZQR90al6KODVZ7dG7uagMZK5DY2TvZenIzLFu8=;
        b=UksV+tpYf0rxN7yfNx+808VP+zHK2X9JQTKQi1qbqyfRHhFupzs6tr/Te1XkTafx51
         YMVpmI2Oi+/jVu538TQW00HrrvT/BOwdJkZBv6DixCG8//VVMKhueaXbWJOAodrj2cjS
         jrM+E9UUH2Cqh8hTiyzS15Fcs3QUUu6npTOMzYDrkqjSxyYdpG+dCHQc2rtrD3u0ngCa
         wmgvV1HCZarLEONwujT8zb/VFf8GDcyRW0xqhLP+hjDsK8lkDPGfFiHyMpEqANlNMXCy
         Th+EuCkZSBOFRNwqJRqSjdGot4cgKwGUqjuYDdZfIXlrpMWQKI+iqZyBJp+XhctqfuR6
         Zogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783534446; x=1784139246;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8T5cKZQR90al6KODVZ7dG7uagMZK5DY2TvZenIzLFu8=;
        b=DOzlX/LWiyScKaShbBqtbmT/Bhy4aXWOzy6uZk8FxxzHBGwrvnXgkKNAkaR3z1LFFm
         uj28qotirYO4xXzjJZqXBgaVDLwbQFbA/49WdvRjv+xM0ibneWUTZuz2+7U/WjcUDGg6
         3umplQlQQ3MyJW906BeyRUk+EbRmROSN3vVgxZdFgMnnN2Bqxq36TYQnJJodzaXZEYLb
         cbZKXrXyNUOYQMGnhYioZNNcnDgpeND2xYGPYabhrKtJlBmdwIISwR/23Ouisgt5MoKn
         Rtez2Um+UPc2ZJwoK0HWa39AQVH/gwM+R7zD/eQRFMBLsZxrf1j2QB4AFP27eE/vdqDK
         Kyuw==
X-Forwarded-Encrypted: i=1; AHgh+RoL4Bxoi1UfrZtJOwsa1NDmR4hli6bXBfnQUCC1jE02dI8W+mNMgzT0OTbVGK3atxGGyWDGcsHIR6m64J57@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8ut6p7NVotrjLp13WRWgNHBCNJ1TJA0PD6m/DbwdW+p/B9jAs
	ZbeIkR9i+iPHwT/9eRgKGvIlSilgNfetS6hA6SydD7aDnNtofmNTEAMTMv1M8DXdCNY=
X-Gm-Gg: AfdE7cnC/7iCdO8fgP1AIoD3B9CAeqa4CuHhpEjJSof5L9BMtcWgWxwYofWrDv+bU9G
	PWiDqIGUmBXjznHkOatPta71vxivjO8pz3Hjcz2iJYoRZJJMXMPPlIAq7qERncu697px72xDceL
	lGCSmDSihooKQeKGsCwwt5cnCicrb0RKYQd2xxPFmQ6vXn+V7EveOtmxHU9/SxP1jyWpi/gFZxq
	ytI2YQDMTW0iRLtIeJjMd4qNTbwNiqUOZOs12VUtShvg9fEKl6zX4u00X1yTxHlmH0GmnnTJxly
	AWzzGklZr+oI5ANrcfoPCrtDp61Z1nYAjFnPG7sH9mmAD11G2TVz8WiLOum6CMVqN3XmqmAu7hY
	Kmk5ciVXwG6UQXl4SuUF9dQwzg8sw9+zndE2tO21eo4RR+s7JPGB1BJcTIKRJtG3QLXR/UFvKTy
	P4uPSuYYhpdlAsnsG5Yrf0GyhD0Ynxx1J1xOG9a53i05UzL01JG4bNkkm9z/Q7iaobpkhALR4cp
	/5N35xPROEFGcgp/SICzNHpcVKf4TLD5O1tdu6xJq+H20wxe7WN9TM9zZQ4O64pArEfZgyBxIJy
	VT9PhW8=
X-Received: by 2002:a05:690e:4508:20b0:667:8b90:2ed2 with SMTP id 956f58d0204a3-6679e90f5f1mr2163623d50.46.1783534445606;
        Wed, 08 Jul 2026 11:14:05 -0700 (PDT)
Received: from [10.0.0.3] (162-197-212-70.lightspeed.sntcca.sbcglobal.net. [162.197.212.70])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66787a35d07sm2375548d50.15.2026.07.08.11.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 11:14:04 -0700 (PDT)
Message-ID: <e1dc4acaa001ad4fdf589bac3ccd2a937edc8f0c.camel@dubeyko.com>
Subject: Re: [PATCH v4] hfsplus: validate thread record before delete key
 rebuild
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Kyle Zeng <kylebot@openai.com>, linux-fsdevel@vger.kernel.org
Date: Wed, 08 Jul 2026 11:14:02 -0700
In-Reply-To: <20260707234130.23524-1-kylebot@openai.com>
References: <20260707234130.23524-1-kylebot@openai.com>
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

On Tue, 2026-07-07 at 16:41 -0700, Kyle Zeng wrote:
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
> record is a thread record, that the record size matches the thread
> name
> length, or that nodeName.length fits in the fixed HFS+ catalog key
> buffer.
>=20
> A corrupted image can therefore provide an oversized thread name
> length
> and make hfs_bnode_read() write past the catalog search-key
> allocation.
>=20
> Read the CNID record through hfsplus_brec_read_cat(), which performs
> the
> hfs_brec_find() lookup via hfs_brec_read() before validating the
> catalog
> record. Reject non-thread records before building the delete key from
> the validated thread name.
>=20
> Make hfsplus_brec_read_cat() validate that a thread nodeName length
> both
> fits HFSPLUS_MAX_STRLEN and exactly matches fd->entrylength, then
> share
> the HFS+ thread-record-type helper between hfsplus_find_cat() and
> hfsplus_delete_cat().
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Assisted-by: Codex:gpt-5.5
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> ---
> =C2=A0fs/hfsplus/bfind.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 8 ++++++--
> =C2=A0fs/hfsplus/catalog.c=C2=A0=C2=A0=C2=A0 | 30 ++++++++++++-----------=
-------
> =C2=A0fs/hfsplus/hfsplus_fs.h | 12 ++++++++++++
> =C2=A03 files changed, 30 insertions(+), 20 deletions(-)
>=20
> diff --git a/fs/hfsplus/bfind.c b/fs/hfsplus/bfind.c
> index 9a55fa6d5294..d5e41e1c70b3 100644
> --- a/fs/hfsplus/bfind.c
> +++ b/fs/hfsplus/bfind.c
> @@ -322,8 +322,12 @@ int hfsplus_brec_read_cat(struct hfs_find_data
> *fd, hfsplus_cat_entry *entry)
> =C2=A0			pr_err("thread record too short (got %u)\n",
> fd->entrylength);
> =C2=A0			return -EIO;
> =C2=A0		}
> -		expected_size =3D hfsplus_cat_thread_size(&entry-
> >thread);
> -		break;
> +		if (!is_hfsplus_cat_thread_name_length_valid(&entry-
> >thread,
> +							=C2=A0=C2=A0=C2=A0=C2=A0 fd-
> >entrylength)) {
> +			pr_err("catalog thread name length
> corrupted\n");
> +			return -EIO;
> +		}
> +		return 0;

Do we really need to change this function at all? Because, current
check already works pretty well. This check covers everything already:


	if (fd->entrylength !=3D expected_size) {
		pr_err("catalog record size mismatch (type %d, got %u,
expected %u)\n",
		       be16_to_cpu(entry->type), fd->entrylength,
expected_size);
		return -EIO;
	}

> =C2=A0	default:
> =C2=A0		pr_err("unknown catalog record type %d\n",
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 be16_to_cpu(entry->type));
> diff --git a/fs/hfsplus/catalog.c b/fs/hfsplus/catalog.c
> index 776ce36cf076..1a4b0beae135 100644
> --- a/fs/hfsplus/catalog.c
> +++ b/fs/hfsplus/catalog.c
> @@ -204,16 +204,11 @@ int hfsplus_find_cat(struct super_block *sb,
> u32 cnid,
> =C2=A0		return err;
> =C2=A0
> =C2=A0	type =3D be16_to_cpu(tmp.type);
> -	if (type !=3D HFSPLUS_FOLDER_THREAD && type !=3D
> HFSPLUS_FILE_THREAD) {
> +	if (!is_hfs_thread_record_type(type)) {
> =C2=A0		pr_err("found bad thread record in catalog\n");
> =C2=A0		return -EIO;
> =C2=A0	}
> =C2=A0
> -	if (be16_to_cpu(tmp.thread.nodeName.length) > 255) {
> -		pr_err("catalog name length corrupted\n");
> -		return -EIO;
> -	}

If hfsplus_brec_read_cat() covers this check already, then, probably,
we don't need in new function and we don't need this check. If we still
need to keep this check, then we cannot simply remove it but we need to
call the is_cat_thread_name_length_valid() here. So, do we really need
to introduce the is_cat_thread_name_length_valid() finally?

> -
> =C2=A0	hfsplus_cat_build_key_uni(fd->search_key,
> =C2=A0		be32_to_cpu(tmp.thread.parentID),
> =C2=A0		&tmp.thread.nodeName);
> @@ -350,23 +345,22 @@ int hfsplus_delete_cat(u32 cnid, struct inode
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
> index ec04b82ad927..01e5f1246ff6 100644
> --- a/fs/hfsplus/hfsplus_fs.h
> +++ b/fs/hfsplus/hfsplus_fs.h
> @@ -521,6 +521,18 @@ static inline u32 hfsplus_cat_thread_size(const
> struct hfsplus_cat_thread *threa
> =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 be16_to_cpu(thread->nodeName.=
length) *
> sizeof(hfsplus_unichr);
> =C2=A0}
> =C2=A0
> +static inline bool is_hfs_thread_record_type(u16 type)
> +{
> +	return type =3D=3D HFSPLUS_FOLDER_THREAD || type =3D=3D
> HFSPLUS_FILE_THREAD;
> +}
> +
> +static inline bool is_hfsplus_cat_thread_name_length_valid(
> +		const struct hfsplus_cat_thread *thread, u32
> entrylength)

I don't like this style. :) Potentially, we can rework it:

static inline
bool is_cat_thread_name_length_valid(struct hfsplus_cat_thread *thread,
                                     u32 entrylength);

Technically speaking, it will be better to provide struct hfs_find_data
*fd and hfsplus_cat_entry *entry here.


> +{
> +	return be16_to_cpu(thread->nodeName.length) <=3D
> HFSPLUS_MAX_STRLEN

Do we need to have this check now? I assume that the second check could
cover everything. What do you think?

Thanks,
Slava.

> &&
> +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 entrylength =3D=3D hfsplus_cat_thr=
ead_size(thread);
> +}
> +
> =C2=A0int hfsplus_brec_read_cat(struct hfs_find_data *fd,
> hfsplus_cat_entry *entry);
> =C2=A0
> =C2=A0/*
