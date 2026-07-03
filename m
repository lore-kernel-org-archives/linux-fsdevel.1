Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1DF5695
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Jul 2026 00:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783037631; cv=none; b=iKpMth3f/XC3Geg2Pg+YX2WnGIhc69o4yF7I6vW6mL8Rtt3fF7NIOrlSGZXzUYYFGL2opLSfuEF1eDgLneCr0g3S0fYNY9saH3wToTEhWLOo0tTJxYlHydoehp4AygjZLzaW9+I3qcQJPodLvcORjy4KrwjxVtsO31j43kOzHvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783037631; c=relaxed/simple;
	bh=MFlICDdjKMlrTRd+LDm6xGWzNWWKHBuk/qo2GaZbf8o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EmPEjh7tcbwRm/kGTBtmsqiG7jo8Q5FAmlp67QXt8j0d97rlnSDWAhSzLdREHON92LMm9WkdCJBhpi2coDpUxF1yWxH7R9O4z1Strl8mZJrF60klW3Bl0rrrsM3uk4sKiDqvv33o4h8AtaLy/Ixlxq38cXQRzhMmISmYDf0qOpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=WGkCVU8q; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="WGkCVU8q"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-664ee752958so16601d50.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jul 2026 17:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1783037628; x=1783642428; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OMUxtFi3YZrN3X428OMk0XzpPc4JrqMm7GhCL3V50YQ=;
        b=WGkCVU8qr+b9KnERC38oOLJ44kZR/0WQj/i5pM4OHYVArqQZwqtl1ixmXg9p82u+I8
         AL3h36f3u8g67LSv1sPNREf7uFxZTY8I92VkkgwHoRkcq2l4mSF2Q1flMNF2qna8Lnme
         CVfEOnx53QYw4bunqQrkVHWypdhIpAJhtXEJyUZnbLA/svb8BSEinBVFYb5MHi6KU/Wv
         ebouO1GcTXrR+Uw6NJzWcxW9g6gGA2XoHAyCRem9eSEMDJHXX4zZrCyn3yVuUKJ0nS7Q
         Ch8UikiG8qcmXZoit8Ap/yV0Iy9Y1vaPj/XmnSIcMTBd+oKJMyUIHtbBOKAFwdolUfcT
         Pn5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783037628; x=1783642428;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OMUxtFi3YZrN3X428OMk0XzpPc4JrqMm7GhCL3V50YQ=;
        b=o0m65Fp/pCG08MJydN/bD7n4TBNQiPhI5ksvFC33UTklgE2Gd3RFuaOCetwMNx3BmU
         9MyF6igFzN0Tbh1YbMbBxJ7DKcfpnucaJsUJo1gQnb0DMH1O0X4XNAlgBTgz4W2pWMYW
         qmrRV/MCx4py6zD4h+SzEAPgEZ3wSb8+AhN+e5O73hXrupk5UvQ2ussNa3ae4BCJ8fHK
         1hd+isS5rjNkN+rnrgiqCVh8bCJNEpE8egMHpBut3dQWBXZRaRMQ9Y9rZZiOIuX5klHr
         U5uoUZj6fB4hIzYKL44KxkJQzTRUm2WI/nkhCpwDzqGZFAn3JRkZvm9dg9izT9d16cBB
         WzHg==
X-Forwarded-Encrypted: i=1; AHgh+RroSSZ0d0mpyJtyFe8s0SwvCV4A0wlP23Oo61QRfVHeF+zzLN32zF3MS+FL6tT52YCARsALgt+RdKOq7sCU@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0SBnF2ki83XEWebnw910K3tCqWRLzKpx7ni0XopB9FLZ+Ef/r
	YFJzPc1sRnsDy8XyflBYBZBb3tpBqhbgc62GxaP8RDVHYNYZdK34dgJr9hSXdQ7r8Alwi57Ep9g
	QwPB7AXKlXQ==
X-Gm-Gg: AfdE7cklFOalnGnglkF4cmBsAXWzho5fmmglJuJhLbjfYREPcsD1a1UcIc29aMp51Cm
	8jCTiXcw4lnJ8+JkfmldlFBofqRYnQsfJwISTZlDBqLt8OohLfC8pDhuP66DI1bapBgVes6hUtl
	2GvfWSKdRmmw9K9gICkICMRLWAurY7ZbrSfl+d0mjm6jgnZBOpiZqjNJTZhoj/djvJW4PRFuTZ1
	dYsQiQnhS1e3/02lQX0SZ/1slApPsbxZg2SJ8+jZtEaW9zIrdtSAr905cc/Dpi86YpB2wDxf9Iq
	uQLJkSAbDSSWZ9ZTAQqz6phh+4M1D9HKKHjhSA/QMfKzGJDx0q8oNIleE2TBhhkEHabdQbDDsCT
	7Y31cn58sI0s6hS7NPE+M7D0ke0o/+RBeqJHsmvLPFM6yDqyQEbbOJy1Ngfi8+7w/llWzAltGdy
	pF9xZXK3cn6uBPe+kHOQxPE8LQvrBhPjbGXso6T/r2+kCSfe3sflZxONvWQo0ebUPx1n0iJ/04d
	+NfibR9MlRys0PmX5VdGUDp6awopaCxS+GmUsVUmR5PIWMiJBknAwtynnaL8jwy8oWiCVYRggRg
	kpvg88oFJtPQR1mIhg==
