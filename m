Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B32C3FF883;
	Tue, 13 Oct 2026 13:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791899516; cv=none; b=OihC8gHhqhXrN/rgD7ITpNp/jNQsReYXrq5Moc/nDq61VkIMactmolpAxq59r8LNkH61tJnKChkWZhc8+NHJH7o6/xiuhiNknZp1XvXFkA0Z+skXtaTeRIJ88m3zLF0U/WJi9+qtf/5YluifFYp1ZY8txwD6AKV82PuslK60gpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791899516; c=relaxed/simple;
	bh=bahVI3Ax/ZyEicmhpxPli+bgLsjnIUHODRWel3iO2tQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=elyTBcl2IZjGqJagyTJRC3ouV3T9RQoqh3ILOB0leFWs7PkfBohdVwsMgwbdvM77TNbVHPTWFwbOSIq++ksssqlqqCHjYKJVivuz9Uuz+nk27WGsl1AxIM4OJMVA2KLbklL5ldgFCg81nu+d12Fo6lilqPTzO5wI1jR0xSsEQQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=AboGi5wF; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="AboGi5wF"
Received: from relayfre-01.paragon-software.com (relayfre-01.paragon-software.com [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 966291D47;
	Tue, 13 Oct 2026 13:52:43 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=AboGi5wF;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 1ACCE215F;
	Tue, 13 Oct 2026 13:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1791899513;
	bh=PmHM9vt9eDeZXXVo1fBMSVboaBjLr0ljMeJYoQzV7Gk=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=AboGi5wFFB3NcSoRaLtOgXo2nxTneWVWqU3IjX1wb/lTRnLJixG2MGBhC8A/wqr5O
	 6pZd5B6polbJ+vM+Tmb4ARhZaJSur83CfOj0xRmu80bp1MzUDL5ts9Bs2fZim1432P
	 c+yXOJgCa2OpCqF6QZS6mP16dPrqUlp6hZw17pHU=
Received: from [192.168.95.128] (172.30.20.169) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 13 Oct 2026 16:51:51 +0300
Message-ID: <0ceff955-1b44-4162-b9b8-868af1b10b93@paragon-software.com>
Date: Tue, 13 Oct 2026 15:51:49 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] fs/ntfs3: prevent positive E_NTFS_NONRESIDENT from
 reaching writeback error handling
To: Vidhu Sarwal <vidhu.linux@gmail.com>
CC: <ntfs3@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <skhan@linuxfoundation.org>,
	<linux-kernel-mentees@lists.linux.dev>,
	<syzbot+57f9327d593d301ce2a2@syzkaller.appspotmail.com>
References: <20260713084140.249515-1-vidhu.linux@gmail.com>
Content-Language: en-US
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20260713084140.249515-1-vidhu.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

On 7/13/26 10:41, Vidhu Sarwal wrote:

> attr_data_write_resident() returns the internal positive status code
> E_NTFS_NONRESIDENT when the DATA attribute becomes non-resident.
> ntfs_writepages() propagates this value into generic writeback error
> handling, which expects a standard negative errno and triggers
> WARN_ON_ONCE(err > 0).
>
> Translate positive E_NTFS_* status codes to -EIO before recording
> the writeback error. This prevents positive internal status codes from
> reaching generic writeback code while preserving the existing behaviour
> of treating this path as a writeback error.
>
> Reported-by: syzbot+57f9327d593d301ce2a2@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=57f9327d593d301ce2a2
> Signed-off-by: Vidhu Sarwal <vidhu.linux@gmail.com>
> ---
> RFC:
>
> I'd appreciate guidance on whether -EIO is the appropriate errno here.
>
> E_NTFS_NONRESIDENT indicates that the DATA attribute became
> non-resident during writeback. Translating it to -EIO prevents the
> positive internal status code from reaching generic writeback code and
> preserves the existing behaviour of treating this path as a writeback
> error.
>
> However, if the intended behaviour is to retry the write using the
> non-resident path instead of failing it, then the correct solution would
> be more than a simple errno translation. The proposed change assumes the
> current terminal-error behaviour is intentional.
>   fs/ntfs3/inode.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
> index 0c9bd669117d..9458867c6b0b 100644
> --- a/fs/ntfs3/inode.c
> +++ b/fs/ntfs3/inode.c
> @@ -1019,6 +1019,15 @@ static int ntfs_writepages(struct address_space *mapping,
>
>                          folio_unlock(folio);
>                          if (err2) {
> +                               /*
> +                                * attr_data_write_resident() can return the
> +                                * positive internal code E_NTFS_NONRESIDENT;
> +                                * both mapping_set_error() and writeback_iter()
> +                                * need a negative errno and warn on a positive
> +                                * value.
> +                                */
> +                               if (err2 > 0)
> +                                       err2 = -EIO;
>                                  mapping_set_error(mapping, err2);
>                                  if (!err)
>                                          err = err2;
>
> base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
> --
> 2.53.0

Hello,

Sorry for the delay.
Your patch was applied, thanks.

Regards,
Konstantin

