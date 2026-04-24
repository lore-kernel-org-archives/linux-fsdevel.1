Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628B731AF31;
	Fri, 24 Apr 2026 18:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777054914; cv=none; b=GP6EWX4/ajzeEfTlhl9sktOzDh0y0L0DteDkxcMtBqdmvNL9hQwzMyiupfOqlhsO6lX1u60KAbv6q6S0slZMwThqi3rAZ6sOcFZvXfFGL9rRCEXKEbzNEJ/ywk+hCINCuH1SJtDX2dTrP2p2bL7n/NrU4wzBP1OUn7tOJ6+7UTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777054914; c=relaxed/simple;
	bh=A6cwV09PFySh2BHMjLnyIAmw/A8PNSd9MGwqCSfKhvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Svk1AxCsiK7R6UAuSmyLLI5FlRI6M2Oy/oJNlRYaMR9RQdH0mMMBqqVFPPjGpB/L/zqVUyLm1+lPmEl1vRH3DZpzK+pece6lqlSkFRVwCyLEtqMKeVSMz1H5puc7UYaqfXCJkSIV45ldMKLNjQI84sOmKU0K2mBg1Yxck2/HZt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YTM5dHmh; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YTM5dHmh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NR6vNZVk0dPAkPir5/ba6AkbwkyQyimA7C2z0CUF9jY=; b=YTM5dHmhKFhPLVD6m7frehsJFM
	mkj+cMbG3hOIBtH3eNMKjFSYlQtfVSqwEbPE9yeoTWzJcBEHHR3aj5pqNEuoZE1bt69PyBlIDjIdM
	KqDjCSSQbbFUI38/J2+55KCaRWVtI01mVaD73WMh6nLoTy3zTbe9voRbhqx5zbTIrlB6z7Rce3m3q
	x4IuSOxw15q7QZE9wkXZE8BOZkHS5oJSpyCqW9oHnEN/E6Udbj9qMeR6kyVwLb74sthaThO0y1H7n
	MDuA4sUYBz7vpKcwCfCWd2aHGplA6xd/2b2IDXW/nAr9YfsSKiBdHG+mL8iBO1mUwHaDbEb5ioymZ
	OaI17/rw==;
Received: from [38.23.173.23] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGL9x-0000000DdtV-2Cgk;
	Fri, 24 Apr 2026 18:21:49 +0000
Date: Fri, 24 Apr 2026 14:21:47 -0400
From: "Liam R. Howlett" <liam@infradead.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, ljs@kernel.org, vbabka@kernel.org, 
	david@redhat.com, willy@infradead.org, jannh@google.com, paulmck@kernel.org, 
	pfalcato@suse.de, shuah@kernel.org, hsukrut3@gmail.com, richard.weiyang@gmail.com, 
	reddybalavignesh9979@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/3] selftests/proc: ensure the test is performed at the
 right page boundary
Message-ID: <j3vswsvp6jp3hopogpc2qqre4mwneeffoutbytlgt6sah2blgz@33rsxbylk7bv>
References: <20260424070234.190145-1-surenb@google.com>
 <20260424070234.190145-3-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424070234.190145-3-surenb@google.com>

On 26/04/24 12:02AM, Suren Baghdasaryan wrote:
> When running tearing tests we need to ensure the pages we use include
> VMAs that were mapped by the child process for this test. Currently we
> always use the first two pages, checking VMAs at their boundaries and
> this works, however once we add tests for /proc/pid/smaps, the first two
> pages might not contain the VMAs that child modifies.
> Locate the page that contains the first VMA mapped by the child and use
> that and the next page for the test.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Liam R. Howlett <liam@infradead.org>

> ---
>  tools/testing/selftests/proc/proc-maps-race.c | 78 ++++++++++++++++---
>  1 file changed, 68 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/testing/selftests/proc/proc-maps-race.c b/tools/testing/selftests/proc/proc-maps-race.c
> index a734553718da..c5031b0593b7 100644
> --- a/tools/testing/selftests/proc/proc-maps-race.c
> +++ b/tools/testing/selftests/proc/proc-maps-race.c
> @@ -39,6 +39,13 @@
>  #include <sys/types.h>
>  #include <sys/wait.h>
>  
> +#define min(a, b) \
> +	({ \
> +		typeof(a) _a = (a); \
> +		typeof(b) _b = (b); \
> +		_a < _b ? _a : _b; \
> +	})
> +

