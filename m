Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED09049CF5C
	for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2026 13:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788183609; cv=none; b=PGEFAmYqxvDYQC/j9WS/BJ5nf7/8JJ0CBUjh3hcV5EWlrRNzAlEqyQVv1DiEeIw28MbkJGB3mpcEMMxxobVTvCDM9EXGNVQlVxb7Czj2zQV6ytLyNfyM9ONd5nl98befgs46XCGktO3GPORBylJ1ccW5e7JUz2VevK3caQcn5iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788183609; c=relaxed/simple;
	bh=rE7h8zbq53OFhYYydlfuTPoMOMrAbYTIIR6UWRulbHQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fIFFOuIV9vh3I+i+ifFlY24AMZ5WfjG9P0A9jAUxdKKr9C0IXGZ9B1h6J14wbeoyT9tKtG8w7lo2nZFQ+TJrZGqAbuA2hfa64U0CgHr47f4rdbdVEeIY7KZsQUfG80KhAzuX3V9qUozAFb98vjQUONBRazr/7ZLn5ZuXL4WoHos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QYnTNB+o; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYnTNB+o"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d91ded8174so9975535ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2026 06:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788183605; x=1788788405; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=53920xzB8XLNSjeZIZbkJ3m9LVbpBiAgUUyw5Vt5WJg=;
        b=QYnTNB+omOwWNFOwoaUcfOupDptKIpObRIswMrhhKYJyglQwGoYNnjpla/qjNJmcxS
         O4XT03hZqdQ9aeSYO92SkTeDuOCIZo1vHhTKZxDEIyBYbQ9qSxiBI/ugKs0yit3FnKwV
         5lBeJF0qjdyfLKBSnbF9q56vd/ioN0dckZIKipVR5XX7hAr0a0b442OImj3zyAn+qdTh
         c+ErXFKzhyfzcsPpI+9vhIipZV03LL9yc3EnrFFPRmBJkJ7Xkb7Jz2Sq3IF8TY4L6CWV
         4Q/W4eGM+24psZVdM8UPNS51ObTCFOzju3I3codvuyUhQzAeX1+hgATnLumvcQkliRT3
         V14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788183605; x=1788788405;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=53920xzB8XLNSjeZIZbkJ3m9LVbpBiAgUUyw5Vt5WJg=;
        b=WDinHFioRCRW6QHJkb/pTxjx66w6aChwElqmjnYidyiKcZ+3lgBrURCGgkPdPgCfBR
         wu2Od2UYhjZtmSDiwR3gvSUTfZpjEmKUcDWR7TF2Xs1CbJB2F37dC6yUaz19PX3qVRXt
         sGyWV75eTVvJQArug1d7J38E4bHb3qTi8CVI9P7x6KEu0/BTDwBOkORY9GFkBGLVRmSO
         tooOQ22zBSMo7tSkBpitbMOzq+nApIAsgCYL9r11ZIru8Y6CCYsG8fcVCYk2jlR75x1Y
         Z0wvigVMsOHYjBxW2WkB/yUXPiuum4glLWTl5PJ5xAcLjjgYXS9lolKtfLRovNdZg9Uz
         eoHw==
X-Forwarded-Encrypted: i=1; AKwUvByodA+0Mfa0NFhhZbZB3WuRijbGj6FHOVoYozRkKawuCmErtCOi7AccRmvZQCRdFoh9EdnIQDlYpuQjQgj4@vger.kernel.org
X-Gm-Message-State: AFuF++ma3kgOlzJthiABJK9/2uWYmORbzq3rqiUqZcKJqehOb6lLuLXh
	wi5CfBGJWxpOmXy6iO4j0QC1fle2PIt2XKwxPSKum7MEGNPp/bU2dZU6
X-Gm-Gg: AYBFou3xraKK9n6lfNbioesB9dHbDdf2n4gpFYZL3nUhfZWrBjKYwI29snYFDgELeTu
	F8QwDeAvlydrW1RkYHDqSkEswk4CsA/XbRYQWH6tg89vAKBMnTWLCnDVM7n6ZNMhQxFEV2r1Qko
	D5qvgoiz+gcmZxEeKyV9h6WJRgu4SrETD+2ew5onNX0RF3+aepYgJOa9hZfhRd4oih9NJQV49Oi
	l47ngAOcsTGuZorI1MpWeaPKRT8Ddkboo/vFNHdOQ1uS1f2+TB7G2jzGjaIhYYGaOgQknMtJXO+
	oFQC7iT8iFIotOVl87cV+lS9/fYbRzo0OhzzTAyXOJ2BV2VLYxy837TlKPGUgA0ukMBHc/EAj3D
	KzCZyACTWA1PWzmX6bLEQbLseyu7LXEhJVIIQBC/4PCIiRiyn6PPRwYQkoj/XJe53JEZwOyoHlr
	ah4TcYTIbe9hx7otG2jkwHFfwznxpoa9ke8dG6w1fhE578CWUSjktHhQ==
X-Received: by 2002:a17:902:ce88:b0:2c9:c952:6e9 with SMTP id d9443c01a7336-2d74dca2281mr379634065ad.2.1788183605112;
        Mon, 31 Aug 2026 06:40:05 -0700 (PDT)
