Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E20D2EAB72;
	Tue,  9 Jun 2026 07:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780991864; cv=none; b=YOMbm9UvWKAj59ZMlVvuktOJ3AQC0IsfLPRonUutUO+tS/Q6SBhNhkytHwH2IG5RHz8Ui87/0A8RN/QH2yDtV0MjyivNZG6TeMP1Dgd3USquoXhtYEwQkGQp9qQVVrzyyG0UOfoC4OfcGMcKvu5cSMJKlSMeGq5MyXb5NSDx5SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780991864; c=relaxed/simple;
	bh=hCWhHEhW4r+C3VDTQUYPF5CSAxWluVmdk6lvM6lw1Aw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=F/L1m2U3YZc4kbx7iTePV+mKCGSX0M4cpSPB590TBievCMsdDJeZBEKZHhdLQGoPb1P1zQqz2Nqa06yjg+wiuynhs/vQC/mVoLZAMiM7i51XAEQZqaDNeOecxCCt28ZaEb4EqpZ2zPjgVT3ZC34uiPh/TE+XMGcW7D5lgYmmVf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=rd8uKlHI; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="rd8uKlHI"
Received: from relayfre-01.paragon-software.com (relayfre-01.paragon-software.com [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 72DF71D47;
	Tue,  9 Jun 2026 07:57:35 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=rd8uKlHI;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 653901D11;
	Tue,  9 Jun 2026 07:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1780991851;
	bh=kf6T+sn805TIIm7DZAp4ubwU3+nDlTwzyy33aVFt690=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=rd8uKlHIMT42M4BQO7pp//GHSZ9O2umeyLWPtbYz8sC2wid86lKcc6H68MBzENbgR
	 2pCkWFuYE5HWQvNbHiBv25nSctmg/NTl3U87bybT/1v4iLwZdFQSnGs5LvIvPTpuQ/
	 fgbLjDK7TV49WBZXDcf7j3T9aNoDkGQVjYGV61+Y=
Received: from [192.168.95.128] (172.30.20.172) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 9 Jun 2026 10:57:30 +0300
Message-ID: <189e7066-3d41-4629-8e9a-deea011047eb@paragon-software.com>
Date: Tue, 9 Jun 2026 09:57:28 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fs/ntfs3: bound NTFS_DE view.data_off in
 UpdateRecordData{Root,Allocation}
To: Michael Bommarito <michael.bommarito@gmail.com>
CC: <ntfs3@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Pavitra Jha <jhapavitra98@gmail.com>
References: <20260515163424.1575298-1-michael.bommarito@gmail.com>
 <20260519095135.1609973-1-michael.bommarito@gmail.com>
Content-Language: en-US
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20260519095135.1609973-1-michael.bommarito@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

On 5/19/26 11:51, Michael Bommarito wrote:

> In do_action()'s UpdateRecordDataRoot (fslog.c:3489) and
> UpdateRecordDataAllocation (fslog.c:3697) cases, the memmove
> destination is `Add2Ptr(e, le16_to_cpu(e->view.data_off))`,
> where e->view.data_off comes from an on-disk NTFS_DE inside
> an INDEX_ROOT or INDEX_BUFFER.  Neither case validates
> view.data_off + dlen against e->size; the existing
> check_if_index_root / check_if_alloc_index helpers walk the
> entry chain and validate the entry's offset, but not its
> internal view fields.
>
> The neighbouring read sites (e.g., fs/ntfs3/index.c when
> iterating view entries) check view.data_off + view.data_size
> <= e->size.  Apply the same bound at the two memmove sites.
>
> Reproduced under UML+KASAN on mainline 8d90b09e6741 via
> pr_warn-only probe instrumentation: with view.data_off forced
> to 0xFFFC, the memmove writes 32 bytes past the end of the
> NTFS_DE.
>
> This is similar in shape to Pavitra Jha's 2026-05-02 patch
> "fs/ntfs3: prevent oob in case UpdateRecordDataRoot"
> (<20260502105008.21827-1-jhapavitra98@gmail.com>) which
> proposes calling ntfs3_bad_de_range(); that helper does not
> exist in mainline.  This patch uses inline checks.
>
> Fixes: b46acd6a6a62 ("fs/ntfs3: Add NTFS journal")
> Cc: stable@vger.kernel.org
> Reported-by: Pavitra Jha <jhapavitra98@gmail.com>
> Closes: https://lore.kernel.org/ntfs3/20260502105008.21827-1-jhapavitra98@gmail.com/
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
> v2:
>    - Add Pavitra Jha's Reported-by trailer and a Closes tag for
>      the original public report, as requested in review.
>
>   fs/ntfs3/fslog.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
>
> diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
> index acfa18b84401e..127860fd2ab50 100644
> --- a/fs/ntfs3/fslog.c
> +++ b/fs/ntfs3/fslog.c
> @@ -3497,6 +3497,18 @@ static int do_action(struct ntfs_log *log, struct OPEN_ATTR_ENRTY *oe,
>   
>   		e = Add2Ptr(attr, le16_to_cpu(lrh->attr_off));
>   
> +		/*
> +		 * e->view.data_off and dlen come from the on-disk
> +		 * INDEX_ROOT entry / LRH.  The neighbouring read sites
> +		 * (e.g. fs/ntfs3/index.c) check that
> +		 * view.data_off + view.data_size <= e->size; mirror that
> +		 * bound here so the memmove cannot reach past the entry.
> +		 */
> +		if (le16_to_cpu(e->view.data_off) > le16_to_cpu(e->size) ||
> +		    le16_to_cpu(e->view.data_off) + dlen >
> +			    le16_to_cpu(e->size))
> +			goto dirty_vol;
> +
>   		memmove(Add2Ptr(e, le16_to_cpu(e->view.data_off)), data, dlen);
>   
>   		mi->dirty = true;
> @@ -3689,6 +3701,12 @@ static int do_action(struct ntfs_log *log, struct OPEN_ATTR_ENRTY *oe,
>   			goto dirty_vol;
>   		}
>   
> +		/* See UpdateRecordDataRoot for the rationale. */
> +		if (le16_to_cpu(e->view.data_off) > le16_to_cpu(e->size) ||
> +		    le16_to_cpu(e->view.data_off) + dlen >
> +			    le16_to_cpu(e->size))
> +			goto dirty_vol;
> +
>   		memmove(Add2Ptr(e, le16_to_cpu(e->view.data_off)), data, dlen);
>   
>   		a_dirty = true;

Hello,

Your patch was applied, thank you.

Regards,
Konstantin

