Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA26471403;
	Wed,  9 Sep 2026 08:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788940942; cv=none; b=jLyuJ4Air8yWMgBOSjA0J6d1Lnmq8iBIQSkATHcw13M5EayMBVUoTMCEUpLRtETFUS4ubBSCi6aKiK+Kd/dHnQleZqt+RmlxR4iBaYrsalSTn/K14wYzW1C1MXH32dU25ThLs8QWT1PksrSIzafggZ96ooqU0dBZtzi/dGfSbBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788940942; c=relaxed/simple;
	bh=V8ENEhea0/045IaOrULyUtODpmtdvKkTlPTex21YVtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sdA6OO7qDjoIFw26aLvkgismtFGWcFd+bAW2sm4kt19L3xU2/SaCcDEinJEyYtzvPWXDjaTVURRA3ZsNIET9daeIszGMhKmoYPMYVyJ3y1xKcWpOn5CILkn3XDeeXTf4Le3qNTtelauDT63+MCiYJy6qDsLgsQadwZfmnbNCO74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7OzrsvI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7OzrsvI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 552FA1F00A3A;
	Wed,  9 Sep 2026 08:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788940940;
	bh=W612c/YDCkd9sV3obaip9FxOejj1359jethIBJsEBkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j7OzrsvIMBoMfy63XYj4cFEojGCR8j1Nq9GMSWdsJawWwImdjCfTPe+N+iWI/kJzX
	 afVLmSxN99g5gkk0jAD+V30TFhULJXJHu26HE41r7/Bajn8fLaKsBHn95ZTtsFTD51
	 2TTxZfT0WOH6JRnoSvg4trBJIGV7IBe8LDl+xUP+ZC7OODzXL6Mh2me7Yzx8/6p1ro
	 GZRp88OEHXUGfgXo05ApVhRtnIl6fi22RdX1vAGZKqQuP6nd2Tg+Svp9IRNWWitJ0F
	 ENuHdJyNxIKLdysWZ32ew7fmaCfAPrzUPlj/ifjax1o2lw10HwNhD2j2jIHuHnIAHB
	 ntZWwikusKr9Q==
From: Christian Brauner <brauner@kernel.org>
To: Norbert Szetei <norbert@doyensec.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	akpm@linux-foundation.org,
	Bradley Morgan <brads@mainlining.org>
Subject: Re: [PATCH v2] nstree: check listing permission before taking a namespace reference
Date: Wed,  9 Sep 2026 10:02:13 +0200
Message-ID: <20260909-arterien-zutreffen-extra-e2858bdb3209@brauner>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <ABA32239-733B-438C-B95A-B13ED69FF0F3@doyensec.com>
References: <ABA32239-733B-438C-B95A-B13ED69FF0F3@doyensec.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1496; i=brauner@kernel.org; h=from:subject:message-id; bh=V8ENEhea0/045IaOrULyUtODpmtdvKkTlPTex21YVtg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQtFOpgt/KffXjmM9PW0MgfB8tL5q5QkXHKtzqQw25++ XQCE+vOjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImIKjH8L3FV/hf5NP6X+PwL FUbHeHbM4c11lt19aN0XmcmfLiVmJTH8Mz21/XducPiva1/+xbxrDeUMNPt1+sJZ0ZOCdXJelWt dGAE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 07 Sep 2026 16:22:17 +0200, Norbert Szetei wrote:
> legitimize_ns() takes a reference on the candidate namespace before
> may_list_ns() has decided whether the caller may see it. The
> __free(ns_put) cleanup on the denied path can drop the last reference to a
> mount namespace while we still hold the rcu read lock, and put_mnt_ns()
> may sleep there. This is the same problem commit 2ec2aff3c8e2 ("ns: make
> sure reference are dropped outside of rcu lock") fixed for the put_user()
> path. Neither ns_requested() nor may_list_ns() needs a reference, both
> only look at the namespace type and at the caller's own namespaces, so do
> the checks first and take the reference last.
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

[1/1] nstree: check listing permission before taking a namespace reference
      https://git.kernel.org/vfs/vfs/c/ecfee3a7c9ea
