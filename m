Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8F9577E41;
	Wed,  9 Sep 2026 16:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788969827; cv=none; b=Df0lPRqHXHKrBGz7OnuUy9n0MLWfWiD7Ce83++quA5JQVdmUmjat9KSq+jA2Sl3SpCf6Nk724UtDWQnQPH0/NtHaNBQI6g9bff9KSQhDh+r/2IKzWKLuVHlnv2C+5yw9bwGodafmQuRVfKBCpbr6QD3uzSrwQX4K8wk3i5hjQvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788969827; c=relaxed/simple;
	bh=rTZ7EYdIhRMPLG3HqEiZcqOZFG5xWLQ0O0Lc9jPBr6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BkvmQyvtA6DBE2jLY9cQc3e7g4mwrF6XJfyffrSh/lTagbWF0vZi6Idw9KZ5IxU158bUeHEjd75W45g3GtUpZ4lu/2pxDce6SB0UeFOwi0k8HuafXXppSlIZw6yIT/QAZMur2m+/1P+GJ0SEzaAZ/r189XmpH7KaChUpodDYAE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Rmy+0WUn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Rmy+0WUn"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689B1gRN2666353;
	Wed, 9 Sep 2026 16:03:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fj4NPV
	2b5ddzadjwHBV/wDjDeqoVgqkR4d6YGILhwFk=; b=Rmy+0WUnNw8usGhP8aO1CW
	npxqOOkOr+WQDVMoE0dJ8RnucjRCKyXJ056PibXKf+kMZkEWCnqxbkYdOzHJc/eQ
	b83gZjNzJ4jxda9nJBbw+wsiGJGrV9wnUdxYuupCP1TrKypfTv9IrbqdArEh89hr
	d+jlgc06Ap82h5C7EWRv1g7e1zZp768wD3QmFD8hNcZOg0Z2DOuBdgNrhhhxwgin
	JqMynF1fWVzsExjeGpXUJZO8URFQWJpAGeriUHFEN1S+CzS2i1V76IQVLp8rDa5n
	oCajKQ20X7jplw/TRxp1nQDNcKdForaFPCeZt8p+YhwATmds5snniTYPOf3ydicA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbjrxk7s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 16:03:13 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 689FuErS001919;
	Wed, 9 Sep 2026 16:03:12 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ggwswb9mc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 16:03:12 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 689G39aC50332008
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Sep 2026 16:03:09 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1EAE32004E;
	Wed,  9 Sep 2026 16:03:09 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 54CEE2004B;
	Wed,  9 Sep 2026 16:02:59 +0000 (GMT)
Received: from [9.61.255.18] (unknown [9.61.255.18])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  9 Sep 2026 16:02:58 +0000 (GMT)
Message-ID: <7880f5d5-afed-4ca5-8da6-80893b572811@linux.ibm.com>
Date: Wed, 9 Sep 2026 21:32:55 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/22] coredump: add COREDUMP_SPARSE to the coredump
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
 <20260820-work-coredump-sparse-v2-14-ba32dd718c51@kernel.org>
Content-Language: en-US
From: R Nageswara Sastry <rnsastry@linux.ibm.com>
In-Reply-To: <20260820-work-coredump-sparse-v2-14-ba32dd718c51@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=E7T9Y6dl c=1 sm=1 tr=0 ts=6aa18341 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=us48m2cYMFLMeAGhKtMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE3OCBTYWx0ZWRfX+7vrOXwUj/+D
 FKIsj97BObNt71OeFHogKWmOHpgkOcs0wN4GaLf8oslDqRCK6Oyl860LQD5JqtD+Ju00R8jNNoZ
 yjeSjfIzljV9RHY0caNOijuXhYbwBOM=
X-Proofpoint-ORIG-GUID: -IYP7dQxPlEC9kq_1QMKZcr34Ex8paTO
X-Proofpoint-GUID: 8uMRCQi-kmepLPnmlVejNAZPUGdU1KmV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE3OCBTYWx0ZWRfX9QhGXDWcGgf0
 Je75CZ5HbJKuStCslM3G3GKNNpCxomuuMx1X3ViHDdb5k1kLLgu1IMHMCvu/StDITo0uUhJuosW
 SID6RDMfJuI2sIuPELt3gEoz2Uex70L5/BqgMIzyfJ0LZeaIBKTrd7ZyFNaPJuYV4Tx0e9b14d/
 H/79VFqi2wgcUoM+jcVF17ltmHzsH8LC0+Uwx7daR5ZudnBuOeGbqv6o6RdW1W5J6dCj1Gss3mK
 7SOqL4V+IuxdK3DmWXaVFfKnsxl/k2q5F7Uzj/Ef4qLtqdzuKcD7LeobMRWUlB6YidqD2Q0QEez
 jCvt7bCROfkpw3jFgvmquOMv8EBfHp97ZB8ah95H0QPQ38xDZt2QRICKhc7HCeAUUcKqub4FXoH
 slCl6bEEYm1B0bHGj0SHOTbfQcCUyrTDxcGe79h/1OyRQU9B+2gRq7RJohnAsaEC9HAJoeIpt88
 ep3N4knMrvkNbEHHPgQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090178


