Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534CE3ACEE9
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jun 2026 09:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780997145; cv=none; b=DlcNuhdCd6gCHnqE6tFkwl/suHVBB3To5+Dqx6Rk7hmvJY2P7448dLLOfIGwdOEIOulD/flI6dqNshjSuAN68yz5tQoUkHxQWImWvaDkzZxYsMc1CxnZs+NhiQjEWhcECG1EiZaIkpRqCLcf+JZ2ukkY3JylvDzxtDdzceOo/CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780997145; c=relaxed/simple;
	bh=ZyrPVORKuAtZ5DfK0JnZ7+zr6kTn6WvFaVTmVKDBlG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c1lHOmcmWOO1PeUPZKbqr1+QeCJXCJDPbNiYimRXJSQpJ5DKxN64U71uT+zaqiqWDnG21t1eNStmSVlZjmJCsHMYAvt7O5RerWo+p9xLjnOyuaNr73jxsVVQFjKDJh8fl0MnRoYouiX6aky0Kyqnrh8g3i/anzHljRuuyfedV68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mndy84Y8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mndy84Y8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F379D1F00898
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jun 2026 09:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780997144;
	bh=guXMkD/CXZWZz7/ypVkwTi8EGLanAoQU2wk31gOXaEo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=mndy84Y8lvq0TM5Q6Hlw53iK4X2FN/c48QXuMplImyW3vD4LP/DEmyS9Z716SzGvo
	 7nRbY1OlGw/B/Uh/v8EAGDA/ZMUUFEOM2MjFvNzrs33adPxgXa2zZIuDlajVM6aUgV
	 hNoUivf4RRzG9uWYKmaSlW/85pJTkMPLr1IAdM0QHp0cx4aoDj4KPZpZ8Pin4se178
	 dpbCnPzn29zpqdrlCzXSmkAufn6NmnOtgYDkN1KGbmYeuW5dJMC7K48qjUEuxowllf
	 SNcJzDce5mda6xrZ7Yuqtgb+RTNxUUVU+nL0jySwaMMPyVVN/JIo6cTjV8yJYj7FnP
	 oUw7IXiLpdj/A==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-bef47b1ac01so793706366b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Jun 2026 02:25:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9ZaoVwescX63fOqxwoXhANk1bu51a+GiET3CF9q6ah9X/l7wnwx2HEFd3HuisrX9xLVR1gX45pJYhUluBG@vger.kernel.org
X-Gm-Message-State: AOJu0Yxle4QvYZ9c9YY5aYaq9/PV7xLzHvg461f+tioHoUJKG+VGnvp5
	gztQBlJNONkB9cszneIrZh+aN7tsqBYU8ucDQjttweQVmCTG7FYzrJKb+3EiYxqjHhn8F6zgli1
	bnWP/lxV44bZ0PnHCpd+krVV8mN7dXuc=
X-Received: by 2002:a17:907:970d:b0:bae:456f:fbb2 with SMTP id
 a640c23a62f3a-bf37234c821mr989583366b.23.1780997142437; Tue, 09 Jun 2026
 02:25:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608154917.2703739-1-charsyam@gmail.com>
In-Reply-To: <20260608154917.2703739-1-charsyam@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 9 Jun 2026 18:25:28 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9jxzr29a9s0d+40tHpuWzY6xuN8UR8CSQMQFnK+w2+NA@mail.gmail.com>
X-Gm-Features: AVVi8CeUqV6szHd-7o_GDE4LZ5zr7BD8G02k7_VNE0hIB8YXxFSAIQg3W8MdCww
Message-ID: <CAKYAXd9jxzr29a9s0d+40tHpuWzY6xuN8UR8CSQMQFnK+w2+NA@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] ntfs: finish resident attribute lookup validation
To: DaeMyung Kang <charsyam@gmail.com>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 12:49=E2=80=AFAM DaeMyung Kang <charsyam@gmail.com> =
wrote:
>
> Hi,
>
> this is v6 of the remaining NTFS resident attribute lookup validation
> fixes, rebased onto the current ntfs-next branch from git.kernel.org.
>
> v5 was generated against the temporary linux-ntfs ntfs-next test branch,
> where the earlier lookup validation patches and the initial resident
> $INDEX_ROOT validator were already present. That made the final
> allocated_size-only patch depend on context that is not present in the
> official ntfs-next branch.
>
> This version is generated on top of:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/ntfs.git
>   branch ntfs-next
>   base: <b3f6cd1d54aa>
>
> The current official ntfs-next branch already contains the earlier shared
> attribute-value validator, the volume-name error handling fix, the volume
> information search-context reinit fix, and the resident $VOLUME_NAME
> validator. This resend therefore contains only the remaining official-bas=
e
> delta:
>
> - reject non-resident records for all resident-only attribute types;
> - fix the $INDEX_ROOT grow and shrink ordering so header capacity never
>   exceeds the resident value visible to lookup-time validation;
> - add the full resident $INDEX_ROOT lookup validator, including
>   allocated_size checks.
>
> Changes since v5:
> - Rebased onto the official git.kernel.org ntfs-next branch instead of
>   the temporary out-of-tree test branch, so the series no longer depends
>   on patches that only existed there.
> - Patch 4 is now a complete resident $INDEX_ROOT validator. In v5 it was
>   an incremental allocated_size-only change on top of the out-of-tree
>   validator; the resulting validator function is unchanged, but it now
>   stands on its own against ntfs-next.
> - No functional changes to the other three patches.
>
> Testing:
> - Applied this 4-patch series on top of the ntfs-next base above with
>   git am; git diff --check is clean and scripts/checkpatch.pl --strict
>   passes on all four patches.
> - Built a KASAN kernel (CONFIG_KASAN=3Dy, CONFIG_NTFS_FS=3Dy) and ran it
>   under QEMU against fresh 512 MiB NTFS images: mounted each read-write,
>   created 12 directories and 2160 files, then renamed, removed, cleaned
>   up and unmounted. Repeated three times; no KASAN report, oops or
>   panic, and ntfsfix -n reported each image clean after every run.
>
> DaeMyung Kang (4):
>   ntfs: reject non-resident records for resident-only attributes
>   ntfs: grow index root value before reparent header update
>   ntfs: update index root allocated size before shrink
>   ntfs: validate resident index root values on lookup
Applied them to #ntfs-next.
Thanks!
