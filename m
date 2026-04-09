Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F882309AA;
	Thu,  9 Apr 2026 02:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775701662; cv=none; b=KEsDBKHUAXT2krAZhDmNOqdz1wRZUIcQ3CNSyEkDpravTzih7GDCaFa3adJOpmx18muz6vDMOmZl/SLrW0QAw0+kWB1WGoe/P5oRWprcwrtHR9pl3fCGrBx2zq8PKG3INFlwy7kRyjI68hnU20X+DVh2p3yt8VS0uR1VnjSvoGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775701662; c=relaxed/simple;
	bh=bGAFxpTiq/WlFBLb1YcygMa4jv0YwVYg/pCCPvVSasc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QhqBNF2IDnBNfuSqIgiRgzlsWga4ujw/i0ot43OYrxgF3t4uD/z8ZG6OVGKnqL2r/MB1GOkWg4wcK+NXiGuo8/fklHgL40Pdv670Ho6SLnRGD+PVT69WCM2vKxKKgeMNRnkSK5mxlq+P8xtRa6Eo6W0VgWXcTm2hwDkkDa9Iyps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=H7nUpdGp; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="H7nUpdGp"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1775701656; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=OWgOCsqbJLPzolipxltE1h0Dmoqj1O51GEEuMn/8ELc=;
	b=H7nUpdGpVPOY1oYbJOX27W1my7ghY9bjp4VVvo2UN9r1uuJR8UqLBzTNlrxOcKru6rGa/ZfZj95haeXIDob0xvGynAvUpGFqQLi2PKGdWA/RwL4KsA/qk933ATbuRuQ9SBgKt8j0xQmCvTfprB1NanhxpbyY2Vq6e/+KLSoIszg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R901e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0X0gktlq_1775701628;
Received: from 30.221.145.70(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0X0gktlq_1775701628 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 09 Apr 2026 10:27:35 +0800
Message-ID: <5c13b5ae-ca74-4fd8-97ec-39f24ccfd5c2@linux.alibaba.com>
Date: Thu, 9 Apr 2026 10:27:35 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 6/8] fuse: implementation of lookup_handle+statx
 compound operation
To: Luis Henriques <luis@igalia.com>, Joanne Koong <joannelkoong@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>,
 Bernd Schubert <bschubert@ddn.com>, Bernd Schubert <bernd@bsbernd.com>,
 "Darrick J. Wong" <djwong@kernel.org>, Horst Birthelmer
 <hbirthelmer@ddn.com>, Kevin Chen <kchen@ddn.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Matt Harvey <mharvey@jumptrading.com>, kernel-dev@igalia.com
References: <20260225112439.27276-1-luis@igalia.com>
 <20260225112439.27276-7-luis@igalia.com>
 <CAJnrk1Yxpy0+tx2yb7CxVVwF9gqNRz_pHH5NUpBHOg55NNooJA@mail.gmail.com>
 <87v7e24gdw.fsf@igalia.com>
 <CAJnrk1aG_N-FVJfNpoU6iLcA6XHsUvWe74E0Pkth-hev9zgmHg@mail.gmail.com>
 <87fr55lpu4.fsf@igalia.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <87fr55lpu4.fsf@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Luis,

