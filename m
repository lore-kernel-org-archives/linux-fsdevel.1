Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A1F2DF155
	for <linux-fsdevel@vger.kernel.org>; Sun, 26 Apr 2026 06:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777184852; cv=none; b=FLfIp29WM2Af/Y7A4Mj9Vqj9t4tVajbVt+x5xLiIN1nUZkD3Wwe5H+7qKB4JEaNV2EdbRR1Ilf/AwesVpCH4LLBwL8KRqsmqgon2ZmikNI7Qis+mw/c3axDlQ/aXIE2P6CBULmudOxcLatnb395v/WYY+ECcnVCkwO5Ct407QGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777184852; c=relaxed/simple;
	bh=yxX9S+gKUq71RidCW01kW3BfqOUd2y3AtJzsLU2iU+I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uJGDHaldf8GBHrQxU65FVTEb4V1OVZEa/22Ya1gGWosyQzrw3e6oCNFAgktX/j/fpk3kezAa0OrOzVdz/y9oVcoOKp/mxNbhYqqBM8vbGNWTunw2bqkAjRXvsYhjMwi/cTPNt2C7OCmYkYK64M5FtgboGcfQkjnRfr4dG48M93c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DesYcZ0g; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DesYcZ0g"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12c20d5d7f4so44487197c88.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Apr 2026 23:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777184848; x=1777789648; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0bz3o39/B8+STfzOmNVRr4jYj/f9wiAKcuL2hAc9CAE=;
        b=DesYcZ0gTvXSAN3jcPFsPNf0ZsYDchBVh6/sI4LjgN51XQ4B9C4xp7N+eiFM8ourfo
         mcBhVgYL2NNCtFknVRTf2XFWa5f0jvfU/CD3o1WuIayALKg3Cbz8kK4S65sAG1Hk+jsR
         tDsUOvPvL2M9rZQhxDdJn7xamRHf7Gb2ivdzwllnUq1Sn1k7joPWo5c61WQAZrYc64fO
         IzkGA5xpY5/jCOBzYhzbUYMEto51tsy3F8XQ9bPACgp3h3nBVbSfISPpvi/rAAtED6bn
         ebQ5ubbVANmdoTNWOLQzPDnM30aF18wPKvR3rt7QE3bIRLfk57ylg8oTR4bzYtHWK+Q6
         gymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777184848; x=1777789648;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0bz3o39/B8+STfzOmNVRr4jYj/f9wiAKcuL2hAc9CAE=;
        b=YGCOJ6Yc0Nnh9Rqc1MnOY6DF3T21Wp5URmZp6eYJIQy1iRYanpZ3mDYYJLqvnHMWva
         fNytif4EAn7kLki9P9xIFGCD3HDj3syOmdAcBcesY8IpEbp4Z2GRZ1rP/DH+frEa5ztf
         VxauVDQss0C8/emP+yLoKOMAWDuFZDR8VATkScD4mJIRrTGtBXy/oTj5i8COoJKEr8s3
         ziW8CjeocwahQ5JptBYKAnlBifl1Bs3QnrWorHtb9hEPeVlOmq6JBQjZ8Mun5F/NDBn7
         pAjG9lLAWjeJt3yxO0Qr+pykXZIAmb9wVe/k7zX0ptW1tUEZHTwgltMTZBzFqv3lNgiJ
         55LQ==
X-Forwarded-Encrypted: i=1; AFNElJ+2PSBPuJkOoJifoPNZajk6ADfdFUe/i/K3rjy4Nl7alh1GKj2EwNBiTZ4nqrI+uNOY88LTbQTrxhVN7Pfw@vger.kernel.org
X-Gm-Message-State: AOJu0YybUZEisJvkXG8JK/64TUdHHIWoBNoJSTHkDrsToowCZDQcziIG
	TnbtGVANU5mDeCA5mI0ZFtJQeBDdZGqWuloYuJC9q/NkqpuYFiE2qR7Ba46TnENAfdWcRwJiIwn
	jgf0yRw==
X-Received: from dlbpu1.prod.google.com ([2002:a05:7022:e881:b0:12c:4955:b382])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:458f:b0:12d:ca9f:7e4f
 with SMTP id a92af1059eb24-12dca9f818dmr3135792c88.19.1777184848209; Sat, 25
 Apr 2026 23:27:28 -0700 (PDT)
