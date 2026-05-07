Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A53D391E5F
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 May 2026 12:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778158422; cv=none; b=LvWo2lKRCEsbZhi6fw2KhRSmlwrsc6gYTUmGdC5xPV3kYohzpncPenNpyDo4EBp+S83CgSGLXrSBd3mnpPj2h2Jw8+jjA+PAwRl9ewsDg+uJMsO0/TllR/i4WvUyOWWiy2SU/FfE5EfdtynrB27awS8YUZqkd+hCAR9KZkz5eRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778158422; c=relaxed/simple;
	bh=7hkrpD7EZ/8FKA1SKQVYJbabgMr8ZaKaxZfBFYSXjyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YcpHHFV87QMmc0ZfuPtaLZU5DnIYZDMWQh7id/hRDctMwgHQtdq3oHTlOH0qckk06yjzlMvv7i6C5rPn88p211OL/gCCEBdVHtb51wYohcgB1s8N6ZtiH01mTsIRAmuRLeo8yKtAlqLuJTezomwj1PzD0oVMGmM1GQNiklGibUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/2FnGWG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/2FnGWG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B773C2BCB8
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 May 2026 12:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778158422;
	bh=7hkrpD7EZ/8FKA1SKQVYJbabgMr8ZaKaxZfBFYSXjyE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=k/2FnGWGjfLufMCdvCCnjnNG1QU/kr3MkMC1rEpntRSqTMohIIuNvYzl1cNcsqz6M
	 V0YQ4SYBNwAclwp8G3envVJIsvWHeitj+9RJFPBpI09Fm57f5Jch2Krh8yGGJm+iL7
	 AYcOL9OqZLYEIl30yeNgS3SONUzK1nHgrwMD4gyfUirrcsccVyhL/Yn0x39gN97Ewi
	 xZczDPr5Z6DId3TwzkxQFWvxVaIRg33isZDWgMEZYQK8hv7u0Ms5lO1FGvsQ3mUTyS
	 T2/mwuE0hifvnFO0uX7VHCAi1De4BugD6yywI2ow+Ll+56v5vkJZHtEipBkXrL7JfI
	 TUYM/mRqNPBgw==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-65c4152313fso1133498a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 May 2026 05:53:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ89nnRHlpNaFyH13LWQy3I1xaer65feTdzEDTjCg5bwpzbE2K9q9QALqyxLAt+w0Zt71cmxJqcYZcaWPVX2@vger.kernel.org
X-Gm-Message-State: AOJu0YxmfV/a89641zOUrEm7hxl0T2lG/S4w5rjMjvoL2cEAcXELm11U
	OqKRwNL4ITk5YZyEV0j/a/lOrzgsK/rIdetzd2hC+bA3CZiZtmZKhK2zOf82FsBbqsw9FZfQPtR
	Z5VfTTyeQ301Ek+5gx6m6C7rMR7rkQ6c=
X-Received: by 2002:a05:6402:518c:b0:67b:4e46:f13c with SMTP id
 4fb4d7f45d1cf-67d648ad039mr3982795a12.23.1778158420661; Thu, 07 May 2026
 05:53:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506153850.774060-1-charsyam@gmail.com> <20260507021831.1196548-1-charsyam@gmail.com>
In-Reply-To: <20260507021831.1196548-1-charsyam@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 7 May 2026 21:53:28 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9SgCkmDGKej0Z=Yc6V6sRZBbnpCV5xvgyvCLBK-dNBaA@mail.gmail.com>
X-Gm-Features: AVHnY4JwuzCa7mlQeEMoJ6p0ZV-gPmkzw_RyiG9Nex52gZv01_U8RPcVetDOWDs
Message-ID: <CAKYAXd9SgCkmDGKej0Z=Yc6V6sRZBbnpCV5xvgyvCLBK-dNBaA@mail.gmail.com>
Subject: Re: [PATCH v2] ntfs: fix out-of-bounds write in ntfs_index_walk_down()
To: DaeMyung Kang <charsyam@gmail.com>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 7, 2026 at 11:18=E2=80=AFAM DaeMyung Kang <charsyam@gmail.com> =
wrote:
>
> ntfs_index_walk_down() used to update the index traversal depth
> directly before writing parent_pos[] and parent_vcn[]. A malformed
> directory index with too many child-node levels can therefore advance
> pindex past MAX_PARENT_VCN and write past the fixed arrays in struct
> ntfs_index_context, corrupting context state used by later index
> traversal.
>
> Use ntfs_icx_parent_inc() for walk-down transitions so the existing
> depth limit is enforced before the arrays are updated. Make the helper
> check the limit before incrementing pindex so failed callers do not
> leave the context at an out-of-range depth.
>
> This is reachable by iterating a crafted NTFS directory after the volume
> has been mounted, including read-only mounts. The reproducer uses
> getdents64() on an index root that points to an excessively deep chain
> of child index blocks.
>
> A crafted directory index with a chain of child-node entries reproduced
> UBSAN array-index-out-of-bounds reports in ntfs_index_walk_down() and
> subsequent KASAN reports in ntfs_index_walk_up(). With this change, the
> same image is rejected with "Index is over 32 level deep" and no KASAN
> or UBSAN report is emitted.
>
> Fixes: 0a8ac0c1fa0b ("ntfs: update directory operations")
> Suggested-by: Namjae Jeon <linkinjeon@kernel.org>
> Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
Applied it to #ntfs-next.
Thanks!
