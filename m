Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87411D7E41
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Apr 2026 00:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775004122; cv=none; b=HVS4mKieLsi7W+yMbakSRpvkP+hDz7e5H8ex04qP29jJmKBaweahsFW5y/d2oFHnL1D9UciOT/KTAHA3XGLCOfhO5y2pIAjstLQ0rNVEeVLtYUoXr8C0Hx7i4WchIRrbykjSmi/vFDIx14w7Ph9s3Bs/cd7TjLV7NwhYfFFEwiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775004122; c=relaxed/simple;
	bh=0f6H66EJ8FTtE0mIr6/FwIXLfnsShtG/M3I5Q65svMM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DUZEuxUHIMMhhMYZov+kTqZoO/3wOBVanoyXGa8wj7IvMRGeRRZHsSQLi+/zeUSfvv91jJ44rSW/ijCROjaLuQ3ig+yvZ6Tx6BHCfX8Z+cNUDAZAAei9nVYb+tKALWqtq3SkLeGcmqmwm1xmUJmEkH31cVqAgMOxX139pTWLR6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AJFt+puR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=n/Ox2uzl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AJFt+puR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="n/Ox2uzl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775004120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YkdBOKp8ur+t6DO8tDb2WCjkiRXdOFttzTuv0DcNlaM=;
	b=AJFt+puRpu1SUWSiL1DL0xmAia0rJ7N+qX7OFFnwL6+A5Hm+JR7euSKCgTep9Qyb6xWzsP
	hfEBaQGlvWI/gLOgY+qtYo3kmfbUv/5J1prA85+aA0cbjtVFS7fcP5F8Oxmnwsf9pzUfk/
	mBIiWOfEXfAmIbq140aGnyx1MaY7ayI=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-HBHyP-u6Mj23whRwXuGXrw-1; Tue, 31 Mar 2026 20:41:58 -0400
X-MC-Unique: HBHyP-u6Mj23whRwXuGXrw-1
X-Mimecast-MFC-AGG-ID: HBHyP-u6Mj23whRwXuGXrw_1775004118
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-799001d7289so65409317b3.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 17:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775004118; x=1775608918; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YkdBOKp8ur+t6DO8tDb2WCjkiRXdOFttzTuv0DcNlaM=;
        b=n/Ox2uzlSfA1Ez2yJ5eo9lGv/OeROqRAnn78caHk5WqwNGP9qejZj1lq8oxHVAWzdx
         F6KYSJeSIQEfk/YjCE1xUMg/s0oXZG91D1hcxJ6umP9E8Sc8IcCpGl0KJdT3apkprW3t
         QLpiO/Ydk/2hEcEhc5MD08obfNWNLrORqw0UJIRSgr+GsUn62XVGLosUj0IGPK6Z+9qF
         iJPTP1bo8xpvg4v3mFDA9UXg4bIN1vEnMdCzI38CTLhSA50tOqrBUqg9ZnQR/1JziwNU
         CRLs2xcAvwSVqJPmcvUsx3mVoZXqnVuBrXwkzRT4+3dcE86avt/NufyUlIu4Nk01LF1F
         eM6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775004118; x=1775608918;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YkdBOKp8ur+t6DO8tDb2WCjkiRXdOFttzTuv0DcNlaM=;
        b=OXxHqDxuUOMbAudTvfkGLACaoqsq1yQKKtDQ88QQDKZvrXL2ZV9uUpShhSfIVIHNzy
         i9GJDyjjMjQIYiPL0I0eGGP21eLuFhru5uNrIyBEHwxr1fIuoD3n/InQBAaWfAGcyJ1t
         YPKFL86zEjEmJ8wcdiffjsozZFTeh1+saw6f5z9V2zR+W5OwvzYX7UH2cAN67/3GcMUm
         BNzmO96zdMSKRGEBLQRtBhRClTGvn0eEtKUZ9wcTl/0KpddCRMpzkAMphIygO6WVq509
         8H1trqmX3+da9IlOVoe8VzWt9trKQgSaj+8y3KvN0iK3Vt5WjuSLpyhfinyhiSr6Ng3W
         tjJw==
