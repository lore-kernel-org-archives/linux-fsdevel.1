Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C661374E5A;
	Wed, 10 Jun 2026 06:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781073128; cv=none; b=lAKQn8nBNbjA/bI2xmIaD1NRqHSoBF8F/0EWPQg92nZhFnjYGdxrOjFYMOyg2/yyhbacwUtfcEJBUwX3aCPDQbdVlF8HzkRTtZz7nuIqleXEIJf5xv1QoB+4ewtpPkoZS7mR2/BHZuXTjuHEJOSmMIKXMuApgW/q3XhbqActOOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781073128; c=relaxed/simple;
	bh=M845WCXEVBDN5jEpp2FAINDSiNHSK8tnZGUI25q/3Yo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cCVYEHKrI5BXN6cNdHXp/Tw24UZjv6RXX4wxlkaI57VlH/ZjBpJjFOQuNWwUDwTXcMmfdK5eITSYra1RJ42VgEpW6A7GLGSGquGfHn9nQ52kYyF6eR4LTw4HTqgF2CzFX8T4iXt0E3Q+sav4dTE7vXGMD1wMtNoy9dRKKLu0I0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=F/BbLZ1f; dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=mBYQVBUH; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="F/BbLZ1f";
	dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="mBYQVBUH"
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id A328B26F765F;
	Wed, 10 Jun 2026 15:32:04 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1781073124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oHttKLqJy0QvLy+dCrmMkRF9+qTAGmgboae9XEIir8Q=;
	b=F/BbLZ1fQ4DexoOGM1reGK2gfXeWqGo7KgjRdbyOrRUiae5ERPKZJHaoLcj2sGcBHZa7Kj
	dKfn+3mdPUFlRGUzM0pwhbCrkStfQ3HievuLlRjeUKyWGbYrtWZXeX1GlTRu1EGGPOhmms
	Fr+LM/ylL5yc/DTnJmPSMPiUycuLwUzHrREzGO27dhE+dzygkL6HP49gHXMoevGrYKVRTk
	2bMOjvWwW/07JJ3ZlDuqaGl4IMg4UFhGPxUellmPY5O65or4+3/3h4AYQ4TDt74bkd9dVR
	M7Y6cru3nNvevBL1ro2TEALd/BGOcdBEJalH478tOjIRi/rvBjZYUhoxW1hzBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1781073124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oHttKLqJy0QvLy+dCrmMkRF9+qTAGmgboae9XEIir8Q=;
	b=mBYQVBUHGcFbhiRPxz5ayz1jN4UckiMLJGdVmH4A7zB941Vxyp4dPEsUgXowYyAvj8pQCU
	a14qkJvl1n8zvoDA==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id 243FEE008A9;
	Wed, 10 Jun 2026 15:32:04 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id 1095922001D5; Wed, 10 Jun 2026 15:32:04 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Matteo Croce <technoboy85@gmail.com>
Cc: Timothy Redaelli <tredaelli@redhat.com>,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Matteo Croce <teknoraver@meta.com>
Subject: Re: [PATCH v2] fat: stop reading directory entries past the
 end-of-directory marker
In-Reply-To: <20260606105420.26641-1-technoboy85@gmail.com>
References: <20260606105420.26641-1-technoboy85@gmail.com>
Date: Wed, 10 Jun 2026 15:32:04 +0900
Message-ID: <87qzmehpnf.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Matteo Croce <technoboy85@gmail.com> writes:

> @@ -1310,12 +1333,15 @@ int fat_add_entries(struct inode *dir, void *slots, int nr_slots,
>  	bh = prev = NULL;
>  	pos = 0;
>  	err = -ENOSPC;
> +	saw_eod = false;
>  	while (fat_get_entry(dir, &pos, &bh, &de) > -1) {
>  		/* check the maximum size of directory */
>  		if (pos >= FAT_MAX_DIR_SIZE)
>  			goto error;
>  
>  		if (IS_FREE(de->name)) {
> +			if (de->name[0] == 0)
> +				saw_eod = true;
>  			if (prev != bh) {
>  				get_bh(bh);
>  				bhs[nr_bhs] = prev = bh;
> @@ -1325,6 +1351,12 @@ int fat_add_entries(struct inode *dir, void *slots, int nr_slots,
>  			if (free_slots == nr_slots)
>  				goto found;
>  		} else {
> +			if (saw_eod) {
> +				fat_msg_ratelimit(sb, KERN_WARNING,
> +					"allocated dir entry found after end-of-directory marker (i_pos %lld); please run fsck",
> +					MSDOS_I(dir)->i_pos);
> +				saw_eod = false;

Although this doesn't catch all cases, if it found the corruption, maybe
we should make FS read-only (fat_fs_error()), and return -EIO error? Is
there the reason to allow continue to write?

Thanks.

> +			}
>  			for (i = 0; i < nr_bhs; i++)
>  				brelse(bhs[i]);
>  			prev = NULL;

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
