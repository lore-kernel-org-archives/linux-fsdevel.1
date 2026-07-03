Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55F22367D9
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Jul 2026 01:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783042877; cv=pass; b=XNFv1EhBftphtAI3o2vtXTQE/HT6WHTnBPaf22Q7GAVXkTSdPm/GxRhNlb1FtIHmbMYTmupcdMgdwk67HvaA5cJKRuE8OwLZp0WC+DqVh0vbZdGdkPnj3l7hRmchPwp/0u7Mw4htbyOVTsUOFFIt25gzYaaQt23JL9uJJquFiVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783042877; c=relaxed/simple;
	bh=GjnQcsugbzq7pSMN61WDGKezW96ZpqpWXqGhawt2wI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cZvTmRGn4mL+X7YLPOvUDVffoVidwXwhNK4ipCrAcmDy5d7agakFD7G+n+iD6SXUP5P63NsxYI/jKE2z7ZRjfK7dsAPKfBPrgU03fHJf1XkIWytMGrqQ0rlGacy6mw8owF4eShYQ3YYwBrv1G/ty3otQ4YurCP6DYH87vD0Ad9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sm6SRKYs; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sm6SRKYs"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5aeb91c003eso89576e87.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jul 2026 18:41:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783042874; cv=none;
        d=google.com; s=arc-20260327;
        b=s2KGcT5rtkT+Mg6zPacbq1XVkPhEstKwC2oouAQZXxqqwMjJ9n+g1vhmPG8O8WfT9D
         N0YtCj71hpLTUq0Hks+iE+oSjnOXKCBMLhNG/3ALRjAi0118QEmJcSj3aKIvQ/IHmBKd
         GtpmDL0zIyiWg5dbDHPhS07Dcm8QsyOxT5vgI85+YI1s6h+UupYLm1D88BXrHywTnbcA
         ar4c6uY4vnRbEHx3k35304zB5pkbCg+SpZ/rMmTNgexI0d/a/DtcV/yCFufVqyrN/f/f
         fvdkuVo1312YfEC5Xim5JPyGLTjwUIBRmdx33qSqf1gwWD9obyoH93MGfYNCFXB0fG1o
         3eQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Tm8cgihkDfE/U9ZOxUrysshJ9BVxEukGQxToeu32U5E=;
        fh=zHhdE63tAc+TpSTPP1ir8tmkeLVotSKg1LuaLVITXao=;
        b=hx78wJeOAKkcdoGV7Yi5PBrYSecD1UQnYVjvYLyS1bZBmnG+5zX1fq1SrzJGgDiGeq
         LWDlydpDWWZJJwiIeEpe5MitPHK/naewP9xSq3M9VJUJvCa/3BORwkm+UT8cPMpQ3Q8A
         kxvGflRibydZYan8sYIk13AwgWwuHA+8iy6lw2MMh5+yAvkltOfLMstqeKVBIdQwBVJM
         Kuzp3xcB761VTdJi8YOKvVNGF1jj323HmjphYzRDv+xhpCCQ5H1HGR6GE3ZiuMjah4iQ
         olPcoWYcjD3D588YTY6q7fgSGOyIIFnSnAwLe3iQO4WEiZbYeKxceZylqUBpAjT6l4zA
         MpSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783042874; x=1783647674; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Tm8cgihkDfE/U9ZOxUrysshJ9BVxEukGQxToeu32U5E=;
        b=sm6SRKYsQMA1lB3fAUHJGnwso7vzTjABHRcmroEzKrgxdU0BqaUs0puGWbq48QEHAU
         bjt9qqq1hA2gXAUHYe3qcq3ExF+4I0dQqh3Ctc3YJonc4jQMXHaplP7X5Pf0qfx5pQ78
         gPINf0y5Yuha1S140QrHeLbMqkSpQRnCGzGa8O/s7n+meEHjVAGTto7NWYvS5zZIThta
         l8pCmFmIUMSL328neK+DoZh76r6pIvzJJCD5Ljsu9AUzIgc/b4VjazmTnIi731nUDIZo
         FtTUTxtRDADr45mDF6j0TCphng+Il8R2hih8eCtctMgm4usDJoZIGrmH8ep683kUdZWQ
         6vKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783042874; x=1783647674;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tm8cgihkDfE/U9ZOxUrysshJ9BVxEukGQxToeu32U5E=;
        b=EKU9gxBoVonAcBdnBfuMcFKfDdDudXli/UukK/GDcmoDibwBDfhaQJ9clyczaqE0rW
         75E97X8Jb5JfqSOxJVyp++bkzU3ZUkrDDGKONiM8M+G9kaU8GXSb0DkTVjqkYlOmUzdH
         fGCRIr34bFwCij3POq/F8r8YLprNgOUXI40L46MWV34iNMpp30mgqLkgUXGf/tdO1wNQ
         VXemFExN3iS24sXnEzDEvfKrP1eofSNJC4zbL8yHAmmGIY3b5/GPhlO7QwHLXChDtKpR
         TtemCSH/FHXtEtTLB7yFMI6QCwU471nxpybKONRpX7McLjDQI9rvldvwqqlEpS+ZWcYq
         mNDg==
