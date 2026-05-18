Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAFB3F2102
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2026 11:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779102232; cv=none; b=KjbVVm5pgvXVfYvnUJbBOwDFgAhsFHnOJoSP0rIfKuLO9KReaS4RGyoOuK7A5U76qDtNtQIPKHkQVjDqxaaOhRjaOJ33z3/arY7xMzeSaSrUuTetj4QMW0pJiNz+p1+vUbQAy88NWzKVXFVPN1LYlaCWE1VVebMTDNWcRXmFNiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779102232; c=relaxed/simple;
	bh=UHop5yFx+Z6FYOWg9cpgi3/9XDbDin9YWGBRPdjRsG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=upBt0T/YxmRT+7uqJiduErRlKFc6sKoDa/z4qj9T1Cbu8GVBoWaQVJL2cqbvd+Tjy99UbYkKbybyQ4SMqS6fbtEaTL+rhREmf9KDYxsKyKe5D6FjZhk2yDvPsI0fV1ElA2GG2Q/MBa5yyd2FM1Q5Ww/vU6rjrpVCr+x81L6rJzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q/IQ3Q8o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q/IQ3Q8o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8D8DC2BCB7;
	Mon, 18 May 2026 11:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779102231;
	bh=UHop5yFx+Z6FYOWg9cpgi3/9XDbDin9YWGBRPdjRsG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q/IQ3Q8ow0sGFJLMoW/SWpilHYfKmMtljd2BonqejW5RB6JKkg+Fnfcl6H79N7IHR
	 7yh66juqtne8m4w/ULvncp/y+PqEvrkpWy7w0ypghtSmEDIbylD9QCgMJFUtlqp+Lj
	 eUvx6lzfAjqd0pFe2qViM/EnnqlVRquZ7nDoPljzkUI95q3ygnaQflrtBQ9D6/sIR8
	 0AUlM1e100ifpswzOGFQxBgG0DRjPu23xlrDptthjRvtw47ykTdAmjqrOYhx+INy8L
	 9/fouxaPJVunku1DPgvBnOcMJorBjYX9YS3QTYnlxYC9aU/FQGn0ckSUItuk/7KdN/
	 ky/1QIiCNu4Bw==
From: Christian Brauner <brauner@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/7] Fixes for vfs/vfs-7.2.casefold
Date: Mon, 18 May 2026 13:03:40 +0200
Message-ID: <20260518-gipfel-klamotten-3a79468fe213@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515153515.362266-1-cel@kernel.org>
References: <20260515153515.362266-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2136; i=brauner@kernel.org; h=from:subject:message-id; bh=UHop5yFx+Z6FYOWg9cpgi3/9XDbDin9YWGBRPdjRsG4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRxfRI891P/pWn1s7+Hsv+u0rt4MNDMx6ffpsQ0Ze+cI 4c28kx/2lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRwE2MDKePfNl/9uah2hOy Ohmvd7uH7D4lcqTnWZFBU2WCeGluThbDX8G3cz1L5+z6eOO9qFjAQ4YYu2aLdRmpkQz1u7I7d8t f5AcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 15 May 2026 11:35:08 -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Address review comments for the series in the vfs/vfs-7.2.casefold
> branch.
> 
> Chuck Lever (7):
>   tools headers UAPI: Sync case-sensitivity flags from linux/fs.h
>   nfs: Avoid transient zeroed case capability bits during probe
>   nfs: Skip pathconf probe when neither field is consumed
>   fs: Clarify FS_CASEFOLD_FL semantics in UAPI header
>   nfsd: Use kernel credentials for case-info probe
>   nfsd: Map -ESTALE from case probe to NFS3ERR_STALE
>   nfsd: Cap case-folding probe cost across READDIR entries
> 
> [...]

Applied to the vfs-7.2.casefold branch of the vfs/vfs.git tree.
Patches in the vfs-7.2.casefold branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.2.casefold

[1/7] tools headers UAPI: Sync case-sensitivity flags from linux/fs.h
      https://git.kernel.org/vfs/vfs/c/2c718fccf374
[2/7] nfs: Avoid transient zeroed case capability bits during probe
      https://git.kernel.org/vfs/vfs/c/c6eb07d3da83
[3/7] nfs: Skip pathconf probe when neither field is consumed
      https://git.kernel.org/vfs/vfs/c/425294293cd1
[4/7] fs: Clarify FS_CASEFOLD_FL semantics in UAPI header
      https://git.kernel.org/vfs/vfs/c/45e57cfb7b10
[5/7] nfsd: Use kernel credentials for case-info probe
      https://git.kernel.org/vfs/vfs/c/3aa75b92e862
[6/7] nfsd: Map -ESTALE from case probe to NFS3ERR_STALE
      https://git.kernel.org/vfs/vfs/c/fbaee2a5c406
[7/7] nfsd: Cap case-folding probe cost across READDIR entries
      https://git.kernel.org/vfs/vfs/c/cfff672ffcf9
