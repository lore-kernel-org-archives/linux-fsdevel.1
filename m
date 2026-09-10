Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9103C1F41
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 08:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789027743; cv=none; b=V/Q5T/6ElEWulEZhvca4S/fVtvda+Q0XPSIJ1pHgU8Ke+9mrzHjtLs8cHLm8aF5DeFAZv2OsOFlcMhD/wx8vQhApDg1z7VAK2GEQiyqgGE95IiTAOiS0piIEucwAXng0DlnT8zPkbbiaaPHQ1lKj2cxZK7pFxlUCFFXEkzOWSus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789027743; c=relaxed/simple;
	bh=sZG2eexUBDvxgaq6ysoGTc36spnht+MNulg2i1alcXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rKkiumgttTPWyluZ24Wz2RbQYWIxym872L1apNugroSr7R2Fa9m1hg6fvEEz1yzV25TFFcgpi3U/jHoUMEEV6VPPVR/47QJf7ZTyV28M3UV1OrMXb0JoYjC+0iql3csXXqyDSFcFjaXMz2qwyFbnogcxBcOWBUl6F+LiyYDso0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pPiRgpa+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UFjQ5zIi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pPiRgpa+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UFjQ5zIi"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68A5GpCl3655280
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 08:09:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	P7BTTddhf4N5PrxHybbjlwH7viQ1O+pT1zz2AMFb7tw=; b=pPiRgpa+i0kXlw4m
	fqepclc9pletqlBQvxnlcD3vbXxI7ffdS3JSAZ6LpjwntoyNwWtXmEKxEQjxoxKU
	i20i/xkYq+Qbakow9oTJDl44ledqUtNTXWv5ptACP/Owae0VzEI/2LWcDzrlQ+z8
	Qi2lygGNGUGeHjBcEtx4ceEaPzvtRmWlqiB3fYBhcbirDV2hBWcVjvFdnGlWkFyx
	06jgq3AIN2EOUIvox3B40s0qrSTx5K+RUgg0OmNad4cAqA5D97+upvOD5bxaPJTH
	wftptOlTkGJJIl1i9KCxulqNDdbgsnWcdfzGH3aFk8upu0uiTXqwd0SEFfCw45yA
	fJjunQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkcydtsc9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 08:09:00 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-9392788b3f8so132183785a.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 01:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789027740; x=1789632540; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P7BTTddhf4N5PrxHybbjlwH7viQ1O+pT1zz2AMFb7tw=;
        b=UFjQ5zIiTxL2Hhr3U9xhbMULcTapKWRVYybuHlT2X0v0jCvZxI0vwM1uorHFX/gOwj
         xmx8gmErQc2DCycx8KyWcKWC24eH+14A4SWzYAY9m2zcIJCRtzxlC1UCSSaf+vUkR5fT
         n898IhLQ54zAPXhiOq2RSU0aYZKlwmBJiOcUUz3ccJWIC4z4+s+eZQfediDuZEOhmiLw
         F4QCHU565iSXfMOUSdfs3kkWsycmZQj/JLto8X8iPp2Y2F+Fj45+1OY+4yjLMWY649ii
         7EzigQE7uqODhSzTOdmJe9B03/HKgwsn4YPoS0qp+ZosWyA3tDv1P7UiuQASGe05tJYy
         wFfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789027740; x=1789632540;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P7BTTddhf4N5PrxHybbjlwH7viQ1O+pT1zz2AMFb7tw=;
        b=A/gve7UREx6u7vFqvNcpl66rrFR2tgpYg7w8yMyn+FN2H+JqOKueA/TIdlq/Is9IWY
         ZAClc2k5JwXKDVZ5Iu+GIFpAwy9LBmsiC1gavypFD7bKDg2R1umZq1hEmLzERD+ZzQ5V
         LX/H/9p4zCpjchwRgcTqu0YDgKIdl/82aYpE1k5KiZdcZi+o+xUEd8HaSajnC3aznlMC
         rh9PMDQHZ+fY4yd1+vLRf4XhimQ+lk4j5iyqY0zBrgmS4g6Og1oQllxDYbxQEXe+lHUB
         pGoNMlm4rEi9D41+xcCVcvK8Z2CjIZCo9+XhFuEcH7h7pLi+ntj22zUeV7wGeeMoGHvc
         Feog==
X-Gm-Message-State: AFuF++lvkrFpghFEG/0s8a5yVSIS6i0Lr8rILAxkWWra6FHORM7bwLE6
	oWS8KAg0EBcW5HoDxMGMRyyf6y4Q6Oy9eQbQk5vBe0L5MHBHh2TLFQa8fXmsFCtZkynDpK1/bbQ
	J/TYKKItB0H71cmSw9mZeB3aWpMY7nqIJ/TXQKev1YlN+xAn+8IXXihVlZ2vSkOm6sKxj
X-Gm-Gg: AYBFou3ZPsE7gFnuqv/esUQautpBn7Luq1Mdj9jbZVswrRWRM8Xe3PAMgszX7LSorkg
	xBshHS6YVMrp5Cs3KXqGIbP954qT8SyUt1wy0REAh4b0wE7uAxDmsBxSIpQUg+3GCtNKcfbBm7j
	v6VZ6du0wXHOm2XY5l/j77kKbTAgfbaIy1E3jsrxfvNw3EeiM5FkRNo+9oxnhZLIAl6z89rWK5F
	yA8M8x1UBV6tSTyk8IXQGtrKyvSJpQhJK9HoBn1LxxRgwSOaMB2K6Wit3+LwIeZ5sEwwNqqPICA
	pC6o9+GqoBb+16FHWUITd/OA5ueBiD7TvXCvzdfJYD7VKq5dc/27WLfWuxgP1Xz72OApgenkEf3
	6jP5sc1Rh1UZCrUGAtXcQtg==
