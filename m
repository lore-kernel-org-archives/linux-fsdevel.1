Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5983B14C9;
	Wed,  7 Oct 2026 21:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791408879; cv=none; b=HT1egc6Qd/7FEGvPJ3vqPwrE5nGjzk00IcKyVoCXZdRjpb229u2h6BdM6Cg9TmxPn+LnLfuMIcHAtNaROH1w9JatmPHWGwEJVRlRPH5YIRKN5k3jui2NWWiUNyBR5fq6ctyWfv+nCDjX+Hb7jYDG6JNJEG6R5csPzNq2Vyu4nss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791408879; c=relaxed/simple;
	bh=4yBSJJszorsqsinK0VDsbss1s/GSDZc7dNtTQNUBfp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=b3uQbTVimcRZV3kt6Q5oa+/tqM3Q7y8DfgY6LIljXlbNePlfLmtxkQxaqXOgvMNkmbXPBgVznewQPnlLXweNSKTgU4nLLjzEFKtX4UXlEVGuxT+W+G2iMLA7wVGJCJNtr5Ep2h9+xbsh8s6oh5K5Ti6OnPwY/XdyvGeXc046xQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=WhHlZgX8; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="WhHlZgX8"
Received: from relayfre-01.paragon-software.com (relayfre-01.paragon-software.com [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 3BAD61D60;
	Wed,  7 Oct 2026 21:35:27 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=WhHlZgX8;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 95AD321D8;
	Wed,  7 Oct 2026 21:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1791408875;
	bh=3ax5YoLjUmErqO3if/gSysdbbVp273Gay8qujDIizcY=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=WhHlZgX8QGYCiYUrWwuO7dZV2mheyZ5ls39vw1SFT7WsXv7PRrc+DexGgfhs50auk
	 nbtQuG5HoYl5OyUKy6jD1W8PGbZDH+tcfPBy67K4lN8BAWZ+szZls2cRmbCMnQYmqR
	 MgJ4FyXZRAtkZ8BOybpTwvDySm0E+1JnqMbAMCDc=
Received: from [192.168.95.128] (172.30.20.178) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 8 Oct 2026 00:34:34 +0300
Message-ID: <0364b9ec-f3bc-4a91-9f73-81d61be90895@paragon-software.com>
Date: Wed, 7 Oct 2026 23:34:33 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/ntfs3: do not mark frame pages uptodate on read error
To: Weiming Shi <bestswngs@gmail.com>
CC: <ntfs3@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Xiang Mei <xmei5@asu.edu>
References: <20260712133427.435377-2-bestswngs@gmail.com>
Content-Language: en-US
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20260712133427.435377-2-bestswngs@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

On 7/12/26 15:34, Weiming Shi wrote:

> ni_read_frame() ends with a loop that marks every page of a compressed
> frame uptodate regardless of whether the read succeeded:
>
> 	out:
> 		for (i = 0; i < pages_per_frame; i++) {
> 			pg = pages[i];
> 			SetPageUptodate(pg);
> 		}
>
> Non-critical frame pages come from __filemap_get_folio(FGP_CREAT) and are
> not zeroed. On an error path that reaches out: before frame_mem is
> written, these pages keep uninitialized page-allocator contents but are
> still marked uptodate. A later read() is then served from the page cache
> and returns that stale kernel memory to user space.
>
> For an unprivileged user mounting a crafted NTFS image this is a
> repeatable kernel memory disclosure.
>
> Mark the pages uptodate only on success; on error leave them !uptodate so
> the read path re-reads them or reports the error.
>
> Fixes: 4342306f0f0d ("fs/ntfs3: Add file operations and implementation")
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
>   fs/ntfs3/frecord.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
> index 2d2644d80017..862baafb80e3 100644
> --- a/fs/ntfs3/frecord.c
> +++ b/fs/ntfs3/frecord.c
> @@ -2467,7 +2467,8 @@ int ni_read_frame(struct ntfs_inode *ni, u64 frame_vbo, struct page **pages,
>   out:
>   	for (i = 0; i < pages_per_frame; i++) {
>   		pg = pages[i];
> -		SetPageUptodate(pg);
> +		if (!err)
> +			SetPageUptodate(pg);
>   	}
>   
>   	return err;

Hello,

Your patch was applied, thank you.

Regards,
Konstantin

