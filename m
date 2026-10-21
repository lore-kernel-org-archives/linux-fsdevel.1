Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792583230;
	b=idKpCsgoN0pU+F7v4tgF47mUK8Gr4yUy0rYbUtFxsnruGiNBPpx0ZS8+XnKWSMBE6VEb
	 676zPLqt0iZgiwlS03rhHVMse4ohvfT3QX5h6Vu6yNLMj5Sno5tX9C0D9FdhSd/CRIjgT
	 ZmOsPAtyFp14KuiAjEOiOLY59dzXqJhy4WZqhs0VNy5xkXmhKN1De8mX16QHMGRF58eYR
	 C94SLi/CdFN85j6wRwz13kq9HgOe3mcmkZbPEN2tep7GdkisQeptyi4kJfbzwJorrdh6T
	 DGWe5RB4uyaI3WpfuF9Zft3jXVt5A+s0PGlT4NhsYUcoJ9YWtGzFMPshy48metQi0tA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792583230;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=B9V+K2FHSVayRLHT+tOK0bpg2fWU8DMnB8OtEuqpFcI=;
	b=gIPy7LO4IpEVDlS0y6xBMyiJCsmEpn2XulWgFy+hN5L0bz3VROGVt6Id7q6Y1lpMbOSC
	 5HKTmdoyUcUwwLmgUnLudP9YN/h0H37/VRgSEO47wLO9yzt/DxqIUbpDoRLycjthi1fgk
	 XYIIiU0hJwfhMswkzvPUXrNEPt8Bb+czXAigDumE3CtjKU2ks1arNHhjDaDQLCkX59uUv
	 oQ+ScR2FoMDatbhicFOGbGAusSzDodEQhnbog+4Od4zAqlJPFsLCyuRYGVQfLpgF1ccyi
	 Xjzd9QXeM+qtYR9g4fdpgW4RNxhSTNsyox60xw3s2YNnPhguOKv8DA5rucytXh5O2SA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CNZhtGr1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64974606A32D;
	Wed, 21 Oct 2026 11:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CNZhtGr1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7835D1F000C5;
	Wed, 21 Oct 2026 11:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792583229;
	bh=B9V+K2FHSVayRLHT+tOK0bpg2fWU8DMnB8OtEuqpFcI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=CNZhtGr1V573Lk7OxroMMTmwhGnSnHV4n7MCGdfueNNXZPzltUfshSJ6UoX1A3u82
	 8LbeGuHHOQlLtGwUWVuA7EVN0DytpA3bN2BZ4jluKOdzvjyJUOCNKblHSZg+TaQdhF
	 lFWth0NDpyi2T0LSr3E22SEnLUr6WDtear3wkJ+Nx6ZJPnfH72/lSDVlxhdKB2Myug
	 s9w7IBsanJOmMYen5zq+bnkmwQr3GhlQb9i/n+ZF5EnVM6FbcIBoHA2yc46wmHAyxw
	 UQPDbS3rZIFbAWLLSBYlXCT5r6hirlpjvLsg2Z0ANqWo7TH+tcgGrrWxAqr8KdTWgg
	 3sC9hOd4lcHcQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 21 Oct 2026 13:46:55 +0200
Subject: [PATCH 2/6] selftests/filesystems: check short buffers for
 statmount() strings
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-work-mount-statmount_listns_fixes-v1-2-8917a4c1bd14@kernel.org>
References: <20261021-work-mount-statmount_listns_fixes-v1-0-8917a4c1bd14@kernel.org>
In-Reply-To: <20261021-work-mount-statmount_listns_fixes-v1-0-8917a4c1bd14@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Miklos Szeredi <mszeredi@redhat.com>, Jeff Layton <jlayton@kernel.org>, 
 shaos <shawnq1@163.com>, linux-kernel@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-3d1b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3620; i=brauner@kernel.org;
 h=from:subject:message-id; bh=eFchj9AL0dcLKoT/7ev1PhpZsH64hOw/E2yK/MCRkog=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTdWGZ8xMtroo3hSrH+OZZ+ta8/bdvcX9RW0cN3cV7ex
 +e27BPkO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYSocvwz8j4j5xhyD8hVaaq
 i4XfFRs/c3CsVvh354H4w82BpypalzD8j7zQq5Lt8jiiekXZ9j+Niixa/yfeOjzjevO1Rrv7XeF
 H+AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Request strings that end up empty with buffers that aren't larger than
