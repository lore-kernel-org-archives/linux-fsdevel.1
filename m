Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF51A3D8918
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 19:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774294315; cv=pass; b=oa3pxWt8ZiD1KuyeAY7eQxy0/yBzuJo2ph+tWaCXEXhXbvtyMG7Ss6Ia4LUU3spnuBSpiXDXOaRgi0JmFGbeouq3E+PVKkub5XlMQy/FwaPj0Jhbbeh08w+TXmbZ4yYe2tX/r0K1U/O4O/MKcqgz+ACTMMc5PwY4GWO2H7AbYwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774294315; c=relaxed/simple;
	bh=qEmaMrG6tQEKHABcH5kGpa1dSTH50exe6PGoRyajv9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VhjhRN9jBmKR6cV8p1OwmOLSzLf+UhQCpevzAcznAvqcmKGXLuCKJj6yYFRFLjaB5pGLFurTEYggrc/LLs7nj7YGmCKSDGce/A/dKXHkQEtlNj6rKJL8qa0rmsoGPSNACuEQmWmkFw2L/PZFZNleUOZmSfNrWPzH5l66sUgSV/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=dau72Gt3; arc=pass smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="dau72Gt3"
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62NHGtHD551067
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 12:31:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=qEmaMrG6tQEKHABcH5kGpa1dSTH50exe6PGoRyajv9c=; b=dau72Gt3dvQN
	Jbl5OSdTRlLie7gsjtUOOGmFwPdNDx2OdKuFIEHt8cZz0kC//nK7765yvsXTEi5l
	tpAHkjjgzsZKqXlOzQVJRY6FG+Qw2rdPOXZ+dZcwhQlI68qFAS3dmH1GKyLm0I4j
	TrfOtFZgU4WHizGxN+QnfN60+hdV58LEK7ei3jrXaADUY+5MxzwOupKP52n3IBzy
	dnWRPzWGgUCw8OWMRHWFHvqb1R2HIL6IrXdaBfkvvASEXPxUTHQPbY5vKkvlrpWB
	vQHjyWNNttoIT+uPLz71hulmTcfnNhKnW/7afG5Dk8LCfa1w4UdrwIfYWQRyMv0J
	t3A9GTFdrg==
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4d38s33g63-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 12:31:51 -0700 (PDT)
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-38b05f4c330so17185931fa.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 12:31:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774294310; cv=none;
        d=google.com; s=arc-20240605;
        b=BLFRD5G7FIXmo1Kt123NDskP5B8Dkie8vE1yRtXEV+TOJh+MGmwvfa58lg9o/Et4eQ
         ElzBnO7Wr7eD+g6i8dlsA4n9tLxOHdLCx/Kit/+4S3yrzJ3864JXcZo2ivl8ktakLhnS
         dq2cJUPgIorgg+iTvh2TmX2gnO+i+9uA7bg0draP1HKSYJfFWK32MAfMgJocfJhJZaF4
         MzjGGg5jOIPKqTZufk/M5dr/ktmV7fWhg8V+1AJcvefQRc2PodDcGJ/n/jY/5uZth8hE
         HxbRj6Co64Auy1JHGKMxBZOazhs2OYaNaTi40bnwgP50z368gX9LU3CeBnWHqtPFOyaY
         ptOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=qEmaMrG6tQEKHABcH5kGpa1dSTH50exe6PGoRyajv9c=;
        fh=eXyqo19IreWT61LmcdzMZSLAS0jLUw4eoOazjqgbkcw=;
        b=CqV1nFBjlxUBAnRBkiqE3smBvf0EZ1vYPz310uv2OPVfHiirhxZXWk3InEEGdvR57f
         MnVBjjA/0hyjVnlnl4vJG9ZSw7OMSzqLpNGTewsm25l9BvXcqCVQYRcdWqTQ4kZ7u4oO
         fKVG9vs3oNhPNCvVAiaZDuzCP/rlhqaaJguTEhJRrOTishP2pZgKbpr9Jxj2uNAYd4MS
         vZAqZrsLWr2Z7HMPpnMVjgxgGo6upu6+fZGkEzFO6KhlR+jXyoSLsIYP19guZSrr/EHj
         QRDgCOQIwcZZCorP4w42AKoKEUgo+SwlpbWyV5Z99m076ggeMlqfl+V4YFCf5hzbv+bg
         Nj3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774294310; x=1774899110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qEmaMrG6tQEKHABcH5kGpa1dSTH50exe6PGoRyajv9c=;
        b=XHGi4paSrJwQS5s1shj86IE78P1Vj/xDFbntF0oP6kb5OeAJDfCG3w+d1jsuK+NuA2
         VxznkrYCqyAJf4OBY0qX5LAREIqOOsaEmVMTiiVt9BY8tmnpp5yZCTGhxumoF7uKLUpu
         ODTCGDBubY5Q/PSA4oEHdN083zN6FTrtAIVF3A6wVUXZ1RGGcS+05qAMb8oRgt4K/PGZ
         hZAvxKwisqXcYOjUSSLoOhHfCARjoWiRl+rpsiysPEF/qP5vag4GepwnRTyfet3e10L6
         XKYjNJs3W6W+Gm+kNRav/xYqW4VyV9DZd5m0QD5RuaRpl1PdBbnn/UUrkAkcq6WmgHR2
         EY/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUUtJ6LC9Ghh1LkDwgRUcgenn3ouO0T8ljHOsr7F7CvnfrtDpaBqltbnXflEblWddUen1L4ysC2Irzefpcq@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5cECZe86gRHbB3sbiPyTCHAb+Q2RvmOeW3E5gYy1lcVV+a40K
	BwHQrFgPxil4hYURrIbGOT67U+j8Wm4xBHiVY4MZ27LGQehT3sDeE7ufhB8+0KLebU4YJbVfbju
	EbTHBbmAba1NGL65CBd7P8VC/GEV7G/1QcDB7BIilN5x2jLkdVDpNSBaOymDKhpMAtBOvbeeqRH
	TSxL019p/yMZ1VeeEqsILJraZKJ5SkRaVifM/5BGQO
