Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793279746;
	b=SCQCy7ZhIIrjzeZfxl8zHEM/fFkx+2oxCaRfUF4KgJA9dsvdD2fzweXoml8JeyxILz+q
	 6qaYpQW6daq1evoTIAzm8DPEEQzONj+kWFFf9Etxz2oYloLM5e1wuH60KEmwcxTAFZH0a
	 r7yJBF/9jtZUhbtKtJ13Pt7QaVxSLd5wIUjqN/EBvXcjf8U8Y0NrTqauLyOdqe/XSwNRp
	 PA2Aj/zVopU3bVOCIRP8zA1VbaacHCgo1JDFYYK++3ftBD+hx38SznVW5hVT2Osr3Xay9
	 /4Z70H6kwmotVEVXFWoWDK9vn7ugjLr2FcqRnN87mg/jy5jpwYL2G/EpfswnYUzruuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793279746;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:User-Agent:MIME-Version:Content-Type;
	bh=lqh2h9OdAhEsv8R7JgV92DMgdxSdmNya/U3mKn63VeQ=;
	b=EMwlC4pHLObymr2xfyeVD7/Qr4icU0WOlUB+LoGBCqijEl7uo9Rt5yWJfYziM59LZv6Z
	 A80+wd421hXs9yQsfOdjizy0brWCuJvZa08Jkb08NvJETNRdwGudUFc7s5n/B5UEp24R8
	 v4wCjZba9iZti1m1+dK/rOVfYDztkLLzZyNfFt2fjLroUzSgFdtc9YtJbet0OnmiBL8Yw
	 NlZGhjyi7o6x63Iwm5hRWkPLN8IahmUKDmtwKOVjsAJtnRqzZKyOmRdVC1mJQi6EDsks3
	 jO1leW4mlkVsEne2ibzNfYbQ0fHZ8qYuGjOz9llwLONszaXR+rgHHlaieiHTsPSX5BQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MmZFJDiu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05877606A31A;
	Thu, 29 Oct 2026 13:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MmZFJDiu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A98C01F01825;
	Thu, 29 Oct 2026 13:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793279745;
	bh=lqh2h9OdAhEsv8R7JgV92DMgdxSdmNya/U3mKn63VeQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=MmZFJDiu5p0O+/D6H9EcM1bWgs2P1sLao6pof6JMiCUbkuDuhoUnWvIYq6wdOTfbm
	 BpcdU9h8weFSI7YLOAuJPhsKw4Gi4YRQO5cUZN10fGi7ReIbYh9hagBT+jrYElX2YH
	 +ih3xGMrA3kLoEpG35T95VY9VY8CZ9PitTQpY1G0Ri8tbgIY4OEyb5lujXrodMB0ht
	 9mq4mqJBN5iSIEzqMYOWBi7auC6ctfTuZZc8lG2Ic63rca7gBPiLKOXjhv0fOpMgDy
	 ZaqKgfNBg3F6hiO66BQ6fFngZ+rT7A9j651kIkx8sefoDuBSSHj73PbusVG/D+GcyR
	 U4/gnsox7yWQw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Alexander Viro
 <viro@zeniv.linux.org.uk>,  Christian Brauner <brauner@kernel.org>,  Jan
 Kara <jack@suse.cz>,  "Matthew Wilcox (Oracle)" <willy@infradead.org>,
  Hugh Dickins <hughd@google.com>,  Baolin Wang
 <baolin.wang@linux.alibaba.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  David Hildenbrand <david@kernel.org>,  Zi
 Yan <ziy@nvidia.com>,  "Liam R. Howlett" <liam@infradead.org>,  Nico Pache
 <nico.pache@linux.dev>,  Ryan Roberts <ryan.roberts@arm.com>,  Dev Jain
 <dev.jain@arm.com>,  Barry Song <baohua@kernel.org>,  Lance Yang
 <lance.yang@linux.dev>,  Usama Arif <usama.arif@linux.dev>,  Kiryl
 Shutsemau <kas@kernel.org>,  Mike Rapoport <rppt@kernel.org>,  Matthew
 Brost <matthew.brost@intel.com>,  Joshua Hahn <joshua.hahnjy@gmail.com>,
  Byungchul Park <byungchul@sk.com>,  Gregory Price <gourry@gourry.net>,
  Ying Huang <ying.huang@linux.alibaba.com>,  Alistair Popple
 <apopple@nvidia.com>,  Kairui Song <kasong@tencent.com>,  Qi Zheng
 <qi.zheng@linux.dev>,  Shakeel Butt <shakeel.butt@linux.dev>,  Axel
 Rasmussen <axelrasmussen@google.com>,  Yuanchu Xie <yuanchu@google.com>,
  Wei Xu <weixugc@google.com>,  Baoquan He <baoquan.he@linux.dev>,
  Johannes Weiner <hannes@cmpxchg.org>,  Michal Hocko <mhocko@kernel.org>,
  Lorenzo Stoakes <ljs@kernel.org>,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,
  kexec@lists.infradead.org
Subject: Re: [PATCH 1/3] mm/memfd_luo: don't use memfd_pin_folios()
In-Reply-To: <auKJXHWnNMzju7cv@google.com> (Pasha Tatashin's message of "Wed,
	28 Oct 2026 20:01:59 -0400")
References: <20261027173031.763213-1-pratyush@kernel.org>
	<20261027173031.763213-2-pratyush@kernel.org>
	<179321872100.1775665.6881420026761127422.b4-review@b4>
	<2vxz4ie5o2ak.fsf@kernel.org> <auKJXHWnNMzju7cv@google.com>
Date: Thu, 29 Oct 2026 14:15:38 +0100
Message-ID: <2vxzv76kmyv9.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Oct 28 2026, Pasha Tatashin wrote:

> On 10-29 00:04, Pratyush Yadav wrote:
>> > Nit:
>> >
>> > I would suggest adding another helper, memfd_luo_get_folio(inode, index, 
>> > &folio), that wraps:
>> >
>> > - shmem_get_folio()
>> > - The !folio_is_longterm_pinnable() migration retry loop logic
>> >
>> > I think this would make the final code a bit more manageable.
>> 
>> Sounds good, will do.
>> 
>> >
>> > Other than that the patch looks alright, feel free to add
>> > Acked-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>> > Once the nit is addressed.
>> 
>> Thanks!
>> 
>> I think the MM side might take some time to gather reviews so I will
>> send this out as part of a liveupdate-only series. This patch is useful
>> on its own anyway.
>
> Sounds good. Could you also consider adding a patch to that live 
> update-only series to extend the memfd freeze from retrieve to finish()? 
> That would close another gap that does not affect us yet, but will once 
> other session fds depend on the memfd mapping.
>
> See:
> https://lore.kernel.org/r/20261022225035.377445-8-dmatlack@google.com

Hmm, right. That's a useful fix. I think I'll do that in a separate
series, since it can go independently.

-- 
Regards,
Pratyush Yadav
