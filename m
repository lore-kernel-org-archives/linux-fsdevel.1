Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38809EEC0
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jun 2026 05:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782710298; cv=none; b=SnSO++OmIf+5+vxXpAZUpvKKv7egxZyRhxruY7YB8J7IinzIhSbWluvCmQMgMq+uYAAHrQ3PildGt03eSiLZhAwyabbEK+yxaJQYpaMlf1VX2z5pHe5FFFbgqhzU/ucsPXAB5jVQzxCYNR69hxNB7E598gmntx3wZ7X7S1VvWNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782710298; c=relaxed/simple;
	bh=9MZcaXB8tkb4w+nk67Ld3i8wZd5kQw41E1xpTgUy/ZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OZWt7c1JMu2qdyLtj1g4zazQ5HzNw+M8msBWuUvlFCE1qTQBaZHQUlHn6HP9gI1x66Wfw2qZdxl6dOTvUKfrGiNXBw1umCdzfqHsor7J86WFfHemRY7pyKqvHrEWKiCOl2M2a82lGk9Nxz8eMgZ9B/Gub5d7UnNv7QfFllpxeCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GjpFOcyK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GjpFOcyK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E72D41F000E9
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jun 2026 05:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782710296;
	bh=9MZcaXB8tkb4w+nk67Ld3i8wZd5kQw41E1xpTgUy/ZE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=GjpFOcyKd+Vfq6BsEe6kyWi2jzDbnwqb0JGybs0Q3eVTx8CjAHdp/evMIbWKSKDq7
	 fyZs3xrVFxYyEhqSdM4avq78Pze34nDy+WK9QHJo6jwq5B/Sa84XWscpPSdd9HbrlT
	 zY8uywVHNywcA7/NydpGKCAD1EeH46avhXv2X3i5AqEH2dlNXNW5G8W+HfZ+QnxOKw
	 rWLYzF0vX++bpgPdFsFUQID3q7ByC818uyTmP2yO5iTT9vSyjdp2FdpfT29p5SRkQb
	 PLou0UH6YYmtGpVrGgQfQ3jbeoe4q28Z3dCXauYOaUoE3inb3IgmnMSIF5t/6sYLo5
	 M22wlDrTiIuKw==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c126fe7d0f3so33726566b.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Jun 2026 22:18:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrvmFy2La0y3CLjYojsvf2usy4O0i1IzFVAyU5rGHVIQozW/vqCAgaevt7i2lL5VhVpeU5a2inXIBvD6jCx@vger.kernel.org
X-Gm-Message-State: AOJu0YznFm1375Hmecxm/K32+VdHmXnG8qmWXPT2nuyZP10E42mUeujB
	7j200NWuRBYK2y2Wx1Q9ylS7OrxIrTS3gXNcZuP140BCoPSx+gxZqOP/XPgkjDI7K3xSfGWJ8Yz
	PjyLD47ZA3UM4pRwC6zyb+Uc+3jg3zDo=
X-Received: by 2002:a17:907:c706:b0:c07:43ed:1b3e with SMTP id
 a640c23a62f3a-c12330fa0famr414692666b.0.1782710295692; Sun, 28 Jun 2026
 22:18:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <C4D296F0E9F3D66C+9397ffbc-eb55-44bb-9b3f-5da4809e7955@smail.nju.edu.cn>
In-Reply-To: <C4D296F0E9F3D66C+9397ffbc-eb55-44bb-9b3f-5da4809e7955@smail.nju.edu.cn>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 29 Jun 2026 14:18:02 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_XUHGKfJsZpZ7ZGpe8icvJZRWrjuU9D3H3XgauYhV_Ow@mail.gmail.com>
X-Gm-Features: AVVi8CfbNW-rtZriSFxMSIxSm9eVfced5f1sN1Egy7Ba8Akqx613qGQ6bN_tWKE
Message-ID: <CAKYAXd_XUHGKfJsZpZ7ZGpe8icvJZRWrjuU9D3H3XgauYhV_Ow@mail.gmail.com>
Subject: Re: [BUG] ntfs: mrec_lock ABBA deadlock between writeback/fsync and rename
To: Peiyang He <peiyang_he@smail.nju.edu.cn>
Cc: hyc.lee@gmail.com, syzkaller@googlegroups.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 1:25=E2=80=AFPM Peiyang He <peiyang_he@smail.nju.ed=
u.cn> wrote:
>
> Hello Linux kernel developers and maintainers,
Hello Peiyang,

>
> We found two task hungs in the new NTFS when fuzzing with Syzkaller.
> After our digging, we believe both hangs are caused by the SAME AB-BA typ=
e DEADLOCK issue,
> so we report them together here.
>
> Title of task hung #1: INFO: task hung in __ntfs_write_inode
> Title of task hung #2: INFO: task hung in ntfs_inode_sync_filename
>
> Kernel version: commit 8cd9520d35a6c38db6567e97dd93b1f11f185dc6 (tag v7.1=
).
> And we believe the bug is also possible in the current mainline.
> Note that the code line numbers in the following analysis are also based =
on this kernel version.
>
> Relevant kernel config: (the complete config is included in the attachmen=
ts)
Do you have a suggested patch you can get credit for?
Thanks.
