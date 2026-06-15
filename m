Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3109936A373
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2026 23:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781567876; cv=none; b=cVi6Zc4k1QMHx/9RC/oBNJ6E8JeCPQ70yLmwpXE9MXXEgw1z8/wJgwf1yTBRoluBcRdOfBs0w8K3xxn1RqHlhguA1W8xvbMBMjyyVge4aizydxhdYcsMKqQaB1HJHdRB75W1xGvA68CHcQB2ctP9uKLFu9Cbq7QI6QQyXWMlims=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781567876; c=relaxed/simple;
	bh=D5VpS27PIz7llIDWmXxfKoUtWbXk7xJ41hj8JSsNxpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e/vwHaNP5o7hYzCG7ufnSSGOqrumV6rmeOVwkiSptTL7HEpqrl7dzs7NP5fFH+ESccokU0EGzZLIPjhtXjw0WlNhzy4AYtYp1GBay967qYbaa8s9eDc2hhUi1zHAP4Dz72Z5smbVvO7h6w0DpDsSNRdEdNPRonicJPmi3q+dtU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgcJCd/J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgcJCd/J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E22981F000E9
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2026 23:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781567874;
	bh=3JEnIeafamhxprnHxKLmCF5h1bsCs+JDEZ3KZbgZ7yQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=fgcJCd/JZ2SGnVPx0unL0ZiyaGbRnY5tzChzphrwUSvM5/MjHjRmlGxD0OLF7vyHI
	 ldhvqXme4a1eocSWNh51Gm5FnWVhgXNqE6bZOv00My9tNbZNGvnlY5F4kYVV11g50z
	 yzB4GyArozn+DdvmkNnrSlkCm4bQYfVWpQ5Am72WA2VXMPCfrte5y8e+9F2UL5oZFe
	 nLlL816LM+J5ybMeCguneDEosadt7Hom/3Eyq56Pdh7LhvsK0O0FuR9WHNQ2KvPSB7
	 N2Az1XWY0iiSSAY7qTMConGQ0OQDVicEv4uuFX/5hqnQMBIWh2zhPsn3KTn8TrBFtN
	 BKZMXu10qNBiQ==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-bec449d0af2so468637366b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2026 16:57:54 -0700 (PDT)
X-Gm-Message-State: AOJu0YzV4ss36hIKVloTgag+vSkwuCE6splbvzFUJ+IT7UOJDaQLykfA
	TRNEYHErb1uarrTEPzxLSPHvUf00zftCIPSYVoHRSn271DTrqfgK2lCBAkSglmTwoEtTqNCDxj2
	efhA2qMP+3NYjT8E9LiNSYIBILjHzbgs=
X-Received: by 2002:a17:907:1987:b0:bea:3ebb:19d2 with SMTP id
 a640c23a62f3a-bff4c6f9410mr590163766b.25.1781567873696; Mon, 15 Jun 2026
 16:57:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615-topic-symlink-v2-0-648a769d01f8@gmail.com>
In-Reply-To: <20260615-topic-symlink-v2-0-648a769d01f8@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 16 Jun 2026 08:57:41 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8w=_w1mhO+b6n+tFjQQgUXW_8i-YFrNrQKKNtgobZ-bQ@mail.gmail.com>
X-Gm-Features: AVVi8Cemv0GJlI5NQHb4xr9lOJ-kzl5KMKrZ77bbhPoMxTkufgV9R358q_BmdQk
Message-ID: <CAKYAXd8w=_w1mhO+b6n+tFjQQgUXW_8i-YFrNrQKKNtgobZ-bQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] ntfs: Support Windows native symbolic links
To: Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 8:50=E2=80=AFAM Hyunchul Lee <hyc.lee@gmail.com> wr=
ote:
>
> This patch series adds support for Windows native symbolic links and
> introduces mount options to configure how symbolic links are resolved
> and created.
>
> Currently, the NTFS driver creates WSL-compatible symbolic links and
> has limited support for native Windows symbolic links. This series
> addresses these limitations.
>
> 1. Following/Resolving Symlinks & Junctions:
>   - Add support for parsing and following Windows native symbolic links.
>   - Introduce the "native_symlink=3Draw|rel" mount option to configure
>     absolute target resolution.
>
> 2. Creating Symlinks:
>   - Introduce the "symlink=3Dwsl|native" mount option to choose the
>     creation behavior of symlinks. Under "native", Windows native
>     symbolic links are created by converting the target path to UTF-16
>     Windows format.
>
> 3. Fixes & Cleanups:
>   - Fix an issue where the size of symbolic links is reported as 0.
>   - Clean up target name conversion for WSL symlinks by avoiding
>     redundant conversion.
>
> 4. Documentation:
>   - Document the newly introduced mount options in ntfs.rst.
>
> Changes since v1:
> - Add a boundary check to verify that reparse point attribute size is
>   at least the size of the `reparse_point`.
> - Fix target inode fields (`reparse_tag`, `reparse_flags`) not being
>   updated `ntfs_reparse_set_wsl_symlink()`,
>   `ntfs_reparse_set_wsl_not_symlink()`, and
>   `ntfs_set_ntfs_reparse_data()`.
> - Improve absolute path validation in `ntfs_reparse_set_native_symlink()`
>   by ensuring that absolute paths actually start with a valid drive
>   letter and a path separator.
> - Optimize memory allocations in `ntfs_reparse_set_native_symlink()` by
>   sharing the same buffer for print name and substitute name in the
>   relative symlink path.
>
> Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
> ---
> Hyunchul Lee (7):
>       ntfs: fix incorrect size of symbolic link
>       ntfs: support following Windows native symlink with relative paths
>       ntfs: support following Windows native symlink with absolute paths
>       ntfs: add native_symlink mount option
>       ntfs: clean up target name conversion for WSL symlinks
>       ntfs: support creating Windows native symlinks
>       docs/fs/ntfs: add mount options to support Windows native symbolic =
links
Applied them to #ntfs-next.
Thanks!
