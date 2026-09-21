Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBAD4A8FE4
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 14:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790000152; cv=none; b=I8zLoESd9SqFbEVTc3VLVt6sz97PvJ6F3a81iOc4KdbNOmxVbZqMGk6bHvxYgdoBA9ySlmKN/MVyz8zniNkzhsAOyj7eemf0yM6F+18WpJeXiimQI/wPXUffuHy+2AnYBhImw0Fu6PIDq1MV9Bts3MTZeEWCt/Uh2VjN41x0p1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790000152; c=relaxed/simple;
	bh=9Ebe8Dwl3b96VpQgKri16G8KtFyxNk5dzUxknqSeLgM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q8kJGM2XjyybvuxiJxhmR/RHF9gYx+32vzjBaTNBmBMaNEQiuJHQgFrweIWYknyNCfNBCvICw2LVj9wcYROSyKv+geg9zGc/OJ5j5h648RLa5s3FxH4gIxOwAeTXtml/tmroeTGOhMRYNsfYxrjoSu+fjoAgekWLp3fe9vbk8qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPdbAWpQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPdbAWpQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F43C1F000FF;
	Mon, 21 Sep 2026 14:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790000150;
	bh=50S+RvlOKV/41exvtthTHaRCbLj0oyiIj9yHkF6BmQY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=bPdbAWpQdxzEj0CnuLEz1D4mnnCBTq+t86noFYc4Dz1UWum08smv10+jGrHImhZna
	 4ONSyB5UPrV54S8bYDBkTj43R98vHM6/eH+Pek7IoWcP2geIj9Yb917ZtFThTZX9+o
	 DoykSZaKgeXQXQ71isGNqALgRy+fI6v49ur0aDljUnm4zHjtmawjEw8YAQCLBQC6eh
	 K9dEzFF90sjr7PXRGIyhCtMvsfCwO6v4l9/T6Ny6k8HOQBWI2f1A7FlJwBdi1zTo/R
	 /B4FpVMN7UhFJ7KYoo3nfc8ssBm5l6jUQfD1XkQv79o+eAIpt7h5/M1amJbsqMQE6r
	 veIU5gmnlJlTA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 21 Sep 2026 16:15:30 +0200
Subject: [PATCH 02/10] selftests/core: test the hole CLOSE_RANGE_UNSHARE
 leaves behind
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-work-file-close_range_except-v1-2-c20d0b49270d@kernel.org>
References: <20260921-work-file-close_range_except-v1-0-c20d0b49270d@kernel.org>
In-Reply-To: <20260921-work-file-close_range_except-v1-0-c20d0b49270d@kernel.org>
To: Jann Horn <jannh@google.com>, linux-fsdevel@vger.kernel.org, 
 Oleg Nesterov <oleg@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Neil Brown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=1951; i=brauner@kernel.org;
 h=from:subject:message-id; bh=9Ebe8Dwl3b96VpQgKri16G8KtFyxNk5dzUxknqSeLgM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRttOGp8XWyeM7jVGeXtPSI9tXXupwrInQM3vx/vrt26
 epfsrcCOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaidYaR4c/E1WoHl+x+LbBL
 lm+t5rMpbwv8Xr7Z8sJkTfLzIkk95T2MDJdObbJ8rD3tjMO6Cw0V/mvPR/7na93wg9W3PHl2lOQ
 7MU4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Cover a range in the middle of a full word:

- the descriptors in it are gone from the clone and the ones around it
  are still there

- the slots are handed out again, the word is not left marked full

- the table the child cloned from is untouched

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 tools/testing/selftests/core/close_range_test.c | 44 +++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tools/testing/selftests/core/close_range_test.c b/tools/testing/selftests/core/close_range_test.c
index f14eca63f20c..afae3462502d 100644
--- a/tools/testing/selftests/core/close_range_test.c
+++ b/tools/testing/selftests/core/close_range_test.c
@@ -236,6 +236,50 @@ TEST(close_range_unshare_capped)
 	EXPECT_EQ(0, WEXITSTATUS(status));
 }
 
+TEST(close_range_unshare_hole)
+{
+	int i, status;
+	pid_t pid;
+	struct __clone_args args = {
+		.flags = CLONE_FILES,
+		.exit_signal = SIGCHLD,
+	};
+
+	/* Fill the first two words of the table. */
+	for (i = 3; i < 128; i++)
+		ASSERT_GE(dup2(0, i), 0);
+
+	pid = sys_clone3(&args, sizeof(args));
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		/* Punch a hole into the second word, behind a full first one. */
+		if (sys_close_range(70, 80, CLOSE_RANGE_UNSHARE))
+			exit(EXIT_FAILURE);
+
+		for (i = 3; i < 128; i++) {
+			bool closed = i >= 70 && i <= 80;
+
+			if (closed == (fcntl(i, F_GETFD) != -1))
+				exit(EXIT_FAILURE);
+		}
+
+		/* A stale full bit on word 1 would hand out 128, not 70. */
+		if (dup(0) != 70)
+			exit(EXIT_FAILURE);
+
+		exit(EXIT_SUCCESS);
+	}
+
+	EXPECT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_EQ(true, WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+
+	/* The shared table the child unshared from is untouched. */
+	for (i = 3; i < 128; i++)
+		EXPECT_NE(-1, fcntl(i, F_GETFD));
+}
+
 TEST(close_range_cloexec)
 {
 	int i, ret;

-- 
2.53.0