On 4/8/26 6:16 PM, Luis Henriques wrote:
> On Tue, Apr 07 2026, Joanne Koong wrote:
> 
>> On Tue, Apr 7, 2026 at 2:20 PM Luis Henriques <luis@igalia.com> wrote:
>>>
>>> Hi Joanne,
>>>
>>> On Tue, Apr 07 2026, Joanne Koong wrote:
>>>
>>>> On Wed, Feb 25, 2026 at 3:25 AM Luis Henriques <luis@igalia.com> wrote:
>>>>>
>>>>> The implementation of lookup_handle+statx compound operation extends the
>>>>> lookup operation so that a file handle is be passed into the kernel.  It
>>>>> also needs to include an extra inarg, so that the parent directory file
>>>>> handle can be sent to user-space.  This extra inarg is added as an extension
>>>>> header to the request.
>>>>>
>>>>> By having a separate statx including in a compound operation allows the
>>>>> attr to be dropped from the lookup_handle request, simplifying the
>>>>> traditional FUSE lookup operation.
>>>>>
>>>>> Signed-off-by: Luis Henriques <luis@igalia.com>
>>>>> ---
>>>>>  fs/fuse/dir.c             | 294 +++++++++++++++++++++++++++++++++++---
>>>>>  fs/fuse/fuse_i.h          |  23 ++-
>>>>>  fs/fuse/inode.c           |  48 +++++--
>>>>>  fs/fuse/readdir.c         |   2 +-
>>>>>  include/uapi/linux/fuse.h |  23 ++-
>>>>>  5 files changed, 355 insertions(+), 35 deletions(-)
>>>>>
>>>>> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
>>>>> index 113583c4efb6..89e6176abe25 100644
>>>>> --- a/include/uapi/linux/fuse.h
>>>>> +++ b/include/uapi/linux/fuse.h
>>>>>
>>>>>  enum fuse_opcode {
>>>>> @@ -671,6 +676,8 @@ enum fuse_opcode {
>>>>>          */
>>>>>         FUSE_COMPOUND           = 54,
>>>>>
>>>>> +       FUSE_LOOKUP_HANDLE      = 55,
>>>>> +
>>>>>         /* CUSE specific operations */
>>>>>         CUSE_INIT               = 4096,
>>>>>
>>>>> @@ -707,6 +714,20 @@ struct fuse_entry_out {
>>>>>         struct fuse_attr attr;
>>>>>  };
>>>>>
>>>>> +struct fuse_entry2_out {
>>>>> +       uint64_t        nodeid;
>>>>> +       uint64_t        generation;
>>>>> +       uint64_t        entry_valid;
>>>>> +       uint32_t        entry_valid_nsec;
>>>>> +       uint32_t        flags;
>>>>> +       uint64_t        spare;
>>>>> +};
>>>>
>>>> Hi Luis,
>>>>
>>>> Could you explain why we need a new struct fuse_entry2_out instead of
>>>> reusing struct fuse_entry_out? From what i see, the only differences
>>>> between them are that fuse_entry2_out drops attr_valid,
>>>> attr_valid_nsec, and struct fuse_attr. Is this done so that it saves
>>>> the ~100 bytes per lookup? Would it be cleaner from an abi perspective
>>>> to just reuse fuse_entry_out and ignore the attr fields if they're not
>>>> necessary? The reason I'm asking is because I'm looking at how you're
>>>> doing the lookup request reply to see if the fuse passthrough stuff
>>>> for metadata/directory operations can be combined with it. But I'm not
>>>> fully understanding why fuse_entry2_out is needed here.
>>>>
>>>> I'm also a bit confused by why the compound with statx is needed here,
>>>> could you explain this part? I see the call to fuse_statx_to_attr()
>>>> after do_lookup_handle_statx(),  but fuse_statx_to_attr() converts the
>>>> statx reply right back to a struct fuse_attr for inode setup, so if
>>>> FUSE_LOOKUP_HANDLE returned struct fuse_entry_out instead of struct
>>>> fuse_entry2_out, doesn't this solve the problem of needing to compound
>>>> it with a statx or getattr request? I also noticed that the statx part
>>>> uses FUSE_ROOT_ID as a workaround for the node id because the actual
>>>> nodeid isn't known yet, this seems like another sign that the
>>>> attributes stuff should just be part of the lookup response itself
>>>> rather than a separate operation?
>>>
>>> First of all, thanks a lot for looking into this patchset.  Much
>>> appreciated!
>>>
>>> The main reason for swapping the usage of attr by statx is that statx
>>> includes some attributes that attr does not (e.g. btime).  And since I was
>>> adding a new FUSE operation, it would be a good time for using statx
>>> instead.  (Moreover, as new attributes may be added to statx in the
>>> future, the benefits of using statx could eventually be even greater.)
>>>
>>> This was suggested by Miklos here[0], before converting the whole thing to
>>> use compound commands.  So, I was going to use fuse_statx in the _out args
>>> for lookup_handle.  However, because the interface was getting a bit
>>> complex with extra args (and ext headers!), Miklos ended up suggesting[1]
>>> to remove attr completely from the lookup_handle operation, and use
>>> compounds instead to have the full functionality.
>>
>> Thank you for the context and links, Luis!
>>
>> Using fuse_statx over fuse_getattr makes sense to me for the new
>> FUSE_LOOKUP_HANDLE op but the part I am confused about is why it needs
>> to be compounded. If we are adding a new struct (struct
>> fuse_entry2_out) to the abi, why is it not simpler to just make the
>> new struct something like:
>>
>>   struct fuse_entry_handle_out {
>>       uint64_t    nodeid;
>>       uint64_t    generation;
>>       uint64_t    entry_valid;
>>       uint64_t    attr_valid;
>>       uint32_t    entry_valid_nsec;
>>       uint32_t    attr_valid_nsec;
>>       struct fuse_statx stat;
>>   };
>>
>> and avoid the compound stuff altogether? Is it because that would make
>> the struct fuse_entry_handle_out too big to be stack-allocated and
>> would thus have to be heap allocated? But if I'm recalling correctly,
>> the compound requests path requires heap allocations as well. Although
>> at that point if we're gonna have to do the heap allocation, then we
>> might as well just also embed the struct fuse_file_handle inside
>> struct fuse_entry_handle_out?
> 
> I'm open to drop the usage of compounds for this, of course.  In fact,
> during the v2 discussions I suggested here[0] the usage of a similar
> struct fuse_entry_handle_out.  Using compound commands was a way to try to
> simplify the interface.  But maybe at that point I was too quick at
> jumping into the compound commands suggestion.  It may make sense to
> reevaluate this decision if you think it simplifies things, specially for
> passthrough.
> 
> [0] https://lore.kernel.org/all/87zf6nov6c.fsf@wotan.olymp
> 

Many thanks for your work on this.

Just FYI We are also interested in the kernel-maintained filehandle,
which can dramatically help reduce the memory footprint on the FUSE
server side.

It just seems that the overall design is still not clear right now.  I'd
like to and would be happy if I could help any.


-- 
Thanks,
Jingbo

