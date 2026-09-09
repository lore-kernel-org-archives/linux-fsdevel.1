Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21505577E26;
	Wed,  9 Sep 2026 16:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788969799; cv=none; b=Uwbclh0OJ92Gpk3/KmSY060VkY3sJ89EFd5JcfZgRxnhGw13YrN0ZN5GHFC6EhQkkhynR03SKfFmuQ6M1VBcRFwU73wUSLB7FrwFSoh/b/vzR+SorqYvHTk+AJzS+h2DrkV9FTe8O2LBvaxyLfI0oZPpHursCemxIXF0XWX04uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788969799; c=relaxed/simple;
	bh=6k71zVTtg4gskeQ71dR57KqGckAtGUuZczZAACIOabo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cbBzFoPCA437QdBs/sH1/PC3lg8dksXAaySL5HfrPOhfzGZqjI0Dkg3nVANXN115PGeksQbaDL2JN4C/+U5ycA5gAZmi6L1cdsRHhTD1nKnRpoBFwr6JdEnP6MNe6NlYrPmOg9nPlp7xIOzhbd/03S5JDo45bb8SKkT51qn8AEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XGq85tAN; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XGq85tAN"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689B1QNt3801875;
	Wed, 9 Sep 2026 16:02:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=HSY/Er
	1CmYDqXlV3DacUgRIGKuhSH1cmMKR2uFNIWLQ=; b=XGq85tANWEGt+kPdGvbv5l
	gS5vUEe68BAiHVu+vo0sACDL/e7VRctQdEM4/iCP7o1Y/TX5ym6HtR4gDAF6Q7SQ
	l2dD4Xiyo1s/iBclrb5ICMqOMvS9KUinB6BPtQmsQrlV3YuOt0QFhKMHkKHtMskl
	LhY91ByF2VjW3cdwr2qLMtyLMpYle9QqpUtKXsPEwjQ5q8MjXwiycpI+5ozFu0W7
	PM5hZYgW4EOmJ3+27v6Na4b0Bg2ORJuU7nZW4IOWM0NOwYLIBhgQvbkYQ6HVJboX
	4S681HWXjP6f3uVa4Ea4L7lnjam44VNU88YlzXVBO+CVVnPXL80OFXBWas/YjKqg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbhky0ts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 16:02:45 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 689FuGXx005264;
	Wed, 9 Sep 2026 16:02:44 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ggxwhb444-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 16:02:44 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 689G2dE349283438
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Sep 2026 16:02:39 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 964302004F;
	Wed,  9 Sep 2026 16:02:39 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA11F20043;
	Wed,  9 Sep 2026 16:02:29 +0000 (GMT)
Received: from [9.61.255.18] (unknown [9.61.255.18])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  9 Sep 2026 16:02:29 +0000 (GMT)
Message-ID: <ffeb3910-5923-470d-8ff0-8db665ff2bb0@linux.ibm.com>
Date: Wed, 9 Sep 2026 21:32:25 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/22] coredump: add COREDUMP_RECORDS to the coredump
 socket protocol
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Jacob Lalonde <jalalonde@meta.com>, Josef Bacik <josef@toxicpanda.com>,
        Jann Horn <jannh@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
        "Liam R. Howlett" <liam@infradead.org>,
        Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Omar Sandoval <osandov@osandov.com>, Jacob Lalonde <jalalonde@fb.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
References: <20260820-work-coredump-sparse-v2-0-ba32dd718c51@kernel.org>
 <20260820-work-coredump-sparse-v2-13-ba32dd718c51@kernel.org>
Content-Language: en-US
From: R Nageswara Sastry <rnsastry@linux.ibm.com>
In-Reply-To: <20260820-work-coredump-sparse-v2-13-ba32dd718c51@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE3OCBTYWx0ZWRfXzPZdSwT6Cj0z
 4b99P1W16MAmjQqnxkbK2d27CmM2i/OIZppMqF0m+r63Y94nDlpVjnclqixwQ9x7jo8+yOqCjgU
 +Y0PlznQ4T4n5UOt9OYeU7Drlaj94rQ=
X-Proofpoint-ORIG-GUID: zZBYAI8Ze8g_g7P1UnwCdknMJzB5uk3g
X-Authority-Analysis: v=2.4 cv=NMDlPU6g c=1 sm=1 tr=0 ts=6aa18326 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=WVHIdix6p19bwZ1xHcsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE3OCBTYWx0ZWRfXyeMWmainlQeC
 HThRCwuusivddEBLW3VCaGYoJTbOGPXd0S7Rm1H4qhvTQCiunRqJBW5OcIBXBvPeSOhNUZSeG9S
 iZad7jrKSIw2NLkSQBNhcBZAb68iNUdpc5A2cP2e17buQOtuXUx3sPg23fRYNooebDKUPL8j/dz
 PxFAsAUO+H+7F4eUf8sd/BtgJXfUErNZEf65szRrybJre2Er+XruGWn8rlneEGAboO4ZdvcGDqL
 1TXtxYAYkKV9gvV/XSXwTVdXZ1QrQwZFjHW5ciX7cnuKVX8FzBLZV34PuTse9EoAuVdvKGCeJRv
 ApNhvWZBkBvB3tE0/ONqvnUrCREE4hbLaVwD/i1kzIiricbdQppym6alYfD+VNUmXAHA49uyi2R
 O2zevJT7JShoptvXkOIJxvS85G1yqmH7sJ2t6Tfl8taVYVg69GKKJ0x19NKAffEpUCSTVgYAzTE
 uuU9Z+l7W9bRKehQMFA==
