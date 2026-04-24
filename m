Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87C93376A9
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 07:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777014188; cv=none; b=t44ME1Z9DSYK9tfaqs2zydtuokNbnp0ZUYgGT+yqsQqOsU+/2BB2gKUvoJFeFTBD00ZM/yRhdRCFXS437ItqZv1YblIo770obEub6/Y6E7Vl0TgE/ld74MwEgpDJu8iSW7jGJk5LapNlmkGGH5/jGBHFmTNP2htG9l8A9mY0zWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777014188; c=relaxed/simple;
	bh=JtFAv6G2caNWJMReAzgreJ08mLrVeU8lSOVMG1xDGNY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rpWdK9U2m261XE1icS+BrZKzjKnVlXBNutI27eqoHrTPu1V7zj3ydri6qJYu2upP0gYXy9tQBm9wVsXJdoFARtXckDaJEqgX1JGJB75jcb0CwzTi7445uLTO3exOU9Wj1Wd3FWISch6/DHzZn3FIcibJ8ZyYs0QaJOW+K7Kxmqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uIPIb6Q7; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uIPIb6Q7"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12c66fdd4aeso11237667c88.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 00:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777014182; x=1777618982; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0swTopRwFXSNiJeH+dx7Oyuq8zIyt+95DwEnqw+0GOE=;
        b=uIPIb6Q7/l7WOfElUpvAkC6SnaR2yGU358M77Ejb+qQIWrH5iqeUre89GBGZDIg1La
         2A/aM5F/dRoPNAl8yttx0bi84ycZFiV3V6FEyxnlFLMqNSXS6kEMIUeEz/LEYl69rfbT
         mNufNzhYHxfDZgFYBfueZhmIyBcG4iKbInHIjg/QUQyTdDRU5xtxHkGMHZkzYpddMBMb
         8F159s2D4wXlHa3oxEFl2SgQP7jHLN0PVm3z+huXqYdi29FwbCgRYPGtx3iVLjxJz9u+
         zUIdETeO2wzlESob4jsAqrV1YZ9qNBL0dFWYeNX/RSThwhXAz9wVtejato/XTjKPZBxL
         8okA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777014182; x=1777618982;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0swTopRwFXSNiJeH+dx7Oyuq8zIyt+95DwEnqw+0GOE=;
        b=oG/v22eDOXcumCdiYv/xdK7abnmWGbjPm374Pe5YihxbGyicdEiyxwTeUpizX9L8/Q
         6rhgYb3GQIKLM71Buyu+oNnX+//s81GP7kJ7AVwSGimk86w3e4Drr2gk3Ak3bCPCuaak
         IamDsVOjzO/X5A3GL6ySpC3bVgE5u0EbWARkSwNihMrJHvvZpn/vCkEX2gdpn+EXrdqc
         VpxxgmYa6qHsVH9MMNoZtoLBscmej/3G7j7i0X17GZcSbU5+7UHcOr+7ITmM+HPHS4Ua
         EvlQjgrdyUTBp/Q6yG4HzT5lbay87hfHF/3nQPzILn6UMWMrJrSuqITyxaBD96Mgcv/o
         H4AQ==
X-Forwarded-Encrypted: i=1; AFNElJ9i2Sf/z6IP0lX7PMmj8nBOP+JdJl32dk67ANJCv04rBVNn2N5QaLTcHySgQ9Mb1pG0OZimQtJSSj60157P@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0518W9c6DYwwgOa2jSt1fx96nFXtBthxZW0lBEwg4gfDy7Pkh
	hH5K/BDLx1EoUYWAFqTubCyNNGxdGRS7IzqJuxtUmBFK3GA0KWcAgQA2SfV4PMGvRKOppWaFJYY
	3Ft7H+g==
X-Received: from dlea14-n1.prod.google.com ([2002:a05:701b:420e:10b0:12c:49a5:e4a4])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6b8d:b0:128:ca90:3301
 with SMTP id a92af1059eb24-12c73f71963mr16316333c88.11.1777014181789; Fri, 24
 Apr 2026 00:03:01 -0700 (PDT)
Date: Fri, 24 Apr 2026 00:02:34 -0700
In-Reply-To: <20260424070234.190145-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260424070234.190145-1-surenb@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260424070234.190145-4-surenb@google.com>
Subject: [PATCH 3/3] selftests/proc: add /proc/pid/smaps tearing tests
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: liam@infradead.org, ljs@kernel.org, vbabka@kernel.org, david@redhat.com, 
	willy@infradead.org, jannh@google.com, paulmck@kernel.org, pfalcato@suse.de, 
	shuah@kernel.org, hsukrut3@gmail.com, richard.weiyang@gmail.com, 
	reddybalavignesh9979@gmail.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

