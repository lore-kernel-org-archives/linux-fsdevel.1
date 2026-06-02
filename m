Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272853EAC8D;
	Tue,  2 Jun 2026 13:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780408561; cv=none; b=U0pHIf12LmgT3VvnlIXUo1hu+yE5iIBGh+GMPy4tr6QMNM3xaLFQ7TaycJmLJPo6orVuefzXz22poWUZUBa/qTCZK9iafxfOFOpBH/F96Zg7adTTcFzYKpRrXa6pzR51uu2eXxXM8vQB4SWMYjpnDWzdR255+bRM30bGujcIvjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780408561; c=relaxed/simple;
	bh=9Zuf0S3qINRxsZ6picvUYggdISrGpZ5FaYCIie1NG+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Pzq1jjlXu9XA5s06WLqL9BjkJGkuk2YHw9rBazu+bKZQY7lhX2gZWoY0YuR2iG3VGgASNwqSEdjoMlY4bftjXGxzTgo6XftFUigDuUF2C6GuQo8/eY+E9V3y7s75ItJhMLA0layo8gUoNvvz/yJYziquF6y4hlnIuC/bY4/Ze4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=mq4TeBO0; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="mq4TeBO0"
Received: from relayfre-01.paragon-software.com (relayfre-01.paragon-software.com [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id AC1601D3F;
	Tue,  2 Jun 2026 13:55:59 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=mq4TeBO0;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 220451D26;
	Tue,  2 Jun 2026 13:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1780408554;
	bh=GzAODxi7wo8KE4dZhm3q3dnuf/GEZr3KGntbTuL4rIs=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=mq4TeBO06XZQjOHQd2UlowUxGfJphHQ9+E/qW/YwNfwCR7ITSRyZvGZjusvQp1uPE
	 r5Hpe4SBOoAqHflHGuY7sN3IuMofz+dHQQJ9E73+pxstegwVjl5CJxRJ6cs3601Uq9
	 w5WHkiY2tJf2fVGsHCmYu2VgsnmVKAj7JGZmKMKw=
Received: from [192.168.95.128] (172.30.20.149) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 2 Jun 2026 16:55:53 +0300
Message-ID: <77535f18-6224-4d2c-9aba-3bd9779ab84b@paragon-software.com>
Date: Tue, 2 Jun 2026 15:55:51 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/ntfs3: bound attr_off in UpdateResidentValue against
 data_off
To: Michael Bommarito <michael.bommarito@gmail.com>
CC: <ntfs3@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
References: <20260515163355.1574086-1-michael.bommarito@gmail.com>
Content-Language: en-US
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20260515163355.1574086-1-michael.bommarito@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

On 5/15/26 18:33, Michael Bommarito wrote:

> In do_action()'s UpdateResidentValue case (fslog.c:3307),
> lrh->attr_off and lrh->redo_len come from the on-disk LRH.
> When they satisfy aoff + dlen < attr->res.data_off, the
> assignment
>
> 	attr->res.data_size = cpu_to_le32(aoff + dlen - data_off);
>
> underflows to ~4 GiB (e.g. 0xFFFFFFF9 when aoff=0x10, dlen=1,
> data_off=0x18).  Subsequent code that reads attr->res.data_size
> to walk the resident attribute payload would then read up to
> 4 GiB past the 1024-byte MFT record allocation.
>
> The existing mi_enum_attr() defense in fs/ntfs3/record.c:287
> catches the corrupted data_size on the next attribute walk
> and fails the mount, but only on the path that walks all
> attributes.  A read site that picks an attribute by name and
> reads its data_size without re-validating is not covered.
> Validate aoff against data_off and asize at the source.
>
> Reproduced under UML+KASAN on mainline 8d90b09e6741 via
> pr_warn-only probe: with aoff=0x10 and data_off=0x18, the
> post-assignment data_size is 0xfffffff9 (mount then fails
> at -22 from mi_enum_attr).
>
> Fixes: b46acd6a6a62 ("fs/ntfs3: Add NTFS journal")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
>   fs/ntfs3/fslog.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
> index acfa18b84401e..4977ac1f62027 100644
> --- a/fs/ntfs3/fslog.c
> +++ b/fs/ntfs3/fslog.c
> @@ -3325,6 +3325,17 @@ static int do_action(struct ntfs_log *log, struct OPEN_ATTR_ENRTY *oe,
>   		nsize = ALIGN(nsize, 8);
>   		data_off = le16_to_cpu(attr->res.data_off);
>   
> +		/*
> +		 * aoff comes from the on-disk lrh->attr_off.  Forbid
> +		 * writes that begin below the resident attribute's
> +		 * data_off (which would overwrite the resident header),
> +		 * and forbid aoff + dlen < data_off, which would make
> +		 * the data_size assignment below underflow to ~4 GiB.
> +		 */
> +		if (aoff < data_off || aoff + dlen < data_off ||
> +		    aoff + dlen > asize)
> +			goto dirty_vol;
> +
>   		if (nsize < asize) {
>   			memmove(Add2Ptr(attr, aoff), data, dlen);
>   			data = NULL; // To skip below memmove().

Hello,

The patch was applied, thank you.

Regards,
Konstantin

