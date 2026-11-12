Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794516264;
	b=4G191Ur6LW6RMQgUMUiedM7JWJu4zszF3+iE5Kfb70Pb9gX1u5Fe84KWEha7PfPN74iq
	 QhQI8Zwo57tMtQzAXKYvLOv2rSdX5Vvsdf/Nb2wYKxfZyHHHN3NmCt8ueMR3Bg8thkbb6
	 R3dsl8cfiRDmDQVp3/AOtydGXGwpNUa8Dvb+FgplI5J+ONVE9db8ifZeEzCUym6m+Tyj1
	 91wXKFCnWERG4g55cGGyKJaUz4s2IU8P4oEjDQCp3DhX/uaHVja86wkXHVwKh5jcs2r2u
	 Wf9pg832Z/ZtK5LHBtMcxbvQm1sJ2ohnJJVfsXZKqgRo0DhD/xjonesy3xMyKXdcHaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794516264;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:Autocrypt:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=1x6aqmAQRrynAIsDlQ7a6VDqmeWzlsEVjpZnIZpydcQ=;
	b=CzQgE1LX7qxfh8ACDgx8MGVZYaJXGBkYf8udSY5mblvzMOfBr459J2GY+KHqLSs+9W9G
	 dDoYSIu2YSEwZoQMBd6yMVd4z9dyXZ1y5CQDsY56CtaZNa9J5VHuuP+/HAJe4NnUHAUjt
	 qyxnQ7ZrQTsuAjplNc797j0lYvDKpV+Wh80ecEra+QphD1ZFMtlBzpT3lpPWibdVnA9tf
	 Wp5rSPJdxrUHEstWnrRXeLvoP5vmQMZbIx8j/J+mJRn2EryYLQsOpbve3DY5kVTHsVKgw
	 jTKABpWS8bVIj3Nm1pbi8pHYQsJUfElE+m+DsY9jaVl+ROHbn/bFzh+6cDfnSFh86Fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=BBpdXZel;
	arc=none smtp.remote-ip=209.85.128.173
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B5D606A8A6
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 20:44:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36B5D606A8A6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=BBpdXZel
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8b2d14968c9so4375467b3.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 12:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20260707.gappssmtp.com; s=20260707; t=1794516263; x=1795121063; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1x6aqmAQRrynAIsDlQ7a6VDqmeWzlsEVjpZnIZpydcQ=;
        b=BBpdXZel5kBePXjqDY0dAG2uVor93zVHv83A9d2dtD22Fvvh7VbD802BQqMtV+zPhX
         0nThnfnv7QDqRt+LaVCOO8CDqrq4QYTZ2ypKNKkph3Wh5xEjsUbH4zezhpEb8CKaVu+5
         pIzSzyg5EwUEp5K9iAQ4IYODZYgYiuQ9JkbLGWRxm3uI3MfMfVZyhHXPo/v0FAuQAQ3V
         e8uico/h6SQx+I2lbc/JDoc80a5Zf7gRlq1uv8Om1IaiuWLlGSg/se8AXn0RGmE7Z3rn
         rAoON2hOFrLUjmyBwMkQ0fyunO11YE+r4XVjvRHq4yZr0L9V5OC68+Mfr1Sz2LfSk7WY
         3bnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794516263; x=1795121063;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1x6aqmAQRrynAIsDlQ7a6VDqmeWzlsEVjpZnIZpydcQ=;
        b=We868GbD7IyQWdKBowHvX13GqKHvQf8lrJmZ3T/d8iJkAYlaU7boEGR9HFYC4I3Als
         dNOta/ViDoQJI6bIZRuvsTRO348JfsMkCh0iugKNP6nWSMGo3fNzpxJAwguF/eytFUqc
         RCY6mtmGpm0e4zNpS1JwB0DjOyERA8I0OoHgjpZVbxXC3epF0GGVrnntRCnpda08Uzqt
         oqbw5B+tAdYWuY+htHFCJo+YnobzzLqeCwVR7HcEHSCRJgdo2EC0amL62NXsh6e9Q6CQ
         /LApReZxiUmBy3TIZg3jAkHMlUo+7eM5i2kLw3N6DiLSETj30Sc5kIB9ehdCVRe5PTdu
         l1mw==
X-Forwarded-Encrypted: i=1; AL+hErFt4IIqECigd9VmM4fN3x8LnxauyQu+X3JpDkMElCNnU191PgWT6VkxuQW7bZtkbNy0m+GBfCeQaaWw6tkk@vger.kernel.org
X-Gm-Message-State: APuU4Z+rxaKMUVbxftps/WDNtHeB2NbG7rtI464stmN3LVHSFm9c66D8
	g6Ah6N7gonS46Dbt0svMs99BxNDQZL4YN4Rd7sqf1iCp/ni0JxppSpuE25bywzzHDYU=