Date: Sat, 25 Apr 2026 23:27:18 -0700
In-Reply-To: <20260426062718.1238437-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260426062718.1238437-1-surenb@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260426062718.1238437-4-surenb@google.com>
Subject: [PATCH v2 3/3] selftests/proc: add /proc/pid/smaps tearing tests
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: liam@infradead.org, ljs@kernel.org, vbabka@kernel.org, david@redhat.com, 
	willy@infradead.org, jannh@google.com, paulmck@kernel.org, pfalcato@suse.de, 
	shuah@kernel.org, hsukrut3@gmail.com, richard.weiyang@gmail.com, 
	reddybalavignesh9979@gmail.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

Add tearing tests for /proc/pid/smaps file. New tests reuse the same
logic as with maps file but skipping all the data except for the VMA
addresses, which are the only part relevant for the tearing tests.
Skip PROCMAP_QUERY parts of the tests because smaps does not implement
that ioctl.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Liam R. Howlett <liam@infradead.org>
---
 tools/testing/selftests/proc/proc-maps-race.c | 178 +++++++++++++-----
 1 file changed, 133 insertions(+), 45 deletions(-)

diff --git a/tools/testing/selftests/proc/proc-maps-race.c b/tools/testing/selftests/proc/proc-maps-race.c
index 5eb350c23da4..1026d8c400e1 100644
--- a/tools/testing/selftests/proc/proc-maps-race.c
+++ b/tools/testing/selftests/proc/proc-maps-race.c
@@ -17,8 +17,8 @@
  */
 /*
  * Fork a child that concurrently modifies address space while the main
- * process is reading /proc/$PID/maps and verifying the results. Address
- * space modifications include:
+ * process is reading /proc/$PID/maps and /proc/$PID/smaps, verifying the
+ * results. Address space modifications include:
  *     VMA splitting and merging
  *
  */
@@ -73,6 +73,11 @@ enum test_state {
 	TEST_DONE,
 };
 
+enum maps_file {
+	MAPS,
+	SMAPS,
+};
+
 struct vma_modifier_info;
 
 FIXTURE(proc_maps_race)
@@ -83,6 +88,7 @@ FIXTURE(proc_maps_race)
 	struct line_content last_line;
 	struct line_content first_line;
 	unsigned long duration_sec;
+	enum maps_file maps_file;
 	int shared_mem_size;
 	int skip_pages;
 	int page_size;
@@ -92,6 +98,19 @@ FIXTURE(proc_maps_race)
 	pid_t pid;
 };
 
