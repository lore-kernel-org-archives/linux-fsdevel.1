Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B303B1EE2;
	Tue, 14 Jul 2026 03:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783998036; cv=none; b=WtFXPc6f02NYwFs31FwwjVU5UGtXjXnCpFtJ9x/3hDEnrffh2lVIAaLPeXV83qqrFWf8gf8uWWVZUOoV5VR+CLcFyHB7gFftH0jyZcBKFVZaquDXf5cB2dUlJN2VuM4PYS6vngzry9Wxl5hCCRogSbkey4LLLZDpxosMEiOld3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783998036; c=relaxed/simple;
	bh=r683DN2Zw6wyMw9aoZHodWR/RImDSbFaggxQwNASLyA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FSAVfy/0jOnL2dBe4Stp1VXsnNqc70zf/951ruu7ucmrMb3cAZ+TY7L5jPD053eLoyek5g8Q5K1vF437v7aMtsMrGvVqhJhNCvdBHp9/RlAF35blwkpeewx/qsQWWkgIAiajNxKtIQoQKe/JVNrS/lDKlEqvLUxklHFreNugwEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYF+UtVR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYF+UtVR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EBD71F00A3A;
	Tue, 14 Jul 2026 03:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783998034;
	bh=IjExG8SLdFmswT+7SNT2VlWPxv/Kx5sx61AUKIoe19k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kYF+UtVR/Z+tP0BDgQMNjRPnXw/M1HHg6GG8xmZiCLxUHcREwRJ9Dq/s9SNan6N4O
	 cjm+O/x6W31Uh9sWN+fcjRdaD1SYFJ3EU1IkDR6JX5iYquZcCFF3f4B+V0PZxgpoNn
	 WPtCqoX3HP7DMihqIGnfMZKamifF1wAKGJZsrl9dZgq1yW0n6ZI58LSPmKVlb9zWsN
	 UfVQtWoj7a7321ZQiOwTblibHG7n0z75SpVD4oASjSsR3wAgOFN2R76vdmI6ND2hOp
	 XVCQhLM4MtCyaJd+v4JQbVWS9xli5UYj7gm0fdnpmRANegx/9giENWGoW+9+owwwRt
	 ZpaNhIZpSzLTQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569EF3924FB7;
	Tue, 14 Jul 2026 03:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix folio_nr_pages() race after put in
 large folio invalidate
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <178399800888.2939750.13968624423667195416.git-patchwork-notify@kernel.org>
Date: Tue, 14 Jul 2026 03:00:08 +0000
References: <20260713111944.924883-1-zhaoyang.huang@unisoc.com>
In-Reply-To: <20260713111944.924883-1-zhaoyang.huang@unisoc.com>
To: zhaoyang.huang <zhaoyang.huang@unisoc.com>
Cc: jaegeuk@kernel.org, chao@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, huangzhaoyang@gmail.com, steve.kang@unisoc.com

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 13 Jul 2026 19:19:44 +0800 you wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> Our v6.18 based Android system is continuely suffering livelock and bad
> page stat as shown in[1] which related to broken xarray slot status. By
> investigating big folio operations within f2fs, we find below races and
> fix it by get the nr_pages before drop the refcount and folio_lock.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix folio_nr_pages() race after put in large folio invalidate
    https://git.kernel.org/jaegeuk/f2fs/c/aebfda7985f6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


