Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C6350AC12
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2026 15:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789745618; cv=none; b=keBbrHwQvZ0fBHjrhCMHLmJDJ8fW9yc8+96v8xus3EZVBQTiuF8qOLPYhWCaOAIpgWnroomQDFCfXPbDQc+rP66P6v7w+g7BFLNhpEUbN9zcHEwPyXYLQkgY+2NQnWjOCsEE10sqJp4zF3O1Ooqc664HIWWXtiYtMnNVA4C1uIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789745618; c=relaxed/simple;
	bh=KMg7LIcwjTIHXZlfRPQEJm7YMnNI09tGnzRfT2CuQ6w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JHrWwfZOcmgUPAPmdQQjnPqB+ZCONJ/NRDo1ll2b7CpbkfVfUNBMn7mefmYWy9QCFOvvfffNKyHWd2dLNj+50M2/Rm7n3vpavq7slYWBqUOcRRYjTel5F/NpADi4w9cgcJYibzgAhOimKPDel0LwxPgaxUzcU+DxJN4GM9V6jas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PinwlIup; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PinwlIup"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cfc52ddc55so11769545ad.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2026 08:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789745616; x=1790350416; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qSlM5tp89ADGL7d7hsn2qc0Ifj+pabEAxR9BGEjE7ls=;
        b=PinwlIup6CFTiUZHZwiJFAtfGPLE7P9OMfTSQInQ9nUak7WMTVNLM/FgUMt6fVodYm
         MlArm5s+mjyP+TMtwbEa6bJSpl1dN4amNykDRKP9G74g0p/0Q5VHFaFTAEJjylkll89H
         z/j4+pT/Tgt27Si6VNwOyeg6noSJ/i4CzHHiQx8D74qs7UlP++OIN/0Qeu3le7saJ3Gc
         fN/Fh2x4drqBhmguPqZv1C+zldQqtMU8a/yXUDBw6hFMWjh55/JBOo1Yf/S6fFAMReaz
         CQliLmTWmw0CL1hmzn3NJ8PEahy7P2itkMBFAgIHuNyNV84yvwO6s8ACUbtjhEJoO7dh
         t1Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789745616; x=1790350416;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qSlM5tp89ADGL7d7hsn2qc0Ifj+pabEAxR9BGEjE7ls=;
        b=gKTLI5QX6qcga05zvxoPM6XXWUr81QisfmziSSP3h9wplK/pYHQjRX8mHAO4hXuUkN
         FB8d0MWcmst8Sy6UYt65hgvDB5StyvOVS2Sye6QxNj7W4zAMVTv63jI+6Q7X1T3pZKww
         PiOJlr6Zye5bjm9mN/PDsQ1aYDcj88fXVFT7LOOnzarJMJlHs3rg1r2r6bcXpGARWqC8
         ulJ/NSgQHG08dFJFai2GT+2xFtah/hy6tUhrAdXuU6xXR52H7hSZRqZfZTJ95VKQT8z/
         9MWXZOa4Bbgi1LWd/nW8I0ShoKiDxfHkWwdiMHJmObgq00evObEVR98oZDL1pOap5HnR
         R/+A==
X-Forwarded-Encrypted: i=1; AKwUvBznmlx4SEHjbOqfKaVQ4V2kCWfRZOIXzNs778YKk4iTDxTCaHjvW5GEmNX1USj36XhwajHP0Bi0n8fBUBcd@vger.kernel.org
X-Gm-Message-State: AFuF++kkkiMFsbVEKURcT/amr7Cx/b6Bo67i5sMw9xjwhJ7OweJNvink
	iG0ENlKB4tqV+I7n15/aDh/pKK3DXkOoSDx/u80WJoHYi1Euq99J4j/fz2T0Vg3WubSelTbEEXL
	25p1ywA==
X-Received: from plly11.prod.google.com ([2002:a17:902:7c8b:b0:2dd:c0fa:93f7])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2ac4:b0:2dd:c0a5:6634
 with SMTP id d9443c01a7336-2ddc0a5674fmr2432485ad.15.1789745615483; Fri, 18
 Sep 2026 08:33:35 -0700 (PDT)
Date: Fri, 18 Sep 2026 08:33:18 -0700
In-Reply-To: <20260918153318.758387-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260918153318.758387-1-surenb@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260918153318.758387-8-surenb@google.com>
Subject: [PATCH v5 7/7] selftests/proc: add /proc/pid/smaps_rollup tearing tests
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: liam@infradead.org, ljs@kernel.org, vbabka@kernel.org, david@kernel.org, 
	willy@infradead.org, jannh@google.com, paulmck@kernel.org, pfalcato@suse.de, 
	xueyuan.chen21@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

