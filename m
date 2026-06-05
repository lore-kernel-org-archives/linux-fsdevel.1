Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC733481AB3;
	Fri,  5 Jun 2026 08:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780646428; cv=none; b=l7QOGqq202EjsAEEeZZsIYBVkdsida9cw1/kZFX00RGa/z9c/AMd+FsWyGkL1W8l2VidYAQg6mAhyvp4Hgvn8A+AJWjMIaqTPJHsba0oJj0Vof85RWKSZ3RGBXMkESuP5BrMqJfHln6tScLI4fH5gi84YW98+G5mhazo+1c54Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780646428; c=relaxed/simple;
	bh=YvJKeLRQNexy0zb8rYuAlcSxa7wy9WLn4ug159pEIfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QzwT1GTMshnFFirQor/XFhHRd4FX9wZ1wWahcj738jAgOX2op69gB/Wx+0eZFAmNGi5wubcDR7I4v9Ugsa+I+cEezcmktTpbBMmCxXSo9qauYzzRPFq5fbHyst3NDRbCWfT6g/1s7YwyAYjnKTPdpdafaaeBK12sWmTObx/+HRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PG4+J48x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PG4+J48x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0426E1F00893;
	Fri,  5 Jun 2026 08:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780646427;
	bh=BmPrK/VOBJVan69VTNdtidS4qQvNxKZi4P1LJSRoGE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PG4+J48x2UiY73m0Zy4Nzyjz4Rq9edN20JvtCvi0i/8vL2FDfQYXJEoblgsbcUC3A
	 wiMybttfVdmiCwHr71yHvsuzMa4Eijp2ghzfS4H7cRrXFcrtCsjmZ/oLpTCswSfice
	 gwWn1lVIpJMC/msMQNMTWLMcQ3RRAcDpYyNz63CmMdA2dG0vqeHP00KVHw3Q2rc/AS
	 8MEXz3cX+0/v0mWT/0bEOjLungVfYxglqB5zX+3pjTdtXWRqzT5D1tcPCW6GWsoVER
	 hWe1GPSd610GpGx02T/m2MWch147zoioX5NkmDpo02GbjDgiSyCah+A4dYXlKO8zcE
	 xY3KyZSGZ5kRg==
From: Christian Brauner <brauner@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fixup! proc: protect ptrace_may_access() with exec_update_lock (part 1)
Date: Fri,  5 Jun 2026 10:00:03 +0200
Message-ID: <20260605-glanz-mittag-auffordern-538ca21aa78c@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260604155806.1402880-1-jannh@google.com>
References: <20260604155806.1402880-1-jannh@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1612; i=brauner@kernel.org; h=from:subject:message-id; bh=YvJKeLRQNexy0zb8rYuAlcSxa7wy9WLn4ug159pEIfY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQpNYmZ/L577OizSycL5XZOqwrr6vocbalVqvj7rn/U4 7ROnWqtjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInMM2T4X5rLED75W+6dRRkT zjsYpSwX29d/cumfLwejVm49uciIRZqR4fZ+A26nzrxn/B0BZlsMMtin/Ft/cJri8RWmhu4P7zG V8gAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 04 Jun 2026 17:58:06 +0200, Jann Horn wrote:
> fix two test breakages in tools/testing/selftests/proc/read.c:
> 
>  - The test requires that readdir() on directories in procfs does not fail
>    when running as root.
>    Restore the previous behavior where /proc/$pid/map_files/ simply returns
>    an empty directory if the process has no MM.
>  - The test requires that any directory in procfs has "." and ".." entries.
>    Restore the previous behavior where, even if a task has no MM,
>    /proc/$pid/map_files/ still has "." and ".." entries.
>    (This now differs from previous behavior in that even if the caller does
>    not have permission, they still see "." and ".." entries; recreating
>    the old behavior exactly would make this code unnecessarily complex.)
> 
> [...]

Applied to the vfs-7.2.procfs branch of the vfs/vfs.git tree.
Patches in the vfs-7.2.procfs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.2.procfs

[1/1] fixup! proc: protect ptrace_may_access() with exec_update_lock (part 1)
      https://git.kernel.org/vfs/vfs/c/883d2f3ec72d
