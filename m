Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8344F4CE5
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2026 19:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792004407; cv=none; b=FNtDE0y6f41LmHWiPg7oSkFxUajf9WD2Nlb2KNtcUwLT+tjIQGZ/DAhWJbtM0VCWGAzsQlX3EAGFnVEBVZF8tkhsTdYFG/QZjcxDkWZZ0nWLA9Fb+hxBmahlHlpDsL4zAFyudB3lPWaiQV/EuqLDDtI8wcIPz8szwP8qYr6HYFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792004407; c=relaxed/simple;
	bh=Rb8XZmmvT8cxn74MXNUCeOuPGauZxlvtGCiTJh0eb40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dgbk26qpzrS20la9/PK0uGbixOnhQucusvrQ1iXq9HluNOO02wWg/TeqHFWQ6D+YWlJQN3Afc2MK7gK1DKMb5XK6+ce0OZB/Z3UgUjx7m2x6yHpiid12xCR3im5z/SpA0cRXP/03imHqJswxarDfDNwmbhr+Xzt1SYuhYztitrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=mWWj+UUG; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=EOZCkvnc; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="mWWj+UUG";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="EOZCkvnc"
Received: from pps.filterd (m0167070.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EInshB3364305
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2026 15:00:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=SHv5
	vB/tk7sll8Kkk+NHhBijfzgb1pYQHOyGwy6N4aU=; b=mWWj+UUGvdXSLYjqGKBk
	qRjyZAFUBqKDFrBsJRjkInUs3ju9ynsaD1j6tJXOE3D0QkYUleR2qkiM6AT/S4pI
	vyObvXKzpUi43jFMC6RmvfwI/sftJiI+Hw4rC/jRdrGpIQEIu2NtmXyndK6GA255
	bd1juLQfEt+qjg448awRfj7cNjD53xF9l7L663bj54t/tGEbjs/hllrUIfkkgnbe
	BIUvzpNKtqm8z3t+iPKuTj9dC/dPMoTDtxhMJvHK7TRZqVaOLjqkSpyqJWILv2w8
	1B2EwMv2fuKSjN86b6U1uEvcoH3PsxtASiWjbYjlsZ+dOFtthToPQ0JdCQVlHupv
	rQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4hae508sfs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2026 15:00:04 -0400 (EDT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-9195c59ac8cso139957936d6.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2026 12:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1792004403; x=1792609203; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SHv5vB/tk7sll8Kkk+NHhBijfzgb1pYQHOyGwy6N4aU=;
        b=EOZCkvnc97Ow0Z1O7ANC71LBs16Aj4MTwavh2MkWeyTuCjAPDXGVLTEbrqUEnwHxFh
         4/7QajRt4sdXQS717Kh1RRCdQ8SCNB1AmloXvoW1yN7vPrinMNyKJKmrQH+RX9OZZiG8
         zwOcuuJU25SVl9vBmwLNHnEEM/+oHhmiSw7glHvgJqiTUxUcVuc+PhZNzwCPTGiP2ZWl
         xqjQ4fKuuNBmnMCGmTdGR7Y8Msprtg/tjWTG7dtR15z1m45ldWKXVAxOe3tkj8w0TxiC
         OHVG01kYNVxrYFZtDmnndd4vPBswTHn4YiDD60ljNmasC5iGM3N5T+3VSFE2idKBjEJi
         1INQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792004403; x=1792609203;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SHv5vB/tk7sll8Kkk+NHhBijfzgb1pYQHOyGwy6N4aU=;
        b=szMNs7qkZC/xCj2fksx3KB9Vre7xGyjtiBo/iJCU5M+UUMfS4efx4rfPru31yKng8u
         qIjdzjlWKoZetql7Sse6B+OqVu8spNlvvWVeXepdRust6I9vzrJ4BwqQruOHtxdftiVd
         eH80wvHqLRLPVGeI1LHo3ZXoTX2DHZYL0HVUYqi906Y044CVE4iico/+Qty7QD0VsB7Z
         cduM7HDGj+XPLn1n0qXz0lBn7BlOWn695Vo5jB+Ax70AUNsWux4MuUEPEs3S5jvtSeH/
         8pUQUXPVH38jdTT0KprkD2goBb7/78Lvf7smMBdN/Qv/mUx9GWJpNHBGv1pTFV4iI8To
         qqpw==
X-Forwarded-Encrypted: i=1; AKwUvBwycX6D8SEjq5L8DcU6COkAIOnAypnlxvVbWNopJ4hviGSkPRO6I1HdkFRliaCL91+/ZfHl9kKXSUnHXX+8@vger.kernel.org
X-Gm-Message-State: AFq9FYK0E0UfAr+zCdnWgNaBFqtIhIFtQrLYre9AytGQhH+zMpGVs8QI
	nAK0qWf11RNKAeYpe46aykBbhOjROmI566SImL9NBlr1vdVrVjaUh5X16SHDyxvJuUDpxJgvU1z
	/a1JEDCONqM9xMoYOxUpP8JRDWQllBC5TW2T/vVsvy2mCbxzQBQEqWYua9Rp5UdU=
X-Gm-Gg: AYBFou0jP+AwPVqM9sgIr0JMakUs8WGRygM1ot3WgBIkX0/7qIPoTSLKyg/Do0cXZ5h
	+YXQ0UwoKFMKwNDx0uChFM2bfYp9SxF7G2nrJnNmMr8qyiX1CAwSDX9m6JX5dnRWNEGq9GOu6Og
	pP7rPTXzIuWv+suI1tSrLEzdQCvfk7JIA91M+a6eIWUYtaw5ZfCfpjgZDHuL2J5M6ivQtxJTYh/
	rC6EBEtsKvjoRVnchAWdrpuczq1b9i5uvoWpzcnh5bJTEDvL54IsPYwDi7o+WT603Uo66NMNHYk
	uE+2FpF3m5S1yN5cqXD+JXNT0MYbwDkecvL3qF3MkPPZsXqnHGDIz5yKCbnL/idHbt78g8FnfkE
	0nuLy0hsSbFs5xUoaJS5Zk694TAzO3sC1w5+fc/5Zji5wGQ3z
X-Received: by 2002:ad4:5c85:0:b0:91b:5d39:e12b with SMTP id 6a1803df08f44-91b5d39e8fcmr282066466d6.52.1792004403632;
        Wed, 14 Oct 2026 12:00:03 -0700 (PDT)
X-Received: by 2002:ad4:5c85:0:b0:91b:5d39:e12b with SMTP id 6a1803df08f44-91b5d39e8fcmr282065896d6.52.1792004403051;
        Wed, 14 Oct 2026 12:00:03 -0700 (PDT)
Received: from [10.207.9.0] (nat-128-59-176-148.net.columbia.edu. [128.59.176.148])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b97b3864dsm59747086d6.14.2026.10.14.12.00.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 12:00:02 -0700 (PDT)
Message-ID: <54a2b38f-f863-48dc-be26-b18949be337d@columbia.edu>
Date: Wed, 14 Oct 2026 15:00:01 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/9] block: fail a short atomic pin in
 bio_iov_iter_get_pages()
To: John Garry <john.garry@linux.dev>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Hannes Reinecke <hare@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong"
 <djwong@kernel.org>,
        Keith Busch <kbusch@kernel.org>, "Martin K. Petersen" <mkp@kernel.org>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Sashiko <sashiko-bot@kernel.org>
References: <20261009-blkdev-fixes-v6-0-307939c387df@columbia.edu>
 <20261009-blkdev-fixes-v6-5-307939c387df@columbia.edu>
 <82978d5c-3e08-48e9-bf0a-7913e1cd0507@linux.dev>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <82978d5c-3e08-48e9-bf0a-7913e1cd0507@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: mjyQ2nzL1C4PIg2UtfZ2yNrZxZnaLuL2
X-Proofpoint-GUID: mjyQ2nzL1C4PIg2UtfZ2yNrZxZnaLuL2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA3NSBTYWx0ZWRfX0P4v0mKIxkHg
 0Om1pxZY2freHjdWMXw26t2HOJ1iFboaaWYDt8NskalJVIvtmp7If0aDha0oP82VBRVlVP6KB4N
 n1i2JRx05Y8ik1z0CfD9xDNxzADmIs/AKszn4hOg+JwkcHxAIDRLa2HVIjSnM4EXtLef4PLcGUx
 iK6Ku0WCIHoWe/ehs5wQDNIbZASpKOUcQI7o/grUGcLBX+uxFU/b35tgkNyAMV/gTu4QKQ39rVq
 otEr6IWl0Glb1OaNr/wJYhxjRqZQ9aS2QW7GommZE3yaJhoZIbAWcWlgJYiJ9xILZcN2fDzCaAw
 RGU7zqsTe/1chjncmXnnBSKRVTMuF1NS9UvSbXmZHwNXn0Gyq5JSoHd9zQUIVGuvCiu9P6SrAKN
 0thI7we7EHlqBPZpgqWti24e88wk1lW/UCQKcslUQzEp+nYER1YSJZYkjOYRLEFM5iSsIVvwt2o
 sWHPoT5dMyygW+TZmAg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA3NSBTYWx0ZWRfXxXJHCoY5WtSf
 57SAXQfMw0RVgNiTYF/aOh4oChB1mbGxSeM16npg4DZ4dbA1AYbBn4ewKeehGu70X6IOdMkl795
 WDDRg03ZFSFh2JRqtwkLIYF070/4GVvDUpeGBKYa9h8oFJky3qs5
X-Authority-Analysis: v=2.4 cv=fKqsTpae c=1 sm=1 tr=0 ts=6acfd134 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=dxtdfZqDOO0kCslK4e47hQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=svvvyxlR1OQQkelhaPoB:22
 a=p2SREvNk3m13K0H494MA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11935
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 lowpriorityscore=10 phishscore=0 malwarescore=0 bulkscore=10 impostorscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140075

On 10/13/26 4:40 AM, John Garry wrote:
> I think that you can now remove the REQ_ATOMIC check after the
> iomap_dio_bio_iter_one() -> bio_iov_iter_get_pages() call also; however,
> considering the trees, it's better to wait until 7.4-rc1 is released.
> 
> Thanks,
> John
> 

Sounds good, I'll queue that up for post-merge window.

Thanks,
Tal