X-Gm-Gg: AYBFou3kUUq1m6OOTZCT/Kuc7cmIp+17wYZ1kGBIZScteRx1+/ckh2pcr4YxPFP1txw
	KcJG++oWDIt6OIzzPofM3LXGHLLHryIc3Ib2evQYfk0jcMNo65+3E2CoMAec5u1CZFgV88jPFEU
	H9irlfTOFWMwHumpwlb+eUbfzfJ3lblx9edgDl9M6a092GVApZiC8YhY+eybVvzU8In7C0i9men
	HipQGUr3L/LvNASy0SEpeaWdrlMMUvp5M5uf/5qckTNShYtn8WfgLG77aMaXBF527h3lXn1hboz
	Clvti2sjWaA8A758GIG+Lqd6/Kgc45H3VugU5IwE5ddMD1ItczEKxzU2aFIO82zoMOH6AguLhXE
	WOkk6FjRKQkfLJOrusQtNBqCjaJD9FW6sq+DH7pAR1XXXMVx/+PbChYbPKadK+u0J+QvDpKEPie
	us0wgmsvEN3OXfVyCxMignRQyc5TlxYwDteALgqIaNm/OO/QnFrn1Q71dP6e87Ba2wP64DaHTGg
	NV2lz1IP2Bg/KQ9tTkwun5nKRM4uCTeLexK2d64tyy3JLo2FWUkvjHv7nqGnX59DmdQ36/iEBhe
	t+mEqsGGtTZBJ24QNgIBno/uPx01KZiDgiG/jqMugGEeBDbhMla3Ii5QnFG6xYde6oclSPSBLZA
	xj60mGTZZJtA+Gs3Y2ImNqBWLEQ1J5ViB6QOhlQW7YfPpLpeVJQHcGwWdhcQ85wpwootC+To=
X-Received: by 2002:a05:690e:43cc:20b0:67c:33d9:791d with SMTP id 956f58d0204a3-67d89639442mr211820d50.48.1794516262929;
        Thu, 12 Nov 2026 12:44:22 -0800 (PST)
Received: from system76-laptop.attlocal.net ([2600:1700:6476:1430:3a31:6c95:5610:70f6])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4aa9da90bsm4665597b3.37.2026.11.12.12.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 12:44:21 -0800 (PST)
Message-ID: <0205ef88738917a6d307b4e334e2dd1b0851317b.camel@dubeyko.com>
Subject: Re: [PATCH 2/2] hfsplus: do not end readdir at i_size after an
 unlink
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Hengyu Liang <hengyul@cs.unc.edu>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yangtao Li
	 <frank.li@vivo.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Thu, 12 Nov 2026 12:44:20 -0800
In-Reply-To: <20261112111745.4094283-3-hengyul@cs.unc.edu>
References: <20261112111745.4094283-1-hengyul@cs.unc.edu>
	 <20261112111745.4094283-3-hengyul@cs.unc.edu>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
 NFdvziOa4FgUBC4X71upsZIoZJeii2V/Jtc3B4g==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Thu, 2026-11-12 at 06:17 -0500, Hengyu Liang wrote:
> Commit 4b0496432844 ("hfsplus: rework hfsplus_readdir() logic")
> stopped
> moving the position of open directories back when an entry is
> deleted.
>=20
> However, hfsplus_readdir() still ends when ctx->pos reaches i_size,
> and
> i_size drops on every delete. As of now, a program that reads a
> directory and deletes what it read sees the directory end early and
> leaves files behind.
>=20
> The issue can be reproduced with BusyBox rm on a new hfsplus volume:
>=20
> =C2=A0=C2=A0=C2=A0 mkdir /mnt/d
> =C2=A0=C2=A0=C2=A0 (cd /mnt/d && for i in $(seq 1500); do : > f$i; done)
> =C2=A0=C2=A0=C2=A0 rm -r /mnt/d

Frankly speaking, I don't quite follow what is the issue of the fix. Do
you mean that we create and delete folder in one thread and execute the
readdir in another one? Or do you mean that application has several
threads and one thread do readdir but another one delete file by file?
How this deletion is executed? I mean which files are deleted?

Even if we delete files in folder then i_size is dropping gradually. If
we traversing the folder's content and ctx->pos >=3D inode->i_size, then
it sounds that we already showed the existing content. Do you mean that
if we deleted the range that we already processed, then we miss the
rest of undeleted items?

