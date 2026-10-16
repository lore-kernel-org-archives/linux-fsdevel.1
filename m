Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D213BB693;
	Fri, 16 Oct 2026 19:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792180017; cv=none; b=TR+DFHOCrwhdjy9j60G7v7nTUH6MqVweefUlaTSQTj1yfNLFD6yAOst06oCD7Q/VbKKf9HgCdd4bLm8KPWtqLsuiBV1RNvN53rN2F3cL0y5GNLt9jJN+aj/b/Hk5PnhNrrOY6A0vCBYzeNuS29fv1zSL9cIO6RWIziAkXYnAN80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792180017; c=relaxed/simple;
	bh=pqBZErlsZfE/Y9XstmP5RbkNp+v46GsHvudhHl/4LxI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HMdRaRK3XvGMZzj/YFwrHdPVU+p59XQ1qCfGwrjMylgGPXcuUSARcWE7XpIPWGRtYdilsekU5N1QogwrsN6maRPoEzs7ZugZY4//JNXWerFFjUVEPEaVj0Py4c9sZKc3ey5mqqgJCvrVeMSoz18koJdSDX2duKteNLIu6XxeM+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MvTRRMBM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MvTRRMBM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C32CB1F000C4;
	Fri, 16 Oct 2026 19:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792180016;
	bh=WozV/uUsWcZP4A+IXIHwEik5HiNR6v3KoUW7wI3XZ28=;
	h=From:To:Cc:Subject:Date;
	b=MvTRRMBM6Ft9C1FNGN/TESwoDtPQWE6tuIYwv6NWjV+oTeDWd5X4e1wowWZpbt4Vh
	 uv0gntK0RGMeLxHblzffqwhFQ+4SagxKwzN8UjuAdROOkcWqqG8K5kn9jYoz7gnlqo
	 YSg5fTEURyX4VWyMA/RnpsX/8S+xRWaRPxjIkogb5gyKpQLu9DnGboLeQ+MJvVtLmX
	 mH5dAAOl21oIxo2laoEPOvQ1jijs4qA2Fa/ElG9l3ySsOCuHrTev0ncgqbbj3yrdxS
	 eQ/Tit+cq7gGCq2KwXv1RDlZ/VcGDAG5glnL6v7O8JPtCSXQqlSexQbn26vyF4mUEB
	 sTVJlu74TMGgA==
From: Arnd Bergmann <arnd@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	Andrew Halaney <andrew@amutable.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Jan Kara <jack@suse.cz>,
	Oleg Nesterov <oleg@redhat.com>,
	Kees Cook <kees+treewide@kernel.org>,
	NeilBrown <neil@brown.name>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] coredump: reduce stack usage in vfs_coredump
Date: Fri, 16 Oct 2026 21:46:39 +0200
Message-ID: <20261016194650.1580988-1-arnd@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

A recent patch changed the coredump code in mostly harmless ways,
but after this I get a very high stack usage in one function
that was benign before:

fs/coredump.c: In function 'vfs_coredump':
fs/coredump.c:1313:1: error: the frame size of 1872 bytes is larger than 1536 bytes [-Werror=frame-larger-than=]

This happens reproducibly every couple of randconfig builds on
s390 with gcc-16 and seems to be caused by kasan checks causing
local variables to be spilled to the stack.

Marking the do_coredump function as noinline_for_stack avoids
the problem here, instead I get only 464 and 672 bytes in
the worst case for vfs_coredump and do_coredump, respectively.

Fixes: 3209535cd39e ("pidfs: record the coredump on the dumping thread's pid too")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
If anyone wants to look at it in more detail, here is the
information I have:

randconfig: https://pastebin.com/raw/bskKJixQ
assembler output: https://pastebin.com/raw/Wr1V8kRS

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/coredump.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index b25ef2ffbdee..82ef9d115999 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1198,8 +1198,10 @@ static inline bool coredump_skip(const struct coredump_params *cprm,
 	return false;
 }
 
-static void do_coredump(struct core_name *cn, struct coredump_params *cprm,
-			size_t **argv, int *argc, const struct linux_binfmt *binfmt)
+static noinline_for_stack void do_coredump(struct core_name *cn,
+					   struct coredump_params *cprm,
+					   size_t **argv, int *argc,
+					   const struct linux_binfmt *binfmt)
 {
 	trace_coredump(cprm->siginfo->si_signo);
 
-- 
2.53.0