Another implementation of min in the selftests.  I guess it's somewhat
unavoidable.

>  /* /proc/pid/maps parsing routines */
>  struct page_content {
>  	char *data;
> @@ -77,6 +84,7 @@ FIXTURE(proc_maps_race)
>  	struct line_content first_line;
>  	unsigned long duration_sec;
>  	int shared_mem_size;
> +	int skip_pages;
>  	int page_size;
>  	int vma_count;
>  	bool verbose;
> @@ -105,27 +113,68 @@ struct vma_modifier_info {
>  	void *child_mapped_addr[];
>  };
>  
> -
> -static bool read_two_pages(FIXTURE_DATA(proc_maps_race) *self)
> +static bool read_page(FIXTURE_DATA(proc_maps_race) *self,
> +		      struct page_content *page)
>  {
>  	ssize_t  bytes_read;
>  
> -	if (lseek(self->maps_fd, 0, SEEK_SET) < 0)
> +	bytes_read = read(self->maps_fd, page->data, self->page_size);
> +	if (bytes_read <= 0)
>  		return false;
>  
> -	bytes_read = read(self->maps_fd, self->page1.data, self->page_size);
> -	if (bytes_read <= 0)
> +	/* Make sure data always ends with a newline character. */
> +	if (page->data[bytes_read - 1] != '\n')
>  		return false;
>  
> -	self->page1.size = bytes_read;
> +	page->size = bytes_read;
>  
> -	bytes_read = read(self->maps_fd, self->page2.data, self->page_size);
> -	if (bytes_read <= 0)
> +	return true;
> +}
> +
> +static int locate_containing_page(FIXTURE_DATA(proc_maps_race) *self,
> +				  unsigned long addr, unsigned long size)
> +{
> +	unsigned long start, end;
> +	int page = 0;
> +
> +	if (lseek(self->maps_fd, 0, SEEK_SET) < 0)
> +		return -1;
> +
> +	while (true) {
> +		char *curr_pos;
> +		char *end_pos;
> +
> +		if (!read_page(self, &self->page1))
> +			return -1;
> +
> +		curr_pos = self->page1.data;
> +		end_pos = self->page1.data + self->page1.size;
> +		while (curr_pos < end_pos) {
> +			if (sscanf(curr_pos, "%lx-%lx", &start, &end) == 2 &&
> +			    start == addr && end == addr + size)
> +				return page;
> +
> +			curr_pos = strchr(curr_pos, '\n');
> +			if (!curr_pos)
> +				break;
> +			curr_pos++;
> +		}
> +		page++;
> +	}
> +
> +	return 0;
> +}
> +
> +static bool read_two_pages(FIXTURE_DATA(proc_maps_race) *self)
> +{
> +	if (lseek(self->maps_fd, 0, SEEK_SET) < 0)
>  		return false;
>  
> -	self->page2.size = bytes_read;
> +	for (int i = 0; i < self->skip_pages; i++)
> +		if (!read_page(self, &self->page1))
> +			return false;
>  
> -	return true;
> +	return read_page(self, &self->page1) && read_page(self, &self->page2);
>  }
>  
>  static void copy_first_line(struct page_content *page, char *first_line)
> @@ -418,6 +467,8 @@ FIXTURE_SETUP(proc_maps_race)
>  	struct vma_modifier_info *mod_info;
>  	pthread_mutexattr_t mutex_attr;
>  	pthread_condattr_t cond_attr;
> +	unsigned long first_map_addr;
> +	unsigned long last_map_addr;
>  	unsigned long duration_sec;
>  	char fname[32];
>  
> @@ -502,6 +553,13 @@ FIXTURE_SETUP(proc_maps_race)
>  	self->page2.data = malloc(self->page_size);
>  	ASSERT_NE(self->page2.data, NULL);
>  
> +	first_map_addr = (unsigned long)mod_info->child_mapped_addr[0];
> +	last_map_addr = (unsigned long)mod_info->child_mapped_addr[mod_info->vma_count - 1];
> +
> +	self->skip_pages = locate_containing_page(self,
> +					min(first_map_addr, last_map_addr),
> +					self->page_size * 3);
> +	ASSERT_NE(self->skip_pages, -1);
>  	ASSERT_TRUE(read_boundary_lines(self, &self->last_line, &self->first_line));
>  
>  	/*
> -- 
> 2.54.0.545.g6539524ca2-goog
> 
