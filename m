Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794447628;
	b=dfwxlkRnmReFQnBiuBLZ0Nljryq2JQzO3AntqJXZ8FDd1c6JF4XVI05vXlBBSnyfirh4
	 nsGQAUKPG1DMZIarGIkEmT+63OR4u/OIrC0fk9fkGh1KDmhWs2KSi5t0GHEGrMmahIY7u
	 e50J5EZgroQ7p2fNK2rag0HFUDCYr3wzWuHKfnYa6RzuRBV/loSbwR/gibDn1kpP21EQW
	 nwhZ/EZHsiHjHqXnhg1Xvg66NIw10db0321VElzW/apPU3cU5Mvin8Mwz+lA1yefVoGBB
	 g0s+9HJfn7zYw1UtqQSKfsISn5ED7G6bJ1WOpuYSDu2CV7vBM7ukZl6LinXVuwNtxXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794447628;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=/7JN4d19OpFHvBR2Ri6GsbzacJ+6v7i/b4y+9yVieW8=;
	b=q0cjfbAsclNBQwG6riA18K0aEDen8Q6XbAk82408xqyfmyw2FItInZFHrmKUZHlNixnY
	 AdihsgKHmgQ3S0jg2GmsTI/lV/wx8RsesCwGnyd6/xAYnJwOIB37U6DlgPz9CP711drUm
	 z5Yc4AY+CnbH32cKw4WS2VJ+HHH8ymMl6Eu+po2LFwNJomyXvmqrhaz94nWloUmkxWedH
	 gS5FVLpSfPj+9xDZ0JrJCzvOiMjPi+60oR7CVi47AxZrhcA+XQNOP3rbVWHCyZOqkun4z
	 +Plzx4vll5XPdu+hRcfskvjw6FZwb94JRNIwS1tF2uesso2/if0qPBvDWyHgBUXqHxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PixSkOzW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4D6606A32E;
	Thu, 12 Nov 2026 01:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PixSkOzW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B0261F00A05;
	Thu, 12 Nov 2026 01:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794447627;
	bh=/7JN4d19OpFHvBR2Ri6GsbzacJ+6v7i/b4y+9yVieW8=;
	h=From:To:Cc:Subject:Date;
	b=PixSkOzW9hIL3ixGtxZKFqJEarO1g+P0gmy8e2zTSVoOiSXTDyI1sP+Ziv02uOZBb
	 a1RPYToiX65Uydq3XnGvMpUE20JDT1rN9ZehyULqCfWJSXhCqcONPpSNqoOCrXwVou
	 wAzYeQudh3+W2rMaCmqfIsyQCa3ttoAQv8/FuWSjQ3sPoBhKzkvCuNWR/oZLcdVENV
	 WqpcERePW9vNdxwNItHMxssg4CNOacFW8FNVMZPwPE3+mVV6uGZwWhoh+WNdEhfA8n
	 6NX202EksQ3/ANXAOsbEmGx2M3ue2KZOdaoWpLkkti+9DJGJVVMf5bKm6gZwL7UBfe
	 AESIpJNtHqAKg==
From: Sasha Levin <sashal@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>,
	Shuah Khan <shuah@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/filesystems: include <fcntl.h> in wrappers.h
Date: Wed, 11 Nov 2026 20:40:25 -0500
Message-ID: <20261112014025.1243753-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

openat_o_mkdir() in wrappers.h uses O_DIRECTORY, O_CREAT and O_EXCL, but
the header doesn't include <fcntl.h>. fscontext_ns_test.c doesn't
either, so it no longer builds:

  ../wrappers.h:116:32: error: 'O_DIRECTORY' undeclared

Include it in the header.

Fixes: b536a4aa16ea ("selftest: add tests for open*(O_CREAT|O_DIRECTORY)")
Reported-by: kernelci.org bot <bot@kernelci.org>
Closes: https://d.kernelci.org/test/maestro:6af49b775b429d354e37819c
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202611110221.YzAZrCXO-lkp@intel.com/
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
Every selftest that includes wrappers.h builds with this, gcc and clang
on x86_64.

 tools/testing/selftests/filesystems/wrappers.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/filesystems/wrappers.h b/tools/testing/selftests/filesystems/wrappers.h
index bc58bdb800631..09f02f67487c6 100644
--- a/tools/testing/selftests/filesystems/wrappers.h
+++ b/tools/testing/selftests/filesystems/wrappers.h
@@ -5,6 +5,7 @@
 
 #define _GNU_SOURCE
 
+#include <fcntl.h>
 #include <linux/types.h>
 #include <linux/mount.h>
 #include <sys/syscall.h>

base-commit: 13419eff849a88a276dec97fa62a532dc7fff400
-- 
2.53.0

