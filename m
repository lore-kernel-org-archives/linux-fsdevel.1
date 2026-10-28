Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793172898;
	b=UZfI7dJ3FEYwW80MBoqw+APwlWQ3Mj0RV8sG4RFbg/07GcGUxEgw+JQhYlPDUsPwDeT9
	 3WnEDPHK1nPBTRFv2nNUDLql5N9BwhCwEWl58+2ogtlxpRlwS5pgFhszs3zEox3nyx/+e
	 KCgWTDT83o149soPmvuD2v2AkKwXzUKsnldDd+M9CCWpWriAZdywFNe3AmJG20Dh1Zdrp
	 Cqcds1SkFLFi70UTuK56zeV8RZuqfVSU5ZXx3Edz2nlv9VIgMlz8b61WGcSbVOruNNeMN
	 pWGyiYgwLiVDQElEIL2p2jEIRbNiuORlL9wYUWoSwOPemvIdcI0bC6GUcwCEr/u2wSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793172898;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=zIStE4bF32XhyUlfFjGjXX08aOZ6FXRCskcbe+64ed0=;
	b=mjz/1JSh2hisyO7G64wYQgeJ/AG33aVExXAi6yStyFumFfjCUJ1t/20ziH+aVUsHnQN5
	 tAMVGPhP2WTHCQBEb7AvQ0wDkjUUUhUvkFM7t0wbQS3UTw0MbK6rZC7blWxPMXt8/diVq
	 g4P8xn8dd5pBgKOxTnW+CZDCLlLROgkAUHLU19xpyBFLNU/qyngV15rdo6h7Z9pt4r61V
	 Au4fjmJ7Wf6Jmm/8Fb+gZ/c545Kon5yywSEV75pCCa4lYa8v/wdp0Wmg0vzKD2rer9z2S
	 GLfVrMXQF9j4vUveIbF2FO1vs6FApLQfNv/Pe+3LSYGC1h8KnXFGwZ1N9j68mP/LN3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=IleMG95e;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E4E606A31E;
	Wed, 28 Oct 2026 07:34:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75E4E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=IleMG95e
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69S4iJVI307019;
	Wed, 28 Oct 2026 07:34:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=zIStE4
	bF32XhyUlfFjGjXX08aOZ6FXRCskcbe+64ed0=; b=IleMG95evMD7Cf03cYBhVn
	AviKOCbHZLwJbpay/iJbCYSQD21f+/+ZKY86E2HWaiwZjkGwVYKqUkldz6g5mA8Z
	AqEPG31ACBy97v7aIeMSAvlxIPyUS3Z/z8TZXn4dPfOHDbRzRv+qaGEpm83A6w5P
	iP5HSrfd4VMH4MekWoD80oMlVP4j+QIKxq/SHMY/Pw7XsdOQ4b82EwVCEqW7haSQ
	+jSU9/bvAQl0oUM03asH1JR8YRZRq7VwfYKVuIMa5rsBji//ze+Nk81LyWN8k6zh
	AtI+8MP9QmPa9RKw01ektNOah+VRS7kgu5+t91qo3v45QNqrOr+XZslq8/xuQULQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmavk1xv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 07:34:54 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69S4YxKk1030496;
	Wed, 28 Oct 2026 07:34:53 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hjsu7v8h4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 07:34:53 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69S7YpCf17433034
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Oct 2026 07:34:52 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D63EE20043;
	Wed, 28 Oct 2026 07:34:51 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4942F2004D;
	Wed, 28 Oct 2026 07:34:50 +0000 (GMT)
Received: from [9.39.21.200] (unknown [9.39.21.200])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 28 Oct 2026 07:34:50 +0000 (GMT)
Message-ID: <ab9e5404-68fc-4cda-b76c-df6ff96673b4@linux.ibm.com>
Date: Wed, 28 Oct 2026 13:04:48 +0530
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
Subject: Re: [PATCH 1/2] selftests/empty_mntns: fix header conflicts and
 remove TOOLS_INCLUDES
To: brauner@kernel.org, shuah@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20261001065728.90239-1-disgoel@linux.ibm.com>
Content-Language: en-GB
From: Disha Goel <disgoel@linux.ibm.com>
In-Reply-To: <20261001065728.90239-1-disgoel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=P8SvFSAu c=1 sm=1 tr=0 ts=6ae1a59e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=9Dw8piptKcqqLLA35HMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 3dhOyGsKRUkpNUyWrbj4SlAIX7vNmJVs
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDAyOCBTYWx0ZWRfXxPrq6w+6Jq4D
 8V95Tvc2gXgHFjfaI88Ab+e5wXYvrY/yjv766oKccSoS7yZ+jsSvVgHZhQULJ3opqm1ihq/4+kw
 3WNWrnYyFeTnyVly9GhlmCU3w8tnsyA=
X-Proofpoint-ORIG-GUID: 3dhOyGsKRUkpNUyWrbj4SlAIX7vNmJVs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDAyOCBTYWx0ZWRfX05qF7VV+23up
 eo3qYSLvoxP37I/rH3muGDCAGOtT0N6VyzmYu6Fbz2NA9m2r7F9R2wNnEo64AHeZSEAHp5DTvcp
 GGzgc+vpG9GbYszHpXxTRCej1F+MsKAz2wAZYGpNsrBHcAWGVdG1+Z2rTpxmhMtnzkYCXYi4U7R
 udDjqqWJnSn8Z/RuYVz7/dolUgvDpA2is5xCeOD8W6qf3Y6JfN7mNboGJwSv3qEQfLZiYwlsQGT
 fTtSq5d5Rx55CxQLI14qY7UJJHvnP04ixAbdWBKClJra1Zha3ChlApUxBY/62fshkj5tTwZlarG
 oA2AqTkPb1iN7u9bXGc19JK9dXJidWBqUMPi9YlkLpmqyBJjrqwqfHu5T/tUcPyXpvBSG/QRwqG
 WrenQvKPJOjIEmnV3DUFY8H81QqJJDVCRjnnZFANTWxHKXmUdV4ThdZ9HUlqDib/Lux8JFtVJxy
 YKBGlfLrOqM4ioK9FiQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610280028

