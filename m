Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F773E6DF4;
	Tue,  2 Jun 2026 13:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780408523; cv=none; b=K/3Ow3ASNCuSeerIXFPoD3jzPi6yFmkcytg+f+aEDkx1oVE2sdqS3uILw9xQJX4+/jg0DKV8KFADTG0dVCLOXQqlJMW5o14OGonVWXQ+427I8H0Fdd3M74pFSR1IdwjKC0y0k8kEm9AIODtZm6bStCSV+B/TjsQDhlxIy3gdiyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780408523; c=relaxed/simple;
	bh=JBW33VLNNUHO22MlRc2n9hGEVzLFPo9RgQ4xjOedF+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MxvnQMzVDXg7E+BtPRdhnvugJNni4n5/AmbXZuM8AkR7hHEWMHjpoxA67n9OGNgomT03Ix96xGgmIo16Dn5pYn+HDP69dXD+L0bd8ytpa+TXLBNQVjlkMupIprAJaVlYvbiYDtB2Gyy4hqi4tqGseNGAnA0czhNTZigr1vifl6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=Gz1BU+zB; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="Gz1BU+zB"
Received: from relayfre-01.paragon-software.com (relayfre-01.paragon-software.com [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id C2CAD1D3F;
	Tue,  2 Jun 2026 13:55:14 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=Gz1BU+zB;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 6E5DC1D26;
	Tue,  2 Jun 2026 13:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1780408513;
	bh=ONEesGv895cp4Nh3+IpbVLctN8Js888beNwJ245uVeA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Gz1BU+zBHV11z0hIzrywVLNlOXevAClLVyXQfWOym2gQXoDfR74TDiWEaMO+YnzLu
	 buUNEPNK5HLqFIHWmjWrP4z8a68xvlsdpR3FtdGmpHMEZ0FORT7fAbi1Zo5sruYmr6
	 kHdeRbJQz6sTolPW5rpwuHT8im6+T47eViMrDcQg=
Received: from [192.168.95.128] (172.30.20.149) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 2 Jun 2026 16:55:12 +0300
Message-ID: <a1e04b7d-70bc-4f40-89d9-24e2b75e5a08@paragon-software.com>
Date: Tue, 2 Jun 2026 15:55:10 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/ntfs3: bound DeleteIndexEntryAllocation memmove length
To: Michael Bommarito <michael.bommarito@gmail.com>
CC: <ntfs3@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
References: <20260515163333.1573210-1-michael.bommarito@gmail.com>
Content-Language: en-US
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20260515163333.1573210-1-michael.bommarito@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

On 5/15/26 18:33, Michael Bommarito wrote:

> In do_action()'s DeleteIndexEntryAllocation case, e->size comes
> from an on-disk INDEX_BUFFER entry.  When e->size makes
> e + e->size point past hdr + hdr->used,
> PtrOffset(e1, Add2Ptr(hdr, used)) returns a negative ptrdiff_t
> that is silently cast to a quasi-infinite size_t when passed
> to memmove().  The memmove then walks past the destination
> buffer.
>
> The sibling DeleteIndexEntryRoot case at fslog.c:3540-3543
> already carries the corresponding guard:
>
> 	if (PtrOffset(e1, Add2Ptr(hdr, used)) < esize ||
> 	    Add2Ptr(e, esize) > Add2Ptr(lrh, rec_len) ||
> 	    used + esize > le32_to_cpu(hdr->total)) {
> 		goto dirty_vol;
> 	}
>
> Apply the same shape to the allocation-path case.  Also reject
> esize == 0: memmove(e, e, ...) is a no-op and leaves
> hdr->used unchanged, hiding a malformed entry from the
> existing check_index_header() walk.
>
> Reproduced under UML+KASAN on mainline 8d90b09e6741 by
> mounting a crafted NTFS image: the unguarded memmove takes a
> length of 0xffffffffffffff00 and the kernel oopses in
> memmove+0x81/0x1a0 on the do_action+0x36a2 frame.
>
> Fixes: b46acd6a6a62 ("fs/ntfs3: Add NTFS journal")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
>   fs/ntfs3/fslog.c | 17 ++++++++++++++++-
>   1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
> index acfa18b84401e..4b32d08441b8d 100644
> --- a/fs/ntfs3/fslog.c
> +++ b/fs/ntfs3/fslog.c
> @@ -3570,9 +3570,24 @@ static int do_action(struct ntfs_log *log, struct OPEN_ATTR_ENRTY *oe,
>   		}
>   
>   		e1 = Add2Ptr(e, esize);
> -		nsize = esize;
>   		used = le32_to_cpu(hdr->used);
>   
> +		/*
> +		 * Reject crafted entries whose e->size makes e + esize
> +		 * point past the INDEX_HDR's used boundary.  Without this,
> +		 * PtrOffset(e1, hdr + used) underflows to a quasi-infinite
> +		 * size_t when fed to the memmove() below.
> +		 *
> +		 * Also reject esize == 0: memmove(e, e, ...) is a no-op and
> +		 * leaves hdr->used unchanged, masking the crafted entry.
> +		 */
> +		if (!esize ||
> +		    Add2Ptr(e, esize) > Add2Ptr(hdr, used) ||
> +		    PtrOffset(e1, Add2Ptr(hdr, used)) < esize)
> +			goto dirty_vol;
> +
> +		nsize = esize;
> +
>   		memmove(e, e1, PtrOffset(e1, Add2Ptr(hdr, used)));
>   
>   		hdr->used = cpu_to_le32(used - nsize);

Hello,

The patch was applied, thank you.

Regards,
Konstantin

