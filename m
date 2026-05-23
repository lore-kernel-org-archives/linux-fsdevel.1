Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEDE39A064
	for <linux-fsdevel@vger.kernel.org>; Sat, 23 May 2026 13:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779542791; cv=none; b=EB1Ti5FbbCOJHQFrC1MUKlUF8Cz+0hs4NLLhVzbStozOtptzSdKWZ2Ucwfj3Cmgly4OGvtdyppB+zK5hBB8kbj24mY5UMBAijjhuF2jQ+Cy1cFBWuNaTaQ+CWAgo8aisYQkSYFVd01AU6P3dwwnvHYQJlS19jy5Mxebcmu2URJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779542791; c=relaxed/simple;
	bh=z1fyR0ugvTus5sJY03WvGTLv6pUSvIKhLTuszjXrHV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l9AFjSr1nqu3nbzzs3xwBpgV88BCWBEam7ZdgM7JEuFuGhCLta/q42lzmKqIYBLvUFkZfV5pUwBiENAkgE8h1uZc0xm+NvDZrnAIh2IyqIJTaEscop1YrzlYU1YhIGyKhhL3JXHyCyv/SgmNoZBbOSVNNHnTg6yRbhN3r4Tonko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJRjog4p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJRjog4p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FB481F00A3D
	for <linux-fsdevel@vger.kernel.org>; Sat, 23 May 2026 13:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779542789;
	bh=TzB/RqYX2rq8oM/20m22L1bAU2PuZrcxwRT+sBZHQL4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=XJRjog4pYAwrAwNuNyMnOXQk5e0qXMzNi8OZMWYVF+g3FTuKEZ9lBwzGT9Ub+SGrt
	 CqS6iTSvltGiC8rOZFWTdJ+0WW1XwFdPVMBe8OsSa7Mf8e+O9yB1WVCAiMcilus+Eq
	 cR7i6r5NDNu1o37xqJISgJkhVlNPRg/nDhq68HBt8XmFX8LXCJI9GxMc10f5ROkbjX
	 nD8DzavvbPb+Ul+6+nZQ0wDOvWtmS31WblXIws5Cbn9E7vHmqPbPn5KFyWcAiwi0EQ
	 0kuOAHtiz/52dFz2DdTCv8Qj5KfmCMqF9Ke0UYrLfJKiABycLXsj0i8DH1JpyyiQfk
	 n8Gj6EHzKoCyw==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-bd124546379so1294466566b.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 May 2026 06:26:29 -0700 (PDT)
X-Gm-Message-State: AOJu0YyYvyH4pcrccrWI/wk1sfJHcs8esve42uOJbTi36sjF8qvpE47E
	zCG6T75/cSuLnkeMg3PTmnmvF/JNRRNkOzU4DeRhkgSm6LN1yET69cfuaUXF/Z912HSpF7okdhh
	I+IRQrzZu8LkqtK7GgV7mDhbn1duCMWY=
X-Received: by 2002:a17:906:6a0b:b0:bdb:e19d:525c with SMTP id
 a640c23a62f3a-bdd262d1b83mr453429066b.33.1779542788196; Sat, 23 May 2026
 06:26:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521053703.1850487-1-hyc.lee@gmail.com>
In-Reply-To: <20260521053703.1850487-1-hyc.lee@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sat, 23 May 2026 22:26:15 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_BoSQPRWGQj1fsN9XVshc=Zz0zOUzLJCXsoOmPkCD87g@mail.gmail.com>
X-Gm-Features: AVHnY4ICqSQp5CUuhMzRP65mHDSYwRXxy6SPHuR5WZN-naCWhq8SgOOXZon4m3E
Message-ID: <CAKYAXd_BoSQPRWGQj1fsN9XVshc=Zz0zOUzLJCXsoOmPkCD87g@mail.gmail.com>
Subject: Re: [PATCH] ntfs: skip extent mft records in writeback to prevent deadlock
To: Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	cheol.lee@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 2:41=E2=80=AFPM Hyunchul Lee <hyc.lee@gmail.com> wr=
ote:
>
> This patch fixes the ABBA deadlock between extent_lock and extent
> mrec_lock triggered by xfstests generic/113, that occurs since the commit
> 6994acf33bae ("ntfs: use base mft_no when looking up base inode for
>                 extent record").
>
> Path A (inode writeback):
>   VFS writeback
>     -> ntfs_write_inode()
>       -> __ntfs_write_inode()
>         -> mutex_lock(&ni->extent_lock)
>         -> mutex_lock(&tni->mrec_lock)
>
> Path B (MFT folio writeback):
>   VFS writeback of $MFT dirty folios
>     -> ntfs_mft_writepages()
>       -> ntfs_write_mft_block()
>         -> ntfs_may_write_mft_record()
>           -> holds one extent mrec_lock from a previous iteration
>           -> tries to acquire another base inode extent_lock
>
> By removing all extent_lock and extent mrec_lock acquisition from the MFT
> folio writeback path, the ABBA lock ordering is eliminated:
>
> Path A: __ntfs_write_inode(): extent_lock -> mrec_lock
> Path B (removed): ntfs_write_mft_block(): mrec_lock -> extent_lock
>
> Path B is always redundant for extent records because:
>
> 1. mark_mft_record_dirty(ext_ni) does NOT dirty the MFT folio.
>    It only sets NInoDirty(ext_ni) and marks the base VFS inode dirty
>    via __mark_inode_dirty(I_DIRTY_DATASYNC), which triggers Path A.
>    Therefore, normal extent modifications never create a situation where
>    the MFT folio is dirty and Path B is not scheduled.
>
> 2. The MFT folio only gets dirtied via ntfs_mft_mark_dirty() inside
>    ntfs_mft_record_alloc(). But all identified callers in attrib.c
>    (ntfs_attr_add, ntfs_attr_record_move_away,
>    ntfs_attr_make_non_resident, ntfs_attr_record_resize) follow through
>    with mark_mft_record_dirty(), which triggers Path A to write the
>    complete record.
>
> 3. ntfs_evict_big_inode() calls ntfs_commit_inode() before freeing extent
>    inodes, ensuring all dirty extents are flushed via Path A before the
>    base inode leaves the icache.
>
> Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
Applied it to #ntfs-next.
Thanks!
