Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E505C3264FD
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2026 04:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781237520; cv=none; b=HCQvoReOHjCH9YBErxPUz9leakyuxS/vooFbIxbhpnirzGJXaVG5mSLscOJLSZovK3GHwal9fWwvsHNuHhw9sCgVEdBh6neM/WB8vpJRY0DCJ3LLItk2Vwcs/EtD477OY0YGrrh0naOBDtwVNfobkAPa60u0i7TxsnLHyhTahdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781237520; c=relaxed/simple;
	bh=tR2NHBeYxTJ5KTgGKkLKUgPceMFBiVd7vW6YwlE4AU8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oVOkzNpcQz69tn0Ysjvinyi8OE0yAiHM4a9CNTVnvzr1I/ivHpKjZmLeD9Lk8RaxSkE+8Mcg/GZ9Nvbf3QkW2pi8P6eygjRH3padCYTTupfGcbTf2jKyv09uChh/UnpP3bQ4oJSMJgJY3xTEi4LevcEdCUF97Fvl+ISrJhVdokk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=MPSKtrRt; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="MPSKtrRt"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-39657d28132so4080671fa.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jun 2026 21:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1781237517; x=1781842317; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qsEq1GwYRO/8ktlYy2x50g/LNlw/hqftiFLLg7QAnOs=;
        b=MPSKtrRtUJ8h5DxsN0sfRgauZsScZaE48ZNO31gxvx6lzjl5JWp3/inCXX77Ch6lAx
         Kph8mpBmqQTgMOJe92L8Dm9XKr7Ih+r96aVB0DrbSkEYAhNK6+WcPc7TRTXadwwLaARc
         o9cdZd1W6EtIVMNi5Mm5Gtk4HsN+Pokp1ECVhSZuqlEplmryzYs1rJbMAMpt+SISQiIa
         Z1CtBc0wIPSWN0y9PSVoffCRFo1w1mLSchKwiWLTDYnVtRkwt9puQQnyvD/xU+lF/deF
         GH1tHkvTZjzuDnr89HF2zPpGL0G4jyI4/1Cz4MMs7ftpkFPKKxHgUytSbiJL0tgzBPNz
         2AGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781237517; x=1781842317;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qsEq1GwYRO/8ktlYy2x50g/LNlw/hqftiFLLg7QAnOs=;
        b=irm4JZGmzjmeidS1ifwTi4o1oa5QfFGjYeJRKsYXlwu9T7ILxe57yZGUXww7SFZgSU
         Emh/WgRJ5Na/brI+kMFRQk1Dj8c0EPdlFvR3kZrEFjQdiBs4KD0nFBGeuI63BlcePoXM
         GkNxqYZQvm1iXb62kUzr8YUz4KywqJSdDwfUVpjdvEIlmMF5ry54JEXOOozfyp3ncWQf
         +3nwoivQgM414sCzWsfptXGBPJhMtdjWrsIDsZ6e2faqurb0sqwce+VLMnC1E8ouxd9X
         gK/waKtO10sK1Dq4M7lI3IWrhM7/uos2L4y2mda03y1HWPGfJMGSfjmGB0OyrvVdhq0d
         +Omw==
X-Forwarded-Encrypted: i=1; AFNElJ/r2q0fFEF3W+G7Fp8B+q/sTEPMm0WJQhLP3DxDiXS6LzxABdmWN66+uuKjwZTggVDWQ+xT5tjYCgpy1gpC@vger.kernel.org
X-Gm-Message-State: AOJu0YymmKm3UJn46sZmSEhi+C93qLXv8k+dx1M7bxDDSCpo+utVNNQE
	feYCzbFp3/hulzV1TUjWa0DSAmckFBXnlpassElCBvgP/WBlh7V1RRogZQJsC13cAqo=
X-Gm-Gg: Acq92OFo5444jtpGSjG9cYC/5UKKiCM3qZrfc6Uc7b1fD+QoJf/c3hKUvU5kvFLw205
	Am1s9A2zXeY8I3pXvHXGvku9z9q7SMNWGAK7WjDxgYZjLbrhqGH6uoooNZuHko6lkZYjUzlg61e
	iLtq7D+3FZAVqNtM5PcLANEfYFvIVvfptnOvW1ZdcLvbvf0nOck8EGVIiCxzFRFP6vCjbyRVk71
	QZfT+j3+NnJ7GIf9SGQN/Jp3H6Srr59DbTl1OhZf+OwpORLUPpAMeuFlHMih5t6akflz99xTS5c
	RcQeCbxF1tyc9pyd+irRA5fhvjeDhPcp8ja9BIGT7fMzawBcYsxNAzDX6/rA6OfSF7cm1zvyGmC
	UP6voRNC/pkRNixjV7UFkl8idA1v5ZqxQ5MjMx1Efsdldaa/iLlY+zKqs5P+NGYn6+pf4mvglMR
	xTSsdM8JHIK83sLxUXMJobw5N1JnLfj6ysRWioIvx/tZ6GhtUBKc/ViJhBRDyXy3JYbsXi5MNWt
	SgPI0nxHN3Os9qA+fO1KlknuqslM9I2ESFlyMAJm1CK4+BjLATXdRCf
X-Received: by 2002:a05:6512:4801:b0:5aa:4aa4:29f3 with SMTP id 2adb3069b0e04-5ad2db5ddeemr245473e87.28.1781237517130;
        Thu, 11 Jun 2026 21:11:57 -0700 (PDT)
Received: from [192.168.1.246] (broadband-95-84-186-252.ip.moscow.rt.ru. [95.84.186.252])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2e1b421bsm167350e87.73.2026.06.11.21.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 21:11:56 -0700 (PDT)
Message-ID: <04c1bff937f903a43820ae4c916b6ea919944869.camel@dubeyko.com>
Subject: Re: [PATCH] hfsplus: validate thread record before delete key
 rebuild
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Kyle Zeng <kylebot@openai.com>, linux-fsdevel@vger.kernel.org
Cc: Yangtao Li <frank.li@vivo.com>, John Paul Adrian Glaubitz
	 <glaubitz@physik.fu-berlin.de>, outbounddisclosures@openai.com
Date: Thu, 11 Jun 2026 21:11:54 -0700
In-Reply-To: <20260611212633.5058-1-kylebot@openai.com>
References: <20260611212633.5058-1-kylebot@openai.com>
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
> +		if (thread_type !=3D HFSPLUS_FOLDER_THREAD &&
> +		=C2=A0=C2=A0=C2=A0 thread_type !=3D HFSPLUS_FILE_THREAD) {
> +			pr_err("found bad thread record in
> catalog\n");
> +			err =3D -EIO;
> +			goto out;
> +		}
> +
> +		if (be16_to_cpu(entry.thread.nodeName.length) >
> +		=C2=A0=C2=A0=C2=A0 HFSPLUS_MAX_STRLEN) {
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

Have you run xfstests for this patch? Sorry, I am in personal trip
right now and I cannot test your patch until the end of June. Please,
ping me around that time.

Thanks,
Slava.
