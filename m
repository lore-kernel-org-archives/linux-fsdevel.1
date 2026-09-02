Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F44647605F;
	Wed,  2 Sep 2026 18:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788372076; cv=none; b=HajgkRdVKR3COmQ+scdjcAqzZ4pr0dtgCE5DqSjp/UhhBiaWYxQGas8NN+Auh7xOraQxgAOgqvWxnsuF37Fy/xcJo1rUsVQc3kJ7k1MX45ZcejyI5R5gDQNTJdVvCtDdkP82ed0ujJ/gyU9TYPgpMHz8ALmU2rhhh1mg8Pe20Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788372076; c=relaxed/simple;
	bh=6y4SgQpQz3RLpexZGYRim0KFzXiNKV69KBfjEhHHVH0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rxfRu20I+rJ+oIHJgPM5yvqe/e6EaEDQG7NekddmwtQ2USNwqa2ojyhiC9Cdbe1mtF7qQucdeWRlfNKV+74HHyHe7q5UV6vSf04uBKbpAGEygFQyClnmBZvRophOZNhuVAmPLLEZzjxeVWIexC57z/6qJbTwOhz1tkW4cG1HB4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d1FKV9YY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d1FKV9YY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A4C1F000E9;
	Wed,  2 Sep 2026 18:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788372074;
	bh=gKMN/4ga+akQkR+gCUDsGByPhFMGOkvrwnVsmryglD8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=d1FKV9YYgYwhR45HYlw7ao5vs9Wvz7PH7HdW6abQ3+PLbGWWvZo+3YkL2712FNcj3
	 eFB3FqAWjSUj+yOdKG8HVSn91Hj33qCCBkTf4fY5KlCUwk8LWC/p+mBfsSR5DnKUiv
	 zhJY6+WmVzQqCI3nQq9Be6MCrPz/Eynxla55ntnaJM6OZU/sEqproc8yvTFMEcQWrQ
	 eG87GbKzRQfMfugp1SyOaQoerezIFaaZibVV2aRufhYlYB6wVAJNTzBiQo8Z/9TAeJ
	 6/I5figxrew5gszJrQH9r3n1eOfh3ulOJKEDhuPwsCKtrOg0tOiipteEvSpi0Rzec2
	 kmSKNsyOBD/9Q==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Wed, 02 Sep 2026 19:00:23 +0100
Subject: [PATCH 6/6] tools/testing/selftests/mm: add MAP_PRIVATE-/dev/zero
 merge tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-map-private-dev-zero-v1-6-a578c730cec7@kernel.org>
References: <20260902-map-private-dev-zero-v1-0-a578c730cec7@kernel.org>
In-Reply-To: <20260902-map-private-dev-zero-v1-0-a578c730cec7@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
 David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4280; i=ljs@kernel.org;
 h=from:subject:message-id; bh=6y4SgQpQz3RLpexZGYRim0KFzXiNKV69KBfjEhHHVH0=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLJmpHjNspi7c//R9qnWvN3MzKq2h9cVHb91el5GlePJx
 AUbDF6/6ShlYRDjYpAVU2R5/kV8f5BI2LzOC/5uMHNYmUCGMHBxCsBEWhMZGa6e/NO3dpKZDHd8
 SbPov0Khpf26ryc8Xx3y77RUo+xE11UMf6XV3rybEF3BPn1ybYZMjtSSYidPjSe/6r7wZV45bLb
 gGxcA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

Assert that MAP_PRIVATE-mapped /dev/zero mappings behave like they are
anonymous.

We test both unfaulted and faulted/unfaulted merges - each with the regions
having page offset of 0, which would not merge if the mappings were treated
as if they were file-backed.

With the recent change that makes them behave as pure anonymous mappings,
the merges should succeed as their page offsets are equal to their
anonymous page offsets.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 tools/testing/selftests/mm/merge.c | 104 +++++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/tools/testing/selftests/mm/merge.c b/tools/testing/selftests/mm/merge.c
index 52b8727b6628..7c528d470404 100644
--- a/tools/testing/selftests/mm/merge.c
+++ b/tools/testing/selftests/mm/merge.c
@@ -1362,6 +1362,110 @@ TEST_F(merge, anon_and_page_offset_mismatch_memfd)
 	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr + 5 * page_size);
 }
 
