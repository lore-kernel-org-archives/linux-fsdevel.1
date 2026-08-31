Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CB83E44F9
	for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2026 08:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788164608; cv=none; b=ir6qcegiddW8EhxlXfLzoNN0b/azfh+UF7YFHy05Ssx5lK4/A82B2rH8JzHVmjFFDjW1Dxy7bJ85Ftgah+IUta6bg7hW2RjW4FAZ/oKr3jqTUo9VU0+vjuenQBRtGtQMc9AEerkfGegcs8DMUW82UGQpJwoHcm8utOAXbDV5IEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788164608; c=relaxed/simple;
	bh=RR9O1NGT74GyQ+Mf1JOrYQ5xY08I4DtpjhLGN5tW7Sg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HRowgxRgKrsqTqXj+De60LS1Xlp5RY6058XiadK9hakirSP2GN5D30ea5TMgpKrKG4qxNNu6TmpWe68Wcdwl3c2REz9QJB/rtwSxYKs5JKlO7DD4LyYVPJfOwMQNF7FpB4TWEB4FABsZ8CNcHae18mvHRAt7C7+hFOum4rDVBts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kb7LDwU+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kb7LDwU+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 808EC1F00A3E;
	Mon, 31 Aug 2026 08:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788164607;
	bh=22U6bts/L91pDmP7fYzCAsD4l6ekQOo4Io5hD/w1djM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=kb7LDwU+1UK4YW8Qyy65ON5UuK10JGYLQXoXMVJBk5aPrafowSaBV+CLw28avURhb
	 aXHhoQJBnC8sxT6D6yBd6JBfr+EieaFdga37SmwFZH7xNr27aj1dRiqTdfsL5GzB32
	 v/bcSOiuNaGU8D6iZ9ubxayUxqDyw7BKvr1b62dFtFB351RvIohTYZtPdhuTsezJCB
	 9X/1H3/avBk6WTDcyvHbeLEndUYypbAaapE/VG4TcqP32m4OVKGnkj/3uYVnvT0FwQ
	 whY+/xQtgqBWcXfi8c9SBHwJqG1ovcUdvAt/uQVtpxXhKSmabhn6FaTl0quoflnrm/
	 OTGaP+gn3g0rw==
From: Christian Brauner <brauner@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Manush Prajwal <manushprajwal555@gmail.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
In-Reply-To: <20260813093431.410-1-manushprajwal555@gmail.com>
References: <20260813093431.410-1-manushprajwal555@gmail.com>
Subject: Re: [PATCH] fs: fix comment typo in fs-writeback.c
Message-Id: <20260831-reift-mitdenken-endziel-86124476fb3b@brauner>
Date: Mon, 31 Aug 2026 10:23:23 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-362b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=863; i=brauner@kernel.org;
 h=from:subject:message-id; bh=RR9O1NGT74GyQ+Mf1JOrYQ5xY08I4DtpjhLGN5tW7Sg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRNtfz3SzN667yXLvdnn1M9HrlSb8fL1N3uD8rdk89zy
 35q+/TBuKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiPTcYGbqepxXo63/k8X1Z
 Z/qyYXbB4943S1end5zh3VbI8adhDzfDP9NpPm/PXfR0PZh37F6Te4TM7oCDj79vFjTgEP61boX
 ceg4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Thu, 13 Aug 2026 15:04:30 +0530, Manush Prajwal wrote:
> fs: fix comment typo in fs-writeback.c

Applied to the vfs-7.4.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.4.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.4.misc

[1/1] fs: fix comment typo in fs-writeback.c
      https://git.kernel.org/vfs/vfs/c/85844e50ebdb

