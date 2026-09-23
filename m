Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D887361DA7
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 12:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790166504; cv=none; b=Sbc8gth9+39S8f2uW+b1CXy1KmM2QK7VmOzhQbo4XKXoUCV567Gst9zGz2GXH0Wf41rqKhuabpQ5SvFJxhSjKMmSlBgnPOIGeiTlq8xBeOvD3cA1+ec170lR3GlS0tkAVhJ00ldNfHEFeQvbqEbik1YjtJiyBIvE89XIN980qFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790166504; c=relaxed/simple;
	bh=/i6zInYt7Y2no5+FlveuHQC9/HJuqRVk7y+STVJas8I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jypvd4Xq3GfrHGsbO20V0ExwOaL79G2LRpottXs+XOFKgxD6q4WpQwmCuo8p/D24gkCGcdl6WWs0VR6MpyVWVE3OL1zF0Pj94oAfU/Fgkta6J8DjP/7PTWnCGIT6k8tu0oClJmxx3xapKT/kVYG6zBaVahNWtTz2uKmbzBnxT9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/JP0hl5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/JP0hl5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B811F000FF;
	Wed, 23 Sep 2026 12:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790166503;
	bh=+asGj7qYngroIAdZjGLOlrUbp6ebGrnpg5gmS2ymeGc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=f/JP0hl5tsdTkRtKGqKVKovO8Rez8WjbDg36Ca6ZcdhVnsDZ18JlXu3zet88Z4DE3
	 sEHVvb1GglN3jo8CNM/2mxy5U2hcqLyXdYa+PdkMrPZwtfJDwOdiAgMZirDxYOBFYs
	 1ujCasoJNUyLptnkWHMJXAr72xMw/XaEU45PXYwSPyCxRNjXZbv7v3Xrw+NF/AcSqZ
	 TFlk8f6qBxKzfdzmTJhRd1EYIktHuDMDsUFknB9RqicxS0hr/DUBNl5U5NsJbmI5+z
	 jfbNztDHz2vLxPqt/ZQj7Vsi2TSmN6MENBxS5arsEUiUV3a3TgrkHijwdNbPgt5abV
	 U9Yo6zxa5g8jg==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 23 Sep 2026 14:27:56 +0200
Subject: [PATCH 4/8] selftests/move_mount_set_group: check that an
 unbindable target is refused
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-work-mount-fixes-v1-4-f424cf8d3242@kernel.org>
References: <20260923-work-mount-fixes-v1-0-f424cf8d3242@kernel.org>
In-Reply-To: <20260923-work-mount-fixes-v1-0-f424cf8d3242@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=4040; i=brauner@kernel.org;
 h=from:subject:message-id; bh=/i6zInYt7Y2no5+FlveuHQC9/HJuqRVk7y+STVJas8I=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRtPnrHcmb5DPGzWWYhH9vCV7Dt3RKuelLSb/2ETfre3
 8M4FSR1OkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYyYQIjw7YPL/bo7vCsn/Ys
 uFY7QDMk6YPTtRim7CdTyrfoXHpeqs/IcEAv9Hbz302hD8vns3mVF/n/m2ZyPXhPT/fNlVtPaa/
 jYwIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

MOVE_MOUNT_SET_GROUP must not accept an unbindable mount as the target.
Cover both sources:

- a slave, which used to leave the target unbindable and a slave at once

- a shared mount, which used to silently drop the unbindable flag

Check that the target is untouched after the refused call.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 .../move_mount_set_group_test.c                    | 74 ++++++++++++++++++++--
 1 file changed, 68 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c b/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c
index 12434415ec36..9c8fc8c7f62c 100644
--- a/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c
+++ b/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c
@@ -146,17 +146,19 @@ static void null_endofword(char *word)
 	*word = '\0';
 }
 