Add MAPS_FILE environment variable to select whether the tests to be run
for /proc/pid/maps or /proc/pid/smaps. Add support for testing smaps file
by reusing the same logic as with maps file but skipping all the data
except for the VMA addresses, which are the only part relevant for the
tearing tests. Skip PROCMAP_QUERY parts of the tests because smaps does
not implement that ioctl.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 tools/testing/selftests/proc/proc-maps-race.c | 176 +++++++++++++-----
 1 file changed, 132 insertions(+), 44 deletions(-)

diff --git a/tools/testing/selftests/proc/proc-maps-race.c b/tools/testing/selftests/proc/proc-maps-race.c
index c5031b0593b7..b677bc23cab9 100644
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
@@ -199,6 +205,57 @@ static void copy_last_line(struct page_content *page, char *last_line)
 	last_line[end - pos] = '\0';
 }
 
+static bool copy_first_entry(struct page_content *page, char *first_line)
+{
+	const char *start_pos = page->data;
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
+		if (sscanf(start_pos, "%lx-%lx", &start_addr, &end_addr) == 2) {
+			strncpy(first_line, start_pos, end_pos - start_pos);
+			first_line[end_pos - start_pos] = '\0';
+			return true;
+		}
+
+		start_pos = end_pos + 1;
+	}
+
+	return false;
+}
+
+static bool copy_last_entry(struct page_content *page, char *last_line)
+{
+	const char *end_pos = page->data + page->size - 1;
+	const char *start_pos;
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
+		if (sscanf(start_pos, "%lx-%lx", &start_addr, &end_addr) == 2) {
+			strncpy(last_line, start_pos, end_pos - start_pos);
+			last_line[end_pos - start_pos] = '\0';
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
@@ -207,8 +264,16 @@ static bool read_boundary_lines(FIXTURE_DATA(proc_maps_race) *self,
 	if (!read_two_pages(self))
 		return false;
 
-	copy_last_line(&self->page1, last_line->text);
-	copy_first_line(&self->page2, first_line->text);
+	if (self->maps_file == MAPS) {
+		copy_last_line(&self->page1, last_line->text);
+		copy_first_line(&self->page2, first_line->text);
+	} else if (self->maps_file == SMAPS) {
+		if (!copy_last_entry(&self->page1, last_line->text) ||
+		    !copy_first_entry(&self->page2, first_line->text))
+			return false;
+	} else {
+		return false;
+	}
 
 	return sscanf(last_line->text, "%lx-%lx", &last_line->start_addr,
 		      &last_line->end_addr) == 2 &&
@@ -464,6 +529,7 @@ FIXTURE_SETUP(proc_maps_race)
 {
 	const char *verbose = getenv("VERBOSE");
 	const char *duration = getenv("DURATION");
+	const char *maps_file = getenv("MAPS_FILE");
 	struct vma_modifier_info *mod_info;
 	pthread_mutexattr_t mutex_attr;
 	pthread_condattr_t cond_attr;
@@ -474,6 +540,18 @@ FIXTURE_SETUP(proc_maps_race)
 
 	self->page_size = (unsigned long)sysconf(_SC_PAGESIZE);
 	self->verbose = verbose && !strncmp(verbose, "1", 1);
+	if (maps_file) {
+		if (!strcmp(maps_file, "maps")) {
+			self->maps_file = MAPS;
+		} else if (!strcmp(maps_file, "smaps")) {
+			self->maps_file = SMAPS;
+		} else {
+			ksft_print_msg("Unknown maps file %s\n", maps_file);
+			ksft_exit_fail();
+		}
+	} else {
+		self->maps_file = MAPS;
+	}
 	duration_sec = duration ? atol(duration) : 0;
 	self->duration_sec = duration_sec ? duration_sec : 5UL;
 
@@ -540,7 +618,16 @@ FIXTURE_SETUP(proc_maps_race)
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
 
@@ -675,20 +762,20 @@ TEST_F(proc_maps_race, test_maps_tearing_from_split)
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
@@ -758,17 +845,18 @@ TEST_F(proc_maps_race, test_maps_tearing_from_resize)
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
@@ -838,20 +926,20 @@ TEST_F(proc_maps_race, test_maps_tearing_from_remap)
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