X-Forwarded-Encrypted: i=1; AJvYcCUuDFPBdWg+gqggxROgOYK0SFiA2h/T5s+2cTgHHnylBnC1Lb50APVr1f47BUxRgXwCIIL7NGaZv+S05S1z@vger.kernel.org
X-Gm-Message-State: AOJu0YyxFopk+W9SOfFHriRJmlCfz2L9nBkRxor+CQFFPkmoc9k11M4c
	TclsJb/xMUGMYPdLICDEuPuiDO73bGOjSToWYSMlBJUVZcRiJ1cF9LiSgpgN2Y1Z/6hy8pER+49
	+4Qxx8ov5C0Eh8GvSBvlifgVmlWoI0qB1slBPeAWFBlDmC+cWEJPS2btlF6OpvyucEjs=
X-Gm-Gg: ATEYQzz0FsEzfst3N6TZkeyq5nVXa1o/DS2OeRPTne6Igu2SX57AFT9usu1MO9jwt6N
	eTD85E1TAbIAKIv5taXQPJeQsreXKFfso8qHf4fJCe35bQK1MAz6T5wGHX2nLIK7g4sUwdesRTX
	pDLF/vWt+/PrenImDY071ErS3kHoxnUYvcdEG7T+09TESrZdc6nk6cjK+wyIdNoewTLD4a0jAiP
	6KSeM1Ft+5oVvWv09IKuRuKR5rmhIYe7pwkCFy3sWOfYaFGvsyUNF18RCgXRq1Am/iaIOj2wFE+
	5gN4R9wvSicfYNAr2t/5ucYR7bA72UCy2jjJyCWVllNykzp6O4IhMdk4E55njX14uOeWPPi1kO4
	gJp/wnkS4SArvlye1gDO1ZaVH9b605KKIgZAixWrI7l5WpAz5ysP4
X-Received: by 2002:a05:690c:e08f:b0:79a:cc64:8869 with SMTP id 00721157ae682-7a21310426amr15686297b3.56.1775004117760;
        Tue, 31 Mar 2026 17:41:57 -0700 (PDT)
X-Received: by 2002:a05:690c:e08f:b0:79a:cc64:8869 with SMTP id 00721157ae682-7a21310426amr15686017b3.56.1775004117117;
        Tue, 31 Mar 2026 17:41:57 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79cb7910e7fsm56542097b3.18.2026.03.31.17.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 17:41:56 -0700 (PDT)
Message-ID: <c732a6e39e833b4b63499059cd388b753e1b2297.camel@redhat.com>
Subject: Re: [EXTERNAL] Re: [PATCH v5] hfs: update sanity check of the root
 record
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Viacheslav Dubeyko
	 <slava@dubeyko.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds	
 <torvalds@linux-foundation.org>, Jan Kara <jack@suse.cz>, Leo Stone	
 <leocstone@gmail.com>, Christian Brauner <brauner@kernel.org>, John Paul
 Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, George Anthony Vernon
 <contact@gvernon.com>, Yangtao Li	 <frank.li@vivo.com>, linux-fsdevel
 <linux-fsdevel@vger.kernel.org>, LKML	 <linux-kernel@vger.kernel.org>
Date: Tue, 31 Mar 2026 17:41:55 -0700
In-Reply-To: <5257abf7-6746-4719-9c5a-e1186883c608@I-love.SAKURA.ne.jp>
References: <21e7ebfd-d35d-4682-b553-6996cc8c3a8e@I-love.SAKURA.ne.jp>
	 <e5c4f20159d3661984888add9c6da684623af3ad.camel@redhat.com>
	 <5257abf7-6746-4719-9c5a-e1186883c608@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43app2) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-03-31 at 10:12 +0900, Tetsuo Handa wrote:
> On 2026/03/31 6:45, Viacheslav Dubeyko wrote:
> > I've already reviewed this patch. And I am not agree with this suggesti=
on.
> >=20
> > We prepare the key with HFSPLUS_ROOT_CNID [1]:
> >=20
> > err =3D hfsplus_cat_build_key(sb, fd.search_key, HFSPLUS_ROOT_CNID, &st=
r);
>=20
> What we are talking about is not hfsplus but hfs.
> I can't catch why you are talking about hfsplus function.

There are a lot of similarity between HFS and HFS+ b-trees functionality. E=
ven
we can have a common code in the form of library shared between HFS and HFS=
+
code. HFS and HFS+ have pretty the same function names in b-tree
implementations.

>=20
> >=20
> > The hfs_brec_read() executes the search of the record [2]:
> >=20
> > 	res =3D hfs_brec_find(fd);
> > 	if (res)
> > 		return res;
> >=20
> > The hfs_brec_find() should found the record for requested key. And if t=
he found
> > thread record contains not correct CNID, then we can check the found th=
read
> > record and return error as the result of the search.
>=20
> hfs_brec_read() indeed calls hfs_brec_find(). But I can't interpret how t=
o extract
> CNID as of returning from hfs_brec_find().

