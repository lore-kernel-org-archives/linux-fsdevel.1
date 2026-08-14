Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F80944BC87;
	Fri, 14 Aug 2026 13:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786713060; cv=none; b=sGeakELRKF9Hxb1uZ/iGKXI4dQyZ4povKy6TWrC0wpPA3MA6oJCFyBx1saL/WeEs5VCDTXTLfsjnV2i0tIctKk9tpVDQBDtzPmTSseIFWnFg7RdcqvnBfR3PH4ZB0h+CMkJuBkIIXPyarGMfk4DmGfI/V3snsFF0oNlbLnOyXqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786713060; c=relaxed/simple;
	bh=ffjNPrtJAUWSYb3ZvuYCGn/roEIVwFI2tDF0W07iGJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qj4SWo/NuqFQw3MtcLhTzKWl2NQUPbRknaSNdbXr2/mTVZgZx/DThe+//dB1xXf+zwj6PvSHCZrE3uutELkUNlBIoh+o65Eq4LlUq0wL5yb5Lza4L3B7EgWruQrftBgmPVv2xvnxv7zFkJwr2Cm/ucmWc5UL4VKHPFKrfmgN6a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PRUjWuiL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRUjWuiL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66FE81F000E9;
	Fri, 14 Aug 2026 13:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786713056;
	bh=y4mbEQVo/z6TVt9qausc6eBQgZ5D5ai1zQSbXh+A5kI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PRUjWuiLULqx3HzyWdx2DZT9/zKK/SxZRTz4zBNqr0ebxIq5WIaMzahcU7odZs/On
	 6IOA1FBdu6VTQnItkfNZgWVPgSFXWvhg572vuCDAvXP6/aEyzJQIYrrvCl2/j8KPFo
	 oAZPcx5PJvD42HRgOFt9IeW5mkVAswpNk7094h6rQZ05MjicTuA82ARLMZ1+Gq4Mfy
	 T8bMGmfL5C2bG3hEYksgl8xAR09tqXRFTyTQlatNU9lOnzVSrkLGqMM3wQCrQo31jF
	 s1jG+lkwqYPkHUcivJtm5RDx4wX/dyZiZM/1ZWYDuZmaiakvD3uCO94uqerrQB0sBI
	 mCEmdV92TzVNA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 01/18 for v7.3] ipc misc
Date: Fri, 14 Aug 2026 15:10:41 +0200
Message-ID: <20260814-illegal-miesmacher-trauben-c3da198a4112@brauner>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260814-vfs-v73-6e884cb31ac9@brauner>
References: <20260814-vfs-v73-6e884cb31ac9@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1139; i=brauner@kernel.org; h=from:subject:message-id; bh=ffjNPrtJAUWSYb3ZvuYCGn/roEIVwFI2tDF0W07iGJE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTVC19dM+mA7pGOf3E3K+rnXr148q1s2l45G4lTdwPFC 9wezGi+3FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARiUWMDN+rF28M5l7QNfvy 7PX536NEmXc7Zb/9cFMhsFSJxdIw056R4ZbfdFsTB9vCzY+W/1JIdLOOEe0++oN/7cutvCpSLy/ N5QAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This rejects mq_notify() with a zero signal number.

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

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/ipc-7.3-rc1.misc

for you to fetch changes up to 1184f5e8200902cae3e098ac68d8600ecdf6fe28:

  mqueue: reject mq_notify with signo 0 (2026-06-29 10:29:28 +0200)

----------------------------------------------------------------
ipc-7.3-rc1.misc

Please consider pulling these changes from the signed ipc-7.3-rc1.misc tag.

Thanks!
Christian

----------------------------------------------------------------
Yi Xie (1):
      mqueue: reject mq_notify with signo 0

 ipc/mqueue.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)
