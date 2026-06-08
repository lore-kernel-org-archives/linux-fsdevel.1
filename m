Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4DE3DDDC4;
	Mon,  8 Jun 2026 15:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780932770; cv=none; b=Oz4IlM2FQmlM0TRLpGIlo+A5JZPC0QbQ6hQAfQ6WE95fk01k6u8KaqFbCxbw0Pex4ZuNClBZ97kHpq9WyA4EFHtcOdEPRA4KOVZ5W7xeZfu9OovaQacgkGoSdok8iXp8F7cjKVhJydAFKbm4dADjVQt+d0iDNmanH2XOy1JZWyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780932770; c=relaxed/simple;
	bh=2x1TJNv4KL692wYDiKWxcw17UfjfTVPybB5+iFsmBg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PqFoUae3JPxegVkZIWEOEOedA9TZpnOaKU7b3jIK1pUbJrbLW9dVNU4tMI+4IB3cCF+Yy2H2cqUFFYoxy5HMfLCyjRv+FD0RDfcgDtmekKG0YYR+Sh1jfuF3rp+dLqAv+79mNBpumRtiTjlYmj6gv/O2+8JrQGDgV0/+/EF53ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NrlSIk+h; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NrlSIk+h"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6588xM0j3159944;
	Mon, 8 Jun 2026 15:32:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=SCpPv7
	JVtlx0M+VEYudc0GKqlb6+J5xmQEMVBPeEAD0=; b=NrlSIk+hGj7UkFgyHF7CVC
	QAdTpz5tdKmJRS09/9wYu3QVcySUSL+7pcLouwywsGhbd0AjH/mV4Xn2Ls1eSUpz
	WGBNK/Zdv+J44Rx2aEPxpsRqpszxqO8EKj1pXwQSwEGpqjmNA3ktPqOWBvuDG+wK
	Z+cwdrQkRrS1ANNvSRcZR8C9659qVU9MxMqLlSL28GuYuUedvcj/Jozsi+X1utWy
	X7IA9tTFcLpjELxnARQZ5MJWJMcfI4zeE8FjzZ0BK9jzgRoQ5ge/5XGSq5K42BrX
	CHV83Rah2toY3GPLgOIbLjxEjURrMvk4KVRAm4RanuV9JZmeHq8ruWMhS8sJIj1A
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em9ye00ec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 15:32:36 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 658FJhb1003696;
	Mon, 8 Jun 2026 15:32:36 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emx8vx1rg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 15:32:36 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 658FWY8F47710472
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jun 2026 15:32:34 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 318F120040;
	Mon,  8 Jun 2026 15:32:34 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 991252004B;
	Mon,  8 Jun 2026 15:32:33 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com (unknown [9.87.135.117])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  8 Jun 2026 15:32:33 +0000 (GMT)
Date: Mon, 8 Jun 2026 17:32:31 +0200
From: Jan Polensky <japo@linux.ibm.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: djwong@kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
        sj1557.seo@samsung.com, yuezhang.mo@sony.com
Subject: Re: [PATCH] exfat: add swap_activate support
Message-ID: <aibgj6XWdE2VIPiR@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
References: <CAKYAXd80+UfzKaCR9YRK8dAQq9S+kEp_VVwr_p3dj1tEeyqUQA@mail.gmail.com>
 <20260603131950.321858-1-japo@linux.ibm.com>
 <CAKYAXd-mLHaF6VeREroNfUXYYhqLObr=8Lmv9JqVZ7qu5XO0Dw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKYAXd-mLHaF6VeREroNfUXYYhqLObr=8Lmv9JqVZ7qu5XO0Dw@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE0NCBTYWx0ZWRfX/ab9J9Ud2s4R
 aBQ3FD2EOWsFzOdh4vr87wGPMTgWcGOFpe17Bv7XUECemwZNvEQuUhrtliF1PLyoyGrL2YYr4n9
 Nv6BJ42QevJvLBKSF3BYWNYgXdaev35oqG8m4kE6bktj1P8a7oDqnwq5O+EyoFJyS3TFww5fCqI
 GF+xzueMNpLkh2MhXEITMfnX8vxA7UNv6I8QN6fVgA8qsImvxTKou4Rv19t5EXHO5WBXMVqgGb4
 fEQqP4T+l2eGHXyMMfDd0wZ1IUXdct2lRD5EymDCQ6V0L22VOPv1FENMZvhAWCsKtG9kxCbMpEP
 xo7hkWQW40jtYjKaj+GRCc0RG5ZRjbHt3Xf9WsRJEIUyXQm1BgVJl0J7IKpD85kZB3N2TlMS3Kh
 OMbqJEwlAnOKEfWbZ2Wtg5mOdknQDz2p+svEy9KIB5jzBmzILfvnsQKpm3W46ZoR6DpUmlY7oKi
 3d3YyCWvwCAcs30UCsg==
X-Authority-Analysis: v=2.4 cv=QKhYgALL c=1 sm=1 tr=0 ts=6a26e094 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=BAQqc3zLvjUhQZapDGMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: DAYNeHlEW1HnFEN-cIxTQ5QVPWGCfAWM
X-Proofpoint-ORIG-GUID: DAYNeHlEW1HnFEN-cIxTQ5QVPWGCfAWM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080144

On Wed, Jun 03, 2026 at 11:34:55PM +0900, Namjae Jeon wrote:
> On Wed, Jun 3, 2026 at 10:20 PM Jan Polensky <japo@linux.ibm.com> wrote:
> >
> > Commit 614f71ca1bdf ("exfat: add iomap buffered I/O support")
> > converted exfat buffered I/O to iomap, but did not add a
> > .swap_activate handler to the address_space_operations.
> >
> > swapon(2) on an exfat swapfile then fails with EINVAL, which causes
> > LTP swap tests to fail.
> >
> > Add exfat_iomap_swap_activate() and hook it into exfat_aops so exfat
> > uses iomap_swapfile_activate() for swapfile activation.
> >
> > Fixes: 614f71ca1bdf ("exfat: add iomap buffered I/O support")
> > Closes: https://lore.kernel.org/all/20260603110212.3020276-1-japo@linux.ibm.com/
> > Signed-off-by: Jan Polensky <japo@linux.ibm.com>
> Applied it to #dev.
> Thanks!

Hi Namjae,

I think one line might have been missed when applying my patch:

    .swap_activate = exfat_iomap_swap_activate,

I checked linux-next (master and next-20260604 / next-20260605),
and the issue is still present there.

Link:
https://lore.kernel.org/all/20260603131950.321858-1-japo@linux.ibm.com/

Could you please take a look?

Thanks,
Jan