/* The catalog record for a file */
struct hfs_cat_file {
	s8 type;			/* The type of entry */
	u8 reserved;
	u8 Flags;			/* Flags such as read-only */
	s8 Typ;				/* file version number =3D 0 */
	struct hfs_finfo UsrWds;	/* data used by the Finder */
	__be32 FlNum;			/* The CNID */
	__be16 StBlk;			/* obsolete */
	__be32 LgLen;			/* The logical EOF of the data fork*/
	__be32 PyLen;			/* The physical EOF of the data fork */
	__be16 RStBlk;			/* obsolete */
	__be32 RLgLen;			/* The logical EOF of the rsrc fork */
	__be32 RPyLen;			/* The physical EOF of the rsrc fork */
	__be32 CrDat;			/* The creation date */
	__be32 MdDat;			/* The modified date */
	__be32 BkDat;			/* The last backup date */
	struct hfs_fxinfo FndrInfo;	/* more data for the Finder */
	__be16 ClpSize;			/* number of bytes to allocate
					   when extending files */
	hfs_extent_rec ExtRec;		/* first extent record
					   for the data fork */
	hfs_extent_rec RExtRec;		/* first extent record
					   for the resource fork */
	u32 Resrv;			/* reserved by Apple */
} __packed;

/* the catalog record for a directory */
struct hfs_cat_dir {
	s8 type;			/* The type of entry */
	u8 reserved;
	__be16 Flags;			/* flags */
	__be16 Val;			/* Valence: number of files and
					   dirs in the directory */
	__be32 DirID;			/* The CNID */
	__be32 CrDat;			/* The creation date */
	__be32 MdDat;			/* The modification date */
	__be32 BkDat;			/* The last backup date */
	struct hfs_dinfo UsrInfo;	/* data used by the Finder */
	struct hfs_dxinfo FndrInfo;	/* more data used by Finder */
	u8 Resrv[16];			/* reserved by Apple */
} __packed;

/* the catalog record for a thread */
struct hfs_cat_thread {
	s8 type;			/* The type of entry */
	u8 reserved[9];			/* reserved by Apple */
	__be32 ParID;			/* CNID of parent directory */
	struct hfs_name CName;		/* The name of this entry */
}  __packed;

/* A catalog tree record */
typedef union hfs_cat_rec {
	s8 type;			/* The type of entry */
	struct hfs_cat_file file;
	struct hfs_cat_dir dir;
	struct hfs_cat_thread thread;
} hfs_cat_rec;

Every record starts with type. And anyone can easily retrieve the type of
record. And, then, you can extract the CNID.

>=20
>   int hfs_brec_read(struct hfs_find_data *fd, void *rec, u32 rec_len)
>   {
>   	int res;
>  =20
>   	res =3D hfs_brec_find(fd);
>   	if (res)
>   		return res;
>   	if (fd->entrylength > rec_len)
>   		return -EINVAL;
>   	hfs_bnode_read(fd->bnode, rec, fd->entryoffset, fd->entrylength);
>   	return 0;
>   }
>=20
> Since hfs_brec_read() doesn't know which type of struct (one of "struct h=
fs_cat_file",
> "struct hfs_cat_dir" or "struct hfs_cat_thread") does the caller of hfs_b=
rec_read()
> want to read, I don't think hfs_brec_read() can tell whether the CNID is =
correct.

Please, check the HFS's on-disk layout.

>=20
> I am waiting for your response on
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lkml.kernel.org_r_=
9f66743b-2D70e0-2D4886-2D884e-2D5203f5c02ed8-40I-2Dlove.SAKURA.ne.jp&d=3DDw=
ICaQ&c=3DBSDicqBQBDjDI9RkVyTcHQ&r=3Dq5bIm4AXMzc8NJu1_RGmnQ2fMWKq4Y4RAkElvUg=
Ss00&m=3DV9I6gMC1If2D6irQzVVC1M0wKQW-kbErffC9npM7z-fyjkutPS0YOARfqxRsyUdc&s=
=3DMAn71bGJ4-F3OEEhjru0azzQc62bUcvfCsk1VndcjC4&e=3D=20
> where the caller of hfs_brec_read() can tell whether the CNID is correct.=
 But such
> change is a matter of preference.
>=20
> You can respond with your patch which will be much faster.
>=20

Sorry, I am busy with other HFS/HFS+ issues.

Thanks,
Slava.

