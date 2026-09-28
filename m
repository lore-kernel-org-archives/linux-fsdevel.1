Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1424D3D9540
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2026 19:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790622756; cv=none; b=GuxLY9wyph47af29GaZaB0BGDEukjxScuxf8o24KXTkNXua0Xr0YemNG68lhPRrJd3BHJTFLKuinuQX8ASzFX+RODf45SuReMxcHoiMYGEgrEkJCIAWzXdS65dNq6Efj78oMV0qqVhiXYBwpqMnfUGiYk7IcjSp4RSD3s8zEKjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790622756; c=relaxed/simple;
	bh=bRSdQjCyV5tSJh7453xUdn38fyIT36XliIQQvgY0gqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XNgaTvY8gbko8gwZ1+aLeOdBOiGbdz2JBkcxWMbyKiLKeetDUUsrdIFRURK+N0AgYyoLcvCeGMeiuoOSUIo227vgLBH/0bkU5ihVFjMiGuUvaTPtqfQMDLlNZr7vrthvLkP+mnoAFJblZ0Psffx5QzI9eE7nq7sIlcF0HDRlC/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HF4S1Z78; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HF4S1Z78"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 342441F000FF;
	Mon, 28 Sep 2026 19:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790622754;
	bh=3+/0gNUnAEU8rNmsasP2G1qveGjqqxqRYFGhYDQK2wU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=HF4S1Z78mScB4lUcYE6JWgmNHRRxIQxkpRj14G/OgV77GYc4NE9XRSxU/WrA7/o8T
	 jHkuFt25YUOT+mG7iVW/hfP8bxMYMWq+WXAe+owB06S0SeE7wPQfrkwVXLE/DAcWtM
	 ARw16ifk79EF7PM9ra6qxCAQxqKbrhfgbt8qls/bYL6rB77cjM4/+zlUULjLLBP+6h
	 LFlEEaVZ0FA6vtFPLORpsHWqiw8cLu9tB3uLGAvnMpvEPc5eo9P2DMndfHhT7A5ikY
	 TB/6cHvErfozrqwxtPPtJqT7/S6cCELTRktjxG3EPzSnTXaoCjxGwaMJKZBMkp8Q/E
	 RSAYk6NBbI7bw==
Message-ID: <85aff663-2131-47da-ac04-8f0799a49b91@kernel.org>
Date: Mon, 28 Sep 2026 21:12:30 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] madvise: best-effort deferred writeback for shared file
 mappings
To: =?UTF-8?B?5aSp54u8?= <rockeet@gmail.com>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 "Lorenzo Stoakes (Arm)" <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Jann Horn <jannh@google.com>
References: <CAAE3jtcL_CZJdcattCwe0RraKnHcZO=UknxEUQVG858ouZCUQA@mail.gmail.com>
 <7ebe4591-2306-4b5c-b83e-6a2e34b52bd8@kernel.org>
 <CAAE3jtfeKJLSypScqRAEEgvO8En5kJfpbcFn5X+LQ2YL+xz_vA@mail.gmail.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <CAAE3jtfeKJLSypScqRAEEgvO8En5kJfpbcFn5X+LQ2YL+xz_vA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/28/26 15:09, 天狼 wrote:
> Hi David,

Hi,

> 
> The use case is a concurrent, lock-free, relocatable data structure that
> uses offsets rather than absolute pointers. It implements copy-on-write
> at the data-structure level and is designed to remain recoverable after
> a process crash. We therefore build it directly in a file-backed
> MAP_SHARED mapping, so its state is not lost when the constructing
> process exits unexpectedly.

What is supposed to happen if the process crashes when updating the MAP_SHARED
region halfway through?

It would be helpful if the use case + data structure would be explained in a
bit more detail.

> 
> Building it in anonymous memory and calling write() only after
> construction would lose that state if the process crashed before the
> write. It would also require copying the entire structure into the
> file's page cache.

Yes. Unless to would try to bypass the page cache of course (if possible for
your use case).

> 
> During construction, writes are scattered throughout the mapping,
> dirtying pages rapidly and repeatedly redirtying pages that may already
> have been written back. The goal is to reduce writeback of these
> intermediate states while retaining the same page-cache pages for
> subsequent readers.

What exactly is the poblem with writeback here? Unnecessary I/O? Is writeback
the problem or actual reclaim after writeback?

(I recall that in a fuse server you can in theory delay the writeback request.
So maybe you could get something going by serving your file through fuse and
enlightening the fuse server about it. Just a random idea.)

> 
> The hint would remain strictly best-effort: memory pressure and explicit
> synchronization could override it. By "process crash," I mean termination
> of the process while the kernel remains running; recovery after a system
> crash or power loss is a separate durability concern.
> 
> Regarding the interface, madvise was only a suggestion. A file-level
> advisory interface would also work for this use case: deferring background
> writeback for the entire file, rather than individual mapped ranges, is
> acceptable.

So fadvise would be an option. However, this "defer mode" is really odd. It
sounds more like you would want to have a custom policy there, instead of
hardcoding something that really not a lot might want. Hmmm

-- 
Cheers,

David
