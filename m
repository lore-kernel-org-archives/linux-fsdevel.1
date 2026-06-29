Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFF23CB8FC
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jun 2026 23:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782777516; cv=none; b=NRImkzGKvnTfuJyl9rtCHqIRG9bzH3Od1IOkIakRrm9fQUL99oH+y6CXxR7Ekyuliib80VyYIQDDjDSDHBl/O9/nARJOpi90XjYAAOja+x8u88pF0pR0rF3ZI7IpiIZ5flHx+dRZTUwizffnPYnFICtjjWjU6WwZoCQ6GSyglw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782777516; c=relaxed/simple;
	bh=RJ10EYVoQjrjNaN0ou7m2OrddTdbB1F+G5+kBFTtodU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lHg6wlh4LYxOmYUwLvxXtTECDXWPvxH9FceFIgF/6zbn2czV/plIzsSZpdecc2ftNAun31y+eEnIXFtWdLb/Czhh/g49gbMwi8BVHDycd80b7Jj2jbgQ787T2a4rvuSxiNvgogltzk9kZxLSvoEqKd9fzflWwVY1c/5heijqjwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=u9+3kweS; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="u9+3kweS"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-664ae993e4bso82795d50.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jun 2026 16:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1782777513; x=1783382313; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8aTeMgGKdHGkFvxYNdIbmDaIRyrOybPqt7hogGrhopQ=;
        b=u9+3kweSltCxj49VW9HvYoUTrzNaK/zYPS1VNa4bNickzjzTNheMgtUnkDEZDapFNR
         MTnkRKa0C99ZYN64fPkvIH6dIU18GamnuyVm6pBYUX0K4+jEgj0dg0ewMzJ2vFSQyC6F
         RZXeSwZKphRQALA6AUE/9bagqF/7Akb1BE+zWcKMOxoN3UVDz0uVeOc9+7qPVSFtrYKo
         THtk+ZWv099AQPu1CpM0UWNXmGW9a5ltRBsvf7fwYM1KAO93vJsR8uOxmXO2X32ydQfK
         n5UwAUUVlaLbgZU0kMUiXtg+fRxmowYrRKafI0nqB1wsmzkTySNtYjt0bTxkgwHs0rmg
         xRAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782777513; x=1783382313;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8aTeMgGKdHGkFvxYNdIbmDaIRyrOybPqt7hogGrhopQ=;
        b=Iz//Pw1P4QhttN5Ze3y79AlW63SrVqpuMKqzJqjU/3TYohib4txkhiIBwJmgHE3LJf
         uS42e4wbNy8r2pQ2+cQc+NmMdiYsJ9gZZPd54/ZzUa73NnWyWhhLkYuNQKlizWT+JCto
         rYPEv4abEveahuKkQOJaocwerG30Z/0p2VIr5drukLg6ETAKtpPE3rtKdJdvqVx6PiNq
         jfFqTa3jYRJI2VVePLNfHvWuFrV6Fhp3Q10qAj1CWiW7Eu6YyKdvjvWni3+LgoMvaopF
         3FRTOPB9YN+hikjeCqMlJf0P1H6Z7FNGKtQzGeFOI/gfIzSc0hvbDDIefdS+JxfxtzxP
         gNKA==
X-Forwarded-Encrypted: i=1; AHgh+Rrk6RY4bu7//lleEIZaUyx6c/4czXGf0Moogo61QJvQ0mYufer6inch6IpaktxWze3ap5StwrSDd3N79Uim@vger.kernel.org
X-Gm-Message-State: AOJu0YzcWsqhoEWgHGx4dcG8D6dMEn56kyZwGsEyv1+FnakZGRpovA9D
	FSAQUFHFWMk/LIhMbKZVY0BEubreQEaC+ud0+x97gSuF2LsNh0x/WDNAjs83EjArY2Tg0PuhGDE
	9W2+fdT1e6A==
X-Gm-Gg: AfdE7ckfF1gjCNOKED8NyuJx1nVNVwsIylnJmvepub8pHUKooUhE71VuEEQwmQG4hp1
	qLn4ypixCnmqUyJdTWPgnTheFxBHLtICy67AikZk00OgEOUoAiMTurFWLBRxk7IFbcV/Fk1e74w
	zcin/34P2eGXV1aMtngP3a4jAsSZv/o+cZJMrEKFe2udf32oxUSbp3bjmxVljc/VEC+Jzi7vFj6
	TwA2SUpQ8DAUmdz3OI93920MhQl6c3C1zWAPnuy5S/orXTdkRLOgGmfO8fG5ZEh9vU9n0PLFVH2
	GodgFYHlTeRAG7QOhaCqncF8EVzx6Om1Ogct9zB8KKv5l9oLWWVNjhuyrnCDRGtFsp9cho8eGcM
	6NBhYFp3UalATju69kVo7FaEpqCQZqZOuVNuO+i6jF5ErhYoEgoVW5Mk5iucIc8ChdGT0Kze0hc
	3mq4CdhE7bevp5M8zWo2F88xJV9m5HUH2PGyvXIhI2/89FDKKTSOkHOIp6TLmIigbCSo5Rfu6Aw
	YJj8nc4EMGyiOwBg2x4R6HHIg1uOhpuF9js1N68EycMQkEnYUAslgtf5q8rHeVjxx7FYTzGe3J0
	h7gtFQ==
