Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41F83EFFBD
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 10:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779877684; cv=none; b=Yi0L/ciomgngYxUpyFj90WCmgHwLsGMTASC9pkRfLINix/VuAjWwPE5WT5m6kAin/vIegZDzewbFN113C57/Vaz3bDADe5QMq8AqYlJOCngsUKDrDEUmnZRfF4k60/rS/unpAYxiFnpQIe5Amc/Mh17BLA1fn9G/QN/c7DcdgRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779877684; c=relaxed/simple;
	bh=qKoShBmc+gDmPE3GgeVHAj77czNTJiRsMf19IzVPZcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tIJ5zIMyy9uMAsIADWJZKpnp767rdxdimoazd6V4JXXn9g/F8XbIw3w4xNLVbOUnC/sH+XObFYMCZLWF5803JsU4agENFa3mWb7KA59LqpMBpqqJeQRZPispeUDbLdvL6gZWvSXl79O9zyVxlra2ZJcmHo5tSndIR2BqnPaf7GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4906869f0cbso31236575e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 03:28:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779877679; x=1780482479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GwGh4zf7B3gPFyimak7aCa+Z+XbFwJnS3td6dMioopc=;
        b=CKOOFerJ9SuKhyxTX78zHajHalW/CZ//oJCc4fs66R1JeROCzMCGW7PSQdIanTqG9p
         b8fS0g+3NvPeM+MunIk19jbNCmds2mXEOuMLSsz21vcnN6Ar++pdOXpgrqg1dukdJdMz
         YAm4SJ9d3B75rm13Tuy1KqarS+LP0flDsSbhJevc84BvUWVW33nA+gSthAqwpt0JAbF1
         wqYW5+WoNYqQ9mPOF8AYXzUx4LdkMQvBSNv/scffYbPlxxLBoAFvTTf+t2ZvAglMV70S
         rfdWYMnB0O+1yibupPzxwD2iw0zFvAR6siHtgWXgbzVBJ6MPEHk8OgOjivZc3abwqKnl
         Z6Cw==
X-Forwarded-Encrypted: i=1; AFNElJ9UhBwjgAThflJ5/OcAnrjDN7PtCVVTzNVGTd5TIJ4x6UF3S9yp1VXAYe0+UudT3jpJtsl1jC1cnMrckMxC@vger.kernel.org
X-Gm-Message-State: AOJu0YyZts/EXmwHCos3s0Oh2vT3I9t85fawlkZu1k9oVtJ8WFhpKq5/
	zxjSdWx6RIQRTw1zaZT/LrqZztjm7Hf/jsjVoW67gGRMbcDKIqUfJvi8
X-Gm-Gg: Acq92OHG2mb2ftD+9zEeu2jO7Z8VRKJQ9ls1KaZLwzYZxXNf3CXYU0GOGPmE72p7PnC
	j+Uzjs27SjR5mYbEbAvO8B33HZBchCPLgWfZNUFzZqswSW3wPpH8v2XBOs6VRnq0d8aP3o88fgU
	UyeL2v/uRQuuJ22BHqmfmU936NnvvoqeCsCVs54nSSsVZ+dQNujkARusUBgfLsJNOfien3pN20H
	zCasJKkqT8HpZ4xTM8Y8A5oIn+r50N81rIOr4iMWr1O8zRKlMEVkcAUd/HTG6DzoQDTtZUOUwh9
	GdgaoR3Pg/lZ1Svl+t8Yi+W0oUvQlcnn65Zyv6dhOL2y1wVQ6SGd1RqNMg30p6xYojHdPFEKQoU
	9YiW6OKlmxD+tP3vGFxqR1cxDswRGOi1lmm2s79Vffi4QsgWZrjRMGEbh2MCUxR4y+srlJiv3QG
	P+qPyG5BHjtVh8AjYdEGjYxHdICos6O2vPBGR1
X-Received: by 2002:a05:600c:6995:b0:490:482c:4384 with SMTP id 5b1f17b1804b1-490482c44ddmr371830255e9.24.1779877678707;
        Wed, 27 May 2026 03:27:58 -0700 (PDT)
