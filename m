Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793635087;
	b=2XRI4TvV4QR+BxaheJxNkd8Zx0OlJ9rAvmz5LyY9T9c5qqlM/TOHeaTgDmHSLmQN0PU5
	 Ua5nG2ivUHziBvHI31ofe/SLMqWBhR9xOUl7N4K3b1mHynSmqK3vieAhLE9+FuYOS9USw
	 t7+qmsCoJUNCiWzbDclcC4DT3pYt1LtulrioJH/K8slMLD3LQiEyvSbsAdQjiZQPZUDUs
	 sAEJtd9OskhFp5GdPy5zJrnjD8TOqNKqIbnwML5hsj6r3as1vbhAUGNcYl4O8034KOFxZ
	 ddHj5hld9LKmLoojtCOU3XjISODT6vP8YMAm1AUWTjuDIePcz0xTwex20akSpK+oH0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793635087;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=QuMgc0nw33KkJCMxo+8yBifrJk7oWSHrJDQEhhWnRDo=;
	b=dJnXdiAnp3jma7tVXJUnt2YEzKuSqbIOeh2W9pjPc4EoOY91XQa7MDDf8+1ZnaaRaESS
	 I8yvkE9xKYAc2ASRJm5K4awjm8OeW7VnWUaLC10HuUGG6CoeSOCRS1+G3kR12CocDMUbj
	 P7nxC+gNKWNTnoM2ujs4GbLOV9X0bH9jc08t7nxQgHUl0ZSn4E5fJgiKeSvxgmrfCBRO+
	 vPikI8tVHohH/qVH4L667w6NjJj6UqdB64oKz7ugKNYispOePhuA5C00L3Gg4qRP5iARJ
	 3K+1hogqvKXfMNpee09QiyQCeHdmb3AaF2ORrF35cnj7zL5g9SXARz19FE5P6/jbiuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=sFDce9rv;
	arc=none smtp.remote-ip=95.215.58.246
Received: from mta1.migadu.com (out-246.mta1.migadu.com [95.215.58.246])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5A1606EE93
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2026 15:58:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE5A1606EE93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=sFDce9rv
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=giT7Ub4tDNwcGbsfCiNVRlt46uIIAK3CYU8BLuMPRA4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793635083; v=1; x=1794239883;
 b=sFDce9rv38qoXhuevHzE/U+Rd0ImKfj9PTdFmJwNtW1572d27ZmVN0V3sFWUgmJAaOwFui93
 pUk1ux7Mgkh3y1OcsTYZqsFWX7P0J0JvwuOLGYXEEKR6DPxt/JImc3p+YcLh+C+VpK0YrR4aKUR
 /7BgaWTDTZC47fMJy3LEUJDE=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1a898305129db6a1;
	Mon, 02 Nov 2026 15:58:03 +0000
X-Mizu-Trace-ID: 1a898305129db6a1
X-Migadu-Flow: FLOW_OUT
Message-ID: <050b2715-84a0-4dab-b9ed-7f93964bb6a1@linux.dev>
Date: Mon, 2 Nov 2026 23:57:59 +0800
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
 <6047c828-07a4-449e-aaa6-8fa182c11cba@linux.dev> <auh_b-jm5yW5ouh5@hobbes>
Content-Language: en-US
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <auh_b-jm5yW5ouh5@hobbes>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/2/26 20:23, Joel Granados wrote:
> On Sun, Oct 25, 2026 at 12:43:37AM +0800, Wen Yang wrote:
>>
>>
>> On 6/17/26 23:25, Joel Granados wrote:
>>> Hey Wen
>>>
>>> Sorry for not getting back to you sooner.
>>>
>>> IMO, this is approach is the way to go to bring back the control of the
>>> sysctl variables into the sysctl subsys files. Would like to get another
>>> set of eyes on it before committing to it though.
>>>
>>> I think it has not gotten too much attention because it does not touch
>>> any other subsystem. Would you consider adding one subsys to the series?
>>> Something like implementing it for the users in arch/ or fs/ or
>>> drivers/.
>>>
>>> Also, this might be a signal to park this temporarily and let it simmer
>>> until more ppl are annoyed at making changes to the sysctl API.
>>>
>>> Best
>>>
>>
>> Hi Joel,
>>
>> Apologies for the long delay, and thank you for your helpful feedback.
>>
>> I've been tied up with other commitments, but can now return to this
>>
>> work and prepare v3 based on your suggestions.
>>
>>
>>
>> Given the time that has passed, I'd appreciate any updated advice or
>>
>> related developments I should take into account.
> 
> There is now more clarity that the use of MACROS like we had discussed
> for this series is probably not the way to go. In [1] it is clear that
> the overuse of macros will probably be rejected once it gets upstream.
> So for now I would let this implementation go.
> 

Hi Joel,

It's okay, we'll keep trying other approaches.
Since it has existed for so many years, it's indeed hard to deal with,
but we won't give up. As we increasingly adopt Linux in autonomous 
driving, we will pay closer attention to information security issues of 
this kind.
We would greatly appreciate your continued guidance. Could you take a 
look at this RFC series and share your thoughts on whether the approach 
makes sense?

