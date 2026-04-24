Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9846A3EF66C;
	Fri, 24 Apr 2026 18:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777055030; cv=none; b=WUvotOg/7HHPYulzs8rKFNZ0h1g2dtorWZ2lvh/BL93Vx6/PrHn4OIBWWNTC1ftUDlkDE4NcrPuR5BSEFh17luf88w5XcnBjjl+LrQ26ZBlQ+tiOyJi0U8RXsV9IplLt/heWh+RpbRsQO3iGxT5jfar4CxtQkSviTUmQiRtDV+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777055030; c=relaxed/simple;
	bh=eksREuEF1L2R/dEaQ5Om16FakRITjuu2CUNa5MZwSGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=blVglSmyBdUObsUL3N6QIDn6h/EhT0J3b/ejUejsNIH+eWliPju85a4Bq+bVhnScgc7WdCUhoXq9+4aGZOO9z0YVz3HwHfWypxbEpHcFP2i7eDtHQ3oV6WSn6x2KoyOCLojcVl80+6/Q7+XhFitZCHSPPmcMa8jStj4aXDIXYC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dHRi0OcS; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dHRi0OcS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wHmkC1PpzrOj3aa7cR/k5HER8pUMmXZ13ybCvJpbXxY=; b=dHRi0OcS4B46i0eR7NtQPZMguw
	F78uOcGHZcuruDxtl+pDS6qwIvrOirqySnnDqrM5t+7be/EQFHCVJeMumOJn4Bmy1/Unsc871qUpS
	yBNgM1Hri0HxWY8nPIqia0IxU5YuIasZbaFti4R7h+T/SGjkGOtDinjzTtmYUUKOZb/vYOv2c0p05
	S2YyF6M6GuljMjvXImLTc249o8bVObxvZ+i4CV+5UHBgC6VmL0w0NYtAAchhHEG0DmerIZtKtmwWS
	Gpi1x9r0x80GWbElko6JZrsVyv+HutB79JrfoxVZbosGa2AUzNa2UCISnDC1y7NDKXFFvLMHD4qge
	g0yHWDWw==;
Received: from [38.23.173.23] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGLBo-0000000DdxS-2GcF;
	Fri, 24 Apr 2026 18:23:44 +0000
Date: Fri, 24 Apr 2026 14:23:42 -0400
From: "Liam R. Howlett" <liam@infradead.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, ljs@kernel.org, vbabka@kernel.org, 
	david@redhat.com, willy@infradead.org, jannh@google.com, paulmck@kernel.org, 
	pfalcato@suse.de, shuah@kernel.org, hsukrut3@gmail.com, richard.weiyang@gmail.com, 
	reddybalavignesh9979@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 3/3] selftests/proc: add /proc/pid/smaps tearing tests
Message-ID: <qxxhshfoe5tph4z324fzl74r532bxdrdvll2xvhaeken6bsdwb@q2wk2nbvxr3p>
References: <20260424070234.190145-1-surenb@google.com>
 <20260424070234.190145-4-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424070234.190145-4-surenb@google.com>

On 26/04/24 12:02AM, Suren Baghdasaryan wrote:
> Add MAPS_FILE environment variable to select whether the tests to be run
> for /proc/pid/maps or /proc/pid/smaps. Add support for testing smaps file
> by reusing the same logic as with maps file but skipping all the data
> except for the VMA addresses, which are the only part relevant for the
> tearing tests. Skip PROCMAP_QUERY parts of the tests because smaps does
> not implement that ioctl.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

One comment question, otherwise..

Reviewed-by: Liam R. Howlett <liam@infradead.org>