+FIXTURE_VARIANT(proc_maps_race)
+{
+	const enum maps_file maps_file;
+};
+
+FIXTURE_VARIANT_ADD(proc_maps_race, maps) {
+	.maps_file = MAPS,
+};
+
+FIXTURE_VARIANT_ADD(proc_maps_race, smaps) {
+	.maps_file = SMAPS,
+};
+
 typedef bool (*vma_modifier_op)(FIXTURE_DATA(proc_maps_race) *self);
 typedef bool (*vma_mod_result_check_op)(struct line_content *mod_last_line,
 					struct line_content *mod_first_line,
@@ -222,6 +241,57 @@ static void copy_last_line(struct page_content *page, char *last_line,
 	copy_line(pos, end, last_line, line_size);
 }
 
+static bool copy_first_entry(struct page_content *page, char *first_line,
+			     size_t line_size)
+{
+	char *start_pos = page->data;
+
+	while (start_pos < page->data + page->size) {
+		unsigned long start_addr;
+		unsigned long end_addr;
+		char *end_pos;
+
+		end_pos = strchr(start_pos, '\n');
+		if (!end_pos)
+			break;
+
+		if (parse_vma_line(start_pos, end_pos, &start_addr, &end_addr)) {
+			copy_line(start_pos, end_pos, first_line, line_size);
+			return true;
+		}
+
+		start_pos = end_pos + 1;
+	}
+
+	return false;
+}
+
+static bool copy_last_entry(struct page_content *page, char *last_line,
+			    size_t line_size)
+{
+	char *end_pos = page->data + page->size - 1;
+	char *start_pos;
+
+	while (end_pos > page->data) {
+		unsigned long start_addr;
+		unsigned long end_addr;
+
+		/* skip last newline */
+		start_pos = end_pos - 1;
+		/* search previous newline */
+		while (start_pos > page->data && start_pos[-1] != '\n')
+			start_pos--;
+		if (parse_vma_line(start_pos, end_pos, &start_addr, &end_addr)) {
+			copy_line(start_pos, end_pos, last_line, line_size);
+			return true;
+		}
+
+		end_pos = start_pos - 1;
+	}
+
+	return false;
+}
+
 /* Read the last line of the first page and the first line of the second page */
 static bool read_boundary_lines(FIXTURE_DATA(proc_maps_race) *self,
 				struct line_content *last_line,
@@ -230,8 +300,16 @@ static bool read_boundary_lines(FIXTURE_DATA(proc_maps_race) *self,
 	if (!read_two_pages(self))
 		return false;
 
-	copy_last_line(&self->page1, last_line->text, LINE_MAX_SIZE);
-	copy_first_line(&self->page2, first_line->text, LINE_MAX_SIZE);
+	if (self->maps_file == MAPS) {
+		copy_last_line(&self->page1, last_line->text, LINE_MAX_SIZE);
+		copy_first_line(&self->page2, first_line->text, LINE_MAX_SIZE);
+	} else if (self->maps_file == SMAPS) {
+		if (!copy_last_entry(&self->page1, last_line->text, LINE_MAX_SIZE) ||
+		    !copy_first_entry(&self->page2, first_line->text, LINE_MAX_SIZE))
+			return false;
+	} else {
+		return false;
+	}
 
 	return sscanf(last_line->text, "%lx-%lx", &last_line->start_addr,
 		      &last_line->end_addr) == 2 &&
@@ -497,6 +575,7 @@ FIXTURE_SETUP(proc_maps_race)
 
 	self->page_size = (unsigned long)sysconf(_SC_PAGESIZE);
 	self->verbose = verbose && !strncmp(verbose, "1", 1);
+	self->maps_file = variant->maps_file;
 	duration_sec = duration ? atol(duration) : 0;
 	self->duration_sec = duration_sec ? duration_sec : 5UL;
 
@@ -563,7 +642,16 @@ FIXTURE_SETUP(proc_maps_race)
 		exit(0);
 	}
 
-	sprintf(fname, "/proc/%d/maps", self->pid);
+	switch (self->maps_file) {
+	case MAPS:
+		sprintf(fname, "/proc/%d/maps", self->pid);
+		break;
+	case SMAPS:
+		sprintf(fname, "/proc/%d/smaps", self->pid);
+		break;
+	default:
+		ksft_exit_fail();
+	}
 	self->maps_fd = open(fname, O_RDONLY);
 	ASSERT_NE(self->maps_fd, -1);
 
@@ -608,7 +696,6 @@ FIXTURE_SETUP(proc_maps_race)
 	ASSERT_TRUE(mod_info->addr && mod_info->next_addr);
 
 	signal_state(mod_info, PARENT_READY);
-
 }
 
 FIXTURE_TEARDOWN(proc_maps_race)
@@ -698,20 +785,20 @@ TEST_F(proc_maps_race, test_maps_tearing_from_split)
 		last_line_changed = strcmp(new_last_line.text, self->last_line.text) != 0;
 		first_line_changed = strcmp(new_first_line.text, self->first_line.text) != 0;
 		ASSERT_EQ(last_line_changed, first_line_changed);
-
-		/* Check if PROCMAP_QUERY ioclt() finds the right VMA */
-		ASSERT_TRUE(query_addr_at(self->maps_fd, mod_info->addr + self->page_size,
-					  &vma_start, &vma_end));
-		/*
-		 * The vma at the split address can be either the same as
-		 * original one (if read before the split) or the same as the
-		 * first line in the second page (if read after the split).
-		 */
-		ASSERT_TRUE((vma_start == self->last_line.start_addr &&
-			     vma_end == self->last_line.end_addr) ||
-			    (vma_start == split_first_line.start_addr &&
-			     vma_end == split_first_line.end_addr));
-
+		if (self->maps_file == MAPS) {
+			/* Check if PROCMAP_QUERY ioclt() finds the right VMA */
+			ASSERT_TRUE(query_addr_at(self->maps_fd, mod_info->addr + self->page_size,
+						  &vma_start, &vma_end));
+			/*
+			 * The vma at the split address can be either the same as
+			 * original one (if read before the split) or the same as the
+			 * first line in the second page (if read after the split).
+			 */
+			ASSERT_TRUE((vma_start == self->last_line.start_addr &&
+				     vma_end == self->last_line.end_addr) ||
+				    (vma_start == split_first_line.start_addr &&
+				     vma_end == split_first_line.end_addr));
+		}
 		clock_gettime(CLOCK_MONOTONIC_COARSE, &end_ts);
 		end_test_iteration(&end_ts, self->verbose);
 	} while (end_ts.tv_sec - start_ts.tv_sec < self->duration_sec);
