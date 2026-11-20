Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795156188;
	b=s+ziBP79v0PL0+gLPeg5PaiGvYsHH8/43l2C4Jp40INefwwe9YV9uZBfA77Ywyvi7GDS
	 PUzlmmw0VI7r9mpdH9MClX7AgOZ2VgBZ8e1RSroU4WivqD6yF7D+JNqFSdeN9PIc9X4On
	 Mz7IR/6Zezq5O4D3kizgwXCYRTCcBLHODpWz3UJHdicfUiNZ24unfilamhobpyLdZZ4Hu
	 GxpZwbO4jgr3x5gJWT9hD9ISFd9uL1/BX9d+o507N/9a13oz27qiWL2wCJ+kkhUlzzthE
	 uptQEMqEYIp2+P2zl5idU7TB9EpMawovSFvvdbhayScKPCHDORyldpo2hlRX59/4dUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795156188;
	h=DMARC-Filter:X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=O7iWL9lO+LbrXuEpmCeRZY/N3vE58iUlbinJdsU8EUQ=;
	b=Exsk71gNWZKd/6PGG6II/xZkN059Dk7ia5p31URbbnLryYK1314Ac2zeh2e01f3zRiV7
	 H5s+WGOh3Ahd9JbG4Ge/3fEb/GtimTlpWqGcyunCwc80JgL/MnsOwPJGormTPrwU2b/61
	 S71eb8FzqCQ25FthZ+CgC+qlrx4F2Z0x/5bo37/k9NRLLCqOoNZFTNDdE/DPC5hV3QjE5
	 BLIn353oAtHkB2ywqWQk1JGKqhUrcZzhpEoBcvjrUqX4GkRv/ruPRGglot/lM6s9h3jql
	 kaQtI20MtmIJ+fl7/tuEaqC/23ezQqj4Rod89zKg2SDlL6ZLw4ti7/zXoxIAqTJALAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AA5606A32A;
	Fri, 20 Nov 2026 06:29:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5AA5606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c2960f8ce4ab11f19a56ed5b684f684d-20261120
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:2b8ee60e-b662-43b4-b1dc-4da4859f0e9b,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:4ff7df8b7421775660aa87df3c415b5e,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50|99,EDM:-3,I
	P:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
	,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c2960f8ce4ab11f19a56ed5b684f684d-20261120
X-User: fuqingshuang@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <fuqingshuang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1583078856; Fri, 20 Nov 2026 14:29:38 +0800
From: Qingshuang Fu <fuqingshuang@kylinos.cn>
To: Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Shuah Khan <shuah@kernel.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qingshuang Fu <fuqingshuang@kylinos.cn>
Subject: [PATCH] selftests/proc: skip fd-003-kthread if run as non-root
Date: Fri, 20 Nov 2026 14:29:33 +0800
Message-Id: <20261120062933.3169112-1-fuqingshuang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
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

/proc/$KERNEL_THREAD/fd can only be opened with ptrace access, so
openat() on the "fd" directory of a kernel thread returns EACCES
when the test is run as non-root.  kernel_thread_fd() conflates this
with "process is userspace process", the scan over /proc runs to
completion without finding a usable descriptor and the test exits
with 1 (KSFT_FAIL) instead of 4 (KSFT_SKIP):

  $ ./fd-003-kthread; echo $?
  1

Distinguish the two cases and skip the test like the rest of
selftests/proc does when privileges are missing, so that unprivileged
runs report "skip" instead of a false failure.

Fixes: b2f5de0334f0 ("tools/testing/selftests/proc: test /proc/*/fd a bit (+ PF_KTHREAD is ABI!)")
Signed-off-by: Qingshuang Fu <fuqingshuang@kylinos.cn>
---
 tools/testing/selftests/proc/fd-003-kthread.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/proc/fd-003-kthread.c b/tools/testing/selftests/proc/fd-003-kthread.c
index dc591f97b63d..e939a7c5f546 100644
--- a/tools/testing/selftests/proc/fd-003-kthread.c
+++ b/tools/testing/selftests/proc/fd-003-kthread.c
@@ -36,6 +36,7 @@
  *
  * Return /proc/$PID/fd descriptor if process is kernel thread.
  * Return -1 if a process is userspace process.
+ * Return -EACCES if run as non-root.
  */
 static int kernel_thread_fd(unsigned int pid)
 {
@@ -88,6 +89,8 @@ static int kernel_thread_fd(unsigned int pid)
 	fd = -1;
 	if (flags & PF_KHTREAD) {
 		fd = openat(dir_fd, "fd", O_RDONLY|O_DIRECTORY);
+		if (fd == -1 && errno == EACCES)
+			fd = -EACCES;
 	}
 	close(dir_fd);
 	return fd;
@@ -168,6 +171,8 @@ int main(void)
 		pid++;
 	}
 	/* EACCES if run as non-root. */
+	if (fd == -EACCES)
+		return 4;
 	if (pid >= 1024)
 		return 1;
 
-- 
2.25.1

