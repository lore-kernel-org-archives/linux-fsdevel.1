Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794498974;
	b=aZYX7EEupQT5BxAu/J4zSPEHP7vi+n086btRD/9uZxmiguOgmOPKD4fKyeXX2CIeGMuf
	 xwG1kQW5BcEoBB9y5Y0X3ZRo2ePveLdYRtIPehNgAqnGN8jmqCLwQ188O/plQk70/saUK
	 suzZo1ieZPcCHVbnZfINpMgc7SSWcu8f9KDo1ChoKNAfOiN+Ld1WmKsxGhFQXIhsK/e8L
	 QonyJMFCAz820z7QlXAf6jfQAyKY26Lex4Z/uY9VCG59g/gNu87XkfuB91uBjK1bjkdgW
	 WuxRiQZbFSzCQKJLhIZaBCVS2YiFWEo1+/iS75dRVoeHdwx6E3ExBEj+pO2FBMDIh9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794498974;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=t5MCX39uElepfVtTvuZHVglCqNrm+Ac5neZ1hbGO2lg=;
	b=3YvNflz92MFhTAfByqNZmXOKvZnuq8qO/4QyemNb8dluXqdcpX43nXefAIoDLJXp4d99
	 4LycRrlzX+OkQuXSMpSAeQ2A8IGvAPdlo4RiHEgopSgkQiQYKl1INrCMagmYkBWoBPV/T
	 edhBP+rb53pS3bwAkW4yUnkaGDUt/+PiKK4NoJkxJzxUpFVg0gaSus0ry16GXxkceiJsj
	 Y0d/HIZR8OuBZQ8VQcmPidLBoS2M3Qeaov19H90/bRBab9jooa3QPJkaf29RYKbuOUOwy
	 UPT7uOrZap9fcejIxAyCVmMQg0cFyb23t9+bpnDTp3iBlMoCvYdjZmiVjzNdcs0lk/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=qTIXmb6I;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=y+JcAziL;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10DD606A32D
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 15:56:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D10DD606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=qTIXmb6I;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=y+JcAziL
Received: from pps.filterd (m0499198.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACFXqLv3952490
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 10:56:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=t5MC
	X39uElepfVtTvuZHVglCqNrm+Ac5neZ1hbGO2lg=; b=qTIXmb6Ic6MlwXZjV3kT
	fn+T3+gZsaoRNrwfJOLTfI7WERkwtLdWJNySW3ERtXHj4X9ojddNHnFnRMdDxE5/
	pIarWQXZiZiMSqTxtZPRoYZ1alPM3+1dw+bo/Q8HzY+0dRNd2SddSeI44/SdsB9Z
	u7yQKYt1a6eH3GsCPJzW1fKyYPwr7aSOgJPyFZnU8QroVLJoDqkm4FiKAwBsY/eR
	ofi6ao3yQVfyz2CpmqAalgjsxeSxdy/AgeDcUM1iDvz9MtGc6ArdcHUkBWG7uFPR
	x6S5pEGTpAm2jdbfxy6S9wYYUcscTTcMY6nI9HAebPLvETvNFl1KuTBVipLVx8ZP
	ig==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4hwft28ftv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 10:56:11 -0500 (EST)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91256a7b7b3so71127536d6.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 07:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794498971; x=1795103771; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t5MCX39uElepfVtTvuZHVglCqNrm+Ac5neZ1hbGO2lg=;
        b=y+JcAziL4iSGXZwGyzlBXeZg3g4rXFZumTN1iIh/MMSOJIDRCdtyzMqYl2BYft9rkS
         09b7Lkemww4IKXXkXkRGvjJgwvHdqHJNpGOaEvhBK9if4ArAsiT5v3zBHUtjSayHm15m
         nh4A4QpL2g0X5J7pscPdrOJB0HC4aTNlcyXqRcZj/u9h9E/wlrYWv3nNBHEUPj70DSun
         Xohe619/Ndp/C8DYKIkSQRszIOIGJXNXMK8aB8QlRFDMrwvhPTf1AYegeGa9IZcKnRyH
         PCU/AwqLBfid7ZTnWJsPiHafelpfUTB8R1nVExJmC4gpQxld/LP8GPI4v5/Er6ciylEN
         5a7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794498971; x=1795103771;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t5MCX39uElepfVtTvuZHVglCqNrm+Ac5neZ1hbGO2lg=;
        b=qhTGtu+C9FsrkktW5LIbWx0XsCn/Qqa/l8iwaiz1445t56AxLV7A/8kUQqI+Mrtejq
         Y3R62b+pwhANpW6b46JVzVLN8S2zwVN/yzxzl2i8BSPrhEoHiwAcPrDF6hYM/PKz5Sj/
         eXu3Pb2W54+TaFGwbNOZkmYG/iGWRJFXjSoznmkwzNCvkvM+unR+QoC+BnDHrq8AzWr5
         a/cJ+pNups+FTAlVPDUjJAyCZwRVi9A85qbpvm144nEZjv0b7VW/NH/JccJ7Fo/jiXAG
         vwNEB3ofgS0Vcw9V7fjkedmzVW4b/SOUXgscZlcl1g7KNbcEavFgcFWwk0fW+E0Yae1Q
         /sWQ==
X-Forwarded-Encrypted: i=1; AL+hErGsM65PbagvtiENrKa+JnB9mFRGAPwf5TH+YRkjbflbl8nT0MFeJRCjpCA1SphZv+X/ElYFLAcgeHkQf5yz@vger.kernel.org
X-Gm-Message-State: APuU4Z9v41o4XaAoPKMOnVPh4ZBMo5o5QN3YaYBD0k7F2hzjdSMLtY4B
	r9pxG+sazp2WDCaIlAvUFxLqGaOQHvQZUVnJpivE0O34KcfjuC+6Jw+PINcgDLjucLL40Fa3kGf
	+KwA5wzxTa6WNmzCzFnp0txzFvSgehzJesRGlJjlEAf4Abf5o0xp7HHwRlmzUZlQ=
X-Gm-Gg: AYBFou0DNpnqGmivLFmzVNMto138XuOugP/02b+Hk0x3+UMbEso/ch8fa3Fexi95Ez9
	yMp5VElsANO6wWyuGuJCXgmC2h8WveTSfvfYnk/TFoaDsEB9lkUijOchOl6bYVeYqj+xTUV5cFI
	etB/lRCTY4HpsCQUGSeKYWVBRMGomkaiDpBrnbXH4Tn1udBLA9zZw4WULUpWl8qUcq8wIBY7DgW
	DfH62UJFah9Uz/Z9TOqDJ+b6MMXi6mei6p8EwA4Bui4nWkFnRlUvoP9SdhoB74acagmelOP+93l
	QxGnLDyDnHgOAV7cbjsiyiRjQzxeu+9/IBCawT/g4GSyE3tmzZw+mVrWOFsCZA1PMV+e3p71f0G
	UQXmu1M/NHMuI2sgrNa49knYbkum8IxAAkGuYpcSuPtnDMZZoDpiFhFkXXXhdORBFDzcZmBCmUG
	HpyQO2ecDPqiKAx9TJc5ftYQ==
X-Received: by 2002:a05:6214:85c2:20b0:91f:136e:e90c with SMTP id 6a1803df08f44-91f136eec29mr39816076d6.53.1794498970950;
        Thu, 12 Nov 2026 07:56:10 -0800 (PST)
X-Received: by 2002:a05:6214:85c2:20b0:91f:136e:e90c with SMTP id 6a1803df08f44-91f136eec29mr39815616d6.53.1794498970297;
        Thu, 12 Nov 2026 07:56:10 -0800 (PST)
Received: from [192.168.1.62] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ef031c7dasm74341706d6.1.2026.11.12.07.56.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 07:56:09 -0800 (PST)
Message-ID: <f76cb2b0-0090-4554-9169-5cfff6a6ca53@columbia.edu>
Date: Thu, 12 Nov 2026 10:56:08 -0500
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
Subject: Re: [PATCH 11/12] mm/madvise: send UFFD_EVENT_REMOVE when installing
 guard regions
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport
 <rppt@kernel.org>, Peter Xu <peterx@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Balbir Singh <balbirs@nvidia.com>,
        "Liam R. Howlett" <liam@infradead.org>,
        Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Andrei Vagin <avagin@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>,
        Muhammad Usama Anjum <usama.anjum@arm.com>,
        David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang
 <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
        Kiryl Shutsemau <kas@kernel.org>, Chris Down <chris@chrisdown.name>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        =?UTF-8?Q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>,
        Michal Hocko <mhocko@suse.com>, Mike Kravetz <mike.kravetz@oracle.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20261111-uffd-state-fixes-v1-0-00713d368976@columbia.edu>
 <20261111-uffd-state-fixes-v1-11-00713d368976@columbia.edu>
 <avWW5t1BiD7pbzIZ@gremlin>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <avWW5t1BiD7pbzIZ@gremlin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=arknmiZV c=1 sm=1 tr=0 ts=6af5e19b cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=BpGzv1V74M3SfeTrGa8v:22
 a=uherdBYGAAAA:8 a=VwQbUJbxAAAA:8 a=Byx-y9mGAAAA:8 a=MsTJSH7eipKYaIDY7ewA:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: dbRFUDDdEpiiKNl8LixUuLvX52YyR1Zx
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA2MyBTYWx0ZWRfX5AE1Sc66si7x
 FNcNQM/Ibx8PfvwzWrY/fmYjJLK0tjFT6975t5VfJv53mgatXv2EAQLygDE7bXoAIHEQ/Uenecm
 sgkODDNNzCJD+UI/ttN6mWwNS5l/Q38t4K3WCnzNacNLCPwlywvE
X-Proofpoint-GUID: dbRFUDDdEpiiKNl8LixUuLvX52YyR1Zx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA2MyBTYWx0ZWRfX+6MElsvNSvHA
 n6BOxhWgRZBTZahRLlu0H1tJ/gygu/TmjrvsmpRtSNeRMnvZZG4teO6g3f3DVBxR93jn82kjthk
 RhnIGgLRTOzlSCD6SnuUjtGXtkv9je//0a9ggwieNwBim8w3JRK1Mt79q7UpTH4+0YIXQ5geFOK
 iAb/jKi855mmXEzDjOdN9f9tkTa5NLJ6af9XTb0vWxk0VZaGAnZLuHnRdm12WillkTz+wifMoyD
 5kYQa34+sJFyqeliqUxxpBjNKpsllWC4JNfG3db01GfLAVDTtb9tQarmoD/D0Y5+ap/4kgrh4Wv
 AX0kJMOiBRxLgwKly1Cs+QV9Fp5r9lKnlpEQa7o9lRQuY19st5taHgstsQGfC54Ax862p1vsOsW
 LtOPDbSbH6ZV3x+4SboEBDPVTiPgytYisw/B7t0jUvoPizjacyMazSBqq2qteyn/TWGQtPn7A1K
 nZcs5vYnGFegoZKnhUA==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11964
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 lowpriorityscore=10 impostorscore=10 malwarescore=0
 priorityscore=1501 suspectscore=0 bulkscore=10 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120063

On 11/12/26 6:03 AM, Lorenzo Stoakes (ARM) wrote:
> On Wed, Nov 11, 2026 at 12:55:19PM -0500, Tal Zussman wrote:
>> MADV_GUARD_INSTALL zaps whatever is mapped in the range before
>> installing the guard markers. However, unlike MADV_DONTNEED and
>> MADV_REMOVE, madvise_guard_install() does not call userfaultfd_remove(),
>> so the userfaultfd manager is not told that the pages are gone.
>>
>> On an anonymous VMA, the zap drops uffd-wp and RWP protection along with
>> the pages. Writes and accesses to the range after the guard is removed
>> are then not reported, and the manager cannot know that it has to
>> protect the range again.
>>
>> To fix it, send UFFD_EVENT_REMOVE before zapping. Guard install on a VMA
>> registered with userfaultfd already takes the mmap lock instead of the
>> VMA lock, so we can drop the lock for the event and look the VMA up
>> again afterwards.
>>
>> As with MADV_DONTNEED, the call can now return -ENOMEM if the VMA goes
>> away while the lock is dropped, or -EINVAL if it is replaced by a VMA
>> that does not support guard regions.
>>
>> Fixes: 662df3e5c376 ("mm: madvise: implement lightweight guard page mechanism")
>> Closes: https://urldefense.com/v3/__https://lore.kernel.org/linux- 
> mm/3f4b0d1b.bbf84.1a1c55cb666.Coremail.18670333770@163.com/__;!!BDUfV1Et5lrpZQ! 
> T5BLvK-D7GgO7Y87n7ULpXAEzR6V57uNMU7saDR9ShW05mDBxMyqFA4DD22Nbycn_r7rhjPtEZp8gBAN$ <https://urldefense.com/v3/__https://lore.kernel.org/linux-mm/3f4b0d1b.bbf84.1a1c55cb666.Coremail.18670333770@163.com/__;!!BDUfV1Et5lrpZQ!T5BLvK-D7GgO7Y87n7ULpXAEzR6V57uNMU7saDR9ShW05mDBxMyqFA4DD22Nbycn_r7rhjPtEZp8gBAN$>
> 
> This report was super-synthetic AI slop
> 

Will drop it

>> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> 
> Sorry I hate this.
> 

Don't worry, me too...

> Since this was already silently broken, I think the right solution is to simply
> disallow guard region installation for uffd-armed VMAs.
> 
> I had the AI go look for users, and it seems nobody is relying on this (glibc,
> android, CRIU, etc.), and there's really no sensible world in which somebody's
> combining the two. So I think fine to do that.
> 

What about CRIU restoring an application that uses guard regions?
CRIU registers the task's memory with uffd MISSING mode for lazy restore, and
if the application (e.g., glibc) is using guard regions, this could break.
I believe glibc falls back to mprotect() after guard installation failure,
but I'm not sure about other users. I agree that there's no sensible reason for
a single application to combine these two, but uffd manager mode is where we
get these fun combinations...

Re: "silently broken", WP and RWP are more broken here than MISSING and
MINOR modes (due to the issues in the other two guard patches). MINOR and
MISSING mode already work today, modulo this event notification. If the CRIU
issue above matters, disallowing guard regions on WP/RWP VMAs could be a good
middle ground (and of course this should all be documented somewhere...).
Otherwise disallowing guard regions on uffd entirely sounds reasonable to me.

> It was simply an oversight (reflex action is to disable new features for hugetlb
> + uffd)
> 
> I'll send a patch separate from this, please drop it from the series.
> 

Will do!

>> ---
>>  mm/madvise.c | 23 +++++++++++++++++++++++
>>  1 file changed, 23 insertions(+)
>>
>> diff --git a/mm/madvise.c b/mm/madvise.c
>> index e8b05dc899f1..6413f0e65381 100644
>> --- a/mm/madvise.c
>> +++ b/mm/madvise.c
>> @@ -1166,6 +1166,29 @@ static long madvise_guard_install(struct madvise_behavior *madv_behavior)
>>  	if (!is_valid_guard_vma(vma, /* allow_locked = */false))
>>  		return -EINVAL;
>>
>> +	/*
>> +	 * Installing guards zaps the range, so report it to a userfaultfd
>> +	 * manager like MADV_DONTNEED does. The VMA can change while the mmap
>> +	 * lock is dropped for the event, so look it up again.
>> +	 */
>> +	if (!userfaultfd_remove(vma, range->start, range->end)) {
>> +		mark_mmap_lock_dropped(madv_behavior);
>> +		mmap_read_lock(madv_behavior->mm);
>> +		madv_behavior->vma = vma = vma_lookup(madv_behavior->mm,
>> +						      range->start);
>> +		if (!vma)
>> +			return -ENOMEM;
>> +		if (!is_valid_guard_vma(vma, /* allow_locked = */false))
>> +			return -EINVAL;
>> +		/*
>> +		 * The VMA may have been split while the lock was dropped.
>> +		 * Handle the part in this VMA. The remainder is handled by the
>> +		 * next iteration of madvise_walk_vmas().
>> +		 */
>> +		if (range->end > vma->vm_end)
>> +			range->end = vma->vm_end;
>> +	}
>> +
> 
> (separate rant - that we have to a. know to do it and b. write duplicative
> open-coded crap like this is a perfect example of why uffd is such an utterly
> broken mm feature that should never have been merged...)
> 

But where would be the fun in that... ;)

>>  	/*
>>  	 * Set atomically under read lock. All pertinent readers will need to
>>  	 * acquire an mmap/VMA write lock to read it. All remaining readers may
>>
>> --
>> 2.39.5
>>
> 
> --
> Cheers, Lorenzo
> 

