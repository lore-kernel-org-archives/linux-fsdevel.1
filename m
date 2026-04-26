Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE1F17C211
	for <linux-fsdevel@vger.kernel.org>; Sun, 26 Apr 2026 12:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777205165; cv=none; b=E0+o5ndGtEtDHUGRcBS+PJlqCadhohBpyPpXQyjYTzJrPB2d9HwZ4aMeZH4tg7Dvw3iJTTiT9hOEuQtMVZ6g2nI0rJ4MIZPb6C4E9F+TKtGTPGIIP62iu5GExeBUWsnRd6IaA9yy3b4SJLkZ9lgErMifVmI7XiD6TIxHe+07Rao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777205165; c=relaxed/simple;
	bh=BC9w8CCVLNqAzvDdLE27loBD2Dj5j+TWuqg5hgAg+r4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WjVktomMkw4ZEdVjdhndzxyV8TLHx8T0Hezn7QZjPMCsCxuI01PPT3A4utazfjpPlsb0MDiho2M3kFnV5AztZI5VBHyU8aWoEDgPqVsySJG8LDh2zGs4HSBmqVm91zKGyjLjWSmpmjyO6TEV06IVTrrD0biZ2oggm2A+osmGYS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oe8p+RRS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oe8p+RRS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD242C2BCB9
	for <linux-fsdevel@vger.kernel.org>; Sun, 26 Apr 2026 12:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777205164;
	bh=BC9w8CCVLNqAzvDdLE27loBD2Dj5j+TWuqg5hgAg+r4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oe8p+RRS3qHznBoGD/GdEaigaUnFBLnhEwSiCYF2SCERiOQRHeE57xD5FlJZgap9v
	 eQlYzLdecCbDppdzOg5zbHh+HGE2pQzqtsWi7nae38IeQQRgAPS1uhL3nmZGh3mSok
	 XW5eBsXs92y2CT9MTpabcpRzXyhO+geyrh0JM+csDIIDFc9A85BYbwF3U5n5imeuZA
	 Xu0ICNaAdxgFNeCEGutHd9iWNOqo5zwJk8XYMxn7FOwJuvu4L3S/Km75dC2KMLnYxD
	 VvsQizEwGEQokbhwQjHL/iz6Bffl/kGXIJAaxfihin13tBdFmwrRsOMR/Ecapb+Nkg
	 C+RGOA5V0emwg==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-67389cf78b0so16387142a12.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Apr 2026 05:06:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/JmUW3Q63XvXY5dyxm2Wzyi06lVFH4/B3v+7zqWhbuzjoOBA5QGoKxyezaO1EV7xNfqNIRX/L0ukEOAwCP@vger.kernel.org
X-Gm-Message-State: AOJu0YyNbWX9UTxTFvCW08YjPUwkfr+lIWmgHJd8+30ahTObrOjk24YF
	q6Q1BD21Kw4W+yCxhgby5tJp74H+DWscb7USPzV3xj+JjvEIb/ePdx8nPTmo4GR+BI/Pg5KxkRx
	dYxHIgazp1WoF3NM/WIbTr66+rlYTapA=
X-Received: by 2002:aa7:d388:0:b0:670:7c64:c24d with SMTP id
 4fb4d7f45d1cf-672bfd86d7bmr12494498a12.6.1777205163347; Sun, 26 Apr 2026
 05:06:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777175371.git.charsyam@gmail.com>
In-Reply-To: <cover.1777175371.git.charsyam@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sun, 26 Apr 2026 21:05:49 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-2+T9gQgiGwDckinx1K9Pp5HfmOVD8hmkbWxp3SNwc7A@mail.gmail.com>
X-Gm-Features: AVHnY4ICok21z4-fUJMPQSRe_Hyv9ykVgYfXbKZobwKgNH9r6exUT_PiEViKAVQ
Message-ID: <CAKYAXd-2+T9gQgiGwDckinx1K9Pp5HfmOVD8hmkbWxp3SNwc7A@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] ntfs: fix index walk NULL deref and WSL symlink leak
To: DaeMyung Kang <charsyam@gmail.com>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 26, 2026 at 1:02=E2=80=AFPM DaeMyung Kang <charsyam@gmail.com> =
wrote:
>
> v2:
>   - 1/2: switch IS_ERR_OR_NULL() to IS_ERR() in the walk_down loop
>     (Namjae Jeon).
>
> v1: https://lore.kernel.org/all/20260425184243.116396-1-charsyam@gmail.co=
m/
>
> Two independent fixes for the new fs/ntfs/ that landed in v7.1-rc1.
>
>   1/2 fixes a NULL dereference in ntfs_index_walk_down(). When
>       kvzalloc() for ictx->ib fails, or ntfs_ib_read() fails mid
>       traversal, the function previously returned a state that
>       ntfs_index_next() and ntfs_readdir() could not distinguish
>       from end-of-directory, and ntfs_ib_read() itself could write
>       through a NULL ictx->ib. Errors are now propagated as
>       ERR_PTR() through ntfs_index_next() up to ntfs_readdir().
>       Reproduced with failslab fault injection on getdents64; the
>       reproducer is described in the commit log.
>
>   2/2 fixes a target-string leak in ntfs_reparse_set_wsl_symlink()
>       when ntfs_set_ntfs_reparse_data() fails. Also switches the
>       kvfree() on the local failure path to kfree() to match the
>       kmalloc() done by ntfs_ucstonls().
>
> The two patches are independent and may be applied in any order.
>
> DaeMyung Kang (2):
>   ntfs: fix NULL dereference in ntfs_index_walk_down()
>   ntfs: fix WSL symlink target leak on reparse failure
Applied them to #ntfs-next.
Thanks!
