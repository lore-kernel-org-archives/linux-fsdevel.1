Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794248861;
	b=zZg70XHAKZIBFRdMGEAEzNxUIh9KXJUMUzD00SGPNgBPe0vEOuRL3mdEfvXlD1daj0Cv
	 GnhFGVgVHz2tHcDKRC+9CFcoWwVAcsG5fqxRIZ/xdrxFtvk7vkgdsg0KN/bhJMJ1KBURL
	 k0oxtKET8BXzHE51p8mWx+iH/cPaq1JA8mPGjTV/Cvovg63hNH9FV3sSas8Bz8cH2Lyqi
	 4MJkT1uEW3P/VZSqQvVvPuTNuHlyIZYbyUNEJdlXk+KjS+aU1dQB1LzvTpNW8H+9puCPU
	 J/Q3Ib6tVJvEzC0fon4Vy/F3/KIuQ2xqhOR19bjXWY8IUx0rRgc1MdDYsCZynMy/V0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248861;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=3LmoJP6g3WtU8XQSQhoDtd6EbgMyoETHVY4mSGzEhSU=;
	b=2sa1/xIkGIkP1Ww866yv0+7hJ8KKu3C/ZfO3UhY/EkdgOPp6FNmYk620KkMlRIwhBYBJ
	 wJdPyo3vVgFi5jwMmG9wtCbdNvGEyd97hIMioW8vjHFIPSZZ+y4kvMnEzKCE/iwZMI2kg
	 ramehDlhSf+tsAhGoZvpzNxLkLee5L4p0OznHG5/ieBXCdADFFTmiUUJ2cHiU1391fiBA
	 TMTwGSgXdFVLpz5LT/bMk/dd6Ii8omb2fqw8wdQPnw3lj7B6m9SZKCJeYhLUSDCcL2N4n
	 dPNABPehOzfNJ3EoFT8kdIes6No2wcQeYTmPSptkK83KRalQtr68CiYy2/xmIdzH+6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=kCc8EzR+;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b="uF9wMu/4";
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5C2606A335
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2026 18:27:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB5C2606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=kCc8EzR+;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=uF9wMu/4
Received: from pps.filterd (m0167070.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9HZ1LJ2298929
	for <linux-fsdevel@vger.kernel.org>; Mon, 9 Nov 2026 13:27:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=3Lmo
	JP6g3WtU8XQSQhoDtd6EbgMyoETHVY4mSGzEhSU=; b=kCc8EzR+b4HrbTrsozWd
	wB3ICfreUm+eixPxqajsNMRIlnZon/Sy5lgy3EzkzghBxLoNs7vYP8QRVS5rLdLC
	kEVhJL0Ph48wv907s6NMXcnDWDU9YBxuYW3XDklW9eHfl3reIVYXlFL8w4j8XZ5S
	rpePeD7RDGFYYNe+aTEy/xR20NBr+fZ+WZKH93POyM4xwQ+vdsJsmIr+vUBE86gJ
	QtxJVaJmLLpxBpdT9BkUENMgRHdgQ2KPWWAzb8uyAyajGaEByZH3EnEtyGEvXqEc
	WzNgU7Uv19RY6DHPQkYJ/3Wr8kf8Jr0eb2FmHas8iniDLBLHep7M7Z9JCFaHSFP2
	gw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4huhda19rr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 09 Nov 2026 13:27:32 -0500 (EST)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-53661e036a2so25708831cf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Nov 2026 10:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794248852; x=1794853652; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3LmoJP6g3WtU8XQSQhoDtd6EbgMyoETHVY4mSGzEhSU=;
        b=uF9wMu/4H29cIsrk2claBd6GaJ/dUYrENKFpwSi28u+CaRmvimN68tPNtHmySxeLun
         jyKS2DHQVN4yQZaxky8bS+m8V0YULEcbTQX6OQ6aIm2ooqwu9D6GycZ9NCrwr8pkxhop
         K5BVAgDopGr3LXDX/jm+yhNEmR7oQGqooYsqrhPtq3PdzSO/34akVMHykDBMAm3Z8PXt
         ztZlwpy/hm1BKK8DfAwWwYP6Emzq+yIAiG5XqrmuvWQoLGxs3oqMvf+7MQ24nCdFFoeO
         UQLoOfFL47g1UrujfRiVj/fpeQdmsSD0f8+IwmhPbp/5JYloVmMKseRWrtZOZDE8oijx
         5V5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794248852; x=1794853652;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3LmoJP6g3WtU8XQSQhoDtd6EbgMyoETHVY4mSGzEhSU=;
        b=gW6LYGNzYt3Ewzrifse9q7dLEc8kovsiLkCDIFffqh6RETxByoqC1BLIONdPbdEt3q
         78SGtxhwPqcdJlfuy/zU7F62dZedBxri9SH86AKR3KkNP0T2KvoJN9Hm75ABmim2EjC/
         5X0LbgQbvYrtQ5G6KQcVvToBiKQg7E9ncB0LksPhF5akJQNwtLHRIyq8E60k6BSp/VQW
         xgf5kQy6WqO9XOAFQtNFNEpRKvIUX9ZAHRGq7bS3q6zHtARcf1S5SoEOYRQ7ecu0AVnz
         FJZWlW1PLSZnF6aeTSDYNtFMdFpi+3EIPxY3/UOr9Kjebl0m74x/MJXhTi6plIeiRzpc
         5SNA==
X-Forwarded-Encrypted: i=1; AL+hErGfOK5qRa/rtj7sCtdOpwc5HYbIYk9Ul+R8MiU4qywfA2tutXI9Qn4HMy1eGW2dxtDMn0J+2gZfT0vzVOAm@vger.kernel.org
X-Gm-Message-State: APuU4Z/JOdNBO3oyQm0173OApKk6x92ra3Z0Uern/jVGKHqAh3YKiOEZ
	x7fbh1l7MgsWqRmHDInX64auidnGwuzooqVanC2X3uusog7EA4ZbarlgP6pk3lzo9QulJX02BtU
	J6UHkhH5oQBvq63waOZpLpFG5EAjeAOQkdt0mxut9Bj0aY/26LhXciTuxRtP2YwQ=
X-Gm-Gg: AYBFou0f8cwKqU/Qu60kfS1AfeW4yz7letkWdb0bCTLO22Kd+ijgZzBxpNlL12gxiwc
	08AE12mM5kgtmAGpZEwuvyj2Db7OFI5IWWNegtElrqGFU56dC4PXtTMhB4gzKNDf+OyA2KSPaoN
	5Yu0I7a5rPec+yMyjTMlde9Ux6Y4YVSA2ouQmmpUPlxdpKw2c0x384B0qKqk07o8YsZkvO/vPkz
	6RFes/jaaAIqRKpdocz/P6ZzVjhutfZ3U9Wwatd2yWKAIRSlUckx2FEVCOmNaQ2qyLIkRXamDvn
	Ef9inra4OgCceol9AGSuW6nol1u69SOnJXS2t9FbApVN1D1LOJtg9SvSwJEh2C9ePECIoXEgCin
	Kth9u66v3j7B3LW/YfHjD4AX2nxc6B2T553W7Dpo6Zp2a3vB9Fp5kKhMN7SEWHiogl0/L2EwspZ
	+aHC7Pov8ljSSHm8CbdobW27A=
X-Received: by 2002:a05:622a:5b8b:b0:536:6c87:ebd7 with SMTP id d75a77b69052e-5552b64e9f2mr1970911cf.69.1794248851898;
        Mon, 09 Nov 2026 10:27:31 -0800 (PST)
X-Received: by 2002:a05:622a:5b8b:b0:536:6c87:ebd7 with SMTP id d75a77b69052e-5552b64e9f2mr1970471cf.69.1794248851255;
        Mon, 09 Nov 2026 10:27:31 -0800 (PST)
Received: from [10.207.116.169] (nat-128-59-178-16.net.columbia.edu. [128.59.178.16])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5550b4516c6sm3479241cf.12.2026.11.09.10.27.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 10:27:30 -0800 (PST)
Message-ID: <74c7632e-52fa-4378-a15b-f90b492fe613@columbia.edu>
Date: Mon, 9 Nov 2026 13:27:30 -0500
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
Subject: Re: [PATCH 1/2] block: fail a short atomic bounce in
 bio_iov_iter_bounce_write()
To: John Garry <john.garry@linux.dev>, Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20261107-blkdev-atomic-bounce-v1-0-f66344262096@columbia.edu>
 <20261107-blkdev-atomic-bounce-v1-1-f66344262096@columbia.edu>
 <6bc16c54-a9f1-4c51-ab68-b227eeecaf66@linux.dev>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <6bc16c54-a9f1-4c51-ab68-b227eeecaf66@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=NMVAaE6g c=1 sm=1 tr=0 ts=6af21094 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=Gl6UJ28otdLh1ydVN8wMBg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=svvvyxlR1OQQkelhaPoB:22
 a=sFb2lJ8PKqpIU8oD2L0A:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: iX5CCjiEfjfkTf0F9TZQ4HFzgbN-IuHF
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA3MyBTYWx0ZWRfX4OOPqWWQkRHu
 t5sZeJIwyHcw0UIdRIxEaWouEXLasbRae270BVVODocnD+O5w+1lOX850b6HL41Zkln1uwZXMU5
 CQWoDwQI8+sTov73om8/FRhPxm92h5aBE4rRokuIiPv9etSDZa8O
X-Proofpoint-GUID: iX5CCjiEfjfkTf0F9TZQ4HFzgbN-IuHF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA3MyBTYWx0ZWRfX49CMYySaoDnu
 M3PkG/O9xxrJ+DOzN7AEkNhegvfc+RUUER0cnsjS4XgAxYX4+PesByNz1ku5CNWvqwjmQdHdGIp
 fXjFakxBNKzTnrE1uCf45GfzU7KOmz7Wd5k/QaENVklDxsiEvJcVmTOXxrrbko873RzI5yU6Iil
 Rg2Caa6pauQHfgYsMlgo4o1ppXjYUi7u8PlL/QrZaVw+CcScALSUnkIUgHc7dcejbUnlMo+KdXU
 aoAJpZbpEvFM0YAz8dKHsvYyyv85TDdBFYiuwMEWdlKK+FCOYruIviBVhvVpfJsofBBXb62zVRT
 QP47R8aGSX0MBDKTZqX4/+n3G9tK4eya+kWPT0803dpK59S3+Kzk6P/N13qkK4gP48G4lXArvUT
 G1JbHkUTegrPSM8Y6+x66WzyXOUj1jyvzw1SQ+Z1V5ogswDikrMr/OouD0AUTbJqaa3xLxgAPEE
 XwX41iYuDZBuW6xcp5Q==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11961
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=10 bulkscore=10 impostorscore=10 malwarescore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611090073

On 11/8/26 12:13 PM, John Garry wrote:
> On 11/8/26 04:24, Tal Zussman wrote:
>> bio_iov_iter_get_pages() fails a REQ_ATOMIC bio that doesn't cover the
>> whole iterator, since an atomic write is submitted as a single bio, and
>> submitting only part of it would tear the write. In contrast,
>> bio_iov_iter_bounce_write() doesn't. If a folio allocation fails partway
>> through, it returns a short bio, which for an atomic write triggers a
>> WARN_ON_ONCE() in iomap_dio_bio_iter_one().
>> 
>> Make bio_iov_iter_bounce_write() also check that a REQ_ATOMIC bio covers
>> the whole iterator, and clean up and return -EINVAL if it doesn't.
>> 
>> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> 
> This looks reasonable, as atomic stable writes are implied to be
> supported from 3373503df025a ("xfs: use bounce buffering direct I/O when
> the device requires stable pages"). I am wondering how to test and prove
> this (change is good and maintained)?
> 

I tested this with XFS on scsi_debug (dif=1 dix=1 atomic_wr=1), doing
1M RWF_ATOMIC direct writes and using fail_page_alloc to make the
folio allocations in bio_alloc_bounce_folios() fail partway through.
I had an LLM make it pretty precise and target bio_alloc_bounce_folios()
using the stack filtering mechanism, so I don't think this necessarily
makes sense as an xfstest if that's what you were thinking...

Without this patch, the write returns -EINVAL and hits the
WARN_ON_ONCE() in iomap_dio_bio_iter_one(). With it, the write returns
-EINVAL without the warning.

This also happened to turn up a scsi_debug bug: with dif=1 dix=1 it
doesn't store the protection information for WRITE ATOMIC(16), so
reading back an atomic write fails. I'll send a separate patch for that.

Does that answer your question/is that what you were getting at?

Thanks,
Tal

>> ---
>>   block/bio.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>> 
>> diff --git a/block/bio.c b/block/bio.c
>> index b0fcc69de653..61a3812520a2 100644
>> --- a/block/bio.c
>> +++ b/block/bio.c
>> @@ -1523,6 +1523,16 @@ int bio_iov_iter_bounce_write(struct bio *bio, struct iov_iter *iter,
>>   		}
>>   	}
>>   
>> +	/*
>> +	 * An atomic write is submitted as a single bio, so it has to cover
>> +	 * the whole iterator or it would be torn.
>> +	 */
>> +	if ((bio->bi_opf & REQ_ATOMIC) && iov_iter_count(iter)) {
>> +		iov_iter_revert(iter, total_copied);
>> +		bio_free_folios(bio);
>> +		return -EINVAL;
>> +	}
>> +
>>   	return 0;
>>   }
>>   EXPORT_SYMBOL_GPL(bio_iov_iter_bounce_write);
>> 
> 

