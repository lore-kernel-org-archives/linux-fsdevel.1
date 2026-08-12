Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7445F2FD694;
	Wed, 12 Aug 2026 07:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786518938; cv=none; b=PWISywa6Klr+cS+vzKWxpwH85pXS3D9ZXDkrdVB6AsbVL/WiFdgtNdlDasEF83RWd3YpKt6nzdsQ9tHd1pHkxtQuvqlmPuROKFlMoemimy2E44MA9xSWdAHbpYYEXjhiAlZy656mB3bMWhn6KgDC41sHFZILVczfBQS8OvqDlRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786518938; c=relaxed/simple;
	bh=ME+68HtBsBPuk6wyraCq4j0RLNp7oSv8iRduvUaiLwQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=J3PPSInFVDxFsL4re8TGCIfrP+Bg2Ai1lRrxxXdL/P9ehpNsuTbsoKAsElgAkCqQgPaptGpS5sCVuWqQ8ncmSLMx5VYFz3KNRqlzjsmwFjDj0zDPSx7Fc7w/iD61BEofCld0aQO2JoyJcer1uWxNFYUrZebjXT2fHrBrXfKRoQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gyFGZqFy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gyFGZqFy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E52511F000E9;
	Wed, 12 Aug 2026 07:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786518937;
	bh=7BeiHnRW0831ssrKcclmKyWO28UlcVpkW8iCJS6yJ24=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=gyFGZqFyKhUtSYyYxoGS9uSGRauIfWHl2pOTRewS65/mPeFCqvrNPlTbEoIiWmnzz
	 hHzSsdbEiQymOMhj8CYWMElsjPjRFcZycgZQwurUX7TyuMlAL/TpfGXrs/M1Y2Vf5j
	 FKuyhD8wyvGElMfTUeiaNA1Xo/kjz4nIY43CS3t4/cNMA4LoYWKGbMU6gsPnW8Pv00
	 X7KrccNnAJ3e9lRx4BhwgfC+Vi/08/xXRFGfzIxjkXoTgKFykvCK30soMyT1NWkFE2
	 3+dAvJ/ZfIYqbo9/avp7JUh9H8nZzC32eOz8bUh99gncSXWWHolAjIJMtORCwJF00f
	 dWcuafD+KK11g==
From: Christian Brauner <brauner@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Jann Horn <jannh@google.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260803-vfs-comment-stat-uid-v1-1-162d062b737c@google.com>
References: <20260803-vfs-comment-stat-uid-v1-1-162d062b737c@google.com>
Subject: Re: [PATCH] fs: document semantics of kstat::{uid,gid} fields
Message-Id: <20260812-nutzpflanzen-entgangen-aufnahmen-5013348c327b@brauner>
Date: Wed, 12 Aug 2026 09:15:28 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-362b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=880; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ME+68HtBsBPuk6wyraCq4j0RLNp7oSv8iRduvUaiLwQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTVyE4vd0xnP7rDIf/Sk1uWGjqTFGddMVud3myZZPRih
 pK3tfK6jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlIKDH8T/qm/zl664efR/kC
 JHp31X+c7rXL2IrTWUvszZv5zzruBzMyzNCJUXZO2/GIU3HC6wbPiBCeLxJz470K/os/d+zQ2d/
 JCAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Mon, 03 Aug 2026 21:46:19 +0200, Jann Horn wrote:
> fs: document semantics of kstat::{uid,gid} fields

Applied to the vfs-7.3.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.3.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.3.misc

[1/1] fs: document semantics of kstat::{uid,gid} fields
      https://git.kernel.org/vfs/vfs/c/5c47ed98a4ae

