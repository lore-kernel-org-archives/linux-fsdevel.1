Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794372856;
	b=NBBFYeYo9FYzN4H0nLkZzfCUjlRJxPsTJUz+2t7DGA+Q4XJgb2fd0me2LwltoZ2J9oGC
	 QlwPmsPeafr5tlGNqr0Zbamfwubu/zD77Z6vbsnQRcy8cGNUpgiXgf2hYOErtbWceooAC
	 T8k9gNdPtrRtXbu/xM3XJJOR8sEI+qbvIMK5crjTrnGdOe7M+TsKVzHj90bHV/Idd6qrw
	 EVMHJQScaNah/b9D5gq+nXjrKzRp7LkjMGmAANWNaLmMBXaZGVwyNRpOW3KaVvAlR+fTu
	 vlKvL49tUQ1hSfsvBF+7BS9NnkKLtR2k8Trchj8xknJe28SLz6Sdq//WQdi+oSO8zmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794372856;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=NtAaZR2KETUPEE3Is5MRv41jGaiQEz+irF5G1JKk/ec=;
	b=jMm/Avi1pHYr+lDwccClCykkoVFVjl+kQPj+aIglbIU+autvtu/DFeSHXRHg5WuGPB+H
	 uaNWmMYinWggi5uL2bWG13ghjbgqepb2ruugzg6kT4GlTdSMrkVtvjejDbH9Z+HX7eONX
	 Idvb9iNunx/qviSYIuEfgM7FSptAWWKPPkKjYEobY2k8uFZfPKT5DYUaq6TffPeCX7AIq
	 DOgtEF3rFT/xesPNRKbEfnkB0cehSewPzpvSDGGiTklHH84UXsatDkkTx99HplJhRuwwS
	 LphfwpLC0g2KreG/HPnrlRli99N82+i47G3aYUCapoQn+BzwsvltvltZ5c70ZUMiAOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=FeWaRpX0;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=DISGDdiB;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F37606A31C
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 04:54:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67F37606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=FeWaRpX0;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=DISGDdiB
Received: from pps.filterd (m0499198.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB4pNJK3717628
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2026 23:54:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=NtAa
	ZR2KETUPEE3Is5MRv41jGaiQEz+irF5G1JKk/ec=; b=FeWaRpX0JFJDqtJwU4br
	PaM4+1C15DtKoY/DjVy4KXDvPyfn+XruGroIDSNDyivz3zErdljr5btTtBNzLpTI
	ZxUlFjl8LhJZgbup0ow0vs76gL0HebhujdS8F9zVGr6xi7disWPs5Jw9Rr9jURaV
	64m7PBpFNjUk/wFc71DZ+QWMSjDLhz44ttgjmZRxdOi+gLJxclT8PQDbc3ScCSLT
	LRpAV/z6kaszEuHAItSZ5lEF/924KuNSvk0juChL9Fk3VNoe/h52JNdLMERXquTD
	3hq3X8b1GGpa73mmPxPNnZykEq8zWZRqCIe76YYzB+lREDhZdRyMIkppFg+lI3R9
	xQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4hvhns80cm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2026 23:54:14 -0500 (EST)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5338c59f90dso49488161cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2026 20:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794372854; x=1794977654; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NtAaZR2KETUPEE3Is5MRv41jGaiQEz+irF5G1JKk/ec=;
        b=DISGDdiBTDvk0g9jSxFKsDmx//N0DJfEMGsT8yNkyY2kVaOCCxVupFCbtYEgZtbVev
         7vuLCFCc1UhcuRlca/rUd82hoUJaBD5H4QA/Wc8rdU1Nd8rSWv+Y7ki86OJFUUU3EQp2
         gf90QI8/dZ1ruxeasE+248eh6R6inRnrKv25SyDmwO5kda6FU/vwPQVmzj718NOqHuh/
         f82g5OTelXhFzZ7zNUij1FA5HGH/00f6+w2PSyCiL2QXQhdkKFYHiVeGCL+WzBudNB8L
         4qmKuL46H07rI7WPwo6OhtSaoUuBYhi9G8I/CieSn68lPXAbYF9ImZeBh0XK0WWdS8eY
         EIAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794372854; x=1794977654;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NtAaZR2KETUPEE3Is5MRv41jGaiQEz+irF5G1JKk/ec=;
        b=fAK6yPc8F7vZPWAGSA5DkUjUpaiZui4NjPshWxslSxGJQqo3UP7gEk35gZokS0gOwD
         pAqNyAGfQ2bhF8edzj0kZDFgRG00BBA5ynla929SLjm7BeE+WpWi9aH5nJdNzHGOr+xX
         dK2pDa55OZ+r4KZl+GsTyjqgnr2Kv8gBYtbFWMwRuW2vZgz86HZnUAH4Fh7N6DRu+tMH
         L+DwawD3Udx0QT2YH2tJZAqpsnHNLrIFTAS/PY/ie7Hji799/VykfrTTxGMpEFAX4IHp
         V4QcvIjxbemDM9EXeRAIATNJlpo9A1/PYrYfZj3FKGC8fizuAM9wI3cSzNNSiBXfNLya
         oM+A==
X-Forwarded-Encrypted: i=1; AL+hErGFkCqD6gHnkH7vtf2lytxebrDXE9hEDKylL1IjpGQjZEuqv4L9T8PbmfqPS7UdjCrUPYiD506O0Y2Yrk1o@vger.kernel.org
X-Gm-Message-State: APuU4Z8JTA937Bu2e05K1jP31X9G8EeuhVY7CZyo0bqpMoS/0B/cq9KG
	dAvVj1lh1wqLmfQVcMEFMkKVj4Sdm75WogsMCtMT34GUiDY/pZMxP6qmgYcuFzBYrPiWycoHwio
	AFhkF7uEUFQus75S/yowNtcMTWJKcfDQ+AWPTrPqon52uzKsJo0dX1y1vPPy2KA0=
X-Gm-Gg: AYBFou0OWn0kEwWycoN6KzN8dK6GZiS8Ah+/RLJGNokDm+JGWFFDBExh0D+4cG8pIXA
	DKz0Js3e/UtmP/N6r06FNsSEsIow+gh/5N+uPd95FbUG3lwAQZQVXR6zJyUtTeo3G5yFDvv0Csp
	K62OXV2/1Xq3inF+v8AW/1PgVDKjv9KbG6Odpk//qzfHjg5FqhuPYsHkrxc8xy8djtR5PTCuQho
	q3svLlvzwwki2wF24Yh5napV7D3AL/rzmJFs2hPJEmYQVFn4xOdfWdkpHrxJc3P27QNHeLzjSni
	jR5jF06+joBoeuL1jokN0cTqLLQorpA11vrsvhYZn1IZCmzlJhX9EfDLMyNHHbHqncZ9YStS8JN
	8itMTUtJ7v3zpVXDlNTffHLUeRhHot4FVhwoBBL70NmnQ5MmLZwbMzDD7RPNr36BwnTWqAnvmP2
	mO95Y/hmcdG0xAqgJiIqYT6g==
X-Received: by 2002:a05:622a:506:b0:535:1d5b:a7fa with SMTP id d75a77b69052e-556c08d6ce1mr16074981cf.14.1794372853570;
        Tue, 10 Nov 2026 20:54:13 -0800 (PST)
X-Received: by 2002:a05:622a:506:b0:535:1d5b:a7fa with SMTP id d75a77b69052e-556c08d6ce1mr16074451cf.14.1794372852302;
        Tue, 10 Nov 2026 20:54:12 -0800 (PST)
Received: from [192.168.1.62] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5550af60493sm41888591cf.4.2026.11.10.20.54.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 20:54:11 -0800 (PST)
Message-ID: <a2ba8655-eaa0-40cd-ac3d-d768b18192c6@columbia.edu>
Date: Tue, 10 Nov 2026 23:54:10 -0500
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
Subject: Re: [PATCH v7 05/11] fs: validate atomic writes after O_APPEND and
 limits
To: Chris Mason <mason@kernel.org>, tytso@mit.edu, cem@kernel.org,
        david@fromorbit.com, jack@suse.cz, djwong@kernel.org,
        josef@toxicpanda.com, hch@lst.de, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        brauner@kernel.org
References: <20261110190417.32650-1-mason@kernel.org>
 <20261110190417.32650-7-mason@kernel.org>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <20261110190417.32650-7-mason@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=S9lMU4sP c=1 sm=1 tr=0 ts=6af3f4f6 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=BpGzv1V74M3SfeTrGa8v:22
 a=VwQbUJbxAAAA:8 a=mm-HGR4lrNp9vsEGGOYA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: -kBGvG6Y5ZzrhOeFtAzRs26GzgzsU_qI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAxOCBTYWx0ZWRfX4KzzXkHhjOoW
 FP3Ip557NPxAlMddpHcLXCQ0SnU/lKpsxaIg1u4HrASPS71YW3nv79ICv4VFd4xV6p0heVmMOYB
 PGYofHPr2Qs1IgBDInvzzB3Pr/Qc6NvAhudKJ0e17JUbLBjSFsSI7e4AQJjJ7Y0lB04pP+7D2ek
 25rkzZSxjve/LKr5WeEQJyAWYm7wgWwfYuFCBoWbVaeMmiUovItcIL2R7tpt6OGpcfQmApcGvBW
 YKvOZgyGKy3txVfrWUWyywWT4GwyE5SCyKcnSPq/8TS9HCVvjg4vVQHLa6kUFRDupAp0j1PN4I7
 kwmE2mSKYcEFLTAYgsEwoQL4CHsBxX+m5ltob1MB9lQnibEURT0iaxj1IpzWFlssTVum+7bzhJr
 2Lg1gYD/tVkly/yC7E5YyerY++7Fc2k7BELh5sKOkgSn0FpMtc42K1OhmUmzCShNe0edRPuYetk
 nz4jCN+wyAjMAEGQv2A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAxOCBTYWx0ZWRfX8/+d8/7aUsJQ
 VZNu+kPeNn56pyxVASMx5JRq00JLSZrX95Lgl1kYLSYF1kiNE423FnWyA1ILGSnVQwJoO7J8a0i
 P598oYE1UGYbRnh17fSEFUk4J2bDh6JUBxPNMbwf67qtTtYK50oQ
X-Proofpoint-ORIG-GUID: -kBGvG6Y5ZzrhOeFtAzRs26GzgzsU_qI
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11962
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=10 adultscore=0
 bulkscore=10 phishscore=0 malwarescore=0 impostorscore=10 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611110018

On 11/10/26 2:04 PM, Chris Mason wrote:
> An RWF_ATOMIC write on XFS with reflink can expose stale disk contents
> if O_APPEND or RLIMIT_FSIZE leaves it sector aligned but not block
> aligned.
> 
> XFS and ext4 call generic_atomic_write_valid() on the range that the
> caller passed. But generic_write_checks() changes the range later:
> O_APPEND moves the position, and RLIMIT_FSIZE cuts the length. XFS can
> then fill only a part of a new block, and still map the whole block into
> the file:
> 
>      block size 4096, i_size 512, O_APPEND
>      validated:        0 to 4095
>      written:          512 to 4607
>      new blocks:       0 to 8191
>      stale below EOF:  0 to 511
> 
> The fix used here is to validate an atomic write in
> generic_write_checks(), after its range is final, and to refuse one that
> was cut. XFS no longer picks the path of an atomic write by the
> alignment of the range that the caller passed.
> 
> Fixes: f096207d3276 ("xfs: Validate atomic writes")
> Fixes: 43c696f9d094 ("ext4: Check for atomic writes support in write iter")
> Signed-off-by: Chris Mason <mason@kernel.org>

Assuming my ext4 patches get picked up:

Reviewed-by: Tal Zussman <tz2294@columbia.edu>

> ---
> 
> Notes:
>      v6->v7:
>      - No change.
> 
>   fs/ext4/file.c    |  4 ----
>   fs/read_write.c   | 13 +++++++++++++
>   fs/xfs/xfs_file.c | 17 +++++++++++------
>   3 files changed, 24 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 50d3c92709c8..e301d4faf1c3 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -802,10 +802,6 @@ ext4_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>   		if (len < EXT4_SB(inode->i_sb)->s_awu_min ||
>   		    len > EXT4_SB(inode->i_sb)->s_awu_max)
>   			return -EINVAL;
> -
> -		ret = generic_atomic_write_valid(iocb, from);
> -		if (ret)
> -			return ret;
>   	}
>   
>   	if (iocb->ki_flags & IOCB_DIRECT)
> diff --git a/fs/read_write.c b/fs/read_write.c
> index 676728310899..1b34b7382619 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1775,6 +1775,19 @@ ssize_t generic_write_checks(struct kiocb *iocb, struct iov_iter *from)
>   	if (ret)
>   		return ret;
>   
> +	/*
> +	 * O_APPEND has moved the position and the file size limits have
> +	 * shortened the write by now, so this is the range to validate.  An
> +	 * atomic write is all or nothing, so refuse it if it got shorter.
> +	 */
> +	if (iocb->ki_flags & IOCB_ATOMIC) {
> +		if (count != iov_iter_count(from))
> +			return -EINVAL;
> +		ret = generic_atomic_write_valid(iocb, from);
> +		if (ret)
> +			return ret;
> +	}
> +
>   	iov_iter_truncate(from, count);
>   	return iov_iter_count(from);
>   }
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index be1f775128d1..153f53f964b9 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -926,12 +926,21 @@ xfs_file_dio_write(
>   	if ((iocb->ki_pos | count) & target->bt_logical_sectormask)
>   		return -EINVAL;
>   
> +	/*
> +	 * An atomic write is at least one block long, and generic_write_checks()
> +	 * refuses it unless its final position is a multiple of its length.  So
> +	 * there is no unaligned case to handle for it.
> +	 */
> +	if (iocb->ki_flags & IOCB_ATOMIC) {
> +		if (xfs_is_zoned_inode(ip))
> +			return xfs_file_dio_write_zoned(ip, iocb, from);
> +		return xfs_file_dio_write_atomic(ip, iocb, from);
> +	}
> +
>   	if ((iocb->ki_pos | count) & ip->i_mount->m_blockmask)
>   		return xfs_file_dio_write_unaligned(ip, iocb, from);
>   	if (xfs_is_zoned_inode(ip))
>   		return xfs_file_dio_write_zoned(ip, iocb, from);
> -	if (iocb->ki_flags & IOCB_ATOMIC)
> -		return xfs_file_dio_write_atomic(ip, iocb, from);
>   	return xfs_file_dio_write_aligned(ip, iocb, from,
>   			&xfs_direct_write_iomap_ops, &xfs_dio_write_ops, NULL);
>   }
> @@ -1128,10 +1137,6 @@ xfs_file_write_iter(
>   
>   		if (ocount > xfs_get_atomic_write_max(ip))
>   			return -EINVAL;
> -
> -		ret = generic_atomic_write_valid(iocb, from);
> -		if (ret)
> -			return ret;
>   	}
>   
>   	if (IS_DAX(inode))
> -- 
> 2.55.0
> 

