Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794537448;
	b=YrCQcebi9V4MKNFZ+ID4w671ujzNvKGTvtKZFGh+Fg4a/pF9Ifc72dKwsJXVKQSsncii
	 bIGyfGdkxELeYoq8RImSEnwaaoipH732tgvdRm6y4Y4dZQO8pIY5yaWJ6fRrpH0RjJlgc
	 AJl1IcrM7+VlZvYypAUlo/Ry3vWYJaySp5511sSSVoKI60J3WLR1nO0X6fo+E1jiBFZBK
	 cBiVZ5e32PRJQOLpRvlvWmWugvqmdjuumx7joPZptYfilIgLv+tpYEaExibwkcs2UWqg8
	 snWuS0foYeV6aBMMMhK77CZgNRtG+OgauJfppxlZL57c5k3sXHnZvQTF0VFGVWLOqQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794537448;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=c7xVO+NmGklllKi/pnNJQ5f6BZkQyZyz+72UU6VKSbA=;
	b=UCsf9yzVMzQvbu3Rt0M06tV+e4POlPCUQhcDEhPamean/wIFAdquKiwFap7chiTptUdr
	 WV7Xn1dI6OPcO9aUgz6VSfLcFns2MRAlXaGCafZAhrBow+4qMNw0V+96P3fxusu04ieid
	 N3/MMwnfWrUwaIw6Yfje/jBJQG1Ahl5V8aFuA+cmTCm4gWSfOD1Qm7DMfjRCtXkx3zfMv
	 e7XDduMEtaAC3oRc3frcHML2U0+1izfqGTPmi24O8+m4cFVBg+Vda6p2AOi08YkUagjA3
	 Tv4pujTBFjVhfswoNbACEZHYRHfs4m83anJKsFXe9bQk1V4h7A4hr5h35ess17I0Aog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=HDvZ6ex5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0C3606A31C;
	Fri, 13 Nov 2026 02:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=HDvZ6ex5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D32821F000C4;
	Fri, 13 Nov 2026 02:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1794537448;
	bh=c7xVO+NmGklllKi/pnNJQ5f6BZkQyZyz+72UU6VKSbA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HDvZ6ex5mndLiwSybBItN1+QPlX1KOoZqAvJ+RsPkPLPX828lEASG07GMcjmVOP7w
	 wNOxlWkKtT+wuid9MBOoC0w06gT4wqs6y4+6qvmSIIuoUH6VfKZ2f9WPXChjWfM5uH
	 h4QCONLhbPu7nyc6ogBQJGTRB9wYoKrq3vJmHaHo=
Date: Thu, 12 Nov 2026 18:37:27 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: "Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>
Cc: Suren Baghdasaryan <surenb@google.com>, Lorenzo Stoakes
 <ljs@kernel.org>, "Liam R . Howlett" <liam@infradead.org>, Vlastimil Babka
 <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato
 <pfalcato@suse.de>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, ahuang12@lenovo.com
Subject: Re: [PATCH mm-unstable 1/1] fs/proc/task_mmu: advance seq_file
 position on interrupted VMA lookup
Message-Id: <20261112183727.68afda9533aff699eea12cdd@linux-foundation.org>
In-Reply-To: <20261112140101.647-1-adrianhuang0701@gmail.com>
References: <20261112140101.647-1-adrianhuang0701@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Nov 2026 22:01:01 +0800 "Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com> wrote:

> Commit 5631da56c9a8 ("fs/proc/task_mmu: read proc/pid/maps under
> per-vma lock") introduced the possibility of returning -EINTR
> from proc_get_vma() when the VMA lookup is interrupted.

OK, but what's causing the interruption?

> When this happens in m_next(), proc_get_vma() returns an error
> pointer without updating the position index. Consequently,
> seq_read_iter() reports:
> 
>   seq_file: buggy .next function m_next did not update position index
> 
> The above buggy message is reproduced by the following command:
> 
>   # stress-ng --vma 0 -t 60

afaict "stress-ng -t" can send SIGALRM, but mmap_read_lock_killable()
only responds to fatal signals.

So please clarify: exactly what is causing this to happen?