+TEST_F(merge, merge_map_private_dev_zero_unfaulted)
+{
+	struct procmap_fd *procmap = &self->procmap;
+	unsigned int page_size = self->page_size;
+	char *carveout = self->carveout;
+	char *ptr, *ptr2;
+	int fd_zero;
+
+	if (access("/dev/zero", F_OK))
+		SKIP(return, "No /dev/zero.");
+	fd_zero = open("/dev/zero", O_RDWR);
+	ASSERT_NE(fd_zero, -1);
+
+	/*
+	 * Map two MAP_PRIVATE-/dev/zero VMAs next to one another with offset 0
+	 * each.
+	 *
+	 * With these being made truly anonymous upon mapping, they will
+	 * merge. If they were file-backed VMAs the page offsets would prevent
+	 * merge:
+	 *
+	 * |-----||------|    |-------------|
+	 * | ptr || ptr2 | -> |     ptr     |
+	 * |-----||------|    |-------------|
+	 */
+	ptr = mmap(carveout, 5 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_FIXED | MAP_PRIVATE, fd_zero, 0);
+	if (ptr == MAP_FAILED) {
+		close(fd_zero);
+		ASSERT_TRUE(false);
+	}
+	ptr2 = mmap(&carveout[5 * page_size], 5 * page_size,
+		   PROT_READ | PROT_WRITE, MAP_FIXED | MAP_PRIVATE, fd_zero, 0);
+	if (ptr2 == MAP_FAILED) {
+		close(fd_zero);
+		ASSERT_TRUE(false);
+	}
+	close(fd_zero);
+
+	/* Assert that they merged. */
+	ASSERT_TRUE(find_vma_procmap(procmap, ptr));
+	ASSERT_EQ(procmap->query.vma_start, (unsigned long)ptr);
+	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr + 10 * page_size);
+}
+
+TEST_F(merge, merge_map_private_dev_zero_faulted_unfaulted)
+{
+	struct procmap_fd *procmap = &self->procmap;
+	unsigned int page_size = self->page_size;
+	char *carveout = self->carveout;
+	char *ptr, *ptr2;
+	int fd_zero;
+
+	if (access("/dev/zero", F_OK))
+		SKIP(return, "No /dev/zero.");
+	fd_zero = open("/dev/zero", O_RDWR);
+	ASSERT_NE(fd_zero, -1);
+
+	/*
+	 * Map a MAP_PRIVATE mapping of /dev/zero with page offset 0, then fault
+	 * it in:
+	 *
+	 * |-------------------------------|
+	 * |           faulted             |
+	 * |-------------------------------|
+	 */
+	ptr = mmap(carveout, 15 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_FIXED | MAP_PRIVATE, fd_zero, 0);
+	if (ptr == MAP_FAILED) {
+		close(fd_zero);
+		ASSERT_TRUE(false);
+	}
+	memset(ptr, 'x', 15 * page_size);
+
+	/*
+	 * Unmap the middle:
+	 *
+	 * |---------|           |---------|
+	 * | faulted |           | faulted |
+	 * |---------|           |---------|
+	 */
+	ASSERT_EQ(munmap(&ptr[5 * page_size], 5 * page_size), 0);
+
+	/*
+	 * Map in a new unfaulted mapping in the middle with page offset 0 -
+	 * this should merge and would not if it were treated as a file rather
+	 * than pure anon:
+	 *
+	 * |---------|-----------|---------|
+	 * | faulted | unfaulted | faulted |
+	 * |---------|-----------|---------|
+	 */
+	ptr2 = mmap(&carveout[5 * page_size], 5 * page_size,
+		    PROT_READ | PROT_WRITE, MAP_FIXED | MAP_PRIVATE,
+		    fd_zero, 0);
+	close(fd_zero);
+	ASSERT_NE(ptr2, MAP_FAILED);
+
+	/* Assert that they merged. */
+	ASSERT_TRUE(find_vma_procmap(procmap, ptr));
+	ASSERT_EQ(procmap->query.vma_start, (unsigned long)ptr);
+	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr + 15 * page_size);
+}
+
 TEST_F(merge_with_fork, mremap_faulted_to_unfaulted_prev)
 {
 	struct procmap_fd *procmap = &self->procmap;

-- 
2.55.0

