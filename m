Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5864517BD7
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Sep 2026 22:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788561317; cv=none; b=YbG6XZqGiWFp4SdlP2P1v0Pe/CCSXWgBOPxoJ3SwESWVJ8WPf0kO6C6ZPxGsylyaUZ72l9aFXPS5uLnlpKblipLq3byGFfHZhIhpkuqk5UXBa1INcEA6JXNoUTFOFTqt7ewYunVrJFekR5jKwl1TCquBIfb4C8jH+jNR1pzmvNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788561317; c=relaxed/simple;
	bh=DA84oxU3rQPrvSsuP6rsi2zMphGkpHQDobH17fbWDNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JZAMjqCu0ndh4PENRnuF2TQVfJSXQ9qemebiaCqy8FdYYUkh0K3Bqv2ebQ/2SJfI2JoC15+Hh6Cs04fp2fcemAbH922h2h7ou/vPtmsjSXW0yYdd422It1gYhRC5gHHLeyz9pVoBdBNJpU5neOLwUL9CS2QFqgSC5AMberO4JU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=OM83EIbe; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=p4AhNWtA; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="OM83EIbe";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="p4AhNWtA"
Received: from pps.filterd (m0167069.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684MWxnQ426845
	for <linux-fsdevel@vger.kernel.org>; Fri, 4 Sep 2026 18:35:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=NS3I
	WLMNep/DrvoibIPUp7dIa6zL29X7BYhj1p+bdp0=; b=OM83EIbeyrJBmKFxiBn7
	95BjxB368qVNGNObkjZ85O1d248QOiUYlzhhJJep+Gt6Hi2B8Fzo7oVG64eJc/tj
	zbc2s9qp5g61Kxn9jIQmS3ffGdAlGQCLFIZHun44tpLrXKQNNfvb8FNBH5XRYio2
	Z0cVo9Dhz5NYwVILy/CkqWJ4AHXPq0IB3wvtxsLVRMEl30S7UHiN5mLrnAZYCkPg
	El3m/66187L/MxMuSPzMn+/WT6GRdkqqrMx3xhVwRJ1iy26arqEVzNfdiHL4NoDp
	xnLYfSKwSetCrD1jSwhPGIAgpUmWjZfBSh9+fhBno0Kz/ApUcGuNj1MCJ7bpAC3u
	VQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4gg0abbhch-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Fri, 04 Sep 2026 18:35:11 -0400 (EDT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93909014c85so254053385a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Sep 2026 15:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1788561311; x=1789166111; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NS3IWLMNep/DrvoibIPUp7dIa6zL29X7BYhj1p+bdp0=;
        b=p4AhNWtAX8wTG5vcPeNMdAcvakpQAgw5k6QYrC1/brPsb0ngW6tTBFeahesat9odxP
         3/CeRuSUVwltWS+YmhVbW32ySRK+wgeoOP1mAg5qJNFADd22/RTTdMNo4WY+nsgFcy3r
         tIM/Lc66jspSRsVFs4xxPN+Iyz68ZXTVepvBh/ovG2zevFudQ6nymIw3vOLr+xw+dd+A
         EMIVdCQHwdZQI0YqVYI0xQPp60no3jNtSJVJQMeZMMAwOv+upZeY/nwE2mtrIFqpUx++
         99tApD++TY7WQocdN+Vb/ljMdRb2f+sL2dbkP2mxUEqvWoG27jkwA13Ty0hfNuxG3/9t
         MyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788561311; x=1789166111;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NS3IWLMNep/DrvoibIPUp7dIa6zL29X7BYhj1p+bdp0=;
        b=gltCfxE+zPjgBo3jULIbFUe8XDYvgEWk1JOUxKrzEu1qzmyngIO9+coKYHrQBp+0rs
         e2jrgXl2w657kPM2HYvrJEnquPisufExnGVAAHDtgDw4Nb1IOA1uPvZZ9h8nr4GdNrOZ
         ZJYnp6a5yoDrCuecKmi6Jwj7zM8kvivcn7dkVIf5iuCPLy+HmfeLSHlO/fZjjaelcMiP
         gyqQpdzGXWYYb83UDO77wOtn8RDWRF0+eZAQiLYN49lM7J93ck09VYgHFwOjtU5tSiha
         Nb/MBXpWVtSwOadl4Dz+8Jk9L1Mve2MDRW+SfBKOIb7qw0V1I/2pfwOnAZZ02E9/I9zg
         JcOg==
X-Forwarded-Encrypted: i=1; AKwUvBwd1wGBRtYBN+dsp7lJh097T4ThRHTD3KtAEmITwvkj11Q6UOBM7An6UcuTCYIv/FuMzGcsIg+uwEUyqyWs@vger.kernel.org
X-Gm-Message-State: AFuF++klmZELoqlK+5nNACgl/E6s3V5R9iDC1D7w7XDV35f7Q2A5XzGh
	l3VsZ4nBG0MqP8vT/nzWuJiTIMxMzEy/QVqpM+iLRvkzd8+/sKVvs9YgwRYC8UGQ15cpxV1A0uB
	RF5x65xGp8Bc3TNmElYgSF3SMcUu/roUQofmwSQD0o0SVSrz6jh9FCqIMyfYHH8g=
X-Gm-Gg: AYBFou00LsN2cZkaW+o/41CRqwG/BzBD7eOmCVN7NFUpHFxZVt3cEXCy40DD45+IbQC
	NxSsBHRM0iQnSZ/a8rp2smijvtgeV+FuJQ4hZUlrajs4Z3Dn+ER++NZILgf9uMO3gTo/vm5HHwL
	0ljOLlBddCVVuz/vTtDFlQWe92Qvy72SyLds1YC4VmsE5ftdZZND+NjsCVTZy5gEm2frPJMRw46
	5pGfwXGgw+N1Vm1/You8lOmvQLi89wH/HBd5lKn4TFaq7+YTam4VCnd6ueNwaeu+3nEIfZd/Gfl
	xTB9n3Tj8QR1beBoEpAym8khL/x+pySggrsyoziRQjvpEnn1IchExSUSUUH5fezxDGlj7OaCvyE
	DP+8I6HA+TJHG6FIIcx3NbGHdMewLSZpV/0mEhy2CuHyw8qjQ4MEO
X-Received: by 2002:a05:620a:44c3:b0:939:8905:ce9b with SMTP id af79cd13be357-9398905d927mr531684185a.17.1788561310782;
        Fri, 04 Sep 2026 15:35:10 -0700 (PDT)
X-Received: by 2002:a05:620a:44c3:b0:939:8905:ce9b with SMTP id af79cd13be357-9398905d927mr531679985a.17.1788561310278;
        Fri, 04 Sep 2026 15:35:10 -0700 (PDT)
Received: from [10.207.49.22] (nat-128-59-177-158.net.columbia.edu. [128.59.177.158])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91040664be1sm31193686d6.18.2026.09.04.15.35.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 15:35:09 -0700 (PDT)
Message-ID: <789e5449-fc8b-4ef4-9571-26abd514681b@columbia.edu>
Date: Fri, 4 Sep 2026 18:35:09 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] f2fs: complete dropbehind write bios in task
 context
To: Wenjie Qi <qwjhust@gmail.com>, jaegeuk@kernel.org, chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        hch@lst.de, jack@suse.cz, axboe@kernel.dk, baohua@kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, qiwenjie@xiaomi.com
References: <cover.1788438786.git.qiwenjie@xiaomi.com>
 <c4e69fb1ffd6c6fd968683c690ba29f2b98c9fa8.1788438786.git.qiwenjie@xiaomi.com>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <c4e69fb1ffd6c6fd968683c690ba29f2b98c9fa8.1788438786.git.qiwenjie@xiaomi.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDIwOSBTYWx0ZWRfX672Q2TX+FBMM
 Jl4L3TukWFwQJePS4kmiaZs14LjFwaGdMV95Fo9SeV1Nwgw97d4PfVeZv9wL4IImL4R7O4zpXdq
 jFPtTnj0KTLxHOthay1g2qcdQ/yH2Juhxa+9Amd4IeKZOl36t4panJl18FdTmRUKriLAHeaSL8N
 5k7p1wRX1mPTC6r2GkHZB2s9sOfBlo8aTdjxS1xe3eEt089jIv1htacJ0b2ug1zzvFOzKvWn8q1
 3YR6CjSWBT4IPbOc3VWzzpDVTjtG89d/mxHsGDBYeYbPciB5WlqtBEo8kIoS42i4MCfHJ0zm5oz
 bMkIbhjYYuRfIYgKuAOTCCJMe3575dzCQKVelrFoClwhn5iACzj+/p9NDsnBAe3qIjydB85Ou6Z
 GcbbLy8Rc/Kfd7Q3Mk0gDZDLstU8sLVwSBx8gXwVhjGTCSj9q9ygbe7haWf9SHeUANTXPswtcRi
 OrwuPGqN6u/b99jzDsw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDIwOSBTYWx0ZWRfXxUtDHhKETA7W
 0t5ufsg7i3I90GdqVu0MbDVwJl8eLFSGNKyQJFgILBZNojQz8wYqDSmbHPsfCmSWEDJxCaUlSLN
 vSTPLKELEIP82noU353tHygJp5KOMfGo/vF7TS7BaoApRd6QTrkP
X-Authority-Analysis: v=2.4 cv=IPgyzAvG c=1 sm=1 tr=0 ts=6a9b479f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=tLges04aSNaZGVAfhBIy2A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=JR4YdQiviy7OQf72WyZ1:22
 a=IeNN-m2dAAAA:8 a=r4jUT_wghbJ-rGNBW1sA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: GO6xEzP02ebc5LKLnq_589jFXaZ9Kzhc
X-Proofpoint-GUID: GO6xEzP02ebc5LKLnq_589jFXaZ9Kzhc
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11896
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=10 adultscore=0 impostorscore=10 bulkscore=10 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040209

On 9/3/26 3:59 PM, Wenjie Qi wrote:
> Buffered RWF_DONTCACHE writes invalidate dropbehind folios at writeback
> completion. Mark these bios BIO_COMPLETE_IN_TASK so the block layer runs
> F2FS completion in task context when needed.
> 
> Use the same flag to keep normal and dropbehind folios from merging in the
> IPU and OPU paths. Classify the original page-cache folio rather than an
> encrypted or compressed replacement folio.
> 
> Keep the existing large-ATC completion path unchanged.
> 
> Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
> ---
>   fs/f2fs/data.c | 18 +++++++++++++++---
>   1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 21f396ebe22..b0fedacfd12 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -503,6 +503,8 @@ static struct bio *__bio_alloc(struct f2fs_io_info *fio, int npages)
>   	bio = bio_alloc_bioset(bdev, npages,
>   				fio->op | fio->op_flags | f2fs_io_flags(fio),
>   				GFP_NOIO, &f2fs_bioset);
> +	if (!is_read_io(fio->op) && folio_test_dropbehind(fio->folio))
> +		bio_set_flag(bio, BIO_COMPLETE_IN_TASK);
>   	bio->bi_iter.bi_sector = sector;
>   	if (is_read_io(fio->op)) {
>   		bio->bi_end_io = f2fs_read_end_io;
> @@ -793,6 +795,13 @@ static bool page_is_mergeable(struct f2fs_sb_info *sbi, struct bio *bio,
>   	return bio->bi_bdev == f2fs_target_device(sbi, cur_blkaddr, NULL);
>   }
>   
> +static bool f2fs_bio_dropbehind_mergeable(struct bio *bio,
> +					  struct f2fs_io_info *fio)
> +{
> +	return bio_flagged(bio, BIO_COMPLETE_IN_TASK) ==
> +		folio_test_dropbehind(fio->folio);
> +}
> +

So I'm admittedly not very familiar with f2fs, but why is it necessary
to prevent merging here? For iomap, we concluded that merging was fine,
as it just results in some extra folios getting resolved in task context
(see commit efbde6f9f449 ("iomap: use BIO_COMPLETE_IN_TASK for dropbehind
writeback")).

>   static bool io_type_is_mergeable(struct f2fs_bio_info *io,
>   						struct f2fs_io_info *fio)
>   {
> @@ -985,8 +994,10 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
>   
>   	trace_f2fs_submit_folio_bio(data_folio, fio);
>   
> -	if (bio && !page_is_mergeable(fio->sbi, bio, *fio->last_block,
> -						fio->new_blkaddr))
> +	if (bio &&
> +	    (!page_is_mergeable(fio->sbi, bio, *fio->last_block,
> +				fio->new_blkaddr) ||
> +	     !f2fs_bio_dropbehind_mergeable(bio, fio)))
>   		f2fs_submit_merged_ipu_write(fio->sbi, &bio, NULL);
>   alloc_new:
>   	if (!bio) {
> @@ -1086,7 +1097,8 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
>   	    (!io_is_mergeable(sbi, io->bio, io, fio, io->last_block_in_bio,
>   			      fio->new_blkaddr) ||
>   	     !f2fs_crypt_mergeable_bio(io->bio, fio_inode(fio),
> -				bio_folio->index, fio)))
> +				bio_folio->index, fio) ||
> +	     !f2fs_bio_dropbehind_mergeable(io->bio, fio)))
>   		__submit_merged_bio(io);
>   alloc_new:
>   	if (io->bio == NULL) {
> -- 
> 2.43.0
> 

