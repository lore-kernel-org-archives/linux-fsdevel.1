Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3B336EAB0;
	Thu, 17 Sep 2026 10:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789639754; cv=none; b=pV9XaJQE1YdVb1i1RyUhGCT1xiI0dZJizcX+74D3cDsvIUq9X5jiZlagfkj0rvqYGT7vcDo6L3e3G3xzVm/rqvsmwoGgzwNwbiBtaVMSo4XzdMjMOiokgqy1alJdWBQ1g9wTRr2VTXaXeZzJ35el93lnL5gjoa7/TrF+k3Be/Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789639754; c=relaxed/simple;
	bh=2X37nh7K5uVquc+LvQVufKLrvahJ/uPC5JXRwMnPEgo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Y7ffUDCwIQvEdaTNwex1fTW5k/oxei52S0qtZYVdWJYAFG8IR2IaR8Tu8m/hyQw0f87XGScJrnsuNDkjdMxmFb3muLWSTIJ/g4JmC3eaolexDvtpkgpo4xCQHuRrN5uXL4gNIRD7oUgyPfGP8BPQH6fGutG50QhUnzYB89YhOzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UCKHVYT4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCKHVYT4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 859471F000FF;
	Thu, 17 Sep 2026 10:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789639753;
	bh=0aMOmJdQxMNrdF46i58nol3JmFvCWCcIPMuGuEg79b0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=UCKHVYT4kzDe/1nQP1C7+Q9WDxQ32Mb+uWSm0mOCF/nohyQRwpvyZcRZrXkAoOyFD
	 Fj7zMGLBU5bVlEewRso97kXKzTfilgUHnEBUsC9IvLcWsiSEJQtjCnhhRzA4r4fqKI
	 CHJsEw6qtGb556u/MAlAbZYWdOpGsAxJjWFQwU87kFNOn/3FZBjqjpMOgVhsbQmRR7
	 xKS6pA6eT8mfCSCkCX9aC2QzDNrmcxEVT5sbvIgKQ5A8XFf+hgVIRHIfFtOkTao0Ue
	 nG5qakaj6QWXBZjmViqutu9lqM75Y6kchm98J0qn73iRmaSJRRBfnNIbBRyHbEs9G4
	 ELvHjnuzucRsA==
From: Christian Brauner <brauner@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Tejun Heo <tj@kernel.org>, Christian Brauner <brauner@kernel.org>, 
 Shakeel Butt <shakeel.butt@linux.dev>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Meta kernel team <kernel-team@meta.com>, linux-fsdevel@vger.kernel.org, 
 driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260911182815.1992483-1-shakeel.butt@linux.dev>
References: <20260911182815.1992483-1-shakeel.butt@linux.dev>
Subject: Re: [PATCH v2 0/4] kernfs: don't hold kernfs_rwsem across
 dir_emit()
Message-Id: <20260917-gewesen-favorisieren-zurechnen-8a2d2c23a5ed@brauner>
Date: Thu, 17 Sep 2026 12:09:07 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=1479; i=brauner@kernel.org;
 h=from:subject:message-id; bh=2X37nh7K5uVquc+LvQVufKLrvahJ/uPC5JXRwMnPEgo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt3uPaNGPJNImHb7/mizzknPXL0Pbtsb1d+4S6F+92a
 sg78TT5a0cpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEHJ8x/JV5zRo8nceum5vl
 ee6M2U2iYnd1xGa/Xl1xanXRHYGLPdsZGebZvNwe+njjxFLhZStnXjrzQ33TVo3qCJngs0eVzwh
 8nMYAAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Fri, 11 Sep 2026 11:28:11 -0700, Shakeel Butt wrote:
> kernfs: don't hold kernfs_rwsem across dir_emit()
> 
> kernfs_fop_readdir() takes kernfs_rwsem for reading and holds it for the
> whole listing, dir_emit() included.  dir_emit() copies into a userspace
> buffer, so it can fault, and under memory pressure that fault goes to
> reclaim.
> 
> [...]

Applied to the vfs-7.4.kernfs branch of the vfs/vfs.git tree.
Patches in the vfs-7.4.kernfs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.4.kernfs

[1/4] kernfs: don't repeat or skip an entry when readdir resumes
      https://git.kernel.org/vfs/vfs/c/5ebcb578adee
[2/4] kernfs: resume readdir on the full entry key
      https://git.kernel.org/vfs/vfs/c/45126ed80bb1
[3/4] kernfs: don't hold kernfs_rwsem across dir_emit()
      https://git.kernel.org/vfs/vfs/c/341c65579de5
[4/4] selftests: cover readdir resuming at a removed entry
      https://git.kernel.org/vfs/vfs/c/a4354906005d