https://lore.kernel.org/all/cover.1793204511.git.wen.yang@linux.dev/


Thanks,
Wen


> Best
> 
> [1] https://lore.kernel.org/all/CAHk-=wjUmLrJd4KM4xvJHUN4P0r8oSu5LyvG4JipnhxizBrE9Q@mail.gmail.com
>>
>>
>>
>> Thanks again for your time and patience.
>>
>>
>> -- 
>>
>> Best regards,                                                            Wen
>>
>>> On Sat, Jun 13, 2026 at 11:56:50PM +0800, Wen Yang wrote:
>>>> Hi Kees, H jioel,
>>>>
>>>> Gentle ping on this series. Please let me know if there are any
>>>> concerns or if further changes are needed.
>>>>
>>>> The series is available at:
>>>> https://lore.kernel.org/all/x5stdwwsfp2h22zyexn5ycbxnkyc4ioxscninxsa6q7lf6djqr@jkuppwwqubkp/
>>>>
>>>> Thanks for your time,
>>>> Wen
>>>>
>>>>
>>>> On 3/26/26 02:39, wen.yang@linux.dev wrote:
>>>>> From: Wen Yang <wen.yang@linux.dev>
>>>>>
>>>>> Historically, changes to how struct ctl_table entries are initialized
>>>>> (e.g. removing the child field, const-qualifying ctl_table) required
>>>>> touching hundreds of files across all subsystems.  Such series require
>>>>> the attention of many maintainers, sometimes need to be pulled into
>>>>> mainline in a special way, and create lots of unnecessary churn.  With
>>>>> CTLTBL_ENTRY_XXX(), future structural changes to struct ctl_table need
>>>>> only update the macro definitions.
>>>>>
>>>>> Conversion of existing call sites will proceed incrementally from
>>>>> kernel/sysctl.c outward, rather than as a treewide sweep.
>>>>>
>>>>> This series:
>>>>>     1. Introduces the CTLTBL_ENTRY_XXX() macros in include/linux/sysctl.h,
>>>>>        using _Generic() for automatic proc_handler selection, auto
>>>>>        address-of, auto maxlen via sizeof(), and compile-time validation.
>>>>>        Supported types: int, unsigned int, long, unsigned long, bool, u8.
>>>>>     2. Converts kernel/sysctl-test.c as a demonstration, adding a
>>>>>        parameterized KUnit test covering all macro variants (V, VM, VMR,
>>>>>        VN, VNM, VNMH) across int, u8, bool, and char[] types.
>>>>>
>>>>> Based on discussion and suggestions from:
>>>>> [1] https://sysctl-dev-rtd.readthedocs.io/en/latest/notes/ctltable_entry_macro.html
>>>>> [2] https://lore.kernel.org/all/psot4oeauxi3yyj2w4ajm3tfgtcsvao4rhv5sgd5s6ymmjgojk@p3vrj3qluban/
>>>>>
>>>>> ---
>>>>> Changes in v5:
>>>>>      - Extend __CTL_AUTO_HANDLER to support bool and u8
>>>>>      - Replace individual test functions with a single parameterized KUnit
>>>>>        test (KUNIT_CASE_PARAM) covering all variants and types
>>>>>      - Use struct ctl_table as the expected-value container in the param
>>>>>        struct, eliminating custom expected_* fields
>>>>>
>>>>> Changes in v4:
>>>>>      - Fix Wpointer-type-mismatch warnings detected by lkp:
>>>>>        https://lore.kernel.org/oe-kbuild-all/202603050724.SZxrEyyu-lkp@intel.com/
>>>>>
>>>>> Changes in v3:
>>>>>      - Replace the unique macro with "capital letter approach"
>>>>>      - Reduce the name further
>>>>>      https://lore.kernel.org/all/rn4rsazh7kxf5byq65vw2phyqgzvwm3scczu3l5h2r4aqit2r6@znlpb24z2zuo/
>>>>>
>>>>> Changes in v2:
>>>>>      - Add lvalue check, handler type check, etc.
>>>>>      https://lore.kernel.org/all/xptwb3uwbzposd4xf7khj52ifv4tchcjdgllhv7aabi6d7wgef@2msurl564v53/
>>>>>
>>>>>
>>>>> Wen Yang (2):
>>>>>      sysctl: introduce CTLTBL_ENTRY_XXX() helper macros
>>>>>      sysctl: convert kernel/sysctl-test.c to use CTLTBL_ENTRY_XXX()
>>>>>
>>>>>     include/linux/sysctl.h | 307 +++++++++++++++++++++++++++++++++++++++++
>>>>>     kernel/sysctl-test.c   | 237 ++++++++++++++++++-------------
>>>>>     kernel/sysctl.c        |   2 +
>>>>>     3 files changed, 447 insertions(+), 99 deletions(-)
>>>>>
>>>