the fixed part of struct statmount and check that:

- every request fails with EOVERFLOW

- nothing is written past the end of the buffer, a guard page right
  behind it catches that

The buffer sizes run from zero up to sizeof(struct statmount) and the
requests cover STATMOUNT_FS_TYPE, STATMOUNT_FS_SUBTYPE and
STATMOUNT_MNT_UIDMAP.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 .../filesystems/statmount/statmount_test.c         | 61 +++++++++++++++++++++-
 1 file changed, 60 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/filesystems/statmount/statmount_test.c b/tools/testing/selftests/filesystems/statmount/statmount_test.c
index 60c2c544db6a..2947546a9367 100644
--- a/tools/testing/selftests/filesystems/statmount/statmount_test.c
+++ b/tools/testing/selftests/filesystems/statmount/statmount_test.c
@@ -7,6 +7,7 @@
 #include <sched.h>
 #include <fcntl.h>
 #include <sys/param.h>
+#include <sys/mman.h>
 #include <sys/mount.h>
 #include <sys/stat.h>
 #include <sys/statfs.h>
@@ -578,6 +579,63 @@ static void test_statmount_string(uint64_t mask, size_t off, const char *name)
 	free(sm);
 }
 
+/*
+ * A string request needs a buffer that is larger than the fixed part of
+ * struct statmount. That's true even if the string turns out to be empty
+ * since the empty string itself is placed past the fixed part.
+ */
+static void test_statmount_string_short_buffer(void)
+{
+	const struct {
+		uint64_t mask;
+		const char *name;
+	} reqs[] = {
+		{ STATMOUNT_FS_TYPE,	"fs type" },
+		{ STATMOUNT_FS_SUBTYPE,	"fs subtype" },
+		{ STATMOUNT_MNT_UIDMAP,	"mount uidmap" },
+	};
+	const size_t sizes[] = { 0, 1, 100, sizeof(struct statmount) - 1,
+				 sizeof(struct statmount) };
+	long page = sysconf(_SC_PAGESIZE);
+	unsigned char *map;
+	size_t i, j;
+	int ret;
+
+	map = mmap(NULL, 2 * page, PROT_READ | PROT_WRITE,
+		   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (map == MAP_FAILED) {
+		ksft_test_result_fail("mmap: %s\n", strerror(errno));
+		return;
+	}
+
+	/* Anything written past the end of the buffer faults. */
+	if (mprotect(map + page, page, PROT_NONE)) {
+		ksft_test_result_fail("mprotect: %s\n", strerror(errno));
+		goto out;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(reqs); i++) {
+		for (j = 0; j < ARRAY_SIZE(sizes); j++) {
+			/* The buffer ends right at the guard page. */
+			struct statmount *sm = (void *)(map + page - sizes[j]);
+
+			errno = 0;
+			ret = statmount(root_id, 0, 0, reqs[i].mask, sm,
+					sizes[j], 0);
+			if (ret != -1 || errno != EOVERFLOW) {
+				ksft_test_result_fail("statmount %s with %zu byte buffer: %s\n",
+						      reqs[i].name, sizes[j],
+						      ret ? strerror(errno) : "success");
+				goto out;
+			}
+		}
+	}
+
+	ksft_test_result_pass("statmount string short buffer\n");
+out:
+	munmap(map, 2 * page);
+}
+
 static void test_listmount_tree(void)
 {
 	ssize_t res;
@@ -869,7 +927,7 @@ int main(void)
 
 	setup_namespace();
 
-	ksft_set_plan(17);
+	ksft_set_plan(18);
 	test_listmount_empty_root();
 	test_statmount_zero_mask();
 	test_statmount_mnt_basic();
@@ -884,6 +942,7 @@ int main(void)
 	test_statmount_string(all_mask, str_off(mnt_root), "mount root & all");
 	test_statmount_string(all_mask, str_off(mnt_point), "mount point & all");
 	test_statmount_string(all_mask, str_off(fs_type), "fs type & all");
+	test_statmount_string_short_buffer();
 
 	test_listmount_tree();
 	test_statmount_by_fd_unmounted();

-- 
2.53.0

