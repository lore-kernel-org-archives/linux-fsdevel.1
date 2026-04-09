Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A1E3195FC
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Apr 2026 18:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775761004; cv=none; b=UxOH8bDVxAdrJ3FdUEIAZen7q/jf8G9wkeNghyk1hrfSMtniTE8V97io6zZWiLgcJPujWQj6AEb4+aqs5snV9/poOi6q7aLcdY3sBEjoTBC2XleSPiFmasqxAirvHZsv488HJaeoPv9TVwWs5lGaCEU/6mR3EVBPk7BY5p/PyM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775761004; c=relaxed/simple;
	bh=s8VtBesH9+RR7p0ccKkYYAEqr9HIwdQsu04bxw86QfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eo6xVFP2R8dye4tM1EoZzhykyh7rS5rXustLz/lknoxjuq1LuaIg5UIifyzPzcj13tSlIUSvQtfIA0DQEDrtlzPYCoWcfU1j3iFaySJgA+TTwbFiqyXHDNf4bzVwQe4GdPxNzl/Qt5mOtX2aSHyIws4eOghqoBwJKyvVY2FuX9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=C9NNnw7O; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="C9NNnw7O"
Received: from pps.filterd (m0167070.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 639Iu1G82341224
	for <linux-fsdevel@vger.kernel.org>; Thu, 9 Apr 2026 14:56:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=TidF
	UCcjURxrvT0mTb47uTbc8cUi8gBa7hb58XJT0I4=; b=C9NNnw7OyyNZTpLLiAgn
	1NGy89rwkfGQ8sKW2xsoDs3psZY5O19VidoJhD6BzpRDMyGkFkwTD1iN5wFldI0Z
	7ScowFZ5piO/9JjmpEEBRSlyCxja1P6z9Qy4nAXRuYvh4jS/8CaFyBXH4UDz1vcV
	7Mnk+PrEoPbR8rZZa1xVayXOGGpi39gL3Zntbbd7wmhqBLqzhA7J4itQLNZcZAbZ
	u4loMcbeOLC2TsS69QUqj1tdG4Qa70Zomc4Rnp/kG03BRMGpYgzzi5nZddQOssOj
	zWdOwOHr0li87w5xr9EbzOtHvvqqhmw6SVfAYvLxmRU3ocoFoYt5y+iH6so2OZRL
	eg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4decmrba92-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 09 Apr 2026 14:56:36 -0400 (EDT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8a965acd0b3so38364546d6.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Apr 2026 11:56:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775760996; x=1776365796;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TidFUCcjURxrvT0mTb47uTbc8cUi8gBa7hb58XJT0I4=;
        b=eg16BuQSm4LjQDJndDRutUn224Yj55AyNdeHrFGht2yjLbXwHx+7etp9Z4PCtSEyN7
         OlnB8mcPx+MM6PMEI4ROvga9w/AsBRIMJho3TAiI2BdjiSutOLEx/rOIEGQRTQaY+woc
         k0GMj7LF1dr7sudVxEDEvlzEIqlQXev5c1qCZR97V8uw6b1kfo+zPJeEXlXtBKMCwAip
         JoFPy0wgV5i5ZV1mV4wL8m970MsnrKs37lhsgH8tbVQCkVboMkzqSpkOXNy3SCEus5sy
         yo1LF+Q7KYw8N69ZAR0G8CW1a/bcJCaCjKp7nh10/6tG45ko2EHLEHLoH57wOgaqSygo
         zTBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHUBi3FjwEm4HKW8l6r6aVZ7k+M3acM84Qse3CoudoY+SnNHDFvtCj9m8GJ+UKn/iWkioeSxPuutomhYzE@vger.kernel.org
X-Gm-Message-State: AOJu0YxR6DHUQu8df/5UC+OzwWLJalg0eURXtfF0nTMb3Opfu/zPqkyJ
	Z3hcs+fFO6OgMVfu89TnjqXv5hTKSSAWM/A0rh8/+0AhwIlCMAxTa20cSDsy8ZoeRIYlUj+6zT9
	Ljcv6a9yXCMXHfqcgj+xk2qIzKNC92WFXY7A47LnJGssHOCunKmmFhmwqFngEhmrBVVj3RA4=
X-Gm-Gg: AeBDies/wBkKCK2ocx93Kt+x3EHZZGC5iSRR/9SNSil218HHhKDdHRW97s5zBjX5C5l
	RyJQTK1bHU21FxJlyocgdc0OZi+MvKnSY7WmdItU/80XZW/8Ch4DaeED9JYwrJErajyq/aH/EUT
	hugxYiXvC8XO8cqB5RmXoOcPLgxK5+YNXkxOYPRImWqvn9g+QvxYYFHlawFmMLE0eMsF+NGGklS
	wikyUE7gk98N+nLNUyU9vUsY103KjvjRfs4GDJngDBJOnq7YCnuOQf77qUPCxcmU6LUkw6UAPwp
	lJ+FOP6V1IK3pekeBJxAfHNpqD2lKu7hdZ/r3Z5XHiMoemxFgm/981QyZTHMgZM8rTyb8ExMASt
	YpNRaxKnTDCQFje8DDRrkg1hAdaP4tx8BV5QeTaAm
X-Received: by 2002:a05:620a:1990:b0:8cd:972d:335 with SMTP id af79cd13be357-8ddcf2be7c4mr2489685a.43.1775760995683;
        Thu, 09 Apr 2026 11:56:35 -0700 (PDT)
X-Received: by 2002:a05:620a:1990:b0:8cd:972d:335 with SMTP id af79cd13be357-8ddcf2be7c4mr2485285a.43.1775760995230;
        Thu, 09 Apr 2026 11:56:35 -0700 (PDT)
Received: from [10.206.71.59] ([129.236.231.31])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac849e35afsm4077376d6.3.2026.04.09.11.56.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 11:56:34 -0700 (PDT)
Message-ID: <874d1114-b742-4351-b25a-4521e1f8f6e0@columbia.edu>
Date: Thu, 9 Apr 2026 14:56:32 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v5 0/3] block: enable RWF_DONTCACHE for block devices
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
 <addM6bkKKtoMvDIG@infradead.org>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <addM6bkKKtoMvDIG@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ZRpmFxE9kW3Om7BaPZyB-1UfPAMWSmcw
X-Proofpoint-GUID: ZRpmFxE9kW3Om7BaPZyB-1UfPAMWSmcw
X-Authority-Analysis: v=2.4 cv=UOft2ify c=1 sm=1 tr=0 ts=69d7f664 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=RFpAoTwO7tzpE9r8PTiuXw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=svvvyxlR1OQQkelhaPoB:22
 a=cYlWaDRCFYRnH0kQEVgA:9 a=QEXdDO2ut3YA:10 a=QYH75iMubAgA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDE3MyBTYWx0ZWRfX0hlaiqwJ7PGj
 PsrozfnNeyag2K3zF8MnHICeMLUxj2FqVRAfNiTfzpBinxz1FlsDafj8xh69R3vN1bR0XBG0Q0t
 hWkCd9ex3Ly+j+qrp9Z2nvlGqermYUEMrve2fgINJxHZC7YcW2dXpWm9+nhJ2XnWMQF0GL9wT1R
 flcO3OJSfr+2QSDP0NiHzmI2QJ45z0kLyeAB/lIZtmYVLhiqMLQOlRnQvzaPAlNI0SV0vKf4j48
 AJFygNTwZhkc59mq6BgWF0+ds6wfjOr7Kmkta4o5yz7bWMs2xXH6UucurAJyEELzbpMPLy4K5QB
 RLuJMBQm1qmQW10bAHyo3Ks3nsQMa/wMHwP00DFnwncw/rdxHNjnFhe2nBjpqnWQu5hqcmcqEwQ
 a4CEtoBFDL9OziVV+rWAYyj6P6VnUjQLp9DRElsjm7za560g7wnWOeuOf598HAY/IiWnSFfILeT
 8B02YDYwGZWDFt5brBQ==
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11754
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=10 priorityscore=1501 lowpriorityscore=10
 suspectscore=0 bulkscore=10 clxscore=1015 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604090173

On 4/9/26 2:53 AM, Christoph Hellwig wrote:
> What tree is this against?  I tried Jens' for-next and for-7.1/block
> trees, linux-next and current mainline and it does not apply to any
> of them.

Sorry about that -- I had previously based this on an earlier rc and forgot
to rebase. For the next iteration, is there a preferred tree to rebase
onto? I see you rebased this on linux-next.

