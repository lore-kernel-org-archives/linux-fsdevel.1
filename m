Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B962E47FAE0;
	Fri, 21 Aug 2026 11:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787313161; cv=none; b=Mauf+sseHm9C/2dAof7EInZ0Z5klmRx29uXuOZ4r3roRm80oUAVjIz4+e6vCOQWwDPjvynRnSeaXQHjkOYY4U5lWtROzvc5RQhW5V7kTtwpOqCpPhbNkcVRr+H2vTS3c0JFFPcRdwip0GDdkCB9KOmjjBqfe+b9NhMSDy9rX7DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787313161; c=relaxed/simple;
	bh=f+bGwHTxfGMnIHvMPIqZQI7u/YXKAHmm2U55Ep6whvo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nqOiW4TDwKZ9x6dNwKCG3fvtosL29j308iFHbe/AXcOLSX4mAc5sbz+XB3OxtoLuuz9f9fJ+4vnvOOqI8jJHZX6ak8C+NeeNpC2bY0N9esI4vI2zKAQfBlIh49CSshjH6SDleziuqH5umIZZBXA4S1f7G23OrWtyT6SQ2FfSwE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCXZiUs5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCXZiUs5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA1F21F00A3D;
	Fri, 21 Aug 2026 11:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787313158;
	bh=izjHgHv/QjuCaAi/tGuqsjHx/DXmfYn+PQHWYmhf148=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=nCXZiUs5DX9vTeCB4cOKcRj2kFgbRKkQAeoM94Xa4qrCN8ipIRyrXUjkhP/ea++Xy
	 9FD1BxDXBzXgQSpSLxbfVcfLwJHdnn8UQvRwCLWG8MWrLpOPCf1NE1EYKRsG29RECr
	 C1omepBVDLW9MKJtej2MN5VXhcB5RWRfFeyJsnrONMQPJ6i4oqXIt6lmut0DUE6Pga
	 aldA1zA/8SZZ56iAYBFTLs3FghNGJz7Ns6M66FABGxEFFV5x1S9TfmTPTdDXo2njN6
	 iDr3P9+5lbErJQIYlTsR9h6+VFryp4f93XnQyGCdt4OHJL5yZBbdrI9dmHpawasELs
	 PraeD93AAvyRA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 21 Aug 2026 13:52:04 +0200
Subject: [PATCH 3/6] selftests/coredump: simplify the refusal tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-work-coredump-filter-v1-3-91f9a73ef03e@kernel.org>
References: <20260821-work-coredump-filter-v1-0-91f9a73ef03e@kernel.org>
In-Reply-To: <20260821-work-coredump-filter-v1-0-91f9a73ef03e@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jacob Lalonde <jalalonde@meta.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jann Horn <jannh@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Omar Sandoval <osandov@osandov.com>, 
 Jacob Lalonde <jalalonde@fb.com>, Shuah Khan <shuah@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-362b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=23451; i=brauner@kernel.org;
 h=from:subject:message-id; bh=f+bGwHTxfGMnIHvMPIqZQI7u/YXKAHmm2U55Ep6whvo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR1WH/sXz3n1cfUvFsqJZe9Mgyslzje3CUkvrhSspnhz
 XoO3puXOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYSKM/wv3J29xGFj9+jAi7K
 z0rdu23f67S2Xp3SOK3m/klLP5s/DmFkuHa6TV3yfYjlAebm3OP6a98d7C7eOGm5jUDmrLTuuiO
 afAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

A couple of tests send a coredump_ack that the kernel refuses. They then
check the marker. Make sure they all use common infrastructure.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 .../coredump/coredump_socket_protocol_test.c       | 550 +++------------------
 .../selftests/coredump/coredump_test_helpers.c     |  37 +-
 .../selftests/coredump/coredump_test_helpers.h     |   1 +
 3 files changed, 107 insertions(+), 481 deletions(-)

diff --git a/tools/testing/selftests/coredump/coredump_socket_protocol_test.c b/tools/testing/selftests/coredump/coredump_socket_protocol_test.c
index daff908232a2..a07546e79651 100644
--- a/tools/testing/selftests/coredump/coredump_socket_protocol_test.c
+++ b/tools/testing/selftests/coredump/coredump_socket_protocol_test.c
@@ -508,91 +508,79 @@ TEST_F(coredump, socket_request_reject)
 	wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
 }
 