X-Received: by 2002:a05:690e:4847:b0:664:c706:2c15 with SMTP id 956f58d0204a3-664fb913e30mr882199d50.7.1782777513445;
        Mon, 29 Jun 2026 16:58:33 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:620b:6926:2bec:7db3? ([2600:1700:6476:1430:620b:6926:2bec:7db3])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66500545288sm201375d50.4.2026.06.29.16.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 16:58:33 -0700 (PDT)
Message-ID: <81f584b44a5639237531f39078856da96eb61ea4.camel@dubeyko.com>
Subject: Re: [PATCH] hfsplus: validate thread record before delete key
 rebuild
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Kyle Zeng <kylebot@openai.com>, linux-fsdevel@vger.kernel.org
Cc: Yangtao Li <frank.li@vivo.com>, John Paul Adrian Glaubitz
	 <glaubitz@physik.fu-berlin.de>, outbounddisclosures@openai.com
Date: Mon, 29 Jun 2026 16:58:31 -0700
In-Reply-To: <20260611212633.5058-1-kylebot@openai.com>
References: <20260611212633.5058-1-kylebot@openai.com>
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

On Thu, 2026-06-11 at 14:26 -0700, Kyle Zeng wrote:
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
> length, or that the name length fits in the fixed HFS+ catalog key
> buffer.
>=20
> A corrupted image can therefore provide an oversized thread name
> length
> and make hfs_bnode_read() write past the catalog search-key
> allocation.
>=20
> Read the CNID record through hfsplus_brec_read_cat(), reject non-
> thread
> records, and explicitly bound nodeName.length before building the
> delete
> key from the validated thread name.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Assisted-by: Codex:gpt-5.5
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> ---
> =C2=A0fs/hfsplus/catalog.c | 32 ++++++++++++++++++++------------
> =C2=A01 file changed, 20 insertions(+), 12 deletions(-)
>=20
> diff --git a/fs/hfsplus/catalog.c b/fs/hfsplus/catalog.c
> index 3f0cc1b1bb58..000000000000 100644
> --- a/fs/hfsplus/catalog.c
> +++ b/fs/hfsplus/catalog.c
> @@ -351,23 +351,31 @@ int hfsplus_delete_cat(u32 cnid, struct inode
> *dir, const struct qstr *str)
> =C2=A0		goto out;
> =C2=A0
> =C2=A0	if (!str) {
> -		int len;
> +		hfsplus_cat_entry entry =3D {0};
> +		u16 thread_type;
> =C2=A0
> =C2=A0		hfsplus_cat_build_key_with_cnid(sb, fd.search_key,
> cnid);
> -		err =3D hfs_brec_find(&fd, hfs_find_rec_by_key);
> +		err =3D hfsplus_brec_read_cat(&fd, &entry);

We can read something only if we have found something. But the logic of
lookup (hfs_brec_find) has been deleted. Are you sure that it is
correct? As far as I can see, the hfsplus_brec_read_cat() will operate
with invalid hfs_find_data instance.

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
> +		thread_type =3D be16_to_cpu(entry.type);

It's not thread_type but entry_type. The thread_type sounds like not a
correct name here.

> +		if (thread_type !=3D HFSPLUS_FOLDER_THREAD &&
> +		=C2=A0=C2=A0=C2=A0 thread_type !=3D HFSPLUS_FILE_THREAD) {

What if we introduce static inline function for checking entry.type?
Let's call it is_hfsplus_thread_type().

> +			pr_err("found bad thread record in
> catalog\n");
> +			err =3D -EIO;
> +			goto out;
> +		}
> +
> +		if (be16_to_cpu(entry.thread.nodeName.length) >
> +		=C2=A0=C2=A0=C2=A0 HFSPLUS_MAX_STRLEN) {

I think that is_hfsplus_name_length_valid() could be good to introduce.
Do we really have nothing yet? I suggest to have static inline function
for checking correctness of name length.

Thanks,
Slava.

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
