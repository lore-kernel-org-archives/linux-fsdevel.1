Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCE323392B;
	Sun, 19 Jul 2026 07:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784445926; cv=none; b=fNKGTABaF442u977SaqAUgnosSSJTdXMDy+Et9cSuxb/HrOdvquJte5EjGnBJwLLk5A+fYw9utx1lEudx3bYcz6v/DEPpdD8FA/mIth36WNFZL3/SA2Na1ExA6RQjjAcKgMQ6seBi4Hk2OlJSUaUmTy/HXVIRE/DQpbo70ulVDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784445926; c=relaxed/simple;
	bh=GzoMKFQShzjrHnAt4yEh591bQz3FqYOThppEpXaB4PM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=R8fbsx/ikQKoeJz0rO50alnsbn1CEF8FftaWnN4UR/Tbcb74iZb952XVk5zoWa2ddDneVm+Xp0kq8oYJ5DMePzT/+yYd/MMBrTdBiTvW7iGo7kL2nvaYHGLy3y9JwiDW6NHcrZnmGnk/Ts4FVm8pU3XWh6SzhoW0j+yL/VUdhfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BrDL9qCf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BrDL9qCf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5BC61F000E9;
	Sun, 19 Jul 2026 07:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784445924;
	bh=5zam7qKa+GIJwAFhCvX75nMaMfpcCbBWqRrQoiYwcTI=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To;
	b=BrDL9qCfnC9nLRXaO8xar89TTbNNI23UIszHUS5A2328dOGS8Ry6gttjVJ9DmSFS2
	 l4/KclO3av85auomYNbJWgJkx073IXtHD9fsy2wOeQr6ZBawggHi6ADIr/liMP2TOC
	 +737ORse48xTVIHkFwoDUlsFV9OYGLm054dW1zyxlVNB8gL8HipaBC9r75up71lCwx
	 /NMv1XvnNEswmGZ6Zb5wPv9d7Dbp+ytxA+xIqPUIGrw5ncT8TuUTBq3yE9ehrLzga+
	 Fy0WVtS0fs6wsoNVum6fGIblAcxr6SuT4t7vxpwLe9wXNZMUR6niJbfDQczsBKFgSM
	 3hWVA7fuomjIQ==
Message-ID: <8eb1eb27-c87a-410e-abf1-0e014689de0a@kernel.org>
Date: Sun, 19 Jul 2026 15:25:20 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org
Subject: Re: [PATCH] f2fs: fix folio_nr_pages() race after put in large folio
 invalidate
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Zhaoyang Huang <huangzhaoyang@gmail.com>, steve.kang@unisoc.com
References: <20260713111944.924883-1-zhaoyang.huang@unisoc.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20260713111944.924883-1-zhaoyang.huang@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/13/26 19:19, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> Our v6.18 based Android system is continuely suffering livelock and bad
> page stat as shown in[1] which related to broken xarray slot status. By
> investigating big folio operations within f2fs, we find below races and
> fix it by get the nr_pages before drop the refcount and folio_lock.
> 
> f2fs_get_read_data_folio() calls f2fs_folio_put() before
> folio_nr_pages() when invalidating a large folio from the page cache.
> That unlocks the folio and drops the caller reference, leaving a window
> where a concurrent truncate or folio split can shrink the compound folio
> or free it before the invalidate range is computed. An undersized range
> then leaves split sub-folios in mapping->i_pages, which can later
> interact badly with truncate and reclaim (stale xarray entries and bad
> page state when folio->mapping no longer matches the mapping being
> truncated).
> 
> [1]
> PID: 2594     TASK: ffffff8169b81580  CPU: 7    COMMAND: "Thread-3"
>   #0 [ffffffc08ef2b8a0] xas_load at ffffffe52d1f42a4
>   #1 [ffffffc08ef2b900] find_get_entries at ffffffe52c185798
>   #2 [ffffffc08ef2bb60] truncate_inode_pages_range at ffffffe52c19e83c
>   #3 [ffffffc08ef2bbc0] truncate_inode_pages_final at ffffffe52c19ec2c
>   #4 [ffffffc08ef2bc20] f2fs_evict_inode at ffffffe52c4c8400
>   #5 [ffffffc08ef2bcc0] evict at ffffffe52c2de9f4
>   #6 [ffffffc08ef2bd00] iput at ffffffe52c2db1b4
>   #7 [ffffffc08ef2bd30] dentry_unlink_inode at ffffffe52c2d7204
>   #8 [ffffffc08ef2bd50] __dentry_kill at ffffffe52c2d3dcc
>   #9 [ffffffc08ef2bd80] dput at ffffffe52c2d3c3c
>   #10 [ffffffc08ef2bda0] __fput at ffffffe52c2b0a7c
>   #11 [ffffffc08ef2bde0] ____fput at ffffffe52c2b1034
>   #12 [ffffffc08ef2bdf0] task_work_run at ffffffe52beea200
>   #13 [ffffffc08ef2be20] exit_to_user_mode_loop at ffffffe52bfbc17c
>   #14 [ffffffc08ef2be80] el0_svc at ffffffe52d1f8e54
>   #15 [ffffffc08ef2beb0] el0t_64_sync_handler at ffffffe52d1f8d10
> 

Need fixes and Cc stable line.

> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Anyway, the code part looks good.

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
