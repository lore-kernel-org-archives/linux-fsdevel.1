Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B7841736F;
	Tue,  7 Jul 2026 13:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783430937; cv=none; b=HImNuZFBpaM+Ti5A9B9xggGU86vKVB1tJzcHXg9uON/jwjV4rkKB0T5sQ8Q3ympYxN9mjtG1MRYx+A7cULXcC3V7JNZmj8tANZ0Kaxv51tE5grg3ml/7e/ZE6DTqERkBKQ8/tdC5rCnWClhpBTWtmORSaQSp4vSPFu+Sqv2BMD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783430937; c=relaxed/simple;
	bh=QxuthDG6C7EaZuCmhHEyzx4mRVYzNX4KrA34zWouSMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uwudvas5nmdyMtyjCvwRCwa0v4zAojvPeYuprqOvsoSXuXW9o3q1vhpRmn5mpbRobOroL6jlqfuO3E2M2QhUfDaJDKJfFhlZ9HkvT/X6eeCMB3gnddoz27PnsfEffMYihkIoOQIKUDt1joHo9Ip6Scafx6rEhyHrne7fm6td7qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GaZCBpRZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GaZCBpRZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 313981F000E9;
	Tue,  7 Jul 2026 13:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783430936;
	bh=hVa/2y67lDjegAbH+jNz4FW3OMYPmgBfp2z3AdNmSOA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=GaZCBpRZQD7fv589ihWWgzl4Vy+vRwdwpglZhxbA5Ks3qJ/HXhCAGkM8dUltQdM73
	 4ZRL1O3uIOhBxlAhVAhIH7FuS5N5BKylI26gith4cUpQ2tlszjpLK4kmfplZAo0UCA
	 aQWuvo8sDjZirhLnQE11KWdtdGSaK64i8rebA4G6rJgJrBAC+XonLjcifGOi4nF788
	 eI6mCX+/3XPsBTva62Gtqw/1+JOqBZr6fErogm8EgPsSjHLt4C7ARyfsdqaVkeCXCe
	 9JicW54uQrhIolqDwDXHiXGBADzKB89KsyUO4/BQ4gXIqqzTL9LXgG9yhAbYH6SGxg
	 2QmKBGvLvfdPQ==
Message-ID: <ebc1f034-7297-459e-975d-5c143567392f@kernel.org>
Date: Tue, 7 Jul 2026 15:28:49 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: remove the requirement for LLM attribution
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>, Boris Burkov <boris@bur.io>,
 Jeff Layton <jlayton@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
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
 <0ba6bf66-e48f-40df-a953-503d317b3dbe@kernel.org>
 <20260707124031.GC211515@killaraus.ideasonboard.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260707124031.GC211515@killaraus.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/7/26 14:40, Laurent Pinchart wrote:
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
> 
> I would like to drop this one. As I understand, several people objected
> to including the product name in the git history as it is just free
> adverising, and nobody objected to dropping it.

Yeah. I mean, we could go the following direction (dropping the models and
encouraging also a description of usage for other tools), but not sure how
much pushback we will get:


diff --git a/Documentation/process/coding-assistants.rst b/Documentation/process/coding-assistants.rst
index 899f4459c52d2..a085a15d59990 100644
--- a/Documentation/process/coding-assistants.rst
+++ b/Documentation/process/coding-assistants.rst
@@ -40,20 +40,26 @@ Attribution
 ===========
 
 When AI tools contribute to kernel development, proper attribution
-helps track the evolving role of AI in the development process.
-Contributions should include an Assisted-by tag in the following format::
+helps track the evolving role of AI in the development process. Further,
+for reviewers and maintainers it is also crucially important to know how
+AI tools were used.
 
-  Assisted-by: AGENT_NAME:MODEL_VERSION [TOOL1] [TOOL2]
+Contributions that used AI to generate significant portions of code,
+comments, or patch descriptions must include an Assisted-by tag in the
+following format::
 
-Where:
+  Assisted-by: LLM # mandatory brief description of usage
 
-* ``AGENT_NAME`` is the name of the AI tool or framework
-* ``MODEL_VERSION`` is the specific model version used
-* ``[TOOL1] [TOOL2]`` are optional specialized analysis tools used
-  (e.g., coccinelle, sparse, smatch, clang-tidy)
+Similarly, usage of other specialized analysis tools should be
+indicated through an Assisted-by tag in the following format::
 
-Basic development tools (git, gcc, make, editors) should not be listed.
+  Assisted-by: [TOOL1] [TOOL2] # optional brief description of usage
 
-Example::
+Examples for ``[TOOL1] [TOOL2]`` are coccinelle, sparse, smatch, and
+clang-tidy. Basic development tools (git, gcc, make, editors) should not
+be listed.
 
-  Assisted-by: Claude:claude-3-opus coccinelle sparse
+Examples::
+
+  Assisted-by: LLM # translate patch description
+  Assisted-by: coccinelle # batch conversion with small manual fixups
davhil01@e142025:~/git/linux$ 

-- 
Cheers,

David
