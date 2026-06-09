Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59555389106;
	Tue,  9 Jun 2026 07:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780991899; cv=none; b=W9jW1ZSZ6QbGXT/qrXv9Iy/8RMoaSFwdsJ13Hav9jHy+/9QNC6cYEogciexBFdVpU+sfOAnoEdUbgJZr3Dx/g4jWOlOS/uyiWnwqoOo5Ua5nxTfay9keWgO/V+n4K1ah1tqIC28MX2Naig/Ddk/wuRXRF03mqCRzglkcIGLTE98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780991899; c=relaxed/simple;
	bh=RDOcPn/xU2uPRQtL5VHOkXLvrUydkW8frKscEXMzVRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KOgN8jTAfidYNIoh94KXfShjfHwUtnLUY6yMYfJhouZ4q4s7tzhfBlrozsTnnuiILmFQdOv4lzb4h7kYxC4Mi8q2Z+kQrVgRP3GSS9pOSuePdx7rMwYsnZntuwDM/znS0QeJXXSvNUW40BdMN+7vzpZ+MSswlGNVysHq20dWlMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=rlPT9NW7; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="rlPT9NW7"
Received: from relayfre-01.paragon-software.com (relayfre-01.paragon-software.com [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 8656B1D47;
	Tue,  9 Jun 2026 07:58:16 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=rlPT9NW7;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 675281D11;
	Tue,  9 Jun 2026 07:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1780991892;
	bh=t/1lqggVdh0EtgxqEJPZrNDXyANk06hSIIRq/QhQmpk=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=rlPT9NW7ZdrIC1YDzz+x3z475bvkDcMSiYLQvtmc0mkcaF2x/V0IPF34ZuPMaVt/e
	 pJIMc8BVVTcr/Za2kxW4mvr3PudxvYK9P6t4enLS2DKEK7vKWV5tpcCzdAZMlM39ZD
	 zxjniuXKGEJ0J0VROMZ0ucUn6a9OAnwBiK5agLws=
Received: from [192.168.95.128] (172.30.20.172) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 9 Jun 2026 10:58:11 +0300
Message-ID: <09b96f47-bf57-4af3-b2b9-265dd5ab59a8@paragon-software.com>
Date: Tue, 9 Jun 2026 09:58:09 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ntfs3: cap RESTART_TABLE free-chain walker at rt->used
To: Michael Bommarito <michael.bommarito@gmail.com>
CC: <ntfs3@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260517234140.1261718-1-michael.bommarito@gmail.com>
Content-Language: en-US
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20260517234140.1261718-1-michael.bommarito@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

On 5/18/26 01:41, Michael Bommarito wrote:

> A crafted NTFS3 disk image triggers an in-kernel infinite loop at
> mount time, hanging the mounting thread and firing the soft-lockup
> watchdog within ~22s on multi-CPU hosts (panic with
> kernel.softlockup_panic=1).  The bug is reachable from desktop USB
> auto-mount on distributions where udisks2 routes the NTFS signature
> to the in-tree ntfs3 driver (Arch family and an increasing fraction
> of Fedora / openSUSE / RHEL deployments); CAP_SYS_ADMIN-class manual
> mount elsewhere.
>
> check_rstbl()'s second walker iterates the free-entry singly-linked
> list headed by rt->first_free with no upper bound on iteration count:
>
>    for (off = ff; off;) {
>        if (off == RESTART_ENTRY_ALLOCATED)
>            return false;
>        off = le32_to_cpu(*(__le32 *)Add2Ptr(rt, off));
>        if (off > ts - sizeof(__le32))
>            return false;
>    }
>
> The existing guards cover three exits: end-of-list (off == 0), the
> in-use marker (off == RESTART_ENTRY_ALLOCATED), and out-of-bounds
> (off > ts - sizeof(__le32)).  None of the three prevents an
> in-bounds cycle.
>
> A crafted on-disk RESTART_TABLE whose free chain contains a
> self-loop or A->B->A cycle whose offsets satisfy:
>
>    - in range [sizeof(struct RESTART_TABLE), ts - sizeof(__le32)]
>    - (off - sizeof(struct RESTART_TABLE)) % rsize == 0
>
> passes all existing guards and spins the mount-time thread forever.
> Reproduced in UML by hand-forging a 2 MB NTFS3 image whose journal
> RESTART_TABLE first_free = 0x18 and whose entry at offset 0x18
> stores 0x18 as its next pointer; mount of the forged image with
> the in-tree ntfs3 driver never returns.
>
> Bound the walker by rt->used.  Each entry on a legitimate free
> chain is unique, and the total slot count is ne = le16_to_cpu
> (rt->used).  A traversal that visits more than ne slots is by
> construction malformed; reject it as a corrupt RESTART_TABLE.
>
> After this patch, mount of the forged image returns with -EINVAL
> and a log_replay failure message, and mkntfs-produced legitimate
> images mount cleanly (verified in the same UML harness).
>
> Fixes: b46acd6a6a62 ("fs/ntfs3: Add NTFS journal")
> Cc: stable@vger.kernel.org
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> Assisted-by: Claude:claude-opus-4-7
> ---
>   fs/ntfs3/fslog.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
> index acfa18b84401e..d3d808d644dbf 100644
> --- a/fs/ntfs3/fslog.c
> +++ b/fs/ntfs3/fslog.c
> @@ -764,8 +764,19 @@ static bool check_rstbl(const struct RESTART_TABLE *rt, size_t bytes)
>   	/*
>   	 * Walk through the list headed by the first entry to make
>   	 * sure none of the entries are currently being used.
> +	 *
> +	 * Bound traversal by ne (rt->used) to defeat a crafted on-disk
> +	 * cycle in the free chain.  Each entry in a legitimate free
> +	 * list is unique, so a chain that visits more than ne slots
> +	 * is malformed.  Without this guard, an attacker-controlled
> +	 * RESTART_TABLE with a self-loop or A->B->A cycle whose
> +	 * offsets satisfy the existing alignment + in-bounds guards
> +	 * spins forever at mount time.
>   	 */
> -	for (off = ff; off;) {
> +	for (off = ff, i = 0; off; i++) {
> +		if (i > ne)
> +			return false;
> +
>   		if (off == RESTART_ENTRY_ALLOCATED)
>   			return false;
>   

Hello,

Your patch was applied, thank you.

Regards,
Konstantin