-TEST_F(coredump, socket_request_invalid_flag_combination)
+/* An ack the kernel must refuse and how. */
+struct refused_ack {
+	/* The ack and how many bytes of it the server sends. */
+	struct coredump_ack ack;
+	size_t bytes;
+	/* The marker the kernel answers with. */
+	enum coredump_mark mark;
+};
+
+/* Send @refused, expect the kernel to refuse it with the marker. */
+static void check_refused_ack(struct __test_metadata *const _metadata,
+			      FIXTURE_DATA(coredump) *self,
+			      const struct refused_ack *refused)
 {
-	int pidfd, ret, status;
+	int pidfd, status;
 	pid_t pid, pid_coredump_server;
 	struct pidfd_info info = {};
 	int ipc_sockets[2];
 	char c;
 
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets), 0);
 	ASSERT_TRUE(set_core_pattern("@@/tmp/coredump.socket"));
 
-	ret = socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
-	ASSERT_EQ(ret, 0);
-
 	pid_coredump_server = fork();
 	ASSERT_GE(pid_coredump_server, 0);
 	if (pid_coredump_server == 0) {
-		struct coredump_req req = {};
 		int fd_server = -1, fd_coredump = -1, fd_peer_pidfd = -1;
 		int exit_code = EXIT_FAILURE;
+		struct coredump_req req = {};
 
 		close(ipc_sockets[0]);
 
 		fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
-		if (fd_server < 0) {
-			fprintf(stderr, "socket_request_invalid_flag_combination: create_and_listen_unix_socket failed: %m\n");
+		if (fd_server < 0)
 			goto out;
-		}
 
-		if (write_nointr(ipc_sockets[1], "1", 1) < 0) {
-			fprintf(stderr, "socket_request_invalid_flag_combination: write_nointr to ipc socket failed: %m\n");
+		if (write_nointr(ipc_sockets[1], "1", 1) < 0)
 			goto out;
-		}
 
 		close(ipc_sockets[1]);
 
 		fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
-		if (fd_coredump < 0) {
-			fprintf(stderr, "socket_request_invalid_flag_combination: accept4 failed: %m\n");
+		if (fd_coredump < 0)
 			goto out;
-		}
 
 		fd_peer_pidfd = get_peer_pidfd(fd_coredump);
-		if (fd_peer_pidfd < 0) {
-			fprintf(stderr, "socket_request_invalid_flag_combination: get_peer_pidfd failed\n");
-			goto out;
-		}
-
-		if (!get_pidfd_info(fd_peer_pidfd, &info)) {
-			fprintf(stderr, "socket_request_invalid_flag_combination: get_pidfd_info failed\n");
+		if (fd_peer_pidfd < 0)
 			goto out;
-		}
 
-		if (!(info.mask & PIDFD_INFO_COREDUMP)) {
-			fprintf(stderr, "socket_request_invalid_flag_combination: PIDFD_INFO_COREDUMP not set in mask\n");
+		/* The task shows as dumping while it waits for the ack. */
+		if (!get_pidfd_info(fd_peer_pidfd, &info))
 			goto out;
-		}
 
-		if (!(info.coredump_mask & PIDFD_COREDUMPED)) {
-			fprintf(stderr, "socket_request_invalid_flag_combination: PIDFD_COREDUMPED not set in coredump_mask\n");
+		if (!(info.mask & PIDFD_INFO_COREDUMP) ||
+		    !(info.coredump_mask & PIDFD_COREDUMPED)) {
+			fprintf(stderr, "Peer isn't marked as dumping\n");
 			goto out;
 		}
 
-		if (!read_coredump_req(fd_coredump, &req)) {
-			fprintf(stderr, "socket_request_invalid_flag_combination: read_coredump_req failed\n");
+		if (!read_coredump_req(fd_coredump, &req))
 			goto out;
-		}
 
-		if (!check_coredump_req(&req)) {
-			fprintf(stderr, "socket_request_invalid_flag_combination: check_coredump_req failed\n");
+		if (!check_coredump_req(&req))
 			goto out;
-		}
 
-		if (!send_coredump_ack(fd_coredump, &req,
-				       COREDUMP_KERNEL | COREDUMP_REJECT | COREDUMP_WAIT, 0)) {
-			fprintf(stderr, "socket_request_invalid_flag_combination: send_coredump_ack failed\n");
+		if (!send_coredump_ack_bytes(fd_coredump, &refused->ack,
+					     refused->bytes))
 			goto out;
-		}
 
-		if (!read_marker(fd_coredump, COREDUMP_MARK_CONFLICTING)) {
-			fprintf(stderr, "socket_request_invalid_flag_combination: read_marker COREDUMP_MARK_CONFLICTING failed\n");
+		if (!read_marker(fd_coredump, refused->mark))
 			goto out;
-		}
 
 		exit_code = EXIT_SUCCESS;
-		fprintf(stderr, "socket_request_invalid_flag_combination: completed successfully\n");
 out:
 		if (fd_peer_pidfd >= 0)
 			close(fd_peer_pidfd);
@@ -627,362 +615,72 @@ TEST_F(coredump, socket_request_invalid_flag_combination)
 	wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
 }
 
-TEST_F(coredump, socket_request_unknown_flag)
+/* Ack @ack_mask, expect the kernel to refuse it as conflicting. */
+static void check_conflicting_ack(struct __test_metadata *const _metadata,
+				  FIXTURE_DATA(coredump) *self, __u64 ack_mask)
 {
-	int pidfd, ret, status;
-	pid_t pid, pid_coredump_server;
-	struct pidfd_info info = {};
-	int ipc_sockets[2];
-	char c;
-
-	ASSERT_TRUE(set_core_pattern("@@/tmp/coredump.socket"));
-
-	ret = socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
-	ASSERT_EQ(ret, 0);
-
-	pid_coredump_server = fork();
-	ASSERT_GE(pid_coredump_server, 0);
-	if (pid_coredump_server == 0) {
-		struct coredump_req req = {};
-		int fd_server = -1, fd_coredump = -1, fd_peer_pidfd = -1;
-		int exit_code = EXIT_FAILURE;
-
-		close(ipc_sockets[0]);
-
-		fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
-		if (fd_server < 0) {
-			fprintf(stderr, "socket_request_unknown_flag: create_and_listen_unix_socket failed: %m\n");
-			goto out;
-		}
-
-		if (write_nointr(ipc_sockets[1], "1", 1) < 0) {
-			fprintf(stderr, "socket_request_unknown_flag: write_nointr to ipc socket failed: %m\n");
-			goto out;
-		}
-
-		close(ipc_sockets[1]);
-
-		fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
-		if (fd_coredump < 0) {
-			fprintf(stderr, "socket_request_unknown_flag: accept4 failed: %m\n");
-			goto out;
-		}
-
-		fd_peer_pidfd = get_peer_pidfd(fd_coredump);
-		if (fd_peer_pidfd < 0) {
-			fprintf(stderr, "socket_request_unknown_flag: get_peer_pidfd failed\n");
-			goto out;
-		}
-
-		if (!get_pidfd_info(fd_peer_pidfd, &info)) {
-			fprintf(stderr, "socket_request_unknown_flag: get_pidfd_info failed\n");
-			goto out;
-		}
-
-		if (!(info.mask & PIDFD_INFO_COREDUMP)) {
-			fprintf(stderr, "socket_request_unknown_flag: PIDFD_INFO_COREDUMP not set in mask\n");
-			goto out;
-		}
-
-		if (!(info.coredump_mask & PIDFD_COREDUMPED)) {
-			fprintf(stderr, "socket_request_unknown_flag: PIDFD_COREDUMPED not set in coredump_mask\n");
-			goto out;
-		}
+	struct refused_ack refused = {
+		.ack = {
+			.size = sizeof(struct coredump_ack),
+			.mask = ack_mask,
+		},
+		.bytes = sizeof(struct coredump_ack),
+		.mark = COREDUMP_MARK_CONFLICTING,
+	};
 
-		if (!read_coredump_req(fd_coredump, &req)) {
-			fprintf(stderr, "socket_request_unknown_flag: read_coredump_req failed\n");
-			goto out;
-		}
-
-		if (!check_coredump_req(&req)) {
-			fprintf(stderr, "socket_request_unknown_flag: check_coredump_req failed\n");
-			goto out;
-		}
-
-		if (!send_coredump_ack(fd_coredump, &req, (1ULL << 63), 0)) {
-			fprintf(stderr, "socket_request_unknown_flag: send_coredump_ack failed\n");
-			goto out;
-		}
-
-		if (!read_marker(fd_coredump, COREDUMP_MARK_UNSUPPORTED)) {
-			fprintf(stderr, "socket_request_unknown_flag: read_marker COREDUMP_MARK_UNSUPPORTED failed\n");
-			goto out;
-		}
-
-		exit_code = EXIT_SUCCESS;
-		fprintf(stderr, "socket_request_unknown_flag: completed successfully\n");
-out:
-		if (fd_peer_pidfd >= 0)
-			close(fd_peer_pidfd);
-		if (fd_coredump >= 0)
-			close(fd_coredump);
-		if (fd_server >= 0)
-			close(fd_server);
-		_exit(exit_code);
-	}
-	self->pid_coredump_server = pid_coredump_server;
-
-	EXPECT_EQ(close(ipc_sockets[1]), 0);
-	ASSERT_EQ(read_nointr(ipc_sockets[0], &c, 1), 1);
-	EXPECT_EQ(close(ipc_sockets[0]), 0);
-
-	pid = fork();
-	ASSERT_GE(pid, 0);
-	if (pid == 0)
-		crashing_child();
-
-	pidfd = sys_pidfd_open(pid, 0);
-	ASSERT_GE(pidfd, 0);
+	check_refused_ack(_metadata, self, &refused);
+}
 
-	waitpid(pid, &status, 0);
-	ASSERT_TRUE(WIFSIGNALED(status));
-	ASSERT_FALSE(WCOREDUMP(status));
+/* More than one of KERNEL, USERSPACE and REJECT. */
+TEST_F(coredump, socket_request_invalid_flag_combination)
+{
+	check_conflicting_ack(_metadata, self,
+			      COREDUMP_KERNEL | COREDUMP_REJECT | COREDUMP_WAIT);
+}
 
-	ASSERT_TRUE(get_pidfd_info(pidfd, &info));
-	ASSERT_GT((info.mask & PIDFD_INFO_COREDUMP), 0);
-	ASSERT_GT((info.coredump_mask & PIDFD_COREDUMPED), 0);
+/* A flag the kernel didn't advertise in coredump_req->mask. */
+TEST_F(coredump, socket_request_unknown_flag)
+{
+	struct refused_ack refused = {
+		.ack = {
+			.size = sizeof(struct coredump_ack),
+			.mask = 1ULL << 63,
+		},
+		.bytes = sizeof(struct coredump_ack),
+		.mark = COREDUMP_MARK_UNSUPPORTED,
+	};
 
-	wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
+	check_refused_ack(_metadata, self, &refused);
 }
 
+/* An ack smaller than the first published struct. */
 TEST_F(coredump, socket_request_invalid_size_small)
 {
-	int pidfd, ret, status;
-	pid_t pid, pid_coredump_server;
-	struct pidfd_info info = {};
-	int ipc_sockets[2];
-	char c;
-
-	ASSERT_TRUE(set_core_pattern("@@/tmp/coredump.socket"));
-
-	ret = socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
-	ASSERT_EQ(ret, 0);
-
-	pid_coredump_server = fork();
-	ASSERT_GE(pid_coredump_server, 0);
-	if (pid_coredump_server == 0) {
-		struct coredump_req req = {};
-		int fd_server = -1, fd_coredump = -1, fd_peer_pidfd = -1;
-		int exit_code = EXIT_FAILURE;
-
-		close(ipc_sockets[0]);
-
-		fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
-		if (fd_server < 0) {
-			fprintf(stderr, "socket_request_invalid_size_small: create_and_listen_unix_socket failed: %m\n");
-			goto out;
-		}
-
-		if (write_nointr(ipc_sockets[1], "1", 1) < 0) {
-			fprintf(stderr, "socket_request_invalid_size_small: write_nointr to ipc socket failed: %m\n");
-			goto out;
-		}
-
-		close(ipc_sockets[1]);
-
-		fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
-		if (fd_coredump < 0) {
-			fprintf(stderr, "socket_request_invalid_size_small: accept4 failed: %m\n");
-			goto out;
-		}
-
-		fd_peer_pidfd = get_peer_pidfd(fd_coredump);
-		if (fd_peer_pidfd < 0) {
-			fprintf(stderr, "socket_request_invalid_size_small: get_peer_pidfd failed\n");
-			goto out;
-		}
-
-		if (!get_pidfd_info(fd_peer_pidfd, &info)) {
-			fprintf(stderr, "socket_request_invalid_size_small: get_pidfd_info failed\n");
-			goto out;
-		}
-
-		if (!(info.mask & PIDFD_INFO_COREDUMP)) {
-			fprintf(stderr, "socket_request_invalid_size_small: PIDFD_INFO_COREDUMP not set in mask\n");
-			goto out;
-		}
-
-		if (!(info.coredump_mask & PIDFD_COREDUMPED)) {
-			fprintf(stderr, "socket_request_invalid_size_small: PIDFD_COREDUMPED not set in coredump_mask\n");
-			goto out;
-		}
-
-		if (!read_coredump_req(fd_coredump, &req)) {
-			fprintf(stderr, "socket_request_invalid_size_small: read_coredump_req failed\n");
-			goto out;
-		}
-
-		if (!check_coredump_req(&req)) {
-			fprintf(stderr, "socket_request_invalid_size_small: check_coredump_req failed\n");
-			goto out;
-		}
-
-		if (!send_coredump_ack(fd_coredump, &req,
-				       COREDUMP_REJECT | COREDUMP_WAIT,
-				       COREDUMP_ACK_SIZE_VER0 / 2)) {
-			fprintf(stderr, "socket_request_invalid_size_small: send_coredump_ack failed\n");
-			goto out;
-		}
-
-		if (!read_marker(fd_coredump, COREDUMP_MARK_MINSIZE)) {
-			fprintf(stderr, "socket_request_invalid_size_small: read_marker COREDUMP_MARK_MINSIZE failed\n");
-			goto out;
-		}
-
-		exit_code = EXIT_SUCCESS;
-		fprintf(stderr, "socket_request_invalid_size_small: completed successfully\n");
-out:
-		if (fd_peer_pidfd >= 0)
-			close(fd_peer_pidfd);
-		if (fd_coredump >= 0)
-			close(fd_coredump);
-		if (fd_server >= 0)
-			close(fd_server);
-		_exit(exit_code);
-	}
-	self->pid_coredump_server = pid_coredump_server;
-
-	EXPECT_EQ(close(ipc_sockets[1]), 0);
-	ASSERT_EQ(read_nointr(ipc_sockets[0], &c, 1), 1);
-	EXPECT_EQ(close(ipc_sockets[0]), 0);
-
-	pid = fork();
-	ASSERT_GE(pid, 0);
-	if (pid == 0)
-		crashing_child();
-
-	pidfd = sys_pidfd_open(pid, 0);
-	ASSERT_GE(pidfd, 0);
-
-	waitpid(pid, &status, 0);
-	ASSERT_TRUE(WIFSIGNALED(status));
-	ASSERT_FALSE(WCOREDUMP(status));
-
-	ASSERT_TRUE(get_pidfd_info(pidfd, &info));
-	ASSERT_GT((info.mask & PIDFD_INFO_COREDUMP), 0);
-	ASSERT_GT((info.coredump_mask & PIDFD_COREDUMPED), 0);
+	struct refused_ack refused = {
+		.ack = {
+			.size = COREDUMP_ACK_SIZE_VER0 / 2,
+			.mask = COREDUMP_REJECT | COREDUMP_WAIT,
+		},
+		.bytes = COREDUMP_ACK_SIZE_VER0 / 2,
+		.mark = COREDUMP_MARK_MINSIZE,
+	};
 
-	wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
+	check_refused_ack(_metadata, self, &refused);
 }
 
+/* An ack bigger than the kernel said it accepts. */
 TEST_F(coredump, socket_request_invalid_size_large)
 {
-	int pidfd, ret, status;
-	pid_t pid, pid_coredump_server;
-	struct pidfd_info info = {};
-	int ipc_sockets[2];
-	char c;
-
-	ASSERT_TRUE(set_core_pattern("@@/tmp/coredump.socket"));
-
-	ret = socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
-	ASSERT_EQ(ret, 0);
-
-	pid_coredump_server = fork();
-	ASSERT_GE(pid_coredump_server, 0);
-	if (pid_coredump_server == 0) {
-		struct coredump_req req = {};
-		int fd_server = -1, fd_coredump = -1, fd_peer_pidfd = -1;
-		int exit_code = EXIT_FAILURE;
-
-		close(ipc_sockets[0]);
-
-		fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
-		if (fd_server < 0) {
-			fprintf(stderr, "socket_request_invalid_size_large: create_and_listen_unix_socket failed: %m\n");
-			goto out;
-		}
+	struct refused_ack refused = {
+		.ack = {
+			.size = COREDUMP_ACK_SIZE_VER0 + PAGE_SIZE,
+			.mask = COREDUMP_REJECT | COREDUMP_WAIT,
+		},
+		.bytes = COREDUMP_ACK_SIZE_VER0 + PAGE_SIZE,
+		.mark = COREDUMP_MARK_MAXSIZE,
+	};
 
-		if (write_nointr(ipc_sockets[1], "1", 1) < 0) {
-			fprintf(stderr, "socket_request_invalid_size_large: write_nointr to ipc socket failed: %m\n");
-			goto out;
-		}
-
-		close(ipc_sockets[1]);
-
-		fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
-		if (fd_coredump < 0) {
-			fprintf(stderr, "socket_request_invalid_size_large: accept4 failed: %m\n");
-			goto out;
-		}
-
-		fd_peer_pidfd = get_peer_pidfd(fd_coredump);
-		if (fd_peer_pidfd < 0) {
-			fprintf(stderr, "socket_request_invalid_size_large: get_peer_pidfd failed\n");
-			goto out;
-		}
-
-		if (!get_pidfd_info(fd_peer_pidfd, &info)) {
-			fprintf(stderr, "socket_request_invalid_size_large: get_pidfd_info failed\n");
-			goto out;
-		}
-
-		if (!(info.mask & PIDFD_INFO_COREDUMP)) {
-			fprintf(stderr, "socket_request_invalid_size_large: PIDFD_INFO_COREDUMP not set in mask\n");
-			goto out;
-		}
-
-		if (!(info.coredump_mask & PIDFD_COREDUMPED)) {
-			fprintf(stderr, "socket_request_invalid_size_large: PIDFD_COREDUMPED not set in coredump_mask\n");
-			goto out;
-		}
-
-		if (!read_coredump_req(fd_coredump, &req)) {
-			fprintf(stderr, "socket_request_invalid_size_large: read_coredump_req failed\n");
-			goto out;
-		}
-
-		if (!check_coredump_req(&req)) {
-			fprintf(stderr, "socket_request_invalid_size_large: check_coredump_req failed\n");
-			goto out;
-		}
-
-		if (!send_coredump_ack(fd_coredump, &req,
-				       COREDUMP_REJECT | COREDUMP_WAIT,
-				       COREDUMP_ACK_SIZE_VER0 + PAGE_SIZE)) {
-			fprintf(stderr, "socket_request_invalid_size_large: send_coredump_ack failed\n");
-			goto out;
-		}
-
-		if (!read_marker(fd_coredump, COREDUMP_MARK_MAXSIZE)) {
-			fprintf(stderr, "socket_request_invalid_size_large: read_marker COREDUMP_MARK_MAXSIZE failed\n");
-			goto out;
-		}
-
-		exit_code = EXIT_SUCCESS;
-		fprintf(stderr, "socket_request_invalid_size_large: completed successfully\n");
-out:
-		if (fd_peer_pidfd >= 0)
-			close(fd_peer_pidfd);
-		if (fd_coredump >= 0)
-			close(fd_coredump);
-		if (fd_server >= 0)
-			close(fd_server);
-		_exit(exit_code);
-	}
-	self->pid_coredump_server = pid_coredump_server;
-
-	EXPECT_EQ(close(ipc_sockets[1]), 0);
-	ASSERT_EQ(read_nointr(ipc_sockets[0], &c, 1), 1);
-	EXPECT_EQ(close(ipc_sockets[0]), 0);
-
-	pid = fork();
-	ASSERT_GE(pid, 0);
-	if (pid == 0)
-		crashing_child();
-
-	pidfd = sys_pidfd_open(pid, 0);
-	ASSERT_GE(pidfd, 0);
-
-	waitpid(pid, &status, 0);
-	ASSERT_TRUE(WIFSIGNALED(status));
-	ASSERT_FALSE(WCOREDUMP(status));
-
-	ASSERT_TRUE(get_pidfd_info(pidfd, &info));
-	ASSERT_GT((info.mask & PIDFD_INFO_COREDUMP), 0);
-	ASSERT_GT((info.coredump_mask & PIDFD_COREDUMPED), 0);
-
-	wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
+	check_refused_ack(_metadata, self, &refused);
 }
 
 /*
@@ -2038,92 +1736,6 @@ TEST_F(coredump, socket_request_sparse_blob_upload)
 	EXPECT_EQ(close(fd_core_file), 0);
 }
 
-/* Ack @ack_mask, expect the kernel to refuse it as conflicting. */
-static void check_conflicting_ack(struct __test_metadata *const _metadata,
-				  FIXTURE_DATA(coredump) *self, __u64 ack_mask)
-{
-	int pidfd, status;
-	pid_t pid, pid_coredump_server;
-	struct pidfd_info info = {};
-	int ipc_sockets[2];
-	char c;
-
-	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets), 0);
-	ASSERT_TRUE(set_core_pattern("@@/tmp/coredump.socket"));
-
-	pid_coredump_server = fork();
-	ASSERT_GE(pid_coredump_server, 0);
-	if (pid_coredump_server == 0) {
-		int fd_server = -1, fd_coredump = -1, fd_peer_pidfd = -1;
-		int exit_code = EXIT_FAILURE;
-		struct coredump_req req = {};
-
-		close(ipc_sockets[0]);
-
-		fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
-		if (fd_server < 0)
-			goto out;
-
-		if (write_nointr(ipc_sockets[1], "1", 1) < 0)
-			goto out;
-
-		close(ipc_sockets[1]);
-
-		fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
-		if (fd_coredump < 0)
-			goto out;
-
-		fd_peer_pidfd = get_peer_pidfd(fd_coredump);
-		if (fd_peer_pidfd < 0)
-			goto out;
-
-		if (!read_coredump_req(fd_coredump, &req))
-			goto out;
-
-		if (!check_coredump_req(&req))
-			goto out;
-
-		if (!send_coredump_ack(fd_coredump, &req, ack_mask, 0))
-			goto out;
-
-		if (!read_marker(fd_coredump, COREDUMP_MARK_CONFLICTING))
-			goto out;
-
-		exit_code = EXIT_SUCCESS;
-out:
-		if (fd_peer_pidfd >= 0)
-			close(fd_peer_pidfd);
-		if (fd_coredump >= 0)
-			close(fd_coredump);
-		if (fd_server >= 0)
-			close(fd_server);
-		_exit(exit_code);
-	}
-	self->pid_coredump_server = pid_coredump_server;
-
-	EXPECT_EQ(close(ipc_sockets[1]), 0);
-	ASSERT_EQ(read_nointr(ipc_sockets[0], &c, 1), 1);
-	EXPECT_EQ(close(ipc_sockets[0]), 0);
-
-	pid = fork();
-	ASSERT_GE(pid, 0);
-	if (pid == 0)
-		crashing_child();
-
-	pidfd = sys_pidfd_open(pid, 0);
-	ASSERT_GE(pidfd, 0);
-
-	waitpid(pid, &status, 0);
-	ASSERT_TRUE(WIFSIGNALED(status));
-	ASSERT_FALSE(WCOREDUMP(status));
-
-	ASSERT_TRUE(get_pidfd_info(pidfd, &info));
-	ASSERT_GT((info.mask & PIDFD_INFO_COREDUMP), 0);
-	ASSERT_GT((info.coredump_mask & PIDFD_COREDUMPED), 0);
-
-	wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
-}
-
 /* COREDUMP_RECORDS applies to a coredump the kernel writes, nothing else. */
 TEST_F(coredump, socket_request_records_without_kernel)
 {
diff --git a/tools/testing/selftests/coredump/coredump_test_helpers.c b/tools/testing/selftests/coredump/coredump_test_helpers.c
index d7cc448eeaf4..9aa901e14f02 100644
--- a/tools/testing/selftests/coredump/coredump_test_helpers.c
+++ b/tools/testing/selftests/coredump/coredump_test_helpers.c
@@ -1354,8 +1354,8 @@ bool read_coredump_req(int fd, struct coredump_req *req)
 	return true;
 }
 
