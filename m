Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFC12F6596
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Jul 2026 19:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783105698; cv=none; b=qUQSkISZt8FoHn15H3xHuOUb1YZUMaAPASKDqPL9OoNn2leJPtjpQYJhFiXVWQVXvDIiHk3TAGjOibaicCw+rhnOE1+kH/1LU54BDB4QmoigniFER+te0+d8dFJHSAmHYLZYCPKQqIWevVaR+n0IRkR1pB3xpDu2w28q/TItzTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783105698; c=relaxed/simple;
	bh=e5BqYn9wHF2Ld/RRtFFEJL7hi18fIddMxA6pOUJx4iU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NEl///zgppSo1jdy28qvBP3Km7srDgSSoBlLECqzC7fN+G8o/lv8VSXFF9Gtlm7/evSLULdpYrLGwdXcSPN5WWFGyrxRcMt//vl5ASt+XOdH9sRjNSW31A4GXxabizr/07SAigqZcCwM7M0Ku6oRKhDvLhZmj0OMBmr/6eXmfII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=bVZAwTUx; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="bVZAwTUx"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-664db84f074so997613d50.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Jul 2026 12:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1783105695; x=1783710495; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N0meiPLPJp8cTrqmLd8F8mhyoylaiQ+uixkllcFYx4k=;
        b=bVZAwTUxCRANVc1P4Bf3WBgokMTMwwj4OZmtXk1mFBIlbDhtfDD84ymfm5FL68nFuu
         WpXEX2AGy0AXXqSUp5AgEcx1o5TZAU9DySCVWdnKToOJpsXEgrDJKjUWvQTc89G0RNbO
         MSu5oH+/EkGAdXQbpPDuLGd6VtSYHSOerwvwhw11A90ouJdrRac27NneXLaWMOwdRFwn
         M/JVmuZj+90Fat/KbQ+fyb5AW0mNBilAjfxD9ueWN1wZZRLUMH+5nT1w8naqRlJFY0or
         ry5DgiJVJz24nJlRlLfG9V3/N47O7adupMFcsAdtrAuU6SpaDyXq8x4g49tl71wxpfji
         vI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783105695; x=1783710495;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N0meiPLPJp8cTrqmLd8F8mhyoylaiQ+uixkllcFYx4k=;
        b=cKUuZQZg8rdaLsxYzl+uNaRVHA5Pt0g97EIIDH1RoJqRiCsHTAi5wYpzvbhM6UwQ2G
         Dp5XtoRT0+O8hbdBLG1jPbus+X8zUYac6S+pTv3dn7dhlvFG+tsdoWZ56ZLWlFFm54xh
         rvWE52Gb0mr64AE773u6pN7NU0aIlmyiZ0/M+/+E6JmnKfaaTMoj2gk/jhbnlROQyTQl
         90Bn0YsuFMETTVtMQUT4zysohUis92dOhkrPNYS2umZc7IBqN2TGbPpJl9yMYZWpAdsD
         ziejSTfWRmbUIMkXwMUzJeqGAoEV8oLAY2ox80U4axx06Jtsgm/ynQ3G+Z2a1Sx6d/Zj
         92fw==
X-Forwarded-Encrypted: i=1; AHgh+RrWwK8xMhZYkBPixIOt5o2zOOvubnLNegwkaj0v9XqVh6rE227Y7NMtBuQTSyqp5B3qJX4SOLkYz+ZyV6k4@vger.kernel.org
X-Gm-Message-State: AOJu0YwjwDlZklWGQh57SLqU7v9mW3+1jNu5CSouu1iy7/obS25c4WoW
	2BccEVoYui+sqkwHi2NRhrih2sFNH+fy9li/m7vuIJKBpOV3Fq9Gwm3jX3Vlzsd+7FS6cTy8TOB
	ZO93CbQS/YA==
X-Gm-Gg: AfdE7clpFtptxVuxRvJaWY9hX/qym+U/BYC6VJODy5aAhQIH+so3jkJEhh9x3BYKjWK
	S43nmGTDS7HOxLrikMq/eDyJK4ZcmTbCtrkEu1uySZJFsxvyzFsTxAEe33ztcOVoRgoRfMfAzxw
	m796oedoZ4Ua40qpEqtd5zZsxiZxFPIyPu8W1LGu1YlMH4qpr6tTWzcMUI/LdC6qavrv9sCgNoo
	QrxBB7ofNAhhQg4J80BuCNTf8azriEoF0xfd3iISnZcfraRMGr8vNXQc3g61Qh0vMKYHbUJe23+
	LLvNL7X/DMcHk9/9v2N8q4eEwp7evxO6jaxG5V3BtPPzh6sWDgbbnhbkRMX9ZezP8kLo0qXZ1R7
	L7eUsdlEKjt36cr7+PSCZngbCpiGgNQewOrXAXvYgXsycuIFl4qwH2DdEiXWXrSfv0jFdXZQ37s
	zPFLHuxwuyq/wG5XDEBYNQE/fzZ0QfHrEHby7W7i+g8h71Tq005mVkc5bNmoSZ6uz30VE8qEtVX
	It07rMuKoigRoorSvccX2kCsiV2mmwzYfGC/mjRrIzDvUwjISoBNKc9M+kHxl65UmfUo0I4hkz2
	bh14R0fgTjYwoGPZ
