Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC1942DFEC
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 12:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782907641; cv=none; b=JJrmFiWn+SkYX/k9EETuds7zygWeWS8Hdj2id1IVvVMM7T83l02bEAm0Z4nIfEu7Z/k32AkgVt9TV9yRYKZzlgcnSsKEalIvAALQvi66vhEYeIALOIZ5De0xKal6qlrDx6Y8D3UUlxuQ6h3WkwAHEbV+7rzHYguKUMpURBLdCrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782907641; c=relaxed/simple;
	bh=wCq64Y0kRtiq6eUMljgSMSNHwXvckxrEO0Dng1ooNhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YtT6BaOXJiTZ9oPkZ40WUZ+AnYoX1BVblZUNK0fSnwwzB+DhUI7Gu3toBht4DIFBUnZcX5tk0iZqsfeS79TTKaPTfx/K8f2n8lCjCKd2kVM2QFI439SZbcEGbjQR0RxwFdzmyWQoDTtsUzryd4oROnOQHSbmXOi9o1qQ58P6WTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDQHeo3/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDQHeo3/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1EC61F00ACF
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 12:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782907639;
	bh=oDjyJOhVV/DIa1FT4XMf4XzZgQ7suZF9JyO1C4a9jok=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=KDQHeo3/JqLVFoCitCzp6OVzHHxgCUuUBL2Z6ca5N0Vb8LORFgCSHBQbMDE9411s7
	 4cvdbRNJd2c/A4u/WoJOsZG/FuDcdo4cEuLGHUhbptCSwACwGROKFyrRhM6nDGwx9a
	 v+RVNKovVutgVgKb0Os9ycLKQ4savFgbyqZE0Iei3roaVj2HddVeEq6dRrjeeN+Tna
	 ITZ/Wdu4k8kRScrTTtEo0N0Gz7ulsesWzQOkUgFrPhpTXkJJnl2Z5hv+XDjmYY5yPq
	 tIq9V2Vz23Bok7Ou1rJ++ylTjgrEMaAbZv07xv3XWf2ISlqRN9pcGnIlIFJMEBUx0P
	 DnVh3EJp1Tdag==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c1276f8414bso74855966b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Jul 2026 05:07:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrMet6MuYNnqxiSBLSuWBcZbx6KUfFpryUzoEqdJoJQpzgQ82AR9zSz2MqHrBLItrGEq1ZalgDUbSqTvscs@vger.kernel.org
X-Gm-Message-State: AOJu0YyjjmEHx9ewkVAgNEA/WYb4VDSYeOhqgLHT8EsBIjCXexFX1Urh
	SCHSw5TGqCqm9N8QCLAAYp1LD0jDCQ6rIqRpYetkl9sOdUKtBgyc4izNkK6Wko8iscWzAUDXb+a
	zhj21q7RLT8KAWEgscIne5PfoHTfA2AY=
X-Received: by 2002:a17:906:6a27:b0:c12:4e0a:458a with SMTP id
 a640c23a62f3a-c12aa39aef2mr66605166b.63.1782907638561; Wed, 01 Jul 2026
 05:07:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701074233.67855-1-zenghongling@kylinos.cn>
In-Reply-To: <20260701074233.67855-1-zenghongling@kylinos.cn>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 1 Jul 2026 21:07:04 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9dak9xFPVt7q=WnBJ8wRD7ohUsXREJTzUFhbjL4SJq=g@mail.gmail.com>
X-Gm-Features: AVVi8Ccj17gzZptYQI0HPoZznvfuM64l2h-LUKu162Gtj2-yzQVPUp1JzPhc55k
Message-ID: <CAKYAXd9dak9xFPVt7q=WnBJ8wRD7ohUsXREJTzUFhbjL4SJq=g@mail.gmail.com>
Subject: Re: [PATCH v4] ntfs: validate error codes from untrusted disk data
To: Hongling Zeng <zenghongling@kylinos.cn>
Cc: hyc.lee@gmail.com, charsyam@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhongling0719@126.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 4:42=E2=80=AFPM Hongling Zeng <zenghongling@kylinos.=
cn> wrote:
>
> ntfs_lookup_ino_by_name() returns MFT references read directly from
> disk, which are untrusted data. The current code extracts error codes
> via MREF_ERR() without proper validation, allowing maliciously crafted
> NTFS images to trigger kernel panic.
>
> The MFT reference encoding uses bit 47 as an error indicator, but the
> lower 32 bits can contain arbitrary values. If a malicious image sets
> the error bit with a positive integer (e.g., 1), MREF_ERR() returns
> that positive value. Returning ERR_PTR(1) causes VFS to treat it as
> a valid dentry pointer since IS_ERR() only recognizes values in
> [-MAX_ERRNO, -1] as errors.
>
> This leads to kernel panic when walk_component() =E2=86=92 step_into()
> dereferences the bogus pointer at:
>     struct inode *inode =3D dentry->d_inode;
>
> Fix by strictly validating error codes: only accept negative values
> in the valid errno range [-MAX_ERRNO, -1]. Convert all other values
> (positive, zero, or out-of-range) to -EIO to indicate disk corruption.
>
> This prevents potential security issues and ensures proper error handling
> for corrupted or malicious NTFS filesystems.
>
> Fixes: 1e9ea7e04472d ("Revert \"fs: Remove NTFS classic\"")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
> Suggested-by: Namjae Jeon <linkinjeon@kernel.org>
Applied it to #ntfs-next.
Thanks!
