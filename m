Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793753735;
	b=FoU2woMo6YkrWBJNBJpMMsNznOVfzC57SeVYbHQk21ljy5Ytu7T1fOuhyK90qDUDQ7EK
	 5dTTCQVKk6SzOT5p2dj7LGko9aecMUBojMINlzhhfbQkVAYIOfFORwJKmDlk/NM3kWw1K
	 PDVRy8Io++vrObjREWgyXZTJ3KhHHmYq9Pwwab5zvCKuwP2DhcugQvi+4sMn8wDRIDb2k
	 S1C1gqvGZipuKNXteu+1yVSAmmhgjNl0LrenwBT53hFeA/ld9ObcgD/AT2BG2ESuqZpxo
	 E9Dwnu8ZHDmdUP4v+8nXVH7EMGcXUdI/xgLaOtpWqnrqHTdv40rbASHQUc669PeUE9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793753735;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=xG5t3xikeZrgWEXDIQ9E66WF0APj2TRUKkrk3j8LkpE=;
	b=sZIYx5ciXVRpq2+p2QD20t7zkDlxqpcg7gfd9ccvPoCE9kS0pGcCYlHQvg/HWXIxNavC
	 2znxCbYmsiCWiV7OOxK8QISnMb9pRUsvoFkz7AopTxf6e7SgbbMwTOx2IO4jcCV8WeHrd
	 e3Vbm2pMWqrSpfKNSRIJS2KJcurUDrsQgH9jLyUJHxV9Otmnkt55ttGrnxCy7XhJVlDqg
	 Ooj98aRZ6yBBCDWpiG3vcD8ZCEPV9VrUkX7Sshgg39houYTnSC3+BijWtqQxvS+N2nJQ6
	 tco9FxkPQ4kLwHSY8DNFM5e906491PgDMqFkhrxExuNZBu/2EDO3gefTGhlQ9REjLXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sudo5wuz;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EBA606A333
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 00:55:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71EBA606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sudo5wuz
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3acb512a7a0so146493a91.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2026 16:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793753734; x=1794358534; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xG5t3xikeZrgWEXDIQ9E66WF0APj2TRUKkrk3j8LkpE=;
        b=sudo5wuzf8me28sIhbntLBwUiKNWuwSV6wtIncQpUBbsN4Zu1yMj1uOdtNMULS+qse
         p10GSTbsQZQej+RmcaRVIPfYXpiJc7DVP332tBPCeYi6iIxYHtw/pCGnwu6pUZaiYkuu
         1jzqj0fIApJI24vXlIZRW+4LFyo/2rv7mV5cIr8Gch74DjfIbhBYVLv8/dyYnqAxTrWw
         7/Kxsv4asQfbrP6PWPBOlk/xWVzyI0hLDQrJy+RjayW+oFANYAqhfVZpq60HUf6srI5f
         LvFF0LRAtEUesVRTlzKq8hIDxyh050q8ogJnunYhdFI0Mss29VGLQmid0PHrrP/vhgJw
         FudA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793753734; x=1794358534;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xG5t3xikeZrgWEXDIQ9E66WF0APj2TRUKkrk3j8LkpE=;
        b=WCvpNdWiLY433647PCPRCFzLIkAR9LfxlZgfhCQ8dFiJ6df5EHrPzuXAuzEqnxKz0g
         onig/o3lYhxAkDmE6qW+N2l5ZrqSp19PphIws8lk6+Lr56+M8r0vdJ1GYvnjsPKZonLY
         N9Z82W32peDSMGLvE2VhzlIAyxQcAxTy77BPiGr2jhE+jpTzS58b89lGzIDgfMgwtz6e
         yUpVvyxW/eFfU1bjm36sUSd7dgtlC97KPdui0yvSpHbDHHN3BQC5mvrXDd8YJVcGPQBN
         LWhr+Ng82ngOW0xlIzrHKnbMQWfRyld41j68PcWM7JYVSqg7icZe5uxoiVTJQ8udmdsD
         h/zg==
X-Gm-Message-State: APuU4Z85njv+ZYtVLnD6eQnC07xr4qRcaFE/r0OPIj/15r/5fYHdQOwl
	Un/Ob28Ubl6dKTePvXMMLYBjUi77ZGQeIOYHObcueXMqpjFHLFKt2qc9
X-Gm-Gg: AYBFou2kGN9ow+MzQFq4H4QZQvh8SfGVwRrIESnh6tfvBpTqidf+m1G6EiCN7EVOguk
	Yss0jNvNLJmLNtz/rS2UpVHxo53N6ahhyEn+9kHZXAorDk5nhesTrOVvW2NAUXK5S3lZC3F78bS
	DktT9PkUhdx3a+OBt1f/vIBK7ahdJWp/tSV4+0YZguk1O/0AtWAzVGjLnwvG1JZ6TOMzI4rb1We
	YRQfYkJ/Q86nSgP8M4IbkeSbnI+4tWKjvVzj3FKJq6BFU3++gBlQ1AETa8ZQqE7maYlZVeXp7tK
	1dlcrybLg/Ku8Sp7JG+RXYvRrQI8g/mgCWqgyuOmGUPrs6yokn1rJM5tsJ6T2JcJT5OlPnotGCi
	ksz89lfs8NhIYYQvQkzKXA83H/QT7a2LMcxo2DCZa/jEMkoXSaKIbmA0hInerEmEL180hB5IE6n
	9UlKLXoR2P3AWSzhfbnJTHgeaXivlScZyxiPBTZntlVlg63zf5PGcqITc42Ihe/zJqDWlF8+Lk9
	wY9AaFZiu93JGWf9GwXVzg9A47s1J9aKutFmIue2cDtZlUFOvDItzhtK7gJh5qHZNBkax+O5c26
	+K3ZOOR29TJAqutwkw==
X-Received: by 2002:a17:90b:184f:b0:3ac:83c1:2c0 with SMTP id 98e67ed59e1d1-3ae897e06efmr11479861a91.64.1793753733906;
        Tue, 03 Nov 2026 16:55:33 -0800 (PST)
Received: from localhost ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b09445f7b3sm1222403a91.5.2026.11.03.16.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 16:55:33 -0800 (PST)
Date: Wed, 4 Nov 2026 09:55:30 +0900
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>, ecryptfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
	linux-nilfs@vger.kernel.org, exfat@lists.linux.dev,
	linux-mm@kvack.org, ntfs@lists.linux.dev,
	ocfs2-devel@lists.linux.dev, linux-btrfs@vger.kernel.org,
	gfs2@lists.linux.dev, linux-efi@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 18/34] ntfs: use the generic emergency read-only state
Message-ID: <auqCgguXEsKCq9p2@hyunchul-PC02>
References: <20261029-work-fs-sb_rdonly-v2-0-2f44f64f0b66@kernel.org>
 <20261029-work-fs-sb_rdonly-v2-18-2f44f64f0b66@kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261029-work-fs-sb_rdonly-v2-18-2f44f64f0b66@kernel.org>

On Thu, Oct 29, 2026 at 05:07:09PM +0100, Christian Brauner wrote:
> Set SB_STATE_EMERGENCY_RO instead of the NV_EmergencyRO volume flag when
> an error makes the volume read-only. ntfs_emergency_state() keeps
> telling a shutdown (EIO) and the emergency state (EROFS) apart so all of
> its callers stay as they are. /proc/mounts shows the volume read-only
> again.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

-- 
Thanks,
Hyunchul
