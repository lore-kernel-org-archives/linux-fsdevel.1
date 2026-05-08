Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EAE3EB7FA
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 May 2026 14:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778250121; cv=none; b=nc3MRDMniSYgA1k3WXpNjOcuhXs+RhhNx4MMTTwOoXmFEFsvs6/8zLYEqJHJqMtYme+kR4l3+p9BG2NPfP5jIRjRKFa3NqaQKTnk1oQApK4SRpO4nlrqjSjYJvh11RjTHeglWAmyORblWcOPTqTMQ5doB+Gm4jobWWMRXziyfVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778250121; c=relaxed/simple;
	bh=nkRtOEf+E2kmbnl/ZnfR1q7JLb3NujZOaaXeYMoi6KU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nI/iJqe/th3TVu9SWVOTVMtqVuHGUNiW3R3JDzP5UlQSxe0jYVhTK9KW3R5OZGqt5hcPuPk5WztReymZuiQo1Q5JYQjx5PIin724E99bPeT8SHsJvdaDWQoLcG5Nvyd+TZ3hz/+r5+D2H1GyeEwNMnnPPXLeglulnQVqK8O8+K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZmxPEawo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZmxPEawo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03CBFC2BCC7
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 May 2026 14:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778250121;
	bh=nkRtOEf+E2kmbnl/ZnfR1q7JLb3NujZOaaXeYMoi6KU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZmxPEawoUy5TW3e0+vMLPBGz6D6nmkVhm7LgWXh47BrtkIRSYJyP2dvYlnPL9pTXf
	 XCXPo4TfOoFITQLfHVGdLB09GKiUlONXaCyRcTTjt9wKRgJurA4IVJu704zJaXnsIP
	 uX+qUNloQCaRGMLqS4Bak1ICghv2Thmrt+x+MAqn7/eBF1c2TO7gHiA7/ZdIcyHVRf
	 zJYtAAlhEG9v3JcHyQmbJKgitc/ztGUH3flGn8VLKrN1SVkxKPhrEnDG+YLzZwBiR3
	 hgaBFoAxQASpT91bJamC++8dnWyM6p5eaLCb4LfjOBUwjXoj8UjmR57DZ8yBLmuwTq
	 rlGeiQsfw33NA==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-676a89de629so3326528a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 May 2026 07:22:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/J9dI12aUg9Zifg3FhRmhUdVqY1eKlnq/B8XMaAV+TcZib2C9vMi817MUQfbHjA30aLlZhSRM07GArIZAy@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6o/U7zF6AKvNzeJ9daZmY8m5Z/qZak5nWYARnuLkY2Zveg3Pe
	ioXCYKvhS5g4CPjmqtBRYiNzFy1r5tb2sO0tcTw+jHciSLnwK808JrEqmnS6ERqP9iXceGfsAiO
	ER40f+1KAC93gv2WyCirDibyyGLVHtk8=
X-Received: by 2002:a05:6402:278c:b0:67d:a63a:deb1 with SMTP id
 4fb4d7f45d1cf-67da63adf40mr5848439a12.5.1778250119566; Fri, 08 May 2026
 07:21:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507154852.1721710-1-charsyam@gmail.com>
In-Reply-To: <20260507154852.1721710-1-charsyam@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 8 May 2026 23:21:46 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9zuxef_7ZgMDVmK-JqK5vo_8s9Q=QdLuA7hPj82C=4LA@mail.gmail.com>
X-Gm-Features: AVHnY4Kuffzo54HoUAzeGb1MxndYHGNfNXadhbMnrPQRZDwmI4zwy1DnnJGhXKo
Message-ID: <CAKYAXd9zuxef_7ZgMDVmK-JqK5vo_8s9Q=QdLuA7hPj82C=4LA@mail.gmail.com>
Subject: Re: [PATCH] ntfs: avoid leaking uninitialised bytes in new security descriptors
To: DaeMyung Kang <charsyam@gmail.com>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 8, 2026 at 12:49=E2=80=AFAM DaeMyung Kang <charsyam@gmail.com> =
wrote:
>
> ntfs_sd_add_everyone() builds the on-disk security descriptor for a
> newly created file by kmalloc()'ing a buffer and then partially
> filling it in:
>
>         sd =3D kmalloc(sd_len, GFP_NOFS);
>         ...
>         sd->revision =3D 1;
>         sd->control =3D SE_DACL_PRESENT | SE_SELF_RELATIVE;
>         ...
>
> The buffer is then handed to ntfs_attr_add() and persisted as the
> SECURITY_DESCRIPTOR attribute of the new MFT record.  The descriptor
> covers a relative security descriptor header, two SIDs (owner and
> group), an ACL header, and a single ACE, but several fields inside
> those structures are never written before the buffer is committed
> to disk:
>
>   - struct security_descriptor_relative
>         @alignment              (1 byte)
>         @sacl                   (4 bytes; SE_SACL_PRESENT is not set
>                                  but the offset still reaches disk)
>
>   - struct ntfs_sid (3 instances: owner, group, ACE.sid)
>         identifier_authority.value[0..4] (5 bytes per SID, 15 total
>                                           - only value[5] is set)
>
>   - struct ntfs_acl
>         @alignment1             (1 byte)
>         @alignment2             (2 bytes)
>
> That is 23 bytes of uninitialised slab memory persisted to disk for
> every new file or directory the legacy ntfs driver creates.  The
> "+ 4" trailing accounting in sd_len holds ace->sid.sub_authority[0],
> which the existing code does explicitly write to zero, so it is
> not part of the leak.
>
> Anything later able to read the SECURITY_DESCRIPTOR attribute - the
> same NTFS volume mounted on Windows or by another NTFS reader, an
> offline forensics tool, an unprivileged user that ends up with read
> access to the volume - can recover those bytes.  The leak persists
> for the lifetime of the file on disk, not just the lifetime of the
> kernel that wrote it.
>
> Switch the allocation to kzalloc() so every byte the on-disk
> descriptor covers is zero before the explicit initialisations run.
> While there, replace the bare "return -1" allocation-failure path
> with a proper -ENOMEM so the error reaches userspace as a meaningful
> errno instead of an unrelated -EPERM.
>
> Found by inspection while auditing fs/ntfs new-inode paths.
>
> Fixes: af0db57d4293 ("ntfs: update inode operations")
> Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
Applied it to #ntfs-next.
Thanks!