X-Forwarded-Encrypted: i=1; AHgh+Rr/YHKGcpe7pf7lNbWsqBLqG0OQiA/mSWTkNN7L1XcYZuyp8zCzE6mlodnXfv8d2wXa6ILFOAz3+9yG0u7D@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo7+rD2Yq5IxCvGeic0/8jdjB0QmU8TNIsHPxgYIDr1T+7d+e3
	PVAP/ycD87d/4BVWikjgGcFhLBNccM8LMrLJRrvkxUFfmfcoshrQw4OSi71uPN1XZ6PezVsXXxi
	//qJjVWghteFgxHXtxjFBLcLRY/iMkRC7zal9
X-Gm-Gg: AfdE7cmVTH/ybkAQSPwY/XIcNZzIexgNBf1gQhwJWwLdEsef36F8VinuZjwTJnANUq1
	Tk5QlYMf19i+tC0uRNiB2Dr+UMQuV6k5uikiuh0SL6fsCgIViWjzHU8SzmKMWAUa2XAEaC+yFXW
	5Bz4HuOr+PhqFq8FmaRpuKtR2LZtbr5gSn8WntSmOV/4dTGIgVoqDPwOCoqsaA5qFQF8tSp27Wg
	lC7BY3wPoTIy/kpm2frd0ZPTQGT0KIpTDQ0dfROnkFwekZBSCBBwmMDAVwwTh9Lm0pEMlOL
X-Received: by 2002:a05:6512:6381:b0:5ae:b0aa:8f07 with SMTP id
 2adb3069b0e04-5aec67a2d1dmr1912012e87.16.1783042874015; Thu, 02 Jul 2026
 18:41:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702161710.2606853-1-zzzccc427@gmail.com>
In-Reply-To: <20260702161710.2606853-1-zzzccc427@gmail.com>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Fri, 3 Jul 2026 10:41:02 +0900
X-Gm-Features: AVVi8CfDq3-O7UZsGSYo4zpc4uGr8Z6DnzHTxqQZyJBTeN8oXZFoTjjgKbCvZaA
Message-ID: <CANFS6bY-GKojmuLMRKoh9r83iHT7_wQQM=SKZH3vB88QFzg11A@mail.gmail.com>
Subject: Re: [PATCH v4] ntfs: serialize attribute-list replacement with lookups
To: Cen Zhang <zzzccc427@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Cen,

While running generic/013 from xfstests, I observed the following hung
task warning:

[  492.533956] INFO: task fsstress:934 blocked for more than 122 seconds.
[  492.534445]       Tainted: G           O        7.1.0-g81fe702ff176 #2
[  492.534870] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  492.535914] INFO: task fsstress:934 <reader> blocked on an
rw-semaphore likely owned by task fsstress:934 <writer>
[  492.536788] INFO: lockdep is turned off.

# ps -eo pid,comm,stat | grep " D"
    460 kworker/u16:4+f D
    934 fsstress        D+

# cat /proc/934/stack
[<0>] ntfs_attr_list_lock+0x2a/0x60 [ntfs]
[<0>] ntfs_attr_get_search_ctx+0x97/0x100 [ntfs]
[<0>] ntfs_resident_attr_resize+0x64/0x610 [ntfs]
[<0>] ntfs_ir_truncate+0x82/0x120 [ntfs]
[<0>] ntfs_ie_add+0x35/0x200 [ntfs]
[<0>] ntfs_index_add_filename+0xca/0x120 [ntfs]
[<0>] __ntfs_create+0xa9a/0xd80 [ntfs]
[<0>] ntfs_create+0xbd/0x170 [ntfs]
[<0>] path_openat+0x1014/0x1400
[<0>] do_file_open+0xdf/0x1a0
[<0>] do_sys_openat2+0x7b/0xe0
[<0>] __x64_sys_creat+0x45/0x70
[<0>] do_syscall_64+0x101/0x6a0
[<0>] entry_SYSCALL_64_after_hwframe+0x77/0x7f

# cat /proc/460/stack
[<0>] __ntfs_write_inode+0x7b/0x6b0 [ntfs]
[<0>] __writeback_single_inode+0x3f1/0x580
[<0>] writeback_sb_inodes+0x25b/0x8c0
[<0>] __writeback_inodes_wb+0x47/0xf0
[<0>] wb_writeback+0x216/0x440
[<0>] wb_workfn+0x3e6/0x510
[<0>] process_one_work+0x200/0x5e0
[<0>] worker_thread+0x1a0/0x370
[<0>] kthread+0xef/0x120
[<0>] ret_from_fork+0x270/0x330
[<0>] ret_from_fork_asm+0x1a/0x30