X-Received: by 2002:a05:620a:4409:b0:939:8bc:8826 with SMTP id af79cd13be357-93991702d25mr3092766185a.2.1789027739697;
        Thu, 10 Sep 2026 01:08:59 -0700 (PDT)
X-Received: by 2002:a05:620a:4409:b0:939:8bc:8826 with SMTP id af79cd13be357-93991702d25mr3092763385a.2.1789027739269;
        Thu, 10 Sep 2026 01:08:59 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a993d6611asm1966906a12.25.2026.09.10.01.08.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 01:08:58 -0700 (PDT)
Message-ID: <e77d4410-e7fa-4885-9d9f-6dd09fb7cebb@oss.qualcomm.com>
Date: Thu, 10 Sep 2026 10:08:55 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] buffer: fix NULL dereference of bh->b_folio in
 __bh_submit()
To: Joseph Qi <joseph.qi@linux.alibaba.com>,
        Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
        Srikanth Aithal <Srikanth.Aithal@amd.com>,
        Luca Weiss <luca.weiss@fairphone.com>, Jan Kara <jack@suse.cz>
References: <20260902013357.2815214-1-joseph.qi@linux.alibaba.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260902013357.2815214-1-joseph.qi@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=IfsSymqa c=1 sm=1 tr=0 ts=6aa2659c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=zd2uoN0lAAAA:8 a=6H0WHjuAAAAA:8 a=SRrdq9N9AAAA:8 a=EUspDBNiAAAA:8
 a=xELAsZIkk1thdxp-Qi8A:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-GUID: 39ff7OonuraRvpzjcDMELHF0qjF0Z9kl
X-Proofpoint-ORIG-GUID: 39ff7OonuraRvpzjcDMELHF0qjF0Z9kl
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDA4OSBTYWx0ZWRfX9XOkswsLBvAo
 cA61y7C2l3NQZnyVLpk6JxZy8Bfk1FYuHqjroSD06mFawqwI0q0ek9NnZqgkIQQh11PKkRbxOEr
 4SVx7sD5h6mvcvNQmYGPYJC97TUc4q0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDA4OSBTYWx0ZWRfX3dgBSNlqGQXi
 WF29UZ65Dvot0PAHtVOxnexb9a3bEOs87437BJ16XZbdUO/p4eZ+1Utm4+1PbWTRG3qN0n41DxS
 x9CXDaqorK+0sWjqnfxc8XFAVXa3QEKPw5VH0a7QIH/4S3GvO9bRsLEuOy3WlH+sCm5bi6mFksT
 UF69SyxJnShnv6FLt2AwKW5hnpgu3VZ6lf/PvOMgpXMz2/CG1bnEPeN+C8ENIzIpcJ5utGX5Adt
 LeH92M7E/ERSy5MyuqFBTi47rywT2SjdeQJnlYZqdTbJaVJQ8vsc66ulGO6pcfdByYtVVNh8vzU
 MBKk4Mkyp8dk7X2NUZpkjswMNF9X8EhbBUxRvbFTI8QPzcUTPPXrs/xWQgMH6yszFW5x81jpC+3
 qYs8IU7sDvTH8s4i61x1Vg/c4iZYZRoAp0avAEOI2nJCPfdxFM6LyRvcvn2dKMYkITjp8LWFiuF
 kxzOXvJoFyK3tbZbj5Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_02,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 spamscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609100089

On 9/2/26 3:33 AM, Joseph Qi wrote:
> Commit a2c924c240e7 ("buffer: set BIO_COMPLETE_IN_TASK for dropbehind
> writeback") added an unconditional folio_test_dropbehind(bh->b_folio) in
> __bh_submit().  But jbd2 shadow buffers have a NULL b_folio since commit
> 5febcba29792 ("jbd2: point the shadow buffer at the frozen data
> directly") made them point b_data at the kmalloced frozen data rather
> than a folio.  Submitting such a buffer during journal commit oopses:
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>   RIP: 0010:__bh_submit.constprop.0+0x87/0x120
>   Call Trace:
>    jbd2_journal_commit_transaction+0x932/0x1b10
>    kjournald2+0xb2/0x250
> 
> Hit by the ocfs2-testsuite fill_verify_holes test running with
> data=writeback.
> 
> Dropbehind only applies to buffers backed by a folio, so skip the check
> when b_folio is NULL.
> 
> Fixes: 5febcba29792 ("jbd2: point the shadow buffer at the frozen data directly")
> Tested-by: Srikanth Aithal <Srikanth.Aithal@amd.com>
> Tested-by: Luca Weiss <luca.weiss@fairphone.com> # sm7225-fairphone-fp4
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>  fs/buffer.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 427d8a817cd5..f46fa6413032 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -1106,7 +1106,8 @@ static void __bh_submit(struct buffer_head *bh, blk_opf_t opf,
>  
>  	bio = bio_alloc(bh->b_bdev, 1, opf, GFP_NOIO);
>  
> -	if (folio_test_dropbehind(bh->b_folio) && op_is_write(opf))
> +	if (bh->b_folio && folio_test_dropbehind(bh->b_folio) &&
> +	    op_is_write(opf))
>  		bio_set_flag(bio, BIO_COMPLETE_IN_TASK);


-next has been broken for a week+ already, please pick this up..

Tested-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com> # multiple QC boards

Konrad
