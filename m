Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B3441A797;
	Fri, 14 Aug 2026 13:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786713084; cv=none; b=JegsGdaitMBhQYystpOdGIn+P3VzfuHPmJVZCx4+lgOMGqdc4/lf7HFDL2H7LaaCLrmb7JXC0Kii1l0vEa/zxqhVD/tCKoOK3Fldw/xawiNjYCF3CAYhGIah8o2Odjbu2KkRcqoSetMvRcj1kZAfrZmqWiK4mCgbjur+Y+VBWpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786713084; c=relaxed/simple;
	bh=itMZYoQYwJNn0/16Do6YkUihWmpVU5a+81GvdtP3DQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c8maettMFukHHJ1vkoLPuarJdXL+p+L0zzUE32wo9swJZR2ZHit0jYTst48V9PoAGUK8eJ9VGKiS1x6NEUutiqK+DOiIQHCen0xc+vm954JfsGM54HH3yKvQYQEz152c1/fK+vFqgrAgK5JrTUZuWBp/e+AXEQcxoTV48k1w6/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZxuxL0M+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZxuxL0M+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD3521F000E9;
	Fri, 14 Aug 2026 13:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786713078;
	bh=IREdlJek16FwaMFQwYrD6J8Rgvv53U5XMGwf5giqkRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZxuxL0M+1VUg/yfWpibpeOFysHzgC0sFk1PaiBlUlSOTg5Py007FLemYVqEl1hVmk
	 nLnJPkH6CNdo0AHosyGoK36kcu3oty+YynyfBY1UyijLYReqsANulBR4CrEKvr3NI2
	 nlno09wWuBP9Lk+rDCfJmDIBL0eidH4ZNZZjfyJEQyP11c41EmCufahOJpX4ojnwHh
	 pjzCrll8ehe/dAPP3gNlja72RX66gBRaOXu0PxlJYub1V2OIaX2Ep/Ged7u3ndgcYZ
	 PBx7FBvrWXWGPG2tDd35nfjHMU/AXW/OxmdNQJ95ncuXVNhivhYR09cItGpN4vcWqD
	 YAz5YwTI4u+Pg==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 02/18 for v7.3] kernel misc
Date: Fri, 14 Aug 2026 15:11:13 +0200
Message-ID: <20260814-kernel-7.3-rc1.misc-ac735b47a231@brauner>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260814-vfs-v73-6e884cb31ac9@brauner>
References: <20260814-vfs-v73-6e884cb31ac9@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1150; i=brauner@kernel.org; h=from:subject:message-id; bh=itMZYoQYwJNn0/16Do6YkUihWmpVU5a+81GvdtP3DQ4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTVC3+aefKmvCvTK4nk/Z/nX2Lnk7XlZv98me3a2veVs T/4eHUWd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyk/zYjQ/uia7+kdp3OLWav N/o7cd6qRScYd4Zm+z6TqAiTORQ6x5aRYeeLU5yfTx6JXWWdXuC9P/jJ9m/KWxgb9K7aZl+6+eZ VCTMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

- fix coding style in the exit path

/* Testing */

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e52491777482:

  Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/kernel-7.3-rc1.misc

for you to fetch changes up to d7337cad4dbe6caf9535d3539daed353dd425dc1:

  kernel: exit: fix coding style missing spaces (2026-06-29 10:29:22 +0200)

----------------------------------------------------------------
kernel-7.3-rc1.misc

Please consider pulling these changes from the signed kernel-7.3-rc1.misc tag.

Thanks!
Christian

----------------------------------------------------------------
mingzhu wang (1):
      kernel: exit: fix coding style missing spaces

 kernel/exit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
