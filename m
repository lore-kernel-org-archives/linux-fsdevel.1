Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6098A3AE187;
	Tue, 11 Aug 2026 15:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786462064; cv=none; b=Bk53+hRAmZNIGYawxzIXs57W1RlrDHHZCnLpN/k9BBCI65M3NlxVEdoWjfniAu5OioiHfaEdabMZccsEYcygWN639nOqmkE7qyMGdUHBz7jXOTsYcpaNwUq4dtfrMsVbCulNF2WranmZm8Lb2Q9/j7YIkUaaK6+vTmqatbuptpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786462064; c=relaxed/simple;
	bh=/WE7FwKgQXlwVzHyeztNVUhNPPEXhv6nrZrHM54peHw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qENp+77oDa3sNcTZiLdTUZxDa3M46elcOymj8jwlrEDTVkwtbMm8lqfXXxKFRtllbn39g+E8GAREXtxceTAkpcwPAhSCgu32JduHL0a4h22ZgMrdvus7iFPUSCk3FUXdShbmc7ZH/ZG+FrMIJCpn9TQY6UNStC6x8TvNmR8vTI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/6/bnLe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/6/bnLe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4FCF1F00A3A;
	Tue, 11 Aug 2026 15:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786462063;
	bh=vem2xsFlpo0+sWC3l/kxNB7POgGE6gpeRa35NgLYw6I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=a/6/bnLeoX9AstuTEYVT9BGZD2qYKRDb97wunLXwXts7QaNjyUzcB5AHy5sjmE40S
	 6opyHuFyx3LhMRWACbJ/XkJtuqANTlhEjlPNcZEkSi8vDJkvRDME+UPn7SdBi78rjc
	 DD52380Eoh9d2MJJaC+QBRqfQYJn3+96s0nVG/H2LObZXr+1vTOiDGvlq3UmEvbI0G
	 BmDptAGWxSW6a/7tnZ10RCk+iblQlTDJSkY1oJnWgkijjuMuE1/0y/1Rcay6oNxL5J
	 KwP08f4hpXhgWT1dknZL72SB1kMKA7ex6IcgtCc9q4MhWD+eaKAN8BzxL162v46ymx
	 icMeoJuuFGO8g==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 11 Aug 2026 17:27:23 +0200
Subject: [PATCH 02/11] selftests/coredump: collapse the expected request
 check into the helper
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-work-coredump-sparse-v1-2-cd3e8b1e356d@kernel.org>
References: <20260811-work-coredump-sparse-v1-0-cd3e8b1e356d@kernel.org>
In-Reply-To: <20260811-work-coredump-sparse-v1-0-cd3e8b1e356d@kernel.org>
To: Jacob Lalonde <jalalonde@meta.com>, Josef Bacik <josef@toxicpanda.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Omar Sandoval <osandov@osandov.com>, 
 Jacob Lalonde <jalalonde@fb.com>, Shuah Khan <shuah@kernel.org>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-362b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=8194; i=brauner@kernel.org;
 h=from:subject:message-id; bh=/WE7FwKgQXlwVzHyeztNVUhNPPEXhv6nrZrHM54peHw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRV2ydwMay6tdplnk7BlGnv9XXXbezfymfu0n9sQf7/T
 5bLM8Med5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExk6UyGvxJ8D2052yc/nq9e
 bnvk9TyetNBdKy40vrB7fpxDQmVzriMjQ9+Dk0d2d3q2LvTZylSuo+C89iHLr+4F+dlCT23N64O
 MGQE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

All nine callers spell the expected flags. So every new feature bit the
kernel learns has to be cargo culted.

The callers also all pass COREDUMP_ACK_SIZE_VER0 as the minimum request
size although what is being validated is coredump_req->size. And
read_coredump_req() makes the same mixup twice more.

Clean this all up.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 .../coredump/coredump_socket_protocol_test.c       | 36 ++++++----------------
 tools/testing/selftests/coredump/coredump_test.h   |  3 +-
 .../selftests/coredump/coredump_test_helpers.c     | 35 +++++++++++++--------
 3 files changed, 32 insertions(+), 42 deletions(-)

diff --git a/tools/testing/selftests/coredump/coredump_socket_protocol_test.c b/tools/testing/selftests/coredump/coredump_socket_protocol_test.c
index d9fa6239b5a9..60a357e628eb 100644
--- a/tools/testing/selftests/coredump/coredump_socket_protocol_test.c
+++ b/tools/testing/selftests/coredump/coredump_socket_protocol_test.c
@@ -151,9 +151,7 @@ TEST_F(coredump, socket_request_kernel)
 			goto out;
 		}
 