During tearing tests, smaps_rollup Pss* metrics should stay constant.
Extend /proc/pid/smaps tearing tests to also check for smaps_rollup
consistency.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 tools/testing/selftests/proc/proc-maps-race.c | 186 +++++++++++++++++-
 1 file changed, 181 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/proc/proc-maps-race.c b/tools/testing/selftests/proc/proc-maps-race.c
index 415eccb70468..bf4c5073f6fc 100644
--- a/tools/testing/selftests/proc/proc-maps-race.c
+++ b/tools/testing/selftests/proc/proc-maps-race.c
@@ -80,6 +80,61 @@ enum maps_file {
 
 struct vma_modifier_info;
 
+enum smaps_rollup_stat {
+	Rss,
+	Pss,
+	Pss_Dirty,
+	Pss_Anon,
+	Pss_File,
+	Pss_Shmem,
+	Shared_Clean,
+	Shared_Dirty,
+	Private_Clean,
+	Private_Dirty,
+	Referenced,
+	Anonymous,
+	KSM,
+	LazyFree,
+	AnonHugePages,
+	ShmemPmdMapped,
+	FilePmdMapped,
+	Shared_Hugetlb,
+	Private_Hugetlb,
+	Swap,
+	SwapPss,
+	Locked,
+	RollupFieldCount
+};
+
+static const char *smaps_rollup_stat_names[RollupFieldCount] = {
+	"Rss",
+	"Pss",
+	"Pss_Dirty",
+	"Pss_Anon",
+	"Pss_File",
+	"Pss_Shmem",
+	"Shared_Clean",
+	"Shared_Dirty",
+	"Private_Clean",
+	"Private_Dirty",
+	"Referenced",
+	"Anonymous",
+	"KSM",
+	"LazyFree",
+	"AnonHugePages",
+	"ShmemPmdMapped",
+	"FilePmdMapped",
+	"Shared_Hugetlb",
+	"Private_Hugetlb",
+	"Swap",
+	"SwapPss",
+	"Locked",
+};
+
+struct smaps_rollup_stats {
+	unsigned long values[RollupFieldCount];
+};
+
 FIXTURE(proc_maps_race)
 {
 	struct vma_modifier_info *mod_info;
@@ -91,6 +146,7 @@ FIXTURE(proc_maps_race)
 	enum maps_file maps_file;
 	int shared_mem_size;
 	int skip_pages;
+	int rollup_fd;
 	int page_size;
 	int vma_count;
 	bool verbose;
@@ -132,12 +188,12 @@ struct vma_modifier_info {
 	void *child_mapped_addr[];
 };
 
-static bool read_page(FIXTURE_DATA(proc_maps_race) *self,
+static bool read_page(FIXTURE_DATA(proc_maps_race) *self, int fd,
 		      struct page_content *page)
 {
 	ssize_t  bytes_read;
 
-	bytes_read = read(self->maps_fd, page->data, self->page_size);
+	bytes_read = read(fd, page->data, self->page_size);
 	if (bytes_read <= 0)
 		return false;
 
@@ -175,7 +231,7 @@ static int locate_containing_page(FIXTURE_DATA(proc_maps_race) *self,
 		char *curr_pos;
 		char *end_pos;
 
-		if (!read_page(self, &self->page1))
+		if (!read_page(self, self->maps_fd, &self->page1))
 			return -1;
 
 		curr_pos = self->page1.data;
@@ -205,10 +261,11 @@ static bool read_two_pages(FIXTURE_DATA(proc_maps_race) *self)
 		return false;
 
 	for (int i = 0; i < self->skip_pages; i++)
-		if (!read_page(self, &self->page1))
+		if (!read_page(self, self->maps_fd, &self->page1))
 			return false;
 
-	return read_page(self, &self->page1) && read_page(self, &self->page2);
+	return read_page(self, self->maps_fd, &self->page1) &&
+	       read_page(self, self->maps_fd, &self->page2);
 }
 
 static void copy_line(const char *line_start, const char *line_end,
@@ -317,6 +374,61 @@ static bool read_boundary_lines(FIXTURE_DATA(proc_maps_race) *self,
 		      &first_line->end_addr) == 2;
 }
 
+static bool parse_smaps_rollup(FIXTURE_DATA(proc_maps_race) *self,
+		struct smaps_rollup_stats *stats)
+{
+	unsigned int dev_maj, dev_min, inode;
+	unsigned long start, end, offs;
+	unsigned long value;
+	char name[32], perm[5];
+	char *curr_pos;
+	char *end_pos;
+	char *line_end;
+
+	if (lseek(self->rollup_fd, 0, SEEK_SET) < 0)
+		return false;
+
+	if (!read_page(self, self->rollup_fd, &self->page1))
+		return false;
+
+	curr_pos = self->page1.data;
+	end_pos = self->page1.data + self->page1.size;
+
+	line_end = strchr(curr_pos, '\n');
+	if (!line_end)
+		return false;
+
+	if (sscanf(curr_pos, "%lx-%lx %4s %lx %u:%u %u %31s",
+		&start, &end, perm, &offs, &dev_maj, &dev_min, &inode, name) != 8)
+		return false;
+
+	if (strcmp(name, "[rollup]"))
+		return false;
+
+	for (int stat = 0; stat < ARRAY_SIZE(smaps_rollup_stat_names); stat++) {
+		int len;
+
+		curr_pos = line_end + 1;
+		if (curr_pos >= end_pos)
+			return false;
+
+		line_end = strchr(curr_pos, '\n');
+		if (!line_end)
+			return false;
+
+		if (sscanf(curr_pos, "%31s %lu kB", name, &value) != 2)
+			return false;
+
+		len = strlen(name);
+		if (name[len - 1] != ':' || strncmp(name, smaps_rollup_stat_names[stat], len - 1))
+			return false;
+
+		stats->values[stat] = value;
+	}
+
+	return true;
+}
+
 /* Thread synchronization routines */
 static void wait_for_state(struct vma_modifier_info *mod_info, enum test_state state)
 {
@@ -397,6 +509,40 @@ static bool print_boundaries_on(bool condition, const char *title,
 	return condition;
 }
 
+static void print_smaps_rollup_stats(const char *title, FIXTURE_DATA(proc_maps_race) *self,
+		struct smaps_rollup_stats *stats)
+{
+	printf("%s", title);
+	for (int stat = 0; stat < ARRAY_SIZE(smaps_rollup_stat_names); stat++)
+		printf("%64s %lu kB\n", smaps_rollup_stat_names[stat], stats->values[stat]);
+}
+
+static bool cmp_smaps_rollup_stat(struct smaps_rollup_stats *s1,
+		struct smaps_rollup_stats *s2, enum smaps_rollup_stat stat)
+{
+	return s1->values[stat] == s2->values[stat];
+}
+
+static bool compare_smaps_rollup(FIXTURE_DATA(proc_maps_race) *self,
+		struct smaps_rollup_stats *expected,
+		struct smaps_rollup_stats *actual)
+{
+	/*
+	 * Clean/dirty metrics might change but Pss-related ones
+	 * should stay constant.
+	 */
+	if (cmp_smaps_rollup_stat(expected, actual, Pss) &&
+	    cmp_smaps_rollup_stat(expected, actual, Pss_Anon) &&
+	    cmp_smaps_rollup_stat(expected, actual, Pss_File) &&
+	    cmp_smaps_rollup_stat(expected, actual, Pss_Shmem))
+		return true;
+
+	print_smaps_rollup_stats("Expected stats:", self, expected);
+	print_smaps_rollup_stats("Actual stats:", self, actual);
+
+	return false;
+}
+
 static void report_test_start(const char *name, bool verbose)
 {
 	if (verbose)
@@ -572,6 +718,7 @@ FIXTURE_SETUP(proc_maps_race)
 	unsigned long first_map_addr;
 	unsigned long last_map_addr;
 	unsigned long duration_sec;
+	char rollup_fname[32];
 	char fname[32];
 
 	self->page_size = (unsigned long)sysconf(_SC_PAGESIZE);
@@ -649,6 +796,9 @@ FIXTURE_SETUP(proc_maps_race)
 		break;
 	case SMAPS:
 		sprintf(fname, "/proc/%d/smaps", self->pid);
+		sprintf(rollup_fname, "/proc/%d/smaps_rollup", self->pid);
+		self->rollup_fd = open(rollup_fname, O_RDONLY);
+		ASSERT_NE(self->rollup_fd, -1);
 		break;
 	default:
 		ksft_exit_fail();
@@ -711,6 +861,8 @@ FIXTURE_TEARDOWN(proc_maps_race)
 	for (int i = 0; i < self->vma_count; i++)
 		munmap(self->mod_info->child_mapped_addr[i], self->page_size);
 	close(self->maps_fd);
+	if (self->maps_file == SMAPS)
+		close(self->rollup_fd);
 	waitpid(self->pid, &status, 0);
 	munmap(self->mod_info, self->shared_mem_size);
 }
@@ -723,6 +875,7 @@ TEST_F(proc_maps_race, test_maps_tearing_from_split)
 	struct line_content split_first_line;
 	struct line_content restored_last_line;
 	struct line_content restored_first_line;
+	struct smaps_rollup_stats orig_stats;
 
 	wait_for_state(mod_info, SETUP_READY);
 
@@ -736,6 +889,8 @@ TEST_F(proc_maps_race, test_maps_tearing_from_split)
 	report_test_start("Tearing from split", self->verbose);
 	ASSERT_TRUE(capture_mod_pattern(self, &split_last_line, &split_first_line,
 					&restored_last_line, &restored_first_line));
+	if (self->maps_file == SMAPS)
+		ASSERT_TRUE(parse_smaps_rollup(self, &orig_stats));
 
 	/* Now start concurrent modifications for self->duration_sec */
 	signal_state(mod_info, TEST_READY);
@@ -799,6 +954,11 @@ TEST_F(proc_maps_race, test_maps_tearing_from_split)
 				     vma_end == self->last_line.end_addr) ||
 				    (vma_start == split_first_line.start_addr &&
 				     vma_end == split_first_line.end_addr));
+		} else {
+			struct smaps_rollup_stats stats;
+
+			ASSERT_TRUE(parse_smaps_rollup(self, &stats));
+			ASSERT_TRUE(compare_smaps_rollup(self, &orig_stats, &stats));
 		}
 		clock_gettime(CLOCK_MONOTONIC_COARSE, &end_ts);
 		end_test_iteration(&end_ts, self->verbose);
@@ -817,6 +977,7 @@ TEST_F(proc_maps_race, test_maps_tearing_from_resize)
 	struct line_content shrunk_first_line;
 	struct line_content restored_last_line;
 	struct line_content restored_first_line;
+	struct smaps_rollup_stats orig_stats;
 
 	wait_for_state(mod_info, SETUP_READY);
 
@@ -830,6 +991,8 @@ TEST_F(proc_maps_race, test_maps_tearing_from_resize)
 	report_test_start("Tearing from resize", self->verbose);
 	ASSERT_TRUE(capture_mod_pattern(self, &shrunk_last_line, &shrunk_first_line,
 					&restored_last_line, &restored_first_line));
+	if (self->maps_file == SMAPS)
+		ASSERT_TRUE(parse_smaps_rollup(self, &orig_stats));
 
 	/* Now start concurrent modifications for self->duration_sec */
 	signal_state(mod_info, TEST_READY);
@@ -880,6 +1043,11 @@ TEST_F(proc_maps_race, test_maps_tearing_from_resize)
 			ASSERT_TRUE(vma_start == self->last_line.start_addr &&
 				    (vma_end - vma_start == self->page_size * 3 ||
 				     vma_end - vma_start == self->page_size));
+		} else {
+			struct smaps_rollup_stats stats;
+
+			ASSERT_TRUE(parse_smaps_rollup(self, &stats));
+			ASSERT_TRUE(compare_smaps_rollup(self, &orig_stats, &stats));
 		}
 		clock_gettime(CLOCK_MONOTONIC_COARSE, &end_ts);
 		end_test_iteration(&end_ts, self->verbose);
@@ -898,6 +1066,7 @@ TEST_F(proc_maps_race, test_maps_tearing_from_remap)
 	struct line_content remapped_first_line;
 	struct line_content restored_last_line;
 	struct line_content restored_first_line;
+	struct smaps_rollup_stats orig_stats;
 
 	wait_for_state(mod_info, SETUP_READY);
 
@@ -911,6 +1080,8 @@ TEST_F(proc_maps_race, test_maps_tearing_from_remap)
 	report_test_start("Tearing from remap", self->verbose);
 	ASSERT_TRUE(capture_mod_pattern(self, &remapped_last_line, &remapped_first_line,
 					&restored_last_line, &restored_first_line));
+	if (self->maps_file == SMAPS)
+		ASSERT_TRUE(parse_smaps_rollup(self, &orig_stats));
 
 	/* Now start concurrent modifications for self->duration_sec */
 	signal_state(mod_info, TEST_READY);
@@ -963,6 +1134,11 @@ TEST_F(proc_maps_race, test_maps_tearing_from_remap)
 				     vma_end - vma_start == self->page_size * 3) ||
 				    (vma_start == self->last_line.start_addr + self->page_size &&
 				     vma_end - vma_start == self->page_size));
+		} else {
+			struct smaps_rollup_stats stats;
+
+			ASSERT_TRUE(parse_smaps_rollup(self, &stats));
+			ASSERT_TRUE(compare_smaps_rollup(self, &orig_stats, &stats));
 		}
 		clock_gettime(CLOCK_MONOTONIC_COARSE, &end_ts);
 		end_test_iteration(&end_ts, self->verbose);
-- 
2.55.0.1082.g2b9226bbc0-goog