> ---
>  tools/testing/selftests/proc/proc-maps-race.c | 176 +++++++++++++-----
>  1 file changed, 132 insertions(+), 44 deletions(-)
> 
> diff --git a/tools/testing/selftests/proc/proc-maps-race.c b/tools/testing/selftests/proc/proc-maps-race.c
> index c5031b0593b7..b677bc23cab9 100644
> --- a/tools/testing/selftests/proc/proc-maps-race.c
> +++ b/tools/testing/selftests/proc/proc-maps-race.c
> @@ -17,8 +17,8 @@
>   */
>  /*
>   * Fork a child that concurrently modifies address space while the main
> - * process is reading /proc/$PID/maps and verifying the results. Address
> - * space modifications include:
> + * process is reading /proc/$PID/maps and /proc/$PID/smaps, verifying the
                                         ^^^ and? Should this be or?  It
                                         doesn't match your commit
                                         message.


> + * results. Address space modifications include:
>   *     VMA splitting and merging
>   *
>   */
> @@ -73,6 +73,11 @@ enum test_state {
>  	TEST_DONE,
>  };
>  
> +enum maps_file {
> +	MAPS,
> +	SMAPS,
> +};
> +
>  struct vma_modifier_info;
>  
>  FIXTURE(proc_maps_race)
> @@ -83,6 +88,7 @@ FIXTURE(proc_maps_race)
>  	struct line_content last_line;
>  	struct line_content first_line;
>  	unsigned long duration_sec;
> +	enum maps_file maps_file;
>  	int shared_mem_size;
>  	int skip_pages;
>  	int page_size;
> @@ -199,6 +205,57 @@ static void copy_last_line(struct page_content *page, char *last_line)
>  	last_line[end - pos] = '\0';
>  }
>  
> +static bool copy_first_entry(struct page_content *page, char *first_line)
> +{
> +	const char *start_pos = page->data;
> +
> +	while (start_pos < page->data + page->size) {
> +		unsigned long start_addr;
> +		unsigned long end_addr;
> +		char *end_pos;
> +
> +		end_pos = strchr(start_pos, '\n');
> +		if (!end_pos)
> +			break;
> +
> +		if (sscanf(start_pos, "%lx-%lx", &start_addr, &end_addr) == 2) {
> +			strncpy(first_line, start_pos, end_pos - start_pos);
> +			first_line[end_pos - start_pos] = '\0';
> +			return true;
> +		}
> +
> +		start_pos = end_pos + 1;
> +	}
> +
> +	return false;
> +}
> +
> +static bool copy_last_entry(struct page_content *page, char *last_line)
> +{
> +	const char *end_pos = page->data + page->size - 1;
> +	const char *start_pos;
> +
> +	while (end_pos > page->data) {
> +		unsigned long start_addr;
> +		unsigned long end_addr;
> +
> +		/* skip last newline */
> +		start_pos = end_pos - 1;
> +		/* search previous newline */
> +		while (start_pos > page->data && start_pos[-1] != '\n')
> +			start_pos--;
> +		if (sscanf(start_pos, "%lx-%lx", &start_addr, &end_addr) == 2) {
> +			strncpy(last_line, start_pos, end_pos - start_pos);
> +			last_line[end_pos - start_pos] = '\0';
> +			return true;
> +		}
> +
> +		end_pos = start_pos - 1;
> +	}
> +
> +	return false;
> +}
> +
>  /* Read the last line of the first page and the first line of the second page */
>  static bool read_boundary_lines(FIXTURE_DATA(proc_maps_race) *self,
>  				struct line_content *last_line,
> @@ -207,8 +264,16 @@ static bool read_boundary_lines(FIXTURE_DATA(proc_maps_race) *self,
>  	if (!read_two_pages(self))
>  		return false;
>  
> -	copy_last_line(&self->page1, last_line->text);
> -	copy_first_line(&self->page2, first_line->text);
> +	if (self->maps_file == MAPS) {
> +		copy_last_line(&self->page1, last_line->text);
> +		copy_first_line(&self->page2, first_line->text);
> +	} else if (self->maps_file == SMAPS) {
> +		if (!copy_last_entry(&self->page1, last_line->text) ||
> +		    !copy_first_entry(&self->page2, first_line->text))
> +			return false;
> +	} else {
> +		return false;
> +	}
>  
>  	return sscanf(last_line->text, "%lx-%lx", &last_line->start_addr,
>  		      &last_line->end_addr) == 2 &&
> @@ -464,6 +529,7 @@ FIXTURE_SETUP(proc_maps_race)
>  {
>  	const char *verbose = getenv("VERBOSE");
>  	const char *duration = getenv("DURATION");
> +	const char *maps_file = getenv("MAPS_FILE");
>  	struct vma_modifier_info *mod_info;
>  	pthread_mutexattr_t mutex_attr;
>  	pthread_condattr_t cond_attr;
> @@ -474,6 +540,18 @@ FIXTURE_SETUP(proc_maps_race)
>  
>  	self->page_size = (unsigned long)sysconf(_SC_PAGESIZE);
>  	self->verbose = verbose && !strncmp(verbose, "1", 1);
> +	if (maps_file) {
> +		if (!strcmp(maps_file, "maps")) {
> +			self->maps_file = MAPS;
> +		} else if (!strcmp(maps_file, "smaps")) {
> +			self->maps_file = SMAPS;
> +		} else {
> +			ksft_print_msg("Unknown maps file %s\n", maps_file);
> +			ksft_exit_fail();
> +		}
> +	} else {
> +		self->maps_file = MAPS;
> +	}
>  	duration_sec = duration ? atol(duration) : 0;
>  	self->duration_sec = duration_sec ? duration_sec : 5UL;
>  
> @@ -540,7 +618,16 @@ FIXTURE_SETUP(proc_maps_race)
>  		exit(0);
>  	}
>  
> -	sprintf(fname, "/proc/%d/maps", self->pid);
> +	switch (self->maps_file) {
> +	case MAPS:
> +		sprintf(fname, "/proc/%d/maps", self->pid);
> +		break;
> +	case SMAPS:
> +		sprintf(fname, "/proc/%d/smaps", self->pid);
> +		break;
> +	default:
> +		ksft_exit_fail();
> +	}
>  	self->maps_fd = open(fname, O_RDONLY);
>  	ASSERT_NE(self->maps_fd, -1);
>  
> @@ -675,20 +762,20 @@ TEST_F(proc_maps_race, test_maps_tearing_from_split)
>  		last_line_changed = strcmp(new_last_line.text, self->last_line.text) != 0;
>  		first_line_changed = strcmp(new_first_line.text, self->first_line.text) != 0;
>  		ASSERT_EQ(last_line_changed, first_line_changed);
> -
> -		/* Check if PROCMAP_QUERY ioclt() finds the right VMA */
> -		ASSERT_TRUE(query_addr_at(self->maps_fd, mod_info->addr + self->page_size,
> -					  &vma_start, &vma_end));
> -		/*
> -		 * The vma at the split address can be either the same as
> -		 * original one (if read before the split) or the same as the
> -		 * first line in the second page (if read after the split).
> -		 */
> -		ASSERT_TRUE((vma_start == self->last_line.start_addr &&
> -			     vma_end == self->last_line.end_addr) ||
> -			    (vma_start == split_first_line.start_addr &&
> -			     vma_end == split_first_line.end_addr));
> -
> +		if (self->maps_file == MAPS) {
> +			/* Check if PROCMAP_QUERY ioclt() finds the right VMA */
> +			ASSERT_TRUE(query_addr_at(self->maps_fd, mod_info->addr + self->page_size,
> +						  &vma_start, &vma_end));
> +			/*
> +			 * The vma at the split address can be either the same as
> +			 * original one (if read before the split) or the same as the
> +			 * first line in the second page (if read after the split).
> +			 */
> +			ASSERT_TRUE((vma_start == self->last_line.start_addr &&
> +				     vma_end == self->last_line.end_addr) ||
> +				    (vma_start == split_first_line.start_addr &&
> +				     vma_end == split_first_line.end_addr));
> +		}
>  		clock_gettime(CLOCK_MONOTONIC_COARSE, &end_ts);
>  		end_test_iteration(&end_ts, self->verbose);
>  	} while (end_ts.tv_sec - start_ts.tv_sec < self->duration_sec);
> @@ -758,17 +845,18 @@ TEST_F(proc_maps_race, test_maps_tearing_from_resize)
>  					strcmp(new_first_line.text, restored_first_line.text),
>  					"Expand result invalid", self));
>  		}
> -
> -		/* Check if PROCMAP_QUERY ioclt() finds the right VMA */
> -		ASSERT_TRUE(query_addr_at(self->maps_fd, mod_info->addr, &vma_start, &vma_end));
> -		/*
> -		 * The vma should stay at the same address and have either the
> -		 * original size of 3 pages or 1 page if read after shrinking.
> -		 */
> -		ASSERT_TRUE(vma_start == self->last_line.start_addr &&
> -			    (vma_end - vma_start == self->page_size * 3 ||
> -			     vma_end - vma_start == self->page_size));
> -
> +		if (self->maps_file == MAPS) {
> +			/* Check if PROCMAP_QUERY ioclt() finds the right VMA */
> +			ASSERT_TRUE(query_addr_at(self->maps_fd, mod_info->addr,
> +						  &vma_start, &vma_end));
> +			/*
> +			 * The vma should stay at the same address and have either the
> +			 * original size of 3 pages or 1 page if read after shrinking.
> +			 */
> +			ASSERT_TRUE(vma_start == self->last_line.start_addr &&
> +				    (vma_end - vma_start == self->page_size * 3 ||
> +				     vma_end - vma_start == self->page_size));
> +		}
>  		clock_gettime(CLOCK_MONOTONIC_COARSE, &end_ts);
>  		end_test_iteration(&end_ts, self->verbose);
>  	} while (end_ts.tv_sec - start_ts.tv_sec < self->duration_sec);
> @@ -838,20 +926,20 @@ TEST_F(proc_maps_race, test_maps_tearing_from_remap)
>  					strcmp(new_first_line.text, restored_first_line.text),
>  					"Remap restore result invalid", self));
>  		}
> -
> -		/* Check if PROCMAP_QUERY ioclt() finds the right VMA */
> -		ASSERT_TRUE(query_addr_at(self->maps_fd, mod_info->addr + self->page_size,
> -					  &vma_start, &vma_end));
> -		/*
> -		 * The vma should either stay at the same address and have the
> -		 * original size of 3 pages or we should find the remapped vma
> -		 * at the remap destination address with size of 1 page.
> -		 */
> -		ASSERT_TRUE((vma_start == self->last_line.start_addr &&
> -			     vma_end - vma_start == self->page_size * 3) ||
> -			    (vma_start == self->last_line.start_addr + self->page_size &&
> -			     vma_end - vma_start == self->page_size));
> -
> +		if (self->maps_file == MAPS) {
> +			/* Check if PROCMAP_QUERY ioclt() finds the right VMA */
> +			ASSERT_TRUE(query_addr_at(self->maps_fd, mod_info->addr + self->page_size,
> +						  &vma_start, &vma_end));
> +			/*
> +			 * The vma should either stay at the same address and have the
> +			 * original size of 3 pages or we should find the remapped vma
> +			 * at the remap destination address with size of 1 page.
> +			 */
> +			ASSERT_TRUE((vma_start == self->last_line.start_addr &&
> +				     vma_end - vma_start == self->page_size * 3) ||
> +				    (vma_start == self->last_line.start_addr + self->page_size &&
> +				     vma_end - vma_start == self->page_size));
> +		}
>  		clock_gettime(CLOCK_MONOTONIC_COARSE, &end_ts);
>  		end_test_iteration(&end_ts, self->verbose);
>  	} while (end_ts.tv_sec - start_ts.tv_sec < self->duration_sec);
> -- 
> 2.54.0.545.g6539524ca2-goog
> 
