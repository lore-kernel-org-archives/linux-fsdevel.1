Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDF6347DD;
	Mon, 23 Mar 2026 12:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774270098; cv=none; b=YeWOYQQPC4EyF5FIV1W+p8Q0pHUxg1d5XLgHmUWuJk2rumVLnzOa2ZDWy9KXP5Tlumd2DlG92RvOPk/wT8BVmolB1aziPdiADODeYbHtQP3xIV6CN3bqfOvSRZH+aMgIlDaa8dfwGca5h3RFb0T+9VphbDbSGWZ5IUk3/ThbyY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774270098; c=relaxed/simple;
	bh=cS3/NknCLhK8WaSljXNkknygeOm2tTxLjOQjsgzkLNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jujjXucbGT3ZmRzOicETvrhtCfVVaGLx1DtDAwxINWPHb+T9F52hOtrL6O1OLIa4QdNV8R8H5WoIOvxdEHkgWODc9CytmiSMpJtiOPHecABlmq0ldoQevmGeL6MG3l6wmOrt355bCcAPMGu6T1XEpCA7bN16pdptCW/AU6xzDrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PaQystNC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PaQystNC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D6E6C2BCB7;
	Mon, 23 Mar 2026 12:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774270097;
	bh=cS3/NknCLhK8WaSljXNkknygeOm2tTxLjOQjsgzkLNk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PaQystNCi3tC9eeQ55SD2194neCmAcWHrQNqYEeBHGqp2HRInR1FE3LQKoMFqPD8n
	 vH4CIQVeprMEHI/h7fN5jqkDBg2cizwnJ2XIVXLCBuNkNnBvdYhv03yyqEivYuJVd/
	 Oq/GoixmUMDYEY7TMREqB248SN/ZQFsKBlqYN8dw/elHJwAld3lbbpRNarcFWFMenf
	 o/tvdpCvX6Hx/Plud55Ly1kAceg3Iq1xCTl+GcYC+2EwZWbbNYRHQvnJrfF809QOXg
	 qC3pgOIldXNir+lrzdulBx8c9NWv2lUsO2B4k5nqie2at4LV0BuaED9mFQXl01QShb
	 y9hlNoFqeaHQQ==
Message-ID: <d509c511-6ec6-4eda-9803-bc74c193a0c7@kernel.org>
Date: Mon, 23 Mar 2026 13:48:12 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] selftests/mm: add folio_split() and
 filemap_get_entry() race test
To: Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Hugh Dickins <hughd@google.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Matthew Wilcox <willy@infradead.org>, Bas van Dijk <bas@dfinity.org>,
 Eero Kelly <eero.kelly@dfinity.org>,
 Andrew Battat <andrew.battat@dfinity.org>,
 Adam Bratschi-Kaye <adam.bratschikaye@dfinity.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20260320142219.375118-1-ziy@nvidia.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260320142219.375118-1-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/20/26 15:22, Zi Yan wrote:
> The added folio_split_race_test is a modified C port of the race condition
> test from [1]. The test creates shmem huge pages, where the main thread
> punches holes in the shmem to cause folio_split() in the kernel and
> a set of 16 threads reads the shmem to cause filemap_get_entry() in the
> kernel. filemap_get_entry() reads the folio and xarray split by
> folio_split() locklessly. The original test[2] is written in rust and uses
> memfd (shmem backed). This C port uses shmem directly and use a single
> process.
> 
> Note: the initial rust to C conversion is done by Cursor.
> 
> Link: https://lore.kernel.org/all/CAKNNEtw5_kZomhkugedKMPOG-sxs5Q5OLumWJdiWXv+C9Yct0w@mail.gmail.com/ [1]
> Link: https://github.com/dfinity/thp-madv-remove-test [2]
> Signed-off-by: Bas van Dijk <bas@dfinity.org>
> Signed-off-by: Adam Bratschi-Kaye <adam.bratschikaye@dfinity.org>

You are likely missing two Co-developed-by.

See Documentation/process/submitting-patches.rst on how to handle such
SOBs.

> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
> From V3:
> 1. fixed for loop stepping issue
> 2. used PRIu64 instead of %zu for uint64_t.
> 
> From V2:
> 1. simplied the program by removing fork.
> 
> From V1:
> 1. added prctl(PR_SET_PDEATHSIG, SIGTERM) to avoid child looping
>    forever.
> 2. removed page_idx % PUNCH_INTERVAL >= 0, since it is a nop. Added a
>    comment.
> 3. added a child process status check to prevent parent looping forever
>    and record that as a failure.
> 4. used ksft_exit_skip() instead of ksft_finished() when the program is
>    not running as root.
> 5. restored THP settings properly when the program exits abnormally.
>  tools/testing/selftests/mm/Makefile           |   1 +
>  .../selftests/mm/folio_split_race_test.c      | 293 ++++++++++++++++++
>  tools/testing/selftests/mm/run_vmtests.sh     |   2 +
>  3 files changed, 296 insertions(+)
>  create mode 100644 tools/testing/selftests/mm/folio_split_race_test.c
> 
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> index 7a5de4e9bf520..cd24596cdd27e 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -105,6 +105,7 @@ TEST_GEN_FILES += droppable
>  TEST_GEN_FILES += guard-regions
>  TEST_GEN_FILES += merge
>  TEST_GEN_FILES += rmap
> +TEST_GEN_FILES += folio_split_race_test
>  
>  ifneq ($(ARCH),arm64)
>  TEST_GEN_FILES += soft-dirty
> diff --git a/tools/testing/selftests/mm/folio_split_race_test.c b/tools/testing/selftests/mm/folio_split_race_test.c
> new file mode 100644
> index 0000000000000..c264cc625a7cb
> --- /dev/null
> +++ b/tools/testing/selftests/mm/folio_split_race_test.c
> @@ -0,0 +1,293 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * The test creates shmem PMD huge pages, fills all pages with known patterns,
> + * then continuously verifies non-punched pages with 16 threads. Meanwhile, the
> + * main thread punches holes via MADV_REMOVE on the shmem.
> + *
> + * It tests the race condition between folio_split() and filemap_get_entry(),
> + * where the hole punches on shmem lead to folio_split() and reading the shmem
> + * lead to filemap_get_entry().
> + */
> +
> +#define _GNU_SOURCE
> +#include <errno.h>
> +#include <inttypes.h>
> +#include <linux/mman.h>
> +#include <pthread.h>
> +#include <stdatomic.h>
> +#include <stdbool.h>
> +#include <stdint.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/mman.h>
> +#include <signal.h>
> +#include <unistd.h>
> +#include "vm_util.h"
> +#include "kselftest.h"
> +#include "thp_settings.h"


[...] some comment son the main() part :)

> +int main(void)
> +{
> +	struct thp_settings current_settings;
> +	bool failed = false;
> +	size_t failures;
> +	size_t iter;

Why are iterations a "size_t" ? Similarly for "failures". Just use int / unsigned long?

> +
> +	ksft_print_header();
> +
> +	if (!thp_is_enabled())
> +		ksft_exit_skip("Transparent Hugepages not available\n");

Is checking thp_is_enabled() the right thing to do when you perform your own setup below either way?

I think you should just use thp_available(). Then, configure THP accordingly below?

> +
> +	if (geteuid() != 0)
> +		ksft_exit_skip("Please run the test as root\n");
> +
> +	thp_save_settings();
> +	/* make sure thp settings are restored */
> +	if (atexit(thp_settings_cleanup) != 0)
> +		ksft_exit_fail_msg("atexit failed\n");
> +
> +	signal(SIGINT, thp_cleanup_handler);
> +	signal(SIGTERM, thp_cleanup_handler);
> +
> +	thp_read_settings(&current_settings);
> +	current_settings.shmem_enabled = SHMEM_ADVISE;
> +	thp_write_settings(&current_settings);
> +
> +	ksft_set_plan(1);
> +
> +	page_size = getpagesize();
> +	pmd_pagesize = read_pmd_pagesize();

I wonder whether we should check for 0 here and skip the test (older kernels?).

> +
> +	ksft_print_msg("folio split race test\n");
> +	ksft_print_msg("===================================================\n");
> +	ksft_print_msg("Shmem size:       %" PRIu64 " MiB\n", FILE_SIZE / 1024 / 1024);
> +	ksft_print_msg("Total pages:     %" PRIu64 "\n", TOTAL_PAGES);
> +	ksft_print_msg("Child readers:   %d\n", NUM_READER_THREADS);
> +	ksft_print_msg("Punching every %dth to %dth page\n", PUNCH_INTERVAL,
> +		       PUNCH_INTERVAL + PUNCH_SIZE_FACTOR);
> +	ksft_print_msg("Iterations:      %d\n", NUM_ITERATIONS);


I don't think printing static test information is that helpful.
Do we need all that at all?


> +
> +	for (iter = 1; iter <= NUM_ITERATIONS; iter++) {

Why not start at 0? You know, to confuse less people :)

	for (iter = 0; iter < NUM_ITERATIONS; iter++) {

> +		failures = run_iteration();

"corrupted_pages" ?

> +		if (failures > 0) {
> +			failed = true;

Do you really need that variable?

> +			ksft_print_msg(
> +				"FAILED on iteration %zu: %zu pages corrupted by MADV_REMOVE!\n",
> +				iter, failures);

Can that simply be printed below?

Like

if (iter < NUM_ITERATIONS) {
	ksft_test_result_fail("Test failed on iterations %zu: %zu pages ...\n",
			      iter + 1, corrupted_pages);
} else {
	ksft_test_result_pass ...
}

> +			break;
> +		}
> +	}
> +
> +	if (failed) {
> +		ksft_test_result_fail("Test failed\n");
> +		ksft_exit_fail();
> +	} else {
> +		ksft_test_result_pass("All %d iterations passed\n",
> +				      NUM_ITERATIONS);
> +		ksft_exit_pass();
> +	}
> +
> +	return 0;
-- 
Cheers,

David
