Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA03347FCD
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 07:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777014182; cv=none; b=NTJOQE/bEa8d9QnNQ/E3zVZ5h8aIayxUwSztcTLyKBxfjW/fq4vD+LDBjvDkcWyZlUCa5h89yPlRoUEatUjwMYTJql6eZx+Usi0LK61MrANdUpVeyPT/u6Dm+FRHbW519wFFeG3/IvszNveKb8dXvZwhmO+v7kJTJhKlf3ucsYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777014182; c=relaxed/simple;
	bh=WAZtIz9DRaTLMD/Vn5XCDvQ2W8Sy7wUfm/O5/IsoqAQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GfDVO84jRYqKu/9nJzab+QDl3v2y+uAZ9BO8MffqDC8CFnGJOrpOSGfekRrYuUllom9ILpd2PP64KiB7VdzevLq8bBxk08hdSNm2TJHSy4UPU6MhPxs0thjGyVopGGZ/AVzyejSmGu9V9uDBrktycJjtnB8GLUAljrJM2mQhg4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZAoamA3a; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZAoamA3a"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2c0ba59a830so11749886eec.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 00:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777014180; x=1777618980; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QROYaYs151R/blxNlpky7uyYcAQOpuOKLNbRD4r5/hI=;
        b=ZAoamA3a5zm17ZcEaQoT86bE2BZ/pAD1NwnFJJM+vOIItd+644Hatwc1O0x2vv87ZJ
         a9GCDgURVb4bQ3wloUoGgcGM3ZaCm3JLeF9PBAFkbYBaZxqF6MXebF4sV5HQwP7mvY20
         vstqhWEmlLxP7Ct4FI/rPZhLkSOTRomQnyohmCA0s+/oxiKhYFVHSpc3ryGmBdvWiYCl
         +WjgEvnezpWgGFd8vij8gWivdFovvLNDOJHKVxSKDqob6PZXmPbG91G5XU7pwDn5JGLE
         5tTWe1qCpwpvA5RbGYW5zHaNHe8SLAa/+tHZUqFMwS8/IhqsrFFN2a8rnZSQmcpSskm1
         1x2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777014180; x=1777618980;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QROYaYs151R/blxNlpky7uyYcAQOpuOKLNbRD4r5/hI=;
        b=aj0uZ4F6l8UKwdEIfxZbCHcZdwYOd+RYo3CLuPm/kioOOQlVQG38MXvB5xHIck9yWD
         f7RbULZ8wej7l8t5NC/vczfB2s0QBuZy4MsorJUESeVBx+MxC9fkb3LGs/aFHcp2rilv
         Kp+FrY6YQvTK24RMNSndXaQ6u8qRK7/vDyUPTq8EUm87F0Kw5zb3OEkhNHHl3uKZ9QzF
         jdsWFsTcDar+Ci3g5r005iwfMURRqsjc2TbCBtzefLBGPtygVLrkR9cQ9AVvtjz3dCGo
         xWS9Gwt6cfxxHPda1Q/WHWR9Rlj0UZkiNH63jUL4L007GAlrUPXEUUMsfJWJX9nFKrPL
         SLmA==
X-Forwarded-Encrypted: i=1; AFNElJ/nGPwqy6NgD2DfB2/hzo7/xFDutiqlPFuvc0EFeUF1WbMIlGQN62PZytDuoNMZgbrndHRTQCXZynEpH1R/@vger.kernel.org
X-Gm-Message-State: AOJu0YyrdSd88TFjh5h/eJak0W2YUuQJ/La5CiwcT+S0TEEEFICgy6mM
	OK0qa611mCAYY1xIFEx2K0+5QpBWwFlFrC3Fov6SNv3JnfWMNMfLeVsrOHTpeSSY/4Y/jBlJVU3
	iM4NSow==
X-Received: from dybqf21.prod.google.com ([2002:a05:7301:6495:b0:2d8:b1cf:5d12])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:3252:b0:2dd:2ad3:f799
 with SMTP id 5a478bee46e88-2e46ca438admr16552962eec.9.1777014179625; Fri, 24
 Apr 2026 00:02:59 -0700 (PDT)
Date: Fri, 24 Apr 2026 00:02:33 -0700
In-Reply-To: <20260424070234.190145-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260424070234.190145-1-surenb@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260424070234.190145-3-surenb@google.com>
Subject: [PATCH 2/3] selftests/proc: ensure the test is performed at the right
 page boundary
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
---
 tools/testing/selftests/proc/proc-maps-race.c | 78 ++++++++++++++++---
 1 file changed, 68 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/proc/proc-maps-race.c b/tools/testing/selftests/proc/proc-maps-race.c
index a734553718da..c5031b0593b7 100644
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
@@ -105,27 +113,68 @@ struct vma_modifier_info {
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
+			if (sscanf(curr_pos, "%lx-%lx", &start, &end) == 2 &&
+			    start == addr && end == addr + size)
+				return page;
+
+			curr_pos = strchr(curr_pos, '\n');
+			if (!curr_pos)
+				break;
+			curr_pos++;
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
 
 static void copy_first_line(struct page_content *page, char *first_line)
@@ -418,6 +467,8 @@ FIXTURE_SETUP(proc_maps_race)
 	struct vma_modifier_info *mod_info;
 	pthread_mutexattr_t mutex_attr;
 	pthread_condattr_t cond_attr;
+	unsigned long first_map_addr;
+	unsigned long last_map_addr;
 	unsigned long duration_sec;
 	char fname[32];
 
@@ -502,6 +553,13 @@ FIXTURE_SETUP(proc_maps_race)
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

