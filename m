Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3945159C967;
	Tue,  8 Sep 2026 18:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788891540; cv=none; b=WeBzlqXGB8EBWKJcHMFNvxNhSnnhMdm+aiY09SsMbfUQonAiKoLho5IVWxGkbGB4qDnKgEJeojulbWYazoN/GDJRq5RTyGJdL9q+SchbGibBVHBY8maqW4+trVji78YKB9T+2kNh6PxZyPeHiu7WU0Pf2OA3ErdBMdeINvoh/sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788891540; c=relaxed/simple;
	bh=wCuMIk7/Ii9ESltb3bVTeEtiSvYe4RJc4F4Uz/QEaCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UV88hVSgFj5xG5HQMgXnsS10+ZBxuzciI6rHih7lyzFRvtHH821HCZXUZcON/LIs4aom1gWC8cy48McH8V38GSJvALI9w9sWlGpkuEDTBdADyp44ZnTdwy2w69NoKw1loikwvyIpl/4qWBAt83L0LSKojqkAZpoUH912vi6mRTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Luj6RHCd; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Luj6RHCd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Li/ybmICa60a36A5BNtThplp6R00X6RYCrxbOUvrWvU=; b=Luj6RHCddO2eLmRGq1mFZIXKPY
	uFHiwRUEke2ZBWZ7XJ42jcIpuOUZ8tYkRkT8ZgUc7Je4qIzqxSs47vni975PywKADIIY6tv3iArhi
	WOAW4XrekF0VnyUSEOxqYzZe6oP1agV/v2opf+TqB/t0Re52dxJ270OKQTcJTVNALiCsnJvKUs7D/
	7g5OUra4oLYtrk14Bl1WPZP4I2EYgby1WE2nr2Ya9ca9Fnp54+/KVwDJagFm3kGBeEtY4f85ZZBoV
	RhPhrGtZBok50Rt8frrCOgWFvlgdE+sscBqOAJMd1HoaU41x8lqyFZ1PavwlQ/M7oUsNoT65qrHr5
	qsv1Dbxg==;
Received: from [38.23.173.23] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x40PF-00000009xMy-3Xbw;
	Tue, 08 Sep 2026 18:18:54 +0000
Date: Tue, 8 Sep 2026 14:18:51 -0400
From: "Liam R. Howlett" <liam@infradead.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, ljs@kernel.org, vbabka@kernel.org, 
	david@redhat.com, willy@infradead.org, jannh@google.com, paulmck@kernel.org, 
	pfalcato@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] selftests/proc: add /proc/pid/smaps_rollup
 tearing tests
Message-ID: <5tivjbxj2nqcgebjxx2lp4lymduaslocdbdibgain6pxtpec5f@dvgvxuod4byt>
References: <20260907063918.3432401-1-surenb@google.com>
 <20260907063918.3432401-6-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907063918.3432401-6-surenb@google.com>

On 26/09/06 11:39PM, Suren Baghdasaryan wrote:
> During tearing tests, smaps_rollup Pss* metrics should stay constant.
> Extend /proc/pid/smaps tearing tests to also check for smaps_rollup
> consistency.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Acked-by: Liam R. Howlett (Oracle) <liam@infradead.org>

