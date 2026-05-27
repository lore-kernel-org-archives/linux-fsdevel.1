Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019FD2C0285;
	Wed, 27 May 2026 01:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779846587; cv=none; b=R94uwQs4UcloEW3kza4lvgvjnG8RXNfwK9m7Ukt3pVRGgzRozSz6pHe9RvcYGhKeJYwV284e1bdgrLkxXeR4nYF1Qq+cUSUp3qfz6ODoBrMGjE/mBQ+9Nc1ZcIPS6vcxDtIIilgE2dAfdZLiBW5/MRGvR+hh0GcGZBogZf55zHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779846587; c=relaxed/simple;
	bh=OnRb35zsOkFRW/CWmv18Wy/NJmcehYUJoAIUg83Y5G0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=f18Mh5WqHUizQLAJCywcEzJjVGbvcOPq4pOIBwxhYSWXx5KLUASfkRaImxzs3Ki109SRGyecRIpnRtbbBmQV7XwoEdkhlCP6lWCm58YzcwT5Bx4Q8qo/9k4E7VduPWrHuKE2vI2xu50uGw8nkOG4WEjC1yl9gRUuenCy161cUpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QJeYrvmY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QJeYrvmY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F42E1F000E9;
	Wed, 27 May 2026 01:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1779846585;
	bh=RQHn0lIESMVrKtDroCt10TOS7riOoU6PCqbNq2RdkAw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QJeYrvmYIXlRgXJqbx2m87Z2F6eVrL4d6nmkeXmTxP+bjQnHFWIWAi+Maiat5XOcW
	 tO1AzZwFe4aVT2grsG0L1uOza0ONm543/qk70VhANXMcH82Q+9Yxp/XNMr1botqiD0
	 QG3usvJtyuOKWb2Hbiirgtj5Lo1s2kEvJi/RyGnk=
Date: Tue, 26 May 2026 18:49:44 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, liam@infradead.org,
 ljs@kernel.org, vbabka@kernel.org, willy@infradead.org, jannh@google.com,
 paulmck@kernel.org, pfalcato@suse.de, shuah@kernel.org, hsukrut3@gmail.com,
 richard.weiyang@gmail.com, reddybalavignesh9979@gmail.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 0/3] use vma locks for proc/pid/{smaps|numa_maps}
 reads
Message-Id: <20260526184944.18c28d6980fd29ff12fbbe22@linux-foundation.org>
In-Reply-To: <CAJuCfpHPs54_hc_U9DCxtv=xikKHJMtqCEDN_4Y5aDqKhoBDnA@mail.gmail.com>
References: <20260426062718.1238437-1-surenb@google.com>
	<a27344e1-6f0c-4686-99ac-fc2cfcc5bb06@kernel.org>
	<CAJuCfpG3xZhL94E=yR1KsWs6fVwcdoAECoOaV3UOeB10TXmOeg@mail.gmail.com>
	<0ce6071b-0c99-4119-9ab4-a2d9c00b99a8@kernel.org>
	<CAJuCfpHPs54_hc_U9DCxtv=xikKHJMtqCEDN_4Y5aDqKhoBDnA@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 May 2026 08:16:01 -0700 Suren Baghdasaryan <surenb@google.com> wrote:

> > > It might be but the point of this patchset (and the previous one that
> > > made a similar change for /proc/pid/maps) is to reduce mmap_lock
> > > contention, not to speed up the read operation, which is not a
> > > performance critical part.
> >
> > Well, this interface has been around .. forever, so if there is a noticeable
> > change in performance it should be called out.
> 
> Sorry, I missed your reply. I'll see if I can adopt Paul's test for
> /proc/pid/maps [1] for benchmarking smaps but I would expect similar
> results as was reported in [2].

How's it coming along ;)

> [1] https://github.com/paulmckrcu/proc-mmap_sem-test
> [2] https://lore.kernel.org/all/20250719182854.3166724-1-surenb@google.com/

I've moved this series to the tail of mm-unstable to permit more time.
