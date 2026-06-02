Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE561F4180;
	Tue,  2 Jun 2026 00:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780361031; cv=none; b=FhBO38TLgctlKSbYwdAZeUyI2wI6GngROw0tB+N/igXol2o+re2F914ZCcfRWSZedQgCDfOB8hrTsAiZtFszsMSq3iXLcGBv4Sn/i7FqBnPQobo99T9Q13dMLRdiCLGQoVq5NkpJcK3uwfQe5gYce20paNdy96JdeggvPDFlhOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780361031; c=relaxed/simple;
	bh=EP7NbwxGQO3cHzJFzkZ79NTCvuSBMk7HVlXDF5Gk4gU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=MzTvEF+P0CKyfd6EbS40pbppuskF6R5EWI9W5RuPZSaT6g29eAEZMyLPcQ73CmmTALD32JLe8ODnuXKtuO0qMkHPIrc9CrvGAM+cY2L7y6CJhk+x+49aHxMkD7NpOx4eYNbJIy0Efni1NK6Arw3gzmSZCCTW7wJR4M0rymfOfv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bFcb+93/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bFcb+93/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AA561F00893;
	Tue,  2 Jun 2026 00:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1780361030;
	bh=Rh2n9Gu0rmNTDcj9emYz6ha4zA22fi+waHRK2Lt+xYA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bFcb+93/9S95ynXbVnpuZtZBYT+X51bssv+rLmgGtRgV8B/W56LyHj9DX1uQVcj4i
	 Pd6p0tFzPEmJGOLkLwCU38i7iM7tieX6PLvShLWnLmzImiLUxjSOP+AuXGeNX+RDxQ
	 9ziqdplU8XWD78fouW0PPprxDLqIHU3nxGZ3Rhqw=
Date: Mon, 1 Jun 2026 17:43:49 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Chi Zhiling <chizhiling@163.com>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, Jan Kara <jack@suse.cz>, Hugh Dickins
 <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, Chi
 Zhiling <chizhiling@kylinos.cn>
Subject: Re: [PATCH v2 0/5] mm/shmem: optimize read with reduced xarray
 lookups and folio batching
Message-Id: <20260601174349.e521b96acac805ac3d9bfbbb@linux-foundation.org>
In-Reply-To: <20260601055704.167436-1-chizhiling@163.com>
References: <20260601055704.167436-1-chizhiling@163.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  1 Jun 2026 13:56:59 +0800 Chi Zhiling <chizhiling@163.com> wrote:

> From: Chi Zhiling <chizhiling@kylinos.cn>
> 
> This series improves shmem read performance by implementing folio
> batching in the read path and reducing unnecessary xarray lookups.
> 
> Performance Results:
> 
> fio --ioengine=sync --rw=read --bs=$1 --size=1G --runtime=180 --time_based --group_reporting --name=seq_read_test --filename=testfile
> 
> | THP disabled in tmpfs  | v7.1-rc5     | v7.1-rc5 + fbatch | Improvement |
> | ---------------------- | ------------ | ----------------- | ----------- |
> | 1M + normal file       | bw=11.5GiB/s | bw=12.7GiB/s      | +10.4%      |
> | 64k + normal file      | bw=11.0GiB/s | bw=12.3GiB/s      | +11.8%      |
> | 4k + normal file       | bw=3826MiB/s | bw=3849MiB/s      | +0.6%       |
> | 1M + fallocated file   | bw=23.8GiB/s | bw=28.6GiB/s      | +20.2%      |
> | 64k + fallocated file  | bw=22.5GiB/s | bw=27.3GiB/s      | +21.3%      |
> | 4k + fallocated file   | bw=4655MiB/s | bw=4680MiB/s      | +0.5%       |
> | 1M + hole              | bw=24.2GiB/s | bw=28.6GiB/s      | +18.2%      |
> | 64k + hole             | bw=22.6GiB/s | bw=27.6GiB/s      | +22.1%      |
> | 4k + hole              | bw=4652MiB/s | bw=4489MiB/s      | -3.5%       |
> 
> 
> | THP enabled in tmpfs  | v7.1-rc5     | v7.1-rc5 + fbatch | Improvement |
> | --------------------- | ------------ | ----------------- | ----------- |
> | 1M + normal file      | bw=13.7GiB/s | bw=13.9GiB/s      | +1.4%       |
> | 64k + normal file     | bw=13.5GiB/s | bw=13.5GiB/s      | +0.0%       |
> | 4k + normal file      | bw=3833MiB/s | bw=3859MiB/s      | +0.7%       |
> | 1M + fallocated file  | bw=24.9GiB/s | bw=34.2GiB/s      | +37.3%      |
> | 64k + fallocated file | bw=23.0GiB/s | bw=31.4GiB/s      | +36.5%      |
> | 4k + fallocated file  | bw=4710MiB/s | bw=4655MiB/s      | -1.2%       |
> | 1M + hole             | bw=24.3GiB/s | bw=34.5GiB/s      | +42.0%      |
> | 64k + hole            | bw=23.5GiB/s | bw=31.1GiB/s      | +32.3%      |
> | 4k + hole             | bw=4690MiB/s | bw=4647MiB/s      | -0.9%       |
> 

That looks nice.

Microbenchmarks are useful, but are you able to help us understand how
much benefit our users might see in real-world workloads?

I'll take no action at this time - it's late in the cycle and reviewers
have yet to participate.

AI review flagged a few possible issues, so please take a look:
	https://sashiko.dev/#/patchset/20260601055704.167436-1-chizhiling@163.com
