Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D096576EB8;
	Wed,  9 Sep 2026 15:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788969234; cv=none; b=NfwWvkdb6KtBKNStvdqyo+kMrRA9Z19IRee3digS2QS9gc0+po/rLeV2zqMp3yw74/wgyY1LKOV/Aopz+TQ/x6hSO6XCj1/Bb+PHVJoTqtK+IAJAL/hXtUit2sIfh5k0XTffF9SiyjbHAeYnqK9sC9rd7NNcMNp16mH5f664NPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788969234; c=relaxed/simple;
	bh=dUjHsZuyDv1l8FbpCpEgVt+StsM7dxMMLWPLdFQAmW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NCxrsAXLnmcd4uM8n7PlRgsp0uUZlU73Ka8xPFgNDBy0m9s0I85PWhjsWMuysxdkVqT044PbVthdQzfYmeKIhgAwVBnHipTCGLvK3lwPiXkzG6Cwy8teEFFe/xwpT2GxiihSQ7LOY7yL5p0VMozfR0YDKXcCJduIGO+Eh+HQeas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FkZShthZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FkZShthZ"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689B1hXA1930950;
	Wed, 9 Sep 2026 15:53:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9fEv8C
	VQ+LcrjyrEyKWNY8tE1ZC5nOC4fuPxuTwwtWQ=; b=FkZShthZPf6z6Inxuhf+uF
	iNXUzguRjPZq6PaXhqShCZ3McDp20T3UU5KU3cjMrWdZqtNCUuSuqfdkm8GvIvLF
	dd72+XGKDtIjz69shK+IZlKQChWqyKHmF6exXT0UkgZBSqDxfU9Ur7ERBXMUX80P
	s0bhDfhWZtFY8AxXcf0pCGiGI5KikMBri/OGHlqKcjofQOFEa0vOHAVhylAiOQpt
	uCOLt6833VHDacYxqLq1mLTEtUp5aex8n856rgslbajZo+ccvWXcR2TgU4TdVmIw
	4EHKN7jBzQE3ENXFaCKAqQK2azDDhu9EJCVqra+ip00luEloiWqmnR79lR7H0gcw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbqk6vp0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 15:53:23 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 689FfE6N015367;
	Wed, 9 Sep 2026 15:53:22 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ggwswb807-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 15:53:22 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 689FrJXq50987368
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Sep 2026 15:53:20 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D9F5A2004B;
	Wed,  9 Sep 2026 15:53:19 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4CF0E20043;
	Wed,  9 Sep 2026 15:53:10 +0000 (GMT)
Received: from [9.61.255.18] (unknown [9.61.255.18])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  9 Sep 2026 15:53:09 +0000 (GMT)
Message-ID: <30360c50-0238-40e8-b598-bdfda1141cc8@linux.ibm.com>
Date: Wed, 9 Sep 2026 21:23:06 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/22] coredump: refuse negative skips
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
 <20260820-work-coredump-sparse-v2-2-ba32dd718c51@kernel.org>
Content-Language: en-US
From: R Nageswara Sastry <rnsastry@linux.ibm.com>
In-Reply-To: <20260820-work-coredump-sparse-v2-2-ba32dd718c51@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: pYL1X5j4L64D3lhY8GC7_PxezJajFPeA
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE3MyBTYWx0ZWRfXyZQ2yeCYTZ8Y
 0zY5ztZt9jhIlCwPuIHMWYJZeFMN1RfSvZmQxlYKHYhZCliMI/1/l/3Wg0EpWXDDd6lWozX46Rp
 BOsUhsvxP3K7Gf6k9YxbUWZBPcLY48o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE3MyBTYWx0ZWRfX5MyolTbYyMTx
 81rdDfK4pUyI4nx4v6Y9Tq/r/gVfH0lueULm43ZNa2On7UJUzNwVwdVblnzuc6TdwypX9OVkabd
 mY7Y+a3Um2ewoWxHnuzkeZMU9B9ZEx8zXreAkdyeB0s9N4qbY4sE3Mi+N9nw47/d2BRpkyMNGvD
 3NamjGc8COyszi5eNpC2WHmCm6ZnIaCNR9nVGU8PKzrDMBSZz7UZmsQZ2GC97VMvBlLdIC1rSRX
 cnRoYJFT+Rf7HW7PJ/28KPLDCHwRT7HIo66pa7r9Oacak+UAvogwSvhdsx8cRtWmtDzjGv5q3Tx
 MRgAeULZKoh4YyzTCo7msiB5MQSn0j7ly8YqteQYeKytKoC6USiarP/25m9uwlz0MZyki4TDtFE
 9HQGoeP/j1znxi3DPlsn/xA5Dz4ToJDJEyWtDxCPse+ktxUKAo6Dlm+UeqHdrTyl+tA5+qewgyB
 79OOPB5Pjo8vswDjYfA==
X-Authority-Analysis: v=2.4 cv=JaKMa0KV c=1 sm=1 tr=0 ts=6aa180f3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=0fa85O3lyfMzuANSHggA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: x7FvKhawyt97Kk1EQB6_XHSAe9xWv9Jr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090173


On 20.08.2026 4:39 AM, Christian Brauner wrote:
> The dump_skip_to() helper calculates a relative skip based on the
> absolute positon of the coredump:
>
> 	cprm->to_skip = pos - cprm->pos;
>
> That's easy to mess up for callers and one already did. This risk
> endless zero PAGE_SIZE loops or overwriting already written coredump
> data thereby corrupting the dump.
>
> I don't think skipping backwards has any meaning. So warn and refuse.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>

System: ppc64le LPAR (IBM POWER), Linux 7.3-rc2
> ---
>   fs/coredump.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/fs/coredump.c b/fs/coredump.c
> index e68a76ff92a3..ac4e922c9cb9 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -1261,6 +1261,8 @@ EXPORT_SYMBOL(dump_emit);
>   
>   void dump_skip_to(struct coredump_params *cprm, unsigned long pos)
>   {
> +	if (WARN_ON_ONCE(pos < cprm->pos))
> +		return;
>   	cprm->to_skip = pos - cprm->pos;
>   }
>   EXPORT_SYMBOL(dump_skip_to);
>
-- 
Thanks and Regards
R.Nageswara Sastry

