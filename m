Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9D53E49C9;
	Mon, 31 Aug 2026 11:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788175318; cv=none; b=DOOQhjJc0tLCxuUc4+XrhujuS9UfmSgf0dDJMqazhPd4UIIu2hlNt+aSTmiKcqJGw2D7MdWBQWq8idrwTcDrMV2lssEqgP1IOcZevK7NUa1vf8F79uoSLBr9VXIfpDKp4xrfVtdFsT9twyVvEeLNu/yF5MIlK1Eh80UbLwYISds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788175318; c=relaxed/simple;
	bh=93dvwazGQmyhpLGOG6YC1oHD3PgppRUiN9FyAp69QeA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gBplB78XQnTrECFDynNFoEhDOPEYBGdTH4iNZjhxmAQD0mQloEqXaoopPbd1FaSjpdJTPeLmGkiuWnqjgQl0BoYdInvEZbYzf9zk53aBswajn0r+AJ+c+jEhDb1DNZ1l6HJ5sITJWupqUU1OkEk3Vt8ju3PKycok0xQAfM7UyzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekNDTPCQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekNDTPCQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A6941F00ACA;
	Mon, 31 Aug 2026 11:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788175316;
	bh=vvhqs/opFW1MtRaaw0rgUb+gCmDOYHPkin1TdpYv3Uk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ekNDTPCQdWkEoSfNIbvVZXs2NUYC7fLMmBBvnOWaxsvJ+6lft/Go7ZNrqrufS1qxm
	 B/VlzNwrEvTVOkN3FUr/fExTnqUjI1TYzfZQwzoqdnRDFLOdkmVUc7Rk8PPJXghIeU
	 jfD0ZWDxJRtk4qXnrz3tCqfOWs51QLVCTLX9ZOOD5D24jN+sl6d/YxT92SYHRtkzJg
	 QGOtq6RrHZaOyZixmn6MQgedIHjzJmjDVsZ+GbcWmdmvhdSPCo39AkbsUPSTTtDhz2
	 atGEsETzjwvTlPN44XbjHHrUWdr5TIMv+4GJIAeL9Aqm6lx0bygWRqz1TzOcw3av4j
	 E2yXCEvPCmMGA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 31 Aug 2026 13:21:20 +0200
Subject: [PATCH 08/10] selftests/net: SO_PEERPIDFD_THREAD
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-work-unix-passpidfd-v1-8-70cbfda0c7ba@kernel.org>
References: <20260831-work-unix-passpidfd-v1-0-70cbfda0c7ba@kernel.org>
In-Reply-To: <20260831-work-unix-passpidfd-v1-0-70cbfda0c7ba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Oleg Nesterov <oleg@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=3150; i=brauner@kernel.org;
 h=from:subject:message-id; bh=93dvwazGQmyhpLGOG6YC1oHD3PgppRUiN9FyAp69QeA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRNTd6omPdr8tFpGT13mZcY/On+Kp+0qWTDZ6azhmIPd
 iS2u0e/7yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjImTZGhjlsX2+sdVq45P8j
 A59dVk/c7yX4KQdpc8tPteIrrDA362RkWOX34H+w2slS65fuTxLsOa7/Kzrfmix8863Ya+Nnq5b
 qMAMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add tests for SO_PEERPIDFD_THREAD.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 tools/testing/selftests/net/af_unix/scm_pidfd.c | 97 +++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/tools/testing/selftests/net/af_unix/scm_pidfd.c b/tools/testing/selftests/net/af_unix/scm_pidfd.c
index 019c48e1cdcd..bbbd5e7b4fa7 100644
--- a/tools/testing/selftests/net/af_unix/scm_pidfd.c
+++ b/tools/testing/selftests/net/af_unix/scm_pidfd.c
@@ -32,6 +32,10 @@
 #define SO_PASSPIDFD_THREAD 86
 #endif
 