Received: from localhost ([45.112.44.97])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286fa20e2fsm30550306eec.28.2026.08.31.06.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 06:40:04 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date: Mon, 31 Aug 2026 21:36:33 +0800
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>, catalin.marinas@arm.com, 
	will@kernel.org, mark.rutland@arm.com, chenhuacai@kernel.org, kernel@xen0n.name, 
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, 
	tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	hpa@zytor.com, akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org, 
	pasha.tatashin@soleen.com, pratyush@kernel.org, ruirui.yang@linux.dev, kees@kernel.org, 
	thuth@redhat.com, gshan@redhat.com, jic23@kernel.org, james.morse@arm.com, 
	ardb@kernel.org, leitao@debian.org, yeoreum.yun@arm.com, tangyouling@kylinos.cn, 
	hbathini@linux.ibm.com, adityag@linux.ibm.com, ionut.nechita@windriver.com, 
	liaoyuanhong@vivo.com, seanjc@google.com, fuqiang.wang@easystack.cn, makb@juniper.net, 
	piliu@redhat.com, ebiggers@kernel.org, jbouron@amazon.com, mclapinski@google.com, 
	me@linux.beauty, graf@amazon.com, bgwin@google.com, robh@kernel.org, 
	takahiro.akashi@linaro.org, palmer@rivosinc.com, x86@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCH v3 07/17] crash_dump: Fix potential double-free of
 keys_header
Message-ID: <apWDDWhkVMIpKWS-@Rk>
References: <20260826092541.3905933-1-ruanjinjie@huawei.com>
 <20260826092541.3905933-8-ruanjinjie@huawei.com>
 <87186b8a-f68c-400b-97cf-8ea6129eba69@linux.ibm.com>
 <fecbe6ee-12e3-4f3d-94ac-eb7cd08eeb0d@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fecbe6ee-12e3-4f3d-94ac-eb7cd08eeb0d@huawei.com>

On Mon, Aug 31, 2026 at 09:24:07AM +0800, Jinjie Ruan wrote:
>
>
>在 2026/8/30 13:59, Sourabh Jain 写道:
>> Hello Jinjie,
>>
>> Coiby is handling this issue in the below patch series:
>> https://lore.kernel.org/all/20260828084900.1496839-2-coiby.xu@gmail.com/
>>
>> Since the above patch series is all about crash_load_dm_crypt_keys,
>> could you
>> please consider dropping this patch from your series and reviewing his
>> patch
>> instead?
>
>Absolutely, happy to do so — I'll drop this patch and review Coiby's
>series instead.

Hi Jinjie,

Thank you for agreeing to drop your patch and review mine instead!

>
>>
>> Thanks,
>> Sourabh Jain
>>
>> On 26/08/26 14:55, Jinjie Ruan wrote:
>>> `keys_header` was freed in `build_keys_header()` without being reset
>>> to NULL, and the error path in `crash_load_dm_crypt_keys()` freed it
>>> unconditionally even when reused, leading to double-free or
>>> use-after-free.
>>>
>>> Add `free_keys_header()` to centralize freeing and NULL-setting.
>>> Use it in `build_keys_header()` and only free in the error path when
>>> the header was newly built (`!is_dm_key_reused`).
>>>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: Baoquan He <bhe@redhat.com>
>>> Cc: Mike Rapoport <rppt@kernel.org>
>>> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
>>> Cc: Pratyush Yadav <pratyush@kernel.org>
>>> Cc: Dave Young <ruirui.yang@linux.dev>
>>> Cc: stable@vger.kernel.org
>>> Fixes: e3a84be1ec2f ("arm64,ppc64le/kdump: pass dm-crypt keys to kdump
>>> kernel")
>>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>>> ---
>>>   kernel/crash_dump_dm_crypt.c | 15 +++++++++++----
>>>   1 file changed, 11 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
>>> index c685497cd470..ed0960ff0987 100644
>>> --- a/kernel/crash_dump_dm_crypt.c
>>> +++ b/kernel/crash_dump_dm_crypt.c
>>> @@ -363,15 +363,21 @@ static struct configfs_subsystem
>>> config_keys_subsys = {
>>>       },
>>>   };
>>>   +static void free_keys_header(void)
>>> +{
>>> +    if (keys_header) {
>>> +        kvfree(keys_header);
>>> +        keys_header = NULL;
>>> +    }
>>> +}
>>> +
>>>   static int build_keys_header(void)
>>>   {
>>>       struct config_item *item = NULL;
>>>       struct config_key *key;
>>>       int i, r;
>>>   -    if (keys_header != NULL)
>>> -        kvfree(keys_header);
>>> -
>>> +    free_keys_header();
>>>       keys_header = kzalloc(get_keys_header_size(key_count), GFP_KERNEL);
>>>       if (!keys_header)
>>>           return -ENOMEM;
>>> @@ -441,7 +447,8 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>>>       r = kexec_add_buffer(&kbuf);
>>>       if (r) {
>>>           pr_err("Failed to call kexec_add_buffer, ret=%d\n", r);
>>> -        kvfree((void *)kbuf.buffer);
>>> +        if (!is_dm_key_reused)
>>> +            free_keys_header();
>>>           return r;
>>>       }
>>>       image->dm_crypt_keys_addr = kbuf.mem;
>>
>

-- 
Best regards,
Coiby