-		if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
-					COREDUMP_KERNEL | COREDUMP_USERSPACE |
-					COREDUMP_REJECT | COREDUMP_WAIT)) {
+		if (!check_coredump_req(&req)) {
 			fprintf(stderr, "socket_request_kernel: check_coredump_req failed\n");
 			goto out;
 		}
@@ -301,9 +299,7 @@ TEST_F(coredump, socket_request_userspace)
 			goto out;
 		}
 
-		if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
-					COREDUMP_KERNEL | COREDUMP_USERSPACE |
-					COREDUMP_REJECT | COREDUMP_WAIT)) {
+		if (!check_coredump_req(&req)) {
 			fprintf(stderr, "socket_request_userspace: check_coredump_req failed\n");
 			goto out;
 		}
@@ -441,9 +437,7 @@ TEST_F(coredump, socket_request_reject)
 			goto out;
 		}
 
-		if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
-					COREDUMP_KERNEL | COREDUMP_USERSPACE |
-					COREDUMP_REJECT | COREDUMP_WAIT)) {
+		if (!check_coredump_req(&req)) {
 			fprintf(stderr, "socket_request_reject: check_coredump_req failed\n");
 			goto out;
 		}
@@ -581,9 +575,7 @@ TEST_F(coredump, socket_request_invalid_flag_combination)
 			goto out;
 		}
 
-		if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
-					COREDUMP_KERNEL | COREDUMP_USERSPACE |
-					COREDUMP_REJECT | COREDUMP_WAIT)) {
+		if (!check_coredump_req(&req)) {
 			fprintf(stderr, "socket_request_invalid_flag_combination: check_coredump_req failed\n");
 			goto out;
 		}
@@ -702,9 +694,7 @@ TEST_F(coredump, socket_request_unknown_flag)
 			goto out;
 		}
 
-		if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
-					COREDUMP_KERNEL | COREDUMP_USERSPACE |
-					COREDUMP_REJECT | COREDUMP_WAIT)) {
+		if (!check_coredump_req(&req)) {
 			fprintf(stderr, "socket_request_unknown_flag: check_coredump_req failed\n");
 			goto out;
 		}
@@ -822,9 +812,7 @@ TEST_F(coredump, socket_request_invalid_size_small)
 			goto out;
 		}
 
-		if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
-					COREDUMP_KERNEL | COREDUMP_USERSPACE |
-					COREDUMP_REJECT | COREDUMP_WAIT)) {
+		if (!check_coredump_req(&req)) {
 			fprintf(stderr, "socket_request_invalid_size_small: check_coredump_req failed\n");
 			goto out;
 		}
@@ -944,9 +932,7 @@ TEST_F(coredump, socket_request_invalid_size_large)
 			goto out;
 		}
 
-		if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
-					COREDUMP_KERNEL | COREDUMP_USERSPACE |
-					COREDUMP_REJECT | COREDUMP_WAIT)) {
+		if (!check_coredump_req(&req)) {
 			fprintf(stderr, "socket_request_invalid_size_large: check_coredump_req failed\n");
 			goto out;
 		}
@@ -1355,9 +1341,7 @@ TEST_F_TIMEOUT(coredump, socket_multiple_crashing_coredumps, 500)
 				goto out;
 			}
 
-			if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
-						COREDUMP_KERNEL | COREDUMP_USERSPACE |
-						COREDUMP_REJECT | COREDUMP_WAIT)) {
+			if (!check_coredump_req(&req)) {
 				fprintf(stderr, "check_coredump_req failed for fd %d\n", fd_coredump);
 				goto out;
 			}
@@ -1509,9 +1493,7 @@ TEST_F_TIMEOUT(coredump, socket_multiple_crashing_coredumps_epoll_workers, 500)
 				fprintf(stderr, "socket_multiple_crashing_coredumps_epoll_workers: read_coredump_req failed\n");
 				goto out;
 			}
