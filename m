Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794531931;
	b=ynxst1qViNXfVloIfHhFqZnNd5uYBwe9UDWnpQ7SDHJEUeLStfL/B8SgrziLMSDVfYu3
	 omNcpS0KZ/ZJU/jl0bAJdD3kUWBoylc0x8oYvjJMv1Qu9r5sN+yRIyAoAOiTCL6a4IBuJ
	 i6LjQKyIxuA8MPSlfp1kWBTn4qGBVnOTLKfvXmUd7SZm6X1zszHUcBsE8DRAv4DC8QxU3
	 3m9vHXPmER0iw0S+MnI/AyEos39s99lmNnbi6o1uJgJq9S7wS1XoeQRbzofeWCKwogD5b
	 K1ILcTzMZZo4nnsldJLN/GGu8rF57NCdaKrQtCHBIfWr8qsneBLPHzSgL4zbbaIJcOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794531931;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=vG/ZTN7qCBSDmFaKjVjdGqfEtbYGB5lYGnePbBzeUbs=;
	b=RjW14Ug4F7HNZY9IITuMHTIFRYOh8QYzNZF+785yuwroCRydS2EOVoYPeqYJXAMEoJSg
	 vQFVw3LzFfgN0Uqq2NlC1DYbp56k3YHDoYoecgAVpaoT9FtzbhTddkTYt7sAN9bJmgFrL
	 um+GCbnW/8/dHMXa1CM1akea4/g+SPbGxONkOQA13WmavfXn6gpa1G6TS7dLO6VdqGpqi
	 mh2oBjC3Vi6QbkuA/69mP55GuwdANSSCwzZWKYeFMLJrdvMexOdKIXyDDGgOSVB6c+cXr
	 qkp7SOLm3Ma+EUUvF1EFKjWB99HOF7pmyHv2srGIRCayV9jRw0x5y678W+WFEiq8Zfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=WhUZApyL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8892F606A323;
	Fri, 13 Nov 2026 01:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=WhUZApyL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BA231F000C4;
	Fri, 13 Nov 2026 01:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1794531931;
	bh=vG/ZTN7qCBSDmFaKjVjdGqfEtbYGB5lYGnePbBzeUbs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WhUZApyLsoF66Xt6K2wtFt7kBRT23e1EZ+HI4j1DZGv3z9ixaHOgEAuOm0nBEJtug
	 dseykBs9T8h3tSk4svyzZ29TNaJtdybxtKIfWc3gmWNHVd2geyRukF8kgGjmXAdR0D
	 ApPXm0rXBIXRoMI+y9144IU/E8XnifHObGlpdGR8=
Date: Thu, 12 Nov 2026 17:05:30 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Matt Salsamendi <matthewsalsamendi@gmail.com>
Cc: "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes
 <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Jann Horn
 <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, Muhammad Usama Anjum
 <usama.anjum@arm.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/proc/task_mmu: fix stale walk_end after a completed
 scan
Message-Id: <20261112170530.ccddc60994db414a3177a066@linux-foundation.org>
In-Reply-To: <CAMPWk9NE_epOdOCbs1PGh8OQP4wjTObvjU-1Wopmu7SSNAMXhw@mail.gmail.com>
References: <CAMPWk9NE_epOdOCbs1PGh8OQP4wjTObvjU-1Wopmu7SSNAMXhw@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Nov 2026 12:41:02 -0500 Matt Salsamendi <matthewsalsamendi@gmail.com> wrote:

> From: Matthew Salsamendi <matthewsalsamendi@gmail.com>
> 
> After PAGEMAP_SCAN fills its internal buffer, a successful final walk can
> leave walk_end at the earlier stopping point. On x86-64, 513 disjoint
> written pages return 513 ranges with the last range beyond walk_end.
> This trips a bounds assertion in a userspace dirty-page tracker.
> 
> Update walk_end on successful completion before replacing ret with the
> range count. Preserve the stopping address for partial scans.