X-Received: by 2002:a05:690e:14c6:b0:663:593b:e30d with SMTP id 956f58d0204a3-66652e8999cmr315259d50.34.1783105695301;
        Fri, 03 Jul 2026 12:08:15 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:682a:9cbb:a4fb:99f8? ([2600:1700:6476:1430:682a:9cbb:a4fb:99f8])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-666405289f2sm1159596d50.7.2026.07.03.12.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 12:08:14 -0700 (PDT)
Message-ID: <466d084104280fd5feced09a54662a30e4b9b739.camel@dubeyko.com>
Subject: Re: [PATCH v2] hfsplus: validate thread record before delete key
 rebuild
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Kyle Zeng <kylebot@openai.com>, linux-fsdevel@vger.kernel.org
Cc: outbounddisclosures@openai.com
Date: Fri, 03 Jul 2026 12:08:13 -0700
In-Reply-To: <deaf9198e4e937310f92001628e48bb9d8b88844.camel@dubeyko.com>
References: <20260701063519.9447-1-kylebot@openai.com>
	 <deaf9198e4e937310f92001628e48bb9d8b88844.camel@dubeyko.com>
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

Hi Kyle,

The xfestests haven't revealed any new issues. So, patch looks good
but, please, check my remarks below. I see some logical issues in the
patch that needs to be reworked from my point of view.

