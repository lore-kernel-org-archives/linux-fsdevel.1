Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D31B35F197;
	Tue, 16 Jun 2026 20:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781642868; cv=none; b=old0ysisw52ZfznLfroEgSFpgQ8NpLntpD587bzK97oyw8Lhw8GKgtOMcrnhiB8H5UNlXjK7WQmQq22lPGF0rLfOZgLsvoaLVi2mFdUJJUKLKf56QmGGEX/3mcNRrc8GZ4NMc73VOkzdBcbfEZEVVMqBsusP1I/38XM64Jc8cLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781642868; c=relaxed/simple;
	bh=fa7Y3qx6gblR451C+xwmA06qp8aBTIQpJLG39CEKCZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IkZTP4B3YF1fRDJWJvedAlvwRyu99WzCPqU8WK5aZSd7x36O8eU1Dao2hsfBYKn8vKwztbKf2apbTliWyJfU+tfZyxx4vNEe5JF/cAgWzgfP2jxcGtIRUzirXviFjbhFA+w60Oa5GyT+LPFGkR/e+I+jo1NqjhC1UoSZAOs4mGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshtriplett.org; spf=pass smtp.mailfrom=joshtriplett.org; dkim=pass (2048-bit key) header.d=joshtriplett.org header.i=@joshtriplett.org header.b=NvU2MT3U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kJiR7r/+; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshtriplett.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joshtriplett.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=joshtriplett.org header.i=@joshtriplett.org header.b="NvU2MT3U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kJiR7r/+"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 3E3F11D00045;
	Tue, 16 Jun 2026 16:47:45 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 16 Jun 2026 16:47:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	joshtriplett.org; h=cc:cc:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781642865;
	 x=1781729265; bh=fa7Y3qx6gblR451C+xwmA06qp8aBTIQpJLG39CEKCZA=; b=
	NvU2MT3UMdzRuW3e0CLzmi4tt+7s5v3E+B+KSQvNeAYKsj/BPBIA+t/fJ/5f8sy3
	okYvG51r6LhXw0ElImBGpaAirrsRZfgorv34V/BSLbGPNmKlRhAYm5JA/mojXjMG
	/VLCcZrajrue+z9b3jEbm7APOQ7C7bJYWYkWMxQITegUUImSFmnkQQIVhKQcG9Jz
	Xgseo1mLklOgJoNf43FkEY4nwIYtjHmuOqn77QvDNAXxy+8vRStB/nmADlZ1/l79
	0aHx2qKJmQEJqh6AdNzWE0DTZ0HG4KbQcGrFAq+Rni+92xqrI4xzPpUuy/q4CUZV
	LsFEX55mN1n+i+VAXnPzbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781642865; x=1781729265; bh=fa7Y3qx6gblR451C+xwmA06qp8aBTIQpJLG
	39CEKCZA=; b=kJiR7r/+KpxVNHRyx/xX8JukmSxkSvjLisQR2PxWBlCcr0p+TpZ
	hQtjEoYqO1u+ASZfvXqZfm9dIlAuN/orVfpnsoifYJjAfU/GtZXVTAjvrT89cmge
	NoywETGDbDP67cRpAB100TB3aPBSBZE701WEIBvsRR1f40u+waxZ0NoC3EH745f1
	is8o9V1/SsQ9+/orZQuo0FIrEYqdGH3dlX6uP5gb1jO+AUq/hjVCsmW4wuDtXGGm
	sml2KZJmlkcPNf1az931ZIpm2lwvkq8S541ywDfeeaIgDIYtAcO2SBxg4vXt5e7A
	hK0xjifDzbw0/NmgfWAOj7N7B1szyXD9ITA==
X-ME-Sender: <xms:cLYxaiVS2VEGkPnvPaxHVVic5171kqh55MUckedxPuIy7_DziC_xcA>
    <xme:cLYxao9MpnDsXCPOWQaSx61QKnu0L_0TOAj7mIT8D9HSwulE2rgWm7HyPICFBCZy6
    Tv86Zo5XBdgq4zQr2NFFjgqEzP01NFafVt7iG5biFC0B0znPCaqmg>