Received: from gmail.com ([62.197.47.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4904561f682sm410082785e9.13.2026.05.27.03.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 03:27:58 -0700 (PDT)
Date: Wed, 27 May 2026 11:27:57 +0100
From: Breno Leitao <leitao@debian.org>
To: Farhad Alemi <farhad.alemi@berkeley.edu>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] configfs: slab-use-after-free in configfs_drop_dentry() on
 rmdir
Message-ID: <ahbG94EFLD5ntnYr@gmail.com>
References: <CA+0ovCjv-VYvn-4jUj3wDn+DuP9FSv-GL+yPAHbR=ZGKU0wmGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+0ovCjv-VYvn-4jUj3wDn+DuP9FSv-GL+yPAHbR=ZGKU0wmGg@mail.gmail.com>

On Tue, May 26, 2026 at 08:42:00PM +0000, Farhad Alemi wrote:
> Hello Andreas and the configfs team,
> 
> I am reporting a configfs use-after-free found by syzkaller.
> 
> Summary:
> A configfs config-item rmdir(2) can land in configfs_drop_dentry() with
> sd->s_dentry pointing at a dentry whose RCU grace period has not yet
> elapsed. The spin_lock(&dentry->d_lock) at fs/configfs/inode.c:209 then
> reads freed slab memory and KASAN reports a slab-use-after-free.

Thanks for the report. I was able to reproduce it on linus' upstream
tree. 

I've came up with the following fix, would you mind trying it, please?


commit d78c04736ef0ede76093c780a188560b6baed3c3
Author: Breno Leitao <leitao@debian.org>
Date:   Wed May 27 06:25:49 2026 -0400

    configfs: fix UAF in configfs_drop_dentry() after failed attribute lookup
    
    When configfs_lookup() matches an attribute it publishes the new dentry
    into sd->s_dentry (and dentry->d_fsdata) before calling
    configfs_create() to allocate the inode:
    
            dentry->d_fsdata = configfs_get(sd);
            sd->s_dentry = dentry;
            spin_unlock(&configfs_dirent_lock);
    
            inode = configfs_create(dentry, mode);
            if (IS_ERR(inode)) {
                    configfs_put(sd);
                    return ERR_CAST(inode);
            }
    
    If configfs_create() fails (e.g. new_inode() returns NULL under memory
    pressure or fault injection), the lookup returns an error and the
    caller dputs the now-negative dentry, which goes through
    __dentry_kill() and is freed via call_rcu().
    
    Because the dentry never gained an inode it does not go through the
    .d_iput op (configfs_d_iput), which is the only place that clears
    sd->s_dentry.  sd therefore keeps a stale pointer to the freed dentry.
    A subsequent rmdir of the parent item walks the parent's s_children
    list in detach_attrs() and configfs_drop_dentry() does
    spin_lock(&sd->s_dentry->d_lock) on freed memory:
    
      BUG: KASAN: slab-use-after-free in _raw_spin_lock+0xac/0x110
      Read of size 1 at addr ffff00012bacd028 by task repro/2440
       _raw_spin_lock+0xac/0x110
       configfs_drop_dentry+0x48/0x158 [configfs]
       detach_attrs.isra.0+0x18c/0x494 [configfs]
       configfs_rmdir+0x450/0x71c [configfs]
       vfs_rmdir+0x170/0x620
       ...
      Freed by task 0:
       __d_free+0x28/0x34
       rcu_do_batch+0x37c/0x1bd0
       ...
      Last potentially related work creation:
       call_rcu+0x34/0x68
       dentry_free+0xe8/0x3e0
       __dentry_kill+0x404/0x604
       dput+0x14/0x30
       lookup_open.isra.0+0x6ac/0xc00
       path_openat+0xd18/0x2588
    
    Fix this by tearing down the sd<->dentry linkage in the
    configfs_create() error path, under configfs_dirent_lock, mirroring
    what configfs_d_iput() would have done for a positive dentry.
    
    Reported-by: Farhad Alemi <farhad.alemi@berkeley.edu>
    Signed-off-by: Breno Leitao <leitao@debian.org>

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 362b6ff9b908..68d857dcb2d9 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -486,6 +486,22 @@ static struct dentry * configfs_lookup(struct inode *dir,
 
 			inode = configfs_create(dentry, mode);
 			if (IS_ERR(inode)) {
+				/*
+				 * configfs_create() failed (e.g. -ENOMEM
+				 * from new_inode()).  The dentry will be
+				 * dput()ed by the caller and freed via RCU;
+				 * because it never gained an inode,
+				 * configfs_d_iput() will not run to clear
+				 * sd->s_dentry.  Drop the linkage here so a
+				 * later detach_attrs() walking the parent's
+				 * s_children list does not dereference a
+				 * freed dentry in configfs_drop_dentry().
+				 */
+				spin_lock(&configfs_dirent_lock);
+				if (sd->s_dentry == dentry)
+					sd->s_dentry = NULL;
+				dentry->d_fsdata = NULL;
+				spin_unlock(&configfs_dirent_lock);
 				configfs_put(sd);
 				return ERR_CAST(inode);
 			}
