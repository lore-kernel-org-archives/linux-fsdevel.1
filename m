Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793753392;
	b=IBMjxGAAh9nBrgTmwUAO371YCDQJl6yNgE/fmBUduWOauxOVWW2LsZyNczoVqFBG+9p1
	 EMmhmvvaFV8bzFMLedTPAteiKJrjbmjUr6MOnIXVsKDprm3L11T2VXpsp6bLJaAxvmUbT
	 By714pomIzg9/RBHgONeS/kE5B8aattfWRrjDcgmfMlG4/oVcl1JWw663FqpExv5MPg3Q
	 fJjDi0ii1CDN6ZJExdVFKaNi909eNvguN3jJtDwjwa0ahX+Sg+DjBWZJ8wsDHVuKUvgRe
	 ds2YnSc2F24EY7TVshzFYyDu+aEkAoUQO2m3PwKqnagGxUdA/djbO3+Z+wtf5PMaliw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793753392;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=/bumM81nPiENiLh9PH/Fm40C+VENRMD3A/OuAfI8Z4s=;
	b=Za78k2LWtDamSfkET+tqR45zaBoxPIzZ8VZ0R0uATm15YeOX2T2bPUqXjjVFRoCKCKFc
	 wwz/9X4nfw45YdU5ZNKHYwPniqXeESqwPINmUtXnwvee3CTlLchDkxT7tyYNlQeLG2HYX
	 N2Sot6/7E//sICZhemW2MqSVShUMpXuHyMcitS8WnC0KMIlbvAYtLxvHOVy82lEhpZma1
	 2RRnjlll36BYazGnnxM0LeUdMU4ulwOJNxD1bMT+Ll2csAKQXhTNTabILSMp9WzvAsIJP
	 iPOg7Xs6MlLalWfqUAGfDa+xhxv+2V2ulGpyz/kOXuhC/yMehcccxQQlXwC4oh1Gkkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VT+pUP2N;
	arc=none smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38141606A334
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 00:49:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38141606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VT+pUP2N
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-886e61fa30fso101056b3a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2026 16:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793753391; x=1794358191; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/bumM81nPiENiLh9PH/Fm40C+VENRMD3A/OuAfI8Z4s=;
        b=VT+pUP2NwuZcLnfpE6RBehWP9rj7p+v+tKoR/WVHOzz1v7CJgJGu6gqjY1V/YGEdmw
         igNrVOnPTFLv9xvYK2tnZhcPD4jqAzwLjDlQ2iFsJIT0vgZOsXkUB60qRSrv68Heg2+2
         k5XkKmMrKWtBUKDoGvgF6CjyKJx7mmzehyXgiMW8Z51NtcdDEa4LvP5GkI/GPk/JWdX0
         E0pyc83t8pyqA1wDQ4YMhv4IP3UIHbsnnJtT4+s3TyxuI9ePzpN8dD0BzwPhXNBIUBNN
         GS4KAdHBqzLrJ9upnMsWdUfiG2GuZuR+cDGx90+hJalABWpp8S3bPmquj5j2mZuikn7l
         6bxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793753391; x=1794358191;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/bumM81nPiENiLh9PH/Fm40C+VENRMD3A/OuAfI8Z4s=;
        b=zD7YJA26M6q6jTVDDupqZaWNPGigxR4gn/vqz67vKQ05WlAC2Exnq9QI5Dc+YFKmG2
         WL/6FQreKNvIb9Wdp3ryLFvNb37bHaynJuwTgNQ2+16hEBpzsfcZhnOx10l4hBUfd5YF
         nfJk7xIKha+M1UVnT2IAFloZjlzoluPsQctFwO9IVTZzsUrqU7mWvJURRoDzU/vhnycX
         uU6uF1ijQC1uud2alV++1AvP/C0cCNUcyvIW18wNI8cFFoo1jlRG9FZkSdjFIkp4g6yi
         I7P2AjackEZBA659CzOK79kvuJfYOJPI+MbMr7HPLf4z8j/p5nbAXumpnv7ymZW7xsrR
         tYzA==
X-Gm-Message-State: APuU4Z969jRVdJZ4hPtSXacPuRqXr4B/xoCfnTizDL353pTMxE1OiRzb
	5L+2HflXvmFdGLm9rVQeKDEYabpphHojYydNzY1fifIY5AAyqpaFsOx0
