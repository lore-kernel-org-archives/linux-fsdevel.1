Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E02419316;
	Tue,  7 Jul 2026 13:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783430992; cv=none; b=hLKjzIzGZeddMAQ6+mhwRm0uFKoQxcVS/h07We1Ug/wjWMsRFw0pG//w7WyBAuN8A82Pz3IG2XNRFKYn+NR00G2IckXXnkAHacpyUrfEaYwGoVr9UMSKKWpwwTVH9qEUX97jrVwQF0b38YR23QhXt1ll6mTa61rvnDXrHPuJnjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783430992; c=relaxed/simple;
	bh=AeKOkDF9KGVYq4U5w3QsAhAQbcjRdhpOhvBrDm5NH0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zvvi4U8ahMX5UiA30KdfU0Nob7XFu8FC89gruVRJ7qqCT/cx47V4lRxVkBgXbQuaynI1arLsALRsXEddoMS3riqpSLYj5fWYSQxqGYDTTkmBvkU4OmK8wW1yz0jcIQ9ul0Gkf59fapx46DeWaPQU3NsDqBr8VTd9mguKpF1PKZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aM3Y5ZPL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aM3Y5ZPL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31DE31F000E9;
	Tue,  7 Jul 2026 13:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783430991;
	bh=RwhAjGAolw0zONtLEbzGNkoSidQtU6ZdwCG/czr8kKQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=aM3Y5ZPLPmZl3utiUy9AFqp742MEu9aVemQtD00lcYnAvsMSDgWXybIqqo1IggL46
	 JNmdmachMsxB7nmaG6ZG47pCMCvTzO360DLv3nRm8rrupcG/A1tCmsgayDgaADsSTL
	 Pzp8JeyYQ1XIZ+KuQIs4LK7DdlVEYijc7vPHdJxLVeqkay+RyOz28p+fQJN8eigLZU
	 dW5C2L7CeBwRK4MsCxe2OEFiQfT++TnznicitgsxOVRYq5fzO+oGTdDPVrnpSknUtA
	 1jFUzQQwkNtKpICQ7+R/INvt2Gl5JM3tKMihpDbBtH2XdlGn4U4hgqY6G/bbOcaz/m
	 Dbl/TAczdvuLw==
Message-ID: <5ccbb28a-171e-40c1-9a6b-9ac7b6b7777d@kernel.org>
Date: Tue, 7 Jul 2026 15:29:44 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: remove the requirement for LLM attribution
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Boris Burkov <boris@bur.io>, Jeff Layton <jlayton@kernel.org>,
 Greg KH <gregkh@linuxfoundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>, Justin Stitt <justinstitt@google.com>,
 Carlos Maiolino <cem@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Jori Koolstra <jkoolstra@xs4all.nl>, Krzysztof Kozlowski <krzk@kernel.org>,
 Brian Foster <bfoster@redhat.com>, Christoph Hellwig <hch@infradead.org>,
 David Disseldorp <ddiss@suse.de>, Mark Brown <broonie@kernel.org>,
 Jani Nikula <jani.nikula@intel.com>, Jens Axboe <axboe@kernel.dk>,
 Vlastimil Babka <vbabka@kernel.org>,
 "Christian Brauner (Amutable)" <brauner@kernel.org>,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <2026070227-payroll-eradicate-8f66@gregkh>
 <16c507cea8f2873766e1de586d9a0d73234a3038.camel@kernel.org>
 <akaWnQ5Pkg_676B-@lucifer> <20260702211740.GA639365@zen.localdomain>
 <3f447113-4407-471f-878f-e6d6edafee71@kernel.org> <akez23ZhLRSGMFQ1@lucifer>
 <20260703163251.GB3734786@killaraus.ideasonboard.com>
 <e93d28e4-750c-4a4f-8bfd-7a0b404cd05c@kernel.org> <akzETpsps4TMfqpC@lucifer>
 <0ba6bf66-e48f-40df-a953-503d317b3dbe@kernel.org> <akzMh-ySQ2fN0d8R@lucifer>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <akzMh-ySQ2fN0d8R@lucifer>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/7/26 11:55, Lorenzo Stoakes wrote:
> On Tue, Jul 07, 2026 at 11:49:31AM +0200, David Hildenbrand (Arm) wrote:
>> On 7/7/26 11:20, Lorenzo Stoakes wrote:
>>>
>>> I think the silence suggests nobody :)
>>>
>>> What we could do is send a patch to simply add a section on adding a comment
>>> explaining _what_ used an LLM and strongly suggesting it would be helpful to do
>>> so.
>>>
>>> That should hopefully be uncontroversial, then later (or alongside that?) we
>>> could submit an RFC for making the language move to 'you MUST do this', as that
>>> will probably be the more controversial bit.
>>
>> Maybe we should just spell out about which scenario we care about where we really
>> expect the disclosure.
>>
>> Sure, it might be more controversial and we could have that in a separate patch.
>>
>> I was thinking of the following end result:
>>
>> diff --git a/Documentation/process/coding-assistants.rst b/Documentation/process/coding-assistants.rst
>> index 899f4459c52d2..4c2ab4dfc6da7 100644
>> --- a/Documentation/process/coding-assistants.rst
>> +++ b/Documentation/process/coding-assistants.rst
>> @@ -40,20 +40,37 @@ Attribution
>>  ===========
>>
>>  When AI tools contribute to kernel development, proper attribution
>> -helps track the evolving role of AI in the development process.
>> -Contributions should include an Assisted-by tag in the following format::
>> +helps track the evolving role of AI in the development process. Further,
>> +for reviewers and maintainers it is also crucially important to know how
>> +AI tools were used.
>>
>> -  Assisted-by: AGENT_NAME:MODEL_VERSION [TOOL1] [TOOL2]
>> +Contributions that used AI to generate significant portions of code,
>> +comments, or patch descriptions must include an Assisted-by tag in the
>> +following format::
>>
>> -Where (preferred):
>> +  Assisted-by: LLM # brief description of usage
>> +
>> +Or alternatively::
>> +
>> +  Assisted-by: AGENT_NAME:MODEL_VERSION # brief description of usage
>> +
>> +Where::
>>
>>  * ``AGENT_NAME`` is the name of the AI tool or framework
>>  * ``MODEL_VERSION`` is the specific model version used
>> -* ``[TOOL1] [TOOL2]`` are optional specialized analysis tools used
>> -  (e.g., coccinelle, sparse, smatch, clang-tidy)
>> +
>> +If other tools were used, they should be specified through a dedicated
>> +Assisted-by tag in the following format::
>> +
>> +  Assisted-by: [TOOL1] [TOOL2]
>> +
>> +Where ``[TOOL1] [TOOL2]`` are specialized analysis tools used
>> +(e.g., coccinelle, sparse, smatch, clang-tidy)
>>
>>  Basic development tools (git, gcc, make, editors) should not be listed.
>>
>> -Example::
>> +Examples::
>>
>> -  Assisted-by: Claude:claude-3-opus coccinelle sparse
>> +  Assisted-by: LLM # translate patch description
>> +  Assisted-by: Claude:claude-3-opus # generate most of the code
>> +  Assisted-by: coccinelle sparse
> 
> LGTM! Do you want to send that then? People can comment on the actual path then
> (probably worth cc'ing everybody here on that also).

Let's first gather some more thoughts on the rough direction before spinning of
yet another discussion. :)

-- 
Cheers,

David
