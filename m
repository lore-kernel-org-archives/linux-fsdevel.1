Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA46E3E49F6;
	Wed, 26 Aug 2026 10:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787741262; cv=none; b=G9FhqEwKWfDIX4kFvyq4zCCsNhba7FLOJbW62Pq8jRE6D44dySQlsm7b6mTQrzEQhkyC2QxDG8MHHLR8Q9I/tpW6Us9SgD30TyT5a0cizP7dGxLgdy3HvXYT8gMT9n9TLmgQ2tKpgRp3ZGX4Vu3/3RzWRQRtGjeDDDfGHeLGaRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787741262; c=relaxed/simple;
	bh=wORddpQUoxxZEK3S19npcB7hSW0MP1npfZ3b9/K/ucE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WAC8lXfL9eXkDtvuSAMPJjSHPXryQF/2frHwNUQ+o+ApaT6xo5przaOlBcqMn052Osh+/S6mKlyw6PcZXQRZYfixJHQJueVNbbKhxewGj58t/ZxqCxK3uRzoWpbHD5cFB30Ew/5nPan+42loAJV30zAFk+jPm86pl1Wd7Q6eI9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=AHkVCzV4; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="AHkVCzV4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=JXNr6CEUXmj8N7QueMhznzhe1v4sbdf3gFq1tlg/g+k=; b=AHkVCzV46WiABn44nJHLiRpL3t
	2ygbV/3bTNLqF1OayPkTGraPIr/hRVHZBpjpE1pVzqeO7WMcFUynSDEEU5I/IG3DyVdMMMh4xazKF
	fXYukP6sf1mEcfb5RJvFIFqwmzpbVQHQvn+S/qsEF4IZoc5E0uyg/lIV7/Xe1K20ggXdn1gN186at
	XATrVr3POWLT8A6C3fvuDCJpAzzUn6kiesI/M0a3nLGii7mLULoLUjDETAUcuEYcogCvtEyqY3mF9
	p9IeXd4kXT2EGsmudnXk4zW6DIjYI34xEsVF7xipwY+Upuk4s+xEj4kYFuZXiXvpB2mC0YOAxuFJ+
	B6e8M9JQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wzBA7-00FA0g-2U;
	Wed, 26 Aug 2026 10:47:20 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH 0/4] configfs: add a basic selftest
Date: Wed, 26 Aug 2026 03:47:01 -0700
Message-Id: <20260826-config_selftest-v1-0-e364b07e91ac@debian.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACXEjmoC/x3MYQqEIBAG0KsM3++EklZarxIRZWM7EBaORBDdP
 dh3gHdDOQsrPN3IfIrKnuCpqQjhN6WVjSzwBFtbV3fWmbCnKOuovMXCWsx36drpMzccrENFODJ
 Huf5jPzzPC2PfbVxhAAAA
X-Change-ID: 20260826-config_selftest-9d84a5b1ec26
To: Shuah Khan <shuah@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 gustavold@gmail.com, linux-fsdevel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com, 
 vasilisalmpanis@gmail.com
X-Mailer: b4 0.16-dev-f8e9d
X-Developer-Signature: v=1; a=openpgp-sha256; l=1915; i=leitao@debian.org;
 h=from:subject:message-id; bh=wORddpQUoxxZEK3S19npcB7hSW0MP1npfZ3b9/K/ucE=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqjsQz+GfQussfA2Bz1wytoVT6WFsGGdkfc9BM3
 Zdlei97S9eJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCao7EMwAKCRA1o5Of/Hh3
 bVU5D/91/W9yhCdj0RXzGF60lZojUfwFBhCYHn3a816PyQSvSRdVqiUNSYF8Y5tsg1X4U7BrZts
 tZmDDxHBlcwfxpjYJXZZV4bsKT0fLhvWsMmJWqXvpAbZ7j0/dSY4IUKoXPSYoxIFzFi0708U5Mw
 QPnnOei0CXNV7D9+1+TeXbhbMidiViGTL08mXNxa8CPZBkYo+KFPKjqZD3W5YHOFcSklLd8r4oZ
 Nfxgttvp04FN7ReOhFlSJJPeSq7MTY4sC3kl8qz0CIV3rovNoUcS2Wznqin8hWhYN2IPzmO+xdN
 v4F2swpgnJDbrB2e/1SX6sjwzCrv9Sh50NHJxFXwwlRpxPnX2RaYxA9yES9lbD7szzNUy33FaEI
 0mNElKysJbAAxssNZJETIpP2E2e+1JVKnNMEKgwzmk1MPZFiu4ZcZ2QbfIC9FJWmqCAFzx8yLuT
 ldaFSJa59lmnaxcGQ9WSR8m/pfE89ow9HGxTYNz47mSXowG6330gAFbt8OKTw+/o5a3E8u2xZDB
 NjJbygr3zc/8v8mGpO1pA2Yo9NccpSW45ZPaoDI+wwdU4kcsBEia5Ll3khFr0q7mzf3H+qj2ZQw
 Pk7tJQXK4Ng2xLgoCF93PXlzaubt/mcpxuNl4s0bw96vGdUbd+5shqTa6NCtaR1NTZYpfFZdukB
 3LlzHZGZlIjQitg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

configfs has had no selftest since day one, which makes maintaining it
harder than it needs to be.

The good news is that it is not hard to test: nearly all of it is
reachable from userspace through mkdir/rmdir/read/write and symlink(2).
This series leverages the sample configfs module to do exactly that.

The sample implements no ->allow_link(), so patch 2 adds a subsystem that
accepts symlinks and patches 3 and 4 build the symlink coverage on it.

Patch 4 races symlink(2) against rmdir(2) of the target and reproduces the
use-after-free syzbot reported, so it fails until these patch land:

  1507d5b57e40 ("configfs: pin the symlink target's dirent instead of chasing ->ci_dentry")
  2251d0ed97c2 ("configfs: unhash the dentry before dropping the item in rmdir")

Both are in configfs-next.  The first trips the s_count WARN_ON()
in configfs_get(), the second the KASAN use-after-free in
config_item_get().

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Breno Leitao (4):
      selftests/configfs: add tests for the userspace interface
      samples/configfs: add a subsystem that accepts symlinks
      selftests/configfs: cover symlink and unlink
      selftests/configfs: race symlink against rmdir of the target

 MAINTAINERS                                        |   1 +
 samples/configfs/configfs_sample.c                 | 121 ++++++
 tools/testing/selftests/Makefile                   |   1 +
 .../selftests/filesystems/configfs/.gitignore      |   2 +
 .../selftests/filesystems/configfs/Makefile        |   8 +
 .../testing/selftests/filesystems/configfs/config  |   5 +
 .../selftests/filesystems/configfs/configfs_test.c | 481 +++++++++++++++++++++
 7 files changed, 619 insertions(+)
---
base-commit: a8406e6c0b793ce0788019683837c40855b55995
change-id: 20260826-config_selftest-9d84a5b1ec26

Best regards,
--  
Breno Leitao <leitao@debian.org>

