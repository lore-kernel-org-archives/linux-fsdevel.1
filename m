Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795067694;
	b=ZSm/yObBCI9zmZvRfdFtSBUKEaUO2Ujt/FnMsHozDammEqALA8/yArquiSu2S19vPvmA
	 s0cPF6muMED+m5QmGeyB+3sBy30sWSZyt51aFDwpkexWCkgWq4uBdWJ0y+c5iBRZKBm34
	 AAwvMT06iLalrg7iS5CHvyjnZK2wnlu89TFqVZKZRQbB6UqV3Cvxz4mUpdAQe0X/PeLXW
	 pKIKcuaSSGuooMf+O1hivEkK5BscGce6K4lBEc7r1rfvoncL4DKp+6j63n6i7kHVsvXux
	 CjOl4jo8iMnuPLu8+xwtw4MuQimAF3BsnjGJvQ/3RNwY+g5Q8WcUuDyZKdLjaMLxDoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795067694;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=zFfnlyC81sGzZtiO2N+3qRscXbxSDBZT3Ouo++SYFZg=;
	b=000RRH9WYz7m6j6jE87wK2KDSAumg2506hOPvmMrr2onuG/1EainR9/ZUPFKk1b0d9uD
	 Ak4q7JltYerbJBeStAy7V1+/diu94J6FG+Am0xz3ZjmVtxVmyMIzLEwU/obL6Q/B0d9bZ
	 X+bNT5TLsTTtNOvAkI/eUEfur5L8+FZaJGJ6PW2DfeLA9FZCnVSGMOim+Bv7Ed8WDJsEs
	 KFNWXXJDgjmw0H+f8gekqVG96fJe+Ac866AAdtc0Pn72M4Dx9W4OjDns881ui4w9NhCE9
	 9qinhhH9p9HzRc0f8SJKjPTteeG/1T0Fg0u/TL5b8tkZyPPHpNvKJEe4mehOhzyoPEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=kcsVYwZN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7AC606A320;
	Thu, 19 Nov 2026 05:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=kcsVYwZN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D9DE1F000C4;
	Thu, 19 Nov 2026 05:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1795067693;
	bh=zFfnlyC81sGzZtiO2N+3qRscXbxSDBZT3Ouo++SYFZg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kcsVYwZNsGJrHyzeQz88vuyxBsb+6xOlt7YzUT5ObKKo8DXRRD9FG9sZ1OQoQOe+6
	 szu04sTc6GD6yOnD4Rph3/Dv7nQ+tkrOF/YpU/nYzlyiuLfYjb8oDgMSQIObQ324Ra
	 BNrXE5LTUAbJ5zQRQk09Ucg+TA352U0X5BJW9tMU=
Date: Wed, 18 Nov 2026 21:54:52 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: "Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>
Cc: Suren Baghdasaryan <surenb@google.com>, Lorenzo Stoakes
 <ljs@kernel.org>, "Liam R . Howlett" <liam@infradead.org>, Vlastimil Babka
 <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato
 <pfalcato@suse.de>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, ahuang12@lenovo.com
Subject: Re: [PATCH mm-unstable v2 1/1] fs/proc/task_mmu: avoid spurious
 seq_file warning on interrupted VMA lookup
Message-Id: <20261118215452.388e62261c6ad4c56a95f2f2@linux-foundation.org>
In-Reply-To: <20261118103421.776-1-adrianhuang0701@gmail.com>
References: <20261118103421.776-1-adrianhuang0701@gmail.com>
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

On Wed, 18 Nov 2026 18:34:21 +0800 "Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com> wrote:

> Commit 5631da56c9a8 ("fs/proc/task_mmu: read proc/pid/maps under
> per-vma lock") introduced the possibility of returning -EINTR from
> proc_get_vma() when a fatal signal interrupts mmap_read_lock_killable().
> 
> The issue can be reproduced using stress-ng's VMA stressor, which reads
> /proc/self/maps while concurrently modifying VMAs and periodically
> terminates child processes with SIGKILL. The reproduced command is:
> 
>   # stress-ng --vma 0 -t 60
> 
> When the VMA lookup is interrupted, proc_get_vma() returns an error
> pointer without advancing the position index. Consequently,
> seq_read_iter() emits the following rate-limited informational message:
> 
>   seq_file: buggy .next function m_next did not update position index

Thanks.  That's just bad behavior.

> Save the current position in priv->last_pos before checking the VMA
> lookup result, allowing it to be reused by both successful and error
> paths. Advance the position index when returning an error to avoid
> the spurious warning, while preserving the original error handling.

So I'll add a cc:stable to this, target the next merge window.

