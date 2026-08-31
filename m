Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39EA3DCD85;
	Mon, 31 Aug 2026 09:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788169628; cv=none; b=nKQAsbgh87lHPV1x0wsnUAfVXfEw5yyUteMwY/0Fogc3I0XS3ACxkqe4yxcB12hvZBZHti5o1lheqotOTf0ycz+bVJWKYOmTxVUxlRLWr9h/ENV1/dgUYKdqfST26nwhFpRWrJE0xqubfUBt6tttsemgBfLUMrHWOL0q/vcKw6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788169628; c=relaxed/simple;
	bh=b4JrbUrAVTU2uN9lC3ojOC5jBSObZYZDIEdlLWP/FMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JKw7ej4z32cOxROFOlsBFmhUL7E5fqsaaTXMNxevxUv++Y4FQirY7Ev3AAOlfpD/8M/gxIecM0ieMLFvTc82cpMizPyZKKiU6REG+EJNzkbOCIHwGmTTmJfb1da1XWNHy+FC5fsv2L2AdYfOUVaHr53YvXmDj2Y32ekcAEwJSuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KQ2HRkQq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KQ2HRkQq"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V82G6V1530793;
	Mon, 31 Aug 2026 09:46:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=MQD3fN
	Hi7/uPbySor/Z5iiddi9gEtny6Dxc1mM7PBmU=; b=KQ2HRkQqcZiWB5uEU/uBMN
	fKe67fZ330H0IuVcIYySnl5x1+v28FPGjCOBoVm8LpDt9axpaNiU/T5ThVquy4jo
	kQcp1QdXtPT76cmSSNYze/xYleQ8++tP5VgRTWmLIgSmJ47yxh4kU1wIZ7xJ9bqR
	knA4uoBoIVhNXNiN7MrZAyRwoAmVePF0he4RLYTfbJFt+1n4dIZPxoJbXwUwVTel
	Yd3ryDoDlNDsdeWD7e11LRoB637UkQ+03FvU1rhok55bQvGTK+gemszvYkZ5nU/X
	DO5CBCQey61Q3InhjZ5L39znTDnl6CGKgp1kQCJEVEG2wHQi9o7vMecNzr19gumQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbmuhgmab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 09:46:52 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67V9fN8U024158;
	Mon, 31 Aug 2026 09:46:52 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcb8h53e8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 09:46:51 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67V9knAD30671150
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 09:46:50 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CEA1320040;
	Mon, 31 Aug 2026 09:46:49 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A56012004D;
	Mon, 31 Aug 2026 09:46:46 +0000 (GMT)
Received: from [9.124.216.250] (unknown [9.124.216.250])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 09:46:46 +0000 (GMT)
Message-ID: <cecdc333-f58a-4e8b-a3f5-774fd0e69cf7@linux.ibm.com>
Date: Mon, 31 Aug 2026 15:16:45 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/filesystems: fix missing and stale TARGETS
 entries
Content-Language: en-GB
To: Christian Brauner <brauner@kernel.org>
Cc: shuah@kernel.org, wenyang.linux@foxmail.com, akpm@linux-foundation.org,
        jlayton@kernel.org, jack@suse.cz, djwong@kernel.org,
        aleksa@amutable.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20260703150742.58991-1-disgoel@linux.ibm.com>
 <20260706-geerntet-neonlicht-liege-d005ee1904b3@brauner>
From: Disha Goel <disgoel@linux.ibm.com>
In-Reply-To: <20260706-geerntet-neonlicht-liege-d005ee1904b3@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: iK25nPqJV9LMSHvY6kvqzr8Ao2u6R1pp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA4MiBTYWx0ZWRfX3WbnHJidNza0
 5bcD24UDHBJT3OdC0RTh4RcaP5IW2r9GRGno85lJINHYZfGg3BODXA6SOElVdbkXnj4xCPc4GBW
 i+9zrCk0n3pmLuvijx9gDewK/aeYjNxbkXVH47mgT1Movch2e5cSAXg7tOkEM0DINfnPuouvCC4
 c6TrozPeJEV9GDEy67rMnue6CkRdK87QrZFF3p3XPQ6CgYhU5xEB9XP3EkB+j+EeGBivVGpziPK
 A51CL+Wx0xf03BihCnVrPmdaaUMSbx5oUdYBDJ5XHPM6w0TFBLlwwmRL762SqSPbQ0iS3k0iJ7d
 kpjGc2nVZPEW8bhfCgao0eKUKqNcKB3g5KzSK9DGEXX989bQ3P/xcLYpgy+DMSf/Jaz9gcSXs7+
 cMXLRf/IZpAxTjzy9+GjHvOTKkHVMhwhoXFKhCDxbFoTQZrABU+ScTU0nXebbReEbqU/aqSYuLX
 c6S7I3WmNQfLGTlXZGg==
X-Authority-Analysis: v=2.4 cv=Osl/DS/t c=1 sm=1 tr=0 ts=6a954d8d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=eVA08RXjztBVWkDe5H4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA4MiBTYWx0ZWRfX11HJJxU+eeeS
 JMBl5fvEdbfJfWt1hKZRiAggzNd/0RtAdYvDqCsAT2Zp1bOq9zBO6CWhkQC4brhr3cfur0g6X7Y
 equzcV2iFIBUlF9QCe32zriVefGrZDg=
X-Proofpoint-ORIG-GUID: qgkhNNAyywR0AQGm0QadpHke_BPzCSPy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310082

Gentle ping — is this patch merged or queued for a future merge window.

On 06/07/26 6:40 pm, Christian Brauner wrote:
>> filesystems/eventfd, filesystems/open_tree_ns and filesystems/xattr
>> were never added to TARGETS when introduced. filesystems/openat2 was
>> moved from selftests/openat2/ but the TARGETS entry was never updated,
>> leaving a stale entry pointing at a directory that no longer exists.
>>
>> Fix this by adding the four missing subdirectories to TARGETS and
>> removing the stale openat2 entry.
>>
>> Fixes: 7c37857fc23a ("selftests: add eventfd selftests")
>> Fixes: b8f7622aa6e3 ("selftests/open_tree: add OPEN_TREE_NAMESPACE tests")
>> Fixes: 7e28fef5d4db ("selftests/xattr: path-based AF_UNIX socket xattr tests")
>> Fixes: fe087927046c ("selftests: move openat2 tests to selftests/filesystems/")
>> Signed-off-by: Disha Goel <disgoel@linux.ibm.com>
> 
> Seems fine,
> Reviewed-by: Christian Brauner (Amutable) <brauner@kernel.org>
> 

-- 
Regards,
Disha

