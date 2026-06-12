Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8ED32572F;
	Fri, 12 Jun 2026 15:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781277099; cv=none; b=R/wnGda9OoF8L9ek4oev1nKNHEQhefNXAe4tCaVaaa6wOfRwRE7VAw361BwT0qB6Jgh3y2uazT+QOjAb7+Z41XZ7EoQ5omj06UX5HpLrHRmMrQCdcjXsPWts9zOdkQPBN5Y94twOjXxP+LoVVUGDI3/843m8iBGg+uQ/Y6vwT/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781277099; c=relaxed/simple;
	bh=Rh8ATzT+HiXY29qBzQCPjzEeXmS0oSdBhl80LRg0z4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PKuLIcLLRpleEHN+iBeVqFA2OyjxIH1txywA4FB1tJyRNOTX5R23K5j5X6oAS4ZREz8BGN5sZPXH83Hrms8vSl2at1pmg/gRD0WWNRoqP0dlv+3g8PtBLgirs0L+TKWk6WigfQTh3SzQA7dNONjSA/knbFUT56hK/2UlDcN583g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dMkTGGMi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dMkTGGMi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF3F61F000E9;
	Fri, 12 Jun 2026 15:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781277098;
	bh=J6KZAVQ5vF6bxVzPg3JfUaHJF5T/ihsBEKEGBmXUilg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dMkTGGMimBjA21XCnA2vF72BkfP5EmLFDQXfX2Rf5kdVsd3PV4FG70GctOpW/qVxZ
	 qOXihOrCBUviUGyOAL9LI80WQvCPVrv7n41JwfUPzr7KPp1P61T+CzySF1K70VeGkb
	 CxAhGlT1qKwtc/MD18uRMEjWQ2gfslc4yLbBp1sLphHEZl3/027ghsnY6VeA4b4vpa
	 n0zdE6lmd58Vx1Ve/zEsP1defS/TkHWOtm/0/gfEIBVq4ynoWIevm9Iv1F0a7YYgH4
	 oAwHZqA6SckMdIvZsLoksxM0HTTcZ5We+JYsEBXIfkLMekZKzCLH/N2Ll6rnZm2eAO
	 lS5XhcstYgntg==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 01/16 for v7.2] vfs kfunc
Date: Fri, 12 Jun 2026 17:11:28 +0200
Message-ID: <20260612-vfs-kfunc-v72-64b151bcd92c@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260612-vfs-v72-20facee87e19@brauner>
References: <20260612-vfs-v72-20facee87e19@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1758; i=brauner@kernel.org; h=from:subject:message-id; bh=Rh8ATzT+HiXY29qBzQCPjzEeXmS0oSdBhl80LRg0z4s=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTpKC4qvXstZ7aRTKkwr7Xc44l2yzMnJ//2m3xtzUqHn b8+Mr791VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCR76cY/nD1MT286PWP5a3R 92rF1AZRzx/PQua4ftvPb/mGd0G+FT/D/xQnucmcm363BbU2tdaZFv5dJZ9iaqOkJ/LdIORLxeG /PAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains a fix for the bpf filesystem kfuncs.

The bpf_set_dentry_xattr() and bpf_remove_dentry_xattr() kfuncs locked
the inode of the supplied dentry without checking whether the dentry is
negative. Passing a negative dentry (e.g., from security_inode_create)
caused a NULL pointer dereference. Negative dentries now fail with
EINVAL. The WARN_ON(!inode) in the bpf xattr permission helpers is
dropped as well since it could be triggered the same way, amounting to
a denial of service on systems with panic_on_warn enabled.

/* Testing */

gcc (Debian 14.2.0-19) 14.2.0
Debian clang version 19.1.7 (3+b1)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.2-rc1.kfunc

for you to fetch changes up to 07410646f6ff1d23222f105ccab778957d401bbe:

  bpf: fix crash in bpf_[set|remove]_dentry_xattr for negative dentries (2026-05-11 11:23:00 +0200)

----------------------------------------------------------------
vfs-7.2-rc1.kfunc

Please consider pulling these changes from the signed vfs-7.2-rc1.kfunc tag.

Thanks!
Christian

----------------------------------------------------------------
Matt Bobrowski (1):
      bpf: fix crash in bpf_[set|remove]_dentry_xattr for negative dentries

 fs/bpf_fs_kfuncs.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)
