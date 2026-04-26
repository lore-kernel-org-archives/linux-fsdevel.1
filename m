Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0278B2E7F3E
	for <linux-fsdevel@vger.kernel.org>; Sun, 26 Apr 2026 06:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777184849; cv=none; b=dWo5OnU/DJrYiP81yqYkua69Z3d8M8zeKkEVGS2yRn03/a7zRqdN1tc/UaYrn7Z7t3eOU+HWZajwosg13XaOX41kFpfMnJGVx9juKWxZzIeTa7zSoQ3NN7eL8krj57w/dZ0mKKjaQC1KhJrJM46wBgkY5+G9bE51c4jDz0uoSB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777184849; c=relaxed/simple;
	bh=WtINYcQ2o5Q20NUYMtezs3/9QnS0e8xfJuo6KIVeYwg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DQjK4+taclb30+y1xMqtLT0fVKdhkSecgoXABy+WsGiaoRXPmQNUgWQvkVwI2KZ8LS43RZKKrtGtztxWt59pvDipOQyCNzRx1RwGRgGL6fuj1Xz4yxjWic92J8u2X8bnkVmnkCsC/AdwCpxplXNAjv0B/WzB0Ekh/rWZG6Rd+ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pLHu35NH; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pLHu35NH"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35da4795b3cso18269397a91.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Apr 2026 23:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777184846; x=1777789646; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=StblesR9iaiFRRbioNuJy6fVbWaUnyZsVnFfUPQ3g9E=;
        b=pLHu35NHV1OK+84jxffdn+0qOsaBVV69AZ8RHz798Q/4wZby4ML1m0joQPfSSFNbna
         LN07ujruJQzAAN+G9lbFPv/FlJlNNeQEXc0y2aCy5VNetfUWcm1vRu9S7uQJj0oNu1Xg
         96L7y8bkr5FpIOHPMRlB72156CfweFyDGKZWYBRkUYZt3YixWMITdnfcZZNh+r46NzDf
         gIDpHTqqrSMBHMnnu+RqY1wvvmcX4OgtgncoVzSM5q1Po2kdSc7GjXVxw98FiSldeDL9
         69DJCJsVfyBCjXQ1G1xksLQ2GgQgqg05kik74mKxdUcEdiOBKHRcF0KjweAyZQvqmeBC
         S1Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777184846; x=1777789646;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=StblesR9iaiFRRbioNuJy6fVbWaUnyZsVnFfUPQ3g9E=;
        b=jr8clZWGB/X526gPgR+A201rvrccMH1Pygmf46MG+G219wUssRiNcOetmhDAzsW/Pb
         Y2yATY8Yonb0lEoIUHef+/endcnloJbgOKRrD/DhKuqOM4TGcQGvku7fY4h8jDcgFMyp
         WryzYbQ/nVj+Hi4ZdB4gBNSfgmtLz+fRTIYeg6AXeKNoxVlL8ud+oTs5XvvfmFqBRZva
         52VoLtP1OPyOqhZGAdefxeOb1Ss7//hhPciAjtNgf8S3Kt+VCoEizgX0gjMGT8mqVaBi
         pJ6QI+oTqYpiMB0LzhFyR968l+viiQxyQylN9f5Vhj0ozgNGmSERs6ZAj49lkcBG07iW
         Fb8w==
X-Forwarded-Encrypted: i=1; AFNElJ/Hfsy1vLyuHfiiIaOCz1JcqEFCW+WpS85IvpPHlHDOy1CKh9DOdTQMmUiQJLXGF9vft49p7Ea7fdv2PUT6@vger.kernel.org
X-Gm-Message-State: AOJu0YwNhs42nokfAtAHdn5XykV+L1AVhsEzfYO0AQf1Ea1quD87K58B
	/LYMkq/tHecoffn7rycAyhRbbrD9CApETPfiHG1JaRjleB5rs/84y5h9di7NPpfGgjJhzPPuBYu
	ZPhTgGQ==