+#ifndef SO_PEERPIDFD_THREAD
+#define SO_PEERPIDFD_THREAD 87
+#endif
+
 #define CHILD_EXIT_CODE_OK 123
 
 static void child_die()
@@ -822,4 +826,97 @@ TEST(scm_pidfd_thread_creds)
 	EXPECT_EQ(ids.pid, info.tgid);
 }
 
+static void *peer_connect_thread(void *arg)
+{
+	struct sock_addr *sa = arg;
+	struct thread_ids ids = {
+		.pid = getpid(),
+		.tid = gettid(),
+	};
+	int fd;
+	char sync;
+
+	fd = socket(AF_UNIX, SOCK_STREAM, 0);
+	if (fd < 0)
+		return (void *)1;
+
+	if (connect(fd, (struct sockaddr *)&sa->listen_addr, sa->addrlen))
+		return (void *)1;
+
+	if (send(fd, &ids, sizeof(ids), 0) != sizeof(ids))
+		return (void *)1;
+
+	/* stay alive until the server has looked at our pidfd */
+	if (read(fd, &sync, 1) != 1)
+		return (void *)1;
+
+	close(fd);
+	return NULL;
+}
+
+static int peer_pidfd_info(int fd, int optname, struct pidfd_info *info)
+{
+	int pidfd;
+	socklen_t len = sizeof(pidfd);
+
+	if (getsockopt(fd, SOL_SOCKET, optname, &pidfd, &len)) {
+		log_err("getsockopt(SO_PEERPIDFD*)");
+		return -1;
+	}
+
+	info->mask = PIDFD_INFO_PID;
+	if (ioctl(pidfd, PIDFD_GET_INFO, info)) {
+		log_err("ioctl(PIDFD_GET_INFO)");
+		close(pidfd);
+		return -1;
+	}
+
+	close(pidfd);
+	return 0;
+}
+
+/* SO_PEERPIDFD_THREAD returns a pidfd for the peer's connecting thread. */
+TEST(so_peerpidfd_thread)
+{
+	struct sock_addr sa;
+	struct thread_ids ids;
+	struct pidfd_info info;
+	pthread_t thread;
+	void *tret;
+	int server, cfd;
+
+	server = socket(AF_UNIX, SOCK_STREAM, 0);
+	ASSERT_LE(0, server);
+
+	fill_sockaddr(&sa, true);
+	ASSERT_EQ(0, bind(server, (struct sockaddr *)&sa.listen_addr, sa.addrlen));
+	ASSERT_EQ(0, listen(server, 1));
+
+	ASSERT_EQ(0, pthread_create(&thread, NULL, peer_connect_thread, &sa));
+
+	cfd = accept(server, NULL, NULL);
+	ASSERT_LE(0, cfd);
+
+	ASSERT_EQ(sizeof(ids), recv(cfd, &ids, sizeof(ids), MSG_WAITALL));
+	ASSERT_NE(ids.pid, ids.tid);
+
+	/* SO_PEERPIDFD refers to the peer's thread-group. */
+	ASSERT_EQ(0, peer_pidfd_info(cfd, SO_PEERPIDFD, &info));
+	EXPECT_EQ(ids.pid, info.pid);
+	EXPECT_EQ(ids.pid, info.tgid);
+
+	/* SO_PEERPIDFD_THREAD refers to the connecting thread. */
+	ASSERT_EQ(0, peer_pidfd_info(cfd, SO_PEERPIDFD_THREAD, &info));
+	EXPECT_EQ(ids.tid, info.pid);
+	EXPECT_EQ(ids.pid, info.tgid);
+
+	/* release the connecting thread */
+	ASSERT_EQ(1, write(cfd, "x", 1));
+	ASSERT_EQ(0, pthread_join(thread, &tret));
+	ASSERT_EQ(NULL, tret);
+
+	close(cfd);
+	close(server);
+}
+
 TEST_HARNESS_MAIN

-- 
2.53.0