On Thu, 2026-07-02 at 17:13 -0700, Viacheslav Dubeyko wrote:
> On Wed, 2026-07-01 at 00:35 -0600, Kyle Zeng wrote:
> > hfsplus_delete_cat() is called with str =3D=3D NULL when the last open
> > reference to an unlinked HFS+ hardlink backing inode is closed. In
> > that
> > case, the function finds the catalog thread by CNID and rebuilds
> > the
> > catalog key from thread.nodeName.
> >=20
> > That reconstruction path reads thread.nodeName.length directly from
> > the
> > catalog B-tree into fd.search_key and then copies length * 2 bytes
> > into
> > fd.search_key->cat.name.unicode. It does not first check that the
> > found
> > record is a thread record, that the record size matches the thread
> > name
> > length, or that nodeName.length fits in the fixed HFS+ catalog key
> > buffer.
> >=20
> > A corrupted image can therefore provide an oversized thread name
> > length
> > and make hfs_bnode_read() write past the catalog search-key
> > allocation.
> >=20
> > Read the CNID record through hfsplus_brec_read_cat(), which
> > performs
> > the
> > hfs_brec_find() lookup via hfs_brec_read() before validating the
> > catalog
> > record. Reject non-thread records and explicitly bound
> > nodeName.length
> > before building the delete key from the validated thread name.
> >=20
> > Factor the existing thread-type and name-length checks into shared
> > helpers so hfsplus_find_cat() and hfsplus_delete_cat() use the same
> > validation.
> >=20
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Assisted-by: Codex:gpt-5.5
> > Signed-off-by: Kyle Zeng <kylebot@openai.com>
> > ---
> > =C2=A0fs/hfsplus/catalog.c=C2=A0=C2=A0=C2=A0 | 38 +++++++++++++++++++++=
+---------------
> > -
> > =C2=A0fs/hfsplus/hfsplus_fs.h | 11 +++++++++++
> > =C2=A02 files changed, 33 insertions(+), 16 deletions(-)
> >=20
> > diff --git a/fs/hfsplus/catalog.c b/fs/hfsplus/catalog.c
> > index 776ce36cf076..c57c3bbb8143 100644
> > --- a/fs/hfsplus/catalog.c
> > +++ b/fs/hfsplus/catalog.c
> > @@ -196,20 +196,20 @@ int hfsplus_find_cat(struct super_block *sb,
> > u32 cnid,
> > =C2=A0{
> > =C2=A0	hfsplus_cat_entry tmp =3D {0};
> > =C2=A0	int err;
> > -	u16 type;
> > +	u16 entry_type;
>=20
> I think that this change is not good. The name type is good enough
> and
> it is shorter one. It is not critical remark but this change doesn't
> make sense to me.
>=20
> > =C2=A0
> > =C2=A0	hfsplus_cat_build_key_with_cnid(sb, fd->search_key, cnid);
> > =C2=A0	err =3D hfsplus_brec_read_cat(fd, &tmp);
> > =C2=A0	if (err)
> > =C2=A0		return err;
> > =C2=A0
> > -	type =3D be16_to_cpu(tmp.type);
> > -	if (type !=3D HFSPLUS_FOLDER_THREAD && type !=3D
> > HFSPLUS_FILE_THREAD) {
> > +	entry_type =3D be16_to_cpu(tmp.type);
> > +	if (!is_hfsplus_thread_type(entry_type)) {
> > =C2=A0		pr_err("found bad thread record in catalog\n");
> > =C2=A0		return -EIO;
> > =C2=A0	}
> > =C2=A0
> > -	if (be16_to_cpu(tmp.thread.nodeName.length) > 255) {
> > +	if
> > (!is_hfsplus_name_length_valid(tmp.thread.nodeName.length)) {
> > =C2=A0		pr_err("catalog name length corrupted\n");
> > =C2=A0		return -EIO;
> > =C2=A0	}
> > @@ -350,23 +350,29 @@ int hfsplus_delete_cat(u32 cnid, struct inode
> > *dir, const struct qstr *str)
> > =C2=A0		goto out;
> > =C2=A0
> > =C2=A0	if (!str) {
> > -		int len;
> > +		hfsplus_cat_entry entry =3D {0};
> > +		u16 entry_type;
> > =C2=A0
> > =C2=A0		hfsplus_cat_build_key_with_cnid(sb, fd.search_key,
> > cnid);
> > -		err =3D hfs_brec_find(&fd, hfs_find_rec_by_key);
> > +		err =3D hfsplus_brec_read_cat(&fd, &entry);
> > =C2=A0		if (err)
> > =C2=A0			goto out;
> > =C2=A0
> > -		off =3D fd.entryoffset +
> > -			offsetof(struct hfsplus_cat_thread,
> > nodeName);
> > -		fd.search_key->cat.parent =3D cpu_to_be32(dir-
> > >i_ino);
> > -		hfs_bnode_read(fd.bnode,
> > -			&fd.search_key->cat.name.length, off, 2);
> > -		len =3D be16_to_cpu(fd.search_key->cat.name.length)
> > *
> > 2;
> > -		hfs_bnode_read(fd.bnode,
> > -			&fd.search_key->cat.name.unicode,
> > -			off + 2, len);
> > -		fd.search_key->key_len =3D cpu_to_be16(6 + len);
> > +		entry_type =3D be16_to_cpu(entry.type);
> > +		if (!is_hfsplus_thread_type(entry_type)) {
> > +			pr_err("found bad thread record in
> > catalog\n");
> > +			err =3D -EIO;
> > +			goto out;
> > +		}
> > +
> > +		if
> > (!is_hfsplus_name_length_valid(entry.thread.nodeName.length)) {
> > +			pr_err("catalog name length corrupted\n");
> > +			err =3D -EIO;
> > +			goto out;
> > +		}
> > +
> > +		hfsplus_cat_build_key_uni(fd.search_key, dir-
> > >i_ino,
> > +					=C2=A0 &entry.thread.nodeName);
> > =C2=A0	} else {
> > =C2=A0		err =3D hfsplus_cat_build_key(sb, fd.search_key,
> > dir-
> > > i_ino, str);
> > =C2=A0		if (unlikely(err))
> > diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
> > index ec04b82ad927..b954b45a1003 100644
> > --- a/fs/hfsplus/hfsplus_fs.h
> > +++ b/fs/hfsplus/hfsplus_fs.h
> > @@ -521,6 +521,17 @@ static inline u32
> > hfsplus_cat_thread_size(const
> > struct hfsplus_cat_thread *threa
> > =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 be16_to_cpu(thread->nodeNam=
e.length) *
> > sizeof(hfsplus_unichr);
> > =C2=A0}
> > =C2=A0
> > +static inline bool is_hfsplus_thread_type(u16 entry_type)

First of all, HFS and HFS+ both use the thread records. Also,
is_hfsplus_thread_type() sounds slightly confusing. So, I suggest to
use is_hfs_thread_record_type() name. First of all, we are checking the
thread record type. And, secondly, we can re-use this function in the
future. The difference is that HFS uses HFS_CDR_THD/HFS_CDR_FTH
constants for thread records.

> > +{
> > +	return entry_type =3D=3D HFSPLUS_FOLDER_THREAD ||
> > +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 entry_type =3D=3D HFSPLUS_FILE_T=
HREAD;
> > +}
> > +
> > +static inline bool is_hfsplus_name_length_valid(__be16
> > name_length)
> > +{
> > +	return be16_to_cpu(name_length) <=3D HFSPLUS_MAX_STRLEN;

After some consideration, I cannot accept
is_hfsplus_name_length_valid() as a completely correct check. Because,
even if name_length is smaller than HFSPLUS_MAX_STRLEN, then it doesn't
mean that we haven't a record corruption. Because, the name_length can
be smaller one that HFSPLUS_MAX_STRLEN but still bigger one that the
real length of the name or the length of record itself. Also, xattr
name cannot be bigger than HFSPLUS_ATTR_MAX_STRLEN (127) but it still
HFS+ name. So, I think we need to rework the logic of this function to
check the name length more carefully. And I believe that function name
needs to be reworked too slightly.

Thanks,
Slava.

> > +}
> > +
> > =C2=A0int hfsplus_brec_read_cat(struct hfs_find_data *fd,
> > hfsplus_cat_entry *entry);
> > =C2=A0
> > =C2=A0/*
>=20
>=20
