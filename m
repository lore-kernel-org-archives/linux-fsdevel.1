Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD364A2E1B
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Sep 2026 14:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788359658; cv=none; b=e50Rar0yCv/kWqmHLkborWQCk5fg/uiP8CYzb4ocLUbb92uVPg071EICmemX8qfu2x7KmWi0wZeT/9/kh/NbUffXcUIX/fubcNfOnZwnniImNN+7k0A89ifDhWB2OOnk/qAot/7xsvG2sDwiXz1WqRp0ikr+RDHumE7ZsLUfW28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788359658; c=relaxed/simple;
	bh=FiIj8Mu/M5MlHNmrXdICXLmZM0g6OmS6W32hmfXxyIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tbql1+MrN1RBHoXFqbW6BPQaBcbU7JXZDciT0Z0iHwgU4/X7WV6FbiW7Mq/GuaOztpKu+bBe3hKQSncrH4XlaBs4GcNR0/301841MhBBYzyBwblC+azKAIRqIR8iWE4Gc4FcDXqUH8D39xTKuKpryPORLVxjwwYDBbYnrSqWdjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=leWXjE2R; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=473BFwJt; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="leWXjE2R";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="473BFwJt"
Received: from pps.filterd (m0499198.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682EWC4M767822
	for <linux-fsdevel@vger.kernel.org>; Wed, 2 Sep 2026 10:34:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=5nq8
	F0xboXei8La9m4xhYCwKh6IJ8CtNFoD7hWN6IF4=; b=leWXjE2R9OMgS3Kr0MGQ
	pxvMVDL8XeBDSu8+tM3NjwSGeKHPK/86EjabJLTaUdwjcOSc6YCNjyAw59bFet6l
	slMFCA2Jbtpu453vxYOn0S9QBcmFmrc0gq4P2iBRc8CsONhhH153FBkBoZHUFWU0
	hED/3nH+IC68PvBWJUIgOET0yyDcdzYF58uAeJ7UfWnpaQtEEoHFhzSrg/QLPDKN
	w1CROv6PeuNr3zPiAYkl3wMFIyaai93LdbcTcmAiDFBqkgXQWZKAFtxMJ+2N9LIM
	C86ETTwNnCaUqH9PEa3+OitF6/CUInUyrWuWzu72yWxkfSI1+kMD94DLaI3DqLPM
	xw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4gegv7t15u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 02 Sep 2026 10:34:10 -0400 (EDT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-9394ad7f64aso237862285a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Sep 2026 07:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1788359650; x=1788964450; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5nq8F0xboXei8La9m4xhYCwKh6IJ8CtNFoD7hWN6IF4=;
        b=473BFwJtv8fb9QlE4XHatj1/Ja3+wB3VlHiShNVgqMwE+wbvP/RqQms+J9ANMK9nVb
         y+3nYZQUw6grXcxbpo7UBytAxcO5qxnGYMWSMH3qTXh0I7caxZyftk4iwyPxORgr8Tvg
         R2w6ZRnYv2RylFsJcek5BeYrxKyKExiC6QiZwViwaGaKSeKPeCg+0zSmz/rhnb0mnroW
         fJ5mq44iANv8gy2NHzIbzqtQQhiEDetScptWVg4NGFwa8+OzNXjDtjLAEuxpVAfuHWS/
         D3amJ/fix343jnZN4IQezuxra2Rs4Gh8A/y+kVn+H5SghVGFstnfegWzDdml/h3talSR
         iWKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788359650; x=1788964450;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5nq8F0xboXei8La9m4xhYCwKh6IJ8CtNFoD7hWN6IF4=;
        b=JSNGKXb/v+0sf68hhKZqlJHcXeXCW5JVygPpwITWFx9BHVpc0kJeKrIRQeFWxo3LiQ
         4MIYv4QQvYiHGbgaS6uqMX8crcWYp+7MCfdDeLCEntCNLCNZsiJXAOeIJoeW8ftWA3J8
         LCRzNLW22bN/2BncE+B5DI+iaTNJGfm8/rjWWciyS9gdsU3ZmEH/dG6cTQjgYyJ+8IXb
         zqmU6E9YvCR2VIQvslkuKu3VpTHMv8nKveYCQiy2Yrpl/tt7d1PV6QDDz3IBA4Yc3vEY
         3s8fbzL7+cMOekccvfi9pGGGRS0Hy6kcrc+oF57szXz1RBIvJPJl0iStBFErv1Q2+LoH
         ELHg==
X-Forwarded-Encrypted: i=1; AHgh+Rp92iWiaF/VvWeiDKc8BwcH/JJMDuJw5Bqhycp9ykZuVpfS029bxR/gh4LspcQRdSbLmOEmS5psyOc8p3NE@vger.kernel.org
X-Gm-Message-State: AFuF++lN3LMJcnhA9OXxj4mu4u+NfyBYLfgZklDQF2x9/gh6YFbTdVCD
	Xc4/cOxEmgGe1jID64e6P4E6XhEfDsYxInF5h0ETcVzdGO7FHMA8g7wraWEPs3FFk+cOq90QbFO
	dOmlEOkR0buSGmyRn2xQrr0uQ7HFFxGClvFHPBn7qMTHbzc8319WA+yf4cVHwV98=
X-Gm-Gg: AR+sD13agAdekgqqh4tuHlAHQ0a760ocpwrFd0MFeS2s/r+Qec4CkQrGsxtp+nyH8XM
	ePCHR/2789JsTHw+dBaujNq5GV9BZw8HrL8C4JJ/zuRZ2PC5PeZ40do15SH5S+dKQlaX6Cusaeb
	qdy3Fk9aA49KAimtnQVY9CFPymzuHFYKkPiVwT/P6frZdIqKMw4ab22+o9ex4HLECe1gfdQTuVk
	nTOT/1V2K9HNzH4+KPjy2uTdf31Red9koQHf8HTiu3377oYzlnQpdTz0w5oowCUt6SttXLobtpA
	HUnLmtpFNtTekgrI03fT2+CMXfMTYsp0JNc75fcR2EZIddoGtIbADcPioZ9/pys9N8p9o0d7512
	MrpsO/D45XYpCJoHacdBtRoOki3on3muEV1yrJHdvqDn1+NqpQur7Znx05Q==
X-Received: by 2002:a05:620a:3196:b0:92e:71bb:d1c0 with SMTP id af79cd13be357-93960dea964mr622057885a.15.1788359649518;
        Wed, 02 Sep 2026 07:34:09 -0700 (PDT)
X-Received: by 2002:a05:620a:3196:b0:92e:71bb:d1c0 with SMTP id af79cd13be357-93960dea964mr621987485a.15.1788359646377;
        Wed, 02 Sep 2026 07:34:06 -0700 (PDT)
Received: from [10.207.49.22] (nat-128-59-178-193.net.columbia.edu. [128.59.178.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25d043e6bcsm152362966b.61.2026.09.02.07.34.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 07:34:05 -0700 (PDT)
Message-ID: <dac0f543-4687-49eb-87ae-500ecf32112d@columbia.edu>
Date: Wed, 2 Sep 2026 10:34:01 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/10] ceph: fix error handling when the OSD client is
 stopping in ceph_submit_write()
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko
 <slava@dubeyko.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
        "Liam R. Howlett" <liam@infradead.org>,
        Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Zi Yan <ziy@nvidia.com>, Christian Brauner <brauner@kernel.org>,
        David Howells <dhowells@redhat.com>, Jeff Layton <jlayton@kernel.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
        Sashiko <sashiko-bot@kernel.org>
References: <20260817-remove-wait-on-page-writeback-v4-0-0e5e53d47eb0@columbia.edu>
 <20260817-remove-wait-on-page-writeback-v4-1-0e5e53d47eb0@columbia.edu>
 <CAOi1vP8SCZaFTodwm3_c9cFfc4UB5X8J8vF-sxh+4TuhCS8iog@mail.gmail.com>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <CAOi1vP8SCZaFTodwm3_c9cFfc4UB5X8J8vF-sxh+4TuhCS8iog@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: VDDAM_-v8RNAjecyk06LXhrd3T1xD4M2
X-Proofpoint-GUID: VDDAM_-v8RNAjecyk06LXhrd3T1xD4M2
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDEyOCBTYWx0ZWRfX1yr2KDz3w7Hn
 VpZFd3XPM3I5RNCAnlPOT1Yl8HRBAAu29BTB9urwGsHvgdhapqhmIvkx2K2MQsiqtrp8fBa3gcM
 K2IE8rO2wgt+G1DYq46XSv7gubbWgG22dNY7QYubt0mvmWUKGouQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDEyOCBTYWx0ZWRfX60Lr4FBNN2l8
 5Zduy5pP2/EYZ8L0IJdXwT0lnjDIT94YVKnIV2Ze6Mxn2eLOElUJ9AxYiQNCYSBpP42mAu2W5zo
 2CenYGLyItSZ2ZPI4WnUfT72+iOqsVDNq5luTiqAv3rakDfp2AE/VOuQJ1AcHP0SWqBd6thD6Vz
 UsU124+WTEfXscQKxRjtMMARQwMLt+YHcAYsBWoDu+ddb3dOR34acnv8Ui+vc87wxmM/Wp/nlAL
 u+5HVJ23hL1viXN7tlkFpX1f/+wGXSfkrlxAmYpKI8OThp5mdJQcsBfmTvSxYx+Br7CWMm80bdE
 5Gt+KcXnqCOJH5ka7azKNLjfeWs0xuHO/rls34DCvpUwX2M0VuUcw4STKEbHvJZ6KlJBvSTuaeI
 YgKbkyi9jfAW/QFrujnoDTcDef2KZc7rPNQsFa49pGaIwNQyCT4USBI6+DVx0xOlgtEeCC9QMuz
 XUIK3SBvOK7wEwuSlSA==
X-Authority-Analysis: v=2.4 cv=JcCMa0KV c=1 sm=1 tr=0 ts=6a9833e2 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=XwBYxoxBwSosfWEfMcqm5A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=BpGzv1V74M3SfeTrGa8v:22
 a=uherdBYGAAAA:8 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=TZ2kbKYv5CYyi6T0hQQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11894
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 spamscore=0 suspectscore=0 adultscore=0 bulkscore=10
 malwarescore=0 clxscore=1015 phishscore=0 lowpriorityscore=10
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020128

On 9/2/26 4:44 PM, Ilya Dryomov wrote: 
> On Mon, Aug 17, 2026 at 9:15 PM Tal Zussman <tz2294@columbia.edu> wrote:
>>
>> When ceph_inc_osd_stopping_blocker() fails, ceph_submit_write()
>> redirties and unlocks the folios remaining in ceph_wbc->fbatch.
>> However, none of those folios are locked at this point: locked folios
>> were moved to ceph_wbc->pages[] and removed from the fbatch by
>> ceph_process_folio_batch(). Unlocking them triggers
>> VM_BUG_ON_FOLIO(!folio_test_locked(folio)) in folio_unlock(), or
>> unlocks a folio locked by another task.
>>
>> This error path also returns -EIO without fully cleaning up the folios in
>> ceph_wbc->pages[]: their references are never dropped, fscrypt bounce
>> pages are never freed, the writeback congestion count is never
>> decremented, and the pages array is leaked. ceph_wbc->locked_pages is
>> also left non-zero, so ceph_writepages_start() loops back around and
>> hits BUG_ON(ceph_wbc.locked_pages).
>>
>> Leave the fbatch folios alone, as ceph_writepages_start() drops their
>> references when releasing the batch, and unwind ceph_wbc->pages[] the
>> same way writepages_finish() would have. Abort writeback in
>> ceph_writepages_start() instead of continuing, matching the handling
>> of ceph_inc_osd_stopping_blocker() failure on entry, as the OSD
>> client is being torn down and further writeback cannot make progress.
>>
>> An LLM was used to verify that the cleanup was comprehensive, and
>> suggested aborting the writeback instead of continuing.
>>
>> Fixes: 1551ec61dc55 ("ceph: introduce ceph_submit_write() method")
>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>> Link: https://urldefense.com/v3/__https://sashiko.dev/*/patchset/20260804-remove-wait- 
> on-page-writeback-v2-0-81f0ab065284*40columbia.edu?part=5__;IyU!!BDUfV1Et5lrpZQ! 
> WQ0-twAxqcZ2nQ5MBrBDnqIxwPV4RXuFNZvUldEY6jTQafdUjhi46Zgym70Ltd8gwAKpSl92mam7YO- 
> tlU-7hw$ <https://urldefense.com/v3/__https://sashiko.dev/*/patchset/20260804-remove-wait-on-page-writeback-v2-0-81f0ab065284*40columbia.edu?part=5__;IyU!!BDUfV1Et5lrpZQ!WQ0-twAxqcZ2nQ5MBrBDnqIxwPV4RXuFNZvUldEY6jTQafdUjhi46Zgym70Ltd8gwAKpSl92mam7YO-tlU-7hw$>
>> Assisted-by: Claude:fable-5
>> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
>> ---
>>  fs/ceph/addr.c | 36 ++++++++++++++++++++----------------
>>  1 file changed, 20 insertions(+), 16 deletions(-)
>>
>> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
>> index 1f77aec8e960..d5a349daf4d0 100644
>> --- a/fs/ceph/addr.c
>> +++ b/fs/ceph/addr.c
>> @@ -1482,27 +1482,28 @@ int ceph_submit_write(struct address_space *mapping,
>>         BUG_ON(len < ceph_fscrypt_page_offset(page) + thp_size(page) - offset);
>>
>>         if (!ceph_inc_osd_stopping_blocker(fsc->mdsc)) {
>> -               for (i = 0; i < folio_batch_count(&ceph_wbc->fbatch); i++) {
>> -                       struct folio *folio = ceph_wbc->fbatch.folios[i];
>> -
>> -                       if (!folio)
>> -                               continue;
>> -
>> -                       page = &folio->page;
>> -                       redirty_page_for_writepage(wbc, page);
>> -                       unlock_page(page);
>> -               }
>> -
>>                 for (i = 0; i < ceph_wbc->locked_pages; i++) {
>> -                       page = ceph_fscrypt_pagecache_page(ceph_wbc->pages[i]);
>> +                       fscrypt_finalize_bounce_page(&ceph_wbc->pages[i]);
> 
> Hi Tal,
> 
> fscrypt_finalize_bounce_page() was removed in 7.3-rc1, so this one and
> patch 8 need to be reworked now.
> 
> Thanks,
> 
>                  Ilya
> 

Hi Ilya,

I'll send a v5 today.

Thanks,
Tal