-			if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
-						COREDUMP_KERNEL | COREDUMP_USERSPACE |
-						COREDUMP_REJECT | COREDUMP_WAIT)) {
+			if (!check_coredump_req(&req)) {
 				fprintf(stderr, "socket_multiple_crashing_coredumps_epoll_workers: check_coredump_req failed\n");
 				goto out;
 			}
diff --git a/tools/testing/selftests/coredump/coredump_test.h b/tools/testing/selftests/coredump/coredump_test.h
index ed47f01fa53c..a02809145e2d 100644
--- a/tools/testing/selftests/coredump/coredump_test.h
+++ b/tools/testing/selftests/coredump/coredump_test.h
@@ -51,8 +51,7 @@ bool read_marker(int fd, enum coredump_mark mark);
 bool read_coredump_req(int fd, struct coredump_req *req);
 bool send_coredump_ack(int fd, const struct coredump_req *req,
 		       __u64 mask, size_t size_ack);
-bool check_coredump_req(const struct coredump_req *req, size_t min_size,
-			__u64 required_mask);
+bool check_coredump_req(const struct coredump_req *req);
 int open_coredump_tmpfile(int fd_tmpfs_detached);
 void process_coredump_worker(int fd_coredump, int fd_peer_pidfd, int fd_core_file);
 
diff --git a/tools/testing/selftests/coredump/coredump_test_helpers.c b/tools/testing/selftests/coredump/coredump_test_helpers.c
index 524fa5370593..d32d96436779 100644
--- a/tools/testing/selftests/coredump/coredump_test_helpers.c
+++ b/tools/testing/selftests/coredump/coredump_test_helpers.c
@@ -200,7 +200,7 @@ bool read_marker(int fd, enum coredump_mark mark)
 bool read_coredump_req(int fd, struct coredump_req *req)
 {
 	ssize_t ret;
-	size_t field_size, user_size, ack_size, kernel_size, remaining_size;
+	size_t field_size, user_size, known, kernel_size, remaining_size;
 
 	memset(req, 0, sizeof(*req));
 	field_size = sizeof(req->size);
@@ -214,9 +214,9 @@ bool read_coredump_req(int fd, struct coredump_req *req)
 	}
 	kernel_size = req->size;
 
-	if (kernel_size < COREDUMP_ACK_SIZE_VER0) {
+	if (kernel_size < COREDUMP_REQ_SIZE_VER0) {
 		fprintf(stderr, "read_coredump_req: kernel_size %zu < min %d\n",
-			kernel_size, COREDUMP_ACK_SIZE_VER0);
+			kernel_size, COREDUMP_REQ_SIZE_VER0);
 		return false;
 	}
 	if (kernel_size >= PAGE_SIZE) {
@@ -225,11 +225,11 @@ bool read_coredump_req(int fd, struct coredump_req *req)
 		return false;
 	}
 
-	/* Use the minimum of user and kernel size to read the full request. */
+	/* Consume as much of the request as we know about. */
 	user_size = sizeof(struct coredump_req);
-	ack_size = user_size < kernel_size ? user_size : kernel_size;
-	ret = recv(fd, req, ack_size, MSG_WAITALL);
-	if (ret != ack_size)
+	known = user_size < kernel_size ? user_size : kernel_size;
+	ret = recv(fd, req, known, MSG_WAITALL);
+	if (ret != known)
 		return false;
 
 	fprintf(stderr, "Read coredump request with size %u and mask 0x%llx\n",
@@ -287,15 +287,24 @@ bool send_coredump_ack(int fd, const struct coredump_req *req,
 	return true;
 }
 
-bool check_coredump_req(const struct coredump_req *req, size_t min_size,
-			__u64 required_mask)
+/* Every option the kernel is expected to advertise in coredump_req->mask. */
+#define COREDUMP_REQ_MASK_ALL					\
+	(COREDUMP_KERNEL | COREDUMP_USERSPACE |			\
+	 COREDUMP_REJECT | COREDUMP_WAIT)
+
+bool check_coredump_req(const struct coredump_req *req)
 {
-	if (req->size < min_size)
-		return false;
-	if ((req->mask & required_mask) != required_mask)
+	if (req->size < COREDUMP_REQ_SIZE_VER0) {
+		fprintf(stderr, "%s: size %u below minimum %d\n",
+			__func__, req->size, COREDUMP_REQ_SIZE_VER0);
 		return false;
-	if (req->mask & ~required_mask)
+	}
+	if (req->mask != COREDUMP_REQ_MASK_ALL) {
+		fprintf(stderr, "%s: mask 0x%llx, expected 0x%llx\n",
+			__func__, (unsigned long long)req->mask,
+			(unsigned long long)COREDUMP_REQ_MASK_ALL);
 		return false;
+	}
 	return true;
 }
 

-- 
2.53.0

