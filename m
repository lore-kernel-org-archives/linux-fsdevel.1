Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792860237;
	b=VSmIn7EAUUkQOzDqX5E05px52+qSk6m0iwfN7LZaDFJkvbJiqj6dTjwFZ6nWfY156IXy
	 wniPQjfkI1pBUCfRJ8gub3ybDerw/Ez2jNJglC35dWFTIrEod5G+O4Ubpncy5K89q35Xu
	 mv/CyZrGoACoDOYtShHTF1lnvfAk67w8n4r21fhIfdLYQX9ntcZO5lOnasOkD1Z7jf0dt
	 n4XwvMTNEi4GEzfP65tN25lzCPcyWzzMd9be9VUBeZR6yH9ym9r5r4dS3JnL4fvaYr5Py
	 wnGvQnJZ78qsk42YjH1dqS6oD1er05ow6fOgRtws0x+KXqO6FwSAXKhl3clac6V2llQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792860237;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=+/j266sJfIqDeAfgkEM0MUVjoZ5c4ZSL2NlWj4wux/Q=;
	b=ZNs/0DVBFJULLqGQVzJ5IXPquilK7mQYfCpQxxixY8BCtyAKzcJ7ygudjPHOBNRlPF20
	 P+HS2kqR1rJMte/r1Wbs7oWGihKGroY8fm/5wCJvxOcXyQYR/wkJw4RkeQoQZzLV739s6
	 DRG48MfRIRDzu6PYn4XfdDAZD9mxbBScD0SAxrQ0NYBPuJhExkfGUJowUjPlNFvPztq80
	 T338xaCsmt0lMtazvNTqkPZX/sY8QOxjFMWwHv9KAP3lK6UU6PhAos5ZLLSrhv2+DAMfz
	 Y/nkybewNQfaz4R/SssqgZ4d9doLdw/+cVBAZxIlAJ6BEzS/o1+RAPIsMlGoIxd3nEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=GQmipm9n;
	arc=none smtp.remote-ip=95.215.58.154
Received: from mta1.migadu.com (out-154.mta1.migadu.com [95.215.58.154])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC04606A31B
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Oct 2026 16:43:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAC04606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=GQmipm9n
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=YaB4ADKDgt+Vb2IvZ5bZWg1lDZ+WYJjWnqvVAGLvasI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792860232; v=1; x=1793465032;
 b=GQmipm9n1/AsSrr7Em7oB9sqMBuhxeG28HqgJUlrhZ9CIVaFiNUZdW/YSxg4UWyA2y+iIve2
 1rtaXivcaDOV7b3lCuD3mjjaFGdQQqwPXngJ9SeETxc6FJc1/GCm+gCgqp9VFLUxU4Qtx9gAEKD
 hxVnQBjUUghzkhezNKmCt/pE=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2282dd039a80869b;
	Sat, 24 Oct 2026 16:43:52 +0000
X-Mizu-Trace-ID: 2282dd039a80869b
X-Migadu-Flow: FLOW_OUT
Message-ID: <6047c828-07a4-449e-aaa6-8fa182c11cba@linux.dev>
Date: Sun, 25 Oct 2026 00:43:37 +0800
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 0/2] sysctl: add CTLTBL_ENTRY_XXX() macros for
 ctl_table initialization
To: Joel Granados <joel.granados@kernel.org>
Cc: Kees Cook <kees@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1774463505.git.wen.yang@linux.dev>
 <3626b4c0-319b-4944-b7ff-704ab146fd1e@linux.dev>
 <57fctybn2i7fapt7mo466rou7pu2qfudhkqfmd22y2yu72uilh@zpaewmnbjqbo>
Content-Language: en-US
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <57fctybn2i7fapt7mo466rou7pu2qfudhkqfmd22y2yu72uilh@zpaewmnbjqbo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/17/26 23:25, Joel Granados wrote:
> Hey Wen
> 
> Sorry for not getting back to you sooner.
> 
> IMO, this is approach is the way to go to bring back the control of the
> sysctl variables into the sysctl subsys files. Would like to get another
> set of eyes on it before committing to it though.
> 
> I think it has not gotten too much attention because it does not touch
> any other subsystem. Would you consider adding one subsys to the series?
> Something like implementing it for the users in arch/ or fs/ or
> drivers/.
> 
> Also, this might be a signal to park this temporarily and let it simmer
> until more ppl are annoyed at making changes to the sysctl API.
> 
> Best
> 

