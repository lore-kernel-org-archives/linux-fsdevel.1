Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F902EEE91
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2026 21:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792187713; cv=none; b=MKiESnbGe57sqATvRAiKcKPj8UjFbreGLG3gJISU8ndkLi4WC1R2hfJ/MpbWb4/xc+l+1RSAoy1u7vj+L9K0skgfBbb46KpHIQQIqGK4LIJTGjhngODza/iFJwEFqpFAYWF+Cc5/V7VCkuzbq3pe/ZeZZ6uaU9sAManl44q7YEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792187713; c=relaxed/simple;
	bh=/XEZGiYaI371KDDNsdrAUllzBSMxnPFpvE97XeAMNu0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=TgyL763lAsT5Zvym0WaEI3o0I5HtI4tx5R5eAvrpf0c71FK2APsgraLKaWbZka258e3TWIyopSXHd4x09dK6OdfmmhDCVzjYUpLPEybugSsoyRTPT1PvUIju3E+4lvnM+YWzcTdLlHfa68N4LvRKbVvD8p3JXwMcwsRPx2ot0Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FRrYTkxI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FRrYTkxI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B79DA1F000C4;
	Fri, 16 Oct 2026 21:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792187711;
	bh=wyOeWaReVe49glsqTR1A683AdzcmdRr6nlqlhgz/D8I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FRrYTkxIS4DI+SOjUKehZwHfmr68+eOqbFKW8GuKMmXMPgLc443FqEPwwPFTCojce
	 NnsOlzdK2TaFgQ/ZiEn/+YHsHNpRki/G2GX+DN/rLUnnk+3QhrDOMetBGsuwoUCpQd
	 iFvu7W9mUu7/qoIG53BjBmd6752EcVZvrk8fAlKa2uQBVPtAOommmZTb0vIWx4Y6x7
	 nG8J9A2gSCwqNWa4QxMYWqDERkGYbXtoAvVkzQfiv9qAX/7D2SNFajB9UC+m3qojuJ
	 sp6vZW33L5UaQzlqU9i4ARbqOZIBiCrnhn92ffo9evC/5OsFYfbbi31zIjUI0PbAI6
	 6OUF1CCUESNsQ==
Date: Fri, 16 Oct 2026 11:55:10 -1000
Message-ID: <ece89688cebc89143733bbe1556f1d5e@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Julian Sun <sunjunchao@bytedance.com>
Cc: linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, akpm@linux-foundation.org, roman.gushchin@linux.dev, dennis@kernel.org
Subject: Re: [PATCH 1/2] writeback: reset dirtied_when when switching wbs
In-Reply-To: <20261016115230.3640770-2-sunjunchao@bytedance.com>
References: <20261016115230.3640770-1-sunjunchao@bytedance.com> <20261016115230.3640770-2-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

On Fri, Oct 16, 2026 at 07:52:29PM +0800, Julian Sun wrote:
> When switching a dirty inode to another wb, inode_do_switch_wbs() puts
> it at the newest end of the target b_dirty list instead of searching
> for its sorted position. This requires updating dirtied_when, which
> move_expired_inodes() uses to decide where to stop scanning.
>
> However, the switch updates dirtied_time_when instead. This leaves
> b_dirty out of order and can make the scan stop before reaching older
> inodes. It also resets the lazytime expiration timestamp, potentially
> delaying timestamp writeback.
>
> Update dirtied_when instead, preserving both the constant-time insertion
> and the lazytime expiration timestamp. Correct the field name in the
> comment and document the distinction between the two inode timestamps.
>
> Fixes: 9a6ebbdbd412 ("writeback: Avoid excessively long inode switching times")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Julian Sun <sunjunchao@bytedance.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