@@ -781,17 +868,18 @@ TEST_F(proc_maps_race, test_maps_tearing_from_resize)
 					strcmp(new_first_line.text, restored_first_line.text),
 					"Expand result invalid", self));
 		}
-
-		/* Check if PROCMAP_QUERY ioclt() finds the right VMA */
-		ASSERT_TRUE(query_addr_at(self->maps_fd, mod_info->addr, &vma_start, &vma_end));
-		/*
-		 * The vma should stay at the same address and have either the
-		 * original size of 3 pages or 1 page if read after shrinking.
-		 */
-		ASSERT_TRUE(vma_start == self->last_line.start_addr &&
-			    (vma_end - vma_start == self->page_size * 3 ||
-			     vma_end - vma_start == self->page_size));
-
+		if (self->maps_file == MAPS) {
+			/* Check if PROCMAP_QUERY ioclt() finds the right VMA */
+			ASSERT_TRUE(query_addr_at(self->maps_fd, mod_info->addr,
+						  &vma_start, &vma_end));
+			/*
+			 * The vma should stay at the same address and have either the
+			 * original size of 3 pages or 1 page if read after shrinking.
+			 */
+			ASSERT_TRUE(vma_start == self->last_line.start_addr &&
+				    (vma_end - vma_start == self->page_size * 3 ||
+				     vma_end - vma_start == self->page_size));
+		}
 		clock_gettime(CLOCK_MONOTONIC_COARSE, &end_ts);
 		end_test_iteration(&end_ts, self->verbose);
 	} while (end_ts.tv_sec - start_ts.tv_sec < self->duration_sec);
@@ -861,20 +949,20 @@ TEST_F(proc_maps_race, test_maps_tearing_from_remap)
 					strcmp(new_first_line.text, restored_first_line.text),
 					"Remap restore result invalid", self));
 		}
-
-		/* Check if PROCMAP_QUERY ioclt() finds the right VMA */
-		ASSERT_TRUE(query_addr_at(self->maps_fd, mod_info->addr + self->page_size,
-					  &vma_start, &vma_end));
-		/*
-		 * The vma should either stay at the same address and have the
-		 * original size of 3 pages or we should find the remapped vma
-		 * at the remap destination address with size of 1 page.
-		 */
-		ASSERT_TRUE((vma_start == self->last_line.start_addr &&
-			     vma_end - vma_start == self->page_size * 3) ||
-			    (vma_start == self->last_line.start_addr + self->page_size &&
-			     vma_end - vma_start == self->page_size));
-
+		if (self->maps_file == MAPS) {
+			/* Check if PROCMAP_QUERY ioclt() finds the right VMA */
+			ASSERT_TRUE(query_addr_at(self->maps_fd, mod_info->addr + self->page_size,
+						  &vma_start, &vma_end));
+			/*
+			 * The vma should either stay at the same address and have the
+			 * original size of 3 pages or we should find the remapped vma
+			 * at the remap destination address with size of 1 page.
+			 */
+			ASSERT_TRUE((vma_start == self->last_line.start_addr &&
+				     vma_end - vma_start == self->page_size * 3) ||
+				    (vma_start == self->last_line.start_addr + self->page_size &&
+				     vma_end - vma_start == self->page_size));
+		}
 		clock_gettime(CLOCK_MONOTONIC_COARSE, &end_ts);
 		end_test_iteration(&end_ts, self->verbose);
 	} while (end_ts.tv_sec - start_ts.tv_sec < self->duration_sec);
-- 
2.54.0.545.g6539524ca2-goog

