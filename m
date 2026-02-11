Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7504C239E88;
	Wed, 11 Feb 2026 13:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770816331; cv=none; b=ptxrqZe9wiz1RtWWHJ5jh3gcoXA6xmYi2AbvlPbp/JoFuDkMDCaqLxVhg8GRjOi8jtxsjP6HUBMgu2kuFoqgaMDV06M921u9KGHeqhF2GGSoQWbk6GJ9/Zf7lQLPMyKxBCcFWCYsXylW/lTNbWsPRL8Hs6zs6UG05zQIWsmpKCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770816331; c=relaxed/simple;
	bh=aKYJKatjBi+FBdbRQ/p8BNP7H26DawqLdq9Rg6cJ7zM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RzcuoCXzdSin+n8h1RsZD0kxuN3UxtXh568EQK/ov2hDYOyyTcKwpaixBHj+q1b9YZ5CuGz1I5gcLGSGqqnfrrbVJ6KyRFLBewR6fh9PxYDGauwHNBJ0mCrPUNws50phyiHiacZ2nEkV99skaQW0f08YPDnt+ndZqk9ZRmRAyrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=H4WuOYqh; dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=PDlLxUej; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="H4WuOYqh";
	dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="PDlLxUej"
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id A1219209655A;
	Wed, 11 Feb 2026 22:25:21 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1770816321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qigHMSUzhkKvepn4r672YZd6Nrx2BPvwlI/lOrBJ2TE=;
	b=H4WuOYqhi/XIhhksnvPLiP+waapUAknHJLBHl1aYxQ1yt8RIsU0I8xRsBTWROeO9TopvK0
	77kSOhM/zC/DkUboYkSheK+mBUyVKsKFMCU8RIgzTsxXgrlwJbhLDxj4UmNARRMCAtZjBm
	tedopO+Z47Q21FWOt/aETTGmIMbWzfIcHaHfcdZ0cUf96sJldtGTQJv9cKygZenh90yZL9
	As+Nd8fjZ+0e2j4wx3GvZua4Jbb2lEjDAl+OdBx1FUnQ2en7FDd9V+3MYP9sNcOQjTdwtR
	7rV2+FGiGm26TFgcpmqmyuevkloAgd7kvgVpMf44nySlTJgyURY6pkB5V7u33g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1770816321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qigHMSUzhkKvepn4r672YZd6Nrx2BPvwlI/lOrBJ2TE=;
	b=PDlLxUeju5DVghHXOeR2VgoVaG360/wv4JMf4qGUmgyrHQFD6LvXh5jjVIW9iPQiKl3cEV
	eb0i8GVWhCQOetBA==
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (8.18.2/8.18.2/Debian-1) with ESMTPS id 61BDPKmN255042
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Feb 2026 22:25:21 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
	by devron.myhome.or.jp (8.18.2/8.18.2/Debian-1) with ESMTPS id 61BDPKUU035944
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Feb 2026 22:25:20 +0900
Received: (from hirofumi@localhost)
	by devron.myhome.or.jp (8.18.2/8.18.2/Submit) id 61BDPKAh035943;
	Wed, 11 Feb 2026 22:25:20 +0900
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Ethan Ferguson <ethan.ferguson@zetier.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] fat: Add FS_IOC_GETFSLABEL / FS_IOC_SETFSLABEL ioctls
In-Reply-To: <20260210222310.357755-1-ethan.ferguson@zetier.com>
References: <20260210222310.357755-1-ethan.ferguson@zetier.com>
Date: Wed, 11 Feb 2026 22:25:20 +0900
Message-ID: <87ikc3xvi7.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ethan Ferguson <ethan.ferguson@zetier.com> writes:

> Add support for reading / writing to the volume label of a FAT filesystem
> via the FS_IOC_GETFSLABEL and FS_IOC_SETFSLABEL ioctls.
>
> Volume label changes are persisted in the volume label dentry in the root
> directory as well as the bios parameter block.
>
> Some notes about possile deficiencies with this patch:
> 1. If there is no current volume label directory entry present, one is not
> created.
> 2. Changes to the volume label are not checked for validity against the
> current codepage.

As you know, those will be required to implement. Additionally it looks
like missing proper locking.

Thanks.

> Ethan Ferguson (2):
>   fat: Add FS_IOC_GETFSLABEL ioctl
>   fat: Add FS_IOC_SETFSLABEL ioctl
>
>  fs/fat/dir.c   | 22 ++++++++++++++++++++++
>  fs/fat/fat.h   |  2 ++
>  fs/fat/file.c  | 28 ++++++++++++++++++++++++++++
>  fs/fat/inode.c | 26 ++++++++++++++++++++++++--
>  4 files changed, 76 insertions(+), 2 deletions(-)
>
>
> base-commit: 9f2693489ef8558240d9e80bfad103650daed0af

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
