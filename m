Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597F53B83FB;
	Fri, 14 Aug 2026 19:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786736165; cv=none; b=N4vECsxS7a66icx/xKengpMtpoIYlPkciO2ab+3mMlJOqCkbkkLa8QrDGxf0e2ta/keIZoEe54XigOuFkQtTeOB1PKoABCDt0z40ZsAqckDnA9eJogXZ1g2oY8345J6gNfBVkBo9xpx7BfuVnG68eAhHiGmpJmLtI6KntadjjZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786736165; c=relaxed/simple;
	bh=0+fpWLXcCQjyvl5uWxhwicZ9WNr75PBg37JYhG6N/KM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=IrfJ7/sCIu5hhVdZFRn9evwKhXb7o82SVmvTnG/U6n/CRxVusEfL3Zbc+CEEmEJAeCrL+YW3R1iIuxf6gsYqYCeF0+ULql9U8fR+Spn2cmeRSBw4xpagr2EwsLvkf+xL/lb5pYpuEDZkKRP66aSL+DijkpcjOoALb2PzSOHKADY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=zsEUWF/0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="zsEUWF/0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E84E1F00A3A;
	Fri, 14 Aug 2026 19:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1786736164;
	bh=KKwAleIaodXfr5GwDtgKufR0JVQd9KcvNehl9elNtAQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=zsEUWF/0Y9lojY4C9wCl1hw0plqXyVIDHIsse6N/FsDveqQckboWTj+GtXdIYuCZn
	 tBx3oSkVKw4h185rGmgJQV/4H2XM2XOYyp5v7AxiJC45sMERSpx309sdsfokPbxJAd
	 NTxkvJf1zA6kvXeJnSfPetyPWx15B4c5XZRIORmA=
Date: Fri, 14 Aug 2026 12:36:02 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Joel Granados <joel.granados@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Shuah Khan <shuah@kernel.org>, Jianlin Shi
 <shijianlin11@foxmail.com>, vbabka@kernel.org, hannes@cmpxchg.org,
 surenb@google.com, mhocko@suse.com, jackmanb@google.com, ziy@nvidia.com,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 0/4] sysctl: Disallow partial updates of
 miss-formatted sysctl vectors
Message-Id: <20260814123602.ec6889355580da96958b79d6@linux-foundation.org>
In-Reply-To: <20260814-lklm-partial_ctlvec-v2-0-9df50d26e477@kernel.org>
References: <20260814-lklm-partial_ctlvec-v2-0-9df50d26e477@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Aug 2026 12:41:11 +0200 Joel Granados <joel.granados@kernel.org> wrote:

> What?
> =====
> 
> Stage table->data when writing INT & ULONG ctl_tables. Commit staged
> data to kernel variable only when all the conversions have succeeded.
> This is applicable only to variables that represent a vector; paths
> pertaining to scalers are left unchanged. Notice that partial updates

"scalars"

> can still happen if less than the size of the vector are passed and
> correctly formatted.
> 
> This is the behavior we are protecting against:
> 
>   # echo "4 4 1 7" > /proc/sys/kernel/printk
>   # echo "1 x" > /proc/sys/kernel/printk
>   -bash: echo: write error: Invalid argument
>   # cat /proc/sys/kernel/printk
>   1 4 1 7    <- the write failed, the first element changed anyway

I like the change.

> Why?
> ====
> Allowing a partial change to a vector after returning from an erroneous
> proc_handler is just plain wrong. This should be handled within sysctl
> to avoid users having to do it for themselves [1]. 
> 
> Behavioral Changes
> ==================
> 1. A failed write will not update the vector
> 2. Vector writes can now fail with -ENOMEM

Yeah, this improves Linux.

> Testing
> =======
> This went through regular sysctl kunit and self test. Also is posted to
> 0-day.
> 
> I always find it difficult to know who wants to receive this. Please let
> me know if you want to be removed from the Cc/To.

Sashiko said one thing:
	https://sashiko.dev/#/patchset/20260814-lklm-partial_ctlvec-v2-0-9df50d26e477@kernel.org

