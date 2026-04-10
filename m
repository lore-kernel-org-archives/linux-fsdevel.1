Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178DB2E717B;
	Fri, 10 Apr 2026 13:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775827762; cv=none; b=XNj9S/P7G5oLp+kR1b8muLvrdMT1R/8EuLRBqTPNCrKBLp20wcaINqqUhcI+5GKo7kHU9xeWRf+RPtgDFZ6rkP1EGiu6C15SjqqFHFi3yNHrMKLZ8T5OLVPyb911H1AgdJYOuCYE4iZbexl76HApfVJsBusAECv4zBD3gE6XDNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775827762; c=relaxed/simple;
	bh=BGTVhOVa+Fdq7E52HiKwBfIFKgu77QwjCb2aXOQf+Ws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fwSuYwwIg/iSLjkgjZgFwXjH+GHPsWqwu2yFDpl8HtHvWps4uWpBPb3vc7ItfeJ6p5ouJRGxcSvBTeslL+um4cxe3BokyxmDpKDbG0i7p+mNVxN0CbLdYGQFl2tiZ7UYiU24BGtzvOuDBYaUFlyphMiQGJpYHFPK9j79mtrmaD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lz3e7crt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lz3e7crt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347F1C19421;
	Fri, 10 Apr 2026 13:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775827761;
	bh=BGTVhOVa+Fdq7E52HiKwBfIFKgu77QwjCb2aXOQf+Ws=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lz3e7crtUJ7MuP6SM2Vx3dNuc7GOeW4ksMX1JVpBZY0vOH3PfyBr/8ho2CDhwu9nm
	 ojGoibQSGNm8/3W2av8EBOabOBZdX0DPf4dmTgWp1beeYIK03Q/pUKcx0LYuE11fgu
	 kDGFZ4Bof7AAQUUtXjLoycQKPFY3ZLvSDzMQxRnPLUut0+TUHENXf3DDwAB2hCgoEq
	 SSUT00TR1RUZyfzZJWbdBuYu+iV0qRuXh7YXt1RQnlyHMxa6tjvVTbPeDwRWKMdi3+
	 nmAPqnMaJzMcITQMPPShhTDjBJUaP5AZhvJYbXHmUed3/UJ1XC/SFkAQA/rCp7K/Cl
	 +M3elzl8XckDg==
Message-ID: <40f31e5a-7161-4b17-af03-52b3a28a113e@kernel.org>
Date: Fri, 10 Apr 2026 15:29:12 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] mm: improve large folio readahead and alignment
 for exec memory
Content-Language: en-US
To: Lorenzo Stoakes <ljs@kernel.org>, Usama Arif <usama.arif@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, david@kernel.org,
 willy@infradead.org, ryan.roberts@arm.com, linux-mm@kvack.org, r@hev.cc,
 jack@suse.cz, ajd@linux.ibm.com, apopple@nvidia.com, baohua@kernel.org,
 baolin.wang@linux.alibaba.com, brauner@kernel.org, catalin.marinas@arm.com,
 dev.jain@arm.com, kees@kernel.org, kevin.brodsky@arm.com,
 lance.yang@linux.dev, Liam.Howlett@oracle.com,
 linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, mhocko@suse.com, npache@redhat.com,
 pasha.tatashin@soleen.com, rmclure@linux.ibm.com, rppt@kernel.org,
 surenb@google.com, Al Viro <viro@zeniv.linux.org.uk>, ziy@nvidia.com,
 hannes@cmpxchg.org, kas@kernel.org, shakeel.butt@linux.dev,
 leitao@debian.org, kernel-team@meta.com
References: <20260402181326.3107102-1-usama.arif@linux.dev>
 <803a0c15-0a6a-4c00-b6b3-eaae56d5fc15@linux.dev> <adjkCOiLgZ_-zovg@lucifer>
 <adjllNan2vgBNBHJ@lucifer> <5f99b289-629c-47c4-bef0-966d6678a2a8@linux.dev>
 <adjrKwgiZwXR9epk@lucifer>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <adjrKwgiZwXR9epk@lucifer>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/10/26 14:24, Lorenzo Stoakes wrote:
> On Fri, Apr 10, 2026 at 01:19:08PM +0100, Usama Arif wrote:
>> >> Thanks, Lorenzo
>> >
>> > (Note that we're in a 'quiet period' from here until -rc1 of next cycle and
>> > won't be taking anything new until then. We plan to do this from around rc5 or
>> > rc6 of each cycle in future).
>>
>> Thanks! Just wanted to check, as I am always confused about this. Is it ok
>> to send patches for review for next release at this time? So that they
>> are in a good state when rc1 comes. I wanted to send PMD swap entries
>> for review after I am finished testing, but I want them for review for
>> next release.
> 
> I think different people have different views on that :)
> 
> I mean it's debateable whether having a glut of new material on day one of -rc1
> is preferable to having a bunch come in that might or might not get lost along
> the way :)
> 
> I personally feel it'd be better to send during the cycle window rather than
> before but I suspect others disagree with that!
> 
> So from your point of view, feel free to do what you like, but maybe David +
> others would want to chime in with their opinions?

For me the more important part of the quiet period is that patches can't be
merged, so there's less urgency to review them immediately. So I think it's
fine to still send patches, but not having expectations about quick
response, as people might be taking time off.

On the other hand it would be better if new series could mature in this
quiet period, so there would be less work after rc1. But the key to making
that possible I think is to feel less urgency/being overwhelmed also in the
non-quiet period (rc1-rc5/6). Then it's should be less necessary to take
time off during the quiet period. So hopefully we'll get there through
involving more reviewers, and by having more submaintainers agency.

Vlastimil