X-Proofpoint-GUID: OSUZ9Laqkyeg78AFekbbhNf9bQuODu9T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090178


On 20.08.2026 4:39 AM, Christian Brauner wrote:
> Currently a coredump sent over a socket is raw data. The kernel knows
> things about the data it's sending that are useful for a coredump
> server. For example, it knows where the unpopulated parts of a mapping
> are. We can't communicate this to userspace currently though.
>
> Add a COREDUMP_RECORDS feature bit and a struct coredump_record_header
> so userspace can negotiate that feature. Instead of a byte stream it
> gets a header plus data. Reassembling the records yields the same
> coredump that would have been sent without them.
>
> The record itself is also versioned and thus extensible with the same
> protocol as the ack-req sync.
>
> A record stream ends explicitly. A COREDUMP_RECORD_END record closes it,
> carries no data and reports the size of the coredump. It is only sent
> once the whole coredump has been written. If it's missing the coredump
> should be treated as truncated.
>
> This just adds the infrastructure.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>

System: ppc64le LPAR (IBM POWER), Linux 7.3-rc2

> ---
>   include/uapi/linux/coredump.h | 66 +++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 66 insertions(+)
>
> diff --git a/include/uapi/linux/coredump.h b/include/uapi/linux/coredump.h
> index 662e0468da6e..0bd5c8662ebe 100644
> --- a/include/uapi/linux/coredump.h
> +++ b/include/uapi/linux/coredump.h
> @@ -11,12 +11,16 @@
>    * @COREDUMP_USERSPACE: userspace writes coredump
>    * @COREDUMP_REJECT: don't generate coredump
>    * @COREDUMP_WAIT: wait for coredump server
> + * @COREDUMP_RECORDS: send the coredump as a sequence of records instead of
> + *                    as a plain byte stream, see struct coredump_record_header;
> + *                    requires COREDUMP_KERNEL
>    */
>   enum {
>   	COREDUMP_KERNEL		= (1ULL << 0),
>   	COREDUMP_USERSPACE	= (1ULL << 1),
>   	COREDUMP_REJECT		= (1ULL << 2),
>   	COREDUMP_WAIT		= (1ULL << 3),
> +	COREDUMP_RECORDS	= (1ULL << 4),
>   };
>   
>   /**
> @@ -101,4 +105,66 @@ enum coredump_mark {
>   	__COREDUMP_MARK_MAX		= (1U << 31),
>   };
>   
> +/**
> + * enum coredump_record_type - Type of a coredump record
> + *
> + * @COREDUMP_RECORD_DATA: the header is followed by ->len bytes of data
> + * @COREDUMP_RECORD_END: the coredump ends here, the header is not followed
> + *                       by any data and no further record is sent
> + * @__COREDUMP_RECORD_TYPE_MAX: the maximum coredump record type value
> + */
> +enum coredump_record_type {
> +	COREDUMP_RECORD_DATA		= 0U,
> +	COREDUMP_RECORD_END		= 1U,
> +	__COREDUMP_RECORD_TYPE_MAX	= (1U << 31),
> +};
> +
> +/**
> + * struct coredump_record_header - header of a coredump record
> + * @size: size of struct coredump_record_header
> + * @type: one of enum coredump_record_type
> + * @flags: modifiers for this record
> + * @offset: offset in the coredump this record starts at
> + * @len: number of coredump bytes this record accounts for
> + *
> + * If the coredump server raises COREDUMP_RECORDS in coredump_ack->mask
> + * the kernel doesn't send the coredump as a plain byte stream. It sends
> + * a sequence of records instead. A COREDUMP_RECORD_DATA record is
> + * followed by @len bytes of actual coredump data. Records arrive in
> + * order and leave no gaps. So @offset is the sum of the @len of all
> + * records before it.
> + *
> + * The last record is a COREDUMP_RECORD_END record. It is followed by
> + * nothing. Its @len is zero. Its @offset is the size of the coredump.
> + * The kernel only sends it once it has written the whole coredump. A
> + * server that hits end-of-file without having seen an end record must
> + * treat the coredump as incomplete.
> + *
> + * The @size member is set to the size of struct coredump_record_header
> + * the kernel knows and lets the header grow later. It comes first so it
> + * can be peeked. Userspace must consume @size bytes and discard
> + * anything beyond what it knows. It must refuse a @size smaller than
> + * COREDUMP_RECORD_HEADER_SIZE_VER0. @size covers the header alone.
> + * @offset and @len count coredump bytes.
> + *
> + * The @flags member carries modifiers that change how the record is to
> + * be interpreted. No flag is defined yet. Userspace must refuse a
> + * record carrying a flag or a type it doesn't know. Every new record
> + * type is raised in coredump_req->mask as a feature of its own. A
> + * server only ever sees the types it asked for.
> + *
> + * COREDUMP_RECORDS must be combined with COREDUMP_KERNEL.
> + */
> +struct coredump_record_header {
> +	__u32 size;
> +	__u32 type;
> +	__u64 flags;
> +	__u64 offset;
> +	__u64 len;
> +};
> +
> +enum {
> +	COREDUMP_RECORD_HEADER_SIZE_VER0 = 32U, /* size of first published struct */
> +};
> +
>   #endif /* _UAPI_LINUX_COREDUMP_H */
>
-- 
Thanks and Regards
R.Nageswara Sastry

