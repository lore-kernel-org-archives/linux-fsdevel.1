Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED081B0439;
	Mon, 23 Mar 2026 13:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774270857; cv=none; b=ShrFwWSDWgW7YxM1T6RhUcGznYFcdt+wX6QgvEXx3XGqycT6p5vJk5xDtz4mfR798RLpP0uOaPakrEWOQQuuG0OsJzPeh+WXLUTksaX0+UNXiiiabyCKipJ1groHzfcJQziDI0VtDunqgIEa1veFp8voS/iHkcgpgPVc18uYap4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774270857; c=relaxed/simple;
	bh=q66V72zwnT/uwcwMCawGvQ+p8pPyI7H1QHN9LFbjTrA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=p5rCyyBwQoqP45oCUdqXXwCuMY6WQEk4Zxl2QIciVezciixrDekL0R8oopz39CCwW7UqzEEF13w1ZqE3qxPD8Q4PyJXvKbW0hxnveCZFI7wR/srBvAxWdvJe1Ak14xniWkAQdoEfYoJk3wKjO3lTPzWv7aiKi20Mi4t6R9IALQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4843014BF;
	Mon, 23 Mar 2026 06:00:48 -0700 (PDT)
Received: from NH27D9T0LF (unknown [10.57.13.32])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B5A0E3F73B;
	Mon, 23 Mar 2026 06:00:52 -0700 (PDT)
Date: Mon, 23 Mar 2026 14:00:45 +0100
From: Emanuele Rocca <emanuele.rocca@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH v4 0/2] pidfds: add coredump_code field to pidfd_info
Message-ID: <acE5fYOgyVUYahIn@NH27D9T0LF>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patchs series adds a new field called coredump_code to struct pidfd_info,
as well as the relevant selftests. Note that the coredump selftests are
currently not passing, and the following patch is needed to fix them:
https://lore.kernel.org/lkml/ab2kI0PI_Vk6bU88@NH27D9T0LF/
I have not included it in this series as it is not directly related to the
coredump_code changes.

v1: https://lore.kernel.org/lkml/ab29J6KsQm8Xg3LR@NH27D9T0LF/

v2: Add coredump_pad to struct pidfd_info to ensure the struct has the same
size on both 64 bit and 32 bit systems. The issue was spotted by the kernel
test robot.
https://lore.kernel.org/lkml/202603211842.JCwUVYTI-lkp@intel.com/
https://lore.kernel.org/lkml/ab68fUmCK4An1UH-@NH27D9T0LF/

v3: Sending as a new thread, same as v2 otherwise.
https://lore.kernel.org/lkml/acBRj-DSCpqlKt6t@NH27D9T0LF/

v4: Split kernel code from selftest code as suggested by Christian Brauner. Add
Acked-by: Oleg Nesterov to the commit adding the coredump_code field. Thanks!
https://lore.kernel.org/lkml/20260323-hochsehen-kurort-862912a1d7b5@brauner/
https://lore.kernel.org/lkml/acEoVeBaP7bQRHLT@redhat.com/

Emanuele Rocca (2):
  pidfds: add coredump_code field to pidfd_info
  selftests: check pidfd_info->coredump_code correctness

 fs/pidfs.c                                    | 12 ++++---
 include/uapi/linux/pidfd.h                    |  4 +++
 .../coredump/coredump_socket_protocol_test.c  | 26 +++++++++++++++
 .../selftests/coredump/coredump_socket_test.c | 32 +++++++++++++++++++
 .../coredump/coredump_test_helpers.c          |  4 +--
 tools/testing/selftests/pidfd/pidfd.h         |  5 +++
 .../testing/selftests/pidfd/pidfd_info_test.c |  1 +
 7 files changed, 78 insertions(+), 6 deletions(-)

-- 
2.47.3