X-Received: by 2002:a05:690e:1381:b0:664:e4b2:4e73 with SMTP id 956f58d0204a3-66521a4467amr6975006d50.30.1783037628345;
        Thu, 02 Jul 2026 17:13:48 -0700 (PDT)
Received: from [10.0.0.3] (162-197-212-70.lightspeed.sntcca.sbcglobal.net. [162.197.212.70])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-666407cd44bsm38981d50.12.2026.07.02.17.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 17:13:47 -0700 (PDT)
Message-ID: <deaf9198e4e937310f92001628e48bb9d8b88844.camel@dubeyko.com>
Subject: Re: [PATCH v2] hfsplus: validate thread record before delete key
 rebuild
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Kyle Zeng <kylebot@openai.com>, linux-fsdevel@vger.kernel.org
Cc: outbounddisclosures@openai.com
Date: Thu, 02 Jul 2026 17:13:45 -0700
In-Reply-To: <20260701063519.9447-1-kylebot@openai.com>
References: <20260701063519.9447-1-kylebot@openai.com>
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

On Wed, 2026-07-01 at 00:35 -0600, Kyle Zeng wrote:
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
> record. Reject non-thread records and explicitly bound
> nodeName.length
> before building the delete key from the validated thread name.
>=20
> Factor the existing thread-type and name-length checks into shared
> helpers so hfsplus_find_cat() and hfsplus_delete_cat() use the same
> validation.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Assisted-by: Codex:gpt-5.5
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> ---
> =C2=A0fs/hfsplus/catalog.c=C2=A0=C2=A0=C2=A0 | 38 ++++++++++++++++++++++-=
---------------
> =C2=A0fs/hfsplus/hfsplus_fs.h | 11 +++++++++++
> =C2=A02 files changed, 33 insertions(+), 16 deletions(-)
>=20
> diff --git a/fs/hfsplus/catalog.c b/fs/hfsplus/catalog.c
> index 776ce36cf076..c57c3bbb8143 100644
> --- a/fs/hfsplus/catalog.c
> +++ b/fs/hfsplus/catalog.c
> @@ -196,20 +196,20 @@ int hfsplus_find_cat(struct super_block *sb,
> u32 cnid,
> =C2=A0{
> =C2=A0	hfsplus_cat_entry tmp =3D {0};
> =C2=A0	int err;
> -	u16 type;
> +	u16 entry_type;

I think that this change is not good. The name type is good enough and
it is shorter one. It is not critical remark but this change doesn't
make sense to me.

> =C2=A0
> =C2=A0	hfsplus_cat_build_key_with_cnid(sb, fd->search_key, cnid);
> =C2=A0	err =3D hfsplus_brec_read_cat(fd, &tmp);
> =C2=A0	if (err)
> =C2=A0		return err;
> =C2=A0
> -	type =3D be16_to_cpu(tmp.type);
> -	if (type !=3D HFSPLUS_FOLDER_THREAD && type !=3D
> HFSPLUS_FILE_THREAD) {
> +	entry_type =3D be16_to_cpu(tmp.type);
> +	if (!is_hfsplus_thread_type(entry_type)) {
> =C2=A0		pr_err("found bad thread record in catalog\n");
> =C2=A0		return -EIO;
> =C2=A0	}
> =C2=A0
> -	if (be16_to_cpu(tmp.thread.nodeName.length) > 255) {
> +	if
> (!is_hfsplus_name_length_valid(tmp.thread.nodeName.length)) {
> =C2=A0		pr_err("catalog name length corrupted\n");
> =C2=A0		return -EIO;
> =C2=A0	}
> @@ -350,23 +350,29 @@ int hfsplus_delete_cat(u32 cnid, struct inode
> *dir, const struct qstr *str)
> =C2=A0		goto out;
> =C2=A0
> =C2=A0	if (!str) {
> -		int len;
> +		hfsplus_cat_entry entry =3D {0};
> +		u16 entry_type;
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
> +		entry_type =3D be16_to_cpu(entry.type);
> +		if (!is_hfsplus_thread_type(entry_type)) {
> +			pr_err("found bad thread record in
> catalog\n");
> +			err =3D -EIO;
> +			goto out;
> +		}
> +
> +		if
> (!is_hfsplus_name_length_valid(entry.thread.nodeName.length)) {
> +			pr_err("catalog name length corrupted\n");
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
> index ec04b82ad927..b954b45a1003 100644
> --- a/fs/hfsplus/hfsplus_fs.h
> +++ b/fs/hfsplus/hfsplus_fs.h
> @@ -521,6 +521,17 @@ static inline u32 hfsplus_cat_thread_size(const
> struct hfsplus_cat_thread *threa
> =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 be16_to_cpu(thread->nodeName.=
length) *
> sizeof(hfsplus_unichr);
> =C2=A0}
> =C2=A0
> +static inline bool is_hfsplus_thread_type(u16 entry_type)
> +{
> +	return entry_type =3D=3D HFSPLUS_FOLDER_THREAD ||
> +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 entry_type =3D=3D HFSPLUS_FILE_THR=
EAD;
> +}
> +
> +static inline bool is_hfsplus_name_length_valid(__be16 name_length)
> +{
> +	return be16_to_cpu(name_length) <=3D HFSPLUS_MAX_STRLEN;
> +}
> +
> =C2=A0int hfsplus_brec_read_cat(struct hfs_find_data *fd,
> hfsplus_cat_entry *entry);
> =C2=A0
> =C2=A0/*

Mostly, patch looks good. Let me run xfstests for the patch. I'll share
my final review ASAP.

Thanks,
Slava.