X-Received: from pjbiq12.prod.google.com ([2002:a17:90a:fb4c:b0:35c:27ed:8765])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:8cb:b0:35b:b52d:f34d
 with SMTP id 98e67ed59e1d1-361403b01b9mr28822090a91.5.1777184846217; Sat, 25
 Apr 2026 23:27:26 -0700 (PDT)
Date: Sat, 25 Apr 2026 23:27:17 -0700
In-Reply-To: <20260426062718.1238437-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260426062718.1238437-1-surenb@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260426062718.1238437-3-surenb@google.com>
Subject: [PATCH v2 2/3] selftests/proc: ensure the test is performed at the
 right page boundary
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: liam@infradead.org, ljs@kernel.org, vbabka@kernel.org, david@redhat.com, 
	willy@infradead.org, jannh@google.com, paulmck@kernel.org, pfalcato@suse.de, 
	shuah@kernel.org, hsukrut3@gmail.com, richard.weiyang@gmail.com, 
	reddybalavignesh9979@gmail.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

When running tearing tests we need to ensure the pages we use include
VMAs that were mapped by the child process for this test. Currently we
always use the first two pages, checking VMAs at their boundaries and
this works, however once we add tests for /proc/pid/smaps, the first two
pages might not contain the VMAs that child modifies.
Locate the page that contains the first VMA mapped by the child and use
that and the next page for the test.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Liam R. Howlett <liam@infradead.org>
---
 tools/testing/selftests/proc/proc-maps-race.c | 119 +++++++++++++++---
 1 file changed, 100 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/proc/proc-maps-race.c b/tools/testing/selftests/proc/proc-maps-race.c
