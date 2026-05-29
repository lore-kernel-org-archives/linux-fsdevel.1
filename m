Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1B3378D84
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 04:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780029916; cv=none; b=lxmDGat8++iiZ+jLajffECO38tIykhO3IiaBQ9D+yXWTTZIhEfzESjpvyMpQMDwec9yF6uohsxqWP4alDmQyDTHtToZKHLIp1bZ8PbozY0CHoh6ukkPz1RAh5nch1MJgb7nGRmOYm5xdfq87UObP/LJ2uh7RGTaL697xoeBbi4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780029916; c=relaxed/simple;
	bh=5wG3Uke4e1KFAqPCnvdmG45qb1rsTmgeu2z7PeBr0Do=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CIQfe6WBpm/d1O7vHJb9Usl0/hXC89De2/yvnlM6R0/L9CyznQzsO45xLy5+eBkRv0PsRcsLs/JOIsRkfrLZvNbzBRbs7RdBTlo8+i14YiFa2iU/aLdc11b0tMFnNDLZocDNGnZUVECClFVMqPPkKP4sX3nFnYEAqctEG8SFTns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BKpPrIgv; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BKpPrIgv"
Message-ID: <0f50af7f-03c5-46d5-9d68-553dc6995df0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780029910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BJIrMxTwHebZdafdcfjecbzEMB7/twHvKSL0vrreGMQ=;
	b=BKpPrIgvhIZ6CiQGG6rZe1udMhuTUMdKx51EyT/OLR77Vw2hy1oyO1FZP8omZ1IaWM4c4X
	UT6HmWeFVPLIgRw6nY3dmu7jwSFa4L8YiEfvzbIJEBp1w3bKoAulJz0MKINPNDQSR3eLo1
	G7HneH4/42VFshLs97qgkEzWHLb1aj8=
Date: Fri, 29 May 2026 12:44:46 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/3] bpf: cgroup: fix sysctl new-value handling in
 __cgroup_bpf_run_filter_sysctl
To: Dawei Feng <dawei.feng@seu.edu.cn>, martin.lau@linux.dev
Cc: emil@etsalapatis.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, kees@kernel.org,
 joel.granados@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, jianhao.xu@seu.edu.cn
References: <20260529031026.2716641-1-dawei.feng@seu.edu.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260529031026.2716641-1-dawei.feng@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 5/29/26 11:10 AM, Dawei Feng wrote:
> This series fixes three bugs in the sysctl write-buffer replacement path
> of __cgroup_bpf_run_filter_sysctl(). It resolves a kvzalloc()/kfree()
> mismatch, adds a missing NUL terminator to the replacement string, and
> updates a stale return value check to safely restore the replacement
> functionality.
>
> Patch Summary:
> - patch 1 uses kvfree() for the replaced sysctl write buffer
> - patch 2 NUL-terminates the replaced sysctl value
> - patch 3 restores sysctl new-value replacement
>
> Changelog:
> v1 -> v2:
> - added patch 2 to fix an out-of-bounds access in
>    bpf_sysctl_set_new_value() by properly NUL-terminating the replaced
>    sysctl value buffer.
> - reordered patches 1 and 3.


I think patch 1 and patch 3 should be adjacent in the series.

Why is patch 2 placed between them?

>
> Dawei Feng (3):
>    bpf: cgroup: use kvfree() for replaced sysctl write buffer
>    bpf: cgroup: NUL-terminate replaced sysctl value
>    bpf: cgroup: restore sysctl new-value replacement
>
>   kernel/bpf/cgroup.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