X-Gm-Gg: AYBFou1+kPNDskGk0+0eUO92NBqwhIEAzun3b6LLMwI9JFVlV5JCsxdb1VBOaeWdPuv
	TxWSzwBqMbK6QfvU1Lr1mOnx6Ocf4cCQ+moDlGyhwzWaxzzHILP36Lll0w7bSqkH+s+zUd6YIhc
	iCTo6fVJsKcMwep0eAclTxJ/auNrpqmKx3ShZyUXajXopQPy5R7tfH+XPGNdtBG6MgmXQ05z77l
	0+2/cGkONd81YK5JIKqhDpDrCR4Duj00wVXWVbs91RsF+MnSNWonodTFsloDgngf1M5yOhG7GfN
	CuNJfegREYSNZOvQjXTkpjuDqYcuerFQZiyVxmPYt/Aah1j2Z76i8uToS9ekaD+lIfyMPtHqdQT
	W7IYCfhcG+11WL9pozNLsdukIJMFCgwvfcLxx1/VzRslRgc97y539VzpVURjJzocthIcDzuXmJm
	gGtaMPwhC4JANAr64Y8AcMS81MrtsU1kaiNvbTRXvAwryS81xy6mrU+YXLpqqEJPaTvbcWVDOlE
	fBBQ/WxmvpX8Hb0Eu3nfY1KHl5GhNl83VC5Sw0ZVkCAWxx/dfb6HafDcHnQW0B1e+IZ34C7YQWA
	4S9ucbcutzY9YhB1BS3eoJhFJwhnEYO9QmR8Km4=
X-Received: by 2002:a05:6a20:914b:b0:3e2:9470:5303 with SMTP id adf61e73a8af0-3e928953948mr11828504637.15.1793753391239;
        Tue, 03 Nov 2026 16:49:51 -0800 (PST)
Received: from localhost ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb46440cc7sm329325a12.3.2026.11.03.16.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 16:49:50 -0800 (PST)
Date: Wed, 4 Nov 2026 09:49:48 +0900
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>, ecryptfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
	linux-nilfs@vger.kernel.org, exfat@lists.linux.dev,
	linux-mm@kvack.org, ntfs@lists.linux.dev,
	ocfs2-devel@lists.linux.dev, linux-btrfs@vger.kernel.org,
	gfs2@lists.linux.dev, linux-efi@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-xfs@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 17/34] ntfs: don't set SB_RDONLY after filesystem
 errors
Message-ID: <auqBLEvcurRZfGj6@hyunchul-PC02>
References: <20261029-work-fs-sb_rdonly-v2-0-2f44f64f0b66@kernel.org>
 <20261029-work-fs-sb_rdonly-v2-17-2f44f64f0b66@kernel.org>
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
In-Reply-To: <20261029-work-fs-sb_rdonly-v2-17-2f44f64f0b66@kernel.org>

On Thu, Oct 29, 2026 at 05:07:08PM +0100, Christian Brauner wrote:
> With errors=remount-ro every ntfs_error() ends up in ntfs_handle_error()
> which sets SB_RDONLY without holding s_umount. If that happens while the
> volume is frozen through bdev_freeze() thaw_super() sees a read-only
> superblock and leaves the s_writers rwsems locked so every writer hangs.
> 
> So set NV_Errors and a new NV_EmergencyRO flag instead like ext4 does.
> ntfs_emergency_state() returns EIO after a shutdown and EROFS after an
> error and the write side shutdown checks use it now. fallocate,
> ->set_acl(), FS_IOC_SETFSLABEL, FITRIM and ntfs_mft_record_free() get a
> check as well. Errors while mounting still set SB_RDONLY, nothing can
> freeze the superblock before SB_BORN.
> 
> NV_Errors already refuses a remount to read-write and since
> commit 521978c4f444 ("ntfs: sync the volume dirty bit with the recorded
> error state") the volume stays marked dirty once errors were recorded.
> But the dirty bit may not be on disk yet when the error hits and
> writeback is refused from then on. So a work item writes it right away
> because ntfs_error() can be called with mft records locked, and umount
> lets a pending one run first.
> 
> Unlinked inodes are left to chkdsk in that state. Their mft records are
> freed with direct bios while the index and bitmap updates of the
> deletion can't be written back anymore. And writing to an encrypted file
> only warns now. It called ntfs_error() which let anyone put the volume
> into the emergency state.
> 
> /proc/mounts keeps showing the volume read-write. Writes through file
> descriptors opened before the error fail with EROFS.
> 
> Fixes: 6251f0b0de7d ("ntfs: update super block operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

-- 
Thanks,
Hyunchul