Bug seems real, thanks.

> Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and
> optionally clear info about PTEs")
> Cc: stable@vger.kernel.org

This should be justified, please.  Hopefully full and clear
justification for backports will soon be required.

https://lore.kernel.org/20261111171055.527b4bf3da705367bc78a64c@linux-foundation.org

and followups explain this.

> Validated on x86-64 v7.4-rc2 in KVM: all 12 scan cases and all 119
> pagemap_ioctl selftests pass. The unpatched kernel reproduces the bug.

Thing is, those 119 test already pass.  And the mysterious 12 scan
cases are undisclosed.

So.

Please prepare a selftests patch to catch this bug [1] then confirm
that the altered selftests fail before the proposed patch and pass after
it.  Then present both as a two-patch series.

Thanks.


[1] my thing suggested the below.  I haven't run it.


--- a/tools/testing/selftests/mm/pagemap_ioctl.c~selftests-mm-pagemap_ioctl-check-walk_end-after-buffer-refill
+++ a/tools/testing/selftests/mm/pagemap_ioctl.c
@@ -1476,6 +1476,51 @@ static void *thread_proc(void *mem)
 		if (getrusage(RUSAGE_THREAD, &r))
 			ksft_exit_fail_msg("getrusage\n");
 
+static void test_walk_end_after_refill(void)
+{
+	const int nr_ranges = 513;
+	const int nr_pages = nr_ranges * 2;
+	const int len = nr_pages * page_size;
+	struct page_region *vec;
+	char *mem;
+	long walk_end = 0;
+	long ret;
+	int i;
+	bool ok;
+
+	mem = mmap(NULL, len, PROT_READ | PROT_WRITE,
+		   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (mem == MAP_FAILED)
+		ksft_exit_fail_msg("mmap failed: %s\n", strerror(errno));
+	if (madvise(mem, len, MADV_NOHUGEPAGE))
+		ksft_exit_fail_msg("MADV_NOHUGEPAGE failed: %s\n", strerror(errno));
+	vec = calloc(nr_ranges, sizeof(*vec));
+	if (!vec)
+		ksft_exit_fail_msg("calloc failed\n");
+
+	wp_init(mem, len);
+	wp_addr_range(mem, len);
+	for (i = 0; i < nr_ranges; i++)
+		mem[2 * i * page_size] = 1;
+
+	ret = pagemap_ioc(mem, len, vec, nr_ranges, 0, 0,
+			  PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN, &walk_end);
+	ok = ret == nr_ranges && walk_end == (long)(mem + len);
+	if (ret == nr_ranges) {
+		for (i = 0; i < nr_ranges; i++) {
+			if (vec[i].start != (uintptr_t)(mem + 2 * i * page_size) ||
+			    vec[i].end != (uintptr_t)(mem + (2 * i + 1) * page_size)) {
+				ok = false;
+				break;
+			}
+		}
+	}
+	ksft_test_result(ok, "PAGEMAP_SCAN walk_end after bounce buffer refill\n");
+	wp_free(mem, len);
+	munmap(mem, len);
+	free(vec);
+}
+
 		faults = r.ru_minflt - curr_faults;
 		if (faults < access_per_thread)
 			ksft_exit_fail_msg("faults < access_per_thread");
@@ -1661,12 +1706,14 @@ int main(int __attribute__((unused)) arg
 	if (!hugetlb_setup_default(4))
 		ksft_print_msg("HugeTLB test will be skipped\n");
 
-	ksft_set_plan(119);
+	ksft_set_plan(120);
 
 	pagemap_fd = open(PAGEMAP, O_RDONLY);
 	if (pagemap_fd < 0)
 		ksft_exit_fail_msg("Failed to open " PAGEMAP "\n");
 
+	test_walk_end_after_refill();
+
 	/* 1. Sanity testing */
 	sanity_tests_sd();
 
_