Hi Joel,

Apologies for the long delay, and thank you for your helpful feedback. 

I've been tied up with other commitments, but can now return to this 

work and prepare v3 based on your suggestions. 

 

Given the time that has passed, I'd appreciate any updated advice or 

related developments I should take into account. 

 

Thanks again for your time and patience. 


-- 

Best regards, 
                                                            Wen

> On Sat, Jun 13, 2026 at 11:56:50PM +0800, Wen Yang wrote:
>> Hi Kees, H jioel,
>>
>> Gentle ping on this series. Please let me know if there are any
>> concerns or if further changes are needed.
>>
>> The series is available at:
>> https://lore.kernel.org/all/x5stdwwsfp2h22zyexn5ycbxnkyc4ioxscninxsa6q7lf6djqr@jkuppwwqubkp/
>>
>> Thanks for your time,
>> Wen
>>
>>
>> On 3/26/26 02:39, wen.yang@linux.dev wrote:
>>> From: Wen Yang <wen.yang@linux.dev>
>>>
>>> Historically, changes to how struct ctl_table entries are initialized
>>> (e.g. removing the child field, const-qualifying ctl_table) required
>>> touching hundreds of files across all subsystems.  Such series require
>>> the attention of many maintainers, sometimes need to be pulled into
>>> mainline in a special way, and create lots of unnecessary churn.  With
>>> CTLTBL_ENTRY_XXX(), future structural changes to struct ctl_table need
>>> only update the macro definitions.
>>>
>>> Conversion of existing call sites will proceed incrementally from
>>> kernel/sysctl.c outward, rather than as a treewide sweep.
>>>
>>> This series:
>>>    1. Introduces the CTLTBL_ENTRY_XXX() macros in include/linux/sysctl.h,
>>>       using _Generic() for automatic proc_handler selection, auto
>>>       address-of, auto maxlen via sizeof(), and compile-time validation.
>>>       Supported types: int, unsigned int, long, unsigned long, bool, u8.
>>>    2. Converts kernel/sysctl-test.c as a demonstration, adding a
>>>       parameterized KUnit test covering all macro variants (V, VM, VMR,
>>>       VN, VNM, VNMH) across int, u8, bool, and char[] types.
>>>
>>> Based on discussion and suggestions from:
>>> [1] https://sysctl-dev-rtd.readthedocs.io/en/latest/notes/ctltable_entry_macro.html
>>> [2] https://lore.kernel.org/all/psot4oeauxi3yyj2w4ajm3tfgtcsvao4rhv5sgd5s6ymmjgojk@p3vrj3qluban/
>>>
>>> ---
>>> Changes in v5:
>>>     - Extend __CTL_AUTO_HANDLER to support bool and u8
>>>     - Replace individual test functions with a single parameterized KUnit
>>>       test (KUNIT_CASE_PARAM) covering all variants and types
>>>     - Use struct ctl_table as the expected-value container in the param
>>>       struct, eliminating custom expected_* fields
>>>
>>> Changes in v4:
>>>     - Fix Wpointer-type-mismatch warnings detected by lkp:
>>>       https://lore.kernel.org/oe-kbuild-all/202603050724.SZxrEyyu-lkp@intel.com/
>>>
>>> Changes in v3:
>>>     - Replace the unique macro with "capital letter approach"
>>>     - Reduce the name further
>>>     https://lore.kernel.org/all/rn4rsazh7kxf5byq65vw2phyqgzvwm3scczu3l5h2r4aqit2r6@znlpb24z2zuo/
>>>
>>> Changes in v2:
>>>     - Add lvalue check, handler type check, etc.
>>>     https://lore.kernel.org/all/xptwb3uwbzposd4xf7khj52ifv4tchcjdgllhv7aabi6d7wgef@2msurl564v53/
>>>
>>>
>>> Wen Yang (2):
>>>     sysctl: introduce CTLTBL_ENTRY_XXX() helper macros
>>>     sysctl: convert kernel/sysctl-test.c to use CTLTBL_ENTRY_XXX()
>>>
>>>    include/linux/sysctl.h | 307 +++++++++++++++++++++++++++++++++++++++++
>>>    kernel/sysctl-test.c   | 237 ++++++++++++++++++-------------
>>>    kernel/sysctl.c        |   2 +
>>>    3 files changed, 447 insertions(+), 99 deletions(-)
>>>
> 