>=20
> Before commit 4b0496432844 ("hfsplus: rework hfsplus_readdir()
> logic"),
> the directory is removed. After that commit, the result is:
>=20
> =C2=A0=C2=A0=C2=A0 rm: can't remove '/mnt/d': Directory not empty
>=20
> and 304 files are left.
>=20
> This patch will end a walk that continues from the saved key where
> the
> records of the directory end, and keep the i_size check for a walk
> that
> starts from a position.
>=20
> Fixes: 4b0496432844 ("hfsplus: rework hfsplus_readdir() logic")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
> ---
> Application impact (Ubuntu 26.04 user space): a folder with 1500
> files
> on an HFS+ volume is moved to the trash, then the trash is emptied
> with
> "gio trash --empty" (the call behind "Empty Trash" in GNOME Files,
> done
> by gvfsd-trash 1.60). On v7.1, all files are removed. On v7.2, the
> trash
> looks empty, but 478 files stay in .Trash-0/expunged and their space
> is
> not freed.
>=20
> =C2=A0fs/hfsplus/dir.c | 27 +++++++++++++++++++--------
> =C2=A01 file changed, 19 insertions(+), 8 deletions(-)
>=20
> diff --git a/fs/hfsplus/dir.c b/fs/hfsplus/dir.c
> index b3a1193a491f..81fe8a3e07c9 100644
> --- a/fs/hfsplus/dir.c
> +++ b/fs/hfsplus/dir.c
> @@ -135,10 +135,16 @@ static int hfsplus_readdir(struct file *file,
> struct dir_context *ctx)
> =C2=A0	char *strbuf;
> =C2=A0	hfsplus_cat_entry entry;
> =C2=A0	struct hfs_find_data fd;
> -	struct hfsplus_readdir_data *rd;
> +	struct hfsplus_readdir_data *rd =3D file->private_data;
> +	/*
> +	 * i_size follows the valence and drops on unlink, so it
> says nothing
> +	 * about a walk that continues from a saved key. That walk
> ends where
> +	 * the records of this directory end.
> +	 */

I really dislike the comment in the variable declaration section.

> +	bool resume =3D rd && rd->pos =3D=3D file->f_pos;

Is it possible that rd is NULL here?

I don't really follow how the resume variable can help at all.
Probably, I am missing the case. Could you please explain the issue at
first?

Thanks,
Slava.

> =C2=A0	u16 type;
> =C2=A0
> -	if (file->f_pos >=3D inode->i_size)
> +	if (!resume && file->f_pos >=3D inode->i_size)
> =C2=A0		return 0;
> =C2=A0
> =C2=A0	err =3D hfs_find_init(HFSPLUS_SB(sb)->cat_tree, &fd);
> @@ -183,10 +189,9 @@ static int hfsplus_readdir(struct file *file,
> struct dir_context *ctx)
> =C2=A0			goto out;
> =C2=A0		ctx->pos =3D 2;
> =C2=A0	}
> -	if (ctx->pos >=3D inode->i_size)
> +	if (!resume && ctx->pos >=3D inode->i_size)
> =C2=A0		goto out;
> -	rd =3D file->private_data;
> -	if (rd && rd->pos =3D=3D ctx->pos) {
> +	if (resume) {
> =C2=A0		memcpy(fd.search_key, &rd->key, sizeof(struct
> hfsplus_cat_key));
> =C2=A0		err =3D hfs_brec_find(&fd, hfs_find_rec_by_key);
> =C2=A0		if (err =3D=3D -ENOENT)
> @@ -195,9 +200,11 @@ static int hfsplus_readdir(struct file *file,
> struct dir_context *ctx)
> =C2=A0		err =3D hfs_brec_goto(&fd, ctx->pos - 1);
> =C2=A0	}
> =C2=A0	if (err)
> -		goto out;
> +		goto end_walk;
> =C2=A0	for (;;) {
> =C2=A0		if (be32_to_cpu(fd.key->cat.parent) !=3D inode->i_ino)
> {
> +			if (resume)
> +				goto out;
> =C2=A0			pr_err("walked past end of dir\n");
> =C2=A0			err =3D -EIO;
> =C2=A0			goto out;
> @@ -263,11 +270,11 @@ static int hfsplus_readdir(struct file *file,
> struct dir_context *ctx)
> =C2=A0		}
> =C2=A0next:
> =C2=A0		ctx->pos++;
> -		if (ctx->pos >=3D inode->i_size)
> +		if (!resume && ctx->pos >=3D inode->i_size)
> =C2=A0			goto out;
> =C2=A0		err =3D hfs_brec_goto(&fd, 1);
> =C2=A0		if (err)
> -			goto out;
> +			goto end_walk;
> =C2=A0	}
> =C2=A0	if (!rd) {
> =C2=A0		rd =3D kmalloc_obj(struct hfsplus_readdir_data);
> @@ -279,6 +286,10 @@ static int hfsplus_readdir(struct file *file,
> struct dir_context *ctx)
> =C2=A0	}
> =C2=A0	rd->pos =3D ctx->pos;
> =C2=A0	memcpy(&rd->key, fd.key, sizeof(struct hfsplus_cat_key));
> +end_walk:
> +	/* This directory can hold the last records of the catalog.
> */
> +	if (resume && err =3D=3D -ENOENT)
> +		err =3D 0;
> =C2=A0out:
> =C2=A0	kfree(strbuf);
> =C2=A0	hfs_find_exit(&fd);
