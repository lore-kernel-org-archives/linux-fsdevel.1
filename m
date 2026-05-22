Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A801A681B;
	Fri, 22 May 2026 00:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779408897; cv=none; b=hPBZJSGlWOdcHj48yqFUD0mIYpaZqCI6GLj5nH25gVnMPNx7Y7TaDqoqFqUcO4/rovYei2Bkn7M4ZjBxoF4B6CHbs+jjmXiolTp5BPpSVwUuva6R6Yw23DuSYVk74bCxK0ro4WYONmLhreZpRE41uOPdunAwmSn9onYgCdDP8v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779408897; c=relaxed/simple;
	bh=x4BC34HQRJ0b4ItlCvvJErsju5hLl/trdJ24IzaYuGQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=l5AFA7JLDiv+kzQyCzF5Tn8kaLC4DjdNfXfiegkZKhNX/SjsqaB/+S/2vx/LOU68wiCQGIuIPRrezNTWu4Qq735zvwYEuyLIRyoAFaT4dH6gXBg+LnrOCs1SWEcM4mN+7DPDnh4hDIpc+XinfeRZeBN+ZhdzBdAi6/r0ftd8U4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PpUMZHIp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PpUMZHIp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E77CB1F000E9;
	Fri, 22 May 2026 00:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1779408895;
	bh=E58V6pPlsJLWcNEF4SeWKytMRUR3ac3u30rtpH9EvgM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PpUMZHIp4iHxmimKHo6fhve6bJMUqOFPIGWZw6k30OUBljIH2D2Yo6K9StgdreHBS
	 +uGCZ2QmP04gZdn98kAx9CQE4qM8gBgORSWlBASmtZDHJPfveUiwq4I0rIVTNdUVF+
	 Ev5hUkweZqg+0w3EB4oZZdsQuo+O3vYtgbfV+c9Q=
Date: Thu, 21 May 2026 17:14:54 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Chi Zhiling <chizhiling@163.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Hugh Dickins <hughd@google.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, Jan Kara <jack@suse.cz>, David Hildenbrand
 <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Zi Yan
 <ziy@nvidia.com>, "Liam R. Howlett" <liam@infradead.org>, Nico Pache
 <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain
 <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, Lance Yang
 <lance.yang@linux.dev>, Chi Zhiling <chizhiling@kylinos.cn>
Subject: Re: [PATCH v1 0/5] mm/shmem: optimize read with reduced xarray
 lookups and folio batching
Message-Id: <20260521171454.02e35e71f999672518087037@linux-foundation.org>
In-Reply-To: <20260520101538.58745-1-chizhiling@163.com>
References: <20260520101538.58745-1-chizhiling@163.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 May 2026 18:15:33 +0800 Chi Zhiling <chizhiling@163.com> wrote:

> From: Chi Zhiling <chizhiling@kylinos.cn>
> 
> This series improves shmem read performance by implementing folio
> batching in the read path and reducing unnecessary xarray lookups.
> 

Thanks.

> Performance Results
> ===================
> 
> Testing was performed with fio sequential read workloads:
> 
>   fio --ioengine=sync --rw=read --size=1G --runtime=180
> 
> 
> ### THP Disabled - Normal Files ###
> 
> | Block Size | Baseline  | v1        | Improvement |
> | ---------- | --------- | --------- | ----------- |
> | 1M         | 11.4GiB/s | 12.7GiB/s | +11.4%      |
> | 64k        | 11.2GiB/s | 12.2GiB/s | +8.9%       |
> | 4k         | 3809MiB/s | 3838MiB/s | +0.8%       |
> 
> ### THP Disabled - Fallocated Files ###
> 
> | Block Size | Baseline  | v1        | Improvement |
> | ---------- | --------- | --------- | ----------- |
> | 1M         | 23.7GiB/s | 28.7GiB/s | +21.1%      |
> | 64k        | 22.6GiB/s | 27.0GiB/s | +19.5%      |
> | 4k         | 4668MiB/s | 4678MiB/s | +0.2%       |
> 
> ### THP Enabled - Normal Files ###
> 
> | Block Size | Baseline  | v1        | Improvement |
> | ---------- | --------- | --------- | ----------- |
> | 1M         | 13.9GiB/s | 13.9GiB/s | 0%          |
> | 64k        | 13.4GiB/s | 13.4GiB/s | 0%          |
> | 4k         | 3818MiB/s | 3836MiB/s | +0.5%       |
> 
> ### THP Enabled - Fallocated Files ###
> 
> | Block Size | Baseline  | v1        | Improvement |
> | ---------- | --------- | --------- | ----------- |
> | 1M         | 24.1GiB/s | 34.9GiB/s | +44.8%      |
> | 64k        | 22.9GiB/s | 31.3GiB/s | +36.7%      |
> | 4k         | 4721MiB/s | 4708MiB/s | -0.3%       |

That looks nice.

AI review might have found a few things:
	https://sashiko.dev/#/patchset/20260520101538.58745-1-chizhiling@163.com

I'll skip the patchset for now (unreviewed v1!).

