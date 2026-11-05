Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793868390;
	b=zGae+pogu/2i3DfvNeqnglYM6ZaQs5QvXe0dwYHq+v9qWBXiA56nG/PUbHvlN9kDjacu
	 8L2JPsLVfA/mtEMcuTlSlAg4uOla935/8DUW2VbagMpA5MHqz8AtmcvdCab+uEkbQ5zyK
	 r5grOO7JdPSK2ppuIWZ1wy5jh8C7e6e+Y7dgX3T9cVTyeVu/XsOfTGOkiGVGgl4lfwNHK
	 GVTuO6JoshZtUUS6tqMvY3JvJDaG6xm03vJiEH6e4rbuaQNnsvwpp4SM8LVJ6b99aFaLT
	 iHaJJ8D/r/DMvuNzZgmjLdc9XwBbkCN8YFRhlQ0/y/4wNJI88KvW1tINyFJWYfrZFWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793868390;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=wmBeefEXaw5O44dRo1dUAqRZA0IAtNk7Ok9Q/ObhDCE=;
	b=JF2MjHqfeoj/HRsGXCFLpSXVflwmNBhJWAGsT019HnsdOR217Hbz6q4aEWYFITpg7CYJ
	 0VxbjNnJ/esCm3TTA0dGmEZY4iq8VVg9pe2CC4OVocF96xzQ/VY44BSokelX/I6P4BPtJ
	 tYEJvCrS/gkwiOJlBmY3MeWg0vCrxW6B5716w/J+oW7UzB1FDu2DlUWTDudVcg1YcnQYd
	 5CKvTUTaBLVSZQ9fIIPvLv7Hq9YbqTKMma6QG8NDBSZ3RCeh7KC0o4NTMw9jmeTP+WPqI
	 Wch0gj2vfXiTO4517qQYZh/6GOJj/+gAqV/qNXooHNURAIjeVWrOEiw+0GXEH5MxB/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E4P0MDK9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97ED8606A31B;
	Thu,  5 Nov 2026 08:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E4P0MDK9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8BC61F000C1;
	Thu,  5 Nov 2026 08:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793868390;
	bh=wmBeefEXaw5O44dRo1dUAqRZA0IAtNk7Ok9Q/ObhDCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E4P0MDK9oN1/bYIZaX+CzCBXo5968WnoaZcub1+UXlBhsOk4JvcS+2O9hQfyoHN+C
	 nsOZJM2T7NEX4I5rKnnu9nSOAlCeujUJ8XS7+h6mjPEQ0cMh2HKBXNDqxDBjBUqNMj
	 s9gAsnVjS4PB4U6brVXo52unIJKr4VIZ3OHfcQo0bK9kbI7nD4XMNu+6XCZbix+I+c
	 JCdoLh856Jj18QapogrDVNejW/EDh1TvbDZ428C4IuMCztSOUvPEpA5caEFAGKu7HF
	 c+Lt6ud85OpidUoluXjrPSX/nj0B81QXe16CAS8rsUX22ImGmgOvjHXNTl1ua/hS4G
	 MSMgtbAH86ejw==
Date: Thu, 5 Nov 2026 09:46:26 +0100
From: Christian Brauner <brauner@kernel.org>
To: Hao Ge <hao.ge@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2 01/51] alloc_tag: don't remove /proc/allocinfo
 under the codetag module lock
Message-ID: <20261105-beigaben-anmarsch-wortreich-8c117c8ef23a@brauner>
References: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org>
 <20261104-work-procfs-bugfixes-v2-1-021c84d852e0@kernel.org>
 <fc4939cc-84ec-4c5c-88a7-658ca800377d@linux.dev>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fc4939cc-84ec-4c5c-88a7-658ca800377d@linux.dev>

On Thu, 5 Nov 2026 10:15:13 +0800, Hao Ge wrote:
> is this a problem you have hit in practice?

No? For alloc tagging it might be reasonable somehow but 90% of these
problems I haven't hid in practice. But they're all reproed.

> I previously sent a patch with a comparable idea, though Sashiko remained unconvinced.
>
> [patch]: https://lore.kernel.org/all/20260817062726.106511-3-hao.ge@linux.dev/
>
> Could this patch perhaps wait for mine? No worries if this is inconvenient.

I don't care. We just need to keep straight what was fixed.
