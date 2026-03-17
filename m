Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C073A6EF8;
	Tue, 17 Mar 2026 14:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773758308; cv=none; b=I4GhL1Bh0pnz1d0YfkZhfpBTJyDawu+DfsHr1x+MfgpViNGnHKA5w+g7rIR8lBIooBHdqKC/d/de7TcVIEfKyMRF+VKV9V6X/BuCQUdTPKutI5VQdIBR6wXDtAQr3wLS/1z7Cv+M74yGE/sIh+p11NCi8wKJsSYUc/a1iv9CEzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773758308; c=relaxed/simple;
	bh=6s5chDVwAXndg+Y6XgDhqnlRxrGzuz/Ue+HZVY4Lx4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jPhpOm1U0ukOehdU5wJ23QgIqY2kGTDJ/9awn4tWmYURaxpLx9OP8C0Q4/nuWQ8d+jLC6BzCheZhNLv9cBTWjeig/5+AAWFC4baXacSPOfniWTTLZ3Xaw8vdnaXC2XtckK/NP8MM9ShWGwQuqb9nw57VhRNB5fwBcYBGfGuBBvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVY3GiPg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVY3GiPg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE4AC4CEF7;
	Tue, 17 Mar 2026 14:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773758308;
	bh=6s5chDVwAXndg+Y6XgDhqnlRxrGzuz/Ue+HZVY4Lx4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MVY3GiPgDEXtYTxOmj2lPT0QepCBGq/wp0pVUBlK7CAabtbZMGq+1MOTnLJ3Og3NV
	 dwZq/UjIfn6Py5o7Y9He/Xmapz17La6mKk5hpy5KEwbiEsWbFSVb3QlNIB0FN1EUTr
	 gsUuteydp1FOd48hIf39F5BuWXKkn7qcZFx/MuGcQ+4FF+7mbXpxw5COcL2V3zKQso
	 jRcy46TaBQzg73MadFUJj56UOJzgdHr6EvLlWIxLbVYNtWN9jqcqD9mJor3fAGcaMf
	 Mp6i4ksy4Qw5+xO8c/qdSGiMEAAEWDmHVvmHnMzjNJ5qhc1q6u2+O+ZJmXKsD9fglZ
	 hK/foyjV+SKcg==
From: Christian Brauner <brauner@kernel.org>
To: Hyungjung Joo <jhj140711@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	jack@suse.cz,
	greg@kroah.com,
	linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/mbcache: cancel shrink work before destroying the cache
Date: Tue, 17 Mar 2026 15:38:20 +0100
Message-ID: <20260317-inventar-wirksam-11bc2443fabc@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260317054556.1821600-1-jhj140711@gmail.com>
References: <20260317054556.1821600-1-jhj140711@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1395; i=brauner@kernel.org; h=from:subject:message-id; bh=6s5chDVwAXndg+Y6XgDhqnlRxrGzuz/Ue+HZVY4Lx4U=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTuTI81tnLfrmy7MejlaycBF6Fsm23f+5jOWMY33+AKe 5dwYD1TRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwER2TmNkeP3+oMIBmVP860Ve 6XgJZOcqvSy+dVKpt1HW75R3ls6fq4wMD93Cy166ctxZcfuLpes2qVPs1vxVrTZV1YecrYNNHR1 4AA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 17 Mar 2026 14:45:56 +0900, Hyungjung Joo wrote:
> mb_cache_destroy() calls shrinker_free() and then frees all cache
> entries and the cache itself, but it does not cancel the pending
> c_shrink_work work item first.
> 
> If mb_cache_entry_create() schedules c_shrink_work via schedule_work()
> and the work item is still pending or running when mb_cache_destroy()
> runs, mb_cache_shrink_worker() will access the cache after its memory
> has been freed, causing a use-after-free.
> 
> [...]


Pretty sure this is AI generated and it misses a Fixes: tag but otherwise looks
correct.

---

Applied to the vfs-7.1.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.1.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.1.misc

[1/1] fs/mbcache: cancel shrink work before destroying the cache
      https://git.kernel.org/vfs/vfs/c/d227786ab111