index a734553718da..5eb350c23da4 100644
--- a/tools/testing/selftests/proc/proc-maps-race.c
+++ b/tools/testing/selftests/proc/proc-maps-race.c
@@ -39,6 +39,13 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 
+#define min(a, b) \
+	({ \
+		typeof(a) _a = (a); \
+		typeof(b) _b = (b); \
+		_a < _b ? _a : _b; \
+	})
+
 /* /proc/pid/maps parsing routines */
 struct page_content {
 	char *data;
@@ -77,6 +84,7 @@ FIXTURE(proc_maps_race)
 	struct line_content first_line;
 	unsigned long duration_sec;
 	int shared_mem_size;
+	int skip_pages;
 	int page_size;
 	int vma_count;
 	bool verbose;
@@ -105,38 +113,102 @@ struct vma_modifier_info {
 	void *child_mapped_addr[];
 };
 
-
-static bool read_two_pages(FIXTURE_DATA(proc_maps_race) *self)
+static bool read_page(FIXTURE_DATA(proc_maps_race) *self,
+		      struct page_content *page)
 {
 	ssize_t  bytes_read;
 
-	if (lseek(self->maps_fd, 0, SEEK_SET) < 0)
+	bytes_read = read(self->maps_fd, page->data, self->page_size);
+	if (bytes_read <= 0)
 		return false;
 
-	bytes_read = read(self->maps_fd, self->page1.data, self->page_size);
-	if (bytes_read <= 0)
+	/* Make sure data always ends with a newline character. */
+	if (page->data[bytes_read - 1] != '\n')
 		return false;
 
-	self->page1.size = bytes_read;
+	page->size = bytes_read;
 
-	bytes_read = read(self->maps_fd, self->page2.data, self->page_size);
-	if (bytes_read <= 0)
+	return true;
+}
+
+static bool parse_vma_line(char *line_start, char *line_end,
+			   unsigned long *start, unsigned long *end)
+{
+	bool found;
+
+	*line_end = '\0'; /* stop sscanf at the EOL */
+	found = (sscanf(line_start, "%lx-%lx", start, end) == 2);
+	*line_end = '\n';
+
+	return found;
+}
+
+static int locate_containing_page(FIXTURE_DATA(proc_maps_race) *self,
+				  unsigned long addr, unsigned long size)
+{
+	unsigned long start, end;
+	int page = 0;
+
+	if (lseek(self->maps_fd, 0, SEEK_SET) < 0)
+		return -1;
+
+	while (true) {
+		char *curr_pos;
+		char *end_pos;
+
+		if (!read_page(self, &self->page1))
+			return -1;
+
+		curr_pos = self->page1.data;
+		end_pos = self->page1.data + self->page1.size;
+		while (curr_pos < end_pos) {
+			char *line_end;
+
+			line_end = strchr(curr_pos, '\n');
+			if (!line_end)
+				break;
+
+			if (parse_vma_line(curr_pos, line_end, &start, &end) &&
+			    start == addr && end == addr + size)
+				return page;
+
+			curr_pos = line_end + 1;
+		}
+		page++;
+	}
+
+	return 0;
+}
+
+static bool read_two_pages(FIXTURE_DATA(proc_maps_race) *self)
+{
+	if (lseek(self->maps_fd, 0, SEEK_SET) < 0)
 		return false;
 
-	self->page2.size = bytes_read;
+	for (int i = 0; i < self->skip_pages; i++)
+		if (!read_page(self, &self->page1))
+			return false;
 
-	return true;
+	return read_page(self, &self->page1) && read_page(self, &self->page2);
 }
 
-static void copy_first_line(struct page_content *page, char *first_line)
+static void copy_line(const char *line_start, const char *line_end,
+		      char *buf, size_t buf_size)
 {
-	char *pos = strchr(page->data, '\n');
+	size_t len = min(line_end - line_start, buf_size - 1);
 
-	strncpy(first_line, page->data, pos - page->data);
-	first_line[pos - page->data] = '\0';
+	strncpy(buf, line_start, len);
+	buf[len] = '\0';
 }
 
-static void copy_last_line(struct page_content *page, char *last_line)
+static void copy_first_line(struct page_content *page, char *first_line,
+			    size_t line_size)
+{
+	copy_line(page->data, strchr(page->data, '\n'), first_line, line_size);
+}
+
+static void copy_last_line(struct page_content *page, char *last_line,
+			   size_t line_size)
 {
 	/* Get the last line in the first page */
 	const char *end = page->data + page->size - 1;
@@ -146,8 +218,8 @@ static void copy_last_line(struct page_content *page, char *last_line)
 	/* search previous newline */
 	while (pos[-1] != '\n')
 		pos--;
-	strncpy(last_line, pos, end - pos);
-	last_line[end - pos] = '\0';
+
+	copy_line(pos, end, last_line, line_size);
 }
 
 /* Read the last line of the first page and the first line of the second page */
@@ -158,8 +230,8 @@ static bool read_boundary_lines(FIXTURE_DATA(proc_maps_race) *self,
 	if (!read_two_pages(self))
 		return false;
 
-	copy_last_line(&self->page1, last_line->text);
-	copy_first_line(&self->page2, first_line->text);
+	copy_last_line(&self->page1, last_line->text, LINE_MAX_SIZE);
+	copy_first_line(&self->page2, first_line->text, LINE_MAX_SIZE);
 
 	return sscanf(last_line->text, "%lx-%lx", &last_line->start_addr,
 		      &last_line->end_addr) == 2 &&
@@ -418,6 +490,8 @@ FIXTURE_SETUP(proc_maps_race)
 	struct vma_modifier_info *mod_info;
 	pthread_mutexattr_t mutex_attr;
 	pthread_condattr_t cond_attr;
+	unsigned long first_map_addr;
+	unsigned long last_map_addr;
 	unsigned long duration_sec;
 	char fname[32];
 
@@ -502,6 +576,13 @@ FIXTURE_SETUP(proc_maps_race)
 	self->page2.data = malloc(self->page_size);
 	ASSERT_NE(self->page2.data, NULL);
 
+	first_map_addr = (unsigned long)mod_info->child_mapped_addr[0];
+	last_map_addr = (unsigned long)mod_info->child_mapped_addr[mod_info->vma_count - 1];
+
+	self->skip_pages = locate_containing_page(self,
+					min(first_map_addr, last_map_addr),
+					self->page_size * 3);
+	ASSERT_NE(self->skip_pages, -1);
 	ASSERT_TRUE(read_boundary_lines(self, &self->last_line, &self->first_line));
 
 	/*
-- 
2.54.0.545.g6539524ca2-goog

