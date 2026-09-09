Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9998157C70C;
	Wed,  9 Sep 2026 16:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788970018; cv=none; b=hqVGMw7NQYSv6OytuSGneLLN4ttEnD7xKK6aVq5jvpxip6aBJEBqs1xd6RreDmjV3cNgpYOLL4+0RK3yU6Co/02HazHugPYEAnq8vMBcpn83u6+g7MtUD5zWUn+Mbfugd1sEkNic9xXu2YE1U4xBL8uCHihMllRAH+Ak4cy23mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788970018; c=relaxed/simple;
	bh=rfrQ6T0gJOQH/5zf3bE7xdcYjuX5ypWanyyNADVwqn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ATleyRng51G6fI7cH/ws88JYrNINHJR97ipqQqZpdWMcHkBVxQVv5ys+FvJJX/SS8hywPWbKjtyvYwcTpESh/yYIIUKlJqIbqXlv6p2RAPYoSq9ndlSsmLuN/io56bf5YyI3m7eIxhk92wxta3MsRUfwFYlEd8726UO4oblTMZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GATc8n39; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GATc8n39"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689B22Lf2666620;
	Wed, 9 Sep 2026 16:06:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RWjlI4
	MbqEsZqtycIqtATsbjlYjEDTmZpbeEKOTud1s=; b=GATc8n39raqlzovpzocBJQ
	Qq/Zebd1E3g6mr0A6PZoBUVwGU1ckOw9ocDq7s47zosAcmDQQjUwGaBQe93DceFr
	SBI26gWxDRTHXZkCfWkS8QjNqyIIq5eeGzAa78VWtndciymtqziBwdSXv+VNpQ/s
	mPVuWj8esHtAQ5Lp9ZyHuchZGXDO+NWvZFWYG6BlCxUKWhsq9Ef9mbcjF1IfNwUq
	T4MrIgRUFR0gvKKUQ99mzszOmR+Cbj4koHMQHt8+M85QIarGhq53LD1SmlOOtsdj
	28LrODlEYGuEtIpX9+XqJCswR3dYvtbXfuoybqfc1LkcufFqIk32bUhqJmvjTNQg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbjrxkqk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 16:06:26 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 689FuEUP001920;
	Wed, 9 Sep 2026 16:06:25 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ggwswba5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 16:06:25 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 689G6MRq30933304
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Sep 2026 16:06:23 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D8702004F;
	Wed,  9 Sep 2026 16:06:22 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 21AA72004B;
	Wed,  9 Sep 2026 16:06:13 +0000 (GMT)
Received: from [9.61.255.18] (unknown [9.61.255.18])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  9 Sep 2026 16:06:12 +0000 (GMT)
Message-ID: <fbe69571-3750-46b2-9db8-eb7b2e287ca8@linux.ibm.com>
Date: Wed, 9 Sep 2026 21:36:09 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/22] selftests/coredump: put a hole in the middle of
 a sparse mapping
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
 <20260820-work-coredump-sparse-v2-20-ba32dd718c51@kernel.org>
Content-Language: en-US
From: R Nageswara Sastry <rnsastry@linux.ibm.com>
In-Reply-To: <20260820-work-coredump-sparse-v2-20-ba32dd718c51@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=E7T9Y6dl c=1 sm=1 tr=0 ts=6aa18402 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=yvCvHZBkMPEFi-hM:21 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=4b849oTNI3KMiQfRc2UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE3OCBTYWx0ZWRfXwMOKEAOnufqd
 SGF+DFNNDavrSKHi0O55IeVnCJpxKsk8JMbNAF5YjDffOGYM/iiFNdwXrgZVLI0UDW6amkSRT5j
 c9kaVzcekM8HfLv/ujde5QoSFy27w1A=
X-Proofpoint-ORIG-GUID: uESFL6ZdpJh2pism_iCO0yEFf0a3Syt_
X-Proofpoint-GUID: __IvkGFV-gsBehoP4a6j6PMjApE_YReo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE3OCBTYWx0ZWRfX/iNiFzIMlsZz
 vhZswCktN33AMgFoktb9LL5NRjECPckotB7sYlKRHixcGDrGmwbwJRTNqzWXvCfuKKH/1Vg2QCQ
 8hQD/dbozyCxmL0Q3700Jkgjt6UKvN+RR1lv+CUymuOSjwlQdJCfOnWoUrHZ2mqPaCGB8ZT5P79
 w4Q4xbl5UZ7AOJ0ymI476D+Z2RWtcMKXyg+whwzAt9CP8wkvgK0nZvLV6p6knx1+dOznQPOrA2x
 y2lcagUJTdgEg6BJV/rcanXJ8zdZzWKyovhqmlXjqR/783N9/sIQiUKd6DCYcdn3O3+86whqkAG
 mNsxGHAUxqiOVRREXXESX3xNuwV0LbP3emO3JHxwjAPr5Wcn3U9L8E/apkJTpPcy5jtMutmT9Jn
 7z6XzIc52t8Six/81f6YKFmgnsv//JznOwzvNaAZzb4IGU/TCtDVl/xJ1SElyzqYimrd63JB+vy
 T1Ol686LKB8o4lg23IA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090178


On 20.08.2026 4:39 AM, Christian Brauner wrote:
> The crashing_child_sparse() helper touches the first page of the
> mapping. That forces everything behind it to be a trailing hole. This is
> easy to handle. Make the test more difficult meaningful by also touchin
> the last page. This causes the hole to sit between two populated pages.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>

System: ppc64le LPAR (IBM POWER), Linux 7.3-rc2
> ---
>   tools/testing/selftests/coredump/coredump_test_helpers.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/coredump/coredump_test_helpers.c b/tools/testing/selftests/coredump/coredump_test_helpers.c
> index 45d76fa0f469..89f3954c5607 100644
> --- a/tools/testing/selftests/coredump/coredump_test_helpers.c
> +++ b/tools/testing/selftests/coredump/coredump_test_helpers.c
> @@ -58,14 +58,16 @@ void crashing_child_sparse(size_t size)
>   	char *p;
>   
>   	/*
> -	 * Touch the first page only. The whole mapping is dumped because
> -	 * it has been written to, but all of it save that one page is a
> -	 * hole.
> +	 * Touch the first and the last page. This will cause the whole mapping
> +	 * to be dumped because it has been written to. Everything between
> +	 * those two pages is a hole though.
>   	 */
>   	p = mmap(NULL, size, PROT_READ | PROT_WRITE,
>   		 MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE, -1, 0);
> -	if (p != MAP_FAILED)
> +	if (p != MAP_FAILED) {
>   		p[0] = 'x';
> +		p[size - 1] = 'x';
> +	}
>   
>   	/* crash on purpose */
>   	*(volatile int *)NULL = 0;
>
-- 
Thanks and Regards
R.Nageswara Sastry