X-Gm-Gg: ATEYQzyyXKztzrE+HBMWoretrCsq2Q4a8ogcHx5OM3LZ3VlkFjY0TMw4bWyyiwyey/T
	Z5sOO881r2lOksnbXvj4prN0GoeNmbo4CQ9Y5FoKzASu3Z/jIljrCpW494+G7yLDznlOa0lpaxL
	uPJ3k9PJKK4mjdQ5QjRnrFVeCKzfxrv+R8RdLKsGz0UgIjAFI4xnEWPSCYKTwnT+FATbH+onUmP
	z5oFR7SRNMdm/pSVkM0jw==
X-Received: by 2002:a05:651c:418e:b0:387:1ba5:99bd with SMTP id 38308e7fff4ca-38bf972b0e5mr41075501fa.27.1774294309955;
        Mon, 23 Mar 2026 12:31:49 -0700 (PDT)
X-Received: by 2002:a05:651c:418e:b0:387:1ba5:99bd with SMTP id
 38308e7fff4ca-38bf972b0e5mr41075301fa.27.1774294309455; Mon, 23 Mar 2026
 12:31:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318184400.3502908-1-song@kernel.org> <20260318184400.3502908-7-song@kernel.org>
 <b720f521-e930-4f35-9505-1bfdf9e2818c@I-love.SAKURA.ne.jp>
 <4DF5C4A8-7C92-4F76-9B34-2262089E7289@meta.com> <33abcf34-13e2-4a37-83f3-78bb27ecbc11@I-love.SAKURA.ne.jp>
 <F0A0D13E-8208-49A4-9AC6-89AC4BF3F4FB@meta.com> <20260323-klappen-atemschutz-7a0af8c6b087@brauner>
 <714a614b-cfb4-4b20-af8c-df3cc56dfb92@I-love.SAKURA.ne.jp>
