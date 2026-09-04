Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E71430CDD;
	Fri,  4 Sep 2026 09:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514862; cv=none; b=XLCgNh/6uokhNauhQv/cbDR02kJny6bgIpFzeNczVe6lJ8o55T7vVks7iD9u8+A6DlHIUgDCvCh9b13SlUG3aa3NBVI4IgBeVULN3Ldp8gF0p4Jsrll98H3O+fSOhZkgbqkLf7J50W6WPPwdSccRpYlm9s08Mn2W7mP+yyqli18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514862; c=relaxed/simple;
	bh=46rizbzGhnU1dmKHCvpXDFUJKLW3QO81WjIK7fMpwhU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NkTkYUoQikuY+IHNNYoR4MD7fAMvouhrGa/n+sz1WPFs1lozX34CpQ0wVkWcwMoC08JNGpsVVRttLymwKQR8xI+q8Uva+/RG0jCRBWSWTPDCenMdseEPsu2joLn29uk+CmLDqXTI1kAnjOjuYIPndIrRbJXbMzCzB+fldj/R/Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BSW7PkIW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BSW7PkIW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A7F1F00A3D;
	Fri,  4 Sep 2026 09:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788514861;
	bh=YAV5wnqFZlzybVd7zTHQ45qyMjvxvv83jbqrRH2XBtA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=BSW7PkIWXmrQ8c9RbjsMYB47lxRiy7uXu4vVNnktlUJy5V48w96nMmbwmtPUXTQnr
	 3aPYG/z0RG0QOtgz6Kk3YOrX6Eo9hryA4D9MwJJhwADKf8YQmjVqiQRub6MY61hwB2
	 puLEIYGneSLg1NfTg7OrcbgaW6HXcsy9dkoVrMeTALx9GXNqok0gbOJrcIm0WYvFwh
	 mf6GFDyGvM5FxG9bia+ossI6lAXIZQ2+3wQmmTrjBFvNEbGWhZ243HvhSqo7U7r4AK
	 nleEOgQ5b12HLYxclJFEwiFeo3sgeNqvmkMDVlvRToBp0LXAS9TjZcvzCrXRDbBSc8
	 Y8IInVYddVTeA==
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>, Daehyeon Ko <4ncienth@gmail.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, 
 syzbot+0aee5e8066eddbbe7397@syzkaller.appspotmail.com, 
 syzbot+e8b3520b53e78e90034e@syzkaller.appspotmail.com
In-Reply-To: <20260831001221.3755948-1-4ncienth@gmail.com>
References: <20260831001221.3755948-1-4ncienth@gmail.com>
Subject: Re: [PATCH v2] exit: hold a reference to thread_pid across
 proc_flush_pid
Message-Id: <20260904-weither-weswegen-aprikosen-ad8b1cdde9bc@brauner>
Date: Fri, 04 Sep 2026 11:40:57 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-db0b7

On Mon, 31 Aug 2026 09:12:21 +0900, Daehyeon Ko wrote:
> Commit 0a36bad01731 ("release_task: kill the no longer needed
> get/put_pid(thread_pid)") removed the reference around proc_flush_pid().
> It assumed that free_pids(post.pids) at the end of release_task() would
> keep thread_pid alive until then.
> 
> That assumption is wrong.  __change_pid() only records a detached PID in
> post.pids when pid_has_task() is false for every PIDTYPE.  If another task
> still uses the exiting task's PID as its process group or session ID,
> __unhash_process() removes the exiting task's PIDTYPE_PID link but leaves
> the PID out of post.pids.  release_task() therefore holds no reference to
> it after dropping tasklist_lock.
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

[1/1] exit: hold a reference to thread_pid across proc_flush_pid
      https://git.kernel.org/vfs/vfs/c/cdd812d0683d

