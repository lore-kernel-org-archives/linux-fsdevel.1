Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56062D46A2
	for <linux-fsdevel@vger.kernel.org>; Sun, 13 Sep 2026 13:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789304490; cv=none; b=lsb1y9w4NTfPpG23Eb8248CmU0n6p2OXQjvntVX5XvQrMZlTMPOVmzI9Lw0OSn68ojZilbNZfl9FpRFBrrvfWeRXfNSDt7gfNmnUPBYEzsaaqUh7742YnAoesSUxcXmtfigc1UyJCjE0WCoY8Mhx1CfcO2DswyWORiT8vbSCr9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789304490; c=relaxed/simple;
	bh=JPVrVorCcMNDgIRmuGMPyQWtxCu2dCz1HBfDtRksLpw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TfZLrSEop93zeO7DAoxEmIVtvoGkoPSr1g6LMEQa8Enc4WXbQKg9pQP+z8x7XV1BjToQsz23c1QsV7MYyWKxeQ4qGT3oqr67Puv+SkuBZy6xRG+ADt1+FuyGPI9Dh4qjiVWZyEMOndlY+B+CC7Sz+r0ODE4ygvLYuPICsEH7jWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EYkwsmRF; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYkwsmRF"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39b9184fa80so1128661a91.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Sep 2026 06:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789304489; x=1789909289; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Wg+stOsQjaLt9MCZZ7i9acT8UaapdZ06Alne508dFkw=;
        b=EYkwsmRF3+BO5t+vJ6xCmjRsG/7TlATUTHRIJqMD+LIGAR9DTBWkTOQEsar1qftA0+
         r6Br15kekM32sKC/giaZDnk27Fk7Z5xY5qgr6/zCXugXnKSm0uo8Pin02T/Fj8PH2zb5
         ugarncRqBYGyDVz9U7p9u5qvSJ6Ad3gq4U8XY/22RNhffLNkjZohMYrF0xCDw7XlN6XL
         toEkg7AD3AyhxQA3lSjI1toojQtac3W1NZtxl02oLxp2e5hsDqok+DRgqcentkfebAXS
         7CHKWSE1At5DFliP35lKEeUBc+B5zFtPhthHCHKbRnSILfde16MbJp5VwyXajpRV1wiy
         t9qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789304489; x=1789909289;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wg+stOsQjaLt9MCZZ7i9acT8UaapdZ06Alne508dFkw=;
        b=XpOfqnYmsvyLbJqRSN/Upkhh7/vz+VYSrLX1/J98TLGhzE4JVmWO/eXl5W7fc/VkJ3
         r/ZSFgm64yEFV9/pwmmkWp/Vrn02tRSGEaw6HeytA3hePra6krVMvunS+blYq3DePRXg
         zA8766wu1eiZ452nHnE01Babtfpz/dbNCDyy1Ii0WSHDs1v5RqB0Dn+uLUpW/fWqBDrt
         bPg4NRffRk/wsoe+gmxgRGXtejJjH6ulvOgebY7BmXE3QgKR5kN3sz+g5VlTFwKy8VdO
         La34J406wn8AusGnxRkdT8P+dPjkSs/1rV9ppptXFokMkHblxTwklEV5IUJ45b67ryFG
         1Eww==
X-Forwarded-Encrypted: i=1; AKwUvBxxYxagWScK1Jqi3vbJYH8GuwdBRfoEnPXAcdiDp6BaujnRP8hJW42ASNFGo1C7smGRFBhZqPfgVoF6cbWm@vger.kernel.org
X-Gm-Message-State: AFuF++meIh3jRQ/iozA82+f9RnbVUJrQWLfv8kJtLGcjxFMztj05hDxM
	3OLa5jxmmZDDUAzckvxFfP34LGbavNPC6xGtRx8qypL2rPz8GTOA1gFc
X-Gm-Gg: AYBFou0kzbiyoJAt3AnjZ90JwbicYk711UETP43nrSLbVDYLw1s/VOGEpRrfOcsAX8g
	iZ9b8x8BFZbqSEN3FLtfra4DOqYK2CqmU/8NZ2J5BaVAFtp+aTCBdZ5hagxsipQfJYM7gtNkqV1
	9ZsVOtL5/ZiVIW3jVt5FH0pT9ggt2lGAeMq82aPb68M0r3SctEHT5M/sK+GkjjxVi1bSRjRHf/f
	sOyoVtreymM3dzbBEghyeoBfFwGlZSwLTRgn19rjpx8UtpAeZYx/Mh3UC05K3gUOJTRR9roZxKf
	wSb41OZlem7Pax4+FS3jZ5sUCkvz7bboZT7i69vTK+9RBlvRChBr02/cqeS7Da5IwrweEYJMlh8
	vZPHf3iSPifok4dgh4xBOvTMxYpo5M3VV5uSBUe4zebWDBXSpHApYqKLi54ZBblJBD1vq1HrTdG
	kvWnp7psAxlB/bgDUhvqlUaDLh69dtCqZsVmByeE4ggVF8X29AEQO9j/yYJYP8Ku8NJSDJC05bq
	cc6LPITNQ==
X-Received: by 2002:a17:90b:560e:b0:39b:34ef:3b2b with SMTP id 98e67ed59e1d1-39d9c0ba635mr23620029a91.14.1789304488875;
        Sun, 13 Sep 2026 06:01:28 -0700 (PDT)
Received: from localhost ([106.39.151.115])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d95713602sm15279336a91.11.2026.09.13.06.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 06:01:28 -0700 (PDT)
Date: Sun, 13 Sep 2026 21:01:24 +0800
From: Ray Lee <hburaylee@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: phillip@squashfs.org.uk, squashfs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] squashfs: fix inode number description in documentation
Message-ID: <20260913210124.0000628d@gmail.com>
In-Reply-To: <20260910-bedrucken-wipfel-beraten-dca08f04b19c@brauner>
References: <20260908130103.272230-1-hburaylee@gmail.com>
	<20260910-bedrucken-wipfel-beraten-dca08f04b19c@brauner>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Sep 2026 10:12:45 +0200
Christian Brauner <brauner@kernel.org> wrote:

> On Tue, 08 Sep 2026 21:01:03 +0800, Ray Lee wrote:
> > squashfs: fix inode number description in documentation  
> 
> Applied to the vfs-7.4.misc branch of the vfs/vfs.git tree.
> Patches in the vfs-7.4.misc branch should appear in linux-next soon.
> 
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
> 
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be
> updated.
> 
> Note that commit hashes shown below are subject to change due to
> rebase, trailer updates or similar. If in doubt, please check the
> listed branch.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs-7.4.misc
> 
> [1/1] squashfs: fix inode number description in documentation
>       https://git.kernel.org/vfs/vfs/c/bfe240aab4a1
> 

Thanks for applying!