Hi Christian,

Gentle ping on this series. Could you please review it, and if it looks
fine, pick it up?

On 01/10/26 12:27 pm, Disha Goel wrote:
> Including <linux/mount.h> alongside <sys/mount.h> in empty_mntns test
> files leads to compilation errors with glibc due to conflicting enum
> definitions of MS_RDONLY and other mount flags.
> 
> Additionally, passing $(TOOLS_INCLUDES) (-isystem tools/include/uapi)
> causes tools/include/uapi/linux/types.h to be included, forcing
> int-ll64.h definitions on architectures like PowerPC (ppc64le) that
> use int-l64.h, resulting in type collisions with system headers.
> 
> Fix this by:
> - Dropping <linux/mount.h> from the test sources in favor of
>    <sys/mount.h> (with <linux/stat.h> included after system headers).
> - Removing $(TOOLS_INCLUDES) from the Makefile since standard UAPI
>    headers are already supplied via $(KHDR_INCLUDES).
> 
> Fixes: 32f54f2bbccf ("selftests/filesystems: add tests for empty mount namespaces")
> Fixes: 5b8ffd63fbd9 ("selftests/filesystems: add clone3 tests for empty mount namespaces")
> Signed-off-by: Disha Goel <disgoel@linux.ibm.com>
> ---
>   tools/testing/selftests/filesystems/empty_mntns/Makefile       | 2 +-
>   .../filesystems/empty_mntns/clone3_empty_mntns_test.c          | 3 +--
>   .../selftests/filesystems/empty_mntns/empty_mntns_test.c       | 3 +--
>   .../selftests/filesystems/empty_mntns/overmount_chroot_test.c  | 3 +--
>   4 files changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/filesystems/empty_mntns/Makefile b/tools/testing/selftests/filesystems/empty_mntns/Makefile
> index 22e3fb915e81..8d2cb46668fc 100644
> --- a/tools/testing/selftests/filesystems/empty_mntns/Makefile
> +++ b/tools/testing/selftests/filesystems/empty_mntns/Makefile
> @@ -1,6 +1,6 @@
>   # SPDX-License-Identifier: GPL-2.0-or-later
>   
> -CFLAGS += -Wall -O2 -g $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
> +CFLAGS += -Wall -O2 -g $(KHDR_INCLUDES)
>   LDLIBS += -lcap
>   
>   TEST_GEN_PROGS := empty_mntns_test overmount_chroot_test clone3_empty_mntns_test
> diff --git a/tools/testing/selftests/filesystems/empty_mntns/clone3_empty_mntns_test.c b/tools/testing/selftests/filesystems/empty_mntns/clone3_empty_mntns_test.c
> index 6370086f886d..de0cbd1a5ee0 100644
> --- a/tools/testing/selftests/filesystems/empty_mntns/clone3_empty_mntns_test.c
> +++ b/tools/testing/selftests/filesystems/empty_mntns/clone3_empty_mntns_test.c
> @@ -15,14 +15,13 @@
>   
>   #define _GNU_SOURCE
>   #include <fcntl.h>
> -#include <linux/mount.h>
> -#include <linux/stat.h>
>   #include <stdio.h>
>   #include <string.h>
>   #include <sys/mount.h>
>   #include <sys/stat.h>
>   #include <sys/types.h>
>   #include <unistd.h>
> +#include <linux/stat.h>
>   
>   #include "../utils.h"
>   #include "../wrappers.h"
> diff --git a/tools/testing/selftests/filesystems/empty_mntns/empty_mntns_test.c b/tools/testing/selftests/filesystems/empty_mntns/empty_mntns_test.c
> index 43e296b97d84..a6a90d0b6ff9 100644
> --- a/tools/testing/selftests/filesystems/empty_mntns/empty_mntns_test.c
> +++ b/tools/testing/selftests/filesystems/empty_mntns/empty_mntns_test.c
> @@ -7,8 +7,6 @@
>   
>   #define _GNU_SOURCE
>   #include <fcntl.h>
> -#include <linux/mount.h>
> -#include <linux/stat.h>
>   #include <sched.h>
>   #include <stdio.h>
>   #include <string.h>
> @@ -17,6 +15,7 @@
>   #include <sys/types.h>
>   #include <sys/wait.h>
>   #include <unistd.h>
> +#include <linux/stat.h>
>   
>   #include "../utils.h"
>   #include "../wrappers.h"
> diff --git a/tools/testing/selftests/filesystems/empty_mntns/overmount_chroot_test.c b/tools/testing/selftests/filesystems/empty_mntns/overmount_chroot_test.c
> index 6e21c58258c3..574c03311245 100644
> --- a/tools/testing/selftests/filesystems/empty_mntns/overmount_chroot_test.c
> +++ b/tools/testing/selftests/filesystems/empty_mntns/overmount_chroot_test.c
> @@ -18,8 +18,6 @@
>   
>   #define _GNU_SOURCE
>   #include <fcntl.h>
> -#include <linux/mount.h>
> -#include <linux/stat.h>
>   #include <sched.h>
>   #include <stdio.h>
>   #include <string.h>
> @@ -29,6 +27,7 @@
>   #include <sys/types.h>
>   #include <sys/wait.h>
>   #include <unistd.h>
> +#include <linux/stat.h>
>   
>   #include "../utils.h"
>   #include "empty_mntns.h"

-- 
Regards,
Disha