In-Reply-To: <714a614b-cfb4-4b20-af8c-df3cc56dfb92@I-love.SAKURA.ne.jp>
From: Song Liu <songliubraving@meta.com>
Date: Mon, 23 Mar 2026 12:31:38 -0700
X-Gm-Features: AQROBzBKFBxWkFKdSZb6aDqln1iqdiuNWYNqj8Bk3Aj5pcgV1TsyMg6HDo5_J7A
Message-ID: <CAAeYb7k+TWArOKyOomkLZ8fwqUPjha9iORpJaj4nMyN=o4ZRQg@mail.gmail.com>
Subject: Re: [PATCH 6/7] tomoyo: Convert from sb_mount to granular mount hooks
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Christian Brauner <brauner@kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        Song Liu <song@kernel.org>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>, "jack@suse.cz" <jack@suse.cz>,
        "john.johansen@canonical.com" <john.johansen@canonical.com>,
        "stephen.smalley.work@gmail.com" <stephen.smalley.work@gmail.com>,
        "omosnace@redhat.com" <omosnace@redhat.com>,
        "mic@digikod.net" <mic@digikod.net>,
        "gnoack@google.com" <gnoack@google.com>,
        "takedakn@nttdata.co.jp" <takedakn@nttdata.co.jp>,
        "herton@canonical.com" <herton@canonical.com>,
        Kernel Team <kernel-team@meta.com>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "apparmor@lists.ubuntu.com" <apparmor@lists.ubuntu.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE0NCBTYWx0ZWRfX/9NxuVQkAApD
 RrgVNFmnYTdU/p1D5w486tRDiBpS0DsJWtMsYbzs36xMm0tGKwvWzgbgJtUHjddQTZCYi/+YCON
 me72xp6rfIAoIMbM81O1G5GngXNLq3+DXkHsgB2N/K6PrTsyf6dDmKkqKgRxveV7iHw6uyqUVqj
 VhagP0IlJvrMQQ7RSz0cidJGleJ9tbNY1HJ8k04HTB5CoIZcIHu68X8jJJ+y/QJlcy1j6nYzWKN
 xrwQ7oSGp6ZWZDP8LQQQ0IPyEcpaq3O6I9Wc/yymA1IRoKEGYdCp7wZrRR1nn4HqOlBUzb87itN
 8bz2KxynsKJiHG88E3TE/9qbHo9pW2acQlg8IEYX+0BUqep9ID0Wa51a2szC7ExQD45LoNSPnl/
 KzyEwRDxfKb+q8+ryTCvNeJ/wqnWvs7Mo24sBntl1j+kc+2wI5Ew5mEaz7u4AkGCW25vWzo2v22
 9fUmwuu0fBETZxAs4ng==
X-Proofpoint-ORIG-GUID: yK3TSPN6Ckgeb-hwvgX0TQD7fIvh7pDU
X-Authority-Analysis: v=2.4 cv=FZU6BZ+6 c=1 sm=1 tr=0 ts=69c19527 cx=c_pps
 a=7DXwzBV7yB9sQ64fpm0YNw==:117 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=tpM8CJlwf7uhpglF1g9U:22
 a=BqB2_f_Oa2Tj43kevx4A:9 a=QEXdDO2ut3YA:10 a=eI3u7fyX2kwyfkukwWva:22
X-Proofpoint-GUID: yK3TSPN6Ckgeb-hwvgX0TQD7fIvh7pDU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-23_01,2025-10-01_01

On Mon, Mar 23, 2026 at 3:33=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2026/03/23 19:16, Christian Brauner wrote:
> >>> Since not all filesystems need to resolve dev_name argument, conversi=
on from dev_name
> >>> to "struct path" is up to individual filesystem. If we can use a flag=
 like FS_REQUIRES_DEV
> >>> that tells whether that filesystem will resolve dev_name argument, I =
think we can resolve
> >>> the dev_name argument before security_mount_new() is called (and can =
avoid TOCTOU).
> >>
>
> I was expecting that "struct file_system_type"->fs_flags containing FS_RE=
QUIRES_DEV
> is a sign that the dev_name argument is a pathname. But it seems that suc=
h assumption
> no longer holds true. For example, cramfs started treating dev_name like =
"mtd$num"
> as if /dev/mtdblock$num since 4.15. So, current TOMOYO logic causes mount=
 request of
> cramfs with dev_name like "mtd0" to fail.
>
> >> I guess we can add dev_path to fs_context?
> >
> > No, when and how the path is resolved is entirely up to the individual
> > filesystem and we're not hoisting the block-based specific path lookup
> > up into the VFS while leaving the other stuff per-filesystem. And it's
> > not as trivial as you want it to be either.
>
> Then, how can LSM modules know that how the requested filesystem resolves
> the dev_name argument, without embedding filesystem specific resolution
> logic into individual LSM module?

IIUC, if an LSM cares about the dev_name of a new mount, it will have to lo=
ok
into each individual filesystem. We can add a LSM hook for the filesystems =
to
call. But this will require changes to individual filesystem code. OTOH,
dev_name can probably bridge the gap as we change filesystems.

Would this work?

Thanks,
Song