-bool send_coredump_ack(int fd, const struct coredump_req *req,
-		       __u64 mask, size_t size_ack)
+/* Send @len bytes of @ack as they are, more than the struct if asked to. */
+bool send_coredump_ack_bytes(int fd, const struct coredump_ack *ack, size_t len)
 {
 	ssize_t ret;
 	/*
@@ -1367,23 +1367,36 @@ bool send_coredump_ack(int fd, const struct coredump_req *req,
 		char buffer[PAGE_SIZE];
 	} large_ack = {};
 
-	if (!size_ack)
-		size_ack = sizeof(struct coredump_ack) < req->size_ack ?
-				   sizeof(struct coredump_ack) :
-				   req->size_ack;
-	large_ack.ack.mask = mask;
-	large_ack.ack.size = size_ack;
-	ret = send(fd, &large_ack, size_ack, MSG_NOSIGNAL);
-	if (ret != size_ack) {
+	if (len > sizeof(large_ack))
+		return false;
+
+	large_ack.ack = *ack;
+	ret = send(fd, &large_ack, len, MSG_NOSIGNAL);
+	if (ret != len) {
 		fprintf(stderr, "%s: short send %zd: %m\n", __func__, ret);
 		return false;
 	}
 
-	fprintf(stderr, "Sent coredump ack with size %zu and mask 0x%llx\n",
-		size_ack, (unsigned long long)mask);
+	fprintf(stderr, "Sent %zu bytes of coredump ack: size %u, mask 0x%llx\n",
+		len, ack->size, (unsigned long long)ack->mask);
 	return true;
 }
 
+bool send_coredump_ack(int fd, const struct coredump_req *req,
+		       __u64 mask, size_t size_ack)
+{
+	struct coredump_ack ack = {
+		.mask = mask,
+	};
+
+	if (!size_ack)
+		size_ack = sizeof(struct coredump_ack) < req->size_ack ?
+				   sizeof(struct coredump_ack) :
+				   req->size_ack;
+	ack.size = size_ack;
+	return send_coredump_ack_bytes(fd, &ack, size_ack);
+}
+
 /* Every option the kernel is expected to advertise in coredump_req->mask. */
 #define TEST_REQ_MASK_ALL					\
 	(COREDUMP_KERNEL | COREDUMP_USERSPACE |			\
diff --git a/tools/testing/selftests/coredump/coredump_test_helpers.h b/tools/testing/selftests/coredump/coredump_test_helpers.h
index 97ad5cfeae92..0970d3550fc1 100644
--- a/tools/testing/selftests/coredump/coredump_test_helpers.h
+++ b/tools/testing/selftests/coredump/coredump_test_helpers.h
@@ -46,6 +46,7 @@ bool read_marker(int fd, enum coredump_mark mark);
 bool read_coredump_req(int fd, struct coredump_req *req);
 bool send_coredump_ack(int fd, const struct coredump_req *req,
 		       __u64 mask, size_t size_ack);
+bool send_coredump_ack_bytes(int fd, const struct coredump_ack *ack, size_t len);
 bool check_coredump_req(const struct coredump_req *req);
 int open_coredump_tmpfile(int fd_tmpfs_detached);
 void process_coredump_worker(int fd_coredump, int fd_peer_pidfd, int fd_core_file);

-- 
2.53.0

