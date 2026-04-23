Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785F926738D;
	Thu, 23 Apr 2026 15:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776959719; cv=none; b=arjWL3002vousgZDGCxPp/Pp9z5Y353+1BBHcw/tU3FwortyXxMYH7WYISUnKz11Y7hr89po2c53Je7nfRVJ8N/ze7+b/PUnhIq/zmo48CBBqqScYw9jmt8Ggx/Y+yxMHw/YgqtydhK7xGSbedIB01nLNrrJgwDtrsczQoM/hu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776959719; c=relaxed/simple;
	bh=AGfg1kvvwi9/8mQHoYmLe5MvRC1gFyoT4GJgItX+9gg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kWy+DKyvGE9iMcr0E89F1amNyrBFz01hWJPU8EkZYWeHnCh8/n2+JIrwBegRYg6GXznDObZOlsE1G8ALDnjpNxhkEOvdvYohPXbU4whBqeqS2xtLXv4Tqec4UJX3KIOoZBk52N6l2clHCNCoMUqC3jm6Thf4aaZiC/tNHV0iaKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SP0GGQsU; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SP0GGQsU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=Z7AQNeKGJVR/FcqvlyvAjc1g6j67QN9Za2A6dddIjp8=; b=SP0GGQsU6Keot8S+ymFqTLSs6r
	N3Ak92y5slT5DLq0XCZUstqE+sVNCz/I33nH34lyXmdX/6VnTKk/sOiDIwon1oacxhFsm1niLHfJK
	RlIawbU+N3Se/xUabk7q3qLpSCuqFL4ZKBGdfl6e3RJ9q6Fv5Px8I7qRkv5iw2T0Sr/YYuDuFgz3U
	HxlH32FLBtcOJnZJbh8vTvjJj5dbhIFGLq4NcWfT11aFQlR59HHhd1c2ejqpDXkqx952w3bLJoYbn
	DOieUXgwvCFLVamkQxD/SUydLDWHk6lXqXxHsXQfXXugFpj0RQHSLwkUAp8p2jR2JScYAzGnjX0ob
	UuOtk02g==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFwOP-0000000Bv9E-0GPJ;
	Thu, 23 Apr 2026 15:55:05 +0000
Message-ID: <e1a0e7ab-8cdb-4c60-abcd-82c4e0be6e97@infradead.org>
Date: Thu, 23 Apr 2026 08:55:03 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 v1] Documentation: proc: fix ext4 section numbering in
 table of contents
To: Baolin Liu <liubaolin12138@163.com>, corbet@lwn.net,
 skhan@linuxfoundation.org, surenb@google.com, cyphar@cyphar.com,
 witcher@wiredspace.de
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org, wangguanyu@vivo.com,
 Baolin Liu <liubaolin@kylinos.cn>
References: <20260423065642.11218-1-liubaolin12138@163.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260423065642.11218-1-liubaolin12138@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi--

Why is "ext4" in the Subject?
Probably just drop that word?


On 4/22/26 11:56 PM, Baolin Liu wrote:
> From: Baolin Liu <liubaolin@kylinos.cn>
> 
> Commit e24ccaaf7ec4 ("block: remove last remaining traces of IDE
> documentation") removed the IDE section but left its table of
> contents entry behind.
> Fix the stale entry and renumber the following sections.
> 
> Fixes: e24ccaaf7ec4 ("block: remove last remaining traces of IDE documentation")
> Signed-off-by: Baolin Liu <liubaolin@kylinos.cn>
> ---
>  Documentation/filesystems/proc.rst | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 7ce02573a3d9..70db35987ee1 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -23,13 +23,13 @@ fixes/update part 1.1  Stefani Seibold <stefani@seibold.net>    June 9 2009
>    1	Collecting System Information
>    1.1	Process-Specific Subdirectories
>    1.2	Kernel data
> -  1.3	IDE devices in /proc/ide
> -  1.4	Networking info in /proc/net
> -  1.5	SCSI info
> -  1.6	Parallel port info in /proc/parport
> -  1.7	TTY info in /proc/tty
> -  1.8	Miscellaneous kernel statistics in /proc/stat
> -  1.9	Ext4 file system parameters
> +  1.3	Networking info in /proc/net
> +  1.4	SCSI info
> +  1.5	Parallel port info in /proc/parport
> +  1.6	TTY info in /proc/tty
> +  1.7	Miscellaneous kernel statistics in /proc/stat
> +  1.8	Ext4 file system parameters
> +  1.9	/proc/consoles - Shows registered system consoles
>  
>    2	Modifying System Parameters
>  

Where/how is this Table of Contents used?

But yes, the intent of the patch is good.
Thanks.

-- 
~Randy

