Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99218387378
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Aug 2026 04:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787891074; cv=none; b=US1MclNIVQIleP0u7SnQ8THWZRpR1kAVpKwPvDXIZ67JI4uzvJhpyadtHc8Vk80JfvF8mJA3vxSBKvszazEwBdC6hJY21mMzDeNKP7Bmz9vP/XAgz2y81BWuItaDJ9SVPfTTf1sePP1h2f+jTcq3uRi0L+rdXaxbYOXRmkFOR18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787891074; c=relaxed/simple;
	bh=0Mh1jC/QJ/MzZmhoBgK71nmVa9X9R/cosBlVbeWXYl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RvtTQez6JjeyZF+gXF0Kr7V02frP3nXBgG8+iE7eZJOt+Bms+VBNe9NtixLRxqgrqlYJm+KgKDXOvs5i2hLZDGse3JbKLI/VLVBzSovIWTmiM59XpEkUSuXQt5ySl2ZyQdWN5hQRHiMdf0Ud8cDYfWE5WFjQmF+WPxwdncj22c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=modMriXD; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="modMriXD"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84e04df8c46so862137b3a.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2026 21:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787891073; x=1788495873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ADeDExzR1gAOijbYmVBsEH6+zMDPtRZUnlmbbAacMz0=;
        b=modMriXDUWQDrgFAcz9ZmlyGsEOiS9wO9qVT3mEpuxQv1sLthB4YBuw+Jb6EcXi03L
         zyoQKLIBeAR7RldWE43C7mpgil+ThplPfGI90BULQtgcNSn+91TkRuaO3xp5doFP3wys
         uIhr7LXeP/kQ+aaUnJhzwSND9wSVxHwhIxBhMreOejPtDi4+sDiOCJlPULZ14fpTmKZ2
         wwhzOSMifBjZL0zdaZ7DLH3ojFGJyAUj7jPYzeVKvfn7Ejv2CHwCM47PRaQjg0+b0+tJ
         wQQeDzVcIw/ORtvz5TaiqpcHvZcwXGi0PR3GOhKZwWq8JGct9eSjWmGxvGDdwEbj0W3v
         N5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787891073; x=1788495873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ADeDExzR1gAOijbYmVBsEH6+zMDPtRZUnlmbbAacMz0=;
        b=JDR4lWARdb2mdGJDAYubOg30pOzYIC6qDSVDqPMD892ZHEoH4ldutz8r7a+mMTNpP8
         yMbq8c9O1KDnFAet4QrzNwT3l6Sb6FrSgz5Hz1WT6ZXwD6aYsNiK4syGzXagb+a2ZCkh
         GyNXWA0Vj0tcK6MT+1sHZLP2/FfygIzmxn/9yDyqfsoNQt/C0UKCc+RApooz1U/9f7WY
         cgvHRVESgSSGC5WmP5JzUP+V1eG/yn82gby9KnCJZ9QU+M8EU1w/71ePuVX/60TLeMh7
         JDl6Q7nDqVWL2XEx4SsAazpIg9W/dIjg1E29YsNFjzrDub8Nu07+4OhIeQYUQK5O80QS
         iuGw==
X-Forwarded-Encrypted: i=1; AHgh+RrjqwSJIiG0q9TChO+UxjjAvoL50RnLli7Cyd4GuggeGGrO3k+O65QBORmpW7RqffL3C6Zw6VSHdUOAl/H6@vger.kernel.org
X-Gm-Message-State: AFuF++mNN0c7jCfLgoqC+J+LxeHiCZPLAC9cf8NSdbFD1I5fLp7VwPhB
	8tbubJLdFv1F7U25QrifOEKTJ3RCdVaJ8vzEoYeBNQqY90dFRP5FkgW4pbP+uw==
X-Gm-Gg: AR+sD13Kmhl9oPb+ih8JMHb/ROaxfl7ldDTOSQ3t76yI8smddDxAxi2L/EgvYrw6YRs
	J1elBR9cd+sTzSEypKp11yxduor1eAL+kimP0w8OrG1jlivR7qeeoWJuQ84sjuccvSLorQqUufC
	DnbIGuPFH44M7oVdeBer1IfrQCxJr8a34iVkZGb0ZSfyzidfh5n9dZ7JpaM1EmWhzloAYkqsok5
	WhsfSM3Puwsa7QaxWAWjPWi5bkqpzqBB8sMyLfX1OPebHOT5g6MTU/lrOxD6C0xohpHcXzy30rV
	2U4av7A5VuqYl8eKj9gGTcGR3xoa+oRzV17DYVER72jlAzICsD6WqBwY2EFvtPqQvPsz5MfRHGZ
	9ZFOnosrNhdwxKYqhhSJWFCxm4O/z4jA4aFdinpcPdUlXIDQemjOzUl0v3/gPirMy1HHE+Qp/c6
	f1RpGuQ3uM2HsxDeeqXxNBMqSFrj4a3UIX3GRZb+/+WEZLMDACc0XnCI5uMAJDuH+3IhW13iAs
X-Received: by 2002:a05:6a00:909e:b0:848:467d:293b with SMTP id d2e1a72fcca58-85629f0a1f8mr9011536b3a.11.1787891072818;
        Thu, 27 Aug 2026 21:24:32 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8569f49ed7asm190642b3a.8.2026.08.27.21.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 21:24:32 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [BUG] fanotify: destroy/add race leaves a mark on a detached connector
Date: Fri, 28 Aug 2026 13:24:19 +0900
Message-ID: <20260828042421.964822-1-4ncienth@gmail.com>
In-Reply-To: <yjfqzckumtd32dgqidi5sndvth2t67mjwah4kt4jiahlx2a5uf@if55sinfv5o7>
References: <20260827045007.3831259-1-4ncienth@gmail.com> <yjfqzckumtd32dgqidi5sndvth2t67mjwah4kt4jiahlx2a5uf@if55sinfv5o7>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Honza,

You are right that an fd-held dentry cannot satisfy the count == 1 check. I
was imprecise in the report: the fd and the final unlink refer to two
different hard-link dentries for the same inode.

The setup is:

  1. create A/x and link it as B/y;
  2. open B/y, add the old-group inode mark through that fd, then unlink
     B/y, leaving i_nlink == 1 while the fd retains the B/y dentry;
  3. race these two calls:

       unlink("A/x")

       fanotify_mark(racer_group, FAN_MARK_ADD, FAN_MODIFY,
                     victim_fd, NULL)

     where victim_fd still refers to the already unlinked B/y dentry.

So the A/x dentry checked by d_delete() is not held by the fd and can have
d_lockref.count == 1. Its unlink drops the inode's last link and reaches
dentry_unlink_inode() -> fsnotify_inoderemove(). At the same time,
fanotify_find_path() gets the same inode through the fd-held B/y dentry and
adds the racer mark.

Your suspicion matches this topology: __fsnotify_inode_delete() from
fsnotify_inoderemove() is running while the inode is still live and reachable
through the other, fd-held dentry. Deferring mark cleanup until
__destroy_inode() would avoid this particular add-versus-cleanup race. I have
not audited the broader consequences of that change yet.

I can send the exact reproducer privately if that would be useful.

Thanks,
Daehyeon
