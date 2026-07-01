Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703E5239085
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 23:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782948997; cv=none; b=kS/AEQqTS7v4lkOHfNdR37GTlUqX7MuN89Y8rihp5x6WuQdrKTOp6yTT+3D874+2vk0ettetnr0TEBhXo292gorBrTC+1/BU2N5BWfuYo2o+S9Nvzf9fc52TqHFGCSCoiWEya+VjBynMX/RqzbbPkih9zVVO6605WTNIM2Rr7yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782948997; c=relaxed/simple;
	bh=YTRXpdyXjtJ1Vaj8b6MwwldIqtEM8lOZ7c1h3xune5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aT7sM4wiGVCzrUuupcEQXd5uYvxg2kgoQJrr4TOIzj+FS4psCegtyMRnTk5URvYkR2rGOe9bPwWd+PWb5k4v+uOZxGGK3BWzsiJcN9M0zvQ4wf/eSRkAQgZ0TsJPQ2L+8R2rjo1wuYyaLC7LPIYQSDSKeHapnOL/5cbQ0nkaJN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ErsX5RiI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ErsX5RiI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35BA31F00A3D
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 23:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782948996;
	bh=Q9VXVUHaoyBRe6EMAKmPcZn+fhj9+EFJqR/22yida+c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ErsX5RiIcsLKBW9NUuuDFU5RkKUju+696969yAiwUr5iJec66r2wLlE8j5OFLykB6
	 ROIeKK37Hcl2DQ3DXNVxLpZFRu10XvCTl9pfn651iDp1w8Zjwq1vKa46CtIO8XGn6x
	 wv67PcF9S43Po17NgMTMd+B5DBD9eU0cTaERnzz9p35qkM3UE9WKsTZswutYxJhvjF
	 gAzRqQ7ZjffULaz1ruC3nubrmUzMMt+RTfBjKqH1sBVDiQgzUM0I41sbAkMAkM3Tpk
	 aSysBNZQSLmxyYMg3FIWzvhBNirIcYNog0AcsoHIju5uEKFSU84lIkMcWmAKej+dHq
	 lByMOJlF4LNkQ==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6984169c126so2274608a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Jul 2026 16:36:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+F9ADnW9pZ19mYLi83YM9k5g2g4LwBKkBdwunGacW05V1c5WQaolewK3bUWvZKypWhsy1vmo+X+winvEjd@vger.kernel.org
X-Gm-Message-State: AOJu0YwBQFH8Y3LZeFNmRTFob09wwh8O2/Hn45qQqfDelxr1AKPAikrI
	ZyDfkz9Z5JfkgprWqgPSukbS59SYB82Z9KAFfaftp+GBnBhvuzbENTL8M1QKEP7sa2mqhYhR6NV
	FbOzHchx+mJzKaTXJFyDe8Ag93dCY7QQ=
X-Received: by 2002:a17:906:584c:b0:c12:33a2:a634 with SMTP id
 a640c23a62f3a-c12aa193bccmr146138766b.52.1782948994867; Wed, 01 Jul 2026
 16:36:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701221237.822167-1-kudo3228@gmail.com>
In-Reply-To: <20260701221237.822167-1-kudo3228@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 2 Jul 2026 08:36:23 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-+EKp98S2WMWNfhX0+fNfq1_3QrdSsnw7uav0hWXdtNg@mail.gmail.com>
X-Gm-Features: AVVi8CeV2lCx3qrwNJkSaPKxyFni98jEp8oThBXrv26xdQ5ADGFGn6FamnomFs0
Message-ID: <CAKYAXd-+EKp98S2WMWNfhX0+fNfq1_3QrdSsnw7uav0hWXdtNg@mail.gmail.com>
Subject: Re: [BUG/RFC] ntfs: crafted image triggers WARN_ON in ntfs_map_runlist_nolock()
To: =?UTF-8?B?7J207IOB7Zi4?= <kudo3228@gmail.com>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 2, 2026 at 7:12=E2=80=AFAM =EC=9D=B4=EC=83=81=ED=98=B8 <kudo322=
8@gmail.com> wrote:
>
> Hi,
Hi Sangho,
>
> I found a crafted NTFS image that triggers the following warning during
> mount-time NTFS logfile handling:
>
>   WARNING: fs/ntfs/attrib.c:177 at ntfs_map_runlist_nolock+0x1275/0x17b0
>
> The observed stack is:
>
>   ntfs_map_runlist_nolock
>   ntfs_empty_logfile
>   load_system_files
>   ntfs_fill_super
>   get_tree_bdev_flags
>   vfs_get_tree
>   do_new_mount
>   __se_sys_mount
>
> The warning site is:
>
>   fs/ntfs/attrib.c:177
>   WARN_ON(!ctx->attr->non_resident);
>
> The caller path reaches this through:
>
>   fs/ntfs/logfile.c:677
>   err =3D ntfs_map_runlist_nolock(log_ni, vcn, NULL);
>
> The current hypothesis is that a malformed image reaches the $LogFile cle=
anup
> path and causes ntfs_map_runlist_nolock() to find a resident attribute wh=
ere it
> expects a non-resident one. Since the input is a crafted filesystem image=
, this
> looks like it should be rejected through an ordinary mount error path rat=
her
> than tripping a kernel WARN_ON().
>
> The crash was found with syzkaller/SyzDirect on a recent local mainline b=
uild.
> syz-repro reproduced the warning during minimization and reduced the sysc=
all
> sequence to syz_mount_image$ntfs. I also extracted the crashing program f=
rom
> the syzkaller log and generated a standalone C reproducer from it. The ge=
nerated
> C reproducer compiles locally.
>
> I have not yet confirmed whether this has impact beyond a mount-time warn=
ing
> from a crafted NTFS image. I can provide the full syzkaller/C reproducer =
and
> kernel config if useful.
I will check it and share the patch with you to get your confirmation.
Thanks.
