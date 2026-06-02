Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7513E8C46;
	Tue,  2 Jun 2026 13:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780408712; cv=none; b=u1uGtmz/Xtwb18Vu2GX1zwqiBwzZaTrpPTkxAw2ok01QTjpD5MVNvtCrq2qUyuegzMc2sSDXDOWC0mY1j4eKTHrRYrSUA0KIAc2HBVE5ovcQe63hcOHnzzXExvM6UeSI5dpeREsit2LosSJmfpRIB2/EL1t8+RkFnS9/8JLhuRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780408712; c=relaxed/simple;
	bh=SzC3tKjWvKmMFKMh/jPLS+NMwhPY0yFm8Bttt5hTgTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZYmmB969bTQDRDHmL3wmxghxvOcIQiJmi14vYAEiPryt/9N3b4J2rVaP08C0EMbL6/6fc3d8/a0bnkXp3vyXCq+YNS5t0RBS6lSmVsMWIuRbT4/N0SsVJIop4KRwCiolO9c0KGh3dvHi6yk79PIH8OLqeMUqRUqc/IxbLMplfjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=CHKIzYcG; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="CHKIzYcG"
Received: from relayfre-01.paragon-software.com (relayfre-01.paragon-software.com [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 9C4321D3F;
	Tue,  2 Jun 2026 13:58:29 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=CHKIzYcG;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 28EDD1D26;
	Tue,  2 Jun 2026 13:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1780408708;
	bh=qhFgvX4tZJecHCNLh4j/LKFvSKwNsLowxgYgr4s9BnE=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=CHKIzYcGIQ4XqjvWnkgnanUcJeO/qzRueXpEQchaAoXH7Y9M67Y+r5+8WEiFwgEDv
	 xZKOlnBC+2TaUI8hlAzNTbWvrhFiGQf0Zca96yqJfypnNlEZd/K2AAmnqO1vCpoZXX
	 Tl6qro2ovdNJkdZxoQ9Ld5KvWGXzEh6BZbGHGv4U=
Received: from [192.168.95.128] (172.30.20.149) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 2 Jun 2026 16:58:27 +0300
Message-ID: <f94854ba-c98a-47d7-9c33-9b1d395f3f2b@paragon-software.com>
Date: Tue, 2 Jun 2026 15:58:25 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/ntfs3: bound copy_lcns dp->page_lcns[] index in
 analysis pass
To: Michael Bommarito <michael.bommarito@gmail.com>
CC: <ntfs3@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
References: <20260515163405.1574574-1-michael.bommarito@gmail.com>
Content-Language: en-US
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20260515163405.1574574-1-michael.bommarito@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

On 5/15/26 18:34, Michael Bommarito wrote:

> In log_replay()'s analysis pass, after find_dp() returns a
> valid DIR_PAGE_ENTRY for the (target_attr, target_vcn) tuple,
> the copy_lcns block walks lrh->lcns_follow further entries:
>
> 	t16 = le16_to_cpu(lrh->lcns_follow);
> 	for (i = 0; i < t16; i++) {
> 	    size_t j = (size_t)(le64_to_cpu(lrh->target_vcn) -
> 	                        le64_to_cpu(dp->vcn));
> 	    dp->page_lcns[j + i] = lrh->page_lcns[i];
> 	}
>
> find_dp() only validates that target_vcn falls within
> [dp->vcn, dp->vcn + dp->lcns_follow), i.e., that the FIRST
> cluster is covered.  The walk through the further entries is
> not bounded against dp->lcns_follow.  For a malformed LRH
> where target_vcn = dp->vcn + dp->lcns_follow - 1 and
> lrh->lcns_follow > 1, the i > 0 writes overflow the dp's
> allocated page_lcns[] array.
>
> Add the missing j + lrh->lcns_follow <= dp->lcns_follow guard.
>
> Reproduced under UML+KASAN on mainline 8d90b09e6741 as a
> slab-out-of-bounds write of size 8 from log_replay+0x68d4 on
> the mount path.
>
> This is distinct from Pavitra Jha's 2026-05-02 patch
> ("fs/ntfs3: validate lcns_follow in log_replay conversion",
> <20260502154252.164586-1-jhapavitra98@gmail.com>) which
> addresses the separate version-0 dirty-page-table conversion
> path's memmove(&dp->vcn, ...) call.  The two fixes are
> complementary; both should land.
>
> Fixes: b46acd6a6a62 ("fs/ntfs3: Add NTFS journal")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
>   fs/ntfs3/fslog.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>
> diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
> index acfa18b84401e..f409611f2530d 100644
> --- a/fs/ntfs3/fslog.c
> +++ b/fs/ntfs3/fslog.c
> @@ -4547,6 +4547,19 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
>   		 * whole routine a loop, case Lcns do not fit below.
>   		 */
>   		t16 = le16_to_cpu(lrh->lcns_follow);
> +		/*
> +		 * find_dp() only validates that target_vcn is the first
> +		 * cluster covered by dp.  The walk through lrh->lcns_follow
> +		 * further entries must stay within the allocated
> +		 * dp->page_lcns[] array, which is sized by dp->lcns_follow.
> +		 */
> +		if (le64_to_cpu(lrh->target_vcn) - le64_to_cpu(dp->vcn) + t16 >
> +		    le32_to_cpu(dp->lcns_follow)) {
> +			err = -EINVAL;
> +			log->set_dirty = true;
> +			goto out;
> +		}
> +
>   		for (i = 0; i < t16; i++) {
>   			size_t j = (size_t)(le64_to_cpu(lrh->target_vcn) -
>   					    le64_to_cpu(dp->vcn));

Hello,

There was a conflict in patch apply, fixed it. Thanks for the patch.

Regards,
Konstantin

