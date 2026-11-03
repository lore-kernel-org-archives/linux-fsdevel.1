Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793724862;
	b=ijhj2dyjHfHhLmD7whGA11knX69TGCUSJ23vLIV0GRPOQN8mGf9h3OiRR0VO7HdCA0T+
	 mB2jiFv1THqF1cX4ZktJYgxWMp4IU5eOpz23T5thRs222p0UBIgTIrwQ8Q72y2K9LXDEi
	 0Hu3mLHGLniDhC+5K7DiKK0T6bbCJ4usOLYfzulGIALAJh9Iat8G1OMWQI8ismr/4PnYe
	 zOiKsQp2JDUdci9XNxljx6d2R3sFv/fkbEGfcxRgL/uQ7mfVPcEupamaqfcSQcfEpTrjm
	 KBA01ZMRbN6u0/zHM7ReMhtNIMUk9N05lXzEJKFKu4AlwyuKM6cy/1E2bqlncJUk/XA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793724862;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=vxdw5k8JXp3VH90wFYbwMiOBBanWxY/Kd80uK9Q7CRw=;
	b=jx0/+CPbSpaq1menVFas5V7oRtR5tGzz4FW6vLCTlcjCC4fK1OiG4p9LHxUx6ZI4jg8y
	 zfIR3z8iegZt5SJWDz3RkrdTig/QS1UCTABLKnF60ORmh6cfDixIe9f95JpzwhpE7rZt+
	 2vyoL8ACh9qkXkA8esf6DC8QKHdLCDVpZVQDRC/RXmdg/G0yFYfk21sc2GVVzLZd736mZ
	 t5/5C53mWJeecDBZxryVSJLr8QnIK/xPIKkmpJPvBsv+UPyWkmrG2d2S0a57pU2jRYAE2
	 l412WxyV5oq23+zf3JOQxu/wommDe8n+rv19WcPR0jGddcLWpP21ztb20BuEyJRHDag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="cs8/miqg";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A7B606A328;
	Tue,  3 Nov 2026 16:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cs8/miqg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B651F000C1;
	Tue,  3 Nov 2026 16:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793724862;
	bh=vxdw5k8JXp3VH90wFYbwMiOBBanWxY/Kd80uK9Q7CRw=;
	h=From:To:Cc:Subject:Date;
	b=cs8/miqg0tUcbThCODMeDQlMoZjRkfmzFPxEnBxPPSJ//H2Fp3ViLDSMDcdgw5kqh
	 bd7mPUnMKcAKXkAYpG4tFhPcqxro1ePtMqUfqG4WZkymD7XNtZ66kgUrhaSR9IB/UJ
	 F/SDJFRtvyNneYxXUXPo3FraL3e/8Y+wLFQomeDd9EegOBTFkNGB4oy/LXhl68mnx1
	 aHQwPdxJutXVgv62umzbdP/6ARwu2PDXMaTB2Em0OMeltAGlYDoFwpi5MpEB5vABPV
	 C9jzDnqoxtlRLVrgc/pKl50VivHi4U750dN1k+ZM2Vmn0NcQMwjDp0HN8IYmFtZ2AL
	 t0tPJModPogmw==
From: Sasha Levin <sashal@kernel.org>
To: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: Sasha Levin <sashal@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Shuah Khan <shuah@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/fs/mount-notify: fix the indentation in the fsmount test
Date: Tue,  3 Nov 2026 11:54:14 -0500
Message-ID: <20261103165419.687806-1-sashal@kernel.org>
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

A few lines in the fsmount test are indented with spaces instead of a
tab. That puts them deeper than the ASSERT_*() in front of them, which
ends in a for loop with an empty body, so clang warns:

  mount-notify_test.c:338:18: warning: for loop has empty body [-Wempty-body]

Indent them with tabs.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
Found with clang 21; KernelCI's clang builds show the same warnings.
Amir's pending fanotify series moves this file to filesystems/fanotify/,
and its rename still applies on top of this.

 .../filesystems/mount-notify/mount-notify_test.c          | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
index 6381af6a40e30..6c95c275b1629 100644
--- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
+++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
@@ -337,18 +337,18 @@ TEST_F(fanotify, fsmount)
 	fs = fsopen("tmpfs", 0);
 	ASSERT_GE(fs, 0);
 
-        ret = fsconfig(fs, FSCONFIG_CMD_CREATE, 0, 0, 0);
+	ret = fsconfig(fs, FSCONFIG_CMD_CREATE, 0, 0, 0);
 	ASSERT_EQ(ret, 0);
 
-        mnt = fsmount(fs, 0, 0);
+	mnt = fsmount(fs, 0, 0);
 	ASSERT_GE(mnt, 0);
 
-        close(fs);
+	close(fs);
 
 	ret = move_mount(mnt, "", AT_FDCWD, "/a", MOVE_MOUNT_F_EMPTY_PATH);
 	ASSERT_EQ(ret, 0);
 
-        close(mnt);
+	close(mnt);
 
 	mnts[1] = expect_notify_mask(_metadata, self, FAN_MNT_ATTACH);
 	ASSERT_NE(mnts[0], mnts[1]);
-- 
2.53.0