X-ME-Received: <xmr:cLYxasiyMaJWK-dvJ2aFCFciSzjzO8CKg9RCoIePy9Y62E3spc0MFgPWhg>
X-ME-Proxy-Cause: dmFkZTGkKVs8VRXq2x/QRQMoEoqcUcoTUcJT+jdduJpS5EJcJJXm/nxwKzJKHI52Cuet39
    ltx4/+ev+PouJ6vAj02W4UN7E4pWTZwvPXyMOaFSnxulyM7UnhBwYdnec2rFITtr8ZjYO0
    5nTTMPyA6Tklaho60LobCf3cqxlCG6VnmqO0TB96TitMGTlXjg4IcNaH9p6HUZouBU8ID0
    CPHg6O8+QOtsmCdPO3ZlJIkScsA0P/ee5Z11Y3w4N48tPeSyI1Z8T3LpJeNQ1r5xYn+PMi
    2t7T0vNzvVHaOOOcde9rxfurw/o9aiFvVj2L2vI0VZ7ixKGtS++b8a7zu2eyb9cF8yQoGH
    gSQtqDTMvISmMkOIm8kHgUE1vnL951h2ONS5PAc8g7GBVidoEEtz2veqy2WRLIEMoqvbIB
    vECD6qTEWNk0RIPbLyiQc2WnWRjQ6HJTWGMq3EAiqRRUVcHvYhjhNMhZnkmkuITWW9kZUB
    58aU9oHSyJDVs52MpWdfERKPOLs7iOP3LxPObRLx8J6+GbmyVjf5w/kQfaV8+wWQ4nJ4GV
    MfgiMv/L7I8J0cespzn/2xFu0oBuhq5AEkiDleDsitradTYtBHq6Co5F1gzeB4yMbGZXnw
    hbBxveE4CQXw3eBJ+zIyg3dEkxTJEcmDlNA/8zoZbQ/slgnpkNPd79w7RMgA
X-ME-Proxy: <xmx:cLYxakfzjxHFNiP-wvKJRerJAoYt4xRp4KLsL3IcX0rNZEXQGyL3sg>
    <xmx:cLYxalJkezpXIqdEJkwveaipFZ5-0klQkUe0ZlTPHC0hOg7LWE2n2w>
    <xmx:cLYxahnW7Y2LuI6TJAv69FUaUpg7gmvSBm-_8mVRhFPaTf4ZkMBjpA>
    <xmx:cLYxatcOjopzmnwbybUR23odF4w8aL1xY1Oh663mBaO0xEwHIXquFw>
    <xmx:cbYxav1Xb87qQ5eh8EQkjDNMT-ucWbrVJt5CkpO0pMBwu3yEmmiuIDNg>
Feedback-ID: i83e94755:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jun 2026 16:47:42 -0400 (EDT)
Date: Tue, 16 Jun 2026 13:47:42 -0700
From: Josh Triplett <josh@joshtriplett.org>
To: Breno Leitao <leitao@debian.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Shuah Khan <shuah@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, shakeel.butt@linux.dev,
	jlayton@kernel.org, oleg@redhat.com, axboe@kernel.dk,
	kernel-team@meta.com
Subject: Re: [PATCH v3 0/2] fs/pipe: reduce pipe->mutex contention by
 pre-allocating outside the lock
Message-ID: <ajG2bmhu6j9UWvh4@localhost>
References: <20260524-fix_pipe-v3-0-bb4a75d23a90@debian.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260524-fix_pipe-v3-0-bb4a75d23a90@debian.org>

On Sun, May 24, 2026 at 07:44:57AM -0700, Breno Leitao wrote:
> This series pre-allocates pages outside pipe->mutex in
> anon_pipe_write(): for writes that span more than one full page, up
> to PIPE_PREALLOC_MAX (8) pages are allocated via a per-page
> alloc_page() loop before the mutex is taken. anon_pipe_get_page()
> then drains the prealloc array first, falls back to the per-pipe
> tmp_page[] cache, and only enters the allocator under the mutex for
> the leftover pages (writes larger than PIPE_PREALLOC_MAX, single-page
> writes that skip prealloc, or shortfalls when the prealloc loop
> fails). Leftover prealloc pages are recycled into tmp_page[] before
> unlock and any remainder is put_page()'d after unlock, keeping the
> allocator out of the critical section on both sides.
[...]
> I also vibe-coded a microbenchmark to validate the change. It sweeps
> writers x readers over {1,2,5} x {1,5,10} with 64KB writes against a
> 1 MB pipe and prints throughput + latency percentiles per config.

How do the numbers compare with 1-byte writes/reads? (It's fine if
they're not *faster*, just want to make sure they don't get any
*worse*. This case comes up a lot with pipes used for synchronization or
event reporting, such as with make.)
