Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC54C41D11A;
	Sat, 26 Sep 2026 10:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790419313; cv=none; b=FqkCPaa0iOydX7op7RALVqmAT1MqlIqEErp/JqgKIeT9aYYdCA2WzaT25+Cw+TcLFq2brK8riOoX6XWqHXYL/oDXVoZBZqtyiuFL/1T4ag/IdUe3tzbcATgTi3E8lzUcCKlRRvxIjszPUo2iezXNAj2qorRm2IlLJ45cNsAaKpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790419313; c=relaxed/simple;
	bh=MuW0MgECKFqsgKYanDvHZ2zzAEiQ7iCtWQ9chN/jOZY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A2JTrAliXEQtovD4lkVBLXhjyIFYZNK0Ji/XoFvw7TtXOm7MJWKdOZd1zCXUkf3MTTXDOp7FuFTvwJpkdqnRAoDmUVEcV5r9RJjku+tKdpSI7h25OiTjwJWVozR67kg7XJWwPdefPXhYaq6jHjg3zGmbe92i/gwHIbHhUGjGEyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FOsVDr1l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FOsVDr1l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABFB01F000FF;
	Sat, 26 Sep 2026 10:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790419306;
	bh=7INaOtP/gm2Q0CwFqGyhMMm+FXe4/enBYyOAMoEMKqg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=FOsVDr1lPbdLbth/FdBj5KzXf0oIdA6hCu9mLssK1wFzaBK7SOzL2rFrbZQ8bHdFb
	 +NRHHqxQudc2nRYJ1z6B2okgHcmH3Qa8RHn2nNuv+gzZORsamL5057k+nLTZvMks2H
	 CQvk+OGjt0XOPqUwSaY/SaIaxC2RNRJyuugqLkgdUKOT1BZgeVZNC79AGrl60NU85U
	 xozIGYhzxWRg56hAQEfbIaBWA8PZWVor0VpmS3L4B8+Dgbs2ThIn5DOPdbqsDUpJjy
	 zWbmPHl6dHArcrZuIrxNf4gxZ1w0140QygSC+R/wcRCO2cVNCT7sZ/FMNZYhQh2lCs
	 5YMpWKbsnVYSQ==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Sat, 26 Sep 2026 11:41:10 +0100
Subject: [PATCH v3 5/6] tools/testing/vma: add test to assert
 MAP_PRIVATE-/dev/zero is anon
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260926-map-private-dev-zero-v3-5-d4781e84ccfc@kernel.org>
References: <20260926-map-private-dev-zero-v3-0-d4781e84ccfc@kernel.org>
In-Reply-To: <20260926-map-private-dev-zero-v3-0-d4781e84ccfc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1881; i=ljs@kernel.org;
 h=from:subject:message-id; bh=MuW0MgECKFqsgKYanDvHZ2zzAEiQ7iCtWQ9chN/jOZY=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLK2L/ThnMwp/NdRf3l60KLN0u0+J8QnJbIkff2y9ehr/
 qNu7dLdHaUsDGJcDLJiiizPv4jvDxIJm9d5wd8NZg4rE8gQBi5OAZjIzXiG/9nudyI6qi5MLnc9
 UZecrdL263/01u7jldNfqDkUzHU8uIWR4WzMwkTmt7nexn/yZ6asiFzVbydhudHvRFBUX8SlTav
 FOQE=
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

Now we've made MAP_PRIVATE-mapped /dev/zero mappings truly anonymous, add a
VMA userland test to assert that this is the case and everything is as we
would expect for an anonymous mapping.

Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 tools/testing/vma/tests/mmap.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/testing/vma/tests/mmap.c b/tools/testing/vma/tests/mmap.c
index c85bc000d1cb..fa73faff2262 100644
--- a/tools/testing/vma/tests/mmap.c
+++ b/tools/testing/vma/tests/mmap.c
@@ -45,7 +45,44 @@ static bool test_mmap_region_basic(void)
 	return true;
 }
 
+static bool test_pure_anon_dev_zero(void)
+{
+	const vma_flags_t vma_flags = mk_vma_flags(VMA_READ_BIT, VMA_WRITE_BIT,
+			VMA_MAYREAD_BIT, VMA_MAYWRITE_BIT);
+	struct file file = {
+		.f_op = &zero_fops,
+	};
+	struct mm_struct mm = {};
+	struct vm_area_struct *vma;
+	unsigned long addr;
+	VMA_ITERATOR(vmi, &mm, 0);
+
+	current->mm = &mm;
+
+	/*
+	 * Map a MAP_PRIVATE-/dev/zero mapping at address 0x300000 with a page
+	 * offset of 0x10, which we expect to be reset to the anonymous page
+	 * offset.
+	 */
+	addr = __mmap_region(&file, 0x300000, 0x3000, vma_flags, 0x10, NULL);
+	ASSERT_EQ(addr, 0x300000);
+
+	/* Assert that it truly is an anonymous mapping. */
+	vma = vma_lookup(&mm, addr);
+	ASSERT_NE(vma, NULL);
+	ASSERT_TRUE(vma_is_anonymous(vma));
+	ASSERT_EQ(vma->vm_file, NULL);
+	ASSERT_EQ(vma->vm_private_data, NULL);
+	/* Expect anonymous page offsets. */
+	ASSERT_EQ(vma->vm_pgoff, 0x300);
+	ASSERT_EQ(vma_start_anon_pgoff(vma), 0x300);
+
+	cleanup_mm(&mm, &vmi);
+	return true;
+}
+
 static void run_mmap_tests(int *num_tests, int *num_fail)
 {
 	TEST(mmap_region_basic);
+	TEST(pure_anon_dev_zero);
 }

-- 
2.55.0

