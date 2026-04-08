Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D822BE7AB;
	Wed,  8 Apr 2026 15:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775661822; cv=none; b=PobzWEAy8+54HuBbGlLeptw4kLiBnqq49pm5L9tryLQI7EtXuI4fIwUYFLFdjQJVD2usm1nl1a5SKr/ws4k1uCHRWzLSaS74HS2bWKvaxKRAddX458IJFHKjfT0m2peWXiZ6t83Za+cVv72uoNe4Nd3iz2VheXGYxXootLdNfzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775661822; c=relaxed/simple;
	bh=V4JVgHXrmq3f0UU3dzG1XOpSin/Y60hcI8fTsfyXKhg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Nq06w5t/ad4vbqGl2nT2fgM7NSS9p+zT9MvMmqlWFfONKIkbrZGMM9fsfv/Em3O9gyItpewQvKfZgonMEtsowAZoabtjRC4b0MSXMnrifReFSFaqHYl3ixRtsvmMGQsIibDulo7Kh28o0nza3M6+D58a8V/J0WKFdaffkESw2Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LyhFM20a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LyhFM20a"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D004C19421;
	Wed,  8 Apr 2026 15:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775661822;
	bh=V4JVgHXrmq3f0UU3dzG1XOpSin/Y60hcI8fTsfyXKhg=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=LyhFM20abC4TnMcTwpfd+YbuccZ0GWiCzV4hamPLVrvIMvgf0+3MXbDvY02CiVz+J
	 zkFoLTw60gPXjznI6Ex4dgJ3fRxCfwAtc7laC5e+khCqEiO+ljQ/5O61le+wE0y3cS
	 OYz1Ip6fQ62BsNJNi5u+GHwF7gLG5f+jwZmXCM4Add+NxeEiRpTzdRZ15mos23KRiD
	 lji9hf++hV9+rXtlHLEpbHbRivGepRnxuZjoemGJjLU6UNECq1mZpKx2u7XrVHGCq2
	 5rtzrmH4EbD+lB8G9rGf2sAHBiZy3lo/VL9OvEQTHi4EzMhajDkxTnKFN5GNtTdHdg
	 ASdkujjeHuIAg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125AC10F9953;
	Wed,  8 Apr 2026 15:23:42 +0000 (UTC)
From: Alberto Ruiz via B4 Relay <devnull+aruiz.redhat.com@kernel.org>
Subject: [PATCH 0/2] fuse: fix CUSE device node leak and add regression
 test
Date: Wed, 08 Apr 2026 17:23:39 +0200
Message-Id: <20260408-wip-cuse-leak-fix-v1-0-1c028d575e97@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPty1mkC/x2MSwqAMBDFriKzdqCWotWriAvRpw6KlhY/ULy7x
 WUCSaQALwjUZJE8Lgly7AmKPKNh6fcZLGNi0kqXyijLtzgezgDe0K88ycOwxtSmUuVoQalzHkn
 /z7Z73w96cYWgYwAAAA==
X-Change-ID: 20260408-wip-cuse-leak-fix-e84494706d8e
To: Miklos Szeredi <miklos@szeredi.hu>, Shuah Khan <shuah@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Alberto Ruiz <aruiz@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775661821; l=1981;
 i=aruiz@redhat.com; s=20260408; h=from:subject:message-id;
 bh=V4JVgHXrmq3f0UU3dzG1XOpSin/Y60hcI8fTsfyXKhg=;
 b=OA0l/p3WuhK+V3jOEb/AZMhxCC2gZjORt7zafiyzg0S0boS4nqbL8plKeIXgG4PN7H8rBD4WP
 e9RLRkfSuiHB7yJg8PVNVPupdrqZIia4U5cvC58VyKDWhWhnPKjd3zx
X-Developer-Key: i=aruiz@redhat.com; a=ed25519;
 pk=ZJyUFl31NDNjeRWoQa/6I6bV5lb8axrDvpj9uGd+NvU=
X-Endpoint-Received: by B4 Relay for aruiz@redhat.com/20260408 with
 auth_id=727
X-Original-From: Alberto Ruiz <aruiz@redhat.com>
Reply-To: aruiz@redhat.com

In cuse_process_init_reply(), if device_add() succeeds but cdev_alloc()
or cdev_add() fails, the error path calls put_device() without first
calling device_del().  This leaves a stale /dev node that permanently
poisons the device name -- any subsequent attempt to create a CUSE
device with the same name silently fails with ENODEV.

The fix is a 3-line change: redirect the cdev_alloc() failure to a new
err_dev label that calls device_del() before falling through to
err_unlock.

Patch 2 adds a kselftest that reproduces the bug by forcing cdev_alloc()
to fail after device_add() has succeeded, then verifying that no /dev
node is leaked.  To trigger the failure deterministically, a
CONFIG_FAULT_INJECTION-guarded module parameter (cuse_inject_cdev_failure)
is added to cuse.c.  The test falls back to failslab with stack-trace
filtering when the parameter is unavailable.

I'm on the fence about the fault injection parameter in patch 2 -- it's
only a few lines and it's guarded behind CONFIG_FAULT_INJECTION, but I
understand if it feels too intrusive for production code.  Happy to drop
the kselftest or rework the injection approach if the maintainers prefer.
The fix in patch 1 stands on its own regardless.

Signed-off-by: Alberto Ruiz <aruiz@redhat.com>
---
Alberto Ruiz (2):
      fuse: fix device node leak in cuse_process_init_reply()
      selftests: add CUSE device-node leak regression test

 fs/fuse/cuse.c                                     |  17 +-
 tools/testing/selftests/Makefile                   |   1 +
 tools/testing/selftests/filesystems/cuse/Makefile  |   7 +
 tools/testing/selftests/filesystems/cuse/config    |   5 +
 .../selftests/filesystems/cuse/cuse_leak_test.c    | 406 +++++++++++++++++++++
 5 files changed, 435 insertions(+), 1 deletion(-)
---
base-commit: 631919fb12fe7b1f0453fe1035e62ce704bc3923
change-id: 20260408-wip-cuse-leak-fix-e84494706d8e

Best regards,
-- 
Alberto Ruiz <aruiz@redhat.com>


