Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2474A31E832
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Apr 2026 18:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775761160; cv=none; b=Sgb+EZXnCCaAB1nc2MYYuP+T6GgxRYTg59xG+sSx4nBGPkCxIdWBcQEavjazYgddy/xps7b3jPSKYMErNtDipwFbpISMLtfBDFYRLPZB/jPmXf5HidiSkI89wmgcMYqltDsmjX1ZNa/pYuHTTew3EOS1d8jRvC1AzcaorTyN6KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775761160; c=relaxed/simple;
	bh=83mNKZIsBND3Lg8+THcthV/SuzYcLTq1w+CNeg0fbZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pq7relgBRN3T7H/jVKRdzzSJLQhBsWou62raNyKFkhfaNPvhOF/apwfsL8brpVYhzIIHAoTTX/168/xLf5ToKSipQ3dJSPupv9l9mmRtnK/7CZ0aWCzJ0ewedMhdBvCoEge2MIpZ/vAYA1B0KTaKDC1JKvIzFaPJUsFaNyImUGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=EHz3tC4l; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="EHz3tC4l"
Received: from pps.filterd (m0167072.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 639IuCpT4153791
	for <linux-fsdevel@vger.kernel.org>; Thu, 9 Apr 2026 14:59:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=83mN
	KZIsBND3Lg8+THcthV/SuzYcLTq1w+CNeg0fbZc=; b=EHz3tC4lRgXai8PvPEZq
	pkKUs3OvD5nVT1jqwDXFpk6Rhe9R5SxV6b/feB3LGa6Ml2hWQWH9nTOnbI0jQzLo
	QLYJRGLVXQOHbFB1Vy36nqjvpb9IUyFleXcX5OznP1OtLhuMvp6uayzuz2W+yvxa
	bs5GuKsexDDUjrZp0lEwLGsyCESY+7+nHbIsv21ltQxArYbn0i1Bt/Bmp3jLurPn
	iki6jHLGtAFYO7D52XkMbj6PiglwXmCOboDjwVU3VjlwlhD1YByF+WvnaBhABguH
	kkai+Ec2gVbgexur9XaYmeywsRhFC5Ikw68louduoTGyWGonKSBQ7TCwkUGf3TYB
	lQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4def061n6j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 09 Apr 2026 14:59:18 -0400 (EDT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-89cd4f56e89so28482726d6.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Apr 2026 11:59:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775761157; x=1776365957;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=83mNKZIsBND3Lg8+THcthV/SuzYcLTq1w+CNeg0fbZc=;
        b=exNuzKLkwQpIrJkLkZCTAqWVbOMjOPWFVMOT55jdCNzEjYro0FuqKGILT4HVa3eRRs
         4BRlPnqowi7Afc/ePaI1xC0NE+OCr8Pbc4BIbB+frs0SyN1Ay0a6WRuGokl9Qbs7lRoE
         T6XAv6CMOqZXaFrSEbiTIxzPx/RCK1XrACuWcHUVoxoMsHAJe5csi4s+3cv5x3OgAiig
         XFMgFtDIiYZjqCGA1xxiC1O8r9eQ/f2GxvkmIWAKHzc4tMgPPjyGhiWzqVgDtstbHdsI
         cUKeZF09poZaPgCV1QJad1hxKwncTVvq78k1GOOF9BsN+JlX027Samov8PZ+LZYAgS3j
         AD/A==
X-Forwarded-Encrypted: i=1; AJvYcCVEh9wMDxL/C4cyt23heV5vDz9iGWrrgOR0c9i0TUrfuP98n86mSXKUg5Q2YQ3tkmNJ+gIl+T5QZr+dGTkV@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+ETG2RqauOraRgN46ggolM5vbb+QCnLy8Aq1apjQXEwRbWac9
	fB60yIzrFD7KItAxxALBKd/mYEB/72Blo1Uxzq6cmA0XuiaOkODWGEpfjUZJiWNr6c1hz6hO45Q
	6HeokVNKC7t1oSJGvzV6MZYstAeq2QnmBXx6qaoArb9fZI8H7o9LQGLwSYnkVsLg=
X-Gm-Gg: AeBDiet2FPHcZS8FBxW/Y2FzGrwNzqxkdaTfqBzbxvMTN2xjCCEfK5CNKyPQMo9gJuM
	qhaMVXtuo0NcP1oDBojpnfEm+RYy8dO9Ut8IjneD3Gk3QLbeGB9/gJWPzqF+2iyMmUd9ZIHeaO4
	GJiwYkrkUwyS6+lRi1q3ZWKxADjg0qZO5nN8YHIDmza6fm4P1WlSyURVx7wAcw9UZppyPhds7zE
	/uSe267dyFvLqNZ+ZMmacj26lNm2eKYHKsth3jvAOy0jdS07tX6mP8GlONl+nfco9IDqC49KCbG
	M1n9TBz2fW6l3+bfJ/AwoLNFJGHSkZJ8wR98+z9ty1MsMKpWOV7RXwZ5mzhTcFpfG36Qu2hdhDR
	KFKDwkWdyCKN5nFBuEwnv35hisnuTiTUjHMiuC+pp
X-Received: by 2002:a05:6214:44a1:b0:89c:bf90:e4ea with SMTP id 6a1803df08f44-8a7042f7e4amr439710516d6.34.1775761157324;
        Thu, 09 Apr 2026 11:59:17 -0700 (PDT)
X-Received: by 2002:a05:6214:44a1:b0:89c:bf90:e4ea with SMTP id 6a1803df08f44-8a7042f7e4amr439710016d6.34.1775761156904;
        Thu, 09 Apr 2026 11:59:16 -0700 (PDT)
Received: from [10.206.71.59] ([129.236.231.31])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac849db735sm4286926d6.2.2026.04.09.11.59.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 11:59:16 -0700 (PDT)
Message-ID: <fdbb90a3-846f-4b55-b22a-5a8027bee288@columbia.edu>
Date: Thu, 9 Apr 2026 14:59:15 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v5 3/3] block: enable RWF_DONTCACHE for block devices
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong"
 <djwong@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Dave Chinner <dgc@kernel.org>, Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
References: <20260408-blk-dontcache-v5-0-0f080c20a96f@columbia.edu>
 <20260408-blk-dontcache-v5-3-0f080c20a96f@columbia.edu>
 <adfPA0_U312XhCYF@infradead.org>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <adfPA0_U312XhCYF@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: bBVjyZy7JUNAHYFHYSqULF0LC1DUCQwf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDE3MyBTYWx0ZWRfXzac4KMjSHUlv
 4X0ZAXAuU3/sVmfBd7tMtA10v4s1lpfbaddnkyUPcbxGiTW6Og4ubxVJHnhg5qv6fvpRzBObnNl
 iXrH3VSUNrh109G2toPNPIYEPVSKgRwtKLjng7FVLnPS15uU5nf5xiCT39PMuvX3ogCJb9G00Lf
 FFPQqK/FctxbsuDns6f9zixoOS7Eu8ZxfAVQMsw1sF4PZA5Twz0c3zhcnVp0hxaRNuMdDtY9yCg
 M45bwmslN7g38aqY6q90AlmoTYH6JdCBU22eJCGcukZuGsY7L1OoVMZH1KOhAZutcrnn5xQRex2
 qCri05OSE4CWvI3Q7suDKc3gralX05+rtp6QVdqllOh6r6R2g9XPdxazBtw6H8vqwVwbgyVZkqJ
 HKHPzedhdN6/kayqxT4jlq/6hd4wq5yrK/GKLy/FBwcj7L32b2UHJ2ZOv5sjdY+5sSZeyTCMES9
 dxN1JPUGxOORKbWz4Qw==
X-Proofpoint-GUID: bBVjyZy7JUNAHYFHYSqULF0LC1DUCQwf
X-Authority-Analysis: v=2.4 cv=GP841ONK c=1 sm=1 tr=0 ts=69d7f706 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=RFpAoTwO7tzpE9r8PTiuXw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=SsB-OO3BMngHh3ZO9fOt:22
 a=VtaHy3UVxHd-gCO4CH0A:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11754
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=10 impostorscore=10
 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0 phishscore=0
 bulkscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604090173

On 4/9/26 12:08 PM, Christoph Hellwig wrote:
> For the next round please split this into the buffer.c parts for
> the infrastructure and the use in the block device file operations.

Will do.