On 20.08.2026 4:39 AM, Christian Brauner wrote:
> A coredump with a lot of unpopulated mappings sends useless amounts of
> zero data to userspace. This is nonsensical. While __dump_skip() can
> seek over them when the target is a regular file a socket cannot do
> this. COREDUMP_RECORDS put the zeroes in records but it didn't get rid
> of them.
>
> Add a COREDUMP_SPARSE feature bit and a COREDUMP_RECORD_ZERO record
> type. A zero record is a bare header that tells userspace how many zero
> bytes were skipped.
>
> So a hole crosses the socket as one header no matter how long it is. The
> coredump server can recreate this sparsely. Zero records only exist
> inside a record stream. COREDUMP_SPARSE requires COREDUMP_RECORDS.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>

System: ppc64le LPAR (IBM POWER), Linux 7.3-rc2
> ---
>   include/uapi/linux/coredump.h | 17 +++++++++++++----
>   1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/include/uapi/linux/coredump.h b/include/uapi/linux/coredump.h
> index 0bd5c8662ebe..f3771861ca48 100644
> --- a/include/uapi/linux/coredump.h
> +++ b/include/uapi/linux/coredump.h
> @@ -14,6 +14,8 @@
>    * @COREDUMP_RECORDS: send the coredump as a sequence of records instead of
>    *                    as a plain byte stream, see struct coredump_record_header;
>    *                    requires COREDUMP_KERNEL
> + * @COREDUMP_SPARSE: describe the holes in the coredump as zero records
> + *                   instead of transferring them; requires COREDUMP_RECORDS
>    */
>   enum {
>   	COREDUMP_KERNEL		= (1ULL << 0),
> @@ -21,6 +23,7 @@ enum {
>   	COREDUMP_REJECT		= (1ULL << 2),
>   	COREDUMP_WAIT		= (1ULL << 3),
>   	COREDUMP_RECORDS	= (1ULL << 4),
> +	COREDUMP_SPARSE		= (1ULL << 5),
>   };
>   
>   /**
> @@ -111,11 +114,14 @@ enum coredump_mark {
>    * @COREDUMP_RECORD_DATA: the header is followed by ->len bytes of data
>    * @COREDUMP_RECORD_END: the coredump ends here, the header is not followed
>    *                       by any data and no further record is sent
> + * @COREDUMP_RECORD_ZERO: the header stands for ->len zero bytes and is not
> + *                        followed by any data
>    * @__COREDUMP_RECORD_TYPE_MAX: the maximum coredump record type value
>    */
>   enum coredump_record_type {
>   	COREDUMP_RECORD_DATA		= 0U,
>   	COREDUMP_RECORD_END		= 1U,
> +	COREDUMP_RECORD_ZERO		= 2U,
>   	__COREDUMP_RECORD_TYPE_MAX	= (1U << 31),
>   };
>   
> @@ -130,9 +136,11 @@ enum coredump_record_type {
>    * If the coredump server raises COREDUMP_RECORDS in coredump_ack->mask
>    * the kernel doesn't send the coredump as a plain byte stream. It sends
>    * a sequence of records instead. A COREDUMP_RECORD_DATA record is
> - * followed by @len bytes of actual coredump data. Records arrive in
> - * order and leave no gaps. So @offset is the sum of the @len of all
> - * records before it.
> + * followed by @len bytes of actual coredump data. A
> + * COREDUMP_RECORD_ZERO record is followed by nothing and stands for
> + * @len zero bytes. A server that didn't raise COREDUMP_SPARSE never
> + * sees a zero record. Records arrive in order and leave no gaps. So
> + * @offset is the sum of the @len of all records before it.
>    *
>    * The last record is a COREDUMP_RECORD_END record. It is followed by
>    * nothing. Its @len is zero. Its @offset is the size of the coredump.
> @@ -153,7 +161,8 @@ enum coredump_record_type {
>    * type is raised in coredump_req->mask as a feature of its own. A
>    * server only ever sees the types it asked for.
>    *
> - * COREDUMP_RECORDS must be combined with COREDUMP_KERNEL.
> + * COREDUMP_RECORDS must be combined with COREDUMP_KERNEL, and
> + * COREDUMP_SPARSE with COREDUMP_RECORDS.
>    */
>   struct coredump_record_header {
>   	__u32 size;
>
-- 
Thanks and Regards
R.Nageswara Sastry

