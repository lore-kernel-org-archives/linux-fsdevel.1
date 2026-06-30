Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CD73019A9
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 14:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782829487; cv=none; b=o8jyDkQ4TqGJwRx+7MCiEPzPI5x+tewrIArPj8ijKqU4mQ6zGv1tDJCJoLZP2n9A8Sw2S85+X+t+RYiCrmUICzLt4Eo4rltzOVNBzhw6+WCkFnqDehwlCw/TNBABD+vX66chNFK8SWjXR5EFkkDfcyNjGtBoF6ecPRjkYhG557o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782829487; c=relaxed/simple;
	bh=ttHNQJ6LLPbp8LlZzsGWR60+yvCIT3w/tlx6dnEyYG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TBsGidJa7ywjz9Kmti+TkBqq7BuD0RrVkykksp9aYKl9XDWnNMEN7ds3KelPhjnNoKG27WgGbfvRGsnvzDz2URpBbjUVT/GbQwzApK/2UL0AIPqRI6IDyJPlUQ4RoPQ8Dg45hiNCETvNZP822XFXEsCUxCkXKSboSHAqNyXb6+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZqIWd7A7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZqIWd7A7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C3561F000E9
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 14:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782829486;
	bh=ttHNQJ6LLPbp8LlZzsGWR60+yvCIT3w/tlx6dnEyYG4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ZqIWd7A7DwQLPR8w68uGyXLFWyEXmpuzXrk7GapQLZ7Pf4tKR1cKzjs1U3ENFFTxK
	 YT/vFOIlPnjnGCTqp7qMlgprCb1+FPV83ty5Vyi7Qhs8t3FusqWTNXqMlY5U3hUCPm
	 uJ0DvghCfQ4JGvt1ZDsm/gRv35UnCV3aFs3hVqd6Cz/CP7gWyIWuyjRlZ3kRIpDWmG
	 XEpqCpr4ZJWZW1A20R/3R701q6a8o3YE4sc0TfRF4Zk9cA9TP8EaLGcl6LyXMkyoru
	 QcCOir0TliOx8Fe91eo9l3uLowelDwOlHvCpGjoimJxFq7Kaq+xICDF/RpzxTHybLb
	 4vuoHfxRJoggA==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c029505b389so97892866b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 07:24:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rrn8fzVJj3vYvWFMy1/7/Y7Z7RvH/IPZrWRTECSipvKcjYt8+74lcjTrfX7T9LUX++wr2IFbNzBcSkvOrkW@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4StwsYHNbJc1PYWTMdxPZDFv6OEMnrKZyssiKjmB0jR4H9wTz
	JWcrfYT7CpRjCUrq4CXG9vayclO9fNo6+RLeXaavbpoJXt/SPrkyVYWz73KgxG+fqS/Qy/VvQDI
	XgVYgrVgmQpp4mz3mItV/6lObs/pE32U=
X-Received: by 2002:a17:907:6ea9:b0:c0d:7c31:26a9 with SMTP id
 a640c23a62f3a-c12903c0660mr131595966b.2.1782829485135; Tue, 30 Jun 2026
 07:24:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <E1CB185090CF6721+20260630030856.2210012-1-peiyang_he@smail.nju.edu.cn>
In-Reply-To: <E1CB185090CF6721+20260630030856.2210012-1-peiyang_he@smail.nju.edu.cn>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 30 Jun 2026 23:24:32 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8QFKFrx_9VsEjv-WRDKwFM1SKaWnR8w2X0AgXdy42yFw@mail.gmail.com>
X-Gm-Features: AVVi8CedrEkdCyh9pQM37Epv9fb4Zg4c-G1vQz4e1fqILJD2jmBHiKW-eTQyQyg
Message-ID: <CAKYAXd8QFKFrx_9VsEjv-WRDKwFM1SKaWnR8w2X0AgXdy42yFw@mail.gmail.com>
Subject: Re: [PATCH v2] ntfs: fix mrec_lock ABBA deadlock in rename
To: Peiyang He <peiyang_he@smail.nju.edu.cn>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, syzkaller@googlegroups.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 12:09=E2=80=AFPM Peiyang He <peiyang_he@smail.nju.e=
du.cn> wrote:
>
> ntfs_file_fsync(), ntfs_dir_fsync() and __ntfs_write_inode() lock an
> inode's mrec_lock before taking the mrec_lock of its parent directory.
>
> ntfs_rename() takes old_ni->mrec_lock and old_dir_ni->mrec_lock
> before taking new_ni->mrec_lock for an existing target, or
> new_dir_ni->mrec_lock for a cross-directory rename.
> This can deadlock when ntfs_file_fsync() or __ntfs_write_inode() holds
> the target inode, or when ntfs_dir_fsync() holds a child target
> directory, while rename() holds the parent directory and waits for the
> target.
>
> Fix this by locking the existing target inode before taking any parent
> directory mrec_lock. For cross-directory renames where the target parent
> is a descendant of the source parent, lock the target parent before the
> source parent so the directory order matches the child-to-parent order us=
ed
> by ntfs_file_fsync(), ntfs_dir_fsync(), and __ntfs_write_inode().
>
> Reported-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
> Closes: https://lore.kernel.org/all/C4D296F0E9F3D66C+9397ffbc-eb55-44bb-9=
b3f-5da4809e7955@smail.nju.edu.cn/
> Fixes: af0db57d4293 ("ntfs: update inode operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
> Assisted-by: Codex:gpt-5.5
Applied it to #ntfs-next.
Thanks!
