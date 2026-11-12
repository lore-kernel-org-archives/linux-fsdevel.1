Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794499588;
	b=cGB+F/ZQ3mIvAQprHqGwTAttlv8f7CgK7BN+ShriSQM9zulU+FP01tDcni0sG/VyUySo
	 56Pn4hZkoorzr/iynnDEKk4/UiGxk0jGZ0Db6RUHYxq/37dfhilauBz4qhzsvd/V/6ptO
	 6nBOwGwYXW2LfVe70iHIysxgmrXiBeOpVkEAlVJJePXfEtSHkGcrRP6nNiq6B0Xz/T+76
	 vOdmaDmRbc8vRorIoXJvJE2CGY+TWu4YojhMSX1NiFSBp4Vi4RayYv4jBdIgNW59Cz8rg
	 aT3UhDIjaDtdq2AhP2IZp0SFzDLbtobsuRrGa92bzn0iXUbmRpgZoFPphbfktQBSNCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794499588;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=s/0yD8XwSZcMtPhKjxGvWxzhalMi4P0RN9zUgkplp3I=;
	b=man5x8fzRMEy66jCRRr1M3iphipq78xwiw8Kv9t7I9HVtozrlqeW4FS/fvmHbnkKkXU+
	 rveDu8dYDlyXgU44AFesn1bt0oFpLj7g2mNxBL9olk4nAAWd0MWVGqLO+dfJfQGE/S9ud
	 g21vrgqMo0iWu+6vjXmflxm3DGzBhirTOVlEetmZHsO8/qsXEoFHgDfUQ2ndseZ8vRdrM
	 Ef4/G7729vnMcsarq9lNcVUkSvtZsUUCbXxxH+hwvnjVsCmp0McrRmTBQ9ZthFairgApH
	 Z0YYiEmPYUhWI4JYA6EV4+GL6Z0VdD9qhDQpec4Mv/Un7khtYnwBqdnROZOam4mJ+fQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b="U+/4y+pU";
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=koq8dKHy;
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5810606A32A
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 16:06:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5810606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=U+/4y+pU;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=koq8dKHy
Received: from pps.filterd (m0167072.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACFXvK21980109
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 11:06:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=s/0y
	D8XwSZcMtPhKjxGvWxzhalMi4P0RN9zUgkplp3I=; b=U+/4y+pUkpfDAQFmeZ09
	BltQvCuaL59sr8VUmfUen3PJ8cTOac6eFO5dnCQiTwzplouLPAndcc8p4GIexEQK
	UJEcEcyMBDEzf5xhAwPSz7lO9RgN8BuMgBrQaQimDgBX0pGy6s0UqUQjhJ9NpZ2k
	ukrOYbxDXqyaGOqG5VVhWnklyNWT7rOrQgV46051NXipQHgGh3B9ngiuDILR2TpQ
	IBU6hkSfwvdYT9RG5nihfk3romNw4nySl2w4ECXSy+lMqpqHDilTS2YPBgC/PnK7
	bwzf5oVzpQCMvwHWtZCXM2DNgHMqdX4sk6ewMRCSTtbAviLTewgSO4PenXDbRkHz
	Qw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4hweerhk08-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 11:06:26 -0500 (EST)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-91ea5866643so84252336d6.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 08:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794499585; x=1795104385; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s/0yD8XwSZcMtPhKjxGvWxzhalMi4P0RN9zUgkplp3I=;
        b=koq8dKHy4IzTMST8ASybfjkhRAKBRrxIa8M6gt0gfxvWB45ce5izVyxEAWxjiXTXTK
         ndPiOUgXdoatCQNhXvPZyRPf/Wq4qG5wkGsNSS9hGWukvBfTrnEl8pADQ6x+7ofxlGpi
         WjPw0E+Q3TCFi6ByHKLSpv0JZMN7Qw+zg4YUQISoDy5IIPNgmvbRWhaUwCTCClcsIIMj
         td4dQBLjJ/ZmOaLjkdWi2yMBCkCFL559OYs+Uu1x6P7DeYpfk9R3Uc4mOGgcdFXEiH4Q
         xnWhgSXHIsBi4geU7o9OmkA0uUMw8Hpioz63wPucFPd65yw55t7NVbjGF4dJZe2ejOxS
         NKsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794499585; x=1795104385;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s/0yD8XwSZcMtPhKjxGvWxzhalMi4P0RN9zUgkplp3I=;
        b=L1TfAD+GYyuP/ztei1mvspTiwpcfAp/i3rQny9se9cOH/h/e1oJhuklWWU/85CNzuZ
         Co+YVzKeaoaVGezFuHMNOWOvxNHjl3W7i8g0zGkMdQy5MlxLNWO1+BvdwtqTGs83XeMD
         RO8hrKG+lK6cvZWVLJ6FvQ7PpIR1U7hMx8pWMRtcz41jA+W3kAQPYbbvj2DvHPsDXz3P
         iH55Ed+d7z4tBB0fCR8ieNKnIuj8h4ExUFEnFKVK6Up8ig5ohx2XQtnM0XQFMaoHsnPX
         bvH8VzpAAFGLTZ117eiemnDDtTnIbn+3nJbUnZKhz4lxWoamIDMOUHOsf+/5jdaJEDdz
         8FSg==
X-Forwarded-Encrypted: i=1; AL+hErGdzaxODeCrFESjHV8fSvZSYFXy5KcFasfzCeI2FhQ5emaDreK0oOZxmulmaGScYiLfQUpQTfi52q+Z1yh9@vger.kernel.org
X-Gm-Message-State: APuU4Z+MAJqXyZF+acHqo4+olmdRm096R+GyK+GGdLyDOiftO4pvO9JB
	pvhQdD4eV2FiDb+J6s7JlgPGSJQwShU/ZFrXw0h35mDZWfL36CNmzoJxtWm51ITCwOC5cCM87kX
	e9YHG/In7/AO5niZ/x7CAPQvzDn+tdLq/s+kBJ+BZ9x195pP7KJid8p3ikKuk/+E=
X-Gm-Gg: AYBFou2wFWeUgzENjpDs45gGz1q4cz5dGfOlWtofYLgyDZNwzkR3PKk5JMCNXi3bZ1Q
	I4X79Eb4zPFa83XWGGcp1HXh06f5YCoLZvj+sQKQfQTEhsY/Iso237GN4uT/Zw2WqG3TDnRn096
	6YOASLSEa2rLHMqPPsv4W+vxWM3iAOw2xnpKEYkuGKRW9fWrAJNneXfYXX9D8dyokV61JUEYJEp
	ZagFvCSPR8o41gVGuNA6wNZiPzl+GIoVD8BvWIpr/UWmAohLg9WRHxdpffxVum1cepLWiBvZHjO
	wXYiJy2WbncmKRweC0ynH5q9e1kVaS+hS529PG+JDqu+F+XMcmMyuKiwn2XXB7S3kyPpZbDTcy9
	i/vFCuKpW0jb2+3N1bypAqHceBMpqErgedNyByme2muswkOsP3wy0dePb0CJN0f0Lfugwi/kEg5
	o4d6lVfpBCEsfy0DjLtgxzYQ==
X-Received: by 2002:a05:6214:1d21:b0:91e:9db6:c329 with SMTP id 6a1803df08f44-91f0414665bmr103299996d6.35.1794499583582;
        Thu, 12 Nov 2026 08:06:23 -0800 (PST)
X-Received: by 2002:a05:6214:1d21:b0:91e:9db6:c329 with SMTP id 6a1803df08f44-91f0414665bmr103297826d6.35.1794499581900;
        Thu, 12 Nov 2026 08:06:21 -0800 (PST)
Received: from [192.168.1.62] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ef04fb371sm75358026d6.25.2026.11.12.08.06.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 08:06:21 -0800 (PST)
Message-ID: <e0a9ef1a-c24b-44a8-9d63-9a800b35da24@columbia.edu>
Date: Thu, 12 Nov 2026 11:06:20 -0500
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
Subject: Re: [PATCH 09/12] mm/madvise: let a guard marker carry the uffd-wp
 bit
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
 <20261111-uffd-state-fixes-v1-9-00713d368976@columbia.edu>
 <avWeNRMIU2QPGZ4w@gremlin>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <avWeNRMIU2QPGZ4w@gremlin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TPfQ2Fla c=1 sm=1 tr=0 ts=6af5e402 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=SsB-OO3BMngHh3ZO9fOt:22
 a=iDqOqAWsPJ7IfU34PtYA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA2NCBTYWx0ZWRfX/9wpbdV0wRgi
 hNI+u8crHfQVi7IwYRyK7CDSXnSwTfHo2trE02kVV/gFZ4Ve2u4vCkpP61KdM6YDAaLPo0rW2F1
 OvYG25XsLy6V3Z3D6VRb98u2TdJ7prQ1VQWQ5t52NovtVQHf/IBk
X-Proofpoint-GUID: a1UrkRrmYyDRcpZKNEMO0JTm097CMca7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA2NCBTYWx0ZWRfXwdHetEuYCq/M
 ItOFbHjgJ2nJp8DimdQb9jlE+V7auPezEDMuBqP9jpONH+2TQykBCnX3x/gNY6Ac2MagwI0XUML
 G8rIQRiEYuS328Nf2mY/1Bd/kHelQm7tzEkj+VDyqtpP04wA3vwg7VwbOiLN6Z3MAUhKY2IIDav
 vjjte3/a/rWvUwUdfvt+kIjSh/+cuDR8Hh9p+NOhAUZ9FEi2Nr8elrDg1HLXGw26Lia6GhDJFax
 LpclI7C4ePldLvfuLT3B8I3IK0t9XoDkwBFu3G9I2SYg8YzDX3f2ZxBAchKAUt3H3OMczCprOCN
 Q/PpUDEe2HxrN3gM14dP2dpr8/eFT4apkxx0qZLVAh7DjTysDoUWblk7r6srka24EOgrTT2Y1eV
 Ws6Csm0aWA14L7Gr9J7INd0pf8R82mQcfkKy4N9mF/0lwHnJdEd2bD+rmYJGascJRNGNT0x632s
 xB7uLsAeCbsq9eTCTQQ==
X-Proofpoint-ORIG-GUID: a1UrkRrmYyDRcpZKNEMO0JTm097CMca7
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11964
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=10 malwarescore=0 adultscore=0 clxscore=1015
 suspectscore=0 spamscore=0 bulkscore=10 priorityscore=1501
 lowpriorityscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120064

On 11/12/26 6:21 AM, Lorenzo Stoakes (ARM) wrote:
> On Wed, Nov 11, 2026 at 12:55:17PM -0500, Tal Zussman wrote:
>> MADV_GUARD_INSTALL can only install guard markers in a range without
>> populated entries. It zaps the range and retries, restarting the syscall
>> if the range still isn't clear. On a file-backed VMA registered for
>> uffd-wp, the zap keeps uffd-wp markers and converts write-protected PTEs
>> into new markers, as the pages are still in the page cache and must stay
>> write-protected. The range never becomes clear, and installing a guard
>> region in write-protected shmem keeps restarting the madvise() call.
>> Signal handlers still run, but the call does not return until the task
>> is killed.
>>
>> An entry that is write-protected must stay write-protected while a guard
>> is installed on it and after the guard is removed. PTE markers are a bit
>> mask, so a marker can be a guard marker and a uffd-wp marker at the same
>> time. To fix it, let a guard marker carry the uffd-wp bit:
>>
>>  - guard install adds the guard bit to an existing uffd-wp marker
>>  - guard removal clears only the guard bit
>>  - unprotecting or unregistering clears the uffd-wp bit of a guard
>>    marker
>>
>> The fault path, zap, fork, and pagemap already handle a marker with both
>> bits set. However, pte_is_uffd_marker() would let UFFDIO_COPY overwrite
>> the guard, so make it ignore guard markers. Anonymous VMAs drop uffd-wp
>> markers on zap and never get the combined marker.
>>
>> MADV_GUARD_INSTALL on a uffd-wp shmem range now succeeds instead of
>> hanging. When the guard region is removed again, its pages are still
>> write-protected. While the guard is in place, pagemap reports both
>> PM_GUARD_REGION and PM_UFFD_WP for them.
>>
>> There are two simpler alternatives, but neither works. Zapping with
>> ZAP_FLAG_DROP_MARKER fixes the hang but drops the write protection: the
>> page is still in the page cache once the guard is removed, and writes to
>> it are not reported. Refusing guard install on uffd-wp file VMAs in
>> is_valid_guard_vma() would break a combination that works on anonymous
>> memory, by adding a new -EINVAL for it.
>>
>> Fixes: f807123d578d ("mm: allow guard regions in file-backed and read-only mappings")
>> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> 
> Please drop this patch too.
> 
> With my patch disallowing guard marker install on uffd-armed VMAs this goes
> away (and doesn't make sense anyway.)
> 
> I really feel these guard region ones should have been sent separately, btw.
> 
> You're establishing a bunch of interlocking dependencies of different changes in
> this series that makes life hard for reviewers, especially given backports etc.
> 
> And now I'm having to essentially inverse cherry pick stuff :)
> 

Sorry about that. These started off as one fix and then grew a couple more on
further rounds of AI review...

I'll drop this and the other two guard patches.

>> ---
>>  include/linux/leafops.h |  4 ++++
>>  mm/madvise.c            | 28 ++++++++++++++++++++++++++--
>>  mm/mprotect.c           | 23 +++++++++++++++++++++--
>>  3 files changed, 51 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/linux/leafops.h b/include/linux/leafops.h
>> index 4c1476ae3234..add4968ded44 100644
>> --- a/include/linux/leafops.h
>> +++ b/include/linux/leafops.h
>> @@ -578,6 +578,10 @@ static inline bool pte_is_uffd_marker(pte_t pte)
>>  	if (!softleaf_is_marker(entry))
>>  		return false;
>>
>> +	/* A guard marker stays a guard, even with the uffd-wp bit set. */
>> +	if (softleaf_is_guard_marker(entry))
>> +		return false;
>> +
>>  	/* UFFD WP, poisoned swap entries are UFFD-handled. */
>>  	if (softleaf_is_uffd_wp_marker(entry))
>>  		return true;
>> diff --git a/mm/madvise.c b/mm/madvise.c
>> index 0214efd2a014..e2c6b0f26672 100644
>> --- a/mm/madvise.c
>> +++ b/mm/madvise.c
>> @@ -1123,6 +1123,23 @@ static int guard_install_pte_entry(pte_t *pte, unsigned long addr,
>>  		return 0;
>>  	}
>>
>> +	/*
>> +	 * Zapping keeps uffd-wp markers on file-backed VMAs, so add the guard
>> +	 * to the marker instead. The slot stays write-protected once the guard
>> +	 * is removed.
>> +	 */
>> +	if (!vma_is_anonymous(walk->vma) && pte_is_uffd_wp_marker(pteval)) {
>> +		const softleaf_t entry = softleaf_from_pte(pteval);
>> +
>> +		set_pte_at(walk->mm, addr, pte,
>> +			   make_pte_marker(softleaf_to_marker(entry) |
>> +					   PTE_MARKER_GUARD));
>> +		update_mmu_cache(walk->vma, addr, pte);
>> +		(*nr_pages)++;
>> +
>> +		return 0;
>> +	}
>> +
>>  	/* If populated return >0 so we abort the operation + zap. */
>>  	return 1;
>>  }
>> @@ -1259,8 +1276,15 @@ static int guard_remove_pte_entry(pte_t *pte, unsigned long addr,
>>  	pte_t ptent = ptep_get(pte);
>>
>>  	if (is_guard_pte_marker(ptent)) {
>> -		/* Simply clear the PTE marker. */
>> -		pte_clear(walk->mm, addr, pte);
>> +		const softleaf_t entry = softleaf_from_pte(ptent);
>> +		const pte_marker marker = softleaf_to_marker(entry) &
>> +					  ~PTE_MARKER_GUARD;
>> +
>> +		/* Clear the guard bit and keep the uffd-wp bit, if set. */
>> +		if (marker)
>> +			set_pte_at(walk->mm, addr, pte, make_pte_marker(marker));
>> +		else
>> +			pte_clear(walk->mm, addr, pte);
>>  		update_mmu_cache(walk->vma, addr, pte);
>>  	}
>>
>> diff --git a/mm/mprotect.c b/mm/mprotect.c
>> index ef4e7188e24d..6cc5b99b4185 100644
>> --- a/mm/mprotect.c
>> +++ b/mm/mprotect.c
>> @@ -249,9 +249,28 @@ static long change_softleaf_pte(struct vm_area_struct *vma,
>>  		 * because any access should sigbus/sigsegv
>>  		 * anyway.
>>  		 */
>> -		if (softleaf_is_poison_marker(entry) ||
>> -		    softleaf_is_guard_marker(entry))
>> +		if (softleaf_is_poison_marker(entry))
>>  			return 0;
>> +
>> +		/*
>> +		 * A guard marker on a file-backed VMA carries the
>> +		 * uffd-wp state of the slot for when the guard is
>> +		 * removed.
>> +		 */
>> +		if (softleaf_is_guard_marker(entry)) {
>> +			const pte_marker old = softleaf_to_marker(entry);
>> +			pte_marker marker = old;
>> +
>> +			if (uffd_prot_resolve)
>> +				marker &= ~PTE_MARKER_UFFD_WP;
>> +
>> +			if (marker == old)
>> +				return 0;
>> +			set_pte_at(vma->vm_mm, addr, pte,
>> +				   make_pte_marker(marker));
>> +			return 1;
>> +		}
>> +
>>  		/*
>>  		 * If this is uffd-wp pte marker and we'd like
>>  		 * to unprotect it, drop it; the next page
>>
>> --
>> 2.39.5
>>
> 
> --
> Cheers, Lorenzo
> 

