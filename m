Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C833EC2CE
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 13:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778506770; cv=none; b=Zi8DREn4n1WRJuA2UJN/RTO/wOGJJrwZ4hWG7QO7AHoWfWifAE1pvx22tnK+LQQ/BldBJd+F5wMIowgblY7arbFecDxyr4rDqk6y5xpd3FEGDl9lJ2pOgZSe2YjO7TQWXW0hpbau3Z7+okjUp0umO/9cOaYUz9sojiHE14Hze9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778506770; c=relaxed/simple;
	bh=j5Nne2nmBRMqFo7kmadS2AyVqARkNgq1BkI6hTS0OTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a/dMTrHzSaQiO+PbdXGNF+kfs3NX2EUdMW0bqmPeubEHSZFCf/A9e5OathqKxrODcB/stJ8Vw/E6/LL9LldUw/oXRNTWBZFcJEAqYlh0qD4J8o4+ENjMK3ItshXahgzy0xeDFKbI7/aWMfupXl+QR4uvzCngvXoQ/hqSWJNdvnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CizOMowE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CizOMowE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF9BC2BCB0;
	Mon, 11 May 2026 13:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778506770;
	bh=j5Nne2nmBRMqFo7kmadS2AyVqARkNgq1BkI6hTS0OTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CizOMowEjm75pnGBjvVRtnwUU2nYttqG4L76z++q1+n+WKkXC5/9KXnIYpaZUYLEy
	 ERuuC5RsbZOu4QX1OeIo80ZvILEbaWfKv0B0YzTI+zGOkws70QJNpKWihzLbqeArga
	 VKgNMFxY6g9eEnUbJVsqkeLvsuKSSsvMa3nRiw+9jZt91bWthhVACKG2ioIQP18Eek
	 FkV9x/9u3ZviiwW1FNha/88X5eHNpSU+i9mW7jfnCcDpfSSpYWGW19Q8siAj4FCewZ
	 XEb4VEhan7ZZOtSlgaQmjnRNWhn0weqzEorDRljfvSeJXsPwGQRVSyFT4dy8JsmQCI
	 zGW/jytxG5q/A==
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: drop unused VFS exports
Date: Mon, 11 May 2026 15:39:23 +0200
Message-ID: <20260511-bewiesen-ungelegen-b8c7215e4f82@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260511072239.2456725-1-hch@lst.de>
References: <20260511072239.2456725-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1397; i=brauner@kernel.org; h=from:subject:message-id; bh=j5Nne2nmBRMqFo7kmadS2AyVqARkNgq1BkI6hTS0OTU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQx3uGJn3pui8men6Yitht0Lly6JXa8/4202qQbSXeqJ 09oKjy/r6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiW3czMrzlv8lk23jOS2aK Qb8k69prYRrrnDzSXzu1toTm1XZadDD84Q86zPmFZd3Ee/stTv16LVHQnaDqfzS/tuudWrXqzPa dvAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 11 May 2026 09:22:27 +0200, Christoph Hellwig wrote:
> this series drops a little dead code from the VFS.
> 
> Diffstat:
>  Documentation/filesystems/porting.rst |    1 -
>  fs/namei.c                            |   22 ++++------------------
>  fs/super.c                            |    1 -
>  include/linux/namei.h                 |    1 -
>  4 files changed, 4 insertions(+), 21 deletions(-)
> 
> [...]

Applied to the vfs-7.2.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.2.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.2.misc

[1/3] fs: unexport drop_super_exclusive
      https://git.kernel.org/vfs/vfs/c/017f5962c5f7
[2/3] fs: remove start_removing_user_path_at
      https://git.kernel.org/vfs/vfs/c/a7b8abe0621c
[3/3] fs: fold __start_removing_path into start_removing_path
      https://git.kernel.org/vfs/vfs/c/6f7625314d5c
