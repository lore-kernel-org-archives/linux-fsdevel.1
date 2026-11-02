Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793638888;
	b=OSKn2M6TSs1A5DJV1Ykd+5AHAg+LFadI3R7loY4mRhUerKc4yjTCJRkyLAKruckoCwWN
	 9cjyKYAsG/h5/b5AcrHvJP7YIlxhf3QA3xAHFz6FZ98hmEGEdm+6o8LbBCnNvFHyL0N0A
	 FydRfNNXrYOnMsS7/CA98GRTQCn+jtjxKe87S2cpTXEOalIHPO9EOgqgPwt++VsRiMXM1
	 9gDHnkD73EYJkvfqMqF4T/xYr2YPOqJaDzJtOSLsGlbarDMXlMYlThESSny+rqFLTn9JN
	 PS4TCtuB7s79R5oTig04q44gx5iMo1tvW05nwL+34HwbrS1mHjwCXhadGvJ+T8S15wA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793638888;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=+xlCuFW4BIdyvGbWkDK951R/f+P6HkIlEKcshLrzgjM=;
	b=lpP29P+Tst94ShWcmvU1MFzM8IfiEUA9+0JAgusN9B0H6dRhzhi5dbLfYkzIESbPp4Am
	 c2cFKPJjmKoeaW1v6/6RloPpYOpNbtHoBuMnzl1HQdIH4D+QTnwMec56cXJNiLiF/IWD8
	 qo2qpOKjwqTizNbw4/D+KoH5NFG30F7cOLqmOzeqlIkBk0qzjT5rdrzTTRaWlsVyY5KN/
	 0f5ER8xOLDI0RhdwVoQmp8CALoIZ982r+rQnNa04nAxoOa3Cd6u88ayOe3sAY53Onmk37
	 tomrCzqVrAfTD/j3YSk37huETjKDbj1dPunHBJkKJEHkKccsgVKUv+IXbQsETC4qw1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=e0ZE9RsX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF0C606A5A0;
	Mon,  2 Nov 2026 17:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=e0ZE9RsX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA9631F00A16;
	Mon,  2 Nov 2026 17:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1793638887;
	bh=+xlCuFW4BIdyvGbWkDK951R/f+P6HkIlEKcshLrzgjM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=e0ZE9RsXfTdB+4O5FQ/6CDsY3bXRZfOhxecWF8GzYYr3tpzXrvSLbj+suWLGRM1Tf
	 rqqSZ28gGD5ZmMsKjvNiCSjp7tq3dHTO7b/7jCTA7uxRIvBZzkp73ah1th+rsG+xdt
	 YQ1LCOTlWQ5P9SBshPhZGVl0PpLQvsx7pR4vDCCY=
Date: Mon, 2 Nov 2026 09:01:25 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: david@kernel.org, ljs@kernel.org, jannh@google.com, liam@infradead.org,
 willy@infradead.org, paulmck@kernel.org, pfalcato@suse.de,
 usama.arif@linux.dev, vbabka@kernel.org, linux-fsdevel@vger.kernel.org,
 yi1.lai@intel.com, oe-lkp@lists.linux.dev, lkp@intel.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] selftests/proc: use RSS in
 /proc/pid/smaps_rollup tearing tests
Message-Id: <20261102090125.58a2e80d1669c681c33ed20b@linux-foundation.org>
In-Reply-To: <CAJuCfpGwZqGkOm25=BWAh2QgA8Y00OUmwxsDU+_qOsVsc+KHhg@mail.gmail.com>
References: <20261101154503.3203036-1-surenb@google.com>
	<20261101110100.90796bf33ef50307a7698dca@linux-foundation.org>
	<CAJuCfpGmPLBRhHa_dmyP10QzyRyvcWMYDLU0+J9t-RCLBsTaWA@mail.gmail.com>
	<20261102080103.6e3f602364747ac6adb13f5c@linux-foundation.org>
	<CAJuCfpGmHWiu0Hmob-PgnvWAMn=CD0-xgiyGztP+P=OFrwwfTw@mail.gmail.com>
	<CAJuCfpGwZqGkOm25=BWAh2QgA8Y00OUmwxsDU+_qOsVsc+KHhg@mail.gmail.com>
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

On Mon, 2 Nov 2026 08:15:47 -0800 Suren Baghdasaryan <surenb@google.com> wrote:

> > Ah, I see now why handling READ_IMPLIES_EXEC is needed. Then your
> > complete fix looks fine. Perhaps we should mention this pre-ARMv6 CPU
> > detail in the changelog of your fix to explain why READ_IMPLIES_EXEC
> > is important here?
> 
> I guess I have to ask whether you want to post your fix as a followup
> to mine or if I should fold them into one patch and post a v3. What's
> your preference?

yes, please just prepare a v3.  I don't think bot will be offended.