-static bool is_shared_mount(const char *path)
+/* Does the mount on @path carry the optional field @field in mountinfo? */
+static bool mount_has_field(const char *path, const char *field)
 {
 	size_t len = 0;
 	char *line = NULL;
 	FILE *f = NULL;
+	bool found = false;
 
 	f = fopen("/proc/self/mountinfo", "re");
 	if (!f)
 		return false;
 
-	while (getline(&line, &len, f) != -1) {
+	while (!found && getline(&line, &len, f) != -1) {
 		char *opts, *target;
 
 		target = get_field(line, 4);
@@ -172,15 +174,29 @@ static bool is_shared_mount(const char *path)
 		if (strcmp(target, path) != 0)
 			continue;
 
-		null_endofword(opts);
-		if (strstr(opts, "shared:"))
-			return true;
+		/* the optional fields end at the "-" separator */
+		while (opts && *opts != '-') {
+			char *next = strchr(opts, ' ');
+
+			if (next)
+				*next++ = '\0';
+			if (!strncmp(opts, field, strlen(field))) {
+				found = true;
+				break;
+			}
+			opts = next;
+		}
 	}
 
 	free(line);
 	fclose(f);
 
-	return false;
+	return found;
+}
+
+static bool is_shared_mount(const char *path)
+{
+	return mount_has_field(path, "shared:");
 }
 
 /* Attempt to de-conflict with the selftests tree. */
@@ -372,4 +388,50 @@ TEST_F(move_mount_set_group, complex_sharing_copying)
 	ASSERT_EQ(is_shared_mount(SET_GROUP_A), 1);
 }
 
+#define SET_GROUP_B "/tmp/B"
+#define SET_GROUP_C "/tmp/C"
+
+/*
+ * An unbindable mount is neither shared nor a slave, so it must not be
+ * accepted as the target: with a slave source it would end up unbindable
+ * and a slave at the same time.
+ */
+TEST_F(move_mount_set_group, unbindable_target)
+{
+	bool ret;
+
+	ret = move_mount_set_group_supported();
+	ASSERT_GE(ret, 0);
+	if (!ret)
+		SKIP(return, "move_mount(MOVE_MOUNT_SET_GROUP) is not supported");
+
+	ASSERT_EQ(mount(NULL, SET_GROUP_A, NULL, MS_SHARED, 0), 0);
+
+	/* B: a slave of A's peer group */
+	ASSERT_EQ(mkdir(SET_GROUP_B, 0777), 0);
+	ASSERT_EQ(mount(SET_GROUP_A, SET_GROUP_B, NULL, MS_BIND, NULL), 0);
+	ASSERT_EQ(mount(NULL, SET_GROUP_B, NULL, MS_SLAVE, 0), 0);
+	ASSERT_TRUE(mount_has_field(SET_GROUP_B, "master:"));
+
+	/* C: unbindable */
+	ASSERT_EQ(mkdir(SET_GROUP_C, 0777), 0);
+	ASSERT_EQ(mount(SET_GROUP_A, SET_GROUP_C, NULL, MS_BIND, NULL), 0);
+	ASSERT_EQ(mount(NULL, SET_GROUP_C, NULL, MS_UNBINDABLE, 0), 0);
+	ASSERT_TRUE(mount_has_field(SET_GROUP_C, "unbindable"));
+
+	/* from a slave */
+	ASSERT_EQ(syscall(__NR_move_mount, AT_FDCWD, SET_GROUP_B,
+			  AT_FDCWD, SET_GROUP_C, MOVE_MOUNT_SET_GROUP), -1);
+	ASSERT_EQ(errno, EINVAL);
+	ASSERT_FALSE(mount_has_field(SET_GROUP_C, "master:"));
+	ASSERT_TRUE(mount_has_field(SET_GROUP_C, "unbindable"));
+
+	/* from a shared mount */
+	ASSERT_EQ(syscall(__NR_move_mount, AT_FDCWD, SET_GROUP_A,
+			  AT_FDCWD, SET_GROUP_C, MOVE_MOUNT_SET_GROUP), -1);
+	ASSERT_EQ(errno, EINVAL);
+	ASSERT_FALSE(mount_has_field(SET_GROUP_C, "shared:"));
+	ASSERT_TRUE(mount_has_field(SET_GROUP_C, "unbindable"));
+}
+
 TEST_HARNESS_MAIN

-- 
2.53.0

