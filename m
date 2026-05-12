Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B97E399892
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 12:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778589907; cv=none; b=PmoLmhIf3Q8ua3R8S1aH+cztV+mRLDRJtnv3Bg+rCb8ceHXyUqp7JBzUeJe061hP21eyGil2wwF15iMTz290lPhHK9m01fgCAcrE73xYZMgzxKrLGoXwAnoRrgeV2VwqqNBk0JNt3mwW9C63BEY6MOL6ZWcvEbYgcHicQGWWsvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778589907; c=relaxed/simple;
	bh=2NNIxOSIkBmwbGz2DVVksIrP2w2wwA/R494iNTEjTG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QGW3YwCBxpA2UZo2qYcOs8kf71lYM5S5KS3W+c1CisNuc/TvMHx0pA/UtkPWlPbp7sgZKvDDituF+18cYjvbPZJbx9g/dbXsqerjMDaCwXzr1dXW1apBU7Qjhssris/qydwxYhyUOcZG4+BNUitjJuUiG30IPKS8BCLF3iAIJU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uDaIqAf/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uDaIqAf/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15BEFC2BCFA;
	Tue, 12 May 2026 12:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778589906;
	bh=2NNIxOSIkBmwbGz2DVVksIrP2w2wwA/R494iNTEjTG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uDaIqAf/4y4RNpbai6O6qTGGlGFopzBvARvSkg5uvwlGLhKl55osnlgbZUOlqgW8V
	 eV57MJYZgu0lF8UqT4p05sIy1LIAn9FCTyoNpMfZebceT+WxPcqzDw9KwkI/jN6Gf/
	 Szb49pviyb6zOZuN70zDsJeIDKTIRzFslYU2dkKP3t+IZ59xv5eoy3694dieIS7CV7
	 9o++xx4xm5Z0VUpYPtrpRjjZmyO+zBLWJ63J8l0Mvrie1LELzwK3kh4dCQ2J+Nnz9m
	 yi2KmqrmtDInKuLHBVlEIyROQfQiNFlS9BawcOmPCLsf7K157GO37UycVIzDgpT9Uw
	 KvrCf++kwUe6w==
From: Christian Brauner <brauner@kernel.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] sync_file_range: delete dead S_ISLNK code
Date: Tue, 12 May 2026 14:44:49 +0200
Message-ID: <20260512-entrechteten-liftanlagen-173d7e91c8b1@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <295235c7-7f68-4554-bb6f-85398beca350@p183>
References: <295235c7-7f68-4554-bb6f-85398beca350@p183>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=866; i=brauner@kernel.org; h=from:subject:message-id; bh=2NNIxOSIkBmwbGz2DVVksIrP2w2wwA/R494iNTEjTG0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQxK5w9JRqU6/Jb7eV9i/m3f7pvurG+oOLk8wp7ZvbNC 87eCZgR0VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRbUyMDAcd71zhNt316smc 77OfuV1b21y/9ctccdakqmkq+i/Wz2Fn+O97wmWt4TGXlSYPdjyZs5ZxygyT82YOy28tYRB+IdN ofY0BAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 05 May 2026 21:55:29 +0300, Alexey Dobriyan wrote:
> Symlinks can't appear as opened file.

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

[1/1] sync_file_range: delete dead S_ISLNK code
      https://git.kernel.org/vfs/vfs/c/a38e953240d2