> ---
>  tools/testing/selftests/proc/proc-maps-race.c | 187 +++++++++++++++++-
>  1 file changed, 182 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/proc/proc-maps-race.c b/tools/testing/selftests/proc/proc-maps-race.c
> index 415eccb70468..8d00d7db1c65 100644
> --- a/tools/testing/selftests/proc/proc-maps-race.c
> +++ b/tools/testing/selftests/proc/proc-maps-race.c
> @@ -80,6 +80,61 @@ enum maps_file {
>  
>  struct vma_modifier_info;
>  
> +enum smaps_rollup_stat {
> +	Rss,
> +	Pss,
> +	Pss_Dirty,
> +	Pss_Anon,
> +	Pss_File,
> +	Pss_Shmem,
> +	Shared_Clean,
> +	Shared_Dirty,
> +	Private_Clean,
> +	Private_Dirty,
> +	Referenced,
> +	Anonymous,
> +	KSM,
> +	LazyFree,
> +	AnonHugePages,
> +	ShmemPmdMapped,
> +	FilePmdMapped,
> +	Shared_Hugetlb,
> +	Private_Hugetlb,
> +	Swap,
> +	SwapPss,
> +	Locked,
> +	RollupFieldCount
> +};
> +
> +static const char *smaps_rollup_stat_names[RollupFieldCount] = {
> +	"Rss",
> +	"Pss",
> +	"Pss_Dirty",
> +	"Pss_Anon",
> +	"Pss_File",
> +	"Pss_Shmem",
> +	"Shared_Clean",
> +	"Shared_Dirty",
> +	"Private_Clean",
> +	"Private_Dirty",
> +	"Referenced",
> +	"Anonymous",
> +	"KSM",
> +	"LazyFree",
> +	"AnonHugePages",
> +	"ShmemPmdMapped",
> +	"FilePmdMapped",
> +	"Shared_Hugetlb",
> +	"Private_Hugetlb",
> +	"Swap",
> +	"SwapPss",
> +	"Locked",
> +};
> +
> +struct smaps_rollup_stats {
> +	unsigned long values[RollupFieldCount];
> +};
> +
>  FIXTURE(proc_maps_race)
>  {
>  	struct vma_modifier_info *mod_info;
> @@ -91,6 +146,7 @@ FIXTURE(proc_maps_race)
>  	enum maps_file maps_file;
>  	int shared_mem_size;
>  	int skip_pages;
> +	int rollup_fd;
>  	int page_size;
>  	int vma_count;
>  	bool verbose;
> @@ -132,12 +188,12 @@ struct vma_modifier_info {
>  	void *child_mapped_addr[];
>  };
>  
> -static bool read_page(FIXTURE_DATA(proc_maps_race) *self,
> +static bool read_page(FIXTURE_DATA(proc_maps_race) *self, int fd,
>  		      struct page_content *page)
>  {
>  	ssize_t  bytes_read;
>  
> -	bytes_read = read(self->maps_fd, page->data, self->page_size);
> +	bytes_read = read(fd, page->data, self->page_size);
>  	if (bytes_read <= 0)
>  		return false;
>  
> @@ -175,7 +231,7 @@ static int locate_containing_page(FIXTURE_DATA(proc_maps_race) *self,
>  		char *curr_pos;
>  		char *end_pos;
>  
> -		if (!read_page(self, &self->page1))
> +		if (!read_page(self, self->maps_fd, &self->page1))
>  			return -1;
>  
>  		curr_pos = self->page1.data;
> @@ -205,10 +261,11 @@ static bool read_two_pages(FIXTURE_DATA(proc_maps_race) *self)
>  		return false;
>  
>  	for (int i = 0; i < self->skip_pages; i++)
> -		if (!read_page(self, &self->page1))
> +		if (!read_page(self, self->maps_fd, &self->page1))
>  			return false;
>  
> -	return read_page(self, &self->page1) && read_page(self, &self->page2);
> +	return read_page(self, self->maps_fd, &self->page1) &&
> +	       read_page(self, self->maps_fd, &self->page2);
>  }
>  
>  static void copy_line(const char *line_start, const char *line_end,
> @@ -317,6 +374,61 @@ static bool read_boundary_lines(FIXTURE_DATA(proc_maps_race) *self,
>  		      &first_line->end_addr) == 2;
>  }
>  
> +static bool parse_smaps_rollup(FIXTURE_DATA(proc_maps_race) *self,
> +			       struct smaps_rollup_stats *stats)
> +{
> +	unsigned int dev_maj, dev_min, inode;
> +	unsigned long start, end, offs;
> +	unsigned long value;
> +	char name[32], perm[5];
> +	char *curr_pos;
> +	char *end_pos;
> +	char *line_end;
> +
> +	if (lseek(self->rollup_fd, 0, SEEK_SET) < 0)
> +		return false;
> +
> +	if (!read_page(self, self->rollup_fd, &self->page1))
> +		return false;
> +
> +	curr_pos = self->page1.data;
> +	end_pos = self->page1.data + self->page1.size;
> +
> +	line_end = strchr(curr_pos, '\n');
> +	if (!line_end)
> +		return false;
> +
> +	if (sscanf(curr_pos, "%lx-%lx %4s %lx %u:%u %u %31s",
> +		&start, &end, perm, &offs, &dev_maj, &dev_min, &inode, name) != 8)
> +		return false;
> +
> +	if (strcmp(name, "[rollup]"))
> +		return false;
> +
> +	for (int stat = 0; stat < ARRAY_SIZE(smaps_rollup_stat_names); stat++) {
> +		int len;
> +
> +		curr_pos = line_end + 1;
> +		if (curr_pos >= end_pos)
> +			return false;
> +
> +		line_end = strchr(curr_pos, '\n');
> +		if (!line_end)
> +			return false;
> +
> +		if (sscanf(curr_pos, "%31s %lu kB", name, &value) != 2)
> +			return false;
> +
> +		len = strlen(name);
> +		if (name[len - 1] != ':' || strncmp(name, smaps_rollup_stat_names[stat], len - 1))
> +			return false;
> +
> +		stats->values[stat] = value;
> +	}
> +
> +	return true;
> +}
> +
>  /* Thread synchronization routines */
>  static void wait_for_state(struct vma_modifier_info *mod_info, enum test_state state)
>  {
> @@ -397,6 +509,41 @@ static bool print_boundaries_on(bool condition, const char *title,
>  	return condition;
>  }
>  
> +static void print_smaps_rollup_stats(const char *title, FIXTURE_DATA(proc_maps_race) *self,
> +				     struct smaps_rollup_stats *stats)
> +{
> +	printf("%s", title);
> +	for (int stat = 0; stat < ARRAY_SIZE(smaps_rollup_stat_names); stat++)
> +		printf("%64s %lu kB\n", smaps_rollup_stat_names[stat], stats->values[stat]);
> +}
> +
> +static bool cmp_smaps_rollup_stat(struct smaps_rollup_stats *s1,
> +				  struct smaps_rollup_stats *s2,
> +				  enum smaps_rollup_stat stat)
> +{
> +	return s1->values[stat] == s2->values[stat];
> +}
> +
> +static bool compare_smaps_rollup(FIXTURE_DATA(proc_maps_race) *self,
> +				 struct smaps_rollup_stats *expected,
> +				 struct smaps_rollup_stats *actual)
> +{
> +	/*
> +	 * Clean/dirty metrics might change but Pss-related ones
> +	 * should stay constant.
> +	 */
> +	if (cmp_smaps_rollup_stat(expected, actual, Pss) &&
> +	    cmp_smaps_rollup_stat(expected, actual, Pss_Anon) &&
> +	    cmp_smaps_rollup_stat(expected, actual, Pss_File) &&
> +	    cmp_smaps_rollup_stat(expected, actual, Pss_Shmem))
> +		return true;
> +
> +	print_smaps_rollup_stats("Expected stats:", self, expected);
> +	print_smaps_rollup_stats("Actual stats:", self, actual);
> +
> +	return false;
> +}
> +
>  static void report_test_start(const char *name, bool verbose)
>  {
>  	if (verbose)
> @@ -572,6 +719,7 @@ FIXTURE_SETUP(proc_maps_race)
>  	unsigned long first_map_addr;
>  	unsigned long last_map_addr;
>  	unsigned long duration_sec;
> +	char rollup_fname[32];
>  	char fname[32];
>  
>  	self->page_size = (unsigned long)sysconf(_SC_PAGESIZE);
> @@ -649,6 +797,9 @@ FIXTURE_SETUP(proc_maps_race)
>  		break;
>  	case SMAPS:
>  		sprintf(fname, "/proc/%d/smaps", self->pid);
> +		sprintf(rollup_fname, "/proc/%d/smaps_rollup", self->pid);
> +		self->rollup_fd = open(rollup_fname, O_RDONLY);
> +		ASSERT_NE(self->rollup_fd, -1);
>  		break;
>  	default:
>  		ksft_exit_fail();
> @@ -711,6 +862,8 @@ FIXTURE_TEARDOWN(proc_maps_race)
>  	for (int i = 0; i < self->vma_count; i++)
>  		munmap(self->mod_info->child_mapped_addr[i], self->page_size);
>  	close(self->maps_fd);
> +	if (self->maps_file == SMAPS)
> +		close(self->rollup_fd);
>  	waitpid(self->pid, &status, 0);
>  	munmap(self->mod_info, self->shared_mem_size);
>  }
> @@ -723,6 +876,7 @@ TEST_F(proc_maps_race, test_maps_tearing_from_split)
>  	struct line_content split_first_line;
>  	struct line_content restored_last_line;
>  	struct line_content restored_first_line;
> +	struct smaps_rollup_stats orig_stats;
>  
>  	wait_for_state(mod_info, SETUP_READY);
>  
> @@ -736,6 +890,8 @@ TEST_F(proc_maps_race, test_maps_tearing_from_split)
>  	report_test_start("Tearing from split", self->verbose);
>  	ASSERT_TRUE(capture_mod_pattern(self, &split_last_line, &split_first_line,
>  					&restored_last_line, &restored_first_line));
> +	if (self->maps_file == SMAPS)
> +		ASSERT_TRUE(parse_smaps_rollup(self, &orig_stats));
>  
>  	/* Now start concurrent modifications for self->duration_sec */
>  	signal_state(mod_info, TEST_READY);
> @@ -799,6 +955,11 @@ TEST_F(proc_maps_race, test_maps_tearing_from_split)
>  				     vma_end == self->last_line.end_addr) ||
>  				    (vma_start == split_first_line.start_addr &&
>  				     vma_end == split_first_line.end_addr));
> +		} else {
> +			struct smaps_rollup_stats stats;
> +
> +			ASSERT_TRUE(parse_smaps_rollup(self, &stats));
> +			ASSERT_TRUE(compare_smaps_rollup(self, &orig_stats, &stats));
>  		}
>  		clock_gettime(CLOCK_MONOTONIC_COARSE, &end_ts);
>  		end_test_iteration(&end_ts, self->verbose);
> @@ -817,6 +978,7 @@ TEST_F(proc_maps_race, test_maps_tearing_from_resize)
>  	struct line_content shrunk_first_line;
>  	struct line_content restored_last_line;
>  	struct line_content restored_first_line;
> +	struct smaps_rollup_stats orig_stats;
>  
>  	wait_for_state(mod_info, SETUP_READY);
>  
> @@ -830,6 +992,8 @@ TEST_F(proc_maps_race, test_maps_tearing_from_resize)
>  	report_test_start("Tearing from resize", self->verbose);
>  	ASSERT_TRUE(capture_mod_pattern(self, &shrunk_last_line, &shrunk_first_line,
>  					&restored_last_line, &restored_first_line));
> +	if (self->maps_file == SMAPS)
> +		ASSERT_TRUE(parse_smaps_rollup(self, &orig_stats));
>  
>  	/* Now start concurrent modifications for self->duration_sec */
>  	signal_state(mod_info, TEST_READY);
> @@ -880,6 +1044,11 @@ TEST_F(proc_maps_race, test_maps_tearing_from_resize)
>  			ASSERT_TRUE(vma_start == self->last_line.start_addr &&
>  				    (vma_end - vma_start == self->page_size * 3 ||
>  				     vma_end - vma_start == self->page_size));
> +		} else {
> +			struct smaps_rollup_stats stats;
> +
> +			ASSERT_TRUE(parse_smaps_rollup(self, &stats));
> +			ASSERT_TRUE(compare_smaps_rollup(self, &orig_stats, &stats));
>  		}
>  		clock_gettime(CLOCK_MONOTONIC_COARSE, &end_ts);
>  		end_test_iteration(&end_ts, self->verbose);
> @@ -898,6 +1067,7 @@ TEST_F(proc_maps_race, test_maps_tearing_from_remap)
>  	struct line_content remapped_first_line;
>  	struct line_content restored_last_line;
>  	struct line_content restored_first_line;
> +	struct smaps_rollup_stats orig_stats;
>  
>  	wait_for_state(mod_info, SETUP_READY);
>  
> @@ -911,6 +1081,8 @@ TEST_F(proc_maps_race, test_maps_tearing_from_remap)
>  	report_test_start("Tearing from remap", self->verbose);
>  	ASSERT_TRUE(capture_mod_pattern(self, &remapped_last_line, &remapped_first_line,
>  					&restored_last_line, &restored_first_line));
> +	if (self->maps_file == SMAPS)
> +		ASSERT_TRUE(parse_smaps_rollup(self, &orig_stats));
>  
>  	/* Now start concurrent modifications for self->duration_sec */
>  	signal_state(mod_info, TEST_READY);
> @@ -963,6 +1135,11 @@ TEST_F(proc_maps_race, test_maps_tearing_from_remap)
>  				     vma_end - vma_start == self->page_size * 3) ||
>  				    (vma_start == self->last_line.start_addr + self->page_size &&
>  				     vma_end - vma_start == self->page_size));
> +		} else {
> +			struct smaps_rollup_stats stats;
> +
> +			ASSERT_TRUE(parse_smaps_rollup(self, &stats));
> +			ASSERT_TRUE(compare_smaps_rollup(self, &orig_stats, &stats));
>  		}
>  		clock_gettime(CLOCK_MONOTONIC_COARSE, &end_ts);
>  		end_test_iteration(&end_ts, self->verbose);
> -- 
> 2.55.0.979.g7e5102b832-goog
> 
