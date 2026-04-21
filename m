Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD311632DD;
	Tue, 21 Apr 2026 11:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776771262; cv=none; b=sYDD8xWKsjycHNPsFG/0+lrPIdd0Sf3NvxFbb7k9FmN6IChTJFIBp9+aNz9Pb7whrocRoGNw67mXNoOWJD7JPtAry+fHJLzEghmBMhY2fk4JuJfpSJPXSMRvRNDIQ4IEkeoR+UNuMyKnXgnMU523jZHwy+EDP5E+giY4IBmhJlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776771262; c=relaxed/simple;
	bh=PalhF4/iCkuZh0WAmK8ZvZAijlnAdeWyylG/6szEmU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RUCOzlg8X3NqOyOq/vJgmlqwiFpT6suDOeX2ohoX2evAz8aM++eGa16wTmvnFIjJXXN28zTuJWeV0u/U4jbr/7PKr8Z6d0FBAwr7jcPQ7UZ8GDM0uL7zFXkwFstn+RndYaIcKzwNnfwcafajXmLAdyczMcKCxPkW70hpAaVINjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDGkSy9N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDGkSy9N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F82C2BCB0;
	Tue, 21 Apr 2026 11:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776771261;
	bh=PalhF4/iCkuZh0WAmK8ZvZAijlnAdeWyylG/6szEmU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HDGkSy9NiVT1FbctPLCLmBo5ps3IrHmjMrO+UMuzVvyCvFwk5DHxjWu487zaDZ9lZ
	 g4eOwiYrIMqN9QDtY4cxpCFwRFnc0QE1T9injmJZQHZV0g9BbYKMW9g4eKgniAfxVF
	 8yRhytHEMdoutzujY7ghImf3CIDSDq5ER0N7GYpbKmYVumBEPp76NCJQZHyEjM33kt
	 Emtej1HBwssagtxK539xJDaTAfJ0/Mf2MXTMLjqQs/mekazU8c0nKp/1NOMee4a6D8
	 5Y+MrIvPlwApvoH3xmHfCjHvnHtT+fqns73y4ukFJ39ElBrEwAwtgt1+u5gpeSpMeW
	 kjLaXpHkm8Qdg==
From: Christian Brauner <brauner@kernel.org>
To: viro@zeniv.linux.org.uk,
	jack@suse.com,
	bcrl@kvack.org,
	axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org,
	linux-aio@kvack.org,
	linux-kernel@vger.kernel.org,
	Zizhi Wo <wozizhi@huaweicloud.com>
Cc: Christian Brauner <brauner@kernel.org>,
	wozizhi@huawei.com,
	yangerkun@huawei.com,
	chengzhihao1@huawei.com
Subject: Re: [PATCH] fs: aio: reject partial mremap to avoid Null-pointer-dereference error
Date: Tue, 21 Apr 2026 13:34:14 +0200
Message-ID: <20260421-weinberg-neunmalklug-4f9abb5f114c@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260418060634.3713620-1-wozizhi@huaweicloud.com>
References: <20260418060634.3713620-1-wozizhi@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1449; i=brauner@kernel.org; h=from:subject:message-id; bh=PalhF4/iCkuZh0WAmK8ZvZAijlnAdeWyylG/6szEmU4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ+T9i+PmNKhV9X54ktfHrv/KSvmn540CS5QXRJpd+pV wVr7iue7yhhYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIoBwjQ4/RjpuvFSpLv62r cSl4G/Sn6PQBGa+ujaUH+m6K1u+7tprhmybT+/6MA/FWB34YfxPZa+xb+4opsyfI95lgTiej01p GAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sat, 18 Apr 2026 14:06:34 +0800, Zizhi Wo wrote:
> [BUG]
> Recently, our internal syzkaller testing uncovered a null pointer
> dereference issue:
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> ...
> [   51.111664]  filemap_read_folio+0x25/0xe0
> [   51.112410]  filemap_fault+0xad7/0x1250
> [   51.113112]  __do_fault+0x4b/0x460
> [   51.113699]  do_pte_missing+0x5bc/0x1db0
> [   51.114250]  ? __pte_offset_map+0x23/0x170
> [   51.114822]  __handle_mm_fault+0x9f8/0x1680
> ...
> Crash analysis showed the file involved was an AIO ring file. The
> phenomenon triggered is the same as the issue described in [1].
> 
> [...]

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] fs: aio: reject partial mremap to avoid Null-pointer-dereference error
      https://git.kernel.org/vfs/vfs/c/db80e11b54d2
